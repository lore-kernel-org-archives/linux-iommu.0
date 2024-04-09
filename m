Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74756A033
	for <iommu@lists.linux.dev>; Tue,  9 Apr 2024 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643202; cv=fail; b=DWAoaDhg/RS2oHinusO/Dtbi9PvumwY//MvR6m3yNs7WrgfXhOlrDOkkZBXtdUcFUKtz+DNaQsQNYXG4ez8ojc2jrfNrOh+3Ezh/CO3A6QtOlBXnKejC6ZfW5UDqPTUsGN0VN+5y/8ndIWFqh5pE8tcG57NODGd828ucrqZ1MUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643202; c=relaxed/simple;
	bh=1hvJwEWFqOXbTQSN7tgqiYq7m5d7R8YA6C4A2ik5aTM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1dqL79TVAz4mPlFDEPcEyUZwfn91EOcc/SrxET9Q9D6OMsfGrMw3XnfebQoTCampVnGf2ruS8Qk77SSfLBcssc0M3qH2x5DfSuG5UBhthj2KJ9o6dNw/W5tNS/1uZRYWW/huGhgJkeqs0+Gw/avmYEFCvYWhmT9SXZ+6XIRpTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p8TSBcUh; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p8TSBcUh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPwTUcV7yymb3yaatRnAHv9nzIpFi8uk/Dx/she9wKSgcq1+fi4gvb/dT0ayzJj+/HnFIQCQcz2/l+bjrhhoSCf1OIjgFDSGWe9PFHsC7IqzGag2iWmW9S0IjcphPLGvM4r0B4xsOScUVuzouypu1djXPUy9bZlpG7EqK8JSa993C0IQGCWDbdjmgM77LlZDfUUA8DQtpql7SEk9H3ZsM/miMM9IE5VmAGsNy7F9mJU7BRCPc3lEoWOAQkY8GtUu0pYsAOHzeKXuUHKg5IldDnGqJ4vLtbo/7aqtS4QiIIJxM4RpKdP0/AYoAhJILzyPC4d1BsF0mscXygOlffJH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6sz3uyDEjHTRrXXvLuh5kktlUaPRXdZso4nlKPq5uU=;
 b=oD/AOHbWe2MGenMz5XP4+zEWb5j5ah9zAOvGUzcMvtSPTw7/NK3jKimxh2tBnLoAn1LqgScChQaud5JTzcJeLCuoNgap+f1IPqzKnDp1TDLPJCt7mJSXhVFEV4Vczh75DYAU0txc9w3QxuBW+9/98sZ5MkoZ4CpiVycOLNkclD+u1O1G/s/tij9Mtt9vvb6c/JD73kE3gVRqmRZKzYZg36ADETccmZEzluae+orbRRLxAa62Y9Wmb67sbzfLrVkDRzYf0idMUuAK3qJbAMWweGsuh7Esl5UPoFPSDpqetqidM/wHEq+sQEz8qpEKIV2ewe1IuLd9nw89JzXsX3b1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6sz3uyDEjHTRrXXvLuh5kktlUaPRXdZso4nlKPq5uU=;
 b=p8TSBcUhI71YcS1UlmJAYiyuFHWD+Dw6PRZhKUAM+Q63eL4NNMAQQMeL0P6SpK4b+dQRGqOb/kVLMxenCgx3yRvPe53xAJgV4Y+ect9lRAA5WeOJ8uB84H6Q4NqTVwctXyJNF9FqE4y6XaY2A6d+6SH2mtRJS7zMNM1sj1ZmGGh+W5qmgoMS2cY9aniwttW6kwMwxuWSZ16a+utxXVV47ObqD+hDCzcMkgVpFqqslvtw0nZiguf39Wavk3xK25xFZLdKZ+0IkyF3QPdXeEaf5Cbrt+vYwQNwx27Kl9geYXXdr9ZSV14mrz2IX+BLKHwa+9z3N89adp8KbOdlNfqK7g==
