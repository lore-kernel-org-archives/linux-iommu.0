Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C31E89E
	for <iommu@lists.linux.dev>; Tue,  9 Apr 2024 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692071; cv=fail; b=RRdCIGrgCss/F6sZrHlFB5TbpL4er38cF/pwytYANCOzdX00pbqSGJGKRkkhXIfKY9tcg8uW0KlRzwK+iWgVCSPn2RYqsiBd+c6pMZPgqaiYoTfodPAKIPFI/1vrFeaQKKiKRwbAObzLmBMfd/QAQ3i6cTQmLUv0AlycA8r0prk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692071; c=relaxed/simple;
	bh=i/VhhNXBUPxvv5fI9j/4HlhgmfA01CjNPouCgEoGEts=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsW+XDuQqKDdnT4ridM6YQRmjG4x7WjGaKDRZYxriDroyX84dMcp6N2qi0xLI2aGdpyx3jzX1hlGBMjyGLXFbD0WvX7s/7Nhg0SaPdb907z+JkVbja4JOld7zekYeOi21hIApa9IuGiH0IGPqGWNAttxSVr6AdkXgp291FAEl8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VB9b7+Rn; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VB9b7+Rn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScUf17/OmkYELqcL12aK7Ffgq4NM5uiGlqJCSKKf0aP8uWWxC6NmYQCYVlw5G/92tqprW6g5ALv/kxfncOHd4PfEc6qQYhTK9xyjCtpP6cN1ZV1U5SfkcH3HK2eKzrnDlmsnbTIRq/V/t9rbGTztLtnm4cMWiMdyqhtu+JWVjk1Kw1b7sA3b/tPRi9t37tDyqxglx8K16weGi9Q39Vw8BX3yc9g6t/cUkcEj+3E+QyfBJc1oWlSohPNyOu65WbITK1P2kQL0g/UHY9g/KmTRIMUK1A5G7p7yxeRInXMsCgH1ziL5oUbJrnGMwHCAXVY9zt2QYfh1ZmBIVGzxh6G+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHsZCyQQeJBSGzIeOBEZbOxCUUoZ6GJyR48rYjQKlkk=;
 b=jd1CQJQ1JcaNRi/8wnKlAne4TrR3TR9lS4SUT5wQUrsuKMSHtmQOWafAbblmxKP+qpSMgN1uB1mjDwM6OsCHpvf5mDcwYD5BQQ4lD6LmR/mYWJGtpAOljLzIYhjcDHIYQIrB3x7vtH2LISQqROjT+XMtc9WxtTRn6gCD5ueqxBeyXO8MGdMUXy7POnAYklwWUOnB7LuRCsH64y2x0obwed+/Ig48rGCsMoARU9amkdLaj/SHEyjr30xStMVqOdGTnkuwKfEvbWqMgykFNLp1f7VeYOevaltu8jIS4Cpbs1HaBWcN3YB3+0woLbY/DnnZiRzILb36G3hXs7BcQ8LtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHsZCyQQeJBSGzIeOBEZbOxCUUoZ6GJyR48rYjQKlkk=;
 b=VB9b7+Rnu+HrAk7fzCyHHZ4YHWgCrczOIkH2zIAsYuc0Ue+7BueIMI2Q3dTcZdgxf7p3dMU5l9PLFkfY5gzE+mgwxHiqzecSA8RhKV1BED7CNJRRWBBvzniPLK7yNlFM4K5VUlrl3kx4XKpHHB4iQVXQCtGESDCOo4isgyMq8pN5zs+V3BQn4rFiutaCCbeubE9ZqDoC0T+J0PEiKBTlP19SPsZPbS8RQM2MCMhl2OCK/gumTj/bPIdgogYThejW0BXW9Z/zr7u4TOYdJSqAbxIlLMAcre1iRH7I8xHLUMa/QX/nAEzbJpWZHt5gNIB5pdU8dod8EZ7Z+rqB8+gcmA==
