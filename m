Return-Path: <SRS0=whWg=N5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955DFC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 00:02:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8C76109D
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 00:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B8C76109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 071D940528;
	Tue,  7 Sep 2021 00:02:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1b_qfO2ryZp; Tue,  7 Sep 2021 00:02:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E3B2140533;
	Tue,  7 Sep 2021 00:02:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE4D7C001C;
	Tue,  7 Sep 2021 00:02:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61516C001B
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 00:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50757824D4
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 00:02:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ij5rDpVfJsv9 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 00:02:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400135.outbound.protection.outlook.com [40.107.140.135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 83027824CB
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 00:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLMRmPpmDMj9GOtPL0Kt2vgEjcMf17sCFyrsBK0ZG6MQ16LRfHBq3zSukpPI9HxsMbgdXq2qut6TlML9sM6k5IuPswguJb5r/2kio5MQxGqFQCd6zGqwNF6VGcK6j43T+ZD57SQGeckk4yLYOJtZwqR7x/4rKxytr045gE63Tic0CRghGvhnkNF9efY6Cos2Aos0wrDbZqDORBUKyMX3gOuZYYJ2gCc7rMthVQsYw//t8eHf5NyXj4Nf1maNU9YHv28pd+VPwbETzvpKcK5FmtW7INN8+ddE24SGNtsi8ZGONQrDQEVZqF3gaMqsrrPcqEdZR8E2avGD/y0cxAFYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=9IkjNcpv4+JyqwbD1me1kJcyatV+chIy+Pxyy3QzrF0=;
 b=BYpvHe9Mrf/j+EsybK5KOe2cRgIX0/x2BeE3Ka45V3gYNvMVIPxCs6PpolkRp1fyM5iy29H9xQ4pbo+Ym9OtYr8C6hksRrpBOi8462vbJhf6BFiSz3ab0iarg50j9owFwBzMh9SQGoiMllDKb6XQ/G9eh8eWnNb94e8UCDvzVk25WkWMhMyHA89ybTntykIQ52HBpW8OWEJZJ5/kf7YDPaFpiLunehL5h6zplr31NqGnGQEovMZcYR91i1a18OePBRwFHFhOF2HUpFNzyEFjRz+1JFLlmE3994P+WbQgyrfmQIYxFi7S99u5hIBZCLeORe30VrgPY8hxglUnd4NdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IkjNcpv4+JyqwbD1me1kJcyatV+chIy+Pxyy3QzrF0=;
 b=CrtNplopwLqlWecJYsJwC/NG9DD8irMlPrBTN5lLGLVJpzROYdH8pu/jRhnjMF66//5Ygi7nijzkYMMnYERvamE4UD807fHksYJ7/j+H44Jw1suHnxfbWKjpfedzlyvU51SrPLTjEd0DqhRhABr7HbW6F056vIktyY6TMmMJC18=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYAPR01MB5611.jpnprd01.prod.outlook.com (2603:1096:404:8052::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Tue, 7 Sep
 2021 00:02:17 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b10a:f267:d52c:1e5b]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b10a:f267:d52c:1e5b%3]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 00:02:17 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 2/2] iommu/ipmmu-vmsa: Add support for r8a779a0
Thread-Topic: [PATCH 2/2] iommu/ipmmu-vmsa: Add support for r8a779a0
Thread-Index: AQHXnxvyoah/Riy0106C9EDQXIK2f6uXKuaAgACM7RA=
Date: Tue, 7 Sep 2021 00:02:17 +0000
Message-ID: <TY2PR01MB36928CB43B188D4082829A1FD8D39@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20210901102705.556093-1-yoshihiro.shimoda.uh@renesas.com>
 <20210901102705.556093-3-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXwf0_+VKfuiFQf6roZErz-JAm06P5RBzD-Jwm1uk=p9A@mail.gmail.com>
