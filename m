Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7013541B
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140642; cv=fail; b=quO+s541YLf6rv+sJoD3HHS8em3W61h+tAio+6cR4jl9hKeD9Vh4NET3nzGuF5FTu/mSF+lc26Zn4K8QFlebO+//2V5YzHZ3mcIbb88QqFGaSERxvE4vAd87ytD9iBr+Ubm+TO6gUorSDY06HpbyYGzwNphkr54C6/tDmL4TVvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140642; c=relaxed/simple;
	bh=WfOdlY7lQKoILlaJG19WWeLKnyr/g2cf5DMVspqlt9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is8490H+axi/34p4yywayYzg7cASsWffa8LOQF/3EbHIBm8MZ3Go0CO7e/uiLHt7lvy0D0+bocUE5OeLz/C4BgKwIBOm+Gffi+8RigmMKp6ENhNE3MDI23EQA0VDrP/nkKs3Wu+KniOfJ+p0FrWayL24kIxETVMqRGC/JInPyC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gwTNrJVJ; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gwTNrJVJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfBzXLjPSsBVACIjJEhdked1OyTKTZdOLf0rjf2bPAlPRUTTjdIBl+zquCpZ6S913WVPSAEhuXpmFyaNrkcRrvyoBpdHr6LBUOrjDKfjfqPfcYSUdLaWaId2a72mEUhVsJq0OhR3sz+W0CihePnZPxH8E9esN+APeYHeAuU2xqSjgfsjr4wef7ODGua5CR5ENstUrSb7b+9Fie1wgNNCX+tVC9/fAaB9P7rAKDVygatas9lwjbLiFHYEbjvADI5xbJquqS+j1mcQruO2kUcdvvKc8YFObtgwYfHjzforoe5QmK4fKm5+gKfswipFgbWrxxt38iMkdLEZ6mrGwf0vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVt6EZ/Hy18Jaq2TWXvsD459jAD7qFQqle7Gjfw7XGA=;
 b=p9pDlbG6kFN8L2E42W8pfvDt0TD+23vxmO6y7sCRSvp5t2a4M7sUXzEVcEo9Eoys/P5DyQ1klbM/FyC31SpFS1xoSxx7rhnQUGhN91ciJhRnNzj5AAE0A9KKsx6VxKZVXktjybb4DfM65D0ubqdgG8ep4LbUxUxJiCLAJl/JPIWiQMc6td0kfhdmva40AGHxBkAakm2swZpgpA38RfFgLp8HxmXVAB0H8aSHlas4+mnVNt06o8d4QEN/K5brb0bVf32vDiPk3VXC7RAh751uSHY1z91wKgW3qh+pRml3HIuDo84S/7/YWuumhQo9N0jGLDKskQA5hyA0q7vSGuX1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVt6EZ/Hy18Jaq2TWXvsD459jAD7qFQqle7Gjfw7XGA=;
 b=gwTNrJVJvJUEMuvcq/SCcyBlr8tTHGQgCY+Wy8SOEQ5i7S/N1d1aZYD5lklgzX6Q7Lx/viwVANSV/vXT+sY7YoTEdADgz+YL5vGMAlKzszTP4HXUUOx6aTOSD1cC/72eLFK9NmhkYW42V++hV+T3X2KI04fuiAxAPCWlN1P87L3M8J94I0LV5TaX6kSSfilKLmz8qgsr4HfwmPIaGtMR6Z8jLtQrp2eQsDbxnYxYrw198+cyeBInOUY837hnqfri7lf5PzUkELaOsuDqkJbzbNOkzsD8eL+12CKfUtzESrmUe6PobVIL8MC+X5HXoW5Fg+FrhG74kbxzivgbrgv8rQ==
Received: from MN2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:208:23b::31)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 19:03:55 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::b8) by MN2PR11CA0026.outlook.office365.com
 (2603:10b6:208:23b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 19:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 19:03:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 11:03:42 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 11:03:42 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 17 Jan 2025 11:03:40 -0800
Date: Fri, 17 Jan 2025 11:03:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v6 04/14] iommufd: Always pass iommu_attach_handle to
 iommu core
