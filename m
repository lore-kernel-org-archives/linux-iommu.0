Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717438DF2
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028708; cv=fail; b=KwkcloU5KRv4GNqXAesYozjs1IuvBIE6QWMEu/C6I6X3rO0HGI3T8+BU5gfJPd+BByBGNA9eC8o32Q65vfS0mbDrDgSaQc0gAMg7Hh7oBR0L/8c0fVw0mIfdzz5AXANnmVksm6JMbnRiJ+959WXJmyu/qWWu69klprumiu1kLCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028708; c=relaxed/simple;
	bh=yA+VeqoDzYX9IMI1gBHVgyWusLW+w2jcUVwBAZmhBDk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da6ewE5JH/TTHyHddBt/gKBjPvGo+jN0jCaqNAz3laTsZQoYZ9uKbJwFFzOUSHV9kc8VLU84qDLvOdHwDnDxX0K6cP44jTYY4SzcrZ0cGWPgRUkxaZgy9+AIy+OoT24ECDXizi0XbcL6bpN0M8gS4j0qT9caj+CBUJd+IzixBAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FaKpatb5; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FaKpatb5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lncR5Ms4gxDAvzj4ixzH3NlJmkZu5d1C0gNhRuEx4FVE+dZAw9NUBQ+rLEAjeJuUyjYcGtfIMxTrVpi6poZH/4+PgwvZTWqOLh55ODJAlQatDHa3U50IqONsUcvN5+JSJM+FPTrKT5U0hQScH34Oh4rH0wDEqiFc7/Nsh30CcKt/rSOXa5Z1WCZuQm0UADrsIwXOWlbMYdb0PZFdXhSNsOkuIHP0kbfJmFj+ZupnO9w1njK3wba1QRpOyilLj5F2ZYW/YK1wzpdACTTpQPJBJk6f5NpTLC1eMOXL02BIrm7gzquIVBUP6TALz43XK4KpuscA01rklNszFIBs45z46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX5LmPe8CPR6uGNKtTRPZiCcEzXeVZVRPGeqTUTn+E0=;
 b=B6APyGEgyklAAtUWAjny6lcL2eZ4y4Qr4zgGKck3oJVipzrL02EIAewwL4p5F5+6Q/L/wjADjaH8hkdqRshk0wdWByRfJRuxBxjIQsJEb4EItS0fCh2rgARBoHf0Cs+FPE5/nyvOtGE6TbK6F5va+ed2+YMMY2WhPa4k0YJ5wlLWhaFzRY2NmF5XzQvQRFX6euCUAJNvmfZGXtRw0ESEObi/DLFRXCrLcyfbp1P9s5P59iB1XJd1H5VGqXHZToMR2gsvNEniAVzWcdVmBWdZgloQz/oHcX0B5pwBKVqFjIIS7dJvsYIpWVK0zezyElR9Utj7GQaFZSQhacMf6zhGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX5LmPe8CPR6uGNKtTRPZiCcEzXeVZVRPGeqTUTn+E0=;
 b=FaKpatb5i1I2O1qVfgJLGjc77UJqx2s9t+21dnyjA1CULaVjHzBTa93+YUtFYy4EKAn7sM1nLVozgZh5PYgKhuMhVep7pbOWh+3FbqurCD2zKUbTsn6FwDuFq1TksfWc4lJpyDVMPcmPi/UqhSW99BXznQYKYYarkLm6PzRMnyV6cOFVSZ4naY9d0bvpav2ri1gQzNp8TmKEWTFSsxNE6+RiJxQRD4cDWbI+7+4QKP/XEYHPaamorkbWoRuW80YrFOOI+3T88tVMhZ97LiEWZqwFjd5vDXwsKMEpdf0ukjUrGyWArt55NN9/VJ3ilAa4LRVabqYJ7/0LcGjEk56Bnw==
