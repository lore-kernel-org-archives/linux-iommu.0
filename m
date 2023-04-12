Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B537362
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 02:48:08 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id gb12so8773004qtb.6
        for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 19:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681267687; x=1683859687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TZAGrtuoiVcKtXvhoP6SEB+Aela1UTdkKpDSeJdGY6w=;
        b=f7y1RzwvjEB6e4+ku2OrQ9KaIUMhjWZepTv+TgDO7YnMW3UfcTxRhW66OJd4/6slMd
         99AEC1yT0EPUqhaQajpUnj2hvmU0ww13Zs7TEE/29zFYaKOdRMbsq7M9EB+dEhF95u72
         z6Sxqrg6ulUaPPaT//z+ksujidMHQqArY0WYa5/YibtMm3UCY9bpUc8R5bvy13Uco3Ys
         FKVRF137ZFTMZg4lrvV/peO2iQyq/qIRHefNE/GID/srQCTdf2WBNsIeGglgt99Napkh
         YXX0zdAU84Pdf1dqUoS6g4D1tNYCAL8c/94hO2Sggakop1oMb5E/sThuIHJtPPDEYqmY
         x6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681267687; x=1683859687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZAGrtuoiVcKtXvhoP6SEB+Aela1UTdkKpDSeJdGY6w=;
        b=kn/W6/+nk9RqUeJw41QP2YB94AN5Rv2fYnszbhYc8zI0KFFT1rIvB086XxZj4l+VCy
         oKvnMvnkC1IjBHYpAXdjZHtsGE4kMAe+4mbnGuATAaww8bcdr1WYdAnn5vGzuJn60bUn
         iak/xkXVCH7Q0Hll0vsHStZZHEzY2N2+gVPtuRSa/8UPuujWSEOh591aW7z02Lie5bEv
         /qrsz8TkDKC2QTgp5NKEgHCgkpRBmx0ttHQxS9nj1jk9OWZn6yNYgNwiVEMKc7zBkYpv
         zEgIyfDR6WCtfGuHul4h7SgJWoAQlaQpPSHLEBVzWLhbZEoCdkC5vRVH5o2oZxJqyIw2
         Kdhg==
X-Gm-Message-State: AAQBX9dYefpbW68GrEPc87k3n9yQmjmx9ts8OO/169h20+cgvdsG1lCV
	6DBidcXUgrIgAC/jtic10upW+Wu/6pgPI4hXGRmsjQ==
X-Google-Smtp-Source: AKy350bHU4vIMAu0JiLinQH5ukCQF1Ernd7aI6JOF2bMnBfFkNPtLW3FdZXtBYsLwZLo8UlRkMAO4NgrM4PtJ1RQbkc=
X-Received: by 2002:a05:622a:1a07:b0:3da:1712:608e with SMTP id
 f7-20020a05622a1a0700b003da1712608emr442688qtb.11.1681267687246; Tue, 11 Apr
 2023 19:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia> <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia> <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia> <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com> <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
 <ZC6vlI7onlUgBidX@nvidia.com> <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>
In-Reply-To: <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 12 Apr 2023 10:47:56 +0800
Message-ID: <CABQgh9HLNp-cSp+KhVcgyuVioQochJcG_NyhNcDP0DF1SWs_PQ@mail.gmail.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Robin Murphy <robin.murphy@arm.com>, 
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, 
	"eric.auger@redhat.com" <eric.auger@redhat.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, 
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	qianweili <qianweili@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Nicolin