In-Reply-To: <CAMuHMdXwf0_+VKfuiFQf6roZErz-JAm06P5RBzD-Jwm1uk=p9A@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none; linux-m68k.org; dmarc=none action=none header.from=renesas.com; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0929c60b-196c-4882-7a10-08d97192c15f
x-ms-traffictypediagnostic: TYAPR01MB5611:
x-microsoft-antispam-prvs: <TYAPR01MB561198D1C0ABE1CE410DCAFCD8D39@TYAPR01MB5611.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X0VMjWOQ8RfsfT+9MjQQypOZg2nvhmwkg+oTWPylZPqFS65JCL+S2RMt4mDI+5bbfPuNnZWWwLZpY2ZiwZCtwJfOOtvIKlAk5o1tHoA1Dr++tgwLr9GltrksYAFGoYPTmcPTgIi+DdXkkkqADXEgM/WH5evBU+z8NZfh62si0cvtIH4dSrkd+U8zY1657kHXa/LLe/HCtJcQzNyd/RXn8i0V+UZmtrWfBdrwMZ928Uzs9hlg03T5GyTE4ogMx9QAT9wAhn64QUiYDHKxTGGbr5vVqcn9VAHJeRSdtcPcx4MohbrRn7UsruauUalkodjFYAQqRGoCNqlagSYjypdFzxueOtFqUVP/pobup02aRRW25IOduOITuCME9/aS69RVaJRkOYAYKCr8WJehmR+1tERaEIVOqoBW/unpHTjIOfyRNw0fS/l+9fZ9xohWsUhu4mIocsyK6phcILNthS8IKke0avY2xJk4DgzBwW/f/GoWxq6WSDZ2OjwZE1vTpayIzuxkNChzUTQ11KCz6OEsjjFOhOaF6aEzOJazowAsx9M9HhEMtAgK1FjV8ENOdAynSAzNNVGAQZFaVTDxOGDj5k81zgYP3dpkPy2xtBSWPrpwIgQf5vlRYSid7wsHq8lr6wfhfycgrPHsVMtfccbFLQw6nJHUnYusMwTS6oltHLYBbegVQxZQmfZdnwGNx2dat/4io03dqPGrcsIKkQ/wQXcUQVWwf098LxMIjipLy+5cdD8V++RxFCq8zu1Padv/LM8kawwvrphCcKYpZvkcqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB3692.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(478600001)(4326008)(71200400001)(64756008)(33656002)(86362001)(5660300002)(83380400001)(26005)(76116006)(54906003)(55016002)(186003)(9686003)(66946007)(66556008)(66446008)(7696005)(53546011)(66476007)(6506007)(8676002)(52536014)(2906002)(8936002)(6916009)(316002)(55236004)(38100700002)(122000001)(38070700005)(138113003)(98903001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFBTZGgrZkNueU9PRTE3NitxcFNkSVdBMnE0dWpZaXdxOFZxWnA4UTdBQm1m?=
 =?utf-8?B?UzdMUEdVdnBTRHFJU3pyRWlNUnZNbkJZTzh6L2J1VDlzNE91azZkUWdxQytE?=
 =?utf-8?B?SmE2bGM1bzFDcWJtcUhoZC8rN1Yzdms5QVlocEZTWnNDVjhuRGtvTFlEckNE?=
 =?utf-8?B?TXFoVE9OVFl4SFdiR2F4ckVmQnRNeVBLL2xwazh6OURUNVBaTDMvUkwraWc2?=
 =?utf-8?B?Mkh2aW4rWWdzUTQ5czNKTi9JY3VQMEJuZ2w2MnFSSnFkcVVtMkIzSVo0MXZX?=
 =?utf-8?B?SElvQlRvQjNZT2phaXNhUGVVU0I5UjJ6R0dGY3JPOTZ3QW9MWGxCTkRWZlZn?=
 =?utf-8?B?SFJoRGpTbmhQTUsrdjkxd1NjYkFJL09iK2s5RGIxNjFZNXB1Z05keUJwVFIw?=
 =?utf-8?B?ajlFVXB4UTE4NG1EWmpDMGNKRkRmUExvSTM4bnpRQm5rSm1Kb3ZZbm80U0VR?=
 =?utf-8?B?cnZKaDRFdllYbDk2VnJMcWtlS2svdDJ4TnREWEcyRnZqL2hYcUJlOVQza1Ix?=
 =?utf-8?B?ZVBvR2wxOU4vVDFlWHphc2dDMmdQaUM2aGt5ZEFzZWxUQTdDYVNFUHp5VGEx?=
 =?utf-8?B?WnNIUVJpNUx0YWc0OGRKK1ZPdXdmdzJQVHpjS3NBZjQ2VWsrVFBtK2xKQmR4?=
 =?utf-8?B?bHU1TXk5WmpQMTNsc3pEcm5Xa3JLN3Yxa21yQU13bmhYM0hoY05ySUlNZkgw?=
 =?utf-8?B?enhTWEVtdVo2dVAvcHVXRjRLcldoejlNM1BFWFVuN3kwUGlXeEFUMTBTWmQ3?=
 =?utf-8?B?ckxENVI4UitrZzZSNlJYRnlMcGtSRUNPaDBZUGIraWtad3dwMHI2TS9oNlVx?=
 =?utf-8?B?aVJJMzFrT2U5NmdRWHI5R0NRK2ZpWStER1VXNkU0Y1hJUkp5cHZIenpxVE4r?=
 =?utf-8?B?ODFEYVpaVm9UeDhEZFZVc256Z3Z2YVZOWDB6K21wZTFBVGNUR0ZoNDk4eEVC?=
 =?utf-8?B?QkRVaW5QK2dYWG9aNWd2S1pEdm9RSkNJYmN3OWdoQkNTNlk1aUdOSFhlem5G?=
 =?utf-8?B?bVVKVXFhKzlGN1llU1RyVm1ldHBLd3VCcjZSUWJ5RE9XNU1oWm8vQ09sMnAx?=
 =?utf-8?B?N2t5T1dHS28vTFRoMHBraVplUmhoZTFjN2szbmx5NlkzNVdHZkFuUnlIMGlK?=
 =?utf-8?B?NFdkZjFVOGhMZFBZUzRZenduS1hoV0c0MHB3Y1lFYUYxeGFIYURuYmFHY2lK?=
 =?utf-8?B?MmV2TndkSDk2a01sd1ZwR29GVk4zOE9BTlpyZXlCZGRURjdzMHpNejRrRjhZ?=
 =?utf-8?B?aXlUeEZWSjFhNUR0S0FNL2JCaUdtc3lmWUkwTHk4OWpBRzlqOVFYUU02L3pC?=
 =?utf-8?B?Rmc2WDl2NjBVaFVoNElBV2ZHcUZlUWYyc1lKeEZHcTBaOHZwZ3ZGRE5aZkVU?=
 =?utf-8?B?Nk56SXFyTW5zTVJDWmJyWUZQcWpyYmFLNVBYbzQ5cVB4V1ExM2lvekRKWi94?=
 =?utf-8?B?ZHJHSG90Zzh3UDZJZEdTZm1XZVBla2tyU251SEJpWEE0M2VFSWpWalEzc3Vn?=
 =?utf-8?B?QXBaeVFGcjJRR1VQOHVnYi9aNXhNWG96Ui90bEZCd3pVRzBxYmdkRmVzWHFn?=
 =?utf-8?B?S2QxMUNCT2N0UHgrTGs1Y1FidlZNQ25BbUg4MG50QnZFYnhWdzg2cFRWOE5u?=
 =?utf-8?B?Y1psbXAvcTFLMUlNcmZ3bms3NG9FZlEwQ3hqelh3SW9pWCs1QTdEQ0JQOFRB?=
 =?utf-8?B?WUpXN3VrWmJiRkV4WHg0bVNIQWR2eTh4YVRDZVJZZ2JHYU84OHF3MmJWN0t1?=
 =?utf-8?Q?Y7/49rYjmb1f1WxlUbrftP1zQo3EPF7yG3Opo/P?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0929c60b-196c-4882-7a10-08d97192c15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 00:02:17.1630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVECDQ91xMp/k6e0Jw51KbBHSkIsFYpjl9bmn9/Y/2e/q6CCh8lG962UhVOHt8gYN0VerWtOABk0W2J2eDNEF4ieOCWVVPiyJDTKgjzh16HgOlYKbmA/ObM9yu4e5M6M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5611
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
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

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Tuesday, September 7, 2021 12:34 AM
> 
> Hi Shimoda-san,
> 
> On Wed, Sep 1, 2021 at 12:27 PM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > Add support for r8a779a0 (R-Car V3U). The IPMMU hardware design
> > of this SoC differs than others. So, add a new ipmmu_features for it.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> 
> > @@ -922,6 +922,20 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
> >         .utlb_offset_base = 0,
> >  };
> >
> > +static const struct ipmmu_features ipmmu_features_r8a779a0 = {
> > +       .use_ns_alias_offset = false,
> > +       .has_cache_leaf_nodes = true,
> > +       .number_of_contexts = 8,
> 
> Shouldn't this be 16?
> Or do you plan to add support for more than 8 contexts later, as that
> would require increasing IPMMU_CTX_MAX, and updating ipmmu_ctx_reg()
> to handle the second bank of 8 contexts?

I would like to add support for more than 8 contexts later because
I realized that ctx_offset_{base,stride} are not suitable for the second bank
of 8 contexts...

> Regardless, I assume this will still work when when limiting to 8
> contexts, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you for your review!

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
