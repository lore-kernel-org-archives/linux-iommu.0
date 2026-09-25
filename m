Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C1470421;
	Fri, 25 Sep 2026 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339022; cv=fail; b=ZGx3cKzmvoZakJtr0iL+DbTyiG8y0ziB+1lkpdfziqOvjC5B0lEkHvxiSw9DsTSlrDgoo0HEb2zlnMCxWXtbEP5PXB4B7DMcvu6GhgSGDHE1307xpqSlRAcvqEa8pveDaN7fXTm2PLpj8n+uJDefKvkbij96JdLYCEK7d/b3lQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339022; c=relaxed/simple;
	bh=Pn57lsh+13viBpZoHK++CfEq5m4aEJxZyqa9AvNlHzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UCk+qq/4EmFtd2ZtV9cEEdDk2PUItzYlqTI4Fo4LPBy14++xU48tvA6JW2IWxEjPa1za0ya2btN62m8f4qJhrZgyxAg7bA6wYY8YCpuEW383QS0hcA9FQW9roYorceHkLK9s1rWATHpkaQmw+kaPDs95urAerBGkvyAJdHIJvuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VPwsSCJS; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VPwsSCJS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVxQ0QJ/FPygWviGiXOq1mwlGYYih9PJSkDOE0QDbckgkGiPi6blVr7qKrANQ5+R1Lz5OC9Yf/37u1Sbbsu5yG/u9eaN0qAopMTaSiKUJZJCX55gqzuUvBafzMLGF9G3aYPBQbX9N6h78uVXTvOmOcrv10qDEwN6pAQwsmm3up0NUVH2eHktmWsmfTczOlma4icTBm9/ARSKEKZ/bwuXMPm3yrWpwvR3jMEhtgtk5Dv0fckB0zYNHDxTLYFSpTtPds+v+WFcp8yyVPaUG8nkpwbVThmYJvIQLHQ9T1hzcpSDeS+Z2lhfBxqPZ0WdQLt4eqpq2cVnwFcyuCg//xi8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaDgxJII/99g+pq9Eh/y9y7Pza4GtFmPk5ARjPCxeQQ=;
 b=jF83pFXYtY2PDXCoHxiqMXwzhg//HgtNGTJMsPoULoLApVsYS/EA5U2y+BstSSmpPppDA/Ic7T6zGLf30q+cjk4ikqV34z+G6XL28um013TKfVXcNaeoe5Jqo22nOqZerYyWTgPRz8y3lpifIVBgcHGfNI/lie9gyCfHyEgsvdDxQTmLzsOv6pXn/hyhdxPkksANLHGZ39dRxLN5RhZpBZWLs2xhvXHLHQpjro4LxP+m03lbVuyj4A0hqYnRtFClZL1jaDTdzyhijRXvga6p87F8lKHcn//h+G5kC/bEXajG5NZb8R9d2NoSugqcmkBb6ihraXf5CS4YBkbRvss8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaDgxJII/99g+pq9Eh/y9y7Pza4GtFmPk5ARjPCxeQQ=;
 b=VPwsSCJSxfJVNHKB6ki5OiS2bo+IuzAkj+JjHKdnrz694Wz8XHH84mBK6724x5elSvkZuCP6dHq+QtZuxVAVrL0sU6QcYMx6af49Ld4S5qo2wkaFAGS4pKiM5wjAAsx+h/VriQWqXytZqYumJignPAB/rsb5Jz+f4ln82U+gq4pg8lq8Njk9ECNhJpDyxW1UQ0BS0TGx3afyAFmcGDrwN3ioCeL+iM6HxiRBMTIRwy9CCdfYuybDP1PMADWzy/1lclzDv0EURwUYHFSgLD7rYRcQwte8kusPb29df16FEK25v32PkvWEvxlntjLsv60kTg4nzlJIr79uVhc4Bzdjjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by DS7PR12MB6335.namprd12.prod.outlook.com
 (2603:10b6:8:94::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:23:07 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:23:07 +0000
Date: Fri, 25 Sep 2026 09:23:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU
 parent
Message-ID: <20260925122305.GG9354@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-6-aneesh.kumar@kernel.org>
 <179027891416.104879.10365675178574704349.b4-review@b4>
 <yq5ald8pkhj7.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ald8pkhj7.fsf@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b68548d-d2c5-4233-0aed-08df1affc15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	8d15WZuchlNS65RszopXetY69aNTLea8j+tr+vBiRzK+zBvtynNSS5ZIm2gPPC9FUhXqY2dIXUl9+1zvPdo1zQT8YjCIT6XZudJ4pkI6xo10WTjsT+KN0oD9QM0WqeRrVkifFLdBLHZOczCkBXYj4nos8f8InMDzSqWpt72avn+QLREdhaigBPS3BVJ9fPQeqHr51FKJ4M//CHRRwkmxqOMazE9MlWJLJDugx0yPpVQuVnuHzk8a3coEd7+ZPTj1o6oShHr3MkCLmZiGaR/unEJslLAOWJtxftFtv2dicgJgqMSn5eurPl9LWuHG1J98EkC9EW0OOgo1RIKTElmsCMjZHzZ/uE1bCl2fS9ZdNqITFEmjcT3SYhLQBC80+n3ni5Z3r4Cbu6PqRkE21MpFF1tDnlyq+KzBpOUKMvlD3kBpht3nlmw5/KOfQA2R/n++RwKIlEoLfLIhTQuWF93MtfhwAXZZWRjuxW8y/Nt+17xJRBUsKV1QBEduoubxKw7cLkGM82WFHWBL/KF54z/ptL9b0N8/KiNUWBC58OEAPN2Snh+1rCs55Dmyp3l7JIQbTY8SgBFd7v46OF6M03oLUToFpS/crWMioE0xX2NBMHG0P5RMrD32VWc3/932lLqRJmLJCBuV1G4BQUWotHGmfkTs1EST+bifkU5eGiLCMF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gQGXKawmqvQO5cA+RQesO9+oBW0ZwxER74HHk28Ax4lCq1y/IUWSXs0nNx58?=
 =?us-ascii?Q?M9ED00yTuTfPy72Eu+gb1vbRYbfZxnh2UA78VISZswKHVebya6NwwSxf2IXa?=
 =?us-ascii?Q?/mKy0wy2Bk2A9tJJHJVYQX6DEFOQ+f4VPzSX/EI9KdWRiLJjoKIzxakDGB+e?=
 =?us-ascii?Q?tpo7+WG1wlH5sReSSHjUvQfUzJgqwbqL1CFvn1guO/kw95KDHaZaIeG1nZ8R?=
 =?us-ascii?Q?p6Xeo2JLN9pVBX7+S+HxwugIb5c8MqqCeJlx27KZ5oCmQmcoEySDCAWpPv/L?=
 =?us-ascii?Q?2kXBNLdN6RqLdl+9VDr4h+1V3IkXjWaZkyr4dU6sfxaUJAmnXMKi32IvNvP8?=
 =?us-ascii?Q?2ong/gKAkaEP9hk/nZoDNb74RjaDA49rihb0idfoJBi9HekH2H4r6UiVz3fB?=
 =?us-ascii?Q?BLwd0j9SXh+plAGeyy3l9p2GyHjrykXo7411LBQdt+8cjQK6TEPfHtcdplNo?=
 =?us-ascii?Q?VQexzByJSxXAS1xACKEVnTT32H5hnrE3mxCo4mzpJ5lFrOUUoo86oGeXI2yF?=
 =?us-ascii?Q?Em1oMK15w4pGcgpcmG012dSNNWaJ2uuJ4LKcai/WNC/rJBrU0YvYBuZl6hmW?=
 =?us-ascii?Q?Kri/y4sBYX1UMzWBQLt8yXFOAnNFkTi7onaayxnc9vU3upBQsPx4jsNndfnJ?=
 =?us-ascii?Q?pjZ36wHZ37EcqA/Z0vQzBOKA4NXffDizFrKhyaAvp1AaZjhwYlffQeuJoBkT?=
 =?us-ascii?Q?rlfSOs6Rc1dx1mQYnMurucmDLXPC/NGW8L4ZjBQ5TcQ1tpdy2Q6WjZEdZLph?=
 =?us-ascii?Q?/ddnaLWmPQca/Zk/lvO4DkWUoz4vCz6hDt9PSFMwjg0A2fK9O4FrxIDTOYdP?=
 =?us-ascii?Q?UI9gtyVFbIiNDxVL249n6FrVAKjRECARFRznJm5v72+ZrSBRcUPhu5VyTS4e?=
 =?us-ascii?Q?vNgyHgIXumDPOBNkNBS3muWZ8dD35OFJmRx6MoLdg9Ffjw6JkR+Tz0I+TFsT?=
 =?us-ascii?Q?0eHf8NXF7xWKdEFJ9baiuDTpuiEVQSDUZsYD8BTRH2xvaZwkR54rfMwuP1xN?=
 =?us-ascii?Q?xbZyZd8UTKJQUh5wGsdbVgbx/6STy+JAGsUX3k0z9yRjsyISled8iM/wNuCh?=
 =?us-ascii?Q?xX/8iLTD3IBSLHSR6AQ0vRo27CvuyAC5CVVoNufikByQtQ1BeZ7WuW5C9cnK?=
 =?us-ascii?Q?6VqXzrdNxsBFvo4Jt+mWA4MbLbPKddDutqLkVrLDH2usImpPQkDbYHdFEKxE?=
 =?us-ascii?Q?2AFQZj+RIa59Wr2+SmZFzL6tmub15oO9NL5PeXtvWyBYVZWksWF8j/IZ3kYY?=
 =?us-ascii?Q?W1KfKc4FqsbjLoh9Js5/wGeMAwcqgoT0R9fLXIXAnzOQPMs5JY2vFruEbOTi?=
 =?us-ascii?Q?Oo/851TEHoQgHlrOTLDT9cGNYmMo2pHUxd76sao6KVpNJ/A6d5w5nh8ysuzG?=
 =?us-ascii?Q?iTbkspLyXtxiy5r1t6B4K9zcfo3QdCPqDZVdd/23b6eSpE7JKK6c/U76yAMU?=
 =?us-ascii?Q?cvl+rXkl360AJi3eMNOx+TeI5RlJx4GcQKipalf8DvZqHpP7NRW7BumgGPo2?=
 =?us-ascii?Q?sYl/29MuI3NDZwv+QoRg0o2OSXt4aI0yYgagDqfCBsp+gMnC1w5lC6nXZcN/?=
 =?us-ascii?Q?JBJ/xpOjSGRxig7umnef1E+wWKmVZNxdxcKCVpfEkgNsF117e03+S635H4AC?=
 =?us-ascii?Q?YyICkzdV04iUeUd9NjtALVACGya9MhCK8EccheavP6bApRvbti7prnc71WR+?=
 =?us-ascii?Q?DzMi64mWj3QM2e4mZo6V1p3IrE8KTae9MKLV5/sIQbHEyI0r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b68548d-d2c5-4233-0aed-08df1affc15d
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:23:07.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SnNOKw6+nCKuUjoRAQGBIKUumqqps/ywzSZdyBD/htyxBUvouCOsGrpkrMSfnrN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335

On Fri, Sep 25, 2026 at 11:18:44AM +0530, Aneesh Kumar K.V wrote:
> > The TSM viommu should use a NULL parent domain, it doesn't have an
> > iommufd managed S2.
> 
> How would we assign an untrusted device? I currently follow these steps:

> 1. Create an HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT.
> 2. Allocate a vIOMMU with viommu.hwpt_id set to that hwpt_id.
> 3. Allocate a vdevice with alloc_vdev.viommu_id set to that viommu_id.
> 4. Use VFIO_DEVICE_ATTACH_IOMMUFD_PT with the hwpt_id.

The vmiommu.hwpt_id should be 0.

1. Create a a HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT
2. VFIO_DEVICE_ATTACH_IOMMUFD_PT with the hwpt_id to establish the T=0
   identity S2, no T=0 vSMMU
3. Create a VIOMMU with no hwpt_id and the RMM's type. This triggers
   RMM to create the the T=1 vSMMU inside the realm
4. Allocate a vdevice on the viommu_id. This triggers RMM to create
   the VDEV inside the realm
5. Setup guest ACPI tables/etc to point at the RMM's T=1 vsmmu.

Now both the T=1 VSUMM and T=0 fixed translation are setup.

If we loose our minds someday and want to concurrently have a T=0&1
VSMMU then the the first two steps become:

1. Create a a HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT
2. Create a VIOMMU with no hwpt_id and IOMMU_VIOMMU_TYPE_ARM_SMMUV3
3. Create a vdevice on #2, we'd need to fixup iommufd to support two
   vdevices for the same device.
4. Create a nested child HWPT IOMMU_HWPT_DATA_ARM_SMMUV3 from the T=0
   vSTE
5. Use VFIO_DEVICE_ATTACH_IOMMUFD_PT on #3

ie there would be two viommu objects inside iommufd.

> I use the same iommufd for both trusted and untrusted devices because
> the guest controls that transition. While operating in untrusted mode, I
> use the iommufd to insert DMA mappings via IOMMU_IOAS_MAP.

Sure, that's not an issue, just don't create the *TSM VIOMMU* with a
hwpt.

TSM viommu driver just asserts the parent is NULL, since it doesn't
use a S2.

Jason
