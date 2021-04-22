Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8629C43460
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 19:05:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9BB361428
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 19:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BB361428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9047A40628;
	Thu, 22 Apr 2021 19:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O3zIYOzaYkhu; Thu, 22 Apr 2021 19:05:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E11B240EFB;
	Thu, 22 Apr 2021 19:05:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E643C000F;
	Thu, 22 Apr 2021 19:05:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73A83C000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 19:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EE7040F02
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 19:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rFI0P6YhWlTz for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 19:05:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6ADF404ED
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 19:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv16Dt3vxJs5iOn4y0wKbaOX906gIYii40yFbgcdCGrwbzqdQNqGfcHMnkThkPqnKIbdpCOUBnZfYyJYibVKThQl12h0L8x9iUnf7Xf7OqQltBHKnnOZpB+1o9+sET0VBg6XzTHwTDhQdglXNGL1cVgDdKSTEfPbeWcxYSQNnTNhLU5Fmd3yln9t50/DT/ReWPB1wb3u0rg0v6tScboU1Wi2f9DLRAit05CFnlJ9Pn+k5nAy5cWFdaUlG0LYdMC2rDYhtlhRdv3T3gVk7Jy2yL7/VrnP6N+93oPsLSekjg3BIFokMChwF4AVpVjpDM2Xk3GobBLxbTXOYk0T9dbm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNiizhMaHaIrL/usLS6vkI0sLCctXFmcXBZ8jLx0wCs=;
 b=VeAcbuLuZimbmRSA8Gfn6FdrClSEIx2GtcmnTmnPZRjOcEGbfZilfgC80FYATJYtIXwdbVFC5XHlo/SyHcPgheFh9BYXQvoSP4oFyGfux5ypzQPSahguHfd/1YJMGdIQx3apHGmeIQ5wXVxn3AN95CCqJ9K/xJFJSDocgKvBxkFMjvtLYs0XoJ1DYZh6BV1xSKsF6+w55JFUzE/2A4Na29o5NOxjTFRoUPYjHUWzdLg6HG2ZO//G9bZwl5kt4UQ3sGYUbTjF/TIJWjCayKejMXMDOUWJvNYIbdJHneMkpzjroUhKfcA5d7sTFc1LfsWVr4BX12azUAY16ppBEPejWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNiizhMaHaIrL/usLS6vkI0sLCctXFmcXBZ8jLx0wCs=;
 b=UffRyK+7CZzOZkymmZc4JCU2qyjN0EWVD7SG5+jPJd1L4PQcsRFFEY5Hhgq4NYufrw+6oRGD1aVbcvWjurR8o7JBaKcBiDHriYlI4hwtQlva9U3PJCOTade3QVNlwCGesI2SVJuAw5qNeS77jVyOmKJVltEl2RqLJibAwy6l8/A=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 22 Apr
 2021 19:05:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 19:05:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] iommu/amd: Add amd_iommu=force_enable option