Received: from SJ0PR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:33f::35)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 19:47:46 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::d5) by SJ0PR05CA0060.outlook.office365.com
 (2603:10b6:a03:33f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 19:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 19:47:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:47:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 9 Apr 2024 12:47:44 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 9 Apr 2024 12:47:43 -0700
Date: Tue, 9 Apr 2024 12:47:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, Shameerali Kolothum Thodi
	<shameerali.kolothum.thodi@huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Linuxarm <linuxarm@huawei.com>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Michael Shavit <mshavit@google.com>, "Moritz
 Fischer" <mdf@kernel.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
Subject: Re: Query on ARM SMMUv3 nested support
Message-ID: <ZhWbXkl4fzWGR+VR@Asurada-Nvidia>
References: <b8c1b2fb281246da94b35ceb5e27b538@huawei.com>
 <ZfI74miZ1ss9+Kz0@Asurada-Nvidia>
 <4a37c695bf84425ea5159b82c202cb81@huawei.com>
 <ZgZqMymQY4pL77iw@Asurada-Nvidia>
 <02f3fbc5145d4449b3313eb802ecfa2c@huawei.com>
 <ZhTcaSGOvsIkZDy1@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhTcaSGOvsIkZDy1@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f67a82-0b7d-46ca-2f31-08dc58cdedbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JiIFtLgJ/Ok0taDI9J96GYM0LisqkVsPFeQYqavJSoXbhPifUKFnRvPoFvgrVaUG8uMuV/b7fmhJU1Tt5zCL/iN8iib3obCpz3KZXG9lI4Z6dCkefCwKZpToQGZCCHj4rNvuRe8pu9cHGxSJ6W2YGeImwP73FMIJHOrZ25m6agFBaUrbhCrBiRCT8XNbtNgpGMYs6Rbw5lhLXPlp2yNq6otXJNCWqts1l7M2mW8FTAardp8V0QzglEuh1IIs3pD1vRew8aQbqF+iGx01tCTVpifMe/ST91DVP4RCMzMAV0RaDNZX81oHKpLJaUncLdimwHOgQI+Axwk0PqdkJmDRWnYTljeLRArqBp9to/ieg8YRJr0ykRHIS4a5HfVkwvJmC5wfEnqK2hXvMSGI3oYhDdrceZdgXIMUiDwqpDvI9dHZeC6Yc15PboprIQC3dh/0p+FbkcOrdx+tyETO+x2m7g4TTaiAcGGQgMMcnw1oDGyr9wz/cIl5rcGkyFWDiTnxswD+16smMKaXO8713VlRjcUUJ83LNCQ3mp38aG+Pk8W8hVuBanEHVxWCpWXYP9vaWkpPw7pmNkkM38b4QjxJE6uuI7TuNgHLFxznx91f9hHoJv9625iuBdE6tUMo+fSwaosk3QdBDKd+8jUCTi54psJUrFcKeIlCUsXtIvTokXJnoyneDkxUOBuJdbnZD1XZ2jdw7UUczVf7MZ/P0E7tyPYI+jV4gmDdyvqAYkf6ZQRIknO3PCtsPklb+9YUFylm
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:47:45.9034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f67a82-0b7d-46ca-2f31-08dc58cdedbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

On Mon, Apr 08, 2024 at 11:13:02PM -0700, Nicolin Chen wrote:
> Sorry for my belated reply.
> 
> On Tue, Apr 02, 2024 at 07:25:56AM +0000, Shameerali Kolothum Thodi wrote:
> 
> > Here we have specified nested-smmuv3 and have  a PCIe root port(ioh3420) and
> > a virtio-pci dev(for virtfs). Once this VM is up and running, both the ioh3420
> > and virtio-9p-pci will not work as expected as we return sysmem address space
> > for them.
> > 
> > And then later when you try to hotplug a vfio dev to the PCIe root port,
> > device_add vfio-pci,host=0000:7d:02.1,bus=rp1,id=net1,iommufd=iommufd0
> > 
> > it won't work either because the address space for ioh3420 is wrong.
> > 
> > Taking another look at this, I think we can replace my earlier attempt to fix
> > this by detecting if the dev is vfio or not and add that into the check below,
> > 
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -619,8 +619,15 @@ static AddressSpace *smmu_find_add_as(PCIBus
> > *bus, void *opaque, int devfn)
> >      SMMUState *s = opaque;
> >      SMMUPciBus *sbus = smmu_get_sbus(s, bus);
> >      SMMUDevice *sdev = smmu_get_sdev(s, sbus, bus, devfn);
> > +    bool is_vfio = false;
> > +    PCIDevice *pdev;
> > 
> > -    if (s->nested && !s->s2_hwpt) {
> > +    pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
> > +    if (object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
> > +        is_vfio = true;
> > +    }
> > +
> > +    if (is_vfio && s->nested && !s->s2_hwpt) {
> >          return &sdev->as_sysmem;
> >      } else {
> >          return &sdev->as;
> > 
> > Please let me know your thoughts on this.
> 
> Hmm, checking "vfio-pci" here feels a bit of layer violation..
> But I understand how you got there...
> 
> I think that the current way of enabling the "nested" flag for
> a device is a bit messy:
>     if -machine has "iommu=nested-smmuv3" &&
>        -device is "vfio_pci" &&
>        -device has "iommufd"
> 
> Any other device that doesn't meet the latter two conditions
> is ambiguously added to a soft smmuv3, which feels wrong to
> me now.
> 
> Also, the callbacks from hw/vfio/pci.c to iommu are tricky as
> well:
>     vfio_realize() {
>         pci_device_iommu_address_space() {
>             smmu_find_add_as();   // Can only assume vfio-pci is behind
>                                   // a nested SMMU. So returns system AS
>         }
>         vfio_attach_device() {
>             ioctl(VFIO_DEVICE_BIND_IOMMUFD);
>             ioctl(VFIO_DEVICE_ATTACH_IOMMUFD_PT);
>             listener_add_address_space() {
>                 if (memory_region_is_iommu(section->mr)) { // Skip
>                     iommu_notifier_init(IOMMU_NOTIFIER_IOTLB_EVENTS);
>                     memory_region_iommu_replay();
>                 }
>             }
>         }
>     }
> 
> In my view, we should sort this out with a cleaner enabling
> command first. And then, as Jason pointed out, other devices
> (non vfio-pci) should probably not be added to the SMMU, i.e.
> they might need to be added to a separate PCI bus/bridge with
> out iommu. In this case, the vSMMU module would not need an
> iommu AS at all when "iommu=nested-smmuv3".

Just recalled that kvm_arch_fixup_msi_route still requires a
"vfio-pci" device to return an IOMMUMemoryRegion v.s. system
memory. And that's why there's a "!s2_hwpt" condition (hack)
when returning the system AS, so that (at the beginning) the
vfio attach could bypass the iotlb registeration using system
AS and (after s2_hwpt is allocated) MSI could translate the
MSI address using iommu AS.

Otherwise, such a device could (likely "should" in my view)
stay with the system AS, since it doesn't need the emulated 
iotlb/cache at all. Yet in that case, we would need another
pci_device_msi_address_space for MSI..

@Eric,
Would it be possible for you shed some light also?

In a summary, we have the following opens:
1. How should we enable "nesting" for a passthrough device?
   - Currently is a bit ambiguous:
     if -machine has "iommu=nested-smmuv3" &&
        -device is "vfio_pci" &&
        -device has "iommufd"
   - Actually "-device has 'iommufd'" only guarantees using
     the IOMMUFD cdev APIs v.s. the legacy one, i.e. it's not
     necessary to enable nesting supposedly?

2. How should we handle a non passthrough device (no nesting)?
   - Current is a bit ambiguous again by adding it to the soft
     SMMUv3. But, is it necessary? It doesn't seem to have any
     positive performance gain.
   - Yet not adding it behind the SMMUv3 would require another
     noiommu PCI bus to dock such a device, I assume?

3. Should we keep a nesting-enabled passthrough device in the
   system AS v.s. iommu AS?
   - The reasoning is that it doesn't need an emulated iotlb
     or cache since it uses the HW one.
   - Also, with a HW-accelerated VCMDQ on NVIDIA Grace, the
     emulated iotlb should be turned off because there will be
     no TLBI/ATC command trapped by QEMU, as all those commands
     will be issued to the VCMDQ HW directly.
   - The only usage of an iommu AS is the MSI code, as it's a
     bit unique requiring for a gIOVA to gPA translation. So,
     keeping such a device in the system AS would need another
     pci_device_msi_address_space, which feels reasonable since
     we need something similar in the kernel too:
     https://lore.kernel.org/lkml/f65a3d7e3e0e0c7b2f5cfc03ada9618aa8b523bb.1683688960.git.nicolinc@nvidia.com/

Thanks
Nicolin
