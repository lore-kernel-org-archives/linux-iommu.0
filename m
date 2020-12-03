Return-Path: <SRS0=qXOr=FH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC1BC4361A
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 22:21:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35EF2223E
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 22:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35EF2223E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04ED587853;
	Thu,  3 Dec 2020 22:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wG6AC7_9BEo6; Thu,  3 Dec 2020 22:21:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ACEF387781;
	Thu,  3 Dec 2020 22:21:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EE56C0FA8;
	Thu,  3 Dec 2020 22:21:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 051E1C0FA7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 22:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DF48D204A8
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 22:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UeYy2DoV7ZNP for <iommu@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 22:21:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
 by silver.osuosl.org (Postfix) with ESMTPS id 3C5A720450
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 22:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Re1FIj/zXOO2A9SvmfCEyU1bXUHnZU9ljVccnvc2Z0WtezbOZ5Q8nmbtzRJhCw5SP2EYD8L7matIAhKgZWFWC7R/9PEajAeyk4JkB+t8pj2uDdEZSY0jkewkFD/Dse/5j9FllHgQ/NwNYCX2EM7tqMsKMJqw/gSHeKRutBz7abV1ErlNe36IUNKYE2yOcqijI1UngYNGR4zhomdf5yDgEIA7BPsOjp53Cx6Q9COhXCBtPiVyI3K2vgnZvzaFWeCvzlLrfpL7E4epKTpJRWfw7L/Un/TH4ETBVGdBXmX7IU+8ZDu++rJ3mI/slt9isPd2KAG/D2nRF3NRinIcfqrw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE54hZ1porZ+GAxFgxarv/nBcPqblglPvSbGbxC8gfY=;
 b=cBd3o2XN+MemZI2aFn2zOGktULbATe3csUmRUQfaJ46/7tQFdydcejpXRlqVa6R1rgZawSHQSbCV4AY7Zc9CvLG6XyNt0CR1cuxS4EC+Rl8UeQeDjX2jmNb9lwaIggcVAKDUigJSKtOQjjC/LyxJkeJJn8wVTfXh8bz91EOa+Y8L0L56deWjEGNy9atJ4eq9UZvMDC9+0Wo3C+Ao55Ez2DfSDBnmNjHBIkTAvzfQ/j3bXNenslJars4/Yx2OQ5dg0XXFnP1MPWwFW0jOs/jZuia7n19BL/RYYcYAcEiPASYQ757LPkDuIg8yvGQxpdCaIfmJSLdG1H4SSwg7yPCD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE54hZ1porZ+GAxFgxarv/nBcPqblglPvSbGbxC8gfY=;
 b=RAlm/jpm+YKXgU30l/0nosA+nuOvEmoJOAHqH8OtJMJRTORJxwAjeS2THfA+ilICtv8vi4ycMUZx3iXJcyib1AyRpECHxdgTO86c7bZHFtqKm4wePA0XzUtVN6bReFbLfuKlSOxHxz1Lm93vEh+Uvjsb9mEM+QBTlmHxfffD/zU=
