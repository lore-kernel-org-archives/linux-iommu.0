Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B861E5702
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010499; cv=fail; b=NoTypBoArYthT6ZSgvFSiGA/FFxukfr425CcZgSacf9K9O8NjxygL/DyJCnEOY20TKG/8kn1bvz3M1x+S/NjWUXyZ4ljm9MI7cPZpwXt31YHRE1BM2BbSbK8ssuqQFRLMzHIYX8RRgGYjUGvXy6cukluICilWMTIGhYWIJFF+7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010499; c=relaxed/simple;
	bh=CS1HS8d/n3XaXpkenpX2CZU/qzNY9IhPzdVhzfjAL88=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aq4qyMKBn0v5WtvUfQPx2Y99ji00CY+BEo9/7eyGPiLQNI7YHMOUUIAizvY8Gv3AY3PG+kGtkErehjby8lqvnSkC6+rGBQhUeU1kBmseRZjEd2RFDJ6f2DtXTVp5quvCQAfqLFpG20u5h4FlaG0vPpwsICkBIq7AM0tcLS3Ff68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a5U7wDw3; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a5U7wDw3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4UOJUiEc4HwTqk6WJVND7fLc6ihFA328uamSJaTE7CXpU0Xy9e3FwmxO/iCwtePxwlhrp0N1V2IkS8eUy0sesaqzVQ5AHV3mvZTLAnXtPZLhCTC9kArQW9LH4fept8jAykBWVpRCxvO3tz2fGlm94tDPjbBeOPgNLIs+NYCyL/4V5lOMA6ytzK0qf1dKDt5GgzZb72zbgAujBf6FDdeNMVyY2S3+XlQIMaFrTkmKyryWCHf43RH7GQJqfr75H7jffbAjVL7+p7Kag2YmbP1EF2fl+gyWfAasaF16BKciABwH5MRgnu92BFwfIqn1wp5qXtrMrrDiqFg54zcNJdDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYnyf3C4B6vOOT9QVu10c5COtCFVAPeUcG38E/P6CyA=;
 b=fNK3kzwu2oYZ+hiH3pWEmtsbipmuvbGi/eaaTdROB1yP3s/Pttf06LDTIvC/Dysj2UnXXKd0SCzV4Q1bk68YczChXPds0JNAGEiEILzRM/TalXw0DYk0rYopvGPrh/1u5oae85znLZTxzQ2fq72MnX55hIrGurwq7NSjVv+d13nheMm86IIQO+qAIyUuLXjWrx0D5JkXR1cBXokuL2gQB/tjZA5fQXbFzlOxF32mud95g0ZLGdgiZ1zyVdp5S0vAk/Xlzex22+cwRVGfnQGdomMmM27OxggyQtv/+bEnjKrDXSOy4rKKp5Xw5KWSjjFp8aGUZVmdR1Xr4mAnK9rg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYnyf3C4B6vOOT9QVu10c5COtCFVAPeUcG38E/P6CyA=;
 b=a5U7wDw33/v+IrFKvQLtIPfMXfMFEii/5KHAKVD2UrWjrd9lLl9TFPzik2dv2jtihTMenaawd143Ce8oPYkoGbDiWcZclG/xURfeEu8ha3IYV5TNzvesKUUoRYRZPMcn3cMqEp+MmptAAMM7oPbbYfejlRoGe9brM9SN6LCZV3EioCs+a3QHGmttjMMOBOkei6iJqsUR5gYJJSj0Kl3XT59WFhmjtcGuqyBTal9bp8WKRy+AQjfC7cndJkBpqJQwNkzrI1/r3XB7KGs4LMAzpmhYmwBtY28cz3G97X6JyanpBaxcEKePo45aRCgcAsj5EbUdic+lmwaJCn4hpXLO2g==
Received: from DS7PR05CA0069.namprd05.prod.outlook.com (2603:10b6:8:57::21) by
 SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Thu, 28 May 2026 23:21:32 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::48) by DS7PR05CA0069.outlook.office365.com
 (2603:10b6:8:57::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 23:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 23:21:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 16:21:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 16:21:10 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 16:21:09 -0700
Date: Thu, 28 May 2026 16:21:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 11/11] iommu/arm-smmu-v3: Add KUnit unit tests for
 Runtime PM
