Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792514991;
	b=Gk7Hd6uTHJM5REUOXEpxrf7I8hJddhVPcIF67UV6jsVJzxOSkp9YNxG8aPnslVqF093x
	 +DMYvJI5/9H2Vd9XAcMf1D4Ez/ue8e89gdIp1iNYyG6bM0K3tciHR6q/I1clHTFmAulmL
	 3NcVrUn72E5g69+QnHzeVB/6RIta+EdyUhsEsToXGolDSxAd9OyhMUF9EFer5voex+rL9
	 BS7Cj8A0Au4MUI+gR8JPUHIULfv5OfrsA4lhxN2zaesZ9vKMxTOsYtPyw0EzD/4lIvN7m
	 WRdl60n2VfpZD33zTleDGCDiMdP2M+fQs+kzegT/NOoAsCTDTfR2Je/NLaBin8svqHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514991;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=3TEqumpFgdz+Eh/7mNnSZRkNd/JC86au+svrPRCsCsA=;
	b=gEweCxlCIrfNDqQvglH0IbZ9pNNwFweh1HyW5I2TMAX+NhGHSpxbl7+7KPmaGa+kAhYw
	 Pg5vFURwWqZST8NQUq8LvnAl866/bdDj78TMOVnVt9kMvgVgVKgnSnsGeOGPTEZgxPtLM
	 eu0dNe3dJI/+ECoKfVrThgPWQWj+D3V2BjevOoF0Xst2fGC3VAWdziWoYEXvzLR+4ZUHh
	 lYI+Md0cTBYpRh9jCZFDHxxTPBzxEJT2XMVC/3WQOm7X5DeSK32o7RvKwEWZUJ6ZmOrTp
	 uJ2kudzOUk8KZolfjdUCNuipwuscum5peqeKPTUbYFdmdyS/Fyj57hccjehz3xFMYMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="C+/Hw3I7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.15
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E40606A319
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 16:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E40606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C+/Hw3I7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4gSxtHRL945aBnYja4BYNBfIBHXr1z9ymkhjhn0kCUrU6w2HtnCdPldUqQHt1dDQNUWQ6JLAu0fk3mqfAeuhqnR1i35Inmg/MjQgSR703jD8Oi3XQIE9rLEYKX49btNX9gikueqYjFbtljHexGKFD6KJT5xXT/1tfJXqSI0cLbItCbEEQf6+9/n66D/eLNdS06VNLQEn6iTL4sidpeFAWmlZ2agwcaE1PjjFvMe7td+yXFUXIKwKo2GFr7RCtS8TKannAM6oJhoNTkr9cyN+S+CsOnRdcyqjt8HjhX0Xd+pKvntO0/Yev03+A9CkQauwD6W9iXaq2GjZi687shNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TEqumpFgdz+Eh/7mNnSZRkNd/JC86au+svrPRCsCsA=;
 b=EPffdbwFFPeaQqORe5jFlx3hC4voCWeOPUFynb+5nYe7DGjOlY32ch+2QKxiSAqVUr6v9jVJnCEECKudVWipvK2AwJ+6Vq2CgsxllxZtzzQ5eo8jGn/NOvpIreN2ThCYLY1aDFwOg0J0q3E360vcHd2dxKuzOGA0Q/tPBKR+EHKsep3ghgbsYKMXxG18/h/AhbrCtZ7TA85y+YMijJRek1mARehgrZ0EAblXxKc7It07QSWPuTY3Bv9ZHTA+0UyrTT5AZXOeGrUmhuqvBmrPrsOewHhEq/jW/MVi1UpUhbuJziceCwCUjUMgVYGMCBFWL4vaIp9u9ltneTEBX/Ul9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TEqumpFgdz+Eh/7mNnSZRkNd/JC86au+svrPRCsCsA=;
 b=C+/Hw3I7d5G6vjBhW5GMQhC4Z41ZBR3RJ9XyZHA84pa9k9XeLKZSMQU75rT+Xs38a73K5OvHGIP6ib4tssHMcqKdO5JehYktx5ea+QA9OPHTMLeEtIvDyPChrhJ25XTabP359ERq09vQBHD3HldCg08bCt3AYTuD2gc6rYPLhJocztXDl/5ThjYY1620Ii5v6Jt7dQ9sgAtFVYNR8wWUY9AcO85UJnM/GGQ2eGwjEm2qXwcqkt6WvNedQ8xxqUFN5npzX+WRvxkW6gFu8KOtwjkds4Woic+SUg08AuQAXqeTXigfnNYSCpnMkJll0BL6y05ewkiac4ZNMwNgJBQZqQ==
Received: from DS7P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::7) by
 DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.18; Tue, 20 Oct 2026 16:49:42 +0000
