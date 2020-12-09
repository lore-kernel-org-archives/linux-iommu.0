Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C4AC4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 15:46:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258B522B3A
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 15:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258B522B3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B73B52010F;
	Wed,  9 Dec 2020 15:46:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1qN2PQ1UPoy4; Wed,  9 Dec 2020 15:46:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2F24E1FFFE;
	Wed,  9 Dec 2020 15:46:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C4B1C0893;
	Wed,  9 Dec 2020 15:46:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EDC4C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 15:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EF49E873AE
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 15:46:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AYHGbko3YkhU for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 15:46:44 +0000 (UTC)
X-Greylist: delayed 00:13:47 by SQLgrey-1.7.6
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com
 [67.219.246.4])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 001D786FF2
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 15:46:43 +0000 (UTC)
Received: from [100.112.2.115] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-b.us-east-1.aws.symcld.net id AD/6B-42660-72EE0DF5;
 Wed, 09 Dec 2020 15:32:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSe0xbdRjld+9te4ftvLRjfCJo0s2ZgbfhQqY
 1c1FnjB2EuJkFU43SSyltZ1tqb6vgYwE7wmsIExZKF56CLEiQFTNENrFjQceyUKsxDcM4pEYe
 m5sdCvLobLls6n/n/M73O+d8yUfi0hFhIqkrsutsFtYkF8YShtnpWHrX777ctPAlhdJV6RMp2
 0b2KitP9YuUx6b2PEOogt4WTDXk/kmk8vRUClX1gW50kHhFYLTkFRZpBIZAOW1dlBT1BvqwEn
 T1vioUS0qpEgx83osET+YQ3C7/TsCTOwgqSjoQT1YQzF6+uUEQ1YXDD6HGyNiWCBkjYGgtlRf
 6EVSv3EZRgaCGcXCNP8V/b8agqqN60/gXBD3tJyKRJCmkUuCKh41+2EaZoGbAS0QxTh2AwUmv
 KIpl1LOwtrgu4Gf2Q2PZh5tYAdW/+kR82E44W9G8ESyhNODqPo/z7bbD0ngvxnsmwGSwdQMDR
 UHnuQmcx/EwNxMW8BtUIRiZGyZ4YS80hOtFPE4Gf2s14nE2/HhnRcDjFAhf8W2avgE1axeF0b
 2A2gXnSlP554egp2Z60zIJrgUGhdEsoGYw8B9fxuoQ4/5PPx4/Bm3DISGPU+GT9gXcvbFbHFx
 qChJtiOhBj+fZjHqD3cwaTTSTlkYzTDqdTjPpGQr2HTpP4eBoHcvZaUbBvs0puGKz1pSvsOjs
 HhS5pXwr9u4XaHn+luICeoDE5PGSk35frnRrXmF+sYHlDLk2h0nHXUBJJCkHSdP1iBZn0+l1R
 QVGU+Qi78pAiuXbJKMLEVnCWVkzZ9Tz0jiiybq55g5cSlgKLbrEBEnfjcgQFR0yOCz3LO7etR
 8lJ8okKCYmRiq26mxmo/3/+jxKIJFcJimIuoiNFvu9pPlICSxSQuyfiJaws/9KiSXYS++XpQy
 uHg1nvrb9fPuk8+Rvyd+8mvX5C9nl8WduqY/IuOCst/To36c1A41bFPOS72XixrYCbnrkD9ln
 awPZ/c7MUB+znvNilv3rxUeNTfsOdR7Sp4uJ0sOjnuCe42cCp5bY2lCWubX44GHPzYXXG5y1x
 P2l1zM//pYwdQW27o/rGstxZ7hqNeNIvKr+dPjJj8Z2HNAvPne6zu2g1UszSQO7/zw2sTp1Q5
 uzAwqSZ69NVTSEvLg217L7rV51nNpx9cv6p52xb3LUkRbnw8zOSpVn/fKD2YPMB5XuhZe1+1R
 LozFpGcr3OsVDzzd0h59QIu0q+1dLmWviq9SfrWeXNY9Y5ARnYJkU3Max/wCd5KhSUgQAAA==
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-17.tower-386.messagelabs.com!1607527974!170912!1
X-Originating-IP: [104.232.225.10]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25323 invoked from network); 9 Dec 2020 15:32:54 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.10)
 by server-17.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Dec 2020 15:32:54 -0000
Received: from HKGWPEMAIL04.lenovo.com (unknown [10.128.3.72])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by Forcepoint Email with ESMTPS id 8A1E96392516181825C7;
 Wed,  9 Dec 2020 10:32:53 -0500 (EST)