Message-ID: <Z4qpi5ucrzcrqQds@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-5-yi.l.liu@intel.com>
 <BN9PR11MB5276F2830324D346D180D3068C132@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3f101c0c-5212-462c-a916-83e9da8793c8@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f101c0c-5212-462c-a916-83e9da8793c8@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 77197592-5f51-4c89-2045-08dd3729b0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sRBAFkXgmmdh7+hV9QcMede4B7JU9QEIjX4lJaCUJJ6oSkuRW4OHMIaHlO6W?=
 =?us-ascii?Q?mJ5b5gwDg/kzKDh5MsKVNvc73w4gqQf1ErPfRTcqwauZEWWUNC+WaWidP68t?=
 =?us-ascii?Q?7EaqUopkeTjO5eBpTKot4Xgd13HxuY7xIwvJQ5MsVdYhpWQuwJvYNioRKXir?=
 =?us-ascii?Q?iyxAZJUM825DryogwFCXXFJTEvr2vORJ38kloqr/CI5dcVRqtFoLEU4HBqv3?=
 =?us-ascii?Q?VbGfy8ruvDgxVmIKLYFJGorIIOGfP8V/+Vtjv4nB6JbVHKLSLgTldvxzclH0?=
 =?us-ascii?Q?nayySkCp6rHidQr73QxjCvn8gWzlqUNHVuyVjg2R1Ei/Lm2DEEhztrjct/DG?=
 =?us-ascii?Q?e1H1LibNYndKu27VDx6zIn2SY6wkW9NFKIydiHDqtzyZpDkF5Vm7T7DFKZ84?=
 =?us-ascii?Q?pN1AgSc2a5KZ6X08oYvg4kV4hEX+TicV/o8LpXssxfeF6kGQDBlHaEcH8ZOO?=
 =?us-ascii?Q?L01WjcdAfC6hUhwQ0c/n/3qD2aINKdhY9a1PRlqBNSBFcYyKehypy11Z0Frh?=
 =?us-ascii?Q?75awtbN6If5TwioMynEjpsmZGvrGmFscb5An9Kyh/rFnUDJIHQcFyDzP91lF?=
 =?us-ascii?Q?b43Mrcf+aAdO8oKXedUrrzKZ4MyZdd0vhz6o2sveU13tvj6m34EWIi/H4xli?=
 =?us-ascii?Q?ZsnVtjd10YOyP+XOQQjakgHekXJC9rcSs6NA8pCIaM8Z08nhQqu3TBAGlkBH?=
 =?us-ascii?Q?wEpy8Kvoax7wXSDbSLBIKJFKJU7Vy4FioMfRkI04O/gC2/FE7/xRufNa13Sk?=
 =?us-ascii?Q?zWd4t9geB5qo9Yy7OHpIb4zUK6eb5Qmc4jSWvL5YwmZ1OFkqQNmlVZPu2r2G?=
 =?us-ascii?Q?uESnuDiZZ+vWJAouAmCdTtnrwUkqHr8B+QHmSZi9dz5IHna6DvxlY0DyzEd9?=
 =?us-ascii?Q?rPimlGZWRHtxK7JYTzKuNFOuxe4yU6UvFTEx6yM990EhG3msShqVgV9SCHar?=
 =?us-ascii?Q?zlZWiQm0y4cMqXYhYIifrwfu4MAW+pXTrKBZRH6jUV3qY0gogWNbX/zJKw0q?=
 =?us-ascii?Q?VI2HXHUDXKWUe8YsJog3iKdzOsmWiwMqTx2x2OEnHXBiohy0JC6e4Knk+gzM?=
 =?us-ascii?Q?8q4orh0xjsLvgYPKT4ymRqE7bmrFHecEpXh9sI0YShOlXnipVQTNAH4yQ/u8?=
 =?us-ascii?Q?ohbrwbSOPwqmc0wohZ2VAyeE/PiFvmy50JN0+oF59Ods+AVARrgAmBlMRXlJ?=
 =?us-ascii?Q?cgxE17dVUY0+d3B6oq204kVgANeDyCh73VyqPAOAXZRmRDceuHxgsEpl+lgv?=
 =?us-ascii?Q?CEhbOrgUq3VISfyO9MNycwpPtkc7+Dk/Ecg6VHMoZtyrWKQt0hO4yblRVuOK?=
 =?us-ascii?Q?Si5wJ7uWRSzKPmKQToY5lAL5JfgKKMdIe7pdcVb+eYWIB1y/orAbGEFuAKZO?=
 =?us-ascii?Q?fwlQr9pMbyVqxDVBN6gejQ6u0r+OBGd2Fzrb9HNF4DQbHWMsft/YOWpwyDF/?=
 =?us-ascii?Q?11hctQCBY/O+OzbLXidBuMjKS0d/PIcKxNvEnQKf0HkF52QA4MEzoFqpNNkx?=
 =?us-ascii?Q?5Y3AuVohnptOE9k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 19:03:55.4023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77197592-5f51-4c89-2045-08dd3729b0cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692

On Fri, Jan 17, 2025 at 08:33:43PM +0800, Yi Liu wrote:
> On 2025/1/9 15:44, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Thursday, December 19, 2024 9:28 PM
> > > 
> > >   static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
> > >   					      struct iommufd_hw_pagetable
> > > *hwpt,
> > >   					      struct iommufd_hw_pagetable
> > > *old)
> > >   {
> > > +	struct iommufd_attach_handle *curr;
> > > +	int ret;
> > > +
> > >   	if (old->fault || hwpt->fault)
> > >   		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
> > > 
> > > -	return iommu_group_replace_domain(idev->igroup->group, hwpt-
> > > > domain);
> > > +	curr = iommufd_device_get_attach_handle(idev);
> > > +
> > > +	ret = iommufd_dev_replace_handle(idev, hwpt, old);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	kfree(curr);
> > > +	return 0;
> > >   }
> > > 
> > 
> > It's not balanced to have handle freed in different locations (one in
> > Fault domain specific handler and the other here).
> > 
> > It sounds clearer to remove the fault domain specific helper and have
> > everything together in this function when you move it to a C file.
> 
> sure. I'm also coordinating with Nic about this since he also needs to
> make the handle code to be generic in both fault and non-fault path.

Yea, it would look like the one in the MSI series [1]. A common
flow attaches/detaches/replaces the handles. If it's on a fault
patch, do the extra to enable/disable the fault specific stuff.

[1] https://lore.kernel.org/kvm/c708aedc678c63e2466b43ab9d4f8ac876e49aa1.1736550979.git.nicolinc@nvidia.com/
