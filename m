Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21EA226D18
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783906; cv=fail; b=nGvT0UktCoos6DI2k4j3E1S+17I3XXBxPpeqt7ytfnibv/M6CcfeBL0wFVmXJMh6Ped5FD0kx4ykrNnT3yRTr2hW4pru4VWs6SHlxXDv+rrGPfJdn83YXyY7TUNHY1goOwmKuUNsYkMMDHM1V7HaH4FnkCdilBmFnsVw1ZWO8xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783906; c=relaxed/simple;
	bh=DN8Fl0YpWTgz9N/gAT24GUe4D9Bs6KdliDVqYYOgDxU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksxiymLdz2IOmpzyLSI0jHAOe9aF5V9H7y2SJvGgEB2YpE66nvVfTekHMgJIXezg19wor0PaX9D2ooJ1iS9p4GdJEvwmwwh8raChOVugzKPd/bNNu+HMuV3TGDSrpkGDA/kfjUzz8ocwhJ8gLXoXCjo+kZRk0Yo8UTQZ3bThNlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=spdfdBeO; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="spdfdBeO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYOXYiYw2aBhYqtpRCpaSXl0tT7sQUSqXyJ4vealPyFQYEBFlPQ3WvxVVa6rE21jhCsX2pqcn/yFNO1cIosNRYokHGUyMPeJR4mW7Gt0dhPFsB76hddvz97wLJ1/MSWJo+hZwbyH4nXUFyeikVeFB94jv14Sf/TO5X9sbqyWJtecAPnjZ2gnTMpRINl0QniDrDMq+CvZC8FI44qENGbFdrmSaQ4eCNI3hDzAqwGENWcgsgkKqaf2mRjIfj9yJKhUcnwhOo1RMiQ711ZhBmcOMLEaE2cdKk7Ld1VSFN0hnc6P1AA9lIYNS1ST6WyiXWWPsudaVJ8iW+Nf67daLUJL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE30yaKS4C8VidfcjjoCRxKgOh9LwJZutQy7D8LJlXM=;
 b=UvWbjtnDBAxIppq38K8GPwasE1ptFdn7D6uIfcXh2YYGiJinnOZ+vxxUgAhC7bQPWAw+Q/IGkqmZJAy53jt1r1hdaIBOd5QYMh6LRS/pwe8aipFdMlS1XcTFlgmx0pdAVNuvxQ3TTSzUkotS1DmnwFRq4fQNeCE9wXhtUq1xY1fkv1YoMESDOw9yrUp+BNBF6lWPYHJvRh6ga+H2Gb+jKBdFJVblVtRufAQ/DAexyV81mqHi6MEcUFq0ZRT1YNAaw6vn5YaSOEuy5YIhEUVcrekahNKML0JfQ/dXEA/ykG4HTtYgwxq4hEs7qiG2CMbXgm7D3eh/D3Z786yYV1YOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE30yaKS4C8VidfcjjoCRxKgOh9LwJZutQy7D8LJlXM=;
 b=spdfdBeOdKE+DIjRsaNyMJJKXtLwwbHt9AqqL8TIPyGNVn14x7HLQk5U4CUX+Q7PBvrNagzxtbcf+OsUcBqFNFI1DVKYn5ni/0kGgKiQBM7ngBMxWMWnyLjKh5PFm3dvB/nsYtJXXGXKRxMhGqzXRLCjJBHbhEEy8EYYAUkeU49eTd003V7H/tuF43/wZAlF3/vdjrgCcdjxmTH5yY/NHDDFcNDAO3Dseld5VdNDp7cSWC/wfwojRV1qLT3YSQCpFtNIWwCc2U+pMqJ4h1w5hJBH6m8tXWfOKekSgAxL3QnPjn42iws5uYfuTjPQ4SGVdyLyvDJYLLVbuYCDWyCXnA==