Received: from HKGWPEMAIL02.lenovo.com (10.128.3.70) by
 HKGWPEMAIL04.lenovo.com (10.128.3.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Wed, 9 Dec 2020 23:32:51 +0800
Received: from HKEXEDGE01.lenovo.com (10.128.62.71) by HKGWPEMAIL02.lenovo.com
 (10.128.3.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4 via Frontend
 Transport; Wed, 9 Dec 2020 23:32:51 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (104.47.126.55)
 by mail.lenovo.com (10.128.62.71) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 9 Dec 2020
 23:32:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akZnAK/pb7yf/5YyvvIzh6zgEYF8aZgjX0lWdOtcxjDPEF/j3a362UB8e8VoNP4rnHGTSZ1tPAHe7y+B0olbUZb+wwX95/VsZ4Xk7yrIumgEg1FCo7g2pOewXpAuLx2M87Mhwzh6zyZCB4ayBfgeuuwx/ZlDEOi8/pAcCqfAuk9r5sG7oVIMZb9je0pU5WWB8dxMadK3LwsUIC28fgOpNE5dmhOC63YdchAGgHvj5e2OkJBVttbdQthyUxIuUItkK3JMsHP1R/4CBt0Q9V9oAsP7OOwXP7gbCDmXhxpj403Fvjqn1p/brtjq7J+1wp72OtidS1eqP6ah6smCuZx+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm2nHP3FP9SmZebLPH1ixhWbfVhhDvE9LFWsWJPAu7M=;
 b=SS0cOI2N87kUSiqe8i0r+uUqPs9bJ7bvd4d2u1ofIyvm5NIGn+BNOi0F7jlfJ5WVXlpu63lo/cr1OB+NhT7C/wWOqhIRyxhsxkHB9kwPmrWBLln953kcecv0wdWi5XdX9+OZOWcQMRz/uCmFYsPmAiyWPGEzZB4z68LULqdWdj1+tTu4YYbr3XEzy7Oy3xgfkXBFpWiT6/1upEoscQ/EpZYQBXBKoVmehoC/vmmnxF83yDXFr63fM+yT4eT0VvOkJPR1tcHEesvdj7H5tV4Rn3PI7WaaPyv/U8sMU3D8REJqS6+6vTthBQoXMfLTBzlD9M3u+FPUKGJuqmq88LngTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm2nHP3FP9SmZebLPH1ixhWbfVhhDvE9LFWsWJPAu7M=;
 b=tRp4mhuESp1m10KctQOmhLmqBFwA90XD3N36gMmwWzWKBBzaQ1CZsZp1TsIVSbP0fzkpNRZ12jhWDBUKV1Ao1bZv8LqhRsnIsWGyuuY6G5tlvHTtVk4k4RM9QGbmc8QrqbGpWgwxyigtTV/vBhSOS9g/LbRKOeRQWliIm/g7708=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK0PR03MB3444.apcprd03.prod.outlook.com (2603:1096:203:53::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.8; Wed, 9 Dec
 2020 15:32:50 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::2db3:5dbc:5c8a:180f]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::2db3:5dbc:5c8a:180f%9]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 15:32:50 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Adrian Huang <adrianhuang0701@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>
Subject: RE: [PATCH 1/1] iommu/amd: Remove unnecessary assignment
Thread-Topic: [PATCH 1/1] iommu/amd: Remove unnecessary assignment
Thread-Index: AdbOQHD/M+tredDiSAuDOmapqMcZmw==
Date: Wed, 9 Dec 2020 15:32:50 +0000
Message-ID: <HK2PR0302MB2594BB6B721306895329A28DB3CC0@HK2PR0302MB2594.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:b011:e003:31f3:a5da:649d:d62b:3a5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 463a513e-73da-4f86-0349-08d89c57b016
x-ms-traffictypediagnostic: HK0PR03MB3444:
x-microsoft-antispam-prvs: <HK0PR03MB34449B78EF80EB1F1650C1B5B3CC0@HK0PR03MB3444.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sVs5pNR49FflQnHhhAJxog3amkFRVwUlEFasy4sekLTSVNq3HRIzzCYsitceS7PtLDZccme/RLJjUL8h56m7VlHsXYm5MQrFasQhGwCvMLpF7QYy5ZftLnUtisKI+NFz8BssPpWBeOzLVI2Qchr9tbMWfz3XphM4NfvUE7mQBYQsNM5g4cQNKqLESFRzbdFu6HOvGNHziMh57QGTZRE0iq8BTBPe6W0jh9R1jPRAyCcKr03etv7aXxknFAvuQL6lfyKRVCaZw9hy9XpCgAnq4q/zVNepAzMUdDvV5RsqRw7S8ffH71KGv1e7JWSslC3w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK2PR0302MB2594.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(8936002)(5660300002)(8676002)(2906002)(66446008)(66556008)(66946007)(66476007)(64756008)(76116006)(4326008)(508600001)(110136005)(33656002)(52536014)(6506007)(83380400001)(71200400001)(55016002)(9686003)(53546011)(186003)(86362001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?roZvDrReWaRHs2EAcn/tbN8cWUBdsr4IRVgOWibEjIUBlAGEUF31M1maZCxf?=
 =?us-ascii?Q?MX4eRNS43fAzC/MWkyORo2hiYkWqBFyMBXz0g42+zMxJ6BcxNTHcw3/qknxk?=
 =?us-ascii?Q?s6Uj7EsE+hTXj3TRWeOaur0dbhhnm0/J8tihmxQbVLe9zcdJ7fYFCLvd3KMj?=
 =?us-ascii?Q?5znsJn4i9yDMqFoBn77jYju3i/D/KBr4zMS6mGzOuz7xRZOFHQEPRp4Lzlnb?=
 =?us-ascii?Q?przB+CM5arPbtYx4PZU5pbavgfFN1eZ8g3+jJ79jJL3e2h19grdJ+jd2wfOy?=
 =?us-ascii?Q?3Q0uAYCvwkRhKxd5zt6LHcWJfzb1NigHzodR+v5wgtXFv/68n5YldB26ul1+?=
 =?us-ascii?Q?7eG2jDBRpoiMEOmwAt5jZ7aXUOj8xXkb10EKixlkGFwQ5meG+tisr1lx9z4s?=
 =?us-ascii?Q?/rXxWD6TbvEyYsUdU4O65BAEqIEjlk8AklAMqIlE7d8NwCjToa1YwUiTpMU/?=
 =?us-ascii?Q?BMtqyW+NMBeUDg6SdTedjgzBtWH0NKTofJJm4X/D6oLF0AGU2QNxczHcVcXd?=
 =?us-ascii?Q?7HKBC3BExbQlpaeqmo+squWhkQrXtsILpPt+WI7qYGi4PW6PB8XNDow+5vO3?=
 =?us-ascii?Q?6569xxoMhZ+PpG0rlor3SLA/7tehownbp+JGSuTCWt716PA07Ei/HAejf7kE?=
 =?us-ascii?Q?aJoO6y/GJ15MTZnOFOZDQbKtYkBl2gKigq9mdgiH7jUpn5kzqTO6Lg4my17+?=
 =?us-ascii?Q?BUI9kdRViWffWkI9y1rdOTlPvhIk3EYq0vVK3GS89obcFRsxye66zGQbxa1z?=
 =?us-ascii?Q?tXLvQgt+ID27pq1Z1NFBhCgxOYQPUuXIZQyfyDhve+stVx1Ud2VFcvnXZNjw?=
 =?us-ascii?Q?6QbH4L/62/a7+zEXGvnsYHz/3whqKE8+uHETSZ2snpwjIoJFbIETI8y8KNu2?=
 =?us-ascii?Q?iUdF/SjRsAnP7e1VoZxTLGY4JfLNGXeCmxGW/Zaw3+E5D3p3G2Fuv1P3k4rD?=
 =?us-ascii?Q?43XMHn7QLsytoOxFgCHjKiMnujhAAXtO6XnKru91eWQu2gf+0Yx919mAdcjc?=
 =?us-ascii?Q?XT3uBwiX7Qi744tZ9OghmqxSIRejJaniBxfoqHhImZiIWYI=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463a513e-73da-4f86-0349-08d89c57b016
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 15:32:50.2166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0tR1bDXoyUc0ADXEtAJ6E3BlX21Ek+MFm3CxtUHJA0cXSUBDwv6NNUyRMWnDbm2kNOWJ3UU2Qr+loWzuBKHCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3444
X-OriginatorOrg: lenovo.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Gentle ping.

-- Adrian

> -----Original Message-----
> From: Adrian Huang <adrianhuang0701@gmail.com>
> Sent: Monday, October 12, 2020 3:01 PM
> To: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org; Adrian Huang
> <adrianhuang0701@gmail.com>; Adrian Huang12 <ahuang12@lenovo.com>
> Subject: [External] [PATCH 1/1] iommu/amd: Remove unnecessary assignment
> 
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> The values of local variables are assigned after local variables are declared, so no
> need to assign the initial value during the variable declaration.
> 
> And, no need to assign NULL for the local variable 'ivrs_base'
> after invoking acpi_put_table().
> 
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/iommu/amd/init.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c index
> 1ba6b4cc56e8..f171078f7ea0 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1858,7 +1858,7 @@ static void print_iommu_info(void)  static int __init
> amd_iommu_init_pci(void)  {
>  	struct amd_iommu *iommu;
> -	int ret = 0;
> +	int ret;
> 
>  	for_each_iommu(iommu) {
>  		ret = iommu_init_pci(iommu);
> @@ -2494,8 +2494,8 @@ static void __init free_dma_resources(void)  static int
> __init early_amd_iommu_init(void)  {
>  	struct acpi_table_header *ivrs_base;
> +	int i, remap_cache_sz, ret;
>  	acpi_status status;
> -	int i, remap_cache_sz, ret = 0;
>  	u32 pci_id;
> 
>  	if (!amd_iommu_detected)
> @@ -2637,7 +2637,6 @@ static int __init early_amd_iommu_init(void)
>  out:
>  	/* Don't leak any ACPI memory */
>  	acpi_put_table(ivrs_base);
> -	ivrs_base = NULL;
> 
>  	return ret;
>  }
> --
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
