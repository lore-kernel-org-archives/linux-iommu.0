Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013033.outbound.protection.outlook.com [40.93.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3031B108
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842622; cv=fail; b=k00SsHlF6mQb5oVBSyz4KTaw8tALLFwp2UT02YuLg9md4KXQqv60XWWIvsK4lPXkFd6MHgSIp6o/Ob4MnP2YsPtiNOsNJ7DH8a0Clj1pjAk0oZFLIKD44ad6oZ53IHOJfmInwLDNtLTAtoc2VHSW/QvzkYS77bpx0SKXjVGQ0CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842622; c=relaxed/simple;
	bh=obH87sfjZkm2DqPEzbqdoP/jvOymCGJR19My6gLz688=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL6D2cxvfzwLJwQYus9HdW9QeXv7kv+4qsKhhurOexkF0LV1Oon99oWEC2AZK2ZCUcm7N5b0RlH3AEPVMLr3zNahSguTT1xAOQjcKg+fK+4nBpxkyqmkOscfvxyzMrnx1QDDzrarJJ0YOjeulmESmL4QSbGyoS17r/aBsZnyd2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qqKQ2f2+; arc=fail smtp.client-ip=40.93.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qqKQ2f2+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcKqaH7aNnSo2aymeD8V0LLW74uX2dRy2wTT63khH85uhyufCphoWk4Ukw6xfyMpkejZWFJ5E3U2hRL/SXcdAvddCMNjxgd3kKcGou5VT7wqf9YNl77jm1baUgBGGNpfxDLs3KD0iMKiSMYrRA0S5JKAPnAo3+CZDThV+/sBmWw/FfxLefhGHV0/j9KPX1Oby3bJxtcf3sZzjr9Bx+MrXTEMK2AgEIzAI81L7SDn/TrbT91PuUnnFFiBhIzl/aTsEuc6tyHBdkN3SDsAoxge836b7SXEJ343AQi7dz11QQJqQxSs/6eir7BpP8aN5fqpqvQHMyxsTGMnSumAnZxqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmQPVsT5SG6YdxM2nLCXuR9GnJGCKabihjgrJ6UknG0=;
 b=MORa+JfV5RMBe68kxrv12w/R9LGwD13GjKTYI4MJoLtm9Pr9IqQnlB5KWsQd2/5A+VjQSKdJmi86NMQhbar7iP0tVQl7BSns7JfsLEOhwWYSmMg8QYsWZQqdfMmFW5++mghr86i/p7RtFLv71fBlfbCPfSBbdggJlx0yOaoLLzj1cMeaVhU8udMfig9THgufsCkHWbmnfsYA1QyS6A0K8BPb0V61pTqxbSvINcVnswgs9p9AC2sqlkL8WWLgWutmUDOsrtLJyjdVjnsymt6C+WLKC8EgqYwT8H+hbtZVThfIWScdRS38ea9fbqZ+iDiE+cL/CbvN1z397biDAC1ICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmQPVsT5SG6YdxM2nLCXuR9GnJGCKabihjgrJ6UknG0=;
 b=qqKQ2f2+rHyHD3orPlGP4voasOFxnnh5K/gQcnDfx1UE1KXMXDSn12KOwLUSfL48KvhHNeA2+t5mBg7w7tdPoWly9Ebzj/wFBa8R8kJSIEwrXpgtNB3vg/saWXCTtdzka2G6nfWu4Cqkr0LrGXjWbM/L/hebE6LJYth4nSoCDALihX2o8VWtByEsVT8OeSORjq8yZ4Po8t7R21SSw64qd8kZ2LN2W0xi6vX/o6t2AcpMW0ezW26hv2v52WNrUenjDbK+G+Ryf+Evlc2WQdk3xs5lSreMcvHiQEOXDH+1X7RaIIprVpSoBeQdv0QeoRrHXgC20bYcJzzfPbewCaqSXA==
Received: from DS7P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::26) by
 DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.6; Mon, 19 Jan 2026 17:10:17 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::90) by DS7P220CA0032.outlook.office365.com
 (2603:10b6:8:223::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 17:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 17:10:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 09:10:05 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 09:10:04 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 09:10:04 -0800
Date: Mon, 19 Jan 2026 09:10:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 0/7] iommu/arm-smmu-v3: Introduce an RCU-protected
 invalidation array
