Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB836C433FE
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:20:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A1261A81
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86A1261A81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 512E24196E;
	Fri,  1 Oct 2021 14:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xN-GUVZ5salD; Fri,  1 Oct 2021 14:20:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E8E2340781;
	Fri,  1 Oct 2021 14:20:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B454DC0011;
	Fri,  1 Oct 2021 14:20:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7E0EC000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 12:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89C4B40278
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 12:25:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bmkairTbu_AK for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 12:25:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20F17401D0
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 12:25:09 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id dn26so34010950edb.13
 for <iommu@lists.linux-foundation.org>; Fri, 01 Oct 2021 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wf1MmBNmIAfZmULUjfzH8CC2xLhdOMWrEvNVMzW+P8I=;
 b=E73JQ3x0ZNVZ6IJLAWgXAYdU8MTUU1HrJwQPmGgXWqQVHe0UkZRVyFJvImOgcmtolY
 nthddNvtNB5aL5qPEjooyqBEV2RpvF8meSi2tTPhdKWiXkbilNCBoCMtfBkRXhNYF299
 s11OW/PCi4puqmBd+/7glS/VkLLXdxuFtmfW5psHTM1e/tk8A/xDZHgyjvml58uKJZ36
 RZzSWj3jhviqMSIIux6uzweOtmg/9RV61J8QA7ui40kM8WsoRNKaoJdoh3FNvwFIVF5F
 sxhu5oclG4CLRWO6Eo8VYUs5BnW0HWwFEVy9NjjvxLF6y6d+FrYt9V54rfNtFvzOpDRZ
 Mk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wf1MmBNmIAfZmULUjfzH8CC2xLhdOMWrEvNVMzW+P8I=;
 b=LOgUmJdLL9JBsn9DPADznqngm+xIOG1fbzzdiUdKo2hWliUkUrHXc9eC/q2j8x0DNl
 0f2J8WgrryFzxy2dcOJDMS7Q4jEgTsX2wDQ9bMc6XigcgwbYxS04RR5kOKBfWglWG0RW
 pVYULBX18g76i7uHSjE66oY1KOCxWsGZM98/EQIuI63Y+OxnvYsGndKsXXCk2MXuPxZj
 UViz4v05P1ZVVdJWXZELgEV0dP/HxpmK+Jf3ExEiZsk3HScoRPGSYAwfsIJJ2l4bWx0l
 JOPcnyuQeBt4JRykEgruNbRNRH5EhJ0vuflTVEGBAjbzFe8+uJtm1VBA1g9lEvW6EoWE
 FUQw==
X-Gm-Message-State: AOAM532BvX4JdVVC5wL+31Z/jpZo9/PoLffNzsxJgnqOnaPHKDghsNJh
 NyqdoWl61SdNAEVKzmhyLn7qkWKhihOmeC/+uzE=
X-Google-Smtp-Source: ABdhPJz4DELVYtVhwAFXFNmRq1jD79KzbANwjAv6bZ7l0nXoZUTlGHRFmD1tuP/vP6q+SIu717KXYglUryg/frU/MT0=
X-Received: by 2002:a17:906:f899:: with SMTP id
 lg25mr5795071ejb.134.1633091106946; 
 Fri, 01 Oct 2021 05:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 2 Oct 2021 01:24:54 +1300
Message-ID: <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
X-Mailman-Approved-At: Fri, 01 Oct 2021 14:20:38 +0000
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, mike.campin@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Sep 22, 2021 at 5:14 PM Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
>
> Hi Joerg/Jason/Christoph et all,
>
> The current in-kernel supervisor PASID support is based on the SVM/SVA
> machinery in sva-lib. Kernel SVA is achieved by extending a special flag
> to indicate the binding of the device and a page table should be performed
> on init_mm instead of the mm of the current process.Page requests and other
> differences between user and kernel SVA are handled as special cases.
>
> This unrestricted binding with the kernel page table is being challenged
> for security and the convention that in-kernel DMA must be compatible with
> DMA APIs.
> (https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/)
> There is also the lack of IOTLB synchronization upon kernel page table updates.
>
> This patchset is trying to address these concerns by having an explicit DMA
> API compatible model while continue to support in-kernel use of DMA requests
> with PASID. Specifically, the following DMA-IOMMU APIs are introduced:
>
> int iommu_dma_pasid_enable/disable(struct device *dev,
>                                    struct iommu_domain **domain,
>                                    enum iommu_dma_pasid_mode mode);
> int iommu_map/unmap_kva(struct iommu_domain *domain,
>                         void *cpu_addr,size_t size, int prot);
>
> The following three addressing modes are supported with example API usages
> by device drivers.
>
> 1. Physical address (bypass) mode. Similar to DMA direct where trusted devices
> can DMA pass through IOMMU on a per PASID basis.
> Example:
>         pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_BYPASS);
>         /* Use the returning PASID and PA for work submission */
>
> 2. IOVA mode. DMA API compatible. Map a supervisor PASID the same way as the
> PCI requester ID (RID)
> Example:
>         pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_IOVA);
>         /* Use the PASID and DMA API allocated IOVA for work submission */

