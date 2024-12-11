//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@testable import PillarboxCoreBusiness

import PillarboxCircumspect
import XCTest

final class DataProviderTests: XCTestCase {
    func testMediaComposition() {
        var data = """
            {
              "chapterUrn": "urn:swi:video:73107474",
              "chapterList": [
                {
                  "id": "73107474",
                  "mediaType": "VIDEO",
                  "vendor": "SWI",
                  "urn": "urn:swi:video:73107474",
                  "title": "Video project: e74da7a8-d81e-4177-8721-a030b5d9b715 with language: GER",
                  "imageUrl": "https://cdn.dev.swi-services.ch/video-delivery/images/e74da7a8-d81e-4177-8721-a030b5d9b715/XSgTrR1sh85MQNmbWDTxNkoxrgSFuwB9/1x1",
                  "type": "EPISODE",
                  "date": "2024-03-06T15:41:40Z",
                  "subtitleList": [],
                  "fullLengthMarkIn": 0,
                  "fullLengthMarkOut": 135720,
                  "resourceList": [
                    {
                      "url": "https://cdn.dev.swi-services.ch/video-projects/e74da7a8-d81e-4177-8721-a030b5d9b715/localised-videos/GER/renditions/GER_20240921T164455_1080x1080.m3u8?versionId=KWDMo8IxETaHLy2ZVEST.B7V_x1aUzwk",
                      "quality": "HD",
                      "protocol": "HTTP",
                      "encoding": "H264",
                      "presentation": "DEFAULT",
                      "streaming": "HLS",
                      "dvr": false,
                      "live": false,
                      "audioCodec": "UNKNOWN",
                      "videoCodec": "H264",
                      "tokenType": "NONE",
                      "mimeType": "application/vnd.apple.mpegurl",
                      "analyticsData": {
                        "srg_mqual": "HD",
                        "srg_mpres": "DEFAULT"
                      },
                      "analyticsMetadata": {
                        "media_streaming_quality": "HD",
                        "media_url": "https://cdn.dev.swi-services.ch/video-projects/e74da7a8-d81e-4177-8721-a030b5d9b715/localised-videos/GER/renditions/GER.mp4?versionId=vBkXWtH8Mc6E3U7GRfPcvzo6LDLdxkJ2",
                        "media_special_format": "DEFAULT"
                      }
                    }
                  ],
                  "aspectRatio": "1:1",
                  "analyticsData": {
                    "ns_st_ep": "SWICMS-149",
                    "ns_st_ci": "73107474",
                    "ns_st_el": "135720",
                    "ns_st_cl": "135720",
                    "ns_st_sl": "135720",
                    "srg_c1": "eng",
                    "srg_c2": "swissinfo.ch",
                    "ns_st_ct": "vc11",
                    "ns_st_ty": "Video",
                    "srg_mgeobl": "false",
                    "ns_st_tp": "1",
                    "ns_st_cn": "1",
                    "ns_st_pn": "1",
                    "ns_st_cdm": "eo",
                    "ns_st_cmt": "ec"
                  },
                  "analyticsMetadata": {
                    "media_segment": "SWICMS-149",
                    "media_segment_id": "73107474",
                    "media_episode_length": "135",
                    "media_segment_length": "135",
                    "media_duration_category": "short",
                    "media_joker1": "eng",
                    "media_language": "eng",
                    "media_joker2": "swissinfo.ch",
                    "media_urn": "urn:swi:video:73107474",
                    "media_content_group": "Culture",
                    "media_type": "Video",
                    "media_number_of_segment_selected": "1",
                    "media_number_of_segments_total": "1",
                    "media_is_geoblocked": "false",
                    "media_is_web_only": "true",
                    "media_production_source": "produced.for.web"
                  }
                }
              ],
              "analyticsData": {
                "ns_st_tdt": "*null",
                "ns_st_tm": "*null",
                "ns_st_tep": "*null",
                "ns_st_en": "*null",
                "ns_st_ge": "*null",
                "ns_st_ia": "*null",
                "ns_st_li": "0",
                "ns_st_stc": "0870",
                "ns_st_st": "SWI",
                "srg_unit": "SWI",
                "ns_st_tpr": "6",
                "ns_st_ce": "1",
                "srg_pr_id": "73107474",
                "srg_plid": "2",
                "ns_st_pl": "Culture",
                "ns_st_pr": "Culture on 06.03.2024",
                "ns_st_dt": "2024-03-06",
                "ns_st_ddt": "2024-03-06"
              },
              "analyticsMetadata": {
                "media_episode_id": "73107474",
                "media_show_id": "2",
                "media_show": "Culture",
                "media_episode": "Culture on 06.03.2024",
                "media_thumbnail": "https://cdn.dev.swi-services.ch/video-delivery/images/e74da7a8-d81e-4177-8721-a030b5d9b715/XSgTrR1sh85MQNmbWDTxNkoxrgSFuwB9/1x1",
                "media_publication_date": "2024-03-06",
                "media_publication_time": "03-41-40",
                "media_publication_datetime": "2024-03-06T15:41:40Z",
                "media_since_publication_d": "280",
                "media_since_publication_h": "6722",
                "media_is_livestream": "false",
                "media_full_length": "full",
                "media_enterprise_units": "SWI"
              }
            }
            """

        XCTAssertNoThrow(try MediaCompositionDataProvider.decoder().decode(MediaComposition.self, from: data.data(using: .utf8)!))
    }

    func testExistingMediaMetadata() {
        expectSuccess(
            from: UrnDataProvider().mediaCompositionPublisher(forUrn: "urn:rts:video:6820736")
        )
    }

    func testNonExistingMediaMetadata() {
        expectFailure(
            DataError.http(withStatusCode: 404),
            from: UrnDataProvider().mediaCompositionPublisher(forUrn: "urn:rts:video:unknown")
        )
    }
}
