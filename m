Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5361D63CD
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325768; cv=fail; b=eXhWA+wFFjJtRh7f/RjP0jqD7GKoUfxeKa9d/p6dMWLoVBiVEu/ShEtq+emSk5Mwx+/8vRU3ckmajmBcdPXgQqWzIWBE4XQ02lKaCkDlrtQAA45VaZZphrqPIWLpNRq2oKlu4SDrrmj9V8KU9A1vVH7U0xvBBJKPUhU2SMv59+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325768; c=relaxed/simple;
	bh=p/qZwWcb5L8jHyPZDXHxb8dMeHRBWBtBaChefKK5XX4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0ifQeEXrJpDrngLMu890nuzvBL3Jk28NHz+jeU47ZbnD9NPs/4qeM9+k85QrTRkTkI8RV9bg440D0jiOCHFmBueAeZF9lVIlDHIigevtcG1CJkN1ZiDAOeINGgDYHO3BSuK3eLskgcrbq3ZX7VJxYa1NVinmT814SCx4LTI138=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eKZ1Oz+z; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eKZ1Oz+z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2GUv11uMR1NUP/4yOvjhPybnG975y3Z4+ajeI5H7ztyI+qV3cZ/ru4BzGVFcp1H4fTvQ4SQ6Fs5kpAmGZK7j1f8EiDeGQFeFHisofkglvM7KT6u6ZMYd17ngc37OBkKVWTZQltl7AVB3mbxv9AFCt0PL6Izd197FBXNy87lTHLPVcd5pYx4xxik/3po9I4E8ZcGd74Zi+nULvB5zGnWtRThyUYJVREiyVYZhENk8p90t7VcsmViw4sSyfXwYHsMuu1YlvP6jhraKkp0NnDnJ7KcgYuDAbRObtpe+pzbyHhM1FWpUirb7mPPU2cPOwagS6vHEOAAmzbSEyG8beXDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAiO04wbXaadG4Rc+yr61LUxPYhzaHmSr5jdnNQe6Tk=;
 b=d/bWahBCe+GlYtz2Z22FfHd0yy9mDxkBW4xbfTeh0pYP66mrBvEqPhXOcpABMb1/Xx8+zOmjVSra1RGR5SFMPbnkBTcpMtruGpeyJSbumIxvVDyaK4QQin+T4KRko14n8/+MNHMyzl0iBwVrJqVDH+MzP9WnEatZL9WLbTu0Tnfee4CpJC+ftEtXVZgQMPoh+L5/d1KOqKNQ9aO1ZRrPCojiCmVHHWbmzyVu6o+Ph1rRO7k4DfPm0w6pgo/vy9g3aTVsskgYCQfoK9WfthC1j16CVkr6pFGGksBjOIpHyc+8kIzfXtatMZzy62LQXzJ16txUcqJ3H665i73CHU6LUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAiO04wbXaadG4Rc+yr61LUxPYhzaHmSr5jdnNQe6Tk=;
 b=eKZ1Oz+zIGjGKpGuzDkw2qnzJLcL5N4mg+mLzYwkh+uKlpYAs39XR5JPaDSmYXELoYnSZTQrpu1ZG6pZgtyW0zmFvzSPcSDK1ikM7/YN5T9WMqOZc7VqgnSuv7XuWhsJ6AnVWD3ffG/JE3CSuUTSIUW0MT4BPxzvw/+CQj1GH1GQVIAKI0ZdtkrjwPQYDbLihyYZBdt3FAQRWtp0lpDbhnNPzkwE6O6S+wbuaax/qrPo/TrJfNjMsRC/OllHQ6tQIP+v6SpkoplyaZ0bsQD8AXB/iOgCbgK9l7SGv7Qs0Veo37qCdrRa421MgotDzn81Ce/6i21JTzwLkM7AeCTn/Q==
Received: from CH0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:610:76::14)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 19:22:40 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::b9) by CH0PR04CA0009.outlook.office365.com
 (2603:10b6:610:76::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 19:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 19:22:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 12:22:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 12:22:23 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Mar 2025 12:22:22 -0700
Date: Tue, 18 Mar 2025 12:22:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v9 05/21] iommufd/device: Only add reserved_iova in
 non-pasid path
