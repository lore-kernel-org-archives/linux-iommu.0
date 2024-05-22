Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E358174C
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716407272; cv=fail; b=pFOSLEcfj4Z0O48FWtn5026fHn3J66rU8PIB3SCITV18C3yWduqTtIxVe+rpZ10XZYOhj0opplFKZoW243hjgjYnWjqoMFl9sBlVmUzobXHTa34aiJ/nHQ1337WxU2bTCGQtDgKNkPUQGljBftV64v6zVVUpflw6ZB6zp21tPE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716407272; c=relaxed/simple;
	bh=dBSmSQxIp+8EluvdvNn1bbrjwqrfWDCiW7Y1/A82RwA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLlVWvZJV0ab9dkpF7w+wwU5O9e4PAdTxV436n2GrrAEv/DpZ4qkm4tbrKeaB22oMYUpTWkE9Kkn45bcp6ObVagqJs/QDgbol60scgvqLutuTj+qNq9D302c76H+Sg2xVFt8FPKkW4mucLP3o2r4KQe0Zax7Pm0VrYNknzGZsAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B2vMxQ2F; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B2vMxQ2F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deu44E5Bh6yjfv1yPdBcCngnii/Io0/Romc9A2IuftClEOm0ntuTXxgr4o0hqz3dK/0t71VrNqr9K7FGRi96Mteo6/YLsRj9BEcGvafwhX8gyJa9OBFTo5CrONlojOSeFkQODQNMeKE+URM8RlE5ravN5OwOry3cwGR8moEFpQ0sQM8Io8r1Sa2f96giIXDqvjNKipBosFngLziluGC/2yoS1RqZSzNT34OQ/b5DZWTqRtaAxHOjQ/FgrgO/v0la/TEWifjrUXG4qucOR2ZkST89C8mD+lP7hPPU41jyiV/HPukK43aYnrgnMleT2g1nSqLrFQ/lysfQOFlw7sCgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHzrIy+anJh1F9yinOnhJvyLUfX4QLBAwhGnrj9VJ1c=;
 b=TkjoSpjNTtY3paudpISqdgicMZaYsMiqqFgdMUhvzW47qB06v3wlgepbadh9z2ygw2NPatg7miXGVIpgbmsR6aKrw0G6bNX43MoT9uBaWNTumogWUVYMUk9Hcua0hqO2Wv7qPHT1VWV9PTazg03mOTqy0igEFp8oHZJV5K5gRWG7uwMsPrfhr3Md4/WvmBAI/HRFCa5mRD49oMOCK+B98KptDTbvW8C70auCcEzZeWXzH6Mwth828sjOb20YvijeZdGSCnq4CeMKPH3J0y/GiPRYTZ7+m548Efje1zUTvJ5r1rG+jdXbPhw+8SGakfk/0M3YOz0nPevK8zkQ2WPoVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHzrIy+anJh1F9yinOnhJvyLUfX4QLBAwhGnrj9VJ1c=;
 b=B2vMxQ2Fxd1hCpM6IMFh4ckPdU1rYPo+niLWnYhuedwwZIr+5pHCTz7lTmX0XI7edWYu549JoxZDE96Q7dW31pz4YNXhuFatyoploqeN2bYP3vNkSSFVNXBKPV4gsuJNIVfJU5cz7NOI9/Kd9R8mbrU3/ISjv9301A4EUp8YNmBHXEJt0x/Pa95uU/8WQQyT5xonTpj0d3ilzViTFOo1wtD3uDg/7Hi9ZiAeMKN57NiGWJQpWmIt0FlRjWib4cql1Jd0Cr4sg0KMPzsyxA7tb2Y/BKVGvbQI4lHBwMCce/qBkp8WHE53163OtP7fO7yKmn9t373XcWva0lPSBhsfew==
