Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20A437EFFE
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432590; cv=fail; b=BzdRc4YtErXSDvssltCR5GoWGY3wEkDwSRsjuLeat7GNt6K3V/sE0KNV5wlmVNqJZc0e8ojWHI0dSQz02JrwHwnQfNluWnQ7Wxm1XYnm4KUFPCgQGCCpNteoDyM7aRRBW4ZmynI8h9T5q/CmLVp4mwKxmDplnoB76DyPvg8tSS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432590; c=relaxed/simple;
	bh=i5TIcQSB24sO/NvuBJ3t+Cl2bQAWSGrZh6W2Mdq6PUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jflSzu2anDTWyYbPIgAGUGLr3gDHSLClXtDVma200vDXRfgvPAmg/O5g85sQjIvDAWPRP5UVsnH6zhhdQoLELui4uehOIR01SwKgoz5Lg0rmZoqpZIG+ndJgzKkRWB44xPa/VzP1rFdB5uyfXOw7vzsuYhg14GJvHl0Lqkop7Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pidIkF4u; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pidIkF4u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bc/+mQyZahlsAY0mVASZjweReoeIWZ/AD7sqC3myRvpZ+k0kejaOJTNH0FuVqPsAzLeDHv3+b0j2XokSPq1RfTop0mL7yb/WEisiBjDg5MP2iBkAiywzsF1v/xVTxdWdujj7QblcVn7bhYOS38ZTDUsJL1BpDs9d1qBcW75fjPDapCsCLzeo3j+Dfl1id3io1n7G8RD4/j9+kYMFBfj+IBq7cqd+/9tW2ABfAaHu07wqBQ/ANJUZXWVY30hGjoSm6nH50HzX6eq2Kumkt23hXZ/dvA/3xVkis+2eq62hVIr7UCXM87kcxkXWogmhlrGlMsJFX2qe4U5g/tQMIxvuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwo2sVCoyVuzGfe4qaOkIZ7uwE18sgXm0cabRw8gQWs=;
 b=eBBXViWBOqzjP6U8SL3zk9SX7CST3RW0KIamWxQmcf9p4B2/ev6LaSwrencBPVuEWGsXC6XK7oJbVWFHh+jn/lI9Je08lAwYD55tyADFHqxh6dtHk+DkZaFhVfQifU9vviL0QxQZ1LoMdyQF9fXwcMzwKtC+lGPlzffIpcTHIYbflGEHErWFWgdm03tU/qFCBmLvuLl/mCkZcoiyDsD5Zhv0N+Ze88dGsQsWPBoOswD53oi8oKLpqW49QnJyMdEwCmfhPJCRJK//wKW0w4NpckKtma8QaR57JWWWb5DRGVqrnkAF1sIVNlQhzHkicKBfVEKXk8GY2pKZhyQkvuocCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwo2sVCoyVuzGfe4qaOkIZ7uwE18sgXm0cabRw8gQWs=;
 b=pidIkF4uaptDOgg7qhdbCYcWU8KpYBZRU2oxF+TNgvU3pMCnSSgZnsgLSm/kBRfGs5/aqQWI/UmW4CbElr6CZdLpRg+DKPxTm0whPnxjRjv6WSs5UTygyjpy1QQBSsDe1XdrEUMt/8qVK2NJgdJFN1QZCt0oNgOrXGePI+/qHwR32J6oYdPl2DHvV5QSitFX0jbBsCOGX6KCnJDQJLnX0qNK7q3JwXLcX9b0Ju+Hp3kAc0TctjNOFeOfydLGjYJb/52z74IK+IPQ0UJkTQ5hC3tK6UxS9x1V0jzrWXKs1Y2rev3Gu4GNjEzFqy5G3wVh9mQpkVdA7VK6OSaB5mmWsA==
Received: from DS2PEPF00004554.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::516) by PH0PR12MB7959.namprd12.prod.outlook.com
 (2603:10b6:510:282::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 20:36:21 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:92f::1002:0:10) by DS2PEPF00004554.outlook.office365.com
 (2603:10b6:f:fc00::516) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 20:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 20:36:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 13:35:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 13:35:53 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Jun 2026 13:35:52 -0700
