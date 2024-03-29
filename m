Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3E3BB55
	for <iommu@lists.linux.dev>; Fri, 29 Mar 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696461; cv=fail; b=Rac4zaJeqbhhQX2iiQmy9VYWCii3/rs9uYP+20TGArtm+VKhDe2AbezAWnj9LA7xDDC/ZDkiPMDAXWdQrmMCLxXRyDfaAnn1UZkhGNoUvOiuFiJg/jTeF8rIoZo0QHzQFNLswf6pQ6/+E9i8dKLWXWYJeFYqk4SolEkJ4XL2ugE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696461; c=relaxed/simple;
	bh=Bufla3PEgCQCjutDNwgXuyS+hcn2BmeGKEHGHQRMZu8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t86MOzqtQIoKG761g/dUaawjZJYD7qjb4GCSiBkza6LB+N2gbAYamrV33+GscSKgQ5XE2WK4jJ59dWFh2j5moJVJCG8jnDJt6elMrF9zYlZ5M42ZCune8hr8gVjCg2u1tBQ3YkLIdx7cI8UZFMHKJjCIBkJkzo4Nz+3jB6yDBgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qx+OzPmo; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qx+OzPmo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbTVqJPnAc7RY0K+bDnKTHoJPRDBUnE6mA4UfAFvsesDlrJyKnuHopIAHNePgsmkSn7e6YNxU7nZWS2TmoK36pKLOKy+5lumxSwOyVr+iU0dRf/wVnWkFCQxP8UYUY8cJReIEcaFl6Kw5Jij3x4QYupHACoH1GSQ3eMz+fXvPc1Yh4pfO7F7TL9gnqf6Jn8zSoaBrIQCTRPy6hhzySeu9BHTAGBUUpV0WMOGSl1KubXv5J7SICQ7u8ioECe+ultMkbPsklajoWK2EyTc6ZTsUpwTASyP9HBy9WNncjGC2EHu0x138LkFkf2ELPnUS8b2aedEAt08P/s/K0YzzxMmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw1olCfHBbuc2YYkeBohROxjromMzBqw80HjlrjRivA=;
 b=SnJZYDlN0zn8peeeudhYhScqdYjxtzMgLAP7yKwSBD0Vj6brrYtDz8RsZmnYxGLZGnnTR6f2ifBm1E1QrTGbOqk9VOJ4G5tKlQ+FbiQHsvH+CcKTCRwm1wSIOw+gteT6bMzqMKFobApec02e6fAdPjWDkfPwyiTOPgYB1KrQcJo5tsAAqIMu4lDpAnZxCIS9iLPzFwm7IbumN/rafgItCLS2wH6sgfRjToHzIsvQanHB+h9Jt+IMR1NSYUl8UmrnyufD+mLo2xj+SmSkp0OWX/z9mA+Szli2HQK0of1cy9WZhWNNB/FIS3I/oZ3J4AXOPyG29ZoqeHTzQNE1ofA32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw1olCfHBbuc2YYkeBohROxjromMzBqw80HjlrjRivA=;
 b=Qx+OzPmoh7fvkg5hoOZcYT/0MqabznRW3I3qwIle/m8QbG+Zp5B/PnD5T8j1sUb1NtqOXI580veX8kzNePQK+NGqFIdrK0J86Z4Q04EI7S4AJGxhthtxOT12OQ6AlffDR9MvtGARUYyGz6bzt0SYHz8A6RMft8aVrxEoSN8SjG0DYqKkyQhzhp7bwEXerd2KmU6dNQiDh33JGKWohls0s1KHLnQAG6xR2QUn6QUoUcgueMswwtgw/K3s6NFeYTNyeo3yWvvGoRF3jOvIyC+aizKWANpRbpcQ+RukLcN5ecIh82K+eGdmJaQAVlKmSh5XfTTVxF3Gdc+WeF5UCem+1A==
