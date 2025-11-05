Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862E33EAF8
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371890; cv=fail; b=sPUWBAfaZT0u9pS1y/OQnhSQsfhxq2VIaEKi+j+k+axKoKQ3pyZ4pSrTSSgziROgKggcgPYHkf76jLmwHLBXiAEdn+6filKWh3q5P6/XXdJRyQMfukC7Pv3hbHpMS3tHcWWaqt4dUlC6fDV0s8dYlChBruerd2Ktd9Ewo/B2e1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371890; c=relaxed/simple;
	bh=hUP1rYFzhvgmxZkYTOq6F6ywnUBtfc5JyIgRyDVeJ5k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f25SM+6KgRDffMWhzlu94e0V9eClGPub2MliOIb3qOV/7+3TGsC2U8Z6GkEAvXUSobtMNUOP3LbR25NcESlJiMt6ek0QQXVYyKPylGK7cBc8/C3qeGM1noQVkeyA35Ol98ab23Y5E/Jj2wlJ47g7Z/7ZjvcWTs+yh7HAF8U4fxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=urigDqYL; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="urigDqYL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owY/U5cT5rdUcBOVq5sIFQXdFrZnJXcEoPB+pfxNC33h9rsA2pP48/czl1MljgIjXOq+jkF90SZbKP0e9hIFA3CzJIEvlPMBuyIKHbeWYHFkpMrJdeWreog8hEWt0r2yePhiefLDANbNPTE2IkHZrOERjcuRmb53Y7NoORhLrgv74Ztctt0GZaxW+94RFK41FE5xwieQqnnXvmUkUFkHfxf88IOODT9yNbDiIZm6aLi2xmzYxcIVbiiR/L/K+P3FoBPvjiQ6vV7owhuNWQ1WRiirXYWf2TeLG9VNTKasK0TsKiGEG0+FSPjyqYWjGNqnyJS3hIxhtTrYPoIeHku+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YusUNB4qy8SaLqyJ0KnIW2zR3/mr6UlqnzGtt9sAYH0=;
 b=tFefNKPPkaM6tq3gnVVaUldISyi/36cxg81sK7VXgo0HG2S7vsDWZZ1uP3mCd4sqT9L9UroBd8vcZl3jnt1t3VnvN7ECoUqWniqGeTAoPiLJ/lrvL97CwBpySta6T2xhZiCFI8aMQ9oH/AN2wPOU1CzqGzdoWo6wwRW8J79szS9u5Ee1cbB37idr1yLv2b4ln4icA9sKD4YQGkHReNvNBlUehEptvll8yKrDud9Mp3Qck8H3m29igN00f3sEI0uRQ/erllnR7outmxjvId3ruv2Cy/NQ/aLTIfjJmVpFPyOMwM/XCcJ+3pXkUrdV2MkB4fT722aspmqbqWLk4vEo7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YusUNB4qy8SaLqyJ0KnIW2zR3/mr6UlqnzGtt9sAYH0=;
 b=urigDqYLs353ePqprYBbenSPKszu3Rjwe6TUrqE+keSndpoQqfeVOWDxStIYc1H+M8ttGNs6o6F+8TipsvvwFfwDZwn7yHTyEzf1r2nXuRlujwm6bXwNzY/I44ahka5Iaby6PITr/voryKcbJSjHEqFU0LrkMjomNusphoEKVxuMOuiQG/0DsSbxbT3wbDAZEIkVNNBWWY333cCqRBYc12M1UUAFKyc4bYsOJmqcN9dVVj25XdW9gS5FsMUArRQ8nv75S6kFhUaCJCdqd2EcveJIGJGnzmGbfD68aGxjbvGkGdIcVhsJAY7dqXM6Tiv97nsx8/BEf+R+9OwELv037g==
