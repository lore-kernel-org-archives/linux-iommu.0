Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317B1DD9AD
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169319; cv=none; b=SIYzClUr/l4IFQ9x1n2D0PbzHKW2FBGsDlH37+/04zazaAH0QHu/QXvMbqrfqv1XjkvxCgyKxlC/svkR8gaTiRSzu+Yb9rXiefq3p4LvE2mqhxfEMoNXCfBANyihRN3eiVmXMwu7D1AS7hlehggm5WRRbXxllfbeEfCAOE2DS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169319; c=relaxed/simple;
	bh=iLhO7lh1inDfAn5x8gSirivrdOdqQvRbxDSKgqQdQBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6wVjFcFrcSTizOCb9dXMRfsTH3cSOyPq4ZtD6x1Xtr4gILn8kVmlfmPwR5W8SZJrFE0Fa6P1uj0+Ycjfg0APpdQsm3uBTE/nflxV2JSSG+/2twId2Cii/eiHh1jp7lqkfTiWQ/UIMWopbgAwRoFb/FZBi47bcsaOtNG/9uSMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S+lQxNLA; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+lQxNLA"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso44166361fa.3
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 19:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730169314; x=1730774114; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QcH2vlGTspQOvxs8NozQXunlB1zGk1RfWBkXgdAueCo=;
        b=S+lQxNLAdTQUPwL4I4bB0SI5Q/eRqf8HMlRRSImOIvpDVE9IlTnQy9mq5AHOXSVMXK
         h28s6YnC1ZO/l1szJkVPZFbD7EOM/FyKqnh4Joft06fOa0lvaVf3B7yW6M+h2N1nLeKI
         NMdcpUm1ox99AwM/i4gv+e5IOZMAPlu5JRoob8pwnER4K50/x0/T7hLEoYoZyWJt1ACa
         BERhdk+epO7+dAM6KeGsVnK/2tmoy2Rfk87AyjI9/35tHPViGf5CHrN0+Tw0HFzB9cl6
         j3FDObltnHn5PTe7Q8j6RZLhCQth3ZHO/d2PtHOYyVKjSupcH+Bp7xDMUSB7BUtUnZEo
         fgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730169314; x=1730774114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcH2vlGTspQOvxs8NozQXunlB1zGk1RfWBkXgdAueCo=;
        b=kid+lAkAkfEghhkDDkMPdTtvo338WdIxzLXgUpsj9EfdfAVXf5x/PYg3Gg7Q3W1bV4
         EX9f2fap9QrLPRYkuda3NBgTm/47XkBsRUaZNxi2fgoaz739lDmFb2KzV6HAboBcmPGk
         doJHeVrTaDeyNnf4PJj9bsVQmqtyJN2WWL1UV5MC/EAECRcw0fAVuNOrUscYNjW1CZ6A
         Wp9uO3TOh4i+KbYXaBFuC0bbiy9B7bBsb16hYjkubWstEqAoh2fUGAvtlcVbfBFkDcMW
         q7bV9l1Cqi+aKyS1Facre9DxA5I2UFSpUJPMBcMQyscn+3+fYc/KuJl0WZZPLC/mmMV/
         JnHA==
X-Gm-Message-State: AOJu0YynmjRXexaVFcaagRx7Mu17bGnKZucGiz2QVjGIm1j2Rd3S/wVt
	xRT5id4eJbNPen+FsX6DoHXpsTw3k8uZkYEK1T/Tzb7FCijBmCb1YhpTmcP7t5bpBxPZQk8x12h
	RGTKoVwlz0ve1XRNI9wLkhNTjJub3bMsSUFknHQ==
X-Google-Smtp-Source: AGHT+IF+BVMuEQyL5P4tRyH82fESbmQ9baEgbyI5/9REi8DkcJBXwKkGGYMJErO/g4LEP/FyFYztIy7LuDxruKWh5xo=
X-Received: by 2002:a05:6512:238a:b0:535:6aa9:9868 with SMTP id
 2adb3069b0e04-53b348cb8d9mr5311681e87.19.1730169313585; Mon, 28 Oct 2024
 19:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231024135109.73787-1-joao.m.martins@oracle.com>
In-Reply-To: <20231024135109.73787-1-joao.m.martins@oracle.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 29 Oct 2024 10:35:02 +0800
Message-ID: <CABQgh9HN4VnL04EbadWh9cQf+YpTzvscvXBdHY8nte6CW8RVvg@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] IOMMUFD Dirty Tracking
To: Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>, 
	Kevin Tian <kevin.tian@intel.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Joao

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

Is this patchset enough for iommufd live migration?

Just tried live migration in local machine,
reports "VFIO migration is not supported in kernel"

Thanks