Received: from DS7PR03CA0255.namprd03.prod.outlook.com (2603:10b6:5:3b3::20)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 07:14:12 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::81) by DS7PR03CA0255.outlook.office365.com
 (2603:10b6:5:3b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39 via Frontend
 Transport; Fri, 29 Mar 2024 07:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 07:14:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 29 Mar
 2024 00:13:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 29 Mar
 2024 00:13:57 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 29 Mar 2024 00:13:57 -0700
Date: Fri, 29 Mar 2024 00:13:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Linuxarm <linuxarm@huawei.com>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Michael Shavit <mshavit@google.com>, Eric Auger
	<eric.auger@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: Query on ARM SMMUv3 nested support
Message-ID: <ZgZqMymQY4pL77iw@Asurada-Nvidia>
References: <b8c1b2fb281246da94b35ceb5e27b538@huawei.com>
 <ZfI74miZ1ss9+Kz0@Asurada-Nvidia>
 <4a37c695bf84425ea5159b82c202cb81@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a37c695bf84425ea5159b82c202cb81@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bcdbbf-a91c-437f-f5c5-08dc4fbfd459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oHkIjtM1h07NaRRK6QM0ZVkgWtWoMgAXpPTSZViYjb/YKoDq7Yke162ue61rALKvA+5bxr02HE/1uSVMQ7U82YM98fMl3m0bS0G7cl79ZQuE4ggvhvmUJKtD1Oz32eXhGz2ylH77SG6AMiVcyM4SjjannQR+irxx11gBPztN3D27AQrxUz/PR1czWNlobwmHg1r3i8ZDBbRe17xSgtw15Z1ldRODoSfb73n9g8yHIHVVDoL6T7IYoMEBZkDgLPcFwVyzPjsTjamNSppJbhI4q4XeAnzVcFAhs83DJzvxVMF1WDBotLcWfVmxrIWOf1Jskw0xe2o/uUw3TnHm4MSNEXlc8YMGUbgzYcl1dg7ZpbPa/Ms/RecSIIaLCf5FIofu36f9npHK6js+yZRIm1SWauUHMgXar14QGMSbUfmVlSSaP/35G+SM29RFkmXkPXVcYT9Iu5Xba1zrzbu6hpsNoaUKW6L285lM7+MNwLiNIRMQB1Lpi585Jeav/K8/J0/jwIp20TJCn/0bqn/dzqoCMlL41hFYyApZPjAH1msJFQg90Xihqg9JWuv4ym+BweqqnDNSrAdZFVnmpyU9Wvei2cn+RszdKJJ5bF0D4bvuT0RowPFTCUWkhkyO7GSJo9Bs/L2ieRzJVjv3GaadNqKEjsdeDI+xheV8/WKTJLJl1b/A3ptXk07RgLa3mOIvXFxxghFEKOL4/qIgvbykJTPgw0rx/chPkW+tmcgxM6IZRRla3rXTi6SySrdblVaR7bsO
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 07:14:09.8218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bcdbbf-a91c-437f-f5c5-08dc4fbfd459
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037

Hi Shameer,

Sorry for the late reply. Having been occupied by multiple tasks
lately.

On Fri, Mar 22, 2024 at 03:04:42PM +0000, Shameerali Kolothum Thodi wrote:

> Thanks for the reference to above CMDQ-V. Looks interesting.
> I think we can have a go with retry logic first to allocate a new hwpt
> if the attach fails. For now, I have a temp fix where I allocate a new
> hwpt every time.
> 
> I also noticed another problem with the commit below,
> 6691a2f("hw/arm/smmu-common: Use sysmem for get_address _space until !!s2_hwpti")
> 
> This actually breaks a virtio-pci dev assignment when that is the only
> assigned device to the Guest without any pass-through dev in nested
> scenario.
>
> I have a temp fix for that as well here,
> (I know it is ugly!). I will revisit that again. Please let me know if you have
> any ideas.

I am not quite getting the case here. Is that virtio-pci device
behind a nested-SMMU while there is no S2 hwpt? In that case, why
does this virtio-pci device require a "nested-smmuv3"?

> I still have that io_uring write issue mentioned in the other thread[1],
> but for now I use io_uring API only for read and make use of normal write()
> for updating kernel with page response.
> 
> I have done some basic sanity runs with our ACC devices and those seems
> to work(of course needs more testing).
> 
> Please have a look and let me know if you spot anything.

I'm glad that you include the fault handling support. I'll give
that a try.

Thanks
Nicolin