Message-ID: <ahjN5I4ObyGMDJAK@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-12-praan@google.com>
 <ahi3HYssUY9mjjbg@Asurada-Nvidia>
 <ahjLeryndiVuTULP@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahjLeryndiVuTULP@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 700b3866-9ff9-4e0b-a084-08debd0fda40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info:
	jDf0rhDASVAgNCYOCva+coPf3F3UDBTMeGKb+o8B+vKP30vFbGt4FQe9wDIsmMphiZttyaYa3p3ceXd3LcvBWNOvJJnTWIjA1weifKQ5fV6FwZxnJExgKniwE+r58wFQQGoOtbYx5kjyNpqMzIUHWUo9ckQ6uvgstNCcl+8WNOjgd2D5zQmt4cez24Noc36Uj+DU+8QJ8DMPyeRRQJ7mqBhoEOU7ZnIZvACRde2C7HSoWGJGCAdCujh5Ea9a6ivt4zfkXQTgHqQITLWpQ1oL8dlYTaeJJHi3pAg46Ovr8cZgpkvRIAvgf0IDcFSFE8J70V1EQtvKdDrBpKzizCBFCbihPwi5iYlkp4bJOjVIY4XpJjgrTgsxoWzyNwdBb7Uf+YvAqV9qJAXvbM2aau8RnfMc6D92WXRrfhzDP3YwXXURx2bpphVq+XuzEW5jPflHfSyExIrkADXT3u15e4V9WYjCDhQkKASL4AeRu5DNsyLiRqiep9VAUGNADX0NoBZIof8agpOEQyRK2+SKGzRO4J91zU1SgEdHDJJnqXukF0qfeh6c8pAZ2EQ7+IcTtdnPEncwkbxLoVgNHihajDv0KhqvODz+Wp4w5y5D9F7470dNC4dTG2HWxp2TaprTKDZuBfATdLUEWJPxRvLLYMvwDIJUJ8EUfXng+MVaTTwUs7QHMKxqUGi43SVfygl7J20Yc2+BKv7nTLEDtC9zp9zi9iesnTabrj4cU+8cAEvmmTk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sDGRJ/3F7DJWE3AC3yXaGJll+h15iJYw/hzLHwtWoZKDmUdondaGPwApI5sjcceBEHTZM8turORdZjbo75PHOgie70gtyJRG8AcIrtx6mwDT4QMhbl2jNvAWhvMTHaCJ28HMdYA+bbBSUvowdnq3n26pFTktGb7LwkLPWRBaKqzEy0OQJwTb56T3hkD7dPt+lTWAH7NwoZDwV+CHVE4Pf9vhqBataaWmdM2qrWBG1g/BHKr+n+N+1s4OWUqM3JSciDrp3PdycGdFGorYg2401rNXe2dm6lZhampZo2Rzptxsw/7w0b1jo51EUjpVxFsdz84wtDHjAvXUK/AzwJWLoCmo1mLnNXfkuJrnAOJ5AASTs7nxzkT+0ZMl0IbZmoK+zGcC36uM3+PEBIBSMdOcvLZRuB2l4XjTNvH2dhiXUTK5cUcUrBSEZ7w9D9kxdwCE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 23:21:31.5794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700b3866-9ff9-4e0b-a084-08debd0fda40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447

On Thu, May 28, 2026 at 11:10:50PM +0000, Pranjal Shrivastava wrote:
> On Thu, May 28, 2026 at 02:43:57PM -0700, Nicolin Chen wrote:
> > On Wed, May 27, 2026 at 10:14:07PM +0000, Pranjal Shrivastava wrote:
> > > Introduce a kunit selftests to verify the Runtime PM elision gating,
> > > post-suspend elisions and progress on resumption under active
> > > invalidation load. Simulate concurrent HW suspension using a timer.
> > > Mock all HW registers and CMDQ buffers by allocating them on RAM.
> > > Make the mock CMDQ self-consuming to avoid hitting queue_full scenarios.
> > > 
> > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > 
> > Maybe I am wrong, yet this reads like an entirely AI-generated code.
> > So, should it have an Assisted-by?
> > 
> 
> Agh, It appears I made an error during the final send and mistakenly
> posted an old WIP version of this patch! I created a patch file before
> committing the final changes. This has remnants of older experiments and 
> lacks severals other cleanups!
> 
> I'm aware of the AI usage guidelines. However, this is not an entirely AI
> generated patch, it's a pre-cleanup snapshot of a WIP version where I had
> multiple rpm tests (an attempt to use kthreads to simulate races) that
> were using shared functions like the mock_cmdq etc. remnants of which 
> are seen in this patch. *FACEPALM*.

It'd be still very nice to have a KUNIT coverage.

Nicolin
