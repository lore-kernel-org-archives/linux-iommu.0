Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A52DB7BE
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775476062; cv=fail; b=sH+eaK2wZvl2j79EhGrYF4fr+fRJhnRHgg4AMv3Lz8ulfKYJ8AraGDJyhwR3o9hN9fGKd1WtwxFULhWCMmUquueWrtxGa/cOYtZ2avxXCo0+QGjw7gJjIVYRhlZ38PqWosDyDHPDd5+KkQ8KktC8rk7Ut1dXM+qIfM7/11wNaNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775476062; c=relaxed/simple;
	bh=dofm73A1BK5mQ+Gg8pQYGRWdDRzbuTkwAp1ORPRdwF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cefkNjfko9DeRO0v8EcbTgJZ+zGnwrJ1j1giip3sT5rSWnJfrK83AFgEzXZtkqRAm0klCqy2bHH3oY6Lm3L38gvJ+UOJdwhE+foy5tGVB+t5C9mwyMIi+/OndQw35dO4H18vB8L/zkQIuwcqR2FBps1CuxP/sYO/RrDUy2OClgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kI1Evp55; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kI1Evp55"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5W6mVbGW9wUTpdkqPLX6imSBo4a9ouYAwJdzMHLS7BbclCbJGPodz8eEIOaBY64g7FY3OQ5gpx/rJgiGWezRX7q5PIE4Ky14wx9h9ySGJwn2TbU1vLPWqkqqGY6sMFsY8A9OFzHVC/fJkU+3xgjO26udSlGhlQHofeftTitWm9zuT/uMzZk9XZsfg6kZ8e+bzCwbBgtJNGyiiFh0W8xLYopG2uFvTXUqbKDzhJ/YR5h6Evlj5yhwPzRxlGvRiVSHIjkxbZxnKLO9iG2u7KHJy/FPf/ZOvkdZ1VbUrfACDB8t3BJsjumWCNZnGh/ZImzeWUjOiYR71pnlvHAh2VQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsJwVL5Je6Ow/R+Js1w81PW3bKFJOeGN2tosJrhSPZQ=;
 b=yNs/ompj5Ls8eRa6VwKXtWnm9oQjVZsFso8MiaJR7fpXZjV6Qa3yatJIncv1KxrYiJKSM7LzfS1sDKsKI6hCkew6deY7T9ZyGMqwBVxtG4q69xow6eP6Xbkf54fEueiej/n9ouVGn0jWM/RX4go0KAsUf4yLzBi4So3uPbAN9KejebKJR8I5VnCKrJZJ57EI62HcZSpShpRhxtNzXT+MeVMAHaRVP3WgVYximFkO6iofvzIj92Bi3C+7P7s9fTSQRJwkqlr/hc/sh5Xifw61VZ9A8DZi52rpdYqBd3itWEWzdGWoaY5pq/T/b6We9fTk0R+gvICyGS+xwK7IGfHbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsJwVL5Je6Ow/R+Js1w81PW3bKFJOeGN2tosJrhSPZQ=;
 b=kI1Evp55P7wl4lIk2Th56rmQQA8Uo2nk5Rc70Xw2NgbTuY8ijflMyZPAmBTAtd9CrW0TLAvq4lUd+JiTxU3Df+uL3TSx5VKZEy9CpCc2e70Ka41ZPmWuLg1aAjb7tWgYc9yKcLZ/ZsciYE6sFvaQh84RWO+OLxkJjzLlmuEYmqdlsVaNTuZjj8Y8emlrWb73AXhOMCtcYCXYFvL2WdaekTOC2TK93wY5jyllZPqosgpo4cPOsAwzSYogoj5akNTKJSOBK6vVgiZecYrLTnR16MP7IQR+OmOgSZx15+v5wheM6CszSDz7kPjbukgDq9MK6vHqf5LQ/tJjks+LtxYAyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 11:47:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 11:47:37 +0000
Date: Mon, 6 Apr 2026 08:47:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH 09/22] iommu/amd: Introduce domain for IOMMU Private
 Address (IPA) region
Message-ID: <20260406114735.GL310919@nvidia.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-10-suravee.suthikulpanit@amd.com>
 <20260330122012.GG310919@nvidia.com>
 <f31e2d60-046b-402d-b99b-ce7481a469f3@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f31e2d60-046b-402d-b99b-ce7481a469f3@amd.com>
