Return-Path: <SRS0=Jh8h=VQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CACC76195
	for <iommu@archiver.kernel.org>; Fri, 19 Jul 2019 04:26:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785522173B
	for <iommu@archiver.kernel.org>; Fri, 19 Jul 2019 04:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZglmsGRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785522173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 30CF921A4;
	Fri, 19 Jul 2019 04:26:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A5DEC21A0
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Jul 2019 04:25:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 98D07F8
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Jul 2019 04:25:51 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id q22so55704204iog.4
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 21:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=aEV/B/zfslSF4whrA8qZ2mb0nmcoO++IurBGcD9Yv4U=;
	b=ZglmsGRhAS8Qtc8o9xBVl/7WJ+NHL+DvG3giBl6HGmblKAtysO3VzRG3nVmNEzGZwN
	3puZVBa5jjVrWhAkLK/xhgdH8R6KP86XrMPkjKl+zDLx61MQfwRVKF0Nq7ZggSXjyv9V
	9BVFlpPiwaZR1nY8ow+lU/bSxyvOpOmkJSPIpqZ70LuJ0dDaHKtGJqgWwWFxmzUxEaQs
	2OKCE5ghX1VWbwwbDJckSv5561HV2bPDmAER3Z9VW2wBW6x/8gGh/jnkTuDqnAziVt0L
	1cFdqK5VqHwd32edUd/gDv9DlVLn+Zk/L6wSw9baMZlXT53haMkn8RK78ALbwOkv8T/M
	OC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=aEV/B/zfslSF4whrA8qZ2mb0nmcoO++IurBGcD9Yv4U=;
	b=UYAnRWuYLwjywBvhVg8PY9f2kZQ0w5pLzJmOrMXzI4SAo7iE1HRGvMpjzcv82b26HU
	ektvL9mTWq03OhhTZ8VemU46lUkjZn0xP6lATLxYAyLOEjGNJ9aCqjBDzywWqn/1lV9t
	Sq5ERng5E1P0WhYZRrG0o5/z/kLHugX978rqqOgdkP51TgEVZxDp+S3xV9uSuV2e1cnh
	mlTQYWUFr1RQLnGFBnEXcFcp2xlzT7VtSdbpV7E0YAZUmv8FSyUDr52EOGuasJVQNQBq
	SDvf5QG3HnP+oA+RZnxrfXcW8fQ5nJmErb37IdnbkntjtcTDZvOKQkxL5OhhbkG7DqpO
	gW5g==
X-Gm-Message-State: APjAAAXIfhP3d/uKo73mM+xUTl7Vat3xD3xVf8MxFDbwIQj69Rl+WJdH
	pAB1yZD/W5/FOpatAz0bLuOWscvMcHg/6NMYqjw=
X-Google-Smtp-Source: APXvYqz0l7cKVZZSjWpBAW6HMScMdZEAkzvtTOzb71tNuSDpsv+lK/DSvININq0epUP4KkCslzsarBELEJizVKGb1cY=
X-Received: by 2002:a02:b713:: with SMTP id g19mr52932372jam.77.1563510350938; 
	Thu, 18 Jul 2019 21:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190711171927.28803-1-will@kernel.org>
In-Reply-To: <20190711171927.28803-1-will@kernel.org>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Fri, 19 Jul 2019 09:55:39 +0530
Message-ID: <CAKTKpr58zHi0Nw=Fb8d4xHUenW1d76V2pkQ_0+BqWQ0OfBmtCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/19] Try to reduce lock contention on the SMMUv3
	command queue
To: Will Deacon <will@kernel.org>
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Will,

On Thu, Jul 11, 2019 at 10:58 PM Will Deacon <will@kernel.org> wrote:
>
> Hi everyone,
>
> This is a significant rework of the RFC I previously posted here:
>
>   https://lkml.kernel.org/r/20190611134603.4253-1-will.deacon@arm.com
>
> But this time, it looks like it might actually be worthwhile according
> to my perf profiles, where __iommu_unmap() falls a long way down the
> profile for a multi-threaded netperf run. I'm still relying on others to
> confirm this is useful, however.
>
> Some of the changes since last time are:
>
>   * Support for constructing and submitting a list of commands in the
>     driver
>
>   * Numerous changes to the IOMMU and io-pgtable APIs so that we can
>     submit commands in batches
>
>   * Removal of cmpxchg() from cmdq_shared_lock() fast-path
>
>   * Code restructuring and cleanups
>
> This current applies against my iommu/devel branch that Joerg has pulled
> for 5.3. If you want to test it out, I've put everything here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/cmdq
>
> Feedback welcome. I appreciate that we're in the merge window, but I
> wanted to get this on the list for people to look at as an RFC.