Hi Jacob,
might be stupid question, what is the performance benefit of this IOVA
mode comparing
with the current dma_map/unmap_single/sg API which have enabled IOMMU like
drivers/iommu/arm/arm-smmu-v3? Do we still need to flush IOTLB by sending
commands to IOMMU  each time while doing dma_unmap?

>
> 3. KVA mode. New kva map/unmap APIs. Support fast and strict sub-modes
> transparently based on device trustfulness.
> Example:
>         pasid = iommu_dma_pasid_enable(dev, &domain, IOMMU_DMA_PASID_KVA);
>         iommu_map_kva(domain, &buf, size, prot);
>         /* Use the returned PASID and KVA to submit work */
> Where:
>         Fast mode: Shared CPU page tables for trusted devices only
>         Strict mode: IOMMU domain returned for the untrusted device to
>         replicate KVA-PA mapping in IOMMU page tables.

a huge bottleneck of IOMMU we have seen before is that dma_unmap will
require IOTLB
flush, for example, in arm_smmu_cmdq_issue_cmdlist(), we are having
serious contention
on acquiring lock and delay on waiting for iotlb flush completion in
arm_smmu_cmdq_poll_until_sync() while multi-threads run.

I assume KVA mode can avoid this iotlb flush as the device is using
the page table
of the kernel and sharing the whole kernel space. But will users be
glad to accept
this mode?
It seems users are enduring the performance decrease of IOVA mapping
and unmapping
because it has better security. dma operations can only run on some
specific dma buffers
which have been mapped in the current dma-map/unmap with IOMMU backend.
some drivers are using bouncing buffer to overcome the performance loss of
dma_map/unmap as copying is faster than unmapping:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=907676b130711fd1f

BTW, we have been debugging on dma_map/unmap performance by this
benchmark:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/dma/map_benchmark.c
you might be able to use it for your benchmarking as well :-)

>
> On a per device basis, DMA address and performance modes are enabled by the
> device drivers. Platform information such as trustability, user command line
> input (not included in this set) could also be taken into consideration (not
> implemented in this RFC).
>
> This RFC is intended to communicate the API directions. Little testing is done
> outside IDXD and DMA engine tests.
>
> For PA and IOVA modes, the implementation is straightforward and tested with
> Intel IDXD driver. But several opens remain in KVA fast mode thus not tested:
> 1. Lack of IOTLB synchronization, kernel direct map alias can be updated as a
> result of module loading/eBPF load. Adding kernel mmu notifier?
> 2. The use of the auxiliary domain for KVA map, will aux domain stay in the
> long term? Is there another way to represent sub-device granu isolation?
> 3. Is limiting the KVA sharing to the direct map range reasonable and
> practical for all architectures?
>
>
> Many thanks to Ashok Raj, Kevin Tian, and Baolu who provided feedback and
> many ideas in this set.
>
> Thanks,
>
> Jacob
>
> Jacob Pan (7):
>   ioasid: reserve special PASID for in-kernel DMA
>   dma-iommu: Add API for DMA request with PASID
>   iommu/vt-d: Add DMA w/ PASID support for PA and IOVA
>   dma-iommu: Add support for DMA w/ PASID in KVA
>   iommu/vt-d: Add support for KVA PASID mode
>   iommu: Add KVA map API
>   dma/idxd: Use dma-iommu PASID API instead of SVA lib
>
>  drivers/dma/idxd/idxd.h                       |   4 +-
>  drivers/dma/idxd/init.c                       |  36 ++--
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
>  drivers/iommu/dma-iommu.c                     | 123 +++++++++++++-
>  drivers/iommu/intel/iommu.c                   | 154 +++++++++++++++++-
>  drivers/iommu/ioasid.c                        |   2 +
>  drivers/iommu/iommu-sva-lib.c                 |   1 +
>  drivers/iommu/iommu.c                         |  63 +++++++
>  include/linux/dma-iommu.h                     |  14 ++
>  include/linux/intel-iommu.h                   |   7 +-
>  include/linux/ioasid.h                        |   4 +
>  include/linux/iommu.h                         |  13 ++
>  12 files changed, 390 insertions(+), 33 deletions(-)
>
> --
> 2.25.1
>

Thanks
barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
