Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAA3B9DBF
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809459; cv=fail; b=AdoHPZPSc77arE+DlJqn7TwFtMkLJLVtjK6emhqNKc56kxhIZdZFuSrIi5AzWpszJPWqe+e1DfvqLvZtxhTWMMVFUwb3NQu8gX6vXafe08g0DcC2Yxsay5GD6hM2G9V5SOaqDtm3Se7HSWX80xVQDzaGL1DI0W/ZdeUiBmUT4Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809459; c=relaxed/simple;
	bh=CsOJ2c/r4YTRItYCyuSXtFcPHCwOBNTXSrcyDgkNS8Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOPkgMWNOLNCni/RbC8ILeoClWwrQ/rHExQB8/6SNvDHwGmsydsqxtPzPc0MdtNem6BhKUQf7cuIbadeOBI66PJXkSRcGgZEnisHrR/kUeC5h6s0PhwYQnJNbEnra+QKbm13pZq4CnrPM636RzMgqhFtjAcr5ogHw4NGQZpqe2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ooFu5Nyq; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ooFu5Nyq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+H/0BNVUtwzr21+mRbHIbEnUKeSU+eH7JO8AsRiYPZUNu21mIevTGF9MTYPy3hyIH4eEUFpHszd3j0HSf1BMTqu2qKyfdiQc1vIVKoFzxDPlyX4JSTpNr5W8uhNxjjZ0Q+IMG6xEOiy0DDdl0qfNyFEgfpg+KCnBDvjorvbXqzYC3LZBTaZmlOrBpQrgWLJTMC4oHZgbLRcazOd3O6t+50kX6W0XqYkIzP7Joti4h4zULsSfqId59U5EqKoClqX48AN/RMrVT3vWFx904mLmPmTBaTGSj5uv5JMSrZuoBitqhYjTrLsEk6d+T1UpRvtfZ7g8vRSzhq9oR59kMsVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkAhrZsOrNFQ+pZLvuGEEHaVIP7yAq5/Hd29v1bnZlU=;
 b=pG+y0vgbYYb1F7eSZibmydMRSHBmMUh1R54x+2Lp9hIc/S8n5YJUftrurCg3X8uvp9RL1dK7NhaYnjbWywfLVeXFCcyDLJa6vM5EhrpsJbWIMk+zVlvuPUxSgs6lkQpMH9si8Pr9c1JLlJ7JWYRqXN2Egom+dR3+9NW1GhFADORk2tzdtXsdJAA5lzp/zG2Cmkh4YO+uifIuzR0c1NiL+3lJLxOK6QEkUVXgQippK5vlqBK3KKwP+Qe6OvyeTtgH2fgDaYGoBPPoelbQ/tr98EutVJ67jKzbWOV+yb7a+mwmdc+EaM+tTpYzT4UK64vXsmbimlymUKNViUGXsh/e8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkAhrZsOrNFQ+pZLvuGEEHaVIP7yAq5/Hd29v1bnZlU=;
 b=ooFu5NyqVGXg9JLKoDvK7vmh3qp1QWloGRgF0uHOtlIDsRJQ5Zg5cL+FXvJUzOH3BgrYDvXJJAF1KJcfC94FODBEUz+l5qCRNWUO4VffDYIGFZp+Ze/E0RZnvafmIJ3wB9tHRkBwq88bjotvAW5ZEzLUW9AIHT//tjVuos2PsmXsom34BiyrvJiV0MIywEwDSu0KHUaFekgYuxY6rpSGL+r07ofamE87pTVWNDyQDnY2e5TjCSFeQbiembQN2UC67Zy7albv10mVC7vZKlbFh8Q3cOX8ahDjkGA10hOvrc1QS76RqbMmNKjLE7bAscIbJqmFDN+4WSlvSmaACChD/Q==
