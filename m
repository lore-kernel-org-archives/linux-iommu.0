Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A171A4879
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534070; cv=fail; b=CH2D/YhmW92KYbhCCR+vLqeSNUbva+2T5zSkptuwx3iiGrCd9MdEKdYMOpcmH0aljy3JkDJBFBenaWGj2atdVvkA28x5boBIZ+wVnrQ8yrWkBWlaHKklNoz12QQ6vqY5gDW/Ku9MX9TmZHZPg//vSnC5JO9wm2ame8hnnyxeoo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534070; c=relaxed/simple;
	bh=nSIJn8FM51NXy4cHwjlYIRATCHnwS54vNiQ8BPgJIYs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfS0IjAyaIdvIviUnuspTdfWlhB5WKatPKU+7Sl0xSF4jghG/kMJJWrrv53aUYOMjj5Uu6XD4qBfShEohVzrA7hXuTzMj30IDlHUd4JcKEMSTMZNYiWbp0zKc31YzhP0A8i+3PBfhjVZPfkHXmkpPHL3OQWDUzszoLimIIJ17nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jHUzeEGX; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jHUzeEGX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmlPUqHNWs+ZSkBfMjetxFv0gRTVOhAYYZImhPdahiZn2857d53Jd3SH7DJ+jCGsCz/LmPt6bJxT5ta3Ui0PnyzwQEi8p9fynsBKVTgMymsKG4I43KACETRxXKTxoMx7ArIKcM5k/V/BrJEOJQ+G0NIwEz+gr045phQK3ZLbV3MKpNz00alKiyQT6Yziwf3hreeopvEcEeyzsB62+IJBC1X58j0ZAUqVbgVmyQmn9AN11qo8qvj0WyC1HDQ88BYYOduAuGZFpxcPIRKxi7zrAngwi1ZaifXNtBtSSyoZDvX2NXuO7QWPn228PnieHKnPlU70LcECqyZFIMk7Kbj30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW62whnZINl6QE+VYQo7gaasCEWL3AfsZtZhL0jYM9U=;
 b=nyl1gRse7k4ZdlyHTB8tdE9lowOCYVxUxYJnEsu4NZCoDf+6EcZ4yzEG3qUmq8zMTqf9i7aAujDJU0/838B6m3c/0OsjwQUBK8G6AeayZ2jhQqnAIFB4M1fbAUXGo1ifQ8Wi6mnqjO51o3+n08lW7y/ces/F/taO8zkS6FwKJatNohZOpnJCOWBNDOllIf7IvRmoc60kGuDuOTBbYCueWryMVja5Tq82PpVrgWhkxbzRvkyTS8DxKE1yNcyp5X9s4W4hN0j6WfnzZnoTDkZvLfWpr0sh7kSnY8n3Kpxq8cyPpayfIC2lG+ajHTO/zromdoHLVVfoLojN9Ua9D6eLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW62whnZINl6QE+VYQo7gaasCEWL3AfsZtZhL0jYM9U=;
 b=jHUzeEGXRZ9Q6ekQMQpocg7+6GtUIDiI/pHbuGXYdAJRbqi5tBSG0rspF8XBwIGEVWPl40CeD3PLxnt4GQ3WnhU3UqA5YnETpgiYMQN+Uw/1h2svM4CsAnFp5cDS+fG/KdAitjwu61Lok0XrUxJkJdydaoXE7wgfpKEEFB1O/mAqx4/oJPgjya9W5+/kpwixTbGZAh67+hao06lLrjgVtyUl2n2dvTaifBLuV6CjBF8k8nL5XA+JgUXIoPOwvDXiXQZ7QH98XU2AsqRb3aFrOL6XgBosqlZrMEAnDMIlCtjpbvIiE4ei8liVbCJyj80Bf7ywt71cCg3ZUC4iwLAU0Q==
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Thu, 1 Aug
 2024 17:41:04 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::27) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Thu, 1 Aug 2024 17:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 17:41:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 10:40:58 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 1 Aug 2024 10:40:57 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 1 Aug 2024 10:40:57 -0700