X-ClientProxiedBy: YT4PR01CA0424.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: b90288b2-b9f9-4a7a-78f5-08de93d24c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	h9Xx/ICX2zK+3YdTcayM1sXFA98xbMWgL1WvRgtTrYI9jOpfguRw1/EK/y6XzNyK+fFzgnLtE0WRke96SMwwHkxjcj+gD9ElGGrdGSYUTx0nb/f3A+fNXXKopxP2d+aoJQ573oHBpj5Jwo8lSf6uKUFSUMIy1lXzIzwQLese7vXIIjBKKXL+1IfJPmNHfjkV2jrIqTMMMdEF8TqY2N8L5sxHbRqHO3wEucd4gYPd1gMuo34HRAhE5tREAd92Q6+n8Famp5MK32P6A76z7gFfXSoQlA4uYQT5yD6U4QwMM0d+GbzgAZcNEThXYbpsjJ2dI0FG3truK4qq3EbiUTm34aMYe2aWQkDMIH7nPod+gzFh9jKsmd/OpSzpXEZpMvaCtrlJlFweqyAfFNDVVxo7Vwd3H/eSEVpIMiYZiVQe/zqjIThTuX1hewLJWZ2TwGBKvErlVEodM6j4xMxa22hKP6nvHxUmwByACvHdkkyYW08KMLRbiG4o9oXrp0Tg59nOYvgYx8k9zJV5OU8TDFu6HW/H1NIqnUqvY0sA8B+SVkLVz6pngMjrIa0myRYcce6UCJ1VzhDk9mWY4rqtyVfslmBSQv1Ke8kT9E1HHkLuhxIrXt+YuycH0icFB13BNOh0zN9A+PDf6r1ImSq1BlWaSJxjg3njK9ljV0hP6i3kO/EOWWfAG4JUs/uwIjL7bFufoFemAIE+PPUnaaz89eJxxF6Pkjn8XfyCtP88FCngPWQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TNv7UbhNOP4lDyXSzwbnMP6Sks5CNu6bIinxV/Qddorf61SAAP2blP18aKxq?=
 =?us-ascii?Q?XRwTVeLR8GnmgdLwvunCf1NJmxUs9I6kjqifnnGaAfCpRtUpv/YOja5Y+37/?=
 =?us-ascii?Q?hZjml7HfRGRFtcza2LluU5hswCJi30KZyGcQh/olbFl1DUbfchLV9w67Ui/F?=
 =?us-ascii?Q?37tQcr4V9c2jAaQL0Gx3e/9xY924sLLiGnDfqxyx6vAg91EsOSwb4B6YKx0Z?=
 =?us-ascii?Q?41HRGMFbLkh41EL2G9qKThp2PUt4cnvc7IGILKVcj88I1Ep4q1rs9fXK9imW?=
 =?us-ascii?Q?Rlpbt4qTF/LDGwjBpknbR3MlvcwVbgDleOReOy5HIb8chgmdqXzQPGkdZVIy?=
 =?us-ascii?Q?ZmamdEIukWVRQZHe/KVDIP/+bQ4W5oldWRuJUfXGrwa9q5g5omBwvVq6uJJw?=
 =?us-ascii?Q?iGA+XxajUwAAK1V/63b90YC6AntVqLuhzF1mkerrC58mvBzbcWecrStHhrmO?=
 =?us-ascii?Q?K3+bJ8RTCjQwZoMC1lEos4tRZWdW+/FA9fmb0oDYprOBiXyyDLg3+SfQvhAX?=
 =?us-ascii?Q?ecRjuZcC4m04xMCoGyoyOaD6yziXwrn/JX8Secegs5JtA3N7FjJnetLxKNfk?=
 =?us-ascii?Q?pr68A8PMa7aTCusUctEu17IhTRPJQMMPNhqBQ6XYtzbtLhceWpfUZPo12DlZ?=
 =?us-ascii?Q?b9BmURftZY7LiB280d3bMm/btUf4pQj3x2nBNyVgjGiVVL7HhVyzz4KbRrf8?=
 =?us-ascii?Q?RD0BAPy6CFq+GKdpOfo2QhVAJxaR1twUZm9SwGFSMHw4r+aLz1CS7V0MS8fT?=
 =?us-ascii?Q?wOh7K9UWKYzSet49ATkx7Vxydv4I7WHSqRfyRyGnuiwp4ABGknv1tk79s7hu?=
 =?us-ascii?Q?G/m3nPd0CAmvPUTnUypLVKSNii4cY2jQtoah+hZ7m8BI9d+ZYF1IQzT02pwC?=
 =?us-ascii?Q?R+7vwWVdUJrkw9dlsRyaSYZBILKRUeN6wB8bqSBmQWevMN1bhMIORImhOzcC?=
 =?us-ascii?Q?cxf/vQoPyY2gDMNZSwhVqQ0m/FpBmJwLxbvWoY60IGCql3Ut3a+cKyPLOu14?=
 =?us-ascii?Q?YJkdjNUgl5n9lJQHWzaaSxrKLWb/TMZg1GRO4VA7kpLJ078Uyn+FtWCA00m/?=
 =?us-ascii?Q?yz8BlanzEzArKzI6LOjfqN8m4Yz9DUoZIcSzrrDvLtxSqzaF4I5qwZmgCPIH?=
 =?us-ascii?Q?g2uwRsjoPi3nqOFu+dkiMXgdgWIYhDkGnIxbAidIYoejxz6Xf0pHm3/x+BHZ?=
 =?us-ascii?Q?CNGcCKUfSzINv639cKgI0C5jfaobY4D/0jMbIS66B6u3okEHYVPJeQgPfvC1?=
 =?us-ascii?Q?dJOmTYDOxn+cMJjgbHcEKgYCSuyDNMQRY7JFSw4BB1Arnk1vuXLcXLBnxFuO?=
 =?us-ascii?Q?EEAcg+lOrNlArY00+L4ZiIaQ/HdxF8jhSq7aluXko7T71fs8hOyB/9gMAVE+?=
 =?us-ascii?Q?c/vYZ42oRimt3psk6la/WlKst0hxPq3bRsuu+BEyt6Omx/U+3edV0VpAZF1p?=
 =?us-ascii?Q?HN1K8FvIUFR4rZHVgdBZsnpjk221ILAigQDnR2ari6d8cDUkftD1r7MPYMVp?=
 =?us-ascii?Q?+NUxrMz854vx8AeK+wJv28u9rOKtR2TjAexQdInR+lFYM2jQdWNKdQ/XgVrz?=
 =?us-ascii?Q?NkFmP/mJ7OM2aWLRr1XY7vEBR9TUTYm/X8zmdJcUiIE3yoG15iD5XThfEFWj?=
 =?us-ascii?Q?CImJsPyWE4qwwJ4/PWjXKmlWDAl5XYx908fpFTKp3ySllxAucU28oWI/jUs9?=
 =?us-ascii?Q?wGUtPIbr6qtGuXdGHGrgoAQL5OMJpF8P321dTl16A6mgx81S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90288b2-b9f9-4a7a-78f5-08de93d24c77
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 11:47:37.0142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1Dn0BRaEGHotq5GiC2Qcj2FUVGpHbtjh3B9f9TpwnXgiTEqDHMPsGGs8K41KdLb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