Thread-Topic: [PATCH] iommu/amd: Add amd_iommu=force_enable option
Thread-Index: AQHXN3htvCZhDJs6t0+m8CphP2KfMqrA5afQ
Date: Thu, 22 Apr 2021 19:05:04 +0000
Message-ID: <MN2PR12MB4488CD47D15A9A291B8A0499F7469@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210422130701.29872-1-joro@8bytes.org>
In-Reply-To: <20210422130701.29872-1-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-22T19:05:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=398c6481-6763-457c-8882-38766c755744;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1edb770a-ddaa-4670-b11b-08d905c189f1
x-ms-traffictypediagnostic: BL0PR12MB4964:
x-microsoft-antispam-prvs: <BL0PR12MB4964783B6ABD7E36F648CA73F7469@BL0PR12MB4964.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAQCChiU8T5AUi1AwT4ONvQIrMK+se/AG20UAGcfw1gIRJwiV7kdqzDq/hKv3CSryQwnPZJsJ/m1Eq1uo48Hs4SRZ+5j2Ln9PEdsVMs1bsKPBZvjyswyROW8hiFqTOiVAbjmlkAv/8AQl94w17bJBglL7gjrdpWognrNCKSbFw9mFfGW6mopSMhQB47qvHHfy01HHc5mPYFnHRL6duA4KesWmczxnpqDsQshzz1sb3AdrjrGPlE+IxIWJaj2q/QxQnFvEmaCxtxz1WM0YYxy+G7VrLB4OoZTo2BBgOdVnMT/m06y8WJOx4sGHg+XxJyxdzDUdUAjdQ30hXnhKPyEnSIWM75gTwWmNDAqsrIbCFztuzlf8usfif6nqXI6wptXTSfOo1b4FvESoGLnBjLq5jlMbf/O1pZSVcxV4FE+3N+VRGhkyQyoE3B/C4kFdhGp5ELM/cJwqHJc+X3WlCLIrGvNJk6GbuJwmS+G/ZMTXaJRUix0UJYuUf9vhs4+gBCsR0w7wYGswphxlvu8daqdKNbPuuxBOv81NKs6NphsqwwjFw4rfo05cAONqYZN2wY2zqnoVZm8euJnJqN6VNJt7Xtis3yLlbHlSQE1WjWQD0E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(8676002)(8936002)(53546011)(52536014)(71200400001)(66946007)(7696005)(66556008)(64756008)(66476007)(66446008)(122000001)(5660300002)(6506007)(478600001)(76116006)(83380400001)(33656002)(55016002)(54906003)(186003)(110136005)(316002)(4326008)(26005)(38100700002)(2906002)(9686003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Td4aCbshRFxIqklPdttQIbUiKFdWyQmURO3WyImn310zIaZxuOQRTYqsGu16?=
 =?us-ascii?Q?7LODuZXEURIalyrGJMlX3e12Z7VcOp2DTu7s/6gH+lM/phcPQwZawI6P0ZOi?=
 =?us-ascii?Q?PCjc3JJTHpZUKWPwDcFpoFc6P4PqB4+JhHtloGnxmqvR9vystRIlxHYXv4xZ?=
 =?us-ascii?Q?27H0A1P/MODGI9l3agXriYk8aM564R2xPgZo+w2y6GOdoFSEwJSgq/qbFrrI?=
 =?us-ascii?Q?bbR+HSvMU5FTKJI5rl789KJVOwIYrkqOlRB4f5aeMpaDOPdemnO2MZ7IEHJP?=
 =?us-ascii?Q?5OZVpczK18jzIr0s6x8H5DP7KyCERiyD39kusTtZl1eOwdB32N+IQbfWUcvS?=
 =?us-ascii?Q?M+rPHp7FCXcBhbqpPSwFOZ80/cENaG04QffTG65B3fb04Yd2MNKF191qyxbJ?=
 =?us-ascii?Q?F8A6Bn3Pfa23jKN4xQPD8mUODJRzqsXEGMQfk8wb/dgHK/kkNpWSTlS0vdo8?=
 =?us-ascii?Q?fl5RrMKlJe8YWXKQZr4/dOAQBnHAGzaCFUMdGYN9nFj/4Cdb1397F/Uh3IU3?=
 =?us-ascii?Q?UErTcEmTpSlFD3umg0gt9YrhTwUOcTsgJHbfsaCK4f4/ellgSRFTmHf0RTpM?=
 =?us-ascii?Q?LUO2+e+lWdwPGXx5awWZFk/q44MQp3mO/gmO2ekA1zESNFQEzQnjtAay9dgA?=
 =?us-ascii?Q?QfNAlg/eMpFLolfTF/j7P+y6DMjR22tGclwppO0p/0sH0Vd43qVR2TprSOOG?=
 =?us-ascii?Q?TtOGSgbzEeJjyYFL7OcAysJtlbJmk8bKnfIL3bBVLzW0WlECht81vewSzlPT?=
 =?us-ascii?Q?f5M6n7Yc8FQQYe/X1LJDq/vNgySvcUHiAB1rOq69i6NTl1hn3gzwOsj5J7qY?=
 =?us-ascii?Q?asWe4twCmn0WKi5K175eqkQe7JXRLNDwhPezhe0tC0Kw75+dnecvx5RLRzAu?=
 =?us-ascii?Q?3KtW9Z0oWk0hP49c/EVWHc4jDK7E3WyYH+BgBazgu1mx7EC3XiggPbxp4PLS?=
 =?us-ascii?Q?LPfflGAqoAnr1nZDb7HPOB02doIFMqP/+/h6Cr5WaDy1scPM40Xty1tpa8qs?=
 =?us-ascii?Q?jaqnyrIaAuct3hXIxfu25mmSVbHZ1mwkXuol1xU+AUq2vwzpyFl6x2yWI5Ps?=
 =?us-ascii?Q?/fIIvxzi/oIGq/QhXYHMF762Hm2w8LyTfJQ8pVw3dnWOMLqG7iMlvrp/JxiL?=
 =?us-ascii?Q?U5E2f26iNfEjo42ml8ZykZiX+cJ152opHu9idkyjB8iroSRLrtxwWUn0e/Sn?=
 =?us-ascii?Q?OvicpCeQvGK2AE/I9TZRq3/FXpRrMGnoKCr2sfgnZNam/80lIuVP0I7mcXig?=
 =?us-ascii?Q?AtQOkDltfS0dxYZxNWDQjpu2LXXYWCk4JJ1Sj26xXvfAsBioHnF1e2qrOq8F?=
 =?us-ascii?Q?vo5nD8Zq1r9FN+vin3djpCky?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edb770a-ddaa-4670-b11b-08d905c189f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 19:05:04.9118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxvWuwYyAPSa2LrVBan2BZI+bFNNjO0suGS4/VhIXps8Sz57G7/YYbQBryxEyqP1sfE04s/eO4VIt5d1plN5BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
Cc: "d1nuc0m@protonmail.com" <d1nuc0m@protonmail.com>,
 Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
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

[AMD Public Use]

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Thursday, April 22, 2021 9:07 AM
> To: iommu@lists.linux-foundation.org
> Cc: Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>;
> Deucher, Alexander <Alexander.Deucher@amd.com>;
> d1nuc0m@protonmail.com; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Joerg Roedel <jroedel@suse.de>
> Subject: [PATCH] iommu/amd: Add amd_iommu=force_enable option
> 
> From: Joerg Roedel <jroedel@suse.de>
> 
> Add this option to enable the IOMMU on platforms like AMD Stoney, where
> the kernel usually disables it because it may cause problems in some
> scenarios.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  drivers/iommu/amd/init.c                        | 7 +++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..c9573f726707 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -303,6 +303,9 @@
>  					  allowed anymore to lift isolation
>  					  requirements as needed. This
> option
>  					  does not override iommu=pt
> +			force_enable - Force enable the IOMMU on
> platforms known
> +				       to be buggy with IOMMU enabled. Use
> this
> +				       option with care.
> 
>  	amd_iommu_dump=	[HW,X86-64]
>  			Enable AMD IOMMU driver option to dump the ACPI
> table diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 321f5906e6ed..3e2295d3b3e2 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -155,6 +155,7 @@ static int amd_iommu_xt_mode =
> IRQ_REMAP_XAPIC_MODE;
> 
>  static bool amd_iommu_detected;
>  static bool __initdata amd_iommu_disabled;
> +static bool __initdata amd_iommu_force_enable;
>  static int amd_iommu_target_ivhd_type;
> 
>  u16 amd_iommu_last_bdf;			/* largest PCI device id we
> have
> @@ -2882,6 +2883,9 @@ static bool detect_ivrs(void)
> 
>  	acpi_put_table(ivrs_base);
> 
> +	if (amd_iommu_force_enable)
> +		goto out;
> +
>  	/* Don't use IOMMU if there is Stoney Ridge graphics */
>  	for (i = 0; i < 32; i++) {
>  		u32 pci_id;
> @@ -2893,6 +2897,7 @@ static bool detect_ivrs(void)
>  		}
>  	}
> 
> +out:
>  	/* Make sure ACS will be enabled during PCI probe */
>  	pci_request_acs();
> 
> @@ -3148,6 +3153,8 @@ static int __init parse_amd_iommu_options(char
> *str)
>  	for (; *str; ++str) {
>  		if (strncmp(str, "fullflush", 9) == 0)
>  			amd_iommu_unmap_flush = true;
> +		if (strncmp(str, "force_enable", 12) == 0)
> +			amd_iommu_force_enable = true;
>  		if (strncmp(str, "off", 3) == 0)
>  			amd_iommu_disabled = true;
>  		if (strncmp(str, "force_isolation", 15) == 0)
> --
> 2.31.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
