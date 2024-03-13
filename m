Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753A383BA
	for <iommu@lists.linux.dev>; Wed, 13 Mar 2024 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324850; cv=none; b=fMfryNE9GDH+Mt+Vbg+sZ8W2BoeokLE7VzVhRJJYYKfWKKMgw0nWX6hF01X14ghEJmqwI1x7clF5Y1/7XcR+etudDeUVOUFISxGh1djxwh60lO+JxpUx90ORLJzzQhI3ALnJcP2Y3l2PpCR7y3lMfSv/4/v6niDRTWg1jZR67qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324850; c=relaxed/simple;
	bh=Ig7YDfNM6BTgTnpBX251hC7tDcFHjC4FCp516MQgYhc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kMywL5vGG+Zt20WUll+8Y2MvcUY9sW1Y1GkGIDUL0vb5e9gweMMUSh1YPg+ZKSsnpF/e1S0o8lm777+9MPfV8IY3OxAf6s9SHkEKEd8Jp+71pJbO2YP4PQsOuCiMhGrDBqaNzRRRM6qTQ9EaG0NlXPU701iaSoKLdxp088wRiuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TvmZ26Ktvz1FLQd;
	Wed, 13 Mar 2024 18:13:46 +0800 (CST)
Received: from dggems704-chm.china.huawei.com (unknown [10.3.19.181])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BD13180061;
	Wed, 13 Mar 2024 18:14:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 18:14:01 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Wed, 13 Mar 2024 10:13:59 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Linuxarm
	<linuxarm@huawei.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Michael Shavit
	<mshavit@google.com>, Eric Auger <eric.auger@redhat.com>, Moritz Fischer
	<mdf@kernel.org>
Subject: Query on ARM SMMUv3 nested support
Thread-Topic: Query on ARM SMMUv3 nested support
Thread-Index: Adp1KtDVvB0XiTw1RNC3mrRboX3icg==
Date: Wed, 13 Mar 2024 10:13:58 +0000
Message-ID: <b8c1b2fb281246da94b35ceb5e27b538@huawei.com>
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

Hi Nicolin,

Thanks for the latest repos with basic SMMUv3 nested support enabled[1].
I did some  basic sanity runs on a HiSilicon platform and they seems to wor=
k as
expected. The only problem being we can't assign two devices to the VM if
they are on different physical SMMUs.

qemu-system-aarch64: -device
vfio-pci,host=3D0000:75:00.1,iommufd=3Diommufd0: [iommufd=3D29] error attac=
h
0000:75:00.1 (36) to id=3D4: Invalid argument
qemu-system-aarch64: -device
vfio-pci,host=3D0000:75:00.1,iommufd=3Diommufd0: Unable to attach dev to
stage-2 HW pagetable: -1
Segmentation fault (core dumped)
...

I see that on the Qemu side we now allocate a single s2 hwpt and attach tha=
t into
all the devices . But this will only work currently if all the assigned dev=
ices
are under the same physical SMMUv3 as we have a check in kernel
whether domains are having the same SMMUv3. I remember Jason mentioning
that he is planning to relax that. So are the Qemu side changes based on th=
at
assumption? And any idea how we are planning to relax that restriction? We
do a check for compatibility of the phys SMMUv3s and then allow/restrict in=
 kernel?
Do Qemu can then try allocating a separate s2 hwpt for those and attach aga=
in?
Sorry if this was already discussed elsewhere and I missed that.

Thanks,
Shameer
[1]:
https://github.com/nicolinc/iommufd/commits/wip/iommufd_nesting-03112024/
https://github.com/nicolinc/qemu/commits/wip/iommufd_vsmmu-02292024/