Message-ID: <Z9nH7VkfjPLjlHNc@Asurada-Nvidia>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-6-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-6-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a85c7a-301c-40f5-85d7-08dd66523fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Op/PWeZXXAgCMi/dDVdm6AhHjnJkMg/mz7hJwAvNyirgg3r1BtHSYnYUASZ7?=
 =?us-ascii?Q?qGUMzjALdD6Q8GLT7He/07hP45u0dPP+gla3kXTZtJkSNbHSSNbLvBg5+A6B?=
 =?us-ascii?Q?H6tpsEPneweX3cW7J17IIiQySlfnKR/Q5M8+K7MddmJ8zXWt2j9yBlpD9F2J?=
 =?us-ascii?Q?1gAfQDLMsjSi79tyl3ZpR96Q4cipbGnnetxME2OpLO6WA/IjjG9mfw5kzwyw?=
 =?us-ascii?Q?AJvn7EJTBeadgxviZdHU7kUfHelO5lzRdiM/431onKeU8iIyGbgLGYp2Ia+t?=
 =?us-ascii?Q?92fMds8pwrriy4RAfKokp9pBCRWaSmdZoclVwWc8maCYm/KniFCz0pc/AyDf?=
 =?us-ascii?Q?/DZHiCR7GHu9mPdwt7OUCRgwHad17KHHrQsHpOwpZ/z+ycwbr928JHukBcWP?=
 =?us-ascii?Q?ZsofwkigAZQKoh3D9SHBnuEZ048iAFI/yD3lVZaqAsHR7BXS4b7fhL429sU7?=
 =?us-ascii?Q?PPrzQ45Hhj8fk8p2O4jVGk8R6UE0xcWv4JENAhKjwZK9zkorDaKgobYZnw1z?=
 =?us-ascii?Q?qs9qgmqWvPh3bELfHKTgAIYx8HdYnOiqPMzA/xWISk/v2jwc32lS7npF3gVM?=
 =?us-ascii?Q?wW1dwmIFZ2t4Q58ictfVzyDaVVmr/Oq6xnc3LUOChCGJSlPucyiPCBP2wdlZ?=
 =?us-ascii?Q?vv4ActMzoNk2HxR8wuUYXL8sBT3/wvgnL8xGn5Gx9noveLmoDfrdLp6qAzkN?=
 =?us-ascii?Q?YqG5ZVOIM9FqPSpA9cte+IZQmmFOboWJNl5VOwCMWxeuovsNze4vrP6ZMCAG?=
 =?us-ascii?Q?304rkUEEzyjifZF3e+GryfPp5J0nhjcbOREMorH1VR9HF45mLmeFKNjyb8sf?=
 =?us-ascii?Q?e+4IEmjr9bP/a2JHbo8d2MHEpDX7FKUmwNrqPitxwObzWi4sOpWjmkx5XSKg?=
 =?us-ascii?Q?oQGn6AUyCwCXXepDTGANiWktdy9GocKv2dhfuEMbWEQ7uHkS5/bqDVJEDBHG?=
 =?us-ascii?Q?srFJqhedhYWAtgzW3iripCJF7GvG41yfVNOdOsDn0884jhcL32m/6Rg9AQPM?=
 =?us-ascii?Q?LpCS2N8hGwW0wcL9KHA/lde8jyBZo5mbQ8IDh857khpAP7XO8CGzOJysTuDZ?=
 =?us-ascii?Q?wua9ZMlZqj0yNi0KhKpPMp1kbv0QY1qBkKGZqgxaoXNd4eKPZAUWtO5cksxb?=
 =?us-ascii?Q?wBeBCGSxHZB9BilB34N9/lB5W4a0rbXCxy2gHovsciGwtQKAqlwTxDUgoCAO?=
 =?us-ascii?Q?HwCj6JJAwggUUdXglmxxI4m6cokjW7q7N9ECa67XsZOYVUqde1F7Dt2D3FRc?=
 =?us-ascii?Q?/yN/mKCB/tcToZRriHpivDycH5JT1xhZHn/vYkU+8P4WnEmViaNP1Iqv/TUL?=
 =?us-ascii?Q?+Q0E79rr7u72wcxkK4Zxormrz2ni84RTwFUFM5q7GwWH1T7yTdTLH7whlt8n?=
 =?us-ascii?Q?vE4uVgnhRD1aTM4mcjXyDB9XN8tQqQJ+u0KRdMqxwl0PWNDhlI2FxQ477dw0?=
 =?us-ascii?Q?PAkZku0p98ckioJYO2L6TEzJme4v0QSvsw7B0pJw3VL7MUHn7weL9U9+ySgt?=
 =?us-ascii?Q?PrrtHHBag8EX2Pc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 19:22:39.9200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a85c7a-301c-40f5-85d7-08dd66523fd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

On Thu, Mar 13, 2025 at 05:35:16AM -0700, Yi Liu wrote:
> As the pasid is passed through the attach/replace/detach helpers, it is
> necessary to ensure only the non-pasid path adds reserved_iova.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