Received: from BN1PR14CA0012.namprd14.prod.outlook.com (2603:10b6:408:e3::17)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 01:18:18 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::dd) by BN1PR14CA0012.outlook.office365.com
 (2603:10b6:408:e3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Fri,
 10 Apr 2026 01:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Fri, 10 Apr 2026 01:18:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 18:18:03 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 18:18:02 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 18:18:01 -0700
Date: Thu, 9 Apr 2026 18:18:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jpb@kernel.org>, <praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: Re: [PATCH v4 10/10] iommu/arm-smmu-v3: Allow sharing domain across
 SMMUs
Message-ID: <adhPyEWoK01ZzqgA@Asurada-Nvidia>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <5293b61417f96dd58f25fe797e7d0c20dbe30da8.1773949042.git.nicolinc@nvidia.com>
 <20260410003223.GD3357077@nvidia.com>
 <20260410003624.GE3357077@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260410003624.GE3357077@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: b19a3f24-26f0-421d-69c0-08de969f0c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k3rGT8QKWbdPGi9SwJLvuPwvqirqAdyynsP8g0DoBxLAML0s5DxFRah3eg2zaIs0srF3FxlSg1yI74ONTGM4cS5vRO4mV5MuQIbZtF8ADD+VNyhRIL9eAUUrOeBuc2/leazIaeoetakk3jiFQGlT72pLUHMg9f6Gj0jT6ezRyG/TKQSaiTRUwO8BUtXQE+8/5By0BR7akFE7kHFylTYjuXUp2A9hTb5tHr/7saStDBqE8TicfmmYtYjpBZX4/+Vz086RfrAEUa0C+VfHimWg+zlnf1UW8Z+AMQc0x/9wXo/5RlpxkFYL5t145XHMQAZsGxbXap8zMcSRyGUBE1t0e9REcnt72Q0KoRcJ126cdG5pnMAj2ARwODBx4wj/jKHaHi1/+Aht7Yzd0FG1/MmEBFl78K+oifTIIFc/09D6pFT4HLFzt14XKteKWgcSklbKVsz6zk0K7hQBaP9hw72e8csmk6TvWwd65eGXJKkAEP1TRnLhMS4rKXnpm3ajyb91qlZy7hnpKgPBxt5Zdd5ETic3nhIw9Kfzny2Rj7R3xwLxBGyBCkwTSmdoiwHZ3uV/yxCtRflr07NsewYfZM0UCKQc0a44MUCm+JNeZ5XR7yda14+owcwKPsfma4/GezE/nnxQHWzoWKt/7RzaNp1qzDsLcvZWGt6qyIOmsC4QPswASrFBaqVGTtKK7vIWO/iQLz7HKjm1pwhiy16/OyEO1vLvUQ4T8OsmmfNbZeCEUyCD7hs5SsNsdnJRH0MU+g0I+n44gzvJMSGmxfT8+yAEmQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8Av0hwC7F7M/p9oBBXmrRHMfXwqZ9HrOZPvl2Ik+PeQqwKkM+5Z6S1ixXA6SSGA6Ubc3z2/W2SMTb2pshk+UI0fQaE8tcWAILMool/n2Xf93yDSVvgP51tSW5qX/YPcikNn1jiYL6qPU+tE4zrpDz0vQSEcE21y2fmP9CdEIR8AXf9INb+ZJq9vOe1lffAxLOBQI12jlZcK2ChoEUgLf4VTNOF8ul7viWPALLf7MFwxmUtcTX5D7LENej8HYpZ3H9dfj0IGF2fdkoGEnUJHm33s/TnHhif1hwe72OCFIVweclQAFkB3Mjtcv4xCr8iVASTktW/MgjRjlWTMbRPevua2I6walZb3E5MLN64lpN63LoRdELnc+HlTPiUPHZeK9nbCRokrEtDiOx86FgFZan5WNDL7JlDYtpqDim47aFRIdUtYaoCop81a1ckS4PQDp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 01:18:18.2503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b19a3f24-26f0-421d-69c0-08de969f0c59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

On Thu, Apr 09, 2026 at 09:36:24PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 09, 2026 at 09:32:23PM -0300, Jason Gunthorpe wrote:

> Though something else is missing here, I expected this to be removed too:
> 
> struct arm_smmu_domain {
> 	struct arm_smmu_device		*smmu;

An, I didn't look into that very closely, as I vaguely recall that
we planned another series to clean this up.

> What is left using it?
> 
> static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
> 				     struct device *dev, ioasid_t id,
> 				     struct iommu_domain *old)
> 
> int arm_smmu_set_pasid(struct arm_smmu_master *master,
> 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
> 		       struct arm_smmu_cd *cd, struct iommu_domain *old,
> 		       arm_smmu_make_cd_fn make_cd_fn)
> 
> Thous should use the new helper right? It should work for a S1 domain
> too.

Yes.

> static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
> {
> 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> 
> 	if (smmu_domain->smmu)
> 		arm_smmu_tlb_inv_context(smmu_domain);
> }
> 
> I suspect that is just dead code now, it is from before finalize was
> part of alloc?

It seems so. The invalidation doesn't need smmu_domain->smmu any
way.

I will clean this up in v5.

Thanks
Nicolin