Received: from SA1P222CA0142.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::24)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 19:44:43 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::77) by SA1P222CA0142.outlook.office365.com
 (2603:10b6:806:3c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 19:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 19:44:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 11:44:27 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 11:44:27 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 11:44:26 -0800
Date: Wed, 5 Nov 2025 11:44:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
	<zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
	<jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <aQupGR8QsS2h7xY/@Asurada-Nvidia>
References: <20251105190638.23172-1-jacob.pan@linux.microsoft.com>
 <20251105190638.23172-2-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251105190638.23172-2-jacob.pan@linux.microsoft.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e124a88-e922-40b6-2657-08de1ca3c43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y0hU+0pUIJi4nTc5HFifqhAyoPj7NpRYAP1+Wg3FhidhQJNR9wpCIihyfvtM?=
 =?us-ascii?Q?Y8HwZN6YhZ/9NrQMBCqvxU6LjuGTjIPd/K4Vpk+19X33lWNjj5mlmTkD7+rs?=
 =?us-ascii?Q?26ss1K6oi7dYSKFanzfjGZtUajjBZtuEUrOYgYrLdS47ySWWJ14cmpjtSA6t?=
 =?us-ascii?Q?HF4iOlX9fEFpn1s/vMwBGjWMibC0TI/Gw37D24BvX4QAHL4m1aZO28qV29Kv?=
 =?us-ascii?Q?5Jpn2/I5lV9MElU6hsDFQX0PLCNQIrkAg72lPsjB9EXAy+5oX3sz4VQzuXcK?=
 =?us-ascii?Q?uIzXtxRLyGVY6iQUEkqYIl1yfkEe+UQyVDMDeP3YTmk7uenTKgsQql7mAE+w?=
 =?us-ascii?Q?Tn34w25RIkYGAeyPQQ/bAddUOpOCTZqDFY+FHa09T59eRx3savmDDr1GbIJp?=
 =?us-ascii?Q?+41D8aJAnwdBF/RlNTPrbZxYf188JDaAKz92JsTIWQvRhb71ohS8VREnyCO7?=
 =?us-ascii?Q?2ckSyVa1SPxqEPBGczzt5oU5GxYy2pCWaPmr8b0gK6KHrJ+Od16cDKHEXrol?=
 =?us-ascii?Q?YeE3ssKwq0CDkU4ufzUK4YSWc8uOSreTHzoOoTuIU03WPYUTebyYwT1G3r5d?=
 =?us-ascii?Q?4/0RDoAs8KF0ws3oSvRr2fwRo93iQ3kRDxjHMGJPyZwqGTmJks1/DeDXLXuF?=
 =?us-ascii?Q?plLMC5mk/lJOtnAEf4q9/YUrAmHyvzug3JvSIqfcKFCrjzQrv/UKH30xtO8L?=
 =?us-ascii?Q?zYK3mKrgCmBuWGYng7BtxWgDnZZKRURYLAHzC7R6QihYKtGvdMiPRu+rUFXz?=
 =?us-ascii?Q?8dmvfQ3wLnpQoXQjR9YTum4uFZt+mCMwBFccCz/iwt+3XgLeQnlp5hSThuO3?=
 =?us-ascii?Q?WVBSVIZ9778VoGhabTRzHKNa2Aci7oqM0pJMPYAt1uE8GnG+MyorzuHNxHtQ?=
 =?us-ascii?Q?A5txjt3JX3byfStzhfe5oTouW+eup2BwdBHCuwK/a1MRdIKggDYWMVUv61+a?=
 =?us-ascii?Q?nBHYNLsmFtvKuptQ7WeA9v5zMrwR+btaukVf8I88GyqqKAoA638qZfqyl9rP?=
 =?us-ascii?Q?74FfMINGnfTcrNRwGNxjN4cN5mxWyKnsR1dO9CZBSPs2R5O8LLKlsOsUGlov?=
 =?us-ascii?Q?evpW73ZJ7InFXMxynAllSEXIVHPSCigk5d9pZoc6onh/9lK1oWVnJpTGl7WJ?=
 =?us-ascii?Q?QswEUk+sifimpfkiSTi2wyebShH+o9dCFrB6ex1ISFhDoN6JwfGNXuoV9NnV?=
 =?us-ascii?Q?zrOllXjfFTcKyDUJ/g+PN6fM3ga01PfC2qNVVndCnxFKRU5LZ9ilmHJCZPa6?=
 =?us-ascii?Q?xlSqJtszVyZE5OOCiKy3x782lOGLq4h/jJpH0PoEFNRdFzUxgttxWGGdxB3U?=
 =?us-ascii?Q?GQgh2ySC9hgqkCKhn8BvNVus7FFD2zpjG5ub1PiTcO0aIEWdtf61ppM594SN?=
 =?us-ascii?Q?+agrEtD2FVL2AP580afDP70ex9xN2MrVXG4UaMrPnmCY87koFwJ5StXBozcZ?=
 =?us-ascii?Q?5FRfcBezMi3DC8n444tXa9Nl4ZS1eb/9k7K2skxsc8w/ev27xtBw2De6lTi9?=
 =?us-ascii?Q?zb9CS4Upp2FlrbT0xYCZEJw+2KHtqOyq0cdtbWO+C1MqlzfmV+74DRISnnRk?=
 =?us-ascii?Q?7beBq5xcePWab7qEIQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:44:42.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e124a88-e922-40b6-2657-08de1ca3c43b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874

On Wed, Nov 05, 2025 at 11:06:37AM -0800, Jacob Pan wrote:
> +	ret = queue_poll(qp);
> +	if (ret == -ETIMEDOUT) {
> +		dev_err_ratelimited(smmu->dev, "CMDQ timed out, cons: %08x, prod: 0x%08x\n",
> +				    llq->cons, llq->prod);
> +		/* Restart the timer */
> +		queue_poll_init(smmu, qp);
> +	} else if (ret) {
> +		dev_err_ratelimited(smmu->dev, "CMDQ poll error %d\n", ret);

I don't think you need this "if (ret)", as queue_poll() returns
either 0 or -ETIMEOUT. And the patch that I shared with you has
this noted clearly.

The other caller arm_smmu_cmdq_poll_until_sync() treats the ret
simply as -ETIMEOUT as well. So, let's just keep it in this way.

Nicolin
