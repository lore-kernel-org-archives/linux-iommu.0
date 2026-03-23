Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933B3A9DAB
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270563; cv=fail; b=diQqTllNkG412ogZ0vtOVYt9l3yExy7PlbdpDVVRki7liLcv0oWHLnGEnb31oUJR/241awPT9qTLPvsxvbSeNMBJqrampADSdInddHpz+ysKcWBSwD1yMtD0GYAMZgUnCx0ksCEtYK/X+Vp69iexWJSah/7zFSIu/I8PNKeys1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270563; c=relaxed/simple;
	bh=Y0Zq7SWmyPtolGNTzeGsMMdA4DQEssRq5sxtiO/KEw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UImO303LPoQf6reoqAjerYltgXJvqCys7P0L4kxIfv2T7CZFwWqWy7HMZbl7Uo6nAnkOAypEW60+RGrNuV7wWCz8LcfnvKoacRlkDPzz1xZfMJ0sLKYGpuSvD6L5D2OvGD8JHSjjNCMAsgmENjB0bAPh60SSSthhkIkTdVRoeFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iGtPVazP; arc=fail smtp.client-ip=40.107.209.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iGtPVazP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/dnu+PbkQrP8w6qTWoEFR10eF3OT4hWk5k3ZdAmTys+kgpiZDIryd3A5EMcRNsswC/H80LDt6CEr37qdrZ3ZcqZuQ+Pm9MnRWVx8DCLwffkadjHLJAAFqQYPw3Tjc7vpLBfmqWOXNjJAA/9KJz33MWqmt2MHgXLkAdYhbX02dKfbUH+5TS9ra0hSnqkv52QUZEIsWp9akzrIOn+u0uCLjIjmTKiGNUp63P9/1FL8P0NYFauYxi5Dq3kr0BlRB4HTeBLtAR7vfRnXenaTcRRUTSsvz8CUKNBxeI0o4Z5TRbJX/Y/MC0PbWKEYiCaYagQKhg9bwwR5dZh9ZZJwDf2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qu3xYp2RWfWC0nQzZl9RE0t/hh10xa/VPJWKRA7agg=;
 b=DC/kQpIAgHGNSwIhXPejQSTpayzeMvK8ApcrVGqm6TtqQmAtJlXi5zORR61gzku+UIqNsFy4HdPcc5LaCzkuQdtTZE7pTv1lnS6yDdxc++v6T4fyKY1Fvrl71mrdhKOpdl8IncVJ1Ht7a4nTqAk0Fy1aqt/Kt82N/lwny9QQc0vAVzQjDkUOe1Ah2V3Iz3RcgU+mPtzYYxpVjq9tb157I8XxcTO3tY84hZJ6HLU7KQd6L7nVOyzYx1yUGhAvRL57mQAp48pZeMvTtU1SeQJfwt6sJJOUB+NWdRq2n5cUTb3QhjRJedHIoh7xP9jdkBId6tlIC78M0GWrrwx5aTjD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qu3xYp2RWfWC0nQzZl9RE0t/hh10xa/VPJWKRA7agg=;
 b=iGtPVazPJ164jP9d508odN6DvfdNdsaQxHJFbCML3oP/Qnr7NMwhjiw+JlF4w6oD3PRgxUAyQXCawl/zvEI3rP/TGE/O6dHg7Z2CCbfDvbkiPc18MLfwBpRADOK8YXSM2W5JLcIZemjr+Qz1epP79M30P89efrqkApFZ9tgvP6k4M+0CGg6faNg1SccbpJC3xSmLsT44uNQcfBT8Rw9GNq4b1VQUHi1rvwCdPKH5NEvtLNmyGhs9DPEFTnQoOHuad3uEJLGjV1ubsFAeaVJXU0moa+/B9WQHq1QPNN/JPeKR66LJcE8O/e5+DtHm4P0nOJ6ScWDzwP3qPldHK+38Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 12:55:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 12:55:56 +0000