Received: from DM3PEPF000265BD.namprd04.prod.outlook.com
 (2603:10b6:8:25c:cafe::89) by DS7P221CA0017.outlook.office365.com
 (2603:10b6:8:25c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 16:49:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM3PEPF000265BD.mail.protection.outlook.com (10.167.23.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 16:49:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 09:49:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:49:28 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 20 Oct 2026 09:49:27 -0700
Date: Tue, 20 Oct 2026 09:49:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 04/11] iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for
 the event queue
Message-ID: <ateblZuS2lI5t1R1@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <250a57bbdd232bbb1e3511b7768a1c9ae3d204e6.1791226953.git.nicolinc@nvidia.com>
 <atdNpl732M7D4dXz@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atdNpl732M7D4dXz@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BD:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 603f99af-1a52-4c4f-2e4d-08df2eca235f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|23010399003|82310400026|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mXVEzkYZM+LU974MB/d34dUIerFaMkPY5m8iVIDcPm/pCu/xV/WBVlPkZvhHEdS1BJ2+crnfJzWPAoxX4iVSAYKYUgfOWEkpjjGnLEEewPljBa/kkE9I2fcslf9I2DJx/2WYa+GvzhOMaa9XYiwfSHP8SlQernliqmlWK1xr3HYzvOpiTYwGHFVb7351W4xfXtMiuV090cpqtNiIg7XElTmS0O9IsnIwItdQGRiwi/+lNBhELgqkOCsJ1KJOhDIJK09x0bdXBdrtBllgzJLBQVXXqcbCuw6TkqrphrkPA1N+o2GHL/pduAM8KktI2IS/fA9ED52xy0dK+KYpt0+ie1aM/qOlbshNO+PnoBhisKQHkO9QuIP7A8bxQUA5Ww1WCf3cGku/LOynGOblvsVXz+wRpynJQ/35PqbrCEMLXjwdx8SC2Uumcuqbvj2mvWKn3rBtWQfShWMb30u8i/y9zBeotIPZ3qk9gLsnhufSF5Psmdr3BCEa6LwkyPRKJrNRcQ3dRGBCyh5q4lFLtZDJj/BzXNj3m+MxBS+OAKerLF6vgeB1YKiZ4nzY1GZKqRHQEHsFLPgyBmDOLxz4g/uMK6k0t//qAXzZPTeP2xiCAxcYOL6mmDyYh0NNJIAhANWMSYlXAJtXo26+jL7k9NLHPsgcDaonb8A+O/KtX1/zdJ9eUH0nZsFh4u+ApqlV5LF5hb43BaFpkZ0j79Q26j5GQw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(23010399003)(82310400026)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aJ2WhnSAdtVr/hqhpCymd03KN21NWpkB+0cYj2aTnSI4zO7X13DAeka/EEhfqvtXSleovpcn7eWYMUIItDL/f4fUPgyLXorpkwjuOtBAxZl4e5xiRDGgNnjqHHPr7JAxVrcX319QqK0WqRKrjcHb8oL7g5peXQ9MlN9vLGu+11Og6SXSTCMB5PVKdQ9j9MTY4y745sq1Ob2r38/wunNC+VbFBOh05sxib9l7RU5GMjnAIt910T6c/SWyE9xg0MzbyaAYrOzBb3GCUPG95szKSxelwvVRPhwqQgt9UAd5ST+jf8COUQUakCSuZei5GuuO2zE2QFy5KnzPia+xDNncmEUtO+11VJ+AeGYqocHPlQEtdZQiGp2+4ndBLXlyc/jYk7/RC/ICg9a2Mx6TLGy1smRluxNZP1X2m+92tx4WgsKEGToGZL+P8/foBDCcKctL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:49:42.0224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 603f99af-1a52-4c4f-2e4d-08df2eca235f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560

On Tue, Oct 20, 2026 at 11:16:54AM +0000, Mostafa Saleh wrote:
> On Mon, Oct 05, 2026 at 12:30:47PM -0700, Nicolin Chen wrote:
> > @@ -4950,7 +4959,15 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
> >  
> >  	/* Clear the MSI address regs */
> >  	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
> > -	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
> > +
> > +	/* PRIQ's vector needs EVTQ's to be kept */
> > +	WARN_ON_ONCE(!(smmu->features & ARM_SMMU_FEAT_EVTQ) &&
> > +		     (smmu->features & ARM_SMMU_FEAT_PRI));
> > +
> 
> I can't see how we can end up in this case, I’d suggest dropping it
> if I am not missing something.

This will be gone, as the prior patch is reworked following Jason's
suggestion.

Thanks
Nicolin
