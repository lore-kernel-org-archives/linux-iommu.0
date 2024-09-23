Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F322629F
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727112796; cv=fail; b=hjSIGJyWpkS1Jqd+mSSiHB+0vyp5Zfiyu7E54drpQUt2ymB/M0VQ89vKw+gbr5wGkPpMYG2jxGpDKR2nhR3wGj1AqGBG1Bcl3XNPcfg6b8iWtO8UF1iacPMDSYKZ0IMDZSl8wzCcQYt3ktn/dIrFhve22uijwYDf7pUp0dLaHuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727112796; c=relaxed/simple;
	bh=BqpENWUhij2NwggmBKRfM4jsa7F6tBkQP2AwBeuMcAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=URh5/+TGJpAgjhNxsFDF7oycPIe6kyHe7gNsgqhk87Os1qkT4lB9VeEdKuR4DBvds9Yl/nhcWe/5yuuJsGa8Gp2ZFU0QQ3+JFkZ69kwffhKAWD3SioMGIp5RFlaEO8NdzAKghfCIwUVz27Ah1h3CG8M3LEIRztGUljzVGiZFLDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RW0s4LUe; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RW0s4LUe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHaF5QyRFN/ZxZfqzKiXVzwrMHB30MS6sQmjn6mcB1xhKpyF9NJhG+xelsuCsMYcv1zn3F5u0XMmTYKbq3cBIF0esLV4qMcuF0CWBdWNkG1fyU62S6gvilsKNPdg+rRb/8L9tTiKlyxGg5tw1Afgaj6V71FVIvdb3ZlswmxeyoGlZD1ttNczvft53EY+siFqvR2ggoLaxdfihYd33mrX6aFNxYOLyGCdw5UtrlJZQcY0LCtwPCeI9qoamkJmh6pijkQ5WvYQxwODNAbcJxqpYA/QvN6LDDPVo/zY1SaXTE0hIsrqMImvmePe93BpSgKlLN7v804E127lpFXUxH6W1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqhG55kk0Fy0Ct9GAspmldIlOrYEtjys09WIuShoass=;
 b=wI7ou+kHi1pFRwlUjDJhe4mtSwECYV5zvC78CB2UPGTc8oUjgPONYIY5HsYzQ9WA6KczdEoxH95eQ3Ljy4jDi7FF0b8/e9JjT3jLcTBwVbMCc+RYv389DBR9t4AsgSyMUSegJsdH3BVaMBFb7S9Fz4tEV9Kbtm3W5pn+sf3vujCoTQrHAS8NrT8kSjY2dytpt41eQEFZ6bAyvbtIZ60JXU9UX5yIvGd9nJLt6axsuC7A5fofJppgokHYwGQ1R75igKWshzG72+BkDbdHJQa3ovdlT+uUe9JeJOrrzD1AhAmQL8uuyBZt4wJO25BBOJXiC9WGBH72UUhcVb2C9oYiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqhG55kk0Fy0Ct9GAspmldIlOrYEtjys09WIuShoass=;
 b=RW0s4LUeJ6HzhEWkxXvXZSOhpInSWvdABW3nEq4dk7EhUDxpQYAsVzWRGdsVbowi1Txs9B0BAnQRCJAwMlqyx6YrckSbR5vfLgyolFrNspkQ8vkUrqQttetCauf4RcXiSpWFdB7DwdYbBOr39zP41aftsfPDfnw2KgXbvWhYj/6a92mTWKNsBp3n1F/+eOtvLO01AMapbXzPqne2EWkyciT3HUTTE2z7kMtEIqTl/p1pktBAl2RtaKD9z2s9+YwYI2iNS44fVu4BtnCITL/2C+X7nFoVitgYMZXT9xGEbqmdYdNgxbdap0XCKQpMaJ7WqoQ88Z8M7u2CgZF3bXSJHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Mon, 23 Sep
 2024 17:33:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 17:33:11 +0000
Date: Mon, 23 Sep 2024 14:33:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V1 0/9] iommu_ioas_map_file
Message-ID: <20240923173310.GE9417@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <ZudD6O0Sc5Xi+JFE@nvidia.com>
 <4d9d8863-70ce-48e5-8600-1d487a5de87e@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d9d8863-70ce-48e5-8600-1d487a5de87e@oracle.com>