Received: from MW2PR2101MB1130.namprd21.prod.outlook.com (2603:10b6:302:4::15)
 by MW2PR2101MB0969.namprd21.prod.outlook.com (2603:10b6:302:4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.6; Thu, 3 Dec
 2020 22:21:43 +0000
Received: from MW2PR2101MB1130.namprd21.prod.outlook.com
 ([fe80::2c5a:e38c:d8b6:3a4]) by MW2PR2101MB1130.namprd21.prod.outlook.com
 ([fe80::2c5a:e38c:d8b6:3a4%6]) with mapi id 15.20.3654.008; Thu, 3 Dec 2020
 22:21:43 +0000
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [EXTERNAL] Re: Question regarding VIOT proposal
Thread-Topic: [EXTERNAL] Re: Question regarding VIOT proposal
Thread-Index: AdazCIQyX41ICCm/R+W5gs79WO29YQAcViOAABFY4qAAIWNEgAVfUMIA
Date: Thu, 3 Dec 2020 22:21:43 +0000
Message-ID: <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201105134503.GA950007@myrica>
 <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201106135745.GB974750@myrica>
In-Reply-To: <20201106135745.GB974750@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-03T22:21:40Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9591998f-5e54-4dae-a11a-66d00ed68d27;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2001:4898:80e8:9:686d:957c:5712:47b3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9909306f-47c1-40a9-11eb-08d897d9d0a2
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB096974F96338930ABAF1CE4980F20@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VW1MLiiV6gGRrFnaY9AEVMaECwoiTAw3mLKOAk5qlFDGNJ6rVK32Yjnt/A+4qfMtLkSP7z6pARSx8Oinxy8EqhWYslfZXARcXT0t19jhbHBLlbwjMdn/iGAlIGvHKdf1ekQ2eoh2ROsDqWCAh2r8WfuLPH/XheOV0gHt39hqKr2g8XejbtQU5/G5H4ZnqN9VCf+STFGGI/GkmXZjFrFozCDSIhHYc1JOWykV4YdwkRKbit3bpI1DuhaMv36qdg0y7izyUXPt/HilQcIqhh03wspQSUenZ/mWpxYFgK4z4ES5Vr81gRRLFe2AWO/dcC0siPPZeV7jpwmoC+wECC8MnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR2101MB1130.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(66556008)(5660300002)(64756008)(2906002)(8936002)(66446008)(8990500004)(186003)(8676002)(82950400001)(10290500003)(82960400001)(4326008)(6506007)(86362001)(9686003)(66946007)(76116006)(66476007)(55016002)(478600001)(316002)(83380400001)(7696005)(53546011)(71200400001)(52536014)(33656002)(54906003)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?M0pOUGJpK2RVNHVjUmhZSHBBRmNnZXJiektvSitqb3NQaUZYNE84OTNLMThT?=
 =?utf-8?B?aEVkeGFuNGE0KzllQS92dUFlMmxDekJzRWNMV0dBREg5SThUWklqVU9lU1lv?=
 =?utf-8?B?dGhHM0hvRG1IRjJScDA0Qy9TVW1KK0RrVVpSOWx4cjR1Nkl1QSsyaG5LTVhO?=
 =?utf-8?B?YVY4S0pFaDBIVTlsaHd3SWVaMm50OUk4ZkFRZEVnMmRlRVA4bTB0OGUybGpI?=
 =?utf-8?B?MGptTk5wRmVKc3lNUWhWSVo2LzhKY2psMmRvWFNETXdHMk5VOXB6ZVpqU1E1?=
 =?utf-8?B?YnRJSnhwRVpEaExhdVZGR3l4SmQrenQ5cTIyN2xubllHcjF5V1NXbFNpeHVo?=
 =?utf-8?B?dDloRFU4OW8rTGhCS3l2NDFuL3o1dHZQKzRGWGVzOW4zY3pHWHFjQUpZamRO?=
 =?utf-8?B?aWJ5UXNIUzExc3VSWmthczB4dkt3SGtqdzZaTkFjdEpZbkVVcW9PQ1BpVnhn?=
 =?utf-8?B?NS90UzFmUktJM0pja3I4R1B3U0w0dHpxMGY5dXlFVTZENkFWWnNzc2hBRWVL?=
 =?utf-8?B?N1hnWC9MaTNLT2NvRm5WMjIyeWRhLy9wcm1BQlZGdkJ3NUZOS1VtN051RTRI?=
 =?utf-8?B?RStGenNHcm9aMFQvSzBKdyt4bVh1QXBGWjNicnpNdWI0RHBmWUxIMDc1K25w?=
 =?utf-8?B?NUlsbCtiWTZVMTN5N3hkbGlGYXV5WWppR09OQkdaSDZnM2s5bzdvSk93ak5l?=
 =?utf-8?B?SS95ajNZcnFsK3NVb0tscC9jWFNpQmZISE1FY09JZnVTbFJqdG00R1FQMEpU?=
 =?utf-8?B?Zm1KbXpyNXdwU0laSjJDZEdJNVo4VHpPbHFEOUN0Q0xqSGduRFRxZ216RWZt?=
 =?utf-8?B?WjF0SUc5T2czaVVEY3NHTE53T2ZiVWFNL2NBTktBOWtYSHRUZGRwQlhsWXho?=
 =?utf-8?B?RlFsTDhjMm1qWFZkT1RSRC9vRWQ5S3lod0xSMkpVZ2hWQ055NEdWaTU3Zkta?=
 =?utf-8?B?NjBDMXpxWkVlZTBIWDlYYWRLRGtDZ3QrYkNJenRLdXJSWk1vRk1sUDg1djFT?=
 =?utf-8?B?M1JJQlBiSU1XcFF0cXp6RGgweDFIQWwzdWc0SzlDN3d2dE9ONWtXN3paMDl4?=
 =?utf-8?B?c3dmK09WREU2L0tINkpLVXZMQzFmNy84cjNISStoaldrWUE2UlkvbTV4Mm1Y?=
 =?utf-8?B?V1RUY242cmQ5bjQ0b2pZQ282aHZ6WjRjajRNY002ZnZIUThHczRsWHhlZUIy?=
 =?utf-8?B?WTR6eUovWU9aUmpuUVp2WkxIc0RQVWY1SEZNK1gzMFZmN0l6dTMrd1FUT1hJ?=
 =?utf-8?B?aHBjbWtTWlhLMVhiRTdnK1RBTEVXSlBDakxBbFlJNWJ0cko3QnJqWEtiR2sv?=
 =?utf-8?B?WEVOWjRZdXhEOGNjaEgwTVc1OXBkWDNjRFhST09leDFtZHlHM0tzcDQ4Q1N0?=
 =?utf-8?Q?Zo8b23Hqv9bUDbYU9GXUectO02BQu1qE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1130.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9909306f-47c1-40a9-11eb-08d897d9d0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 22:21:43.5485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFGgtYA7iExl7PfX2UHCU7LQYpuuTKyQSuPFM82J4NnzkASU1bQutzuB/K4cHqcDkmx+5sv0E8TnwLwSwh4cfUfDp1u8v5i42mmtxZH7RgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>,
 Alexander Grest <Alexander.Grest@microsoft.com>,
 "ahs3@redhat.com" <ahs3@redhat.com>
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
From: Yinghan Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yinghan Yang <Yinghan.Yang@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgSmVhbiwNCg0KSSdtIHNvcnJ5IGZvciB0aGUgZGVsYXllZCByZXNwb25zZS4gSSB0aGluayB0
aGUgbmV3ICJQQ0kgcmFuZ2Ugbm9kZSIgZGVzY3JpcHRpb24gbWFrZXMgc2Vuc2UuIENvdWxkIHlv
dSBwbGVhc2UgbWFrZSB0aGlzIGNoYW5nZSBpbiB0aGUgcHJvcG9zYWw/DQoNCk90aGVyIHRoYW4g
dGhhdCwgdGhlIHByb3Bvc2FsIGxvb2tzIGdvb2QgdG8gZ28uDQoNClRoYW5rcywNCllpbmdoYW4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEplYW4tUGhpbGlwcGUgQnJ1Y2tl
ciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPiANClNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgNiwg
MjAyMCA1OjU4IEFNDQpUbzogWWluZ2hhbiBZYW5nIDxZaW5naGFuLllhbmdAbWljcm9zb2Z0LmNv
bT4NCkNjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgQWxleGFuZGVyIEdyZXN0
IDxBbGV4YW5kZXIuR3Jlc3RAbWljcm9zb2Z0LmNvbT47IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsg
am9yb0A4Ynl0ZXMub3JnOyBrZXZpbi50aWFuQGludGVsLmNvbTsgbG9yZW56by5waWVyYWxpc2lA
YXJtLmNvbTsgbXN0QHJlZGhhdC5jb207IEJvZXVmLCBTZWJhc3RpZW4gPHNlYmFzdGllbi5ib2V1
ZkBpbnRlbC5jb20+OyBhaHMzQHJlZGhhdC5jb20NClN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJl
OiBRdWVzdGlvbiByZWdhcmRpbmcgVklPVCBwcm9wb3NhbA0KDQpIaSBZaW5naGFuLA0KDQpPbiBU
aHUsIE5vdiAwNSwgMjAyMCBhdCAxMDowNToyOFBNICswMDAwLCBZaW5naGFuIFlhbmcgd3JvdGU6
DQo+IFRoYW5rIHlvdSBmb3IgdGhlIGNsYXJpZmljYXRpb25zLiBJbiBjYXNlcyB3aGVyZSBhIGxh
cmdlIHJhbmdlIG9mICBQQ0kgc2VnbWVudHMgbWF5IGJlIGFzc2lnbmVkIHRvIGd1ZXN0LCB3b3Vs
ZCBpdCBtYWtlIHNlbnNlIHRvIGRlc2NyaWJlIHRoaXMgY29uZmlndXJhdGlvbiBhcyBiYXNlICsg
Y291bnQuIEN1cnJlbnRseSwgb25lIHdvdWxkIGhhdmUgdG8gZGVzY3JpYmUgdGhlbSBpbmRpdmlk
dWFsbHkuIA0KDQpZZXMsIEkndmUgYmVlbiB3b25kZXJpbmcgd2hldGhlciB0aGF0IHdvdWxkIGJl
IHVzZWZ1bC4gSXQgd291bGQgYWxzbyBhbGxvdyBob3RwbHVnZ2luZyBuZXcgc2VnbWVudHMsIGlm
IHRoYXQncyBldmVyIG5lZWRlZC4gSXQgcmVxdWlyZXMgY2hhbmdpbmcgdGhlIGVudW1lcmF0aW9u
IHJ1bGUgdGhhdCBkZXJpdmVzIGFuIGVuZHBvaW50IElEIGZyb20gc2VnbWVudCArIEJERiBudW1i
ZXIuDQoNCkZpcnN0LCB3aGVuIGRlc2NyaWJpbmcgYSByYW5nZSBvZiBzZWdtZW50cywgYXJlIEJG
RCBzdGFydCBhbmQgZW5kIHN0aWxsIHZhbGlkPyAgRG8gdGhleSBvbmx5IGFwcGx5IHRvIGZpcnN0
IGFuZCBsYXN0IHNlZ21lbnQgcmVzcGVjdGl2ZWx5PyAgVG8ga2VlcCB0aGluZ3Mgc2ltcGxlIEkg
dGhpbmsgQkRGIHN0YXJ0L2VuZCBzaG91bGQga2VlcCB0aGUgc2FtZSBtZWFuaW5nOg0KdmFsaWQg
cmVnYXJkbGVzcyBvZiBzZWdtZW50IHJhbmdlLCBhbmQgYXBwbHkgdG8gYWxsIHNlZ21lbnRzIGlu
IHRoZSByYW5nZS4NCg0KU28gdGhlIG5ldyBQQ0kgUmFuZ2Ugbm9kZSBjb3VsZCBiZToNCg0KRmll
bGQgICAgICAgICAgICAgICAgICAgTGVuZ3RoICBPZmZzZXQgIERlc2NyaXB0aW9uDQotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpUeXBlICAgICAgICAgICAgICAgICAgICAxICAgICAgIDAgICAgICAg
MSDigJMgUENJIHJhbmdlDQpSZXNlcnZlZCAgICAgICAgICAgICAgICAxICAgICAgIDEgICAgICAg
MC4NCkxlbmd0aCAgICAgICAgICAgICAgICAgIDIgICAgICAgMiAgICAgICBMZW5ndGggb2YgdGhl
IG5vZGUgaW4gYnl0ZXMuDQpFbmRwb2ludCBzdGFydCAgICAgICAgICA0ICAgICAgIDQgICAgICAg
Rmlyc3QgZW5kcG9pbnQgSUQuDQpQQ0kgU2VnbWVudCBzdGFydCAgICAgICAyICAgICAgIDggICAg
ICAgRmlyc3QgUENJIFNlZ21lbnQgbnVtYmVyIGluIHRoZSByYW5nZS4NClBDSSBTZWdtZW50IGVu
ZCAgICAgICAgIDIgICAgICAgMTAgICAgICBMYXN0IFBDSSBTZWdtZW50IG51bWJlciBpbiB0aGUg
cmFuZ2UuDQpQQ0kgQkRGIHN0YXJ0ICAgICAgICAgICAyICAgICAgIDEyICAgICAgRmlyc3QgQnVz
LURldmljZS1GdW5jdGlvbiBudW1iZXIgaW4gdGhlIHJhbmdlLg0KUENJIEJERiBlbmQgICAgICAg
ICAgICAgMiAgICAgICAxNCAgICAgIExhc3QgQnVzLURldmljZS1GdW5jdGlvbiBudW1iZXIgaW4g
dGhlIHJhbmdlLg0KT3V0cHV0IG5vZGUgICAgICAgICAgICAgMiAgICAgICAxNiAgICAgIE9mZnNl
dCBmcm9tIHRoZSBzdGFydCBvZiB0aGUgdGFibGUgdG8gdGhlIG5leHQgdHJhbnNsYXRpb24gZWxl
bWVudC4NClJlc2VydmVkICAgICAgICAgICAgICAgIDYgICAgICAgMTggICAgICAwLg0KDQpBIFBD
SSBkZXZpY2UgaXMgYWZmZWN0ZWQgYnkgdGhlIG5vZGUgaWYgaXRzIHNlZ21lbnQgaXMgaW4gW1Nl
Z21lbnQgc3RhcnQsIFNlZ21lbnQgZW5kXSwgYW5kIGlmIGl0cyBCREYgaXMgaW4gW0JQRiBzdGFy
dCwgQkRGIGVuZF0uIEl0cyBlbmRwb2ludCBJRCB3aWxsIGJlOg0KDQogICAgKChTZWdtZW50IC0g
U2VnbWVudCBzdGFydCkgPDwgMTYpICsgQkRGIC0gQkRGIHN0YXJ0ICsgRW5kcG9pbnQgc3RhcnQN
Cg0KRG9lcyB0aGF0IHNvdW5kIE9LPw0KDQpUaGFua3MsDQpKZWFuDQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
