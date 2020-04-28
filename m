Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79028C83003
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 07:12:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102CD2083B
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 07:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MT2b0and"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102CD2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EA4C722DD3;
	Wed, 29 Apr 2020 07:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 90LRyoBGezm9; Wed, 29 Apr 2020 07:12:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A768322DC7;
	Wed, 29 Apr 2020 07:12:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6646EC0864;
	Wed, 29 Apr 2020 07:12:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 041F5C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 23:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E487D87594
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 23:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sh0cSdxY3dpM for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 23:43:02 +0000 (UTC)
X-Greylist: delayed 02:59:30 by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2123.outbound.protection.outlook.com [40.107.94.123])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 88DAB87430
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 23:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5JHCrr0GXr0IvRZz1b8jM2r3O8ENsi6hnRZqnWpRzN00y0jZtOiDejq/sbZgzrfbxbWeEfgdedhh267UIqi0mSPQeEJJwo3ui2O8elssfkWMc7ISc+Y2s8y3lsc04BpaoEiFzLUZRx4YvPwXyExUx34+p8XvBQ5gYrHqzTrPkdyNgfzpPYmbnqaQX5I9SS89JpwpD+ctzAYB1A+OLvV4hnN+mmHlyLVz/7mR0P9ltP0guugPpGrN9GpwCBt76SRGofT5K6e/rwurENSWOw4PeKULqWigRtEUy+6wied4b+h9ZCSw6gLIpn+rByRyqxqcxfD/xuImKIqalCJLVtoOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKuYdmjn4Fj8J1ApQ+IOourv59XoWQ0o1RTkZAUJ0xk=;
 b=CattJ08uN+j1MpPLK/AdIBTqxbv4xBKKlNverhiVUyO25EKb3hl1Rd1749pBNkp0dHfJchxHqrsay5rFwRxkE8s7cImRVzQUotoJJdth2lNy+waH89iYODu69bFc3eQz9wEWBk8NP8lz2izby1vgBTvFqhhdABCUnL0/q6m3mxCzHucK+wxIyy1/ZhHnmcO7bf54LLAh8/bzz9worCatN9vuuDpGPpHd0uKOJUWqH+E2gqrGV7VBr+eUlcsIjsbvaTx6wW+j83xdlu3GwkhT/Ptjbi8npVWjzkVcculLhwRzjdZw3Q7kdhFUV5p6b4ySnPNII4EoYSuFVS9kF2y4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKuYdmjn4Fj8J1ApQ+IOourv59XoWQ0o1RTkZAUJ0xk=;
 b=MT2b0andHUgjWCfVMnKjw3oGwGHc+06ZfbYarkUc7fw9l18H+AB83rwm2yK1HkbcCfLpv9AQ7U1lOl+nv6f08vuOGVFhIA9ibDeQuXr04QlPgiRQvpZD7r9Obs8Oi4zBbcDjJd86qrwYasE6G8DWNtFQ84xREl049cMq5FdqR1U=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB5688.prod.exchangelabs.com (2603:10b6:a03:125::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Tue, 28 Apr 2020 18:10:13 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.2958.019; Tue, 28 Apr 2020
 18:10:12 +0000
Subject: Re: [PATCH] perf/smmuv3: Allow sharing MMIO registers with the SMMU
 driver
From: Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <20200421155745.19815-1-jean-philippe@linaro.org>
Date: Tue, 28 Apr 2020 11:10:09 -0700
Message-Id: <F8C2FB7F-2D21-44AA-B41D-0D4555A63660@amperemail.onmicrosoft.com>
References: <20200421155745.19815-1-jean-philippe@linaro.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-ClientProxiedBy: CY4PR15CA0001.namprd15.prod.outlook.com
 (2603:10b6:910:14::11) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.173] (73.151.56.145) by
 CY4PR15CA0001.namprd15.prod.outlook.com (2603:10b6:910:14::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 18:10:11 +0000
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Originating-IP: [73.151.56.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac7e4f50-13d4-40ac-0877-08d7eb9f6532
X-MS-TrafficTypeDiagnostic: BYAPR01MB5688:
X-Microsoft-Antispam-PRVS: <BYAPR01MB5688A45246F9B9F1A2BCC3D7E0AC0@BYAPR01MB5688.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR01MB4598.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(39850400004)(136003)(376002)(396003)(316002)(52116002)(53546011)(54906003)(2906002)(966005)(4326008)(2616005)(6916009)(16576012)(83170400001)(186003)(16526019)(956004)(26005)(478600001)(8676002)(33656002)(66556008)(66476007)(6486002)(42882007)(66946007)(8936002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asNcPy4r3Pf08wSPLPbcYSv+NGF38C7WduOt4rn+I25f6AE7Kk7pzjbQ1OjmPefKWMHxy7ZRHhR4URP2nmilfRk+aTAAM/+DrbN076meR0mVSPFmxin0ztm2/fCm+5Y8IJrs2+h+15CDbY0/06pcvj3FDa2B34aJzJHbBosP9O9s9ijhE/SKIcGF6XS0noQRbiKZDMsA0zNp4SXwMLeufv+LwiVis8XwIgtCunJaM5Rz/Gdy/uWwDKMBpwClzmsYQr0nUEwetSeI9SDJTI+87oWJbFM29RJmAnBrChHWO2T70M6PaaEaeGP7eJNcBcxaimyLQUqblQ7tjZkn378KSgP1ofW/s+P93T+V+Uiz2bxmCTA2Pb4I+XzRaqIE81FtNj4yQG0qp8iTfCc6idvnvE4/k0/ximzj6TsVVKn7F4YYx3AqKRagFz3g8zX2JZqsaZfWfIIaaXDJbK3E52kpWVSLnpK9SnrElacwSeJkVeRe/1ED6z90kA/QFIp5QIF6bVFUev2TyaFl6Fs1P3U2JQ==
X-MS-Exchange-AntiSpam-MessageData: GtST+5BgCrB95LoZUQrsMLvwj0nsDQCnTuGiUf5NrnUbkMibYkobrKfqyWXVFyv0edd7dP0KJv5zk4FU42A0CoEpX59SylP9GevR1DN+R+7nIIWusmnin+3PXIYGI0/oS+4ijrn5VtbcUYb0AlYkZ6VKfjSwWxzh+oOpnCn9EnsYBMiSGDmh3JcUPTdeInFXn924gKJzM247F7XraCE8ipYTj7WHVg3G2X2gGX2yC1MChEd3DPRTzlWrAOSfaIwbw7UTZIGofawEKtByr6xBd5qjBfKh3WYpmf4ONZiRjEVEfAEhF2DhwFI0L2R+XxuWNc9lPbeEG0fDCpczNJPplRyuzuAJn6XHC2619OeQ1eY9VzM24OtXmwww79fjLBQqPZQOuoMbXVgIsMsgmVtE1lt3EhBLtOcw4An3Da6O1MzfGyQrYcoVI7NzzQq0kDCPkyuiyjyfd5WKPbpDi/RdBrVfmOyLDhTkOXu93k6YtiYiB9IDh0COo6C0T+SOj2sVLwheDIbSyPwuYHUsyWEFacWj81wtW0hGmN6VVkRbHaUHhEmmwwl6fxrH4nhs+tr+yga1qCZGCzX2djEOiCO5s3mN0NTGqfKlkpTe0dbbfcHPMQwEfI/igAknayu6DMgGHqWpYueQj5S58zkroW5OeznNzgUCR/iFF2l/BCvOe5pgD/8yeiRVVVGbUoQjtGjoBhRKPDxJHUi4Dbybk0t7deOONF2o2ZCHdvPz1hV+60x+4wAXvQH3/Ricdaiq7aZm+j3MkV0GwanFSMbHfySxbXRjKk5V+nCWX4vtnNG08os=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7e4f50-13d4-40ac-0877-08d7eb9f6532
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 18:10:12.8468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayGi120GJt6NHvgCWZM7NqKceaOcR/ne0s6Zp6rIHLjBzYJf4d0MWKHSchKvRDyOgwBuhWXmZW02iPAHflTudyyhaYC35LAsHZTBtyM45eBhPvc1XAvxUDp6FoSmGm0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5688
X-Mailman-Approved-At: Wed, 29 Apr 2020 07:12:36 +0000
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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


> On Apr 21, 2020, at 8:57 AM, Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> Some Arm SMMUv3 implementations, for example Arm CoreLink MMU-600, embed
> the PMCG registers into the SMMU MMIO regions. It currently causes probe
> failure because the PMU and SMMU drivers request overlapping resources.
> 
> Avoid the conflict by calling devm_ioremap() directly from the PMU
> driver. We loose some sanity-checking of the memory map provided by
> firmware, which doesn't seem catastrophic.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> 
> So this is the simplest solution, and I don't think we're missing much
> by skipping the resource reservation. I've also been exploring a more
> complex approach [1] which has the SMMU driver perform resource
> reservation on behalf of the PMU driver, but I'm not sure it's
> necessary.
> 
> Please test, I've only tried the RevC FastModel using devicetree so far.
> 
> [1] https://jpbrucker.net/git/linux/log/?h=smmu/pmu
> ---
> drivers/perf/arm_smmuv3_pmu.c | 28 +++++++++++++++++++++-------
> 1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index ca183a53a7f10..ad63d1e73333f 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -730,8 +730,8 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
> 
> static int smmu_pmu_probe(struct platform_device *pdev)
> {
> +	struct resource *res_0, *res_1;
> 	struct smmu_pmu *smmu_pmu;
> -	struct resource *res_0;
> 	u32 cfgr, reg_size;
> 	u64 ceid_64[2];
> 	int irq, err;
> @@ -759,18 +759,32 @@ static int smmu_pmu_probe(struct platform_device *pdev)
> 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> 	};
> 
> +	/*
> +	 * If the PMCG registers are embedded into the SMMU regions, the
> +	 * resources have to be shared with the SMMU driver. Use ioremap()
> +	 * rather than ioremap_resource() to avoid conflicts.
> +	 */
> 	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	smmu_pmu->reg_base = devm_ioremap_resource(dev, res_0);
> -	if (IS_ERR(smmu_pmu->reg_base))
> -		return PTR_ERR(smmu_pmu->reg_base);
> +	if (!res_0)
> +		return -ENXIO;
> +
> +	smmu_pmu->reg_base = devm_ioremap(dev, res_0->start,
> +					  resource_size(res_0));
> +	if (!smmu_pmu->reg_base)
> +		return -ENOMEM;
> 
> 	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
> 
> 	/* Determine if page 1 is present */
> 	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> -		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
> -		if (IS_ERR(smmu_pmu->reloc_base))
> -			return PTR_ERR(smmu_pmu->reloc_base);
> +		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!res_1)
> +			return -ENXIO;
> +
> +		smmu_pmu->reloc_base = devm_ioremap(dev, res_1->start,
> +						    resource_size(res_1));
> +		if (!smmu_pmu->reloc_base)
> +			return -ENOMEM;

I tested this patch on HW, however I need to add one more following change to make it works

@@ -2854,7 +2854,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
        }
        ioaddr = res->start;
 
-       smmu->base = devm_ioremap_resource(dev, res);
+       smmu->base = devm_ioremap(dev, res->start, resource_size(res));
        if (IS_ERR(smmu->base))
                return PTR_ERR(smmu->base);


> 	} else {
> 		smmu_pmu->reloc_base = smmu_pmu->reg_base;
> 	}
> -- 
> 2.26.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