On Mon, 10 Apr 2023 at 09:08, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Thu, Apr 06, 2023 at 08:40:04AM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 06, 2023 at 02:23:17PM +0800, Zhangfei Gao wrote:
> >
> > > We are using ioctl method now.
> > > From the testing, the TLB miss impacts performance a lot, so we use
> > > huge page method.
> > > After using huge page method, guest can achieve comparable performance
> > > with host.
> >
> > Looks like these tests are not stressing the MM, just measuring pure
> > BW of the DMA, so they don't get into the invalidation regime..
> >
> > You need to measure a more real application that is actually using the
> > MM (eg alloc/free memory, fork, etc) while it operates and turn on SVA.
>
> Would an iommu map/unmap benchmark test be useful here?
>
> I added a test program to measure map/unmap times with a
> set of different sized buffers:
> https://github.com/nicolinc/iommufd/commit/3eb417f2cae0234cc801c6ad74de2afb0ddbdf84
> (Also thinking about sending this with a RFC series)
>
> @Zhangfei,
> In case that this could be useful, you can pull these two
> branches for perf measurement with and without mmap:
> # Kernel
> https://github.com/nicolinc/iommufd/commits/wip/iommufd_nesting-mmap-04082023
> # QEMU
> https://github.com/nicolinc/qemu/commits/wip/iommufd_nesting-mmap-04072023
>
> To test without mmap, simply revert the following commits:
> # Kernel
> git revert ecf602a3c8480ba7ce2c7e77c2d15ca873dbf2e4
> # QEMU
> git revert c726c014de70998f14b8741a6a96e18a2a7bcd0f
>
> And, you can get the test script in the branch:
>   tools/testing/selftests/iommu/iommu_benchmark.sh
>
>
> On my emulation environment (very slow), with mmap, I see
> improvements. I'll also try setting up a test suite on a
> proper HW this week.
>

Still debugging the mmap method here,

Status 4.12

1.  ioctl method works, based on iommufd

performance same as before, ie.6.2

Using huge page method for guest, guest app can get comparable
performance as host

(The branches are provided by Shameer)
https://github.com/gaozhangfei/linux-kernel-uadk/tree/private-iommufd_nesting-03272023-6.3-rc4-arm
https://github.com/gaozhangfei/qemu/tree/private-v7.2.0-iommufd-nesting-arm


2.  mmap method still in debug,
(patch porting may have issues, need to port patches to the working
version, in check)

qemu:

https://github.com/gaozhangfei/linux-kernel-uadk/tree/iommufd_nesting-mmap-04082023

https://github.com/gaozhangfei/qemu/tree/private-v7.2.0-iommufd-nesting-arm-mmap

log:

guest:

hisi sec init Kunpeng920!

qemu-system-aarch64: IOMMU_HWPT_INVALIDATE failed: No such device

qemu-system-aarch64: --------smmuv3_invalidate_cache_mmap: failed to
invalidate TLB: prod=15fa vs cons=1000709

qemu-system-aarch64: IOMMU_HWPT_INVALIDATE failed: No such device

qemu-system-aarch64: --------smmuv3_invalidate_cache_mmap: failed to
invalidate TLB: prod=9bb vs cons=1000709

qemu-system-aarch64: IOMMU_HWPT_INVALIDATE failed: Connection timed out

qemu-system-aarch64: --------smmuv3_invalidate_cache_mmap: failed to
invalidate TLB: prod=4c0 vs cons=4c0

qemu-system-aarch64: IOMMU_HWPT_INVALIDATE failed: No such device

qemu-system-aarch64: --------smmuv3_invalidate_cache_mmap: failed to
invalidate TLB: prod=f7a vs cons=1000709

qemu-system-aarch64: IOMMU_HWPT_INVALIDATE failed: No such device

qemu-system-aarch64: --------smmuv3_invalidate_cache_mmap: failed to
invalidate TLB: prod=81d vs cons=1000709

host:

[218.986319] arm-smmu-v3 arm-smmu-v3.3.auto: unexpected global error
reported (0x00000001), this could be serious

[218.996464] arm-smmu-v3 arm-smmu-v3.3.auto: CMDQ error (cons
0x01004805): Illegal command

[219.004606] arm-smmu-v3 arm-smmu-v3.3.auto: skipping command in error state:

[219.011622] arm-smmu-v3 arm-smmu-v3.3.auto:0x0060000202110687

[219.017515] arm-smmu-v3 arm-smmu-v3.3.auto:0x0000000000000000

[219.023422] arm-smmu-v3 arm-smmu-v3.3.auto: unexpected global error
reported (0x00000001), this could be serious

[219.033550] arm-smmu-v3 arm-smmu-v3.3.auto: CMDQ error (cons
0x01004806): Illegal command

[219.041692] arm-smmu-v3 arm-smmu-v3.3.auto: skipping command in error state:

[219.048707] arm-smmu-v3 arm-smmu-v3.3.auto:0x0000000000000000

[219.054600]arm-smmu-v3 arm-smmu-v3.3.auto:0x0000000000000000