On Mon, Apr 06, 2026 at 10:48:51AM +0700, Suthikulpanit, Suravee wrote:
> 
> 
> On 3/30/2026 7:20 PM, Jason Gunthorpe wrote:
> > On Mon, Mar 30, 2026 at 08:41:53AM +0000, Suravee Suthikulpanit wrote:
> > > AMD vIOMMU introduces the IOMMU Private Address (IPA) region, which is
> > > used to manage data structures necessary for IOMMU virtualization within
> > > the guest.
> > > 
> > > Introduce a new domain specifically for IPA region for each IOMMU, which
> > > is stored in struct amd_iommu.viommu_pdom. This domain uses AMD IOMMU v1
> > > page table.
> > 
> > Why can't you use a normal v1 domain with all the normal existing code?
> > 
> > Afaict it is not special at all other than it has a specific dte index?
> > 
> > Jason
> 
> Actually, this is quite different from the normal GPA->SPA, but rather
> IPA->SPA (for case GstBufferTRPMode=1). It is used specifically for vIOMMU.
> 
> The current mapping is:
> 
> IOMMU General Backing Storatge: IPA = 0x0 - 0x80_0000 (8MB)
> Domain ID Mapping Table: IPA = 0x10_0000_0000 - 0x1F_FFFF_FFFF (64GB)
> Device ID Mapping Table: IPA = 0x20_0000_0000 - 0x27_FFFF_FFFF (32GB)
> 
> The v1 table containing this mapping is programmed onto the Device Table
> Entry index of the IOMMU device ID.

I understand what it is, I'm asking why so much code is duplicated
when this is just a normal domain with a straightforward mapping put
in it?

Jason