Date: Mon, 23 Mar 2026 09:55:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Samiullah Khawaja <skhawaja@google.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
Message-ID: <20260323125555.GC7340@nvidia.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <aa9W4ZKYWHr9-UNy@google.com>
 <aa9fQchZJER8QvY0@google.com>
 <61267acf-e42e-4d1e-9942-e241ccffa606@linux.intel.com>
 <abfStwmSjgy--e4H@willie-the-truck>
 <e89a6ce3-d0a9-4e91-9786-83c2bdb2efd3@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89a6ce3-d0a9-4e91-9786-83c2bdb2efd3@linux.intel.com>
X-ClientProxiedBy: MN2PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:208:23e::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df43ab5-9729-46e1-9bac-08de88db8622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GDD6miLP3BhNole8ikFFqBz+FFUZUQDsuVor3e/Cca8gJTRzv5jUnNNQYZbUbxsrKCeWxL0opC3nf+zXYDTY7mJVsZPXZtJbuciXO+4viU78Abf9e/VRlC7utm3inYDg7fdNs8+mxSMgIU1d9SEZ/J9ROfx7eI3c1JetZYtK3gtb2GPrZ1THnnRzGH5EKeqZyRSIH47S2sY0q8JQsgdhZQPJnDFqRdwwQ+NWQ8Hy6Vw6PxCRxPy73QyWctLnIny2K8/ahyd8XRq3eZF3KpjDk0mljbG2odKt1WnpveFCKHI+q8qC2r3S7KnI8vaNWBFokUR2o+glFl0b+iNnMtiFO1xBnY5ut7erYRu2sWzrwksjGaN6WGIYA0GQS7CknIopTpTrwJMDVyYuKlLflvk1eVGBCRxGSBT2xhf4SSGpkAtFGJxmjFL4T3x0shWQt+w3PbZVK8BEmBklOR8V9GC6fB3NYBgxAVaFMMHQGczOHgxrS0O5K3bTMzOkVakIYTMekWszKE/J9H+e5N+4xrtF4634552naJuaD4aAO91sF4GtH2x314BOi4p20K2AOK0MJxOjXzcOHOEBk0B5I/EtN1LvaV+qVLbPKguSkWyqJ+ElSk6WR7lrNHJ7zHDNY+eFNFaRueTEt23ThziApIlCFh3bkxawDglFXcSuVMyKSFoSWyTrFZ6sqnmwQmn3qDPmYDCz+oJxW4iVKohrOU8Lp/kEzQKIMLlSWeIda0KNWJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bE4nQpT2xuut2WtYFA9qCm8H7Tb1ZuuGEhjT9qqrzf23nofFuyKd/z16oty/?=
 =?us-ascii?Q?zfWNHJajjtihoy45cxkbnVegrwEdw1xUV5C36cUbo8Dhe/aHNgmgC2Jlsa9U?=
 =?us-ascii?Q?VSlvl8qyu8sNWcberNTTxd0q9s99GQPhhaXxrbleTp92TU7+/1ZZV08X6U8r?=
 =?us-ascii?Q?vZy7pebaRnwM9OVnB7QorVDuUbUNYdcxqq0a5OkKYt5ldvdvuYhBcY4VPiPG?=
 =?us-ascii?Q?sm+6E7tzcMcbKKr97nDPBuItEKRuZXzZvjmy9Nxdmp30O+Z/rV6JvkqH/Njp?=
 =?us-ascii?Q?bWA2Bxpt82ZHMW4Uqkrikyh3VxQfwghAlVPevQX7idokAbUWAemRyYHLnWIQ?=
 =?us-ascii?Q?jPlXB7vjhAKcKrckM03zm3zCbOqouOYgT5gdjZostKAOVqn0tAxCxUrLBp1e?=
 =?us-ascii?Q?begfKEsXLJG2P/UMMXzOrEr1K8ns0NBFm2BOV2JDWSsZvuqo89dtgdbLbPV8?=
 =?us-ascii?Q?sf7ArFQXJF/tEi8jP8QsFK3Q+1Yyx3SmbI36xftVRWDRR8qD7g5GZdPLGroY?=
 =?us-ascii?Q?0TLk0u3O17H5d82AKn/Uhlfbb1KzP3PmaQ6kmX8BeYDpvl7InHdrSO4ZB1Xf?=
 =?us-ascii?Q?PktkuQxIKYBKS7VUng0/ZgUAPzRFaoTRNOFVzieqAfkpNPS514DojxogmUXW?=
 =?us-ascii?Q?ndxcWPQ4IjGFkq0sphLxYWm0J9gKwXrWA5FkggLl06/qIGD3fd7FLKW0Tubs?=
 =?us-ascii?Q?xEuQzMgiWXTE1Zt6XGDuusN6v1FTNzbDGe/3caYYyVkrh8xsadJcrEMx6Rmv?=
 =?us-ascii?Q?xQx6Bcf6vq7/fPIg3m1RdIvZrdnwlWaKyPJX9pWcHVXMJAz5YL+NvRANhLUQ?=
 =?us-ascii?Q?+yV3/WhBGfn+TZsALhLNwvmNima2mdGvAJp/RjNQzSmRVHkdBb6dwidvM8k/?=
 =?us-ascii?Q?JbnmyZ5jxOpmijope4wReR2w+xHXotN2JgsCMWD8cewgaxWeS/Yph+c+SnH5?=
 =?us-ascii?Q?jd0QxCfhGhi8nzc5vbCCo5C3Z86W7nuYBZe8EPIArYjweVsWIUbRh5Ct56JI?=
 =?us-ascii?Q?WjTpN4DSGCWshEVWfvT/2zxicxx0ULjUDEmPqyofs8d1kJZ3TaO2hDO/9ldB?=
 =?us-ascii?Q?qm+g4uj54Vo7bQOPVb7nN3fKN0bJCKIzYNuHXPI/PynjejiLqKnhUyZAC0iT?=
 =?us-ascii?Q?qZcWMJV8VCCYyXpNZJC2lHnEBGws/xCplO45xYM20Po9YgtbjngNlmOBBLsB?=
 =?us-ascii?Q?D2+Xd7Ud1Sw9a0FDakCjO/k3VKHe7TPm7kohdt63SASdlIq4USglQhHfH2Sc?=
 =?us-ascii?Q?84bysNz/0ePI8q2zvNIzLlYgZBBxtB3Pu9LO/ro+hr2RMysgnFxgyIrye84O?=
 =?us-ascii?Q?S5CIZWvHsuQMNd04SYTaG5kiZ/NBsjKpZgiaUGqMLOq9sS/EyLnbxyOt+Bsp?=
 =?us-ascii?Q?21xB0p0xRsagQFdH0spCZg+cI2FFBaaIM0JZwkPHOc9crY/OgvQuovxqaY6l?=
 =?us-ascii?Q?qzqrFadlhttNALXScLEtHZ0kKx5qjkICM9SS4cqytr/Ico1gWV/1I/Lx5Fsh?=
 =?us-ascii?Q?ENCSAndQCONjGn6pr/UzHVq3tpYhsz0ff33I++v6F7vwSWiIZRfxc5PulPwv?=
 =?us-ascii?Q?NWP/Vs3RNtyVo8WnbpBeGjhupMvlBUdWL3N3hcvLthPqUgOLIpLuX6XKTbH1?=
 =?us-ascii?Q?Py4gtt96zx+GjUVaKSAfhA32b7shiy9hTdgE4+99BETd514LQKsE/bepWk+/?=
 =?us-ascii?Q?Jd+CwGUBJ5QNlvtzbTfq2QZPmPJsKikUHUGw8Zd0jCjlXfrU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df43ab5-9729-46e1-9bac-08de88db8622
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:55:56.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFi4vrEEIgpkCsCE3S9Vo7uyKPotEQajDPXeh0tMiM+neDtbSSfnmG5+DpVnTQAw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182

On Wed, Mar 18, 2026 at 11:10:12AM +0800, Baolu Lu wrote:
> > Shouldn't we move the SMMU driver over to this, rather than copy-pasting
> > everything? If not, then why is it in generic IOMMU code?
> 
> Yes. I will start to do this from the next version.

I had written a draft already:

https://github.com/jgunthorpe/linux/commit/cda5c27a4020d162948259df9d3c8dd61196290a

Jason
