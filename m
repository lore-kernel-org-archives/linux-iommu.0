Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DF4213120
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301318; cv=none; b=ZvnFjnYM5E7CYrjMB/bwR7U2tet9eQ3uRR2svtJCi4MBQPHMLyF86Abm57jLZO+C6GX1oojBI5eyXDKdThEVkiwy2MGdGmfCU10fSdukz2YjCYEfyIctwlwI8KtB0Okk3f1gLE0s8HnOli4x4g2OVxXi2WyZib2DkXbFs93vQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301318; c=relaxed/simple;
	bh=1Qcbtem6RebZ8tK/Oxq83LqkYXZ6i4n26uUG3NI9CnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+WtmiLpng5kEih7/q31/Vspw+OxeP5GznIJYtv8uC1RzLt+YDF8TD+s6+LhRs8jutQUGWVoSaGoNgR/0YBBFdKJgORUJcttjG9AWXw/3ZXb8oi1j0OOt4q7dTL/FMryLsXpjQ75fYuelYwSzap44HOHXhSGm8H/bKuXT34oTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yDimhGkE; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yDimhGkE"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e3f35268so8139720e87.3
        for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730301313; x=1730906113; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FCDfP5Rc5QN6lk4Dr+4nDAnrC+iGyk3dht91NbLmbYw=;
        b=yDimhGkEHenpWyoG+qjEhzJWTYxMtI9T6CVw+p8oA06XbVFApLl208KCFMlUr2aUQc
         iX7bS7fIu4sfmFlVMbtClASz9kGTrRggyDSdHpImpApuPYjMUjF9buHxb4Ox+rUyoVPU
         2YpA9Ug4/EFEk/3TmyMpXtmz3KengMHf4ev5Xni+4tp9miw6PxOb8dSiSqnLQ8FNU6E/
         rS67NNamF0opbVCDEvH9p2WiVtZo1Foo2gV/Ei8J3YXSJ2XRGsgG/0lKjc8Xy6ZTLW4K
         N7k/fWaL7CK9C+CuQfiAzxAedWZe6uVVi25sW5ZdW3z3M+/bg6dNchWqmt7tqDf/Ui9c
         ZWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301313; x=1730906113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCDfP5Rc5QN6lk4Dr+4nDAnrC+iGyk3dht91NbLmbYw=;
        b=AtPzQ7UfRvm2d114sDZVXbnx1UhWVTRM4kysJrsV6TlCzVC1krysYnTWjXHn/QbSqy
         YzZ11NHys53asR93hpiLAp7oFCBgukAG6lmZi6a2l0KGfnUxUxb6w6LMB+rIKRUbSyio
         E6u1vBD9QUdGjsXkdhYXP3Ucy7HEotV2V1zPrrU11aCns5U1zLf+G77b84JD9qehKVJc
         ZL4fS8XMkh6iGWjSQR6RIJDwVOYY/QmyV67omxlRzc/JWtjY3ga9V/YxvzolN1Gd23HD
         GPjImsba9j7+TjjbMt5mlwY4UXewWbhYXu1O4aNagltjCgUOaUbyQ7TJx8nJFikEgkfZ
         Besw==
X-Gm-Message-State: AOJu0YyEr8eJXizrjv38QlmW1wBt/sghpuUzSdS9kbZRMEjpjXijbJj7
	ZogNz8thx8uhUTIqo9GA1i5V1jd6XwEg5q2MexduiWcJGph0JPzBQM4KhALuTGXTbVmI4GxiVak
	W0DP3zAl0lv6Zky6HcgGax9fNR6/vSJz/bKfDwg==
X-Google-Smtp-Source: AGHT+IGBomFi77Vw30twRK755ZCz/lufWTwezhtM0NbjSrSTjmDisaVlUCqUOtQONWWcnR6SVjpHt69FFKWCTboxvhY=
X-Received: by 2002:ac2:4e0c:0:b0:539:f74b:62a5 with SMTP id
 2adb3069b0e04-53b348dd3dcmr7427181e87.25.1730301313455; Wed, 30 Oct 2024
 08:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231024135109.73787-1-joao.m.martins@oracle.com>