Date: Tue, 2 Jun 2026 13:35:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Ashish Mhetre <amhetre@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on
 Tegra264
Message-ID: <ah8+pxWXZgXqt7Fi@Asurada-Nvidia>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-4-amhetre@nvidia.com>
 <ah87dzHOOTNGBBmt@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ah87dzHOOTNGBBmt@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbbed54-5cfa-4ece-2e98-08dec0e69b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|13003099007|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	LswSJnmbtFk/TKmrjcG6qy5ZO6+u0TbuAMCLq0jnOrh5wDuAsu8MpqQPke7I+l0PDXhHCqBtKmu567bM3b5VypRbPpdcXm5Tmcs9lynyOFXeVbmtOYmy2p3y6gNXkX+nxh0bDpZHh1E1vysD5poBl/EBpXpZhndkNHUXyqSX7Cp6XgInl1FJF/pn4GUJBJpx7qGrksEkWR2KB3MjfpIlkzIlQhRiGGJroGrnIpwgvOWIjEoHPpD9RVRLpLjKSpfMxAuszvHMBGhP5roXr5hO4TdoGsKaKXTdkqSc/b9CWNHKJJXqMBBfE00rur0eKfyVb3ApxY7yIYK2SCDnB0ifgZDcjFe1vvIX0mcYeaxzIerAm1UYOwF0gV3qkrFhQ0C2JTx4obLQhKTJC3+/fMajFxbiB8bDfVSTaGkpdNm+Y3H9AiczSwna97623ESVfuCehRRDca+xU/iUUeY1tEQWvqVq1qJ6QnhGn3dJtPQDQEyWV+2BUYFvDbYvVPLbW5BiaTrAkkDEE2VnVOShA7iN76F4hgIIgeV+gOIgYqnZy72SmvUi1C1B5K4/bnQ2vNfvaG2tH4BWhNhqqziYmmNbcFeV/XMWtKFNqRy6XTE2T5yPLDJZ5UHg39cDKAmO2zv8Idxbgjs5mpv5mBgWh5sTw/1UjHJvujtHb4Vx3LWTZbq67PXNXCfaZ8zyBdCHoJRfq8OwINw4LIYu0x0D+MtaII/Kug3FpXYqYpQC8ZMYzyM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WNutYPjyVIko+XZ+iVD3LdmTy3ExF3wUFR9CPE906wKXWNpZwspnBzs/pvNIFtAuxSmzWA/lc1iYgPbr2B9vgQcixpz9W6z55IHPwuLjqFItNkEnpjx2jRdhtQUwXGHAkOLGaeMCgLeiiSetQdnkvGDQOwwY0HYs9bW7lMxn+j96ErtIcSvAb0q3q8uJyCsDcdMC3FlB+IPM71uSVCSpSCVZM8QP/DWmehlhSNamAc/HwA1Hu38/9ru7oKfMFTO8L7yYn2FxDOGe7CEDeE53r2N1nHPCmmTU28suOiYeiOOCfQZuXnDNfqrC4Ws+OngXirBPU5/tfWXtuOg29TmyCnIk8dUsvH8GKkawqrxqgXaSAr/4cAsIVwnWItxF/xsQ8JlIi6pNEbyDRX3VgvX1R6/OD0B3eBE/u3UacvFd+tOWNpHyEdUb1gly3JV53Hvu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:36:21.3891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbbed54-5cfa-4ece-2e98-08dec0e69b61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

On Tue, Jun 02, 2026 at 09:22:15PM +0100, Will Deacon wrote:
> On Mon, Jun 01, 2026 at 10:48:45AM +0000, Ashish Mhetre wrote:
> > @@ -382,7 +402,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
> >  
> >  		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
> >  		cur++;
> > -		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
> > +		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1 &&
> > +		    arm_vsmmu_can_batch_cmd(smmu, last, cur))
> >  			continue;
> 
> FYI: Sashiko is unhappy with the existing code here, so somebody should
> check that out:
> 
> https://sashiko.dev/#/patchset/20260601104845.995005-2-amhetre@nvidia.com

Ack. I will submit a separate patch to address this.

Nicolin
