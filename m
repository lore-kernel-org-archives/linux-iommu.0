Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605058;
	b=NBL7tp/vPlh2bEuFFT4bw88qCIv5D7p+YkZprLHMzXdqeZ1uXt7HJpil16/hVW2tKoqU
	 vut3UyXz795LBw620r6errq2uN0LJU2ybVXNSO1SGN9KbDTZVWoouhwvlhT4HSKgG0N9L
	 PY9k5gFz8Uud2hdyRwqVku4E99feLOOm6D58JC1QScHBz+O5b7FN04TvLLs3F2rR1d4/h
	 AO2z/KCJveIO2aHl1mEyfBhj7pdhhNlqrFc8bT8vUWPNUMbtiBStIeWEFE/z2Le95H6ho
	 ymu0MHgsHkf9krsnP7zU/vl80uMhoMaDRxcFFHKR41kRmJ2DLfuf2rHUCL+XZjJONFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605058;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PHkcXYm43iIBTgBURSR+DFhDb3VIIIxJdCmbYkMFwB4=;
	b=rVIL1ve4U+InFY+TfSQAqd0TAdOGLvtZWxHDsqv6lDlWLy2YDi7NcpwVe8uQswMDnAzJ
	 Qr3AIz1BQCc7UlRUAmY2rYkqNkjMZtHbnwwlggj2BpILyDxA0MJkpDK8tOb7WSo4BFefi
	 uBXqa/ZwX1F7BzP1xMeknhoqGwFxglMCAWtU3uuPFTVKH34B7h03uvB1EXr+yyf9FsUTq
	 6jjDP16MF3MPYT1Py4dr0TVy3hiFbuGgjVM5WK3qgUCFB+xTKTpLbbzuAsgPCv4PvK4WH
	 C2FF43CQ0Sqgq1CN91BCtFZUd8EDkHZLlL8zhvYGlhnAYFAqPgK8Z+z3rEXNbGD058w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=htBZ4kqy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.51
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A3606A31B
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 17:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E9A3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=htBZ4kqy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7totHUcg1C8sKric6FbOCrb1E3clPsoIwj+5lyMBrSbECUmnws7ut7oXmWzch1dv4JdHY8m6iYLo0+ymSHiHbfVV0LCBCwYu3MCnLNgd9wECzS2Om3hfsHNKa28HrbTP8gUE88Zato+3XZLr8hi96c/0gp4A1+MRRy4vmnXFqOo/QWKFIWlimOTVjBrEtQrtusw+i9hVJkR+beDH8lD+1YQXLhJuyoKImzUzuZXOtlZNKQsskfptMx7y7OHcgDPacM/sTwU7QilZjjfU1euA5oy0Ht4nHZsbjJayQtd6PNc7aHKmzIJtnh6isNZAXQZ6szGOyHMmQo1e4sPZViCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHkcXYm43iIBTgBURSR+DFhDb3VIIIxJdCmbYkMFwB4=;
 b=cUpp6wuSq0pHk3tPoc3jnlBtePXXZStZsIW7pc3bOrNs3hIJ1mkLfoimqqYEXZZujp5n54dWpASxjtFphES1q0zFHa5iid0jWFCXXhV+GG62GV+XTZPO4oBZ9Vgq0rgFITLGywnK6skOPbvmTMuEKGJ8n/AZu+LExvhd9ALvEPJWzaSjjzPkwJhrOHvkukdzECxQl7qRud2emXLqmqsZo8aeaAhcYIvN9YwEiDbJx8YVqRtunWjmmisMXyaluqC3O4CvHQME/FbmkOX3TQyNGvOWrIWhzQMoQ/cWhVu/hJ6rwYu2YQfATC6D8TE0Xjj1tQZiT8s14BZ087c1S7jPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHkcXYm43iIBTgBURSR+DFhDb3VIIIxJdCmbYkMFwB4=;
 b=htBZ4kqyPijeqRUE/NoT4hS+MLrXNWavmc66eGhR40kohpqygAqmw8lLcafnMOLsTi7x1DQfQMlsAHqUvx7EjF0pE4aEzMvsDUOpuhebmYiNW0m37+KqNPuMhqKau2ZvjgQlpQI5etA24vvyPoyHYEISv/LWr9o0QCNZ7D0QEJosHT+jg/0xzdxHRDhh5F2kTEuFa+VyKux/FXULrp3LPzFWBwQrU4BFYW/C4FaZDkvSIJrJ8+bcxGYliGdt+FxQnnIXyrSM+6HQZYh2vyuYvjHlAFwNPiKFkeUeDkNCQtLSbi14ayP1jbiaIyHSlVhJG77aG6ttxiqSTAhqESxhUA==
