Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D7C433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 10:29:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CB061166
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 10:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CB061166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77011839E7;
	Thu,  8 Apr 2021 10:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3Zoe1siSMos; Thu,  8 Apr 2021 10:29:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CE40839E4;
	Thu,  8 Apr 2021 10:29:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37F28C000C;
	Thu,  8 Apr 2021 10:29:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F347EC000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 10:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA0D960D8C
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 10:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RZDd27cXR69K for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 10:29:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::617])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A941A6078D
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 10:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld4XaObvM/XeklxvlfIOuk8jn+r2rXf+FEBE2CBIn9enXMEFXMEmF5BI4TAh1xhnD5btrdil4Ddzt+urR4K4BfrgkVG7M/YbS9ib7KfGxlNlDGk8nxvCSVLXT/a8raZNaD5DUUiEDHKMaZoi/RvbAhT1bSNPK78VcMeDcw5QMiu6MajW1EmUtS86Y2z/MKbT4Ejt9cHBanvNJXF68WfT90rjI2V8Ui8HBZ858ef07oYVUTbH0o0y+eubQZyHo35hm/ug8kaTzlGb2Bwe6Laii3i1CB+nOPsnzfukGsEZVnvQijVr2ZzvWImtGKC9eInmhb8BCsGAF6bZuvZsRdKQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SKd8EUE18AcTS4mxPGsU67BMJZRgq4ZgZBOLtsgbnA=;
 b=K4I6KCmuMd5dc5JItQon76lw41Tf0bXvbcwZUCdgqNnYe9X5RGsssYgDkFiGHl/72IXaamW2Kl2/4diTRB1mBGLhtlGhf34VOKb6Ynk0/4PEh7HP1bLt4tcDeLESI29AVyKAeuGPEejn/D5pnn3FEV9AKQDPdsZZ/C8IjsDjm/+XZAODu9fL5vP60xGzwB9lC8b13DwbEGDmeX7Aam9Gc/BTBTy/0sE9JxTKTBGMyM1sj6gCiQMhqJz5vtfK/YXneKzjehuc0kYp1YjATEAQUb1mKb219nSX+K9DpszCd/n+tQsZ5IwfWxJeaYA72Sy7+m1mbFiXn0Rv8hJpjFoIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SKd8EUE18AcTS4mxPGsU67BMJZRgq4ZgZBOLtsgbnA=;
 b=H305pgk82RKTuR36a4ZFlmZdSl/DdrinQUV/Ie8Mrtk30HrRhL8T+biz5AXYN2eCZiHFgZuJTvDJDjj3zVcLp7EoQJ4P1sqmQlcOp6IRKCoFp0k95cLRwYSoCRtzzDgBzefz5GNRLrINPTeKWsZ5vJo1T4qJm+M8aKD5rWQQZeI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4247.namprd05.prod.outlook.com (2603:10b6:a02:fd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.11; Thu, 8 Apr
 2021 10:29:25 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::3160:ae0e:f94e:26b]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::3160:ae0e:f94e:26b%7]) with mapi id 15.20.4020.014; Thu, 8 Apr 2021
 10:29:25 +0000
From: Nadav Amit <namit@vmware.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Thread-Topic: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Thread-Index: AQHXK5TyxLWX6NQ3A0yiL6P30rBhzaqpV8oAgADf4gCAADU/gA==
Date: Thu, 8 Apr 2021 10:29:25 +0000
Message-ID: <80A4A5F2-5D8C-4F8D-BF7B-CFFF4F770F57@vmware.com>
References: <20210323210619.513069-1-namit@vmware.com>
 <YG2C42UdIEsWex2L@8bytes.org>
 <71C74038-943D-4041-B6FF-09A8C40CA204@vmware.com>
 <YG6uWFAS6GCWJPGO@8bytes.org>