X-ClientProxiedBy: MN2PR20CA0058.namprd20.prod.outlook.com
 (2603:10b6:208:235::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e12b8b5-d19b-408e-078b-08dcdbf5cba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yAJPgjmO0hmzh+DcO85NX9GKYQLL4P70WGNkCntc17KoL4WBwHk8pwq9qcZz?=
 =?us-ascii?Q?tJgI/i+h8jBPrFLEs+qtukBHHCr9dN7xxjILnjtoXFAbXafirwgUcEs5qfC/?=
 =?us-ascii?Q?j1jDWXFmgxDMfVi/wittbXf4auDhEO5x2G+/WAz5HBCy/xtXtDAyb+1o5Pbm?=
 =?us-ascii?Q?8vXASnxczsaCnptfkUQyqJe209T+Dcvep2zBnKoAElB7BprfIWoXW1FIhXF8?=
 =?us-ascii?Q?G7C8qI9XZvzKpAXcI1BXxGnZmdnUxaJ3MgqLtBbUpOPvvNz/Y1wJz/699tJ8?=
 =?us-ascii?Q?gxfzgStOPDD1BUsRcjyURSVfjEwRTpR/Uf1RBgwqEOIrSBHrb9o0APNCVIfT?=
 =?us-ascii?Q?luvnyyFaUzma8AZqcApgSuquc20Ru6xE+w95y4rjRs6+v/K8FLVaHj6Wnf5c?=
 =?us-ascii?Q?VQmvfBsBws/NV11Bw8PrGcwE7TyyKRKPy+1JpU2JfbdmDjW88gSeElec4fAe?=
 =?us-ascii?Q?YXBuvfGhtbrMbGCjPvHO9HYPayqL1C1fLissAkXjSVXTvCrvvWAFytJNu0Wt?=
 =?us-ascii?Q?wUKGhMDwnExNntxz4ky0wR8inyiqSu0p4p0xkOGBtVzMsO+7FY0xopQOLAf8?=
 =?us-ascii?Q?SSpbk8+8iorbGP1S2lMuEw2zam1U/UlDnXoQ+ktrCtGB0VRyyv+TlYvWgJKA?=
 =?us-ascii?Q?OFp4dMpayncUtMrAt3Cg8G4XFjDHZmQkzPBYRH7zdNYXL+QH65b8kOhXOcF5?=
 =?us-ascii?Q?rStYbue0s3Nz64dHkzAiFuwUoDw+F+3qU2AGfugNkgUaa+Nboz4S8JIyCWnV?=
 =?us-ascii?Q?RJ1GfK8gOKoC2+BEsoWPRSrJGeN3lUcZA9X4ydAdf1Bf7Cv+u8xutKkLrlFk?=
 =?us-ascii?Q?y39GwjtHpzncQIYEy9Yvz7+hGvH6Ht1uE2eot+s9/obFXccyxxo1LmGGEyPy?=
 =?us-ascii?Q?D19CEWWCqF8xtrXAGiOrUzhYL1CzzzqAf/fxjKWbX0Hk0G3h3DntXC4chSD3?=
 =?us-ascii?Q?F3SOJ5eYS8U6FWrKUWqJRMYkgHly8mPXSdXOLBJrZlFuMi9FyABUOHZTUD31?=
 =?us-ascii?Q?+/sUZMsXVSddz54mGOMOVKz/WedNrPo9rLVXCy0+QFSHXTPESzLQ/FRs6+Xy?=
 =?us-ascii?Q?0ugyG+aTlC5XwPkHSjTrjSzCIbWZ7hs/cU1VEn9fFE4epwKiqZFTEpmM/gwM?=
 =?us-ascii?Q?7QUKizNgT/u903WM8V3Q0vNzL1coGdxb5my35X2li7vwOkUL5xLyeiU7zLi1?=
 =?us-ascii?Q?W0Uh1z6H/VGeO/xWnpNdk/XeMuogLBkNJ+pRJtB8kqKO/zW+T+2QkqwuiOc0?=
 =?us-ascii?Q?+4XRnu7ADj7U8iWXgem/Zdwy+7MEzWCztJZIrUWHIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zyhgb0/c+xusOi3q4YQnDDdSnw0WIDMXmS0y6f5w+I6EyPcSymcd46M0mpNC?=
 =?us-ascii?Q?JmtdssUU6LIYwHWWscrNE1H/OW+KfP9d8d9jDEsV5th3T71bXD4/FhvUcYWf?=
 =?us-ascii?Q?muNEIccb+2CO13YHxmRMgJ/S3ocBfaZ40e40EX8PQRza8BZsNQpOLxh695nZ?=
 =?us-ascii?Q?H65UbqCfa7K7Lf5Z6WZ1GUn0Mly9Rv9ZsVfgu1MHUrKaFh3k/dxBg4Hdc8AB?=
 =?us-ascii?Q?kYmfc7fh1Kn6+kgJO1X83GZiRa/yGFzmBruC5pLgEWZHmcWq7G17FtbUKWp3?=
 =?us-ascii?Q?vVRkDVdNUpntb5qhoRbvdgqTuRKZPjfamNE2l+ajufnBh2Fv5HJIO9hy+3+8?=
 =?us-ascii?Q?N4EBx2KZPhH+ZBLfTIefavrfSJfWdxKZc579bmqLikMZVVvVANx43LTngNyS?=
 =?us-ascii?Q?Wx2UtY++Px6mt4iHANgUFEwSU2oU9KpjWumlq5p/6cDPk0DdjYz6/HiLntJp?=
 =?us-ascii?Q?R+9ZlReE/D6GlB4JdZrd7MFay6stUJlYjDyYZSWqx1O2Tlcfzv5JxVo5nij9?=
 =?us-ascii?Q?y0TcNJYLowvAJaWo9cloHd5MYdt1HlyVuE6bQ4J5SsoqenplBg8cpj08m88q?=
 =?us-ascii?Q?5IKzOEsXfa6sJrx4okd5r8MeWdYuSzt5BXfFbypzo3tyl7rQq/PuD5Mzu4PK?=
 =?us-ascii?Q?45OHjVEKadcXgBMpudXEbl1wYanmxaA629mQJ0TZnWJxjLwAw4sSyyvrQVjr?=
 =?us-ascii?Q?+OOFwZMqW1oIg+SPf9ie5/LyKzPRaliJ4szMcPjDAN8r4uaL8gJbNm83Bin1?=
 =?us-ascii?Q?v9ou4kWEoGcLmiHXqU2oV6jvaBRcrFoA1B/w40HjXz+eMKGIOyfHo+8aghuJ?=
 =?us-ascii?Q?qZIWgoS3JULe5lh38hSWvI0Y4vpWkuEh2tlRhSJHyYwkGBhUIl+2CC+mGq5a?=
 =?us-ascii?Q?qBVJjCDK49fE/tp1juui103zyKX/hc3gGd+PtmIl/LsFLizSZ6P27MA2KZuV?=
 =?us-ascii?Q?W5etaiPe9MFRCy5MJfZgWOSHZ2bS9qhlblRhgllC6fcFhf8qxZYXW3keH6yX?=
 =?us-ascii?Q?W3kGEAlAO9sOTbZN9zs1JkzPc7IfqlN/pee7BmHFCZs/cZJ0CuYLlKrFwYV9?=
 =?us-ascii?Q?9rRsNNRk8rZhL7at3sLv7VH9SIvGnpYyGxJZ73ijOZb0P7iyJYwl9YOah8Te?=
 =?us-ascii?Q?yNXH1hhKB9SB9vLWZ7gI01g1LH8wFQlJ4St+GY9ec4JdHh2urvVOpa13SjhR?=
 =?us-ascii?Q?A18HGqcKVFsnjzK+p5DmyjNj22k8jCL5gljO16qg2tXpl2QzKFJKzx4JCoQX?=
 =?us-ascii?Q?L8j408pSjBaEkMojh6Mjuc2zTp7qDD73GTmg7sKGA60cxt9o/Ef+aZSBhktw?=
 =?us-ascii?Q?zxSXXU3hkUfZ9se68x8DN1fF0p39mCBqJ4O/FiLZt4DU3J3dLrStMO6WFWcx?=
 =?us-ascii?Q?ICOkIr5oLwAP7dVh8+XYBaA4dn8du11fXA+skuNmJPwptA0QNwjdzuxw3QeJ?=
 =?us-ascii?Q?uXslpLrJO6yQPnSMk9K3ce2UAHJrDEe7TXtiFxpRBykTugIujPR6nmac+EMd?=
 =?us-ascii?Q?uRD+1KNohFXhSOq9MBhPWVgcMKyphFhSLjqBrobAsTawtDoKILDt62J72Om1?=
 =?us-ascii?Q?XU64PyTR9891OlcSUfA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e12b8b5-d19b-408e-078b-08dcdbf5cba0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 17:33:11.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUOTZI34oYHXCg6EaT6mBhXyoY9hIRsRA2NmIG3FouVN8yPIMlfkMCGzHeB/EciZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

On Wed, Sep 18, 2024 at 10:52:57AM -0400, Steven Sistare wrote:
> On 9/15/2024 4:30 PM, Jason Gunthorpe wrote:
> > On Sat, Sep 14, 2024 at 06:05:49AM -0700, Steve Sistare wrote:
> > > Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
> > > memory by passing a memfd plus offset and length.  Implement it using
> > > the memfd_map_folios KAPI, and the proposed repin_folio_unhugely KAPI.
> > > See the individual patches for details.
> > 
> > Do you want to do this and the other patches as well?
> > 
> > This seems much easier to understand, and over the long run I expect
> > to wrap VFIO in a DMABUF FD as well, so it should work well.
> 
> By "other patches", do you mean iommu_ioas_change_process and friends,
> with VA manipulation removed?

I was meaning iommu_ioas_change_process as you already showed it, but
that seems to answer the question that we will rely on this approach
and drop the VA stuff

Thanks,
Jason