Date: Thu, 1 Aug 2024 10:40:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Message-ID: <ZqvIp/nEz8jnKaH2@Asurada-Nvidia>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
 <BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Zqp+sssdo80B7MaB@Asurada-Nvidia>
 <Zqqq5JYFswS49z2L@Asurada-Nvidia>
 <BN9PR11MB5276F7ACEBCDAB8C0FF5390E8CB22@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F7ACEBCDAB8C0FF5390E8CB22@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c84128-1145-4443-28a3-08dcb2511e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ThqhXr72jQ2Mhfzhrofy3ZUvvKB3IWvhrm/N3JmsGZyQdQiTj8B0eS36SpLo?=
 =?us-ascii?Q?yJwlihP9+3zLK6OKGXnwMm4NVRnTAFkoaxHX1ZA9PV0jwqiwV7ovW4viSaGm?=
 =?us-ascii?Q?Q16RwtOQ7iH4qK6+kppVcjaHrAjokgfkawR8FlI/vMLFs6fi/kwHB2Zxxxhp?=
 =?us-ascii?Q?s8WvqqyyGMTp88IRV70OrMm/tUBvta1FMZ8g7Sg0eVZqmilbz1MqJ2jzk07a?=
 =?us-ascii?Q?GuqWRRSum+fM0PWwT2+vUy/8lbB5IRS+wH5Mw/iIy4xpG/L/76VDinoO+OSj?=
 =?us-ascii?Q?7v2EarMLvkCrMF88FbFCHNmsOzE0EV9/kVvvV6zaQoL3TQETpoeyZ3D7YBk5?=
 =?us-ascii?Q?th4MojKgEpNF/PGt8mHWBDuvgyd90p6oG0vCQVJajIbtkIomuXDfVkYbi2PP?=
 =?us-ascii?Q?IOzp/xLe08fZrnwIRVa9k9rUf4ZkkGXts7DiG8f8kDYhlKPZn1ObXJKTzW1b?=
 =?us-ascii?Q?Z31+sXPP4oDQ+12jUKqG7EBc5OFqcIrnH3GRFRzy/HG4h5rsW40RirxPlxso?=
 =?us-ascii?Q?1Ex0Cu+UZ/FmW/Qq+0NsRtTBakyEBDgzHYBtRTNhLj+OP3gehCYhwRh/Cd1d?=
 =?us-ascii?Q?dEY8rNheqIalhNsvjk5VNMnfB8Ax1ZdZ35uXAhIyaJMsfR06jfSvlA8WdmqO?=
 =?us-ascii?Q?faCMON5UTt+0OxdMgncAh65neA8+4G1oUhwPz4XmHQB7eZhjUZ2rtLVilVWN?=
 =?us-ascii?Q?x+V6yOCcKJjt74FHYelgbOXe7BbNkhBjiVeYqDd4c84CBnXmpBw4XkxOdb8j?=
 =?us-ascii?Q?tm4JQIZm1Kru9K2pNcZYNbrVYBxUAXGuUX8ZXRMHE5K8GSvvMdJPpqCxV8+2?=
 =?us-ascii?Q?PsQDGl53U+jUE2KAMoOPNPnoOWSn30N2jxqEMMGAVAZovFRv9kcZbADHM7Wj?=
 =?us-ascii?Q?MhNKREab+QUAdF6buJvmssajcyYKiKpvtbBiw6bVkBsl3WkiJ+vu+zP23+Qx?=
 =?us-ascii?Q?0A7LqzjHsSLew20LFTvXsUKkawXlDwKhjgCQ1CBheDEpfnPO0jXr75Um3/kn?=
 =?us-ascii?Q?A3zxFYXVaEZ4W7vIwRrtV6PJHee+hzeP9GoKlH2t9/zJ78yZmHm5InbCdLnl?=
 =?us-ascii?Q?eGhZDhN7QrRoTNPS9VlGyQA1H5p1820omN/oa9ploKZbnsOgfS9qCkd8jWkg?=
 =?us-ascii?Q?C+VNIL0PGKDCO+veS9b1/dyvKAIARS32+QuSEZnV3j4ZpOHaZBaEZH9dd9PU?=
 =?us-ascii?Q?PYd+aWu7KW7zaUf+Da8QZ1tKqq8LjDTBEmIdJ64AHrmTbcSQIw8995F0Z1Ms?=
 =?us-ascii?Q?W8n+hCdUgyIw22paXmaFsw1dzm5WaVav6rP6IW0365fqa7oFWfqMUz7bMz7v?=
 =?us-ascii?Q?cqjSt5avgrYzpog++oER+iryeIdSBO0doMp6keZNl5H1LxUIopgQNEvP3Wdt?=
 =?us-ascii?Q?a4hxw97GEm4C4PG6X9RR31R/BbXxpWDZiPmblfpj7Lq03srexVWhPs8H9okK?=
 =?us-ascii?Q?Is0w/5Xx24zLOGXwlek72Y4nY4ddsJkH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 17:41:04.4877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c84128-1145-4443-28a3-08dcb2511e00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

On Thu, Aug 01, 2024 at 08:10:57AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, August 1, 2024 5:22 AM
> >
> > @@ -316,7 +316,9 @@ static inline bool hwpt_is_paging(struct
> > iommufd_hw_pagetable *hwpt)
> >  static inline struct iommufd_hwpt_paging *
> >  to_hwpt_paging(struct iommufd_hw_pagetable *hwpt)
> >  {
> > -     return container_of(hwpt, struct iommufd_hwpt_paging, common);
> > +     if (hwpt_is_paging(hwpt))
> > +             return container_of(hwpt, struct iommufd_hwpt_paging,
> > common);
> > +     return container_of(hwpt, struct iommufd_hwpt_nested, common)-
> > >parent;
> >  }
> >
> 
> hmm this doesn't work with future new hwpt types.

Was trying to make it a smaller change, but short-sighted.

> It's clearer to pass hwpt into earlier helpers and then do the type check
> insided and make it a nop for types other than paging/nesting.

Ack.

Thanks
Nicolin