I have tried branch iommu/cmdq on ThunderX2. I do see there is drastic
reduction in CPU bandwidth consumption(from 15 to 20% to 1 to 2% in
perf top) from SMMU CMDQ helper functions, when I run iperf with more
than 64 clients(-P 64). However I have not noticed any measurable
performance improvement in iperf results. IMO, this might/should help
in performance improvement of IO intensive workloads.

FWIW, you can add,
Tested-by: Ganapatrao Kulkarni  <gkulkarni@marvell.com>

>
> Cheers,
>
> Will
>
> --->8
>
> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jayachandran Chandrasekharan Nair <jnair@marvell.com>
> Cc: Jan Glauber <jglauber@marvell.com>
> Cc: Jon Masters <jcm@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Vijay Kilary <vkilari@codeaurora.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
>
> Will Deacon (19):
>   iommu: Remove empty iommu_tlb_range_add() callback from iommu_ops
>   iommu/io-pgtable-arm: Remove redundant call to io_pgtable_tlb_sync()
>   iommu/io-pgtable: Rename iommu_gather_ops to iommu_flush_ops
>   iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes
>   iommu: Introduce iommu_iotlb_gather_add_page()
>   iommu: Pass struct iommu_iotlb_gather to ->unmap() and ->iotlb_sync()
>   iommu/io-pgtable: Introduce tlb_flush_walk() and tlb_flush_leaf()
>   iommu/io-pgtable: Hook up ->tlb_flush_walk() and ->tlb_flush_leaf() in
>     drivers
>   iommu/io-pgtable-arm: Call ->tlb_flush_walk() and ->tlb_flush_leaf()
>   iommu/io-pgtable: Replace ->tlb_add_flush() with ->tlb_add_page()
>   iommu/io-pgtable: Remove unused ->tlb_sync() callback
>   iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->unmap()
>   iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->tlb_add_page()
>   iommu/arm-smmu-v3: Separate s/w and h/w views of prod and cons indexes
>   iommu/arm-smmu-v3: Drop unused 'q' argument from Q_OVF macro
>   iommu/arm-smmu-v3: Move low-level queue fields out of arm_smmu_queue
>   iommu/arm-smmu-v3: Operate directly on low-level queue where possible
>   iommu/arm-smmu-v3: Reduce contention during command-queue insertion
>   iommu/arm-smmu-v3: Defer TLB invalidation until ->iotlb_sync()
>
>  drivers/gpu/drm/panfrost/panfrost_mmu.c |  24 +-
>  drivers/iommu/amd_iommu.c               |  11 +-
>  drivers/iommu/arm-smmu-v3.c             | 856 ++++++++++++++++++++++++--------
>  drivers/iommu/arm-smmu.c                | 103 +++-
>  drivers/iommu/dma-iommu.c               |   9 +-
>  drivers/iommu/exynos-iommu.c            |   3 +-
>  drivers/iommu/intel-iommu.c             |   3 +-
>  drivers/iommu/io-pgtable-arm-v7s.c      |  57 +--
>  drivers/iommu/io-pgtable-arm.c          |  48 +-
>  drivers/iommu/iommu.c                   |  24 +-
>  drivers/iommu/ipmmu-vmsa.c              |  28 +-
>  drivers/iommu/msm_iommu.c               |  42 +-
>  drivers/iommu/mtk_iommu.c               |  45 +-
>  drivers/iommu/mtk_iommu_v1.c            |   3 +-
>  drivers/iommu/omap-iommu.c              |   2 +-
>  drivers/iommu/qcom_iommu.c              |  44 +-
>  drivers/iommu/rockchip-iommu.c          |   2 +-
>  drivers/iommu/s390-iommu.c              |   3 +-
>  drivers/iommu/tegra-gart.c              |  12 +-
>  drivers/iommu/tegra-smmu.c              |   2 +-
>  drivers/vfio/vfio_iommu_type1.c         |  27 +-
>  include/linux/io-pgtable.h              |  57 ++-
>  include/linux/iommu.h                   |  92 +++-
>  23 files changed, 1090 insertions(+), 407 deletions(-)
>
> --
> 2.11.0
>

Thanks,
Ganapat
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
