Return-Path: <SRS0=1qmC=NX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE4C432BE
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 13:40:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAFD60698
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 13:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AAAFD60698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73CBA606F8;
	Wed,  1 Sep 2021 13:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E_N8ffWVDZjT; Wed,  1 Sep 2021 13:40:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EFBB360730;
	Wed,  1 Sep 2021 13:40:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA881C001A;
	Wed,  1 Sep 2021 13:40:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBD85C000E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 13:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE1B94071E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 13:40:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com header.b="niVvtx8P";
 dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com
 header.b="EXxiD29j"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o0DyZ6V4xUOG for <iommu@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 13:40:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42A0F40228
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 13:40:05 +0000 (UTC)
X-UUID: 3ad7c964e48f4b9e9951579e2dca31d4-20210901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=xnm4+RIee6nDCPiHhaRep4kZgXRYPgUrLaqbm00MQt4=; 
 b=niVvtx8P3CV4hp/Xov7fVp4sYaVZIw6MprjCiYlNdJ67ySBRku7Fh8gNZe+Lnb3EAa5ZMr2BGAEu52l7CpZhOvKDt6BzloDz8qV6GQ1rohUbwz4kHz2r9FkOCx+iemycpLKqoOWdWeEqjqXRqLA6EopKcNeX1XGszNfH9HVNJGU=;
X-UUID: 3ad7c964e48f4b9e9951579e2dca31d4-20210901
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 318247410; Wed, 01 Sep 2021 21:40:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Sep 2021 21:40:00 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP
 Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Sep 2021 21:39:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK15a/3/3nFWpC4hIH7aPF1hxuPDs6GPP29DDJK50BzvezeIjOzQyjQsfsekOU8YTiMtpf2lyyX781VmyR5/ExEkfecfhLhCPg//ThYm7QCoqpJkZWIIvTxj7ObX6+URGFWudBhb+N+6I5eqdMEOpC9V5zVEvcLoyCUK07wDaxpy3WfxEaL0XcwwBssfNxxBOSCG2C6qeJ8zrDJlLDMdAdlBbuWj5ZHKE8g8+ZuPuBTiOznnO5PXZ9g3aSYlpK32IOwdNYTWu6Ag1RYxTc2ysokLauuerlp4v4vFYXC13HC9mL/DxDcnud4XiKNwCHaBAFPrXyCGCF7CE0h66WO32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xnm4+RIee6nDCPiHhaRep4kZgXRYPgUrLaqbm00MQt4=;
 b=AKrQgeOKs8/aML1E2FBZiaEXRhOywQCtQqcEULnY8wsT2wuT4HC0DvzGF2bWckEFnQ0oFtKiRRIqrbNY4wS0d4mUIrUUkCwYScaqoQw0j0hdqX+JdzBTCX+yosj8v5USV46G1SoK6+Ejpm6di/Kn5k7yV99vo/m4wvclGkDLgKVB3H5OdlkB75J1UlA74oVpirE00gUgBcaVTPski4uzEUskyoddv54upNoyK9V6orUcSlBcqhtAGFn9V96HcKJrXGbFDGkeMQzdzZ28LMqj6qp9LUGRdYemPmDjPu+flEgVVZSSeiFjJolBK0GjP9PHzIqzR17TgGGpgZ7UZh2CTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnm4+RIee6nDCPiHhaRep4kZgXRYPgUrLaqbm00MQt4=;
 b=EXxiD29j0QYpbkL9+A3vVM4GM1Mh67tn36BIiy3zEwZSp3ZLWbw+Q471HJyYn++k+DJM10MfSSv5q+g/DGxpGsrmc8Fr4IvhE0kJLpX2jX3zgVO5kHABXtcI80JkWXTriU0KdNFfLebdmQvojcomnKh+9RX/n7n8AjuXi4pterQ=
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com (2603:1096:203:4b::11)
 by HK2PR03MB4403.apcprd03.prod.outlook.com (2603:1096:202:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.16; Wed, 1 Sep
 2021 12:01:36 +0000
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::6595:af4e:bda9:801e]) by HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::6595:af4e:bda9:801e%6]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 12:01:36 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "hsinyi@chromium.org" <hsinyi@chromium.org>
Subject: Re: [PATCH v2 16/29] iommu/mediatek: Adjust device link when it is
 sub-common