Received: from SJ0PR13CA0170.namprd13.prod.outlook.com (2603:10b6:a03:2c7::25)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Wed, 11 Sep
 2024 04:25:01 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::75) by SJ0PR13CA0170.outlook.office365.com
 (2603:10b6:a03:2c7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 04:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 04:25:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Sep
 2024 21:24:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Sep
 2024 21:24:47 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 10 Sep 2024 21:24:44 -0700
Date: Tue, 10 Sep 2024 21:24:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>,
	<eric.auger@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <ZuEbir5Np3sUFkHz@nvidia.com>
References: <20240910204111.7969-1-nicolinc@nvidia.com>
 <ZuD8tsci0JPikUYL@archie.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZuD8tsci0JPikUYL@archie.me>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5f19b9-8b6a-44c4-023f-08dcd219b390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cOuLPWyVdiSOnRIBgTeVzPAcH+udJ/OUXcuQP9VL+QEZoumc0JPEE5cF60oO?=
 =?us-ascii?Q?/tEJkjLFXbqxYW0p1tZfc9zqUg0FEfJEKeKIRS6rXgn3CvedP2xorIAoC4Xd?=
 =?us-ascii?Q?A563Rjxq6TSEbfgeSP5fCfAw434PQ9/gUhAJKB7G17BpywOgsrV1okvtlveA?=
 =?us-ascii?Q?zQjvNV2CoymB1Mxx52KlGsBFLFpOFMvJoouKRUTQ0rCUmGPdm24g54IGEpYa?=
 =?us-ascii?Q?mv1yfsm9niYYOu6Sj/RbaaTYScLZyUeEU/POtrB/ZuCzvhICIi82jjrcZ/TC?=
 =?us-ascii?Q?GZZuXct2/+itm6YIt4jhSFu6bjBjrWodfY85jzED0WLAxlJLXJHDg6XB4XhA?=
 =?us-ascii?Q?A6xdjRXN83SBlUc6vrpYPL9dGvVfsAX+9WKjDQt9GV2d2aKLKDHk1sRKXYOV?=
 =?us-ascii?Q?CcweqOYVjJNCnjYHcDksRrK8BHaOiZ2MVzpmTVnjYGYIoVy/ES1aFa37+S0W?=
 =?us-ascii?Q?2FypYIua76MYPSlERY7iqTPQV75V0+cJueK0J6FczfI0YZ5ATRSB3y5AZ25x?=
 =?us-ascii?Q?VPLW4MOazU55rVhUakcQ2mFTuXwqpManh21QCsIm+iajOScrzhukYlBludyC?=
 =?us-ascii?Q?dqA/3eND9PhxQvxvDXQaPv4XGROv2i9MS3lRsZ+2me2b7fdlfprO/+NdJoR6?=
 =?us-ascii?Q?1t8XAhH6heKBdjRa5ZwC3W5QlNKzxAW3oekCWH8BYZAf2ZQUcUbCqqlmg8Zq?=
 =?us-ascii?Q?7oTdNRXqD0M8VQufsxTeUtnFfeD1bXWb07yletPsbQPqPro7Tp+Zg8DEgKs+?=
 =?us-ascii?Q?mmFRpADsjctqN9rsVULT7LKS7R/4UBWZGwNRwz2upJZjeeCx2Kffxlg8JAhe?=
 =?us-ascii?Q?NH72X9oYmCwoTUPsS34jOJBrSOR1CXFH123iAYTQR53BPww6bJgxVL76suhW?=
 =?us-ascii?Q?ovbn9mYCiVm4fG97G578smiUefEqsiH9mnHThpHU8nJ0ks0HLPdWHh6joCRa?=
 =?us-ascii?Q?8Gi/wWSdbkC2bdieU7TsX5NKJQ22dnvPaWAJYHuEllem459ImlBke4ge6BDR?=
 =?us-ascii?Q?ANszmGiBlCI+A7nXKsu8asLkZT3AEylnv8Cw94JN7GnNTLDe4G/X6M9TpP7k?=
 =?us-ascii?Q?F+7fHnzN+7dXqvJG3UVXfmi2ExziiFYLYx+6yM7RhErZkShMfOJYH/fuxE90?=
 =?us-ascii?Q?CqJ/qqzHBZ060krk1iQxiLa6p14h9IgRTrdcVQDYdrZNRxvDVJNj2gP30q6j?=
 =?us-ascii?Q?qNrCSbltj7hVSHiCoz3Pdgd7hKCDy36M55vWUIBtxBkbS9nYnYE/UfXPdMO4?=
 =?us-ascii?Q?JWAiq+tfieHTQEIdd5QCxhVQe8bil+kv5/e7HNEnW1oqJJDfj6BcYitz5Qf+?=
 =?us-ascii?Q?2ElGMkhGsvdQJ2heHt+FHCrfENoC0ij7DEoDlv0a0ugL8xMRj7ZrDTIkTGz8?=
 =?us-ascii?Q?K2Uz0qzcqSObh8xP4s4UVc4RPl2ciSPn2C9pPY/Dkaxp2JzP0QAZcR022ncs?=
 =?us-ascii?Q?kUienNz8YtU9mpXHpdzrdfxYAhG5k+7e?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 04:25:00.7092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5f19b9-8b6a-44c4-023f-08dcd219b390
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500

Hi Bagas,

On Wed, Sep 11, 2024 at 09:13:10AM +0700, Bagas Sanjaya wrote:
> ---- >8 ---
> diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
> index 3b0e46017dce22..e3ff476aba097e 100644
> --- a/Documentation/userspace-api/iommufd.rst
> +++ b/Documentation/userspace-api/iommufd.rst
> @@ -115,21 +115,21 @@ creating the objects and links::
>  
>  3. IOMMUFD_OBJ_HWPT_PAGING can be created in two ways:
>  
> -   IOMMUFD_OBJ_HWPT_PAGING is created when an external driver calls the IOMMUFD
> -   kAPI to attach a bound device to an IOAS. Similarly the external driver uAPI
> -   allows userspace to initiate the attaching operation. If a compatible
> -   pagetable already exists then it is reused for the attachment. Otherwise a
> -   new pagetable object and iommu_domain is created. Successful completion of
> -   this operation sets up the linkages among IOAS, device and iommu_domain. Once
> -   this completes the device could do DMA. Note that every iommu_domain inside
> -   the IOAS is also represented to userspace as an IOMMUFD_OBJ_HWPT_PAGING.
> +   * IOMMUFD_OBJ_HWPT_PAGING is created when an external driver calls the IOMMUFD
> +     kAPI to attach a bound device to an IOAS. Similarly the external driver uAPI
> +     allows userspace to initiate the attaching operation. If a compatible
> +     pagetable already exists then it is reused for the attachment. Otherwise a
> +     new pagetable object and iommu_domain is created. Successful completion of
> +     this operation sets up the linkages among IOAS, device and iommu_domain. Once
> +     this completes the device could do DMA. Note that every iommu_domain inside
> +     the IOAS is also represented to userspace as an IOMMUFD_OBJ_HWPT_PAGING.
>  
> -   IOMMUFD_OBJ_HWPT_PAGING can be also manually created via the IOMMU_HWPT_ALLOC
> -   uAPI, provided an ioas_id via @pt_id to associate the new HWPT_PAGING object
> -   to the corresponding IOAS object. The benefit of this manual allocation is to
> -   provide allocation flags (defined in enum iommufd_hwpt_alloc_flags), e.g. it
> -   allocates a nesting parent HWPT_PAGING, if the IOMMU_HWPT_ALLOC_NEST_PARENT
> -   flag is set.
> +   * IOMMUFD_OBJ_HWPT_PAGING can be also manually created via the IOMMU_HWPT_ALLOC
> +     uAPI, provided an ioas_id via @pt_id to associate the new HWPT_PAGING object
> +     to the corresponding IOAS object. The benefit of this manual allocation is to
> +     provide allocation flags (defined in enum iommufd_hwpt_alloc_flags), e.g. it
> +     allocates a nesting parent HWPT_PAGING, if the IOMMU_HWPT_ALLOC_NEST_PARENT
> +     flag is set.
>  
>  4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the IOMMU_HWPT_ALLOC
>     uAPI, provided an hwpt_id via @pt_id to associate the new HWPT_NESTED object
> 
> > <snipped>...
> > +      When @pt_id carries an ioas_id to an IOAS object, the IOMMU_HWPT_ALLOC
> > +      call is instructed to allocate an HWPT_PAGING object only.
> > +      When @pt_id carries an hwpt_id to an HWPT_PAGING object, the uAPI call
>          "If instead @pt_id ..."
> > +      is instructed to allocate an HWPT_NESTED object only.
> > +      If any other type of object is passed in via the @pt_id, the uAPI call
> > +      will fail.

I've applied the diff to my local version and will respin another
version after collecting remarks from others.

Thanks!
Nicolin