In-Reply-To: <20231024135109.73787-1-joao.m.martins@oracle.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 30 Oct 2024 23:15:02 +0800
Message-ID: <CABQgh9HRq8oXgm04XhY2ajvGrg-jJO_KirXvfZxRsn9WiZi7Dg@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] IOMMUFD Dirty Tracking
To: Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>, 
	Kevin Tian <kevin.tian@intel.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, 
	Shameer Kolothum <shamiali2008@gmail.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Oct 2023 at 21:51, Joao Martins <joao.m.martins@oracle.com> wrote:
>
> v6 is a replacement of what's in iommufd next:
> https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?h=for-next
>
> base-commit: b5f9e63278d6f32789478acf1ed41d21d92b36cf
>
> (from the iommufd tree)
>
> =========>8=========
>
> Presented herewith is a series that extends IOMMUFD to have IOMMU
> hardware support for dirty bit in the IOPTEs.
>
> Today, AMD Milan (or more recent) supports it while ARM SMMUv3.2
> alongside VT-D rev3.x also do support.  One intended use-case (but not
> restricted!) is to support Live Migration with SR-IOV, specially useful
> for live migrateable PCI devices that can't supply its own dirty
> tracking hardware blocks amongst others.
>
> At a quick glance, IOMMUFD lets the userspace create the IOAS with a
> set of a IOVA ranges mapped to some physical memory composing an IO
> pagetable. This is then created via HWPT_ALLOC or attached to a
> particular device/hwpt, consequently creating the IOMMU domain and share
> a common IO page table representing the endporint DMA-addressable guest
> address space. In IOMMUFD Dirty tracking (since v2 of the series) it
> will require via the HWPT_ALLOC model only, as opposed to simpler
> autodomains model.
>
> The result is an hw_pagetable which represents the
> iommu_domain which will be directly manipulated. The IOMMUFD UAPI,
> and the iommu/iommufd kAPI are then extended to provide:
>
> 1) Enforcement that only devices with dirty tracking support are attached
> to an IOMMU domain, to cover the case where this isn't all homogenous in
> the platform. While initially this is more aimed at possible heterogenous nature
> of ARM while x86 gets future proofed, should any such ocasion occur.
>
> The device dirty tracking enforcement on attach_dev is made whether the
> dirty_ops are set or not. Given that attach always checks for dirty
> ops and IOMMU_CAP_DIRTY, while writing this it almost wanted this to
> move to upper layer but semantically iommu driver should do the
> checking.
>
> 2) Toggling of Dirty Tracking on the iommu_domain. We model as the most
> common case of changing hardware translation control structures dynamically
> (x86) while making it easier to have an always-enabled mode. In the
> RFCv1, the ARM specific case is suggested to be always enabled instead of
> having to enable the per-PTE DBM control bit (what I previously called
> "range tracking"). Here, setting/clearing tracking means just clearing the
> dirty bits at start. The 'real' tracking of whether dirty
> tracking is enabled is stored in the IOMMU driver, hence no new
> fields are added to iommufd pagetable structures, except for the
> iommu_domain dirty ops part via adding a dirty_ops field to
> iommu_domain. We use that too for IOMMUFD to know if dirty tracking
> is supported and toggleable without having iommu drivers replicate said
> checks.
>
> 3) Add a capability probing for dirty tracking, leveraging the
> per-device iommu_capable() and adding a IOMMU_CAP_DIRTY. It extends
> the GET_HW_INFO ioctl which takes a device ID to return some generic
> capabilities *in addition*. Possible values enumarated by `enum
> iommufd_hw_capabilities`.
>
> 4) Read the I/O PTEs and marshal its dirtyiness into a bitmap. The bitmap
> indexes on a page_size basis the IOVAs that got written by the device.
> While performing the marshalling also drivers need to clear the dirty bits
> from IOPTE and allow the kAPI caller to batch the much needed IOTLB flush.
> There's no copy of bitmaps to userspace backed memory, all is zerocopy
> based to not add more cost to the iommu driver IOPT walker. This shares
> functionality with VFIO device dirty tracking via the IOVA bitmap APIs. So
> far this is a test-and-clear kind of interface given that the IOPT walk is
> going to be expensive. In addition this also adds the ability to read dirty
> bit info without clearing the PTE info. This is meant to cover the
> unmap-and-read-dirty use-case, and avoid the second IOTLB flush.
>
> The only dependency is:
> * Have domain_alloc_user() API with flags [2] already queued (iommufd/for-next).
>
> The series is organized as follows:
>
> * Patches 1-4: Takes care of the iommu domain operations to be added.
> The idea is to abstract iommu drivers from any idea of how bitmaps are
> stored or propagated back to the caller, as well as allowing
> control/batching over IOTLB flush. So there's a data structure and an
> helper that only tells the upper layer that an IOVA range got dirty.
> This logic is shared with VFIO and it's meant to walking the bitmap
> user memory, and kmap-ing plus setting bits as needed. IOMMU driver
> just has an idea of a 'dirty bitmap state' and recording an IOVA as
> dirty.
>
> * Patches 5-9, 13-18: Adds the UAPIs for IOMMUFD, and selftests. The
> selftests cover some corner cases on boundaries handling of the bitmap
> and various bitmap sizes that exercise. I haven't included huge IOVA
> ranges to avoid risking the selftests failing to execute due to OOM
> issues of mmaping big buffers.
>
> * Patches 10-11: AMD IOMMU implementation, particularly on those having
> HDSup support. Tested with a Qemu amd-iommu with HDSUp emulated[0]. And
> tested with live migration with VFs (but with IOMMU dirty tracking).
>
> * Patches 12: Intel IOMMU rev3.x+ implementation. Tested with a Qemu
> based intel-iommu vIOMMU with SSADS emulation support[0].
>
> On AMD/Intel I have tested this with emulation and then live migration in
> AMD hardware;
>
> The qemu iommu emulation bits are to increase coverage of this code and
> hopefully make this more broadly available for fellow contributors/devs,
> old version[1]; it uses Yi's 2 commits to have hw_info() supported (still
> needs a bit of cleanup) on top of a recent Zhenzhong series of IOMMUFD
> QEMU bringup work: see here[0]. It includes IOMMUFD dirty tracking for
> Live migration and with live migration tested. I won't be exactly
> following up a v2 of QEMU patches until IOMMUFD tracking lands.
>
> Feedback or any comments are very much appreciated.
>
> Thanks!
>         Joao