Thread-Topic: [PATCH v2 16/29] iommu/mediatek: Adjust device link when it is
 sub-common
Thread-Index: AQHXkBCYbO6e8lmd0kinqTzjFutBSquCVPuAgAzdGQA=
Date: Wed, 1 Sep 2021 12:01:36 +0000
Message-ID: <5e8f943884efbc00b839d33be5420bb8cd7a239a.camel@mediatek.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
 <20210813065324.29220-17-yong.wu@mediatek.com>
 <CAJMQK-ir-wLy4OHkWEWZf=CZcURMhRvHnOjBLWXaezhukJh2JA@mail.gmail.com>
In-Reply-To: <CAJMQK-ir-wLy4OHkWEWZf=CZcURMhRvHnOjBLWXaezhukJh2JA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 059d757e-5523-454f-5a04-08d96d403ff0
x-ms-traffictypediagnostic: HK2PR03MB4403:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR03MB44032ED105ED5B1A7A7DAFA998CD9@HK2PR03MB4403.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6FsbGWur1ZWk4fqQGBScJNFKYybFVN3ONXlAB1O5Yjk4GDMfFMniV2tv3wL4PL+kBUTnrdVkt74IeGhix36JldhGsG76/S7lct+fB2LCYuK/GVg61/364p9W2wQP0NOURRhgICxXtZ0LfFr+uULmpSYB2KERBUe5+bdXacD41t7HudOG5P+BciB/mi1FFmDbe0AwlcEK6pJ6EJ1IZ7NsZVKKhUJ79fzFq9CkFCXV/A01fhgGzlPnQSUwaIZi6Ni0ddg3zxtXk00oeMB4MpR5WTnNNpT9hx5WTGEOxcdkp0mlZmjA7lYq11Iq/2taMcsEnIxgHa+I24xXA05WD+ve6hkiUTD3LruHIWSOGWceq9f6VEgv5pbz16aq/pWY46tPtxqAbLbRWAS6GKPIX0sOgVLd7b/UxXakUt9xdhaAgZGch4Ipfm01tq56J/XzzA7BJH7tnNPGnmJCrgqJv2sSqiHhtvVoAb0Rj1bEQ7HwRRDsl+HRfqKyia+4w3NbQYjA+yDcXgmcZLKJAlyvuZs034d0yaXGmfi8Ehxqc/A10cYSNItuAJoQ3yXQdE9OcJhMKSfCHhcyWOPGA90UXiEp3WqkybNvrjExnN2fw2dzIfe3OCQrTCWIyrymSox8kOzJsmPBu6lM9Qn1gFmj0AV6Tc3JusFjWjixkK7v0E250AEeQ+nuaRzkq2EZ0NhiycXLat7bGsDEAAq15dKg+JFwRmltMntge/DW40osjzFNGpvHDiX7yHnSrmmUx9GS/V842l16AvApxh3V6GuASU6a/Hv/tVuj1Mk9Q3W0jTyri8UYC4ybJ5y/t3OpEUBhTOju
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK0PR03MB3139.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39840400004)(136003)(346002)(396003)(316002)(83380400001)(6916009)(4326008)(6486002)(54906003)(5660300002)(66556008)(66476007)(64756008)(66446008)(26005)(122000001)(38070700005)(85182001)(66946007)(38100700002)(186003)(2616005)(36756003)(86362001)(7416002)(966005)(53546011)(478600001)(71200400001)(8936002)(2906002)(76116006)(6506007)(91956017)(8676002)(6512007)(99106002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ky83OHRLYmpyN3Y2YTZ5LzN4bHVIbjF3bUdkT2hvMzR1OC9iUHZqaFpLeDZl?=
 =?utf-8?B?RXM2dEtKdk1qUWRlNXpaZ3MyMmZEeWJJN3hDWDdXMk54NzdDRDhWTURxdUhR?=
 =?utf-8?B?RXkvMGFaaG94cG04QWpxUGEyTTVXU3M2OHlJL013YkloWnhVM3I3QTFZTXpk?=
 =?utf-8?B?THNXR0V0eXd3cjZjS3pCVkxJSGlpVkNiVkhZNmZWa29HMDVmVTBmanJ2V2l6?=
 =?utf-8?B?RDdMZHZhbXFxc0IremdjS3dCRDU1L3pQT1ozR3NFZkVDUzh1WlJtKzZwa1pj?=
 =?utf-8?B?QVkwMkdUd0Jvb21JbVRPY2dmeW9EdVRiODRUNkdLL0w1V3UyZ3czMVBCanlT?=
 =?utf-8?B?MStqSjQ0bHlTUjQ4RFd3clk5ejlReHFXd001QUVxd3hMS1V6aXBWT2hZK1pu?=
 =?utf-8?B?MVlqR1dzejkzNW92YXJxY2dmTkpORkN4SnpRRGJOZVFkU3ZiSXhUYythbXFY?=
 =?utf-8?B?akRLN011N1hhQk96OFcvTCtvanY2aHdZcTZXRTJPSVhvODFvZlFRQXpQZ2Fo?=
 =?utf-8?B?SUpUKzB3SFY5Q25nczNSSFNwaEdKQVBNVEFjOXZxa0xaRXRmZlM1WnMycGlz?=
 =?utf-8?B?TkZ2UkZBYklkSlMxNW4zZm9tOVBzeExrRm5UcndPUk9Jb1VDTmZ2NzB0eU8w?=
 =?utf-8?B?d3FUSmw0R2J1dGNsRmZMTXp3YmRTOG1TenhDUW1wVlV1MWkxU09YS3VvcUpH?=
 =?utf-8?B?UEtOcUk0eWNleFVwSUtoS2xjS2d2alFINU53YWdiZ0FYN3p1OHNFMytiQlF3?=
 =?utf-8?B?RVhkaUpSN3Rvd2l3NmtLbkpKbmZLNDNnbTd1YnQrVjh5eXZyTTc4aDNPekRq?=
 =?utf-8?B?T1BZRzQzdDd6dzMxb1QvRDljSEsvQmNxZW9Sa3ZxT1B5OFpYem13N0dLdjkv?=
 =?utf-8?B?QmFVamtyUk14bDFZMDA1cVZ4QWhrMlA1N3V2VlpiNm55ZmtMRWFDQmYwMFFO?=
 =?utf-8?B?NFhDM0V6NFVCTmtBdUN3SW9mN2JXVXg4Y2dERmNDQk5SekZMYkhOcDhFem94?=
 =?utf-8?B?NjRWZzkvRFl3ZDhEcjNqQXd1MlFHUmNBRHVFN1ErMWlqSmF6VlR0VFMzNmE1?=
 =?utf-8?B?enN0UTZmU1ZMdDZvbDdRMW50d01CZGZ0VTBXZSt2RTFFRFZpT0lnK3Jjb1Zp?=
 =?utf-8?B?SHlNbXkrSnZXN09lUGVSQ3JyYWMrSXcwbGd1UUFqY0s4b0o3VU9pUUZhbzJD?=
 =?utf-8?B?SnVjVmdKcE9JTkZPM3d0MEdmRjZwVDVIREhtTXZra0lyN3lncGJXb2tOS1lQ?=
 =?utf-8?B?R1RnVnZpNTUxQjhNVkRYQm9NblZwL3M4cjBJdUdGZ2FBUlNuaWdoaHdEcXIv?=
 =?utf-8?B?THdWdURRR1hQTmdUMnlCZTFENTRwRnlxem1Jb1BQT3lCSE4vbkdwbkU2NFhK?=
 =?utf-8?B?TmJ3QzNLdzFJdzhlQnk0b2VWa1lPVGdHQUtIWE1RdEdBSlF5TXVxcmtBRWda?=
 =?utf-8?B?N2NSdlJGSDBtZDhIWFdvalk2cGpNYm1iS2lsRG5kNVB4aGlTd3hQMlFPVTBB?=
 =?utf-8?B?SGZoSVlReUVzbTZBZFFOZkc2dzJJeGM0T3hBeXBuZzk0M2xLOTJkT3lBZ3NK?=
 =?utf-8?B?cWRoZ3RjbTVDZkxJMDZhdW5xU0lSRmgxa2dQSVE0a000WC9sTG5yVzZCalVz?=
 =?utf-8?B?SDQzRUo3VHJ6c1ZZa2JjM1dtaHE4NEpmZWJnUk95S2FOeUYraE1yZXcyTGtq?=
 =?utf-8?B?ZjNJQ2xNSG1GWndIeFViNEZ1dGVZcmRDWjZtRjYrYkhncStnWEpKK1Rnd21L?=
 =?utf-8?Q?WFDy+Pp8omIcO6k1yVASXYLmx2tQ/io0raf1Kpa?=
Content-ID: <4A1762D6C555A64E8F0701808953DCDD@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3139.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059d757e-5523-454f-5a04-08d96d403ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 12:01:36.5188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jl+nF8qILE3xXmXeBXQf5li6E9L8oKhAIrUQXVMHLLDDRYXQZAHjG8IVJ3tSuylv9WDg6BWiL4OT/pxdfgPtyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB4403
X-MTK: N
Cc: =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= <youlin.pei@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "drinkcat@chromium.org" <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 =?utf-8?B?Q2hhbyBIYW8gKOmDnei2hSk=?= <Chao.Hao@mediatek.com>,
 "will@kernel.org" <will@kernel.org>,
 "krzysztof.kozlowski@canonical.com" <krzysztof.kozlowski@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "evgreen@chromium.org" <evgreen@chromium.org>,
 "tfiga@google.com" <tfiga@google.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 2021-08-24 at 15:35 +0800, Hsin-Yi Wang wrote:
> On Fri, Aug 13, 2021 at 3:03 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > 
> > For MM IOMMU, We always add device link between smi-common and
> > IOMMU HW.
> > In mt8195, we add smi-sub-common. Thus, if the node is sub-common,
> > we still
> > need find again to get smi-common, then do device link.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index a4479916ad33..a72241724adb 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -845,6 +845,17 @@ static int mtk_iommu_mm_dts_parse(struct
> > device *dev,
> >         if (!smicomm_node)
> >                 return -EINVAL;
> > 
> > +       /* Find smi-common again if this is smi-sub-common */
> > +       if (of_property_read_bool(smicomm_node,
> > "mediatek,smi_sub_common")) {
> > +               of_node_put(smicomm_node); /* put the sub common */
> > +
> > +               smicomm_node = of_parse_phandle(smicomm_node,
> > "mediatek,smi", 0);
> 
> This only checks 1 level here, and does not check if the mediatek,smi
> of a sub-common node is not another sub-common node.
> So maybe add a check that the updated node here doesn't have
> mediatek,smi_sub_common property.

Yes. Currently there are only 2 levels. we could confirm if it is sub-
common from if it has "mediatek,smi", then "mediatek,smi_sub_common" is
unnecessary.

Will fix in the next version.

> 
> > +               if (!smicomm_node) {
> > +                       dev_err(dev, "sub-comm has no common.\n");
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> >         plarbdev = of_find_device_by_node(smicomm_node);
> >         of_node_put(smicomm_node);
> >         data->smicomm_dev = &plarbdev->dev;
> > --
> > 2.18.0
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