Received: from SJ2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:a03:505::23)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Wed, 21 Oct
 2026 17:50:46 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::6d) by SJ2PR07CA0021.outlook.office365.com
 (2603:10b6:a03:505::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 17:50:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 17:50:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 10:50:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 21 Oct 2026 10:50:24 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Wed, 21 Oct 2026 10:50:23 -0700
Date: Wed, 21 Oct 2026 10:50:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>
Subject: Re: [PATCH v11 06/11] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <atj7XTdjC0CIVDQY@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <ee4257b62324aa75d7140f1f4a49aa0f78586fff.1791226953.git.nicolinc@nvidia.com>
 <9f500b81-792f-47b9-a8a9-1415ff11b699@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9f500b81-792f-47b9-a8a9-1415ff11b699@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: b59a8f4f-05a0-4419-f481-08df2f9bd4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|36860700016|82310400026|1800799024|376014|6133799003|22082099003|10067099003|18002099003|261021121427099003|261021135927099003|11063799006|5023799004|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	j2KovAiqriZ+GYLlRuTL4yTZC5tAq0Mkbhp+xMrDnNv0jz7OXMITZ3Ym2/8Tf2INhQavnN7mGQUqik8KcH4WwdqmVCCKxP+yhc+mTpfNEXj0BNPSaYiS/BUBCcwKk9+sFloauDvNXr/Y0IEPANSE1gQrps0oBuYF4fVhH5Sj/sD2TzysbPKGiH0MGOkfjvM6dltQNtQdPbZa0EBbnVIsFFsxy6QthoDG5g/+bI9GPBhJaLZVuazSEYL8pFH6kFUuk8NOQHu9IbkNZlARXiYaUKxmoRNiG2KLJJGN4dlMUQ/XFOq3uJpA44iot0VA9X1eabkcjBT/2tkaEsswGCkfDQEXxlFmplb64VwY9RF7c31A47MAZ1b/JpvZSIKvbmIjxfqXT9ECo1uvcnDPe01O39UTlBHi1F3AMRGbNUgBCq+7Lwo25lCH8aEuZ/gS9F0jSNQTOz9cNubGZf5xm0DSCvxBeQmubpspp2VJGw27/r+RyAzUXLZ0pyeeWeGsYyn54NVihrza6JruUaXexmfpacgYJYG2x3WYDzMHIIYbyIsElyroYgKokpB9HuromIN714pQQ+hjWHdPl2kerJelpx1KuuGP5djK76HtQXj/6kedHzLRxG+en25Ry5kyCpvQE0TZo480+zPQVdIbx5JjH50lv/nAl5fLRMluq3sq7dOhTUTKrkx/y2bRn8kKielYishv9mlqz20Pdt+Xp8GL0g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(261021121427099003)(261021135927099003)(11063799006)(5023799004)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HWIUnumeXP5uHw8N9SA2WkNJWoWPjlV03SCAKi53TPutevDF2xthl1YHVyKZnzEHu4GY3xrd3fZsLVTp1b6pJtJV5wg8oETbNvS4J1DEmNRBYSckyfEyGWqFOQEcnuLYCBW99BStjg0JhKD9wuHDXf0YriwJs6g2ALAXWJqJ7jzwSQ06kDphE2Nu4v85yqtXAyTFh4n9I6kaUgo4vI9OcXXIzS9gVZ3oKtNYPdrfYyID0kN5MGovCohYcBba95EkvUMyN/RO75FV7jVyY2n4b2i+rdqWGZTfgVoJ2jLjztJxyVrAlMucNh5wLALB3bP86NpbXVS0uq7FOzmLaRSWacf4xfp4uMbRkQohiyfs5Jor1XLUmZjILSyN7W4mmkZJz4PlmFjpGsz/ZbQNG7a85hAQCB3eDLsjWAFXG7+vXiNoqPK4gWO/U+qw/DSl7Zk7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 17:50:44.4535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b59a8f4f-05a0-4419-f481-08df2f9bd4b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596

On Wed, Oct 21, 2026 at 05:37:07PM +0100, John Garry wrote:
> On 10/5/26 20:30, Nicolin Chen wrote:
> > +int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
> > +{
> > +	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
> > +	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
> > +	bool was_2lvl = smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB;
> > +	phys_addr_t base = base_reg & STRTAB_BASE_ADDR_MASK;
> > +	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
> > +	int ret;
> > +
> > +	dev_dbg(smmu->dev, "adopting crashed kernel's stream table\n");
> 
> nit: "attempting to adopt ..."

OK.

> > +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> > +		/*
> > +		 * Both kernels run on the same hardware, so it's impossible for
> > +		 * kdump kernel to see the support for linear stream table only.
> > +		 */
> > +		if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)))
> > +			ret = -EINVAL;
> > +		else
> > +			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
> > +							       base);
> > +	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
> > +		/*
> > +		 * The kdump kernel need not match the crashed kernel. An older
> > +		 * crashed kernel that predates two-level stream table support
> > +		 * may have used a linear table on 2-level-capable hardware, so
> > +		 * enforce the same format here to match the adopted table.
> > +		 */
> > +		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
> > +		if (!ret)
> > +			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
> > +	} else {
> > +		dev_err(smmu->dev, "invalid STRTAB format %u\n", fmt);
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	if (ret) {
> > +		arm_smmu_kdump_adopt_cleanup(smmu);
> 
> Why do arm_smmu_kdump_adopt_strtab_2lvl() and
> arm_smmu_kdump_adopt_strtab_linear() not clean up after themselves, which
> would be standard practice?

Well, the cleanup helper is needed here anyway. So, reusing it in
the caller drops a few lines in those two adopt functions.

> > +		goto err;
> > +	}
> > +
> > +	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
> > +				       smmu);
> > +	/* devm_add_action_or_reset ran the cleanup upon failure */
> > +	if (ret) {
> > +		dev_warn(smmu->dev, "failed to set up cleanup action\n");
> 
> devm_add_action_or_reset() only fails for ENOMEM, so I don't see a point in
> printing this message.

That's a good point. I will drop the print.

> > +		goto err;
> > +	}
> > +
> > +	return 0;
> > +
> > +err:
> > +	dev_warn(smmu->dev, "falling back to full reset\n");
> 
> nit: "falling back to full reset after adoption failed" or similar

OK.

> > +	/*> +	 * Undo the linear adoption's clearing of FEAT_2_LVL_STRTAB so
> that the
> > +	 * full-reset fallback uses the hardware-supported format.
> > +	 */
> > +	if (was_2lvl)
> > +		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
> > +	memset(&smmu->strtab_cfg, 0, sizeof(smmu->strtab_cfg));
> > +	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
> 
> Earlier the event queue feature flag was unset - should we still be going
> with that decision?

Yes. EVETQ and PRIQ are disabled in kdump mode, even today:

	if (is_kdump_kernel())
		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);

> Did you consider to just re-probe the SMMU driver without trying this
> adoption method when problems occur?

You mean -EPROBE_DEFER? I don't think it would be cleaner..

And it would retry the "adopt" mode again? This is a per-smmu
option, no global flag. When it re-probes, smmu pointer would
be reallocated. So it won't disable the adopt path during the
re-probe.

Here, we just have three lines to fallback immediately, which
is much less expensive than a re-probe, IMHO.

Nicolin
