Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537B47F7A
	for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119894; cv=none; b=AqcBYzRU0E3iyLHZoCAjEyLw+UkoRw2rDwA5MZCH+D8eJGBA3VWf99UUQEvQKoifU78uRIjnoZ1BJURVL/dvvHNypBuqkuVEkCMSRu/YI5GAJQ7c2MCNbzsuNK/nc2UexTGrgx1DpYMrFBWwYER8i8DVXuhpojBqJPviIeItylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119894; c=relaxed/simple;
	bh=JMW/wS+YLEbt8TSyWtcLBP3bnqOJvUQU5pwGJLQgORo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IuNWaCVzWPbUZM/ma88lf8LubvT5tg71szkOhasEPBhtHcQtx4qMrlHQ4I2iM9fd5dR57M/5dnIfIgL7zXvMo5mMWX3szAWSAsRLfA0W2UQfGX2FqDBAn4eH0YF64m2kEpiGTscVtNWFXvpDcioV2oylSoYw+zz/cf1YL+4eM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V1QZk60jsz1vxQZ;
	Fri, 22 Mar 2024 23:03:58 +0800 (CST)
Received: from dggems705-chm.china.huawei.com (unknown [10.3.19.182])
	by mail.maildlp.com (Postfix) with ESMTPS id 114B1140133;
	Fri, 22 Mar 2024 23:04:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 23:04:44 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Fri, 22 Mar 2024 15:04:42 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Linuxarm <linuxarm@huawei.com>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Michael Shavit <mshavit@google.com>, Eric Auger
	<eric.auger@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: Query on ARM SMMUv3 nested support
Thread-Topic: Query on ARM SMMUv3 nested support
Thread-Index: Adp1KtDVvB0XiTw1RNC3mrRboX3icgAdnrMAAbGUUaA=
Date: Fri, 22 Mar 2024 15:04:42 +0000
Message-ID: <4a37c695bf84425ea5159b82c202cb81@huawei.com>
References: <b8c1b2fb281246da94b35ceb5e27b538@huawei.com>
 <ZfI74miZ1ss9+Kz0@Asurada-Nvidia>
In-Reply-To: <ZfI74miZ1ss9+Kz0@Asurada-Nvidia>
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
> Sent: Wednesday, March 13, 2024 11:51 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; iommu@lists.linux.dev; Linuxarm
> <linuxarm@huawei.com>; Zhangfei Gao <zhangfei.gao@linaro.org>; Michael
> Shavit <mshavit@google.com>; Eric Auger <eric.auger@redhat.com>; Moritz
> Fischer <mdf@kernel.org>
> Subject: Re: Query on ARM SMMUv3 nested support
>=20
> On Wed, Mar 13, 2024 at 10:13:58AM +0000, Shameerali Kolothum Thodi
> wrote:
> > Hi Nicolin,
> >
> > Thanks for the latest repos with basic SMMUv3 nested support enabled[1]=
.
> > I did some  basic sanity runs on a HiSilicon platform and they seems to
> work as
> > expected. The only problem being we can't assign two devices to the VM =
if
> > they are on different physical SMMUs.
> >
> > qemu-system-aarch64: -device
> > vfio-pci,host=3D0000:75:00.1,iommufd=3Diommufd0: [iommufd=3D29] error
> attach
> > 0000:75:00.1 (36) to id=3D4: Invalid argument
> > qemu-system-aarch64: -device
> > vfio-pci,host=3D0000:75:00.1,iommufd=3Diommufd0: Unable to attach dev t=
o
> > stage-2 HW pagetable: -1
> > Segmentation fault (core dumped)
> > ...
> >
> > I see that on the Qemu side we now allocate a single s2 hwpt and attach
> that into
> > all the devices . But this will only work currently if all the assigned=
 devices
> > are under the same physical SMMUv3 as we have a check in kernel
> > whether domains are having the same SMMUv3. I remember Jason
> mentioning
> > that he is planning to relax that. So are the Qemu side changes based o=
n
> that
> > assumption? And any idea how we are planning to relax that restriction?
> We
> > do a check for compatibility of the phys SMMUv3s and then allow/restric=
t
> in kernel?
> > Do Qemu can then try allocating a separate s2 hwpt for those and attach
> again?
> > Sorry if this was already discussed elsewhere and I missed that.
>=20
> You are very right about this. I haven't thought about supporting
> that case yet. Likely I need to spare some time to refine the QEMU
> part in the coming weeks or so (have been waiting for Zhenzhong's
> full nesting patches).
>=20
> Also, NVIDIA has an interest to support CMDQ-V accelerator, where
> we need more vSMMU instances, than just one. I haven't decided how
> to handle this for both single-vSMMU and multi-vSMMU versions.
>=20
> Yet, some of the ongoing work might help:
> https://github.com/nicolinc/iommufd/commit/b7520901184fd9fa127abb88c
> 1f0be16b9967cff
> https://github.com/nicolinc/iommufd/commit/d969ffeac899491d3a6e54557
> bf6a46d52b95865
> So, each device should poll hw_info to get its SMMU ID, if it is
> not in the S2 list of the vSMMU's, add it and allocate a new S2.

Thanks for the reference to above CMDQ-V. Looks interesting.
I think we can have a go with retry logic first to allocate a new hwpt
if the attach fails. For now, I have a temp fix where I allocate a new
hwpt every time.

I also noticed another problem with the commit below,
6691a2f("hw/arm/smmu-common: Use sysmem for get_address _space until !!s2_h=
wpti")

This actually breaks a virtio-pci dev assignment when that is the only=20
assigned device to the Guest without any pass-through dev in nested
scenario.

I have a temp fix for that as well here,
https://github.com/hisilicon/qemu/commit/ff0230e9593ba1a172aa7ec9162967d6ae=
6875b0

(I know it is ugly!). I will revisit that again. Please let me know if you =
have
any ideas.

FWIW, I have a working branch for vSVA here,
https://github.com/hisilicon/qemu/tree/iommufd_vsmmu-02292024-vsva-wip-v2

I still have that io_uring write issue mentioned in the other thread[1],
but for now I use io_uring API only for read and make use of normal write()
for updating kernel with page response.

I have done some basic sanity runs with our ACC devices and those seems
to work(of course needs more testing).=20

Please have a look and let me know if you spot anything.

Thanks,
Shameer
1. https://lore.kernel.org/all/ad4575588dd247fa8beae60963f36404@huawei.com/