Message-ID: <aW5lavfm2mr8GsMb@Asurada-Nvidia>
References: <cover.1766174731.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1766174731.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdf212a-6f10-4fb9-8cfe-08de577d9e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|30052699003|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6kdPyirWAEKM+AqboswFwutbWN7uUTCyPlxPJr+KvPwTqjsLk4R37eVptO9?=
 =?us-ascii?Q?XnL5LZ2Wo/jjfIlcCVt5iVE7vobMMjHnJYYwOSzL7HP2h2oK7NeiebiZ+p+U?=
 =?us-ascii?Q?xwCMrdQoFxpiAD4og04zAcCV3AS/tn0s4j4Ji5p24gKnQWbnk6pjn3dVCErE?=
 =?us-ascii?Q?LAYS+xhYbfpQYCLe6HlLD/aOPp48G9S1v6o5ZFUHnEA0lu962vb8cZaJkONt?=
 =?us-ascii?Q?Pf0Q08jxjEGDbQmEoDIwJzMmwh/74n2tCvsxgt5Uu/pdd+DJIaX5weDm7oP3?=
 =?us-ascii?Q?F0Tm0ErrMaOjJWDOZqxrqTb9ABIyauXDbEq+hDiAvig+eYwsa6aZ0VSeOSUe?=
 =?us-ascii?Q?h3Lb09vlKdR3GWSHSFsjXYCGO9FJNWYxjRSVj7ZthwQy5IpVgX2X6oVfcQrM?=
 =?us-ascii?Q?MQMhSUiMXGFTBRv3OXD8FudJVb2JSuwAZS0xMH3cOA71VxBOnt7jSKdNFdZR?=
 =?us-ascii?Q?ueCkHB6JHf5bGQiVZQXT+3iJCRN+nty0R1qeCoQ9cxWtaD5raxbYYTapwxYf?=
 =?us-ascii?Q?tTy33HVwn5et3cMw8RFQQ663D04L5az+Zznnkw9tFQt/7NjMLdO2odvvxtiK?=
 =?us-ascii?Q?2ppy0Dof8wtlXEDXHRRQqPmdZhk4RRjyf1vuPuRyKMmdxoCmYsmGxqbBldNb?=
 =?us-ascii?Q?Ka9IhxlktY3QI8O1JwQw1Reux1t+C/Y+N85ebbYIUaLwWFbKaFWokz5bvSTy?=
 =?us-ascii?Q?CBXR99OqKRmCWQQv7ScgKuWYuk0WdYpHlfAsMXmRlWACYRF3h/mlld/eXocP?=
 =?us-ascii?Q?iu4iRlpo/evLG2RtvzQ4kEufu1mImgcGFXzpg+o11m5JXlqRoeeZBDv4m9/v?=
 =?us-ascii?Q?pQ4GgLyG1aje58HtdogYWhbBdRKj1RvnMl4sQc8e6krr5dhQ2qe0+UnyWYYc?=
 =?us-ascii?Q?QdXIT2hIkbnqunKLeslgFgnf1ufgGMqjiXaKLWC5BCsebSE2Vxu2yBVtB3Ut?=
 =?us-ascii?Q?2qrppedZTEixQC+BGi9/ftqG3a5SkHnEcu2gzpaGyiKFgEYe+mhS1UTAchXk?=
 =?us-ascii?Q?5HMzIxQSMIZoJiVwW/MV9AOLataj4RPTX0hMSoiCs/bg8SJWadAqsryCy5LW?=
 =?us-ascii?Q?Q1jRfFQAUm+r9Qf1OGKfykyNzdNQ4TfqebQXrSEEcMDmRunNDIcFrLrOxTQv?=
 =?us-ascii?Q?1KLHp0s4p4w5HhnOfcsyYAyubgKs2m4WjwxEWOEgDAvIbFVo6E8CRnJ43rv9?=
 =?us-ascii?Q?BKUEdlbTrnBGDJomnk49phm1yaIj3zpI+0MX4L+tFBL3ZSeeSWwufWwPBRWC?=
 =?us-ascii?Q?BlGyeiW7YVOk75wiG5BmogFn9gSB4v2G/YVqpTtx0wbHCbPlm/ggWwK5trY6?=
 =?us-ascii?Q?58+8IfxKuT69EEVekFMikKHy2xl9PluaAC4hlEGPj5SHd/lt7ZMBiT49QR4V?=
 =?us-ascii?Q?HmJzEiaNLMoi0hZ9gFwLvTFqksL6bUS/Tp/AzWwVHZlV8uYxuiJOkkm6Jg+Q?=
 =?us-ascii?Q?Jxp0SHEBoiFUqZF1asBJI1eFWWqjr3NamuB/LMa2k2DHnUnQI/UAVUoxEpRz?=
 =?us-ascii?Q?zyhVo2IXvS2jsH1pBl+XjDduSMC0ulQUEBw1TbxRgETcGEEr4+M73nm60Fbo?=
 =?us-ascii?Q?xl0HW5oW5o1iQ1WpWpIOLWNyYjxc9r4B8KhjnhyyKrqWb6B1HtLXPuUQtvQn?=
 =?us-ascii?Q?Mot62A1scmE04Dw7Torh2MtOq/ZVMpJsSlrbxBbE/+4+re0ukxRI8ZCdZvH+?=
 =?us-ascii?Q?JtlyDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(30052699003)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:10:17.3647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdf212a-6f10-4fb9-8cfe-08de577d9e82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365

Hi Will,

On Fri, Dec 19, 2025 at 12:11:22PM -0800, Nicolin Chen wrote:
>  * NVIDIA is building systems with > 10 SMMU instances where > 8 are being
>    used concurrently in a single VM. So having 8 copies of an identical S2
>    page table is not efficient. Instead, all vSMMU instances should check
>    compatibility on a shared S2 iopt, to eliminate 7 copies.
> 
>    Previous attempt based on the list/spinlock design:
>      iommu/arm-smmu-v3: Allocate vmid per vsmmu instead of s2_parent
>      https://lore.kernel.org/all/cover.1744692494.git.nicolinc@nvidia.com/
>    now can adopt this invs array, avoiding adding complex lists/locks.
> 
>  * The guest support for BTM requires temporarily invalidating two ASIDs
>    for a single instance. When it renumbers ASIDs this can now be done via
>    the invs array.
> 
>  * SVA with multiple devices being used by a single process (NVIDIA today
>    has 4-8) sequentially iterates the invalidations through all instances.
>    This ignores the HW concurrency available in each instance. It would be
>    nice to not spin on each sync but go forward and issue batches to other
>    instances also. Reducing to a single SVA domain shared across instances
>    is required to look at this.
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v9
> 
> Changelog
> v9:
>  * Set cur->ssid correctly in arm_smmu_master_build_inv()
>  * Add comments for INV_TYPE_S1_ASID in arm_smmu_master_build_inv()

Sorry for a gentle push. This has been sitting here for a while.
And we are at rc6. Any chance that it can make it to this cycle?

We have a dependent series that I am about to send v2:
https://lore.kernel.org/linux-iommu/cover.1766088962.git.nicolinc@nvidia.com/

Anything that you think I should improve, please let me know.

Thanks!
Nicolin
