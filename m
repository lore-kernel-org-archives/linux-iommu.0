Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA42584
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 20:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxIkrCD1gyBRKHHSzYOl/CDkHAfTWBe8Dkmoti88eNsRjr4/eT3TvVeuSLVpHqvfZkIWHT8ptuT3WviJVP1Ne80WGJS2sNGnstOEgrtwXxULFDcZSWg6Dnxz06G5U2bD8K/at95A9/sAG1EFLVHUKoiTLQMm/e0kYCRh2wy+W7IOKL+qsC4aMygK/2lZLwgNYIS5on0z60+K7Y66C5hufNNUKgjmdt1/CPnSo448MNbvPXL2RFfdStxCq8/iTvwj+Y5bvBBBNMWnIg4vOSIjahuXeJDjM5nOTwQhVkB8HAgFbE1Hg0K/JJVUdv4fExMVNqA1LjP9weldLoTo5BQL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yo8Nx9qnP9AyF69E9c1KOLnKh79zvlHpfgO5jBcRwY=;
 b=XGgSvSWo4cB6S9XZnVqIXJ7HA2otUSHr7jghNGO5fjxIEVbpHbi/uMAfuWAeKd42yP9r/PbPtreY/FVxWarH20aYLni8i45Awe6JTkvybDUWEVZC9Dh+RKX2C0Gg3QnBA0kTbfwxFBdhj/Khx97DMdYWvJv5RrCuIN4TA+OSHzj2U3ObxZwH03D3mmpPv0Cd8pq7l7EBnNhWirzpsnr3yG8M8l/INX15cuNCIQND89kkyaUYD5sKCs7NFoVy6rAWyq/tSQvA2Kxe89qZ9JEyn8LpT++eadLSi2Qr9HcH5K/MhmhQiHa0J86GL7fPJz2PHf4bZYsc19HeG6PSd06w1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yo8Nx9qnP9AyF69E9c1KOLnKh79zvlHpfgO5jBcRwY=;
 b=DaQW7tbD8U4dPNoCOFFMLketwls86zIsrreQuFgZj+dpMuFSge+jicHOvT9L4yw4+IPa9BBTlORPyqBGhGVMqHZ9ug+ZumDlB7q0i7/xQ48s4pMYSPvw08Xvzd8IQddst58yTVzySclC9oytQU8cRBulMVIqeu1bliXwvdQmh/zaX2x5H6t9CgrNIC+vDGVmWYq+N51/Iho8IQ5bVSCzGa6LYItbD9vdW7KUVi32GUoivqGPGTagLd/VJyRwIhB353E31gwqbYtPfax8gDOd1HY67dxz5jQz1gmt28ziT5L332+wci6sGMoLsWG8DYmm/MFNJf0XQDeM9HFxSoZo6w==
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 20:57:31 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::56) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 20:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 20:57:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 13:57:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 22 Mar 2023 13:57:25 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 22 Mar 2023 13:57:24 -0700
Date: Wed, 22 Mar 2023 13:57:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>,
	<eric.auger@redhat.com>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
	<jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBtrs3UHK55UUNYe@Asurada-Nvidia>
References: <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
 <ZBhZiCOQHAxEaamy@nvidia.com>
 <ZBiCEAqP1OU5EvoG@Asurada-Nvidia>
 <ZBiEE+QLjPpxBjkQ@nvidia.com>
 <ZBiRAVROma5/Os2S@Asurada-Nvidia>
 <ZBip4sbxUQo8RjGv@nvidia.com>
 <ZBjOooJZcUf182ES@Asurada-Nvidia>
 <ZBjb9sKkAddFmtOU@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBjb9sKkAddFmtOU@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: a076be8c-8058-44f7-a006-08db2b180dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gv7B9KFbMODYZov69iknx+XhpXibZLg3Ew4CvuDoq7PLyzMqFZq/kxteTinYuIYx20VYEk8In5DNovkYLEEYjg6dTHi2niAALCg4x2Y7oy43sw+MSGYm1Yu9UQAmH6iL/HsF4T7DTFD/rtvz0QjLXHOkqKKG31ZhXeuwfnOgANe+r3q15VG9BSd5D3uKE+2WkJKtvtYi5aJeliv/cPb16cSjupdOFgsTTZnRT2I8K+5s06kwuAdlHOddsbk3MC4zq+ylE9s0ciKSG5Wloof8qpabInG6Xx0JJwLcMd3+UD6Lu3BADmrpoivPAvTKMIwv4c83gxaVZT0jQIU2GCT6iBv+Q3OchMG1MepycQMC244N7rzOJ7phhQMmpYeihFTDjtiy39gdtd71/bDl3wu/Z83M2mey5YfgWvQJ+rN1mvIS4klh7XHHQDFHMP4nLa8JRRTK2URsGScN5Jn/A5ew+vedANlIeSE/a9OvAZ5Ut+osE6iyt1WPeSUeAmnA394YqggyW/9OXJmlCUFve0mZkFN1srtTzVnjF3kkVJkgkk0h8GDzihyerGOnqU567fmKulrxaDecIAD3TAfKQoejFsWoV51e9TjI/dLYK99F8xKVYKl390cFE0oq8f6yE8TiHaDN/ReULxYdTulmdTYGAcpcqq54jAEgjYNpEJGohYKs4dOLFAdDUuHKVaKlJqnu3mtlFAYGDRmai/xc7khtc9NXL24Y/3ibxZgLzDAGMu0HwhBoGnrtDnBRRDa3h2uK
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(36840700001)(40470700004)(46966006)(356005)(478600001)(7636003)(6636002)(316002)(9686003)(82310400005)(186003)(2906002)(70206006)(82740400003)(8676002)(70586007)(26005)(4326008)(54906003)(33716001)(86362001)(40480700001)(41300700001)(7416002)(5660300002)(47076005)(36860700001)(336012)(40460700003)(426003)(55016003)(8936002)(6862004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 20:57:31.1618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a076be8c-8058-44f7-a006-08db2b180dca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965

On Mon, Mar 20, 2023 at 07:19:34PM -0300, Jason Gunthorpe wrote:

> > IIUIC, the ioctl for the link of vSID/dev_id should happen at
> > the stage when boot boots, while the HWPT alloc ioctl happens
> > at CFGI_STE.
> 
> Yes
>  
> > > > What could be a good prototype of the ioctl? Would it be a VFIO
> > > > device one or IOMMUFD one?
> > > 
> > > If we load the vSID table it should be a iommufd one, linked to the
> > > ARM SMMUv3 driver and probably take in a pointer to an array of
> > > vSID/dev_id pairs. Maybe an add/remove type of operation.
> > 
> > Will try some solution.
> 
> It is only necessary if you want to do batching
> 
> For non-batching the SID invalidation should be done differently with
> a device_id input instead. That is a bit tricky to organize as you
> want iommufd to get back a 'struct device *' from the ID.

I am wondering whether we need to have dev_id, i.e. IOMMUFD,
in play with the link of pSID<->vSID, as I am thinking of a
simplified approach by passing the vSID via the hwpt alloc
structure when we allocate an S2 domain.

The arm_smmu_domain_alloc_user() takes this vSID and a dev
pointer, so it can easily tie the vSID to the dev's pSID.

By doing so, we wouldn't need a new ioctl anymore.

Thanks
Nic