In-Reply-To: <YG6uWFAS6GCWJPGO@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e89c6dbe-2ef7-4c83-a893-08d8fa792eb3
x-ms-traffictypediagnostic: BYAPR05MB4247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB42477321CE6BAB6507A0F9B2D0749@BYAPR05MB4247.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9KvpIwkaZ6/BZhOUfMalMJWs7sE9AZs+KdclcPIZev+6xWWMpGaKy1T4iqV4v5Ub8GXmPM+BLx/XaG7WkDl/ZDm6sJ3ry2ZVa89RRsbL2mSW8nkOUDhoE+ELzQUpawiHNqW4mbExABpKkg4rl64MIk8ernaBKWWPv3Wrl3Cu+XFVjiKfcwV0JTAublCbm+h6lpcrrvKqON0ixIKTlelH1EXD0/DVUhQhvNuNcbKp4LE4AS0YNymQ1Ua187ybybxV3TN3OXOFEopYG/swjN7Rtq0ZHlf5PwQazlsfKcp79mC0Z8Jrbh7pyG/ZpZ0ovcuh08xh6uBN4cd49fMscvYA53PZK7yrtZ/ogIR6CKH4ZHIaGjbEwoGVN82oZlG4NqiIjVQensT5Hka+l87hUh1zvyhKfIXWAoazKPhbRamfMC6+4yNrHAdklireMFolv5nqw390gElEDxxVLZXfOrVtk7srPEJ6Hvzc1uNAjNBTs/ZsOp2zhIOBYYXwtYtuhcZMjlaHRrhtVK8Rmxs8CfaOsUbpiFn4m5IZtX+P1UcDyc3PI5Vm0ofETGn+xMOZyUfG4uO785zf3b1E0UP2FbGJWfMJedZj0IL9KbgL+TzYPp+J9/LDkWZGU0nN4Lr5LcYPpgLmOsbG17DaKDAvfQJDrGB6jbEPDL9fDHS4yzd7qkxjiPHxpo6sTQiu0+3eWZG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB4776.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(71200400001)(66946007)(26005)(4326008)(5660300002)(316002)(36756003)(66446008)(66476007)(66556008)(8676002)(64756008)(2616005)(54906003)(76116006)(6512007)(186003)(6506007)(6916009)(86362001)(38100700001)(83380400001)(478600001)(53546011)(2906002)(6486002)(8936002)(33656002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?SDEvckhteUxTdFlxUkR2c3RnK3VmY2dwVm0xN1NuUlNwY2NTUlpjZ21ZdGxG?=
 =?utf-8?B?MSs5MmZvazRpbDBIZjdOMDFCR2ZzNzNVK1Q2R2ZPM0tkb0s3Sks0SGJJbndN?=
 =?utf-8?B?ejdnSFk2NDM1V2RDc0E4UVYvYXEyUlB2RFo1eTZZdXZFa1IwNjY0bXJZSVRN?=
 =?utf-8?B?UXdyMlRpQnpjTXI0aGM2QUdudmRkNTc1YzIvaFJkZE1senRrcGlpdlBmMThE?=
 =?utf-8?B?bjJwd3hZTjR2dHMrZk5PQU1pckh3NFByeGlsd0pFeEg3aGF2NEVGN2NTRlNq?=
 =?utf-8?B?V3l3RitKYkR0Y2dRUTM3WTlTTEhHSy9hTDIwK25TY1gxVkxqY1NYQUtWTTZS?=
 =?utf-8?B?bFVhNzdCQ1pZbWoyb2ttNUtkNDBoYU5XTGp6Sk5TelF2UkpwN3FWdzJDcXkz?=
 =?utf-8?B?dlN2aUJZS05ud3NCTFVXcDlCSTlVMEVyOUFCMXJPU20zVlJFdlNwTy9OdEZj?=
 =?utf-8?B?SldHSlBUTFROY1RTS0ZxcnF0MFZaTWdsRDdRVjNtSSt6cnpkTmxzakEvZUVO?=
 =?utf-8?B?b21uSVZTenZRSzBTSkI0R1EvYVZaMmp6Z0J4RzBkMEVVV2k1VXJYSFZsZlZM?=
 =?utf-8?B?bXJuV2NDN1ExeExlNnZKOVlXT0xmYXo1OERSOHhLTDlWQkZCcDVqTHkrNXB5?=
 =?utf-8?B?bGFqMGJxTHo4ejlCM3hqY2Q3WVlLTDNySDBuS1B5Z1hFOU43OXZ3SDVGSzZD?=
 =?utf-8?B?dFhQaUM3Z1N5SENqQ0c2Tm9PODNFUzNpZXhGWlNQc2Nva2tFNXV3czRsMTFI?=
 =?utf-8?B?OFRhaHJnM3VsNXRmZEkzd2hoeUt6T3UrcVkwZFgxUGxJYm5vUlJDdUJKVkRs?=
 =?utf-8?B?NGVhUEpQSHdrN1c4UlB0RGlzTVRsZVJoNlp6MEVpVU90ZFZXOWEvZ1ZBRVRQ?=
 =?utf-8?B?OXZTd1VyN0d4MCsvNHhnU2ljVWxCeVRiWjhzcU1SYlo2eGUzSzlXRTdPVloz?=
 =?utf-8?B?eU13RzBBcXQzYS94NWtKVlVmcHN1NjVDeVloWHNSNnRjUEYrMTZUOFhydFJ1?=
 =?utf-8?B?THdybXBxSFNWbGxVRGRuVkpyTEJVcmVEVFFMcTFMNm5semova0NxSHFyMjFR?=
 =?utf-8?B?T3VZcnV5Zk5HczFmbkhCRWs2QWUreHpRRkU1TEtFRmJ5NVlicVpNQ0RxUk9C?=
 =?utf-8?B?UW91Z3VHOUdMTGN6c3kydWJrVzVRN1ppNldoa2MvbXFUdktiU0JJZ0MyeUl1?=
 =?utf-8?B?MG5la0RScm1wUm5ZRHpMdWJxczhBalcxcXFYclFDSXhFa0NRcUtkOU1KcEZj?=
 =?utf-8?B?NVdqUVVSRWJpaFFlOXZzVWxJY0VHVFc4S2JiY3RMbURWeWJRdGFRbTdqU0M4?=
 =?utf-8?B?K0V5T3puUCtxV2VJRS9jRlFIQ3ZMckhGZERmRk9mazV0SjhzOHZ4U3poaWh1?=
 =?utf-8?B?N0xxdDBIQTYxLzhrSm5pQ1MzU1dld0V0MkM1c1NEcWd1VEQzZ3hUU0FQU3Vu?=
 =?utf-8?B?Z1Q1TVlBMTJDMTNPT3JjSElRTmxhcW9pYW1JUFZLVytnc0RwOHlIZ1h4RmdW?=
 =?utf-8?B?djJFLzlvS3JOOWJVK3NHNDJKVklnRkcxc2VyYmlGMFdPNGpnNFNyb1RyeW1Z?=
 =?utf-8?B?ZHIwb2pJMmQ3U0Q0d0x4SFlnUi9BemFDUEx6L1BlR0UrOGgrZzlCRzIrMGRZ?=
 =?utf-8?B?a0NROUN0SjFvZWI0dGQ3ZkhYOGxYVHIrV3phZTJGekFEMTFyRFRUdXF6ajNs?=
 =?utf-8?B?czFCYkt6b2pLL053RjZkNjNPWE5VQm1LWGFmN1orLzkwN1JGVlRQQU9QMlVl?=
 =?utf-8?Q?gG6efZOQ9yVsehkYQ4dobnDVKzuCpVPuTuuFput?=
Content-ID: <D6754898E8D7C241BDAAA444488D994C@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89c6dbe-2ef7-4c83-a893-08d8fa792eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 10:29:25.3178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8P8ZGztE2Rd9+j54kNHYyUnLNmREfUjDUvACozMEJz23bHGjlF/SUvJvc4hOPajC207Ng3j6PzqL+ciilkwTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4247
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

DQo+IE9uIEFwciA4LCAyMDIxLCBhdCAxMjoxOCBBTSwgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRl
cy5vcmc+IHdyb3RlOg0KPiANCj4gSGkgTmFkYXYsDQo+IA0KPiBPbiBXZWQsIEFwciAwNywgMjAy
MSBhdCAwNTo1NzozMVBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gSSB0ZXN0ZWQgaXQg
b24gcmVhbCBiYXJlLW1ldGFsIGhhcmR3YXJlLiBJIHJhbiBzb21lIGJhc2ljIEkvTyB3b3JrbG9h
ZHMNCj4+IHdpdGggdGhlIElPTU1VIGVuYWJsZWQsIGNoZWNrZXJzIGVuYWJsZWQvZGlzYWJsZWQs
IGFuZCBzbyBvbi4NCj4+IA0KPj4gSG93ZXZlciwgSSBvbmx5IHRlc3RlZCB0aGUgSU9NTVUtZmx1
c2hlcyBhbmQgSSBkaWQgbm90IHRlc3QgdGhhdCB0aGUNCj4+IGRldmljZS1JT1RMQiBmbHVzaCB3
b3JrLCBzaW5jZSBJIGRpZCBub3QgaGF2ZSB0aGUgaGFyZHdhcmUgZm9yIHRoYXQuDQo+PiANCj4+
IElmIHlvdSBjYW4gcmVmZXIgbWUgdG8gdGhlIG9sZCBwYXRjaGVzLCBJIHdpbGwgaGF2ZSBhIGxv
b2sgYW5kIHNlZQ0KPj4gd2hldGhlciBJIGNhbiBzZWUgYSBkaWZmZXJlbmNlIGluIHRoZSBsb2dp
YyBvciB0ZXN0IHRoZW0uIElmIHlvdSB3YW50DQo+PiBtZSB0byBydW4gZGlmZmVyZW50IHRlc3Rz
IC0gbGV0IG1lIGtub3cuIElmIHlvdSB3YW50IG1lIHRvIHJlbW92ZQ0KPj4gdGhlIGRldmljZS1J
T1RMQiBpbnZhbGlkYXRpb25zIGxvZ2ljIC0gdGhhdCBpcyBhbHNvIGZpbmUgd2l0aCBtZS4NCj4g
DQo+IEhlcmUgaXMgdGhlIHBhdGNoLXNldCwgaXQgaXMgZnJvbSAyMDEwIGFuZCBhZ2FpbnN0IGEg
dmVyeSBvbGQgdmVyc2lvbiBvZg0KPiB0aGUgQU1EIElPTU1VIGRyaXZlcjoNCg0KVGhhbmtzLiBJ
IGxvb2tlZCBhdCB5b3VyIGNvZGUgYW5kIEkgc2VlIGEgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZQ0K
aW1wbGVtZW50YXRpb25zLg0KDQpBcyBmYXIgYXMgSSB1bmRlcnN0YW5kLCBwYWdlcyBhcmUgYWx3
YXlzIGFzc3VtZWQgdG8gYmUgYWxpZ25lZCB0byB0aGVpcg0Kb3duIHNpemVzLiBJIHRoZXJlZm9y
ZSBhc3N1bWUgdGhhdCBmbHVzaGVzIHNob3VsZCByZWdhcmQgdGhlIGxvd2VyIGJpdHMNCmFzIGEg
4oCcbWFza+KAnSBhbmQgbm90IGp1c3QgYXMgZW5jb2Rpbmcgb2YgdGhlIHNpemUuDQoNCkluIHRo
ZSB2ZXJzaW9uIHRoYXQgeW91IHJlZmVycmVkIG1lIHRvLCBpb21tdV91cGRhdGVfZG9tYWluX3Rs
YigpIG9ubHkNCnJlZ2FyZHMgdGhlIHNpemUgb2YgdGhlIHJlZ2lvbiB0byBiZSBmbHVzaGVkIGFu
ZCBkaXNyZWdhcmRzIHRoZQ0KYWxpZ25tZW50Og0KDQorCW9yZGVyICAgPSBnZXRfb3JkZXIoZG9t
YWluLT5mbHVzaC5lbmQgLSBkb21haW4tPmZsdXNoLnN0YXJ0KTsNCisJbWFzayAgICA9ICgweDEw
MDBVTEwgPDwgb3JkZXIpIC0gMTsNCisJYWRkcmVzcyA9ICgoZG9tYWluLT5mbHVzaC5zdGFydCAm
IH5tYXNrKSB8IChtYXNrID4+IDEpKSAmIH4weGZmZlVMTDsNCg0KDQpJZiB5b3UgbmVlZCB0byBm
bHVzaCBmb3IgaW5zdGFuY2UgdGhlIHJlZ2lvbiBiZXR3ZWVuIDB4MTAwMC0weDUwMDAsIHRoaXMN
CnZlcnNpb24gd291bGQgdXNlIHRoZSBhZGRyZXNzfG1hc2sgb2YgMHgxMDAwICgxNktCIHBhZ2Up
LiBUaGUgdmVyc2lvbiBJDQpzZW50IHJlZ2FyZHMgdGhlIGFsaWdubWVudCwgYW5kIHNpbmNlIHRo
ZSByYW5nZSBpcyBub3QgYWxpZ25lZCB3b3VsZCB1c2UNCmFkZHJlc3N8bWFzayBvZiAweDMwMDAg
KDMyS0IgcGFnZSkuDQoNCklJVUMsIElPVkEgYWxsb2NhdGlvbnMgdG9kYXkgYXJlIGFsaWduZWQg
aW4gc3VjaCB3YXksIGJ1dCBhdCBsZWFzdCBpbg0KdGhlIHBhc3QgKGxvb2tpbmcgb24gMy4xOSBm
b3IgdGhlIG1hdHRlciksIGl0IHdhcyBub3QgbGlrZSBhbHdheXMgbGlrZQ0KdGhhdCwgd2hpY2gg
Y2FuIGV4cGxhaW4gdGhlIHByb2JsZW1zLg0KDQpUaG91Z2h0cz8KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
