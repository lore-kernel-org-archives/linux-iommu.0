Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B373CF72
	for <iommu@lists.linux.dev>; Tue,  2 Apr 2024 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042771; cv=none; b=J9k1L4vM3/DG45RHBW1h0apYd6snWcyFIZBgy3JF8clK25rcdc8GcSwmA612x3QDtOZN0vNrcM5GJlptZduR9RwdOFPWm2q7EMgcd6XaGAoF9tHkOTa7nMthbghZzLtDNMRdHD5wuoR4DdntTEu7cyGwcJn6ouUWipL1gRJ7HNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042771; c=relaxed/simple;
	bh=Yz8VU0Nepq1L69SrQvXVJJqcP/3v08Eqv1XZrUaatfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kZ52Dt2oEDubNKsjmLRoMB6wgxqp6s6Qb9JHQ4UgvfyNkRctfytsYgLVN+w3Xt3wDGmdGMva4eNRW6e63IQOe1lrl5j1+n288KjUKiAHDgDFoIUVJIawOAHA/MODERwZua7Gb3Rspr1xsNIn0wmAF+q1PAXiN5p4g/LNpiFkwL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V7zr247C3z1R9Mw;
	Tue,  2 Apr 2024 15:23:14 +0800 (CST)
Received: from dggems705-chm.china.huawei.com (unknown [10.3.19.182])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F7D1180060;
	Tue,  2 Apr 2024 15:25:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 15:25:58 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Tue, 2 Apr 2024 08:25:56 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Linuxarm <linuxarm@huawei.com>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Michael Shavit <mshavit@google.com>, Eric Auger
	<eric.auger@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: Query on ARM SMMUv3 nested support
Thread-Topic: Query on ARM SMMUv3 nested support
Thread-Index: Adp1KtDVvB0XiTw1RNC3mrRboX3icgAdnrMAAbGUUaABUEMEgADJAbvw
Date: Tue, 2 Apr 2024 07:25:56 +0000
Message-ID: <02f3fbc5145d4449b3313eb802ecfa2c@huawei.com>
References: <b8c1b2fb281246da94b35ceb5e27b538@huawei.com>
 <ZfI74miZ1ss9+Kz0@Asurada-Nvidia>
 <4a37c695bf84425ea5159b82c202cb81@huawei.com>
 <ZgZqMymQY4pL77iw@Asurada-Nvidia>
In-Reply-To: <ZgZqMymQY4pL77iw@Asurada-Nvidia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, March 29, 2024 7:14 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; iommu@lists.linux.dev; Linuxarm
> <linuxarm@huawei.com>; Zhangfei Gao <zhangfei.gao@linaro.org>; Michael
> Shavit <mshavit@google.com>; Eric Auger <eric.auger@redhat.com>; Moritz
> Fischer <mdf@kernel.org>; baolu.lu@linux.intel.com
> Subject: Re: Query on ARM SMMUv3 nested support
>=20
> Hi Shameer,
>=20
> Sorry for the late reply. Having been occupied by multiple tasks
> lately.
>=20
> On Fri, Mar 22, 2024 at 03:04:42PM +0000, Shameerali Kolothum Thodi
> wrote:
>=20
> > Thanks for the reference to above CMDQ-V. Looks interesting.
> > I think we can have a go with retry logic first to allocate a new hwpt
> > if the attach fails. For now, I have a temp fix where I allocate a new
> > hwpt every time.
> >
> > I also noticed another problem with the commit below,
> > 6691a2f("hw/arm/smmu-common: Use sysmem for get_address _space
> until !!s2_hwpti")
> >
> > This actually breaks a virtio-pci dev assignment when that is the only
> > assigned device to the Guest without any pass-through dev in nested
> > scenario.
> >
> > I have a temp fix for that as well here,
> > (I know it is ugly!). I will revisit that again. Please let me know if =
you have
> > any ideas.
>=20
> I am not quite getting the case here. Is that virtio-pci device
> behind a nested-SMMU while there is no S2 hwpt? In that case, why
> does this virtio-pci device require a "nested-smmuv3"?

Hi Nicolin,

Let me try to explain with a use case,

Consider a guest boot with below options,

./qemu-system-aarch64 virt,gic-version=3D3,iommu=3Dnested-smmuv3,iommufd=3D=
iommufd0 \
-enable-kvm -cpu host -m 4G -smp cpus=3D8,maxcpus=3D8 \
-object iommufd,id=3Diommufd0 \
-bios QEMU_EFI.fd \
-kernel Image \
-device virtio-blk-device,drive=3Dfs \
-drive if=3Dnone,file=3Dubuntu.img,id=3Dfs \
-device ioh3420,id=3Drp1 \
-device virtio-9p-pci,fsdev=3Dp9fs,mount_tag=3Dp9 \
-fsdev local,id=3Dp9fs,path=3Dp9root,security_model=3Dmapped \
--append "rdinit=3Dinit console=3DttyAMA0 root=3D/dev/vda rw earlycon=3Dpl0=
11,0x9000000" \
-net none \
-nographic

Here we have specified nested-smmuv3 and have  a PCIe root port(ioh3420) an=
d
a virtio-pci dev(for virtfs). Once this VM is up and running, both the ioh3=
420
and virtio-9p-pci will not work as expected as we return sysmem address spa=
ce
for them.

And then later when you try to hotplug a vfio dev to the PCIe root port,
device_add vfio-pci,host=3D0000:7d:02.1,bus=3Drp1,id=3Dnet1,iommufd=3Diommu=
fd0

it won't work either because the address space for ioh3420 is wrong.

Taking another look at this, I think we can replace my earlier attempt to f=
ix
this by detecting if the dev is vfio or not and add that into the check bel=
ow,

--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -619,8 +619,15 @@ static AddressSpace *smmu_find_add_as(PCIBus
*bus, void *opaque, int devfn)
     SMMUState *s =3D opaque;
     SMMUPciBus *sbus =3D smmu_get_sbus(s, bus);
     SMMUDevice *sdev =3D smmu_get_sdev(s, sbus, bus, devfn);
+    bool is_vfio =3D false;
+    PCIDevice *pdev;

-    if (s->nested && !s->s2_hwpt) {
+    pdev =3D pci_find_device(bus, pci_bus_num(bus), devfn);
+    if (object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
+        is_vfio =3D true;
+    }
+
+    if (is_vfio && s->nested && !s->s2_hwpt) {
         return &sdev->as_sysmem;
     } else {
         return &sdev->as;

Please let me know your thoughts on this.

Thanks,
Shameer

