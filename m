Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EF18B484
	for <iommu@lists.linux.dev>; Sat, 15 Feb 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739607101; cv=none; b=rxbpUHYs60belgYz0ftO2147Dm7MkkTrYOSIZiGOsodPhowWczQR1x0wkfPyAxrCJs+ZzxepaAPGvoat8pYCP+hhRWIos8KdaGVhToVBoxYmaVtx71ePcOtNT8KCg+old8h0kUMGQ2vUVMnzRPxEcoq+qFdbf2dq3c+jTtkA8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739607101; c=relaxed/simple;
	bh=MIB9YG7SMXhiZkroBYC/2fPcFC3PXBJXUnzSF+oHi2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg5aSnVnESfAaDv6qU68IM16mjczECVP6gM3hNJfOAgguRLy0g/ar/uc8+hq1mm7w+ba3+T+lmP4oSkpG3nGNlI3gRtxnb/KRphEGOdtX7CxIYdnH71EqdTdcWexALA4oAs74v1VQ4QWlNI7NYnbETctK4ARmeUdFROp300QQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=agS4/Blv; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agS4/Blv"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5454f00fc8dso66790e87.0
        for <iommu@lists.linux.dev>; Sat, 15 Feb 2025 00:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739607097; x=1740211897; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CkZVKWk0Rec6ui/RFP9uHI49J1VIb9gZDRSut/d8t4c=;
        b=agS4/BlvFjGFOjm3j8eLPeLLfIozweZQumTWry44lX7wqNW8+aPiur8KXN7Ju4tBu0
         ffgdxkFVIwibPH07xfXg2u/FMP7HXoMJwYpcfEBxmPiha22MsvWQmqYmYq/WKPjDwM7a
         BWzbI2VQGgKL6fTgVHOhcFt6khujzciwyeEifjMXBOleJxMC0FgysbrKsIUGWRoMQee4
         n/ZTdMYA3dcdQ7DNa08Ip6EVvC09tN4YAVZi6k/pOXkxMyArhde9/eUi2M3Qp79pGbNB
         3iK3doyBVLXcoHlvsIHj2HXChhuYOa82YK4lTtbEZXZ9h2Tm6kxzabZy07ZBo7XqvKUQ
         zSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739607097; x=1740211897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkZVKWk0Rec6ui/RFP9uHI49J1VIb9gZDRSut/d8t4c=;
        b=nSTaMyqsDcjRjSIBQncZJc2pKgjWtOk4q+nxnQYF1N/43ali8q3g7ZaumUCLkV17P5
         yDxZNIFI9RaiIOml0RAiAaMbthaPiP40vOQUt/vdgB5wKVaIrzvxwA2Z2FCncm/wmlLE
         0QNqsEcpokfiZLnQ+KweaaHnn1Em9cqmz07qDquISyEUdp/BDxHgA0s/GjYvAe73zr5x
         VY2OxPCr+/Y2j+KtDJKb5HEMVrfCs81Q9Sa5zjpDpX58dYlUOoBclmgfRuDmJR3LA16W
         kShWnJAPwZk2rvGDCh08De5q6wN24EmC8rUb6tDurZ2GTgjpS1hR/SGxVj4fjNpHK7Uw
         6VLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBkButvOUqsRGFKlGp1ca+Sp9/vToy2sD/1kXu/yD2cNFW44UOZrtLGussp5UZJvI3QRn4ag==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMubjBK9l7BMbfmV1E1blZuSKQ9RhijNs3FpeVMOnzNHX9ixZb
	p4Px/2eur4G5RxI0lNdJp+rlw2d80n5FeWJ6rVZmUAMmloLxuBgAkxAiYBsUa9im9meBzHTbae1
	JNv/H/Xn+EvgcDokVd8zNnzLAY8RNlgzb0B5NYw==
X-Gm-Gg: ASbGncuwR7+PD6GLTzEyxft5ICIiXHKMf3rYDTEfMTPgoXRD8cANZnKRHyWZyl8qalm
	vM+AmqcAkE4tw6ytq7JPq1I2Rm1g6pkX1uQmsrixdrH0HlrShdKkhpAZhItoH+pOWpM88tkT8TA
	QUdw==
X-Google-Smtp-Source: AGHT+IFySeuBuCSbb1zkeS3POUiA8vLWZz45AnvAi+gYcVyqHWR28Ifs//asPxiy+DFqEI5PMjMjr8TyFF76K3JwH5w=
X-Received: by 2002:a05:6512:2214:b0:545:958:180d with SMTP id
 2adb3069b0e04-5452fe82dc9mr652835e87.38.1739607097382; Sat, 15 Feb 2025
 00:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com> <20250214125600.GA3696814@ziepe.ca>
In-Reply-To: <20250214125600.GA3696814@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 15 Feb 2025 16:11:25 +0800
X-Gm-Features: AWEUYZmIvYjS71A50TWsWus9ODDai7SS8JRE7LLRBPYaaxOmD8THXJkZIf975hY
Message-ID: <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Jason

On Fri, 14 Feb 2025 at 20:56, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Feb 14, 2025 at 04:43:12PM +0800, Zhangfei Gao wrote:
> > 3. qemu boot multi device,  test fails, host kernel reports
> > [Hardware Error]
>
> More details? Can you bisect?

