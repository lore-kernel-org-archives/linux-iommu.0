Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DED236ED6
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060178; cv=fail; b=I35E+rgUwTuaRIdWAPgaSzjj7zVi2/pP0DRQ1lrme6D/yDHZEkOGXuHpKBhKmQMbyJ3np3DtgEcfp+bhy0QlD3WHMIDQU/dKq8Y9scF50l8Zh+Ifq87giCinfz8U7IkJ7y4Bf6Gb8vDFDdKsm9YV1yH6a/tyqVwrVEB59qoLiBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060178; c=relaxed/simple;
	bh=EjNFsdq/1ja6rEUdxhAr688qFalu6saaf92QwBy+BGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NM3ryrQ6kIdwzGCEjkITOpQYKi6XUpIkkLtC9HUd23+8zh94szOWC1w6cnjwc+F3kvusyNOig5J/Lp/M9LTyFqbU5I8OCqoAjAKYedG6VbsPx+lddw59kNn1KNWr4DTUdFNHLI8stWlXkEyTxh/kmW3lEPfs6JV4KTEOSVZeIJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pv9nwpwD; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pv9nwpwD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upPv7ZAba+x6OXkr9Sg9/CbXC1HhxwNijZG3iDR2ete8iq58D39jUurYnpLGbrUSH0tLdefpvLekiFUZ+3U7BEvZ7aBaWmuQ9WliZudTFq7/1+WRUdQ4LUJ9krA9hB74xzB7lgrqUVTi8/mxwzxcAv6dstle0A8+tkS5dbTlxxOCADyKS9rzViLi4gZpg6BLylnegLCl8NLnRa7kVfAguO3/VPx2tmD+OL8HUOXql283UQjro0TJ6Dvz7MvyOHj9SGD8G+yBOox3NSpHtSR68k0QixHLbhYRjd2dVtoleYq3e7mXLw9OUDSbNBvCShmnVLPJKqKsKt+qbmtQtt+0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVdXbTx8JmAAtkHUC5wPDlDUXgGyXRHRPWWBMixt68Y=;
 b=Etb9UnvxDzdT5WhkcIrNbB7ERuRmLNYVdPllwwMYCPrHLa548GsOyt4pdlGcduC9GiHXTGkOSiQVPB9Hc3axKW6qqn8t/Fx8l6esMiwPyCPHko3YaNF0zTfYRKhDKQzhAaPxsEhkfGqBXXp2VzSTMazA+QihkP6A/PV5/XJBBba5nabvZ1uxIXhHUIuACQB9kT2jYUamxJlNdX3XMWpdDUV1zY6j50+8AFmQxAtz3aTgv3Qjl0304PDvJPMM0qJJVOXODPfXPsGvVp4sx2ii7l7+bYqjJjBAHItEHlfASanm5/h6dD2y174bi8lU+kj976bwNVDMeeVgs9C2OgcT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVdXbTx8JmAAtkHUC5wPDlDUXgGyXRHRPWWBMixt68Y=;
 b=pv9nwpwDOAgP8kiUUtaEnFuh5GgwVzm/eaNACyeVY7a/sRif8eKq4B5HH5CknfYaJMZtiaoIYoNg0QbxOhHc7jmxTYTu7K1sW+7D7MqIdvffqJ4WnBv4EH7oyINw4r3WHVWNTO7VHEpojsnTklyhDSQxkQ6xoDgfXupujksQo7Ec2+KbazEp/n7si4k6qjT9pJlWGzX9e97na6JmQHKGyOVjFmHLl/KfE4560yh4boWRu+VXIA9vIYNiLfTrD2brLuv04F9gPmFXopqPFLRtdzJKUsjlr+y1/mWlBVnCyRmcZFUbluynSMuEtlRGMJ4G8iNoXCE54fcV/XxXsXzabw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 20:42:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 20:42:54 +0000
Date: Thu, 16 Jan 2025 16:42:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com
Subject: Re: [PATCH rc v2 1/2] iommufd/fault: Destroy response and mutex in
 iommufd_fault_destroy()