Received: from BL0PR0102CA0057.prod.exchangelabs.com (2603:10b6:208:25::34) by
 DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 9 Apr 2024 06:13:15 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::12) by BL0PR0102CA0057.outlook.office365.com
 (2603:10b6:208:25::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.30 via Frontend
 Transport; Tue, 9 Apr 2024 06:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 06:13:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 23:12:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 8 Apr
 2024 23:12:58 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Mon, 8 Apr 2024 23:12:58 -0700
Date: Mon, 8 Apr 2024 23:12:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Linuxarm <linuxarm@huawei.com>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Michael Shavit <mshavit@google.com>, Eric Auger
	<eric.auger@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: Query on ARM SMMUv3 nested support
Message-ID: <ZhTcaSGOvsIkZDy1@Asurada-Nvidia>
References: <b8c1b2fb281246da94b35ceb5e27b538@huawei.com>
 <ZfI74miZ1ss9+Kz0@Asurada-Nvidia>
 <4a37c695bf84425ea5159b82c202cb81@huawei.com>
 <ZgZqMymQY4pL77iw@Asurada-Nvidia>
 <02f3fbc5145d4449b3313eb802ecfa2c@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <02f3fbc5145d4449b3313eb802ecfa2c@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 580c15eb-0cb9-4cfb-b2bf-08dc585c243d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZwYHN/exon16m5d5mr6+nZl/399c27NX3z42KHG1WXFzXfZpT5xJ6oEtLO7hIRywEeeaPHJzlV0BeLb/6vmti3JfTZ/ZprObvBaSeI35Ysn1HCRru5lg46HJ3R0TiKR8z5cI8RXYVlifJx2tODXzy4KfYIaCXgw+HPvwHrWEfXWAL8Yp7JGyRWDX0pZy/DEkYIscgUvRjuqze1kA3KHXa39Fv96RX4z/EB7lF8S/i/SdK1bJma8IolV9QFBD+vJPqSwdFKdXIJvDqEQwhdsHOGR3wKHGzSlTAUejD2rfjEM9b2PIv7xPz3JZZagLrC45c3rczFK2nyGlEdZJzK09RvifMjO+cahMojxv2M2magKwsePDstF54qRMALb0eh8j3k2WOJw3TNh0Az0pp6phsLAcRI6X6Jyx4ETc7k6zUEDk/QaDuGLXPLVG13RQGyd1+O6bvG9CYjnkzRsSVr1ecEyTMBplwBfgDIN7jydNaSfyt4qsRDnRLQkLymoyMA3wOItabYDtUoSvzmImJq+02EnHdH4GQC7aOT6LT5X8iHBYZIy2uiqZtxYpBGHlCTU+0SkxAJNTyYXjOgJ1DbXb0gDtXMp9ndlJBn+diIOOM5KMeLJhwYa6CRuOZI2iQc3pRMeot5AqveY+NlTXFW2dMyDyMjrO1g/OYcbnZXFAuL2XchmsFznemsRXsBxLfmPNMtabr7Bm3gmACkgG4GyTVQlhedL1sCnUGiS1rY/RLE8FbeamgMwshyMXnB2Up+AB
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 06:13:14.5995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 580c15eb-0cb9-4cfb-b2bf-08dc585c243d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

Sorry for my belated reply.

On Tue, Apr 02, 2024 at 07:25:56AM +0000, Shameerali Kolothum Thodi wrote:

> Here we have specified nested-smmuv3 and have  a PCIe root port(ioh3420) and
> a virtio-pci dev(for virtfs). Once this VM is up and running, both the ioh3420
> and virtio-9p-pci will not work as expected as we return sysmem address space
> for them.
> 
> And then later when you try to hotplug a vfio dev to the PCIe root port,
> device_add vfio-pci,host=0000:7d:02.1,bus=rp1,id=net1,iommufd=iommufd0
> 
> it won't work either because the address space for ioh3420 is wrong.
> 
> Taking another look at this, I think we can replace my earlier attempt to fix
> this by detecting if the dev is vfio or not and add that into the check below,
> 
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -619,8 +619,15 @@ static AddressSpace *smmu_find_add_as(PCIBus
> *bus, void *opaque, int devfn)
>      SMMUState *s = opaque;
>      SMMUPciBus *sbus = smmu_get_sbus(s, bus);
>      SMMUDevice *sdev = smmu_get_sdev(s, sbus, bus, devfn);
> +    bool is_vfio = false;
> +    PCIDevice *pdev;
> 
> -    if (s->nested && !s->s2_hwpt) {
> +    pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
> +    if (object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
> +        is_vfio = true;
> +    }
> +
> +    if (is_vfio && s->nested && !s->s2_hwpt) {
>          return &sdev->as_sysmem;
>      } else {
>          return &sdev->as;
> 
> Please let me know your thoughts on this.

Hmm, checking "vfio-pci" here feels a bit of layer violation..
But I understand how you got there...

I think that the current way of enabling the "nested" flag for
a device is a bit messy:
    if -machine has "iommu=nested-smmuv3" &&
       -device is "vfio_pci" &&
       -device has "iommufd"

Any other device that doesn't meet the latter two conditions
is ambiguously added to a soft smmuv3, which feels wrong to
me now.

Also, the callbacks from hw/vfio/pci.c to iommu are tricky as
well:
    vfio_realize() {
        pci_device_iommu_address_space() {
            smmu_find_add_as();   // Can only assume vfio-pci is behind
                                  // a nested SMMU. So returns system AS
        }
        vfio_attach_device() {
            ioctl(VFIO_DEVICE_BIND_IOMMUFD);
            ioctl(VFIO_DEVICE_ATTACH_IOMMUFD_PT);
            listener_add_address_space() {
                if (memory_region_is_iommu(section->mr)) { // Skip
                    iommu_notifier_init(IOMMU_NOTIFIER_IOTLB_EVENTS);
                    memory_region_iommu_replay();
                }
            }
        }
    }

In my view, we should sort this out with a cleaner enabling
command first. And then, as Jason pointed out, other devices
(non vfio-pci) should probably not be added to the SMMU, i.e.
they might need to be added to a separate PCI bus/bridge with
out iommu. In this case, the vSMMU module would not need an
iommu AS at all when "iommu=nested-smmuv3".

Thoughts?

Thanks
Nicolin