It does not relate to multi devices, one device also happens when user
page fault triggers.

iopf_queue_remove_device is called.
rcu_assign_pointer(param->fault_param, NULL);

call trace
[  304.961312] Call trace:
[  304.961314]  show_stack+0x20/0x38 (C)
[  304.961319]  dump_stack_lvl+0xc0/0xd0
[  304.961324]  dump_stack+0x18/0x28
[  304.961327]  iopf_queue_remove_device+0xb0/0x1f0
[  304.961331]  arm_smmu_remove_master_domain+0x204/0x250
[  304.961336]  arm_smmu_attach_commit+0x64/0x100
[  304.961338]  arm_smmu_attach_dev_nested+0x104/0x1a8
[  304.961340]  __iommu_attach_device+0x2c/0x110
[  304.961343]  __iommu_device_set_domain.isra.0+0x78/0xe0
[  304.961345]  __iommu_group_set_domain_internal+0x78/0x160
[  304.961347]  iommu_replace_group_handle+0x9c/0x150
[  304.961350]  iommufd_fault_domain_replace_dev+0x88/0x120
[  304.961353]  iommufd_device_do_replace+0x190/0x3c0
[  304.961355]  iommufd_device_change_pt+0x270/0x688
[  304.961357]  iommufd_device_replace+0x20/0x38
[  304.961359]  vfio_iommufd_physical_attach_ioas+0x30/0x78
[  304.961363]  vfio_df_ioctl_attach_pt+0xa8/0x188
[  304.961366]  vfio_device_fops_unl_ioctl+0x310/0x990


When page fault triggers:

[ 1016.383578] ------------[ cut here ]-----------
[ 1016.388184] WARNING: CPU: 35 PID: 717 at
drivers/iommu/io-pgfault.c:231 iommu_report_device_fault+0x2c8/0x470
[ 1016.398057] Modules linked in:
[ 1016.401102] CPU: 35 UID: 0 PID: 717 Comm: irq/31-arm-smmu Not
tainted 6.14.0-rc2-g4384d0f9bd24-dirty #19
[ 1016.410538] Hardware name: Huawei TaiShan 200 (Model
2280)/BC82AMDD, BIOS 2280-V2 CS V5.B133.01 03/25/2021
[ 1016.420147] pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1016.427077] pc : iommu_report_device_fault+0x2c8/0x470
[ 1016.432194] lr : iommu_report_device_fault+0x2c8/0x470
[ 1016.437309] sp : ffff80008c7fbb20
[ 1016.440609] x29: ffff80008c7fbb20 x28: ffff4f25c95aa6ac x27: ffffb5d5fd356818
[ 1016.447714] x26: ffffb5d600a0b8a0 x25: 0000000000000000 x24: ffff6f454371d0a0
[ 1016.454819] x23: ffffb5d5ff9544e0 x22: ffff4f4545796040 x21: ffff6f25466d80c8
[ 1016.461923] x20: ffff80008c7fbc88 x19: ffff6f25631a2780 x18: 000000000000ffff
[ 1016.469028] x17: 0000000000000001 x16: ffffffffffffffff x15: 0000000000000001
[ 1016.476132] x14: 0000000000000001 x13: 0000000000000001 x12: ffff0001fffedf00
[ 1016.483236] x11: 0000000000000000 x10: 0000000000000c80 x9 : ffffb5d5fde985f0
[ 1016.490340] x8 : ffff4f4545796d20 x7 : 0000aaaada7af000 x6 : 0000000000000001
[ 1016.497444] x5 : ffffb5d600a0b000 x4 : ffffb5d600a0be70 x3 : 0000000000000000
[ 1016.504548] x2 : ffff4f4545796040 x1 : 0000000000000000 x0 : 0000000000000000
[ 1016.511652] Call trace:
[ 1016.514088]  iommu_report_device_fault+0x2c8/0x470 (P)
[ 1016.519205]  arm_smmu_handle_event+0x100/0x170
[ 1016.523633]  arm_smmu_evtq_thread+0x1e4/0x4a0
[ 1016.527973]  irq_thread_fn+0x34/0xb8
[ 1016.531534]  irq_thread+0x160/0x310
[ 1016.535008]  kthread+0x124/0x220
[ 1016.538225]  ret_from_fork+0x10/0x20
[ 1016.541786] ---[ end trace 0000000000000000 ]---
[ 1016.546403] arm-smmu-v3 arm-smmu-v3.3.auto: event 0x10 received:
[ 1016.552474] arm-smmu-v3 arm-smmu-v3.3.auto:  0x0000750100001810
[ 1016.558453] arm-smmu-v3 arm-smmu-v3.3.auto:  0x0000120080000176
[ 1016.564430] arm-smmu-v3 arm-smmu-v3.3.auto:  0x0000aaaada7af000
[ 1016.570406] arm-smmu-v3 arm-smmu-v3.3.auto:  0x0000aaaada7af000
[ 1016.576380] arm-smmu-v3 arm-smmu-v3.3.auto: event: F_TRANSLATION
client: 0000:75:00.1 sid: 0x7501 ssid: 0x1 iova: 0xaaaada7af000 ipa:
0xaaaada7af000
[ 1016.589700] arm-smmu-v3 arm-smmu-v3.3.auto: unpriv data write s1
"Input address caused fault" stall stag: 0x176


Thanks