Received: from PH7PR17CA0011.namprd17.prod.outlook.com (2603:10b6:510:324::20)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 19:47:47 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::81) by PH7PR17CA0011.outlook.office365.com
 (2603:10b6:510:324::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Wed, 22 May 2024 19:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 19:47:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:47:25 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:47:25 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 22 May 2024 12:47:21 -0700
Date: Wed, 22 May 2024 12:47:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part 2/2)
Message-ID: <Zk5Lx7IqvnE2q7a7@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB527641C15DD88FB0C44323D08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522164818.GB20229@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240522164818.GB20229@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 453cf888-a3c9-45b2-c240-08dc7a980e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x7upViHPT3YibD3Gexr1pK6G2tqnX4kPZ1h2oaNOwqBGVAG43MTVTMdy6Lpa?=
 =?us-ascii?Q?svUOcSV1yrtL1zISaadWFBpK3Q56n89NZadMu+FK8TlMxQq129yhoR4+Ade6?=
 =?us-ascii?Q?nKg5IUTA+qY8Ab2QZ58jUgeHfCSIgzgY6+J5UvJWj4iM4YrAd6SqFFLLZvRV?=
 =?us-ascii?Q?xne3muhf5rw3boUOSxCJWINKnsKhmX93XC823Pq1ihOQh3Guqm4hyh2/j398?=
 =?us-ascii?Q?TQqzXNcDIvZ7XRFaJG26x33Nu1L6GpTsklF27eqPV2q0mTtokO4abh6NpdHY?=
 =?us-ascii?Q?z08ZqJYSzJHg/BNA+3qtUuGERShlhlsTbqgrIDLn5VL2HYfViSyRg/YGS3NF?=
 =?us-ascii?Q?7M8wcBfOc39ZF8/6Z/29CixAo7DizyEi8+h8DWCpm74iuRjeRbg4ZfkE8l8f?=
 =?us-ascii?Q?YWg9LEO955Om/Wln7FFyT0P6r9mgY/Nq9uG9y5GZXJJTry5iKUkXFybhTy9C?=
 =?us-ascii?Q?8Oj/11GaJjTW/s+G41H0Ys1V8cIxziUx6PvZoHrjMOf1jdiklILAX0RZdPsB?=
 =?us-ascii?Q?eZ08Meok9jaip/Kds8xu39k2HkkgYsdVrVHLzu7r88urG8P9BIYjOfMrgs5I?=
 =?us-ascii?Q?y1g6z+qq9jPaOY7V5JC4dkdNLTmb+CG4q7RKwpoOEtazKgkJZtWhVJ4RLcqH?=
 =?us-ascii?Q?varfK4e2/FxTmXD8zdKmYRIFu2sD33hBK15A0ewYvfB+qvhwmE9sYJp9Wlom?=
 =?us-ascii?Q?rT7qiInn+YFPVYOKzadyg2tA1+IiJNDYH2eIddVkL2OSztj/SORsOyjRCvYW?=
 =?us-ascii?Q?9lDDceZSZJtY0aHDaciTyacQaK/a6J45l/NCKa5L6EKji4CGjoYYg2x+3AqA?=
 =?us-ascii?Q?4j10Ce7vWuFeQpH+RLrNcbgGzCbClD2t9LrlALwvHXf2E6H392p2Le0/IUiu?=
 =?us-ascii?Q?GEZuUZ+L4+EoVI3TnNWfK/H7ZTLzGr4fgobdMZvDKd3Ixg7MMIUFnRLocl+b?=
 =?us-ascii?Q?KBxd3SJkFu6vJF/ZD1GsdAwGccNk8YYYMnpiXWq2myD9fjMf1KvgZn+HPNv+?=
 =?us-ascii?Q?Xud8PxPG8ygfXAlOl623Js8kh0ASuJnDR/RvVGamvqfLOTaotpMTUlcYaIpy?=
 =?us-ascii?Q?fre1DwFBA2XJehDDyoUkxK+SeDx88h9FBnirv0VQWTp7SH63QC+gbC2HHQDG?=
 =?us-ascii?Q?e1KL8U3joPEJyVDZ15fn8KVQR8B2vHq65IhN6IyzCIZb7VnyEqPTUW83V892?=
 =?us-ascii?Q?hJAZwITVxF9JbiZnnyd7Ffjmx38iMSbdrS48a90tJYppP8OxPUZtKp7i6XtP?=
 =?us-ascii?Q?yxqByt+x+dJSOBk0R9cXk4hD99Prl7lHxQx4Svc5+JS3QqoRp4dSRv3djtKp?=
 =?us-ascii?Q?zmTAciPZxwXVwuFdBP3vBMJ76jwNg9TznJLvgCxghmosNuwyVGeJ6Yzc0VnW?=
 =?us-ascii?Q?0Mw8658=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:47:46.9622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453cf888-a3c9-45b2-c240-08dc7a980e27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718

On Wed, May 22, 2024 at 01:48:18PM -0300, Jason Gunthorpe wrote:
> On Wed, May 22, 2024 at 08:40:00AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Saturday, April 13, 2024 11:47 AM
> > > 
> > > This is an experimental RFC series for VIOMMU infrastructure, using NVIDIA
> > > Tegra241 (Grace) CMDQV as a test instance.
> > > 
> > > VIOMMU obj is used to represent a virtual interface (iommu) backed by an
> > > underlying IOMMU's HW-accelerated feature for virtualizaion: for example,
> > > NVIDIA's VINTF (v-interface for CMDQV) and AMD"s vIOMMU.
> > > 
> > > VQUEUE obj is used to represent a virtual command queue (buffer) backed
> > > by
> > > an underlying IOMMU command queue to passthrough for VMs to use
> > > directly:
> > > for example, NVIDIA's Virtual Command Queue and AMD's Command Buffer.
> > > 
> > 
> > is VCMDQ more accurate? AMD also supports fault queue passthrough
> > then VQUEUE sounds broader than a cmd queue...
> 
> Is there a reason VQUEUE couldn't handle the fault/etc queues too? The
> only difference is direction, there is still a doorbell/etc.

Yea, SMMU also has Event Queue and PRI queue. Though I haven't
got time to sit down to look at Baolu's work closely, the uAPI
seems to be a unified one for all IOMMUs. And though I have no
intention to be against that design, yet maybe there could be
an alternative in a somewhat HW specific language as we do for
invalidation? Or not worth it?

Thanks
Nicolin