Received: from MW4PR04CA0126.namprd04.prod.outlook.com (2603:10b6:303:84::11)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:04:09 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::73) by MW4PR04CA0126.outlook.office365.com
 (2603:10b6:303:84::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 23:04:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 23:04:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 16:03:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 16:03:57 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 16:03:57 -0700
Date: Wed, 30 Sep 2026 16:03:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Daniel Mentz <danielmentz@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Mostafa Saleh
	<smostafa@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
Message-ID: <ar2VWVTSo2NtJdHr@nvidia.com>
References: <20260929032229.3532247-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929032229.3532247-1-danielmentz@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 575925d1-a813-40f2-4419-08df1f472218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	z9kWvq5qlkV1kKia/bR8QRPbbNDA1bB0rLvVrBFs1oGDlNSie61RPwtMIGp/8LmEHAIV+XwrmX8N+NswTf26Z6cw7MCDijUguS36OXn6pkAHoEnz2LZhYP7zwXiYOOlM9VxNUpoTNAiWVRU5rkD+TnVg1x77pEY/Uwxp2aG7kCBFas2Aa1fxnwOBIO02HrfMmeTLwcSQ2Z2ezGDoGPT2M+x7XQUK6SE2zvbmbkqNOTfWLtzXotxqnxFVv56c6c1d7CgW5Zu86ad1CTtavM5LVwozU0d4dodBYOK6GvxoXGy3R8ZbXwhzTuN2JMCb2LVh5DY+oQ6+H/SwdnhKc0NNdsn/9uoV6+3/qnrRGDrcfavQuAOGNaZN7iC4IpL33tFQz1j0TbVf5nJ/w0KmhFz6hNQU5bWxpPG8BAaab/QPhxSrbv9z6kv72e8Bwws7UAk/lWvrIr3I20WDKBo3jAVMBQ8z9hWHvsSQ3eqHmljAidGaWS5BvMs05s3leMbkYpPR14w6kruuz/54l/CaGv5TQyxCrvVV1nubs8YLeqEShAigjBQt+mBZepZ75rNdhRHw3e0QFEHqKVAiNR8yI55+2ygUQQeCLUJ+KcM20cd3Efi8CodelJttnjO5kzbkK9u7ti+qI5oVZ+LOnGR9nYJzZq33P2TaRxy3mKl3czszFkWS5jM1NrDSYixmVblvv2z7zep6U0oSqFjNy9G5OgLBrA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4DRBccPS2Kdh7Kt31wfO7sP9psMwv1Bqi/ZHsmuSEa+BQe79jpV2o9bo/n4aqjRpPpK8ootKD/UMuLT7ONONSPIl2HqlX6Hzj3Z47wVymRW4NDsFmPycY83b+W/0m+s+3fFp5ktnJCRsRbRjYabD/AKIeTXGVsZpUHgXt/pQ2rSkis4gpCHRu//qAU1wYywS3Qh/OqycKYlis0uWYUaBbfl1hghKNxn87DWaT2Bbpz6zRWfraOops/Nb3s41MHLi0oOC/Ls5hC4KcFZKdP4KgGENjr7dsjJEcTWVePs4hwmIZ8bwpFhZNyQXAeSfERokhZl87vM4BBD1SxxeNsWuGVH4oyuvS++TIKqaRtBcfzkVy4Y5k9xsAS6zWdrN1HsKjlxVWoAOXZO+SynAacuWhFEsrTykRSr2/6X9wGCNRoIz3S2vpq0M7AFIO/5URsgH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:04:08.4325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 575925d1-a813-40f2-4419-08df1f472218
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478

On Tue, Sep 29, 2026 at 03:22:29AM +0000, Daniel Mentz wrote:
> @@ -4858,12 +4867,20 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		return ret;
>  
>  	/* CR1 (table and queue memory attributes) */
> -	reg = FIELD_PREP(CR1_TABLE_SH, ARM_SMMU_SH_ISH) |
> -	      FIELD_PREP(CR1_TABLE_OC, CR1_CACHE_WB) |
> -	      FIELD_PREP(CR1_TABLE_IC, CR1_CACHE_WB) |
> -	      FIELD_PREP(CR1_QUEUE_SH, ARM_SMMU_SH_ISH) |
> -	      FIELD_PREP(CR1_QUEUE_OC, CR1_CACHE_WB) |
> -	      FIELD_PREP(CR1_QUEUE_IC, CR1_CACHE_WB);
> +	if (smmu->features & ARM_SMMU_FEAT_COHERENCY) {
> +		cache = CR1_CACHE_WB;
> +		sh = ARM_SMMU_SH_ISH;
> +	} else {
> +		cache = CR1_CACHE_NC;
> +		sh = ARM_SMMU_SH_OSH;
> +	}
> +
> +	reg = FIELD_PREP(CR1_TABLE_SH, sh) |
> +	      FIELD_PREP(CR1_TABLE_OC, cache) |
> +	      FIELD_PREP(CR1_TABLE_IC, cache) |
> +	      FIELD_PREP(CR1_QUEUE_SH, sh) |
> +	      FIELD_PREP(CR1_QUEUE_OC, cache) |
> +	      FIELD_PREP(CR1_QUEUE_IC, cache);
>  	writel_relaxed(reg, smmu->base + ARM_SMMU_CR1);

Nit: this is a big function. Perhaps, cr1_sh and cr1_cache?

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