Hi, Joao and Yi

I just tried this on aarch64, live migration with "iommu=nested-smmuv3"
It does not work.

vbasedev->dirty_pages_supported=0

qemu-system-aarch64: -device
vfio-pci-nohotplug,host=0000:75:00.1,iommufd=iommufd0,enable-migration=on,x-pre-copy-dirty-page-tracking=off:
warning: 0000:75:00.1: VFIO device doesn't support device and IOMMU
dirty tracking

qemu-system-aarch64: -device
vfio-pci-nohotplug,host=0000:75:00.1,iommufd=iommufd0,enable-migration=on,x-pre-copy-dirty-page-tracking=off:
vfio 0000:75:00.1: 0000:75:00.1: Migration is currently not supported
with vIOMMU enabled

hw/vfio/migration.c
    if (vfio_viommu_preset(vbasedev)) {
        error_setg(&err, "%s: Migration is currently not supported "
                   "with vIOMMU enabled", vbasedev->name);
        goto add_blocker;
    }

Is this mean live migration with vIOMMU is still not ready,
It is not an error. It is how they are blocking migration till all
other related feature support is added for vIOMMU.
And still need more work to enable  migration with vIOMMU?

By the way, live migration works if removing "iommu=nested-smmuv3".

Any suggestions?

Thanks