Message-ID: <20250116204253.GZ5556@nvidia.com>
References: <cover.1736923732.git.nicolinc@nvidia.com>
 <bc8bb13e215af27e62ee51bdba3648dd4ed2dce3.1736923732.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8bb13e215af27e62ee51bdba3648dd4ed2dce3.1736923732.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:408:ec::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: c60e617f-65fc-4382-8e10-08dd366e5a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4r35sjxzsIb8yamddnCcnJzJ99WGze9p7MjP5uht7kmxmulXVgHwBMxKG7GX?=
 =?us-ascii?Q?ufqAOlbbt4vLYpkODTZKmb0qoDIRiTuknk0KvyaoU49eVxzqIm6+1SSm8xdf?=
 =?us-ascii?Q?J3nUZz1JXGzphcGdWfXR0vzEIPleNoCk63AOq1NWuYMj1C/0BBp+Ehljdp7U?=
 =?us-ascii?Q?5Gs6I1T7HVRsiFoUuhuJRf/smtKDrPQBBA8I1P+uALzv19TB9f1l2MepB/As?=
 =?us-ascii?Q?nG6c3cAbvcFSn0kV4cUT23NWFtUjgsOQ01pipGZo78x+ljTGDzp99k86IAnd?=
 =?us-ascii?Q?ysdDgBxbT1SSkaLPEkWnpzUxFpIJprxTZfBZZi5KVYNIqWgBaBGkvSqSRg7n?=
 =?us-ascii?Q?TcHcC/92z4Pb1vS/bHNk/Hs9dYawLC/+RFcgOULrQAKEaDdNX9cSSo8njvwy?=
 =?us-ascii?Q?KEDlzybgaTtS4sX3DbsSUpQELYwWWVU60SGdCKopjy9E4ExKwSqGN5FdKuph?=
 =?us-ascii?Q?QqYpIqyx7nGCiv2DfedogF/OCCYFnobo2XuYUfPV6PAKmbNJQXeFHCzRXtqQ?=
 =?us-ascii?Q?YZn1oJ8Pa8DlPDFdMtbf0aiWD6bEziF0hqzNRBkQq4hbsLrtlIIfz9K5s4RE?=
 =?us-ascii?Q?7jnhmTFKMPsW3ZLs8VUzPT4yCmzIrJEOto8+EpZ0DCAjNnsouIlswqP6n8fP?=
 =?us-ascii?Q?PttZNB3y4Y5v2YZ4FUEbnJjzh+pnxPBk+AjjkQ8ehKswE95pAP1WUsEGAizu?=
 =?us-ascii?Q?vW92w9qyQgToU0L0AJq8I7W4R2aJJ0/lR1pSmQYk/aYinQoMpgW1hhigQDTZ?=
 =?us-ascii?Q?dP7JKqonqcYxt4p9KVGU+VL78HeuWBYJavQNOPgOzIjs3o1UoJ+oQNp2fRcb?=
 =?us-ascii?Q?OQN4u1LT2hOoiSkU9BTY08sNcNAkC0Yj5j3OR6e6e7KyjmyBnksJp/0/ttQo?=
 =?us-ascii?Q?N5s++iKtJ49KOZAPUZRgjJqmvCPCRO4uRtCphSXPwa+ui/k0rtg4kVk0ryjH?=
 =?us-ascii?Q?44ezvXyoI7/70I8OMYyfeYxR5oQjJG5roSDkd33D85ZMO5okf71xyBIoNEll?=
 =?us-ascii?Q?z+mYAVuCZQ/BwVyGlROGm8MYTkaAuF/SphBfytVBoU1AFAyntYJVdAU+8/Rr?=
 =?us-ascii?Q?N5dTqHPVeYy+MyYnt4IpNBXqozk7HxdBJGQWtY99Up5DFcqXIqNxiOsa0Lpm?=
 =?us-ascii?Q?OMwruBYlnrxyfv2JYgf0W9+IsTsQ8Ur4W72NeJcZaM8/NtSxG0QqgdRIuKNU?=
 =?us-ascii?Q?DjfDOB1DRuKWiNxZF9rbf4tPjtTbLN0ke4MFsbD0ciEIqDnnRyUVZ6NJkqVB?=
 =?us-ascii?Q?677oGeOtUjJFNoFtwMRzO6O2LsNcjQ9m6Q3xlr+qZ+/WgDPvNe4rQ2WnLJGN?=
 =?us-ascii?Q?XKnYgDJey4Xov7CCKf4CREduUzhKtQuqrjoMYaaaB1dm20IpCeuZZJfH62Xz?=
 =?us-ascii?Q?Uyp1EAhzR93QmzeDczCQxVkdc122?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?roiQ2VfS67LT9yOi3RqndQAMUZyrgqvrtP8dJS9UJNT8tI6m+rH2RPGMiUH8?=
 =?us-ascii?Q?WOqm0FcNe+S5sX9iQMKoCoR3EtQ/J2r1+btn7vnjFFW1+8stqJJRl6oJQgWt?=
 =?us-ascii?Q?YI+88Ajj7IupIof0DYTg0NhGEMChrMBuk/Kl55XZMfe5KLA+5DJZBWaH3TCf?=
 =?us-ascii?Q?X3KaGn6tbRUnYHnA4lrwK2W7aqUDYohAZGT1PlBUK2LpNl/NtG3E83KfgcDY?=
 =?us-ascii?Q?/NynRSmxclupvofcwWJ1sEelMeSnOSYxh+LNzC+SdcZDGJpTlO2UaJI1Rtre?=
 =?us-ascii?Q?6YP96CQ/i6Ujg1AfECTlpyuMTVbLTtcAiGVRilAFS3LxH1ZLoHkkk5Mvu8Dc?=
 =?us-ascii?Q?i/f2HJjTuobnh3URWtFRDZNdhPDAKXLK3qFUrWwHpmx8ll5ZdVvyvTlsZuEu?=
 =?us-ascii?Q?iHiUaz6VhbA3D2tQlER3CGy2v4bViB1XYRqOfSSz8c3TGoAq6ruRjDeehbd3?=
 =?us-ascii?Q?NAhuO6/9P3BGgK7TaT0YX++zq2mm8ioWbM5s3QSdVdAG8CRyA+K0844WKNtc?=
 =?us-ascii?Q?AUJ3CmYFgjIzZR7EFuuY6G13d3FbdP5PNRa46Mb5oejNozYHcN7R9qegcj/w?=
 =?us-ascii?Q?M0SbBVolPYZJdGGKRrPoUWlXX4EGNTttJnJm56YYFnY4DvPc1m3f+vpsYX8x?=
 =?us-ascii?Q?ukF+dSmZHhZyGDaaM6wLcFS0SBwfITYn/ea4rFkxUyU4vAfEhqj1aGsUMdLJ?=
 =?us-ascii?Q?/07bPVdrg7/NPQtTw2uIu04rePahvqL3iCSb54ch5Y9P2pqJ4aBozL7NmTW0?=
 =?us-ascii?Q?VWVHoahd7qDkEwFG1HIh1hsOqDC4BQEXqHDhgME8t4Jc8hMQTs5Tq17NBmi/?=
 =?us-ascii?Q?MI4f3R6ylhb3Ue8zKR3ScseZ0yLR6uRcRDrOCF5UdXBTvPAew+b6h+QH6Ndt?=
 =?us-ascii?Q?GQTckG9mN0rWPCF44qlNgSuo8o28xHB6Uea3+GNWWclzc+iVSKh67Ig6q/6u?=
 =?us-ascii?Q?44TTovh6r3JtsTnJlHEBd3frfSPW9s6xn9/lTWWwxvFfeHHpuOo1G6eZEmC0?=
 =?us-ascii?Q?AYUEbHSPJdO4qwHtAPKKi4JJ2tSZTwi1AFFJdutBVnZLnvENmJIbH1tZReac?=
 =?us-ascii?Q?xDXHn/UrA+7HsaCkk2KBLnQ5gpmEJG9tOsa4WOy6POwNk+Rcvhv+agtsDnDb?=
 =?us-ascii?Q?kTJizs0mVuUvctqQBzJliNvzWYHG2DtPftgaGC0WL2u6h+V03vpuhEpu1Y/r?=
 =?us-ascii?Q?BczQtza9UeUola4uhfMMQtMvSlRCILYxuiXURhhon3cIrKTCWPIG33UdaGjz?=
 =?us-ascii?Q?Pw3EAUr5W/k9bP3N2633r4/WKQUb2DAIY03mfLN1ZADa3Xj7yzkXBXshhVBr?=
 =?us-ascii?Q?ltcZwhizOy52QA4tiMVhCYKMODDgJO+QmE3AfoDaDCJwso4ughRfKG3hQ08R?=
 =?us-ascii?Q?xdBYY77BQQu/YxtDou5glLwIt1DEm6bsqJ8lL6tNg4Wfi9b8MTTgh5yxbz45?=
 =?us-ascii?Q?MaOV/8sLWx9sLkOUfn9wbMPNcTd/B/xASe8Ko8jEux7pDRze68tdHxWS5SLX?=
 =?us-ascii?Q?1s9pJV5RnpfiZd0TqtPfAtiaTXgDWDm1qqqp7tCxhEe4md4yNO8Yf/JQwTag?=
 =?us-ascii?Q?kV35NGZqtMfPGtJJTF0q2suZks+apbjOnS6b/x/E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60e617f-65fc-4382-8e10-08dd366e5a1b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 20:42:54.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMUPCv+JLgp7SdLHOYHxysgE99HTHjjLVg9S7VUu+yemIidHKbet1/scdXrrr2Ff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520

On Tue, Jan 14, 2025 at 10:55:59PM -0800, Nicolin Chen wrote:
> Both were missing in the initial patch.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/fault.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

I picked this one up

Thanks,
Jason
