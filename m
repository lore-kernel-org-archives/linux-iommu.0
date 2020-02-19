Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D8C34047
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 12:27:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A8521D56
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 12:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="YmZlNVCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A8521D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6456520498;
	Wed, 19 Feb 2020 12:27:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snsWrBqZ1h52; Wed, 19 Feb 2020 12:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 46E5920357;
	Wed, 19 Feb 2020 12:27:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A130C1D80;
	Wed, 19 Feb 2020 12:27:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC6CAC013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 12:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DA61385C97
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 12:27:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TV7GHkkLUjWf for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 12:27:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.23])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5E84C85C86
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 12:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582115244;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=Kol9alQE2fexr84Vk2G3U8D7xmADEfgWOaQY2AkKXbY=;
 b=YmZlNVCN9WvRL7oD8husB+oHY+0rgZurawiyJiXbVAFw/qeC2m6ajL2Mb/KZOxzxEq
 BpA+42rxv1RXtFICscR6+Rvt9+xr9dVY3v7ALZaZA69C5WHTa+ruAjRPAFjK2/fhIx3O
 Mko7LJ1IpJsalkPnmECyMIMmDwMSFr7+SxrvKbL5RJXQc9u6dKJbFp8TR9049NR48Hy5
 9yYtTHJZHXuw1Pwiufugd/jSg5XdrV7jQUjQklDUNEt1VKf1Z9QYnCi7JeixqLIvUspe
 W17eBfcEq9Ak+ITBBIPFn+SbmHAZ3NmLNplQO6Ojl1uv9laoaN1h5nM9aNMENmDII2+F
 NGuA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJAQeMuXURD"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net by smtp.strato.de (RZmta 46.1.12 AUTH)
 with ESMTPSA id a01fe9w1JCRHpgR
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 19 Feb 2020 13:27:17 +0100 (CET)
Date: Wed, 19 Feb 2020 13:27:11 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 8/8] iommu/io-pgtable-arm: Prepare for TTBR1 usage
Message-ID: <20200219122711.GA176090@gerhold.net>
References: <20200110152852.24259-1-will@kernel.org>
 <20200110152852.24259-9-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200110152852.24259-9-will@kernel.org>
Cc: iommu@lists.linux-foundation.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org
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

Hi Will, Hi Robin,

On Fri, Jan 10, 2020 at 03:28:52PM +0000, Will Deacon wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Now that we can correctly extract top-level indices without relying on
> the remaining upper bits being zero, the only remaining impediments to
> using a given table for TTBR1 are the address validation on map/unmap
> and the awkward TCR translation granule format. Add a quirk so that we
> can do the right thing at those points.
> 
> Tested-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++------
>  include/linux/io-pgtable.h     |  4 ++++
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 846963c87e0f..5e966ef0bacf 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -104,6 +104,10 @@
>  #define ARM_LPAE_TCR_TG0_64K		1
>  #define ARM_LPAE_TCR_TG0_16K		2
>  
> +#define ARM_LPAE_TCR_TG1_16K		1
> +#define ARM_LPAE_TCR_TG1_4K		2
> +#define ARM_LPAE_TCR_TG1_64K		3
> +
>  #define ARM_LPAE_TCR_SH_NS		0
>  #define ARM_LPAE_TCR_SH_OS		2
>  #define ARM_LPAE_TCR_SH_IS		3
> @@ -463,6 +467,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	arm_lpae_iopte *ptep = data->pgd;
>  	int ret, lvl = data->start_level;
>  	arm_lpae_iopte prot;
> +	long iaext = (long)iova >> cfg->ias;
>  
>  	/* If no access, then nothing to do */
>  	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> @@ -471,7 +476,9 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
>  		return -EINVAL;
>  
> -	if (WARN_ON(iova >> data->iop.cfg.ias || paddr >> data->iop.cfg.oas))
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> +		iaext = ~iaext;
> +	if (WARN_ON(iaext || paddr >> cfg->oas))
>  		return -ERANGE;
>  
>  	prot = arm_lpae_prot_to_pte(data, iommu_prot);
> @@ -637,11 +644,14 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>  	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>  	arm_lpae_iopte *ptep = data->pgd;
> +	long iaext = (long)iova >> cfg->ias;
>  
>  	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
>  		return 0;
>  
> -	if (WARN_ON(iova >> data->iop.cfg.ias))
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> +		iaext = ~iaext;
> +	if (WARN_ON(iaext))
>  		return 0;
>  
>  	return __arm_lpae_unmap(data, gather, iova, size, data->start_level, ptep);

This part of the patch seems to break io-pgtable-arm.c on ARM32 to some
extent. I have a device using qcom_iommu that could normally run ARM64,
but I'm unable to because of outdated (signed) firmware. :(
So it's running a lot of code that would normally run only on ARM64.

It used to work quite well but now qcom-venus fails to probe on:
    if (WARN_ON(iaext || paddr >> cfg->oas))
(I added some debug prints for clarity.)

    qcom-venus 1d00000.video-codec: Adding to iommu group 0
    arm-lpae io-pgtable: quirks: 0x0
    arm-lpae io-pgtable: arm_lpae_map: iova: 0xdd800000, paddr: 0xebe3f000, iaext: 0xffffffff, paddr >> oas: 0x0
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 954 at drivers/iommu/io-pgtable-arm.c:487 arm_lpae_map+0xe4/0x510
    Hardware name: Generic DT based system
    ...
    [<c04bafb0>] (arm_lpae_map) from [<c04bcd6c>] (qcom_iommu_map+0x50/0x78)
    [<c04bcd6c>] (qcom_iommu_map) from [<c04b7290>] (__iommu_map+0xe8/0x1cc)
    [<c04b7290>] (__iommu_map) from [<c04b7bbc>] (__iommu_map_sg+0xa8/0x118)
    [<c04b7bbc>] (__iommu_map_sg) from [<c04b7c64>] (iommu_map_sg_atomic+0x18/0x20)
    [<c04b7c64>] (iommu_map_sg_atomic) from [<c04b94f8>] (iommu_dma_alloc+0x4dc/0x5a0)
    [<c04b94f8>] (iommu_dma_alloc) from [<c0196a50>] (dma_alloc_attrs+0x104/0x114)
    [<c0196a50>] (dma_alloc_attrs) from [<bf302c60>] (venus_hfi_create+0xa4/0x260 [venus_core])
    [<bf302c60>] (venus_hfi_create [venus_core]) from [<bf2fe6cc>] (venus_probe+0x1e4/0x328 [venus_core])
    [<bf2fe6cc>] (venus_probe [venus_core]) from [<c04c8eb4>] (platform_drv_probe+0x48/0x98)
    ...
    Exception stack(0xc2587fa8 to 0xc2587ff0)
    7fa0:                   b6f3dc70 b5051010 b5051010 0017388c b6e645b0 b6e645b0
    7fc0: b6f3dc70 b5051010 00020000 00000080 b6e30790 be84ea54 0046ac91 00000000
    7fe0: b6e75f1c be84e940 b6e5fb51 b6eec8a4
    ---[ end trace 2a0ed284f6d82f16 ]---
    qcom-venus: probe of 1d00000.video-codec failed with error -12

Note that iaext = 0xffffffff != 0.
It seems to be some int/long size problem that only happens with larger
iova addresses on 32-bit systems.

Without the (long) cast for iova everything is working correctly again:

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 983b08477e64..f7ecc763c706 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -468,7 +468,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	arm_lpae_iopte *ptep = data->pgd;
 	int ret, lvl = data->start_level;
 	arm_lpae_iopte prot;
-	long iaext = (long)iova >> cfg->ias;
+	long iaext = iova >> cfg->ias;
 
 	/* If no access, then nothing to do */
 	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
@@ -645,7 +645,7 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_lpae_iopte *ptep = data->pgd;
-	long iaext = (long)iova >> cfg->ias;
+	long iaext = iova >> cfg->ias;
 
 	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
 		return 0;

But I'm not sure if this is really the correct "fix"...

This problem can be also easily reproduced by enabling
IOMMU_IO_PGTABLE_LPAE_SELFTEST on ARM32.
(Shouldn't there be some system that runs these automatically? ;))

Without this patch all of them are passing:

    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 32
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 36
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 40
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 42
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 44
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 48
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 32
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 36
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 40
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 42
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 44
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 48
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 32
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 36
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 40
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 42
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 44
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 48
    arm-lpae io-pgtable: selftest: completed with 18 PASS 0 FAIL

But with this patch 6 of them are failing (with a similar warning as
I posted above):

    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 32
    ------------[ cut here ]------------
    WARNING: CPU: 3 PID: 1 at drivers/iommu/io-pgtable-arm.c:482 arm_lpae_map+0xa4/0x4e4
    Hardware name: Generic DT based system
    [<c01104ac>] (unwind_backtrace) from [<c010c0b4>] (show_stack+0x10/0x14)
    [<c010c0b4>] (show_stack) from [<c06cfb34>] (dump_stack+0x90/0xa4)
    [<c06cfb34>] (dump_stack) from [<c012d76c>] (__warn+0xb8/0xd4)
    [<c012d76c>] (__warn) from [<c012d7ec>] (warn_slowpath_fmt+0x64/0xbc)
    [<c012d7ec>] (warn_slowpath_fmt) from [<c04baf70>] (arm_lpae_map+0xa4/0x4e4)
    [<c04baf70>] (arm_lpae_map) from [<c0a1de3c>] (arm_lpae_do_selftests+0x234/0x688)
    [<c0a1de3c>] (arm_lpae_do_selftests) from [<c0102788>] (do_one_initcall+0x50/0x1b8)
    [<c0102788>] (do_one_initcall) from [<c0a0148c>] (kernel_init_freeable+0x1ec/0x25c)
    [<c0a0148c>] (kernel_init_freeable) from [<c06e6dc4>] (kernel_init+0x8/0x110)
    [<c06e6dc4>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
    Exception stack(0xee867fb0 to 0xee867ff8)
    7fa0:                                     00000000 00000000 00000000 00000000
    7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
    7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
    ---[ end trace 89e831c50a111e7c ]---
    ------------[ cut here ]------------
    WARNING: CPU: 3 PID: 1 at drivers/iommu/io-pgtable-arm.c:1182 arm_lpae_do_selftests+0x4b8/0x688
    selftest: test failed for fmt idx 0
    Hardware name: Generic DT based system
    [<c01104ac>] (unwind_backtrace) from [<c010c0b4>] (show_stack+0x10/0x14)
    [<c010c0b4>] (show_stack) from [<c06cfb34>] (dump_stack+0x90/0xa4)
    [<c06cfb34>] (dump_stack) from [<c012d76c>] (__warn+0xb8/0xd4)
    [<c012d76c>] (__warn) from [<c012d820>] (warn_slowpath_fmt+0x98/0xbc)
    [<c012d820>] (warn_slowpath_fmt) from [<c0a1e0c0>] (arm_lpae_do_selftests+0x4b8/0x688)
    [<c0a1e0c0>] (arm_lpae_do_selftests) from [<c0102788>] (do_one_initcall+0x50/0x1b8)
    [<c0102788>] (do_one_initcall) from [<c0a0148c>] (kernel_init_freeable+0x1ec/0x25c)
    [<c0a0148c>] (kernel_init_freeable) from [<c06e6dc4>] (kernel_init+0x8/0x110)
    [<c06e6dc4>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
    Exception stack(0xee867fb0 to 0xee867ff8)
    7fa0:                                     00000000 00000000 00000000 00000000
    7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
    7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
    ---[ end trace 89e831c50a111e7d ]---
    arm-lpae io-pgtable: cfg: pgsize_bitmap 0x40201000, ias 32-bit
    arm-lpae io-pgtable: data: 3 levels, 0x20 pgd_size, 12 pg_shift, 9 bits_per_level, pgd @ (ptrval)
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 36
    [warning as above]
    arm-lpae io-pgtable: cfg: pgsize_bitmap 0x40201000, ias 36-bit
    arm-lpae io-pgtable: data: 3 levels, 0x200 pgd_size, 12 pg_shift, 9 bits_per_level, pgd @ (ptrval)
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 40
    [warning as above]
    arm-lpae io-pgtable: cfg: pgsize_bitmap 0x40201000, ias 40-bit
    arm-lpae io-pgtable: data: 4 levels, 0x10 pgd_size, 12 pg_shift, 9 bits_per_level, pgd @ (ptrval)
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 42
    [warning as above]
    arm-lpae io-pgtable: cfg: pgsize_bitmap 0x40201000, ias 42-bit
    arm-lpae io-pgtable: data: 4 levels, 0x40 pgd_size, 12 pg_shift, 9 bits_per_level, pgd @ (ptrval)
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 44
    [warning as above]
    arm-lpae io-pgtable: cfg: pgsize_bitmap 0x40201000, ias 44-bit
    arm-lpae io-pgtable: data: 4 levels, 0x100 pgd_size, 12 pg_shift, 9 bits_per_level, pgd @ (ptrval)
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 48
    [warning as above]
    arm-lpae io-pgtable: cfg: pgsize_bitmap 0x40201000, ias 48-bit
    arm-lpae io-pgtable: data: 4 levels, 0x1000 pgd_size, 12 pg_shift, 9 bits_per_level, pgd @ (ptrval)
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 32
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 36
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 40
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 42
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 44
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS 48
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 32
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 36
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 40
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 42
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 44
    arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS 48
    arm-lpae io-pgtable: selftest: completed with 12 PASS 6 FAIL

Any suggestions how to fix this properly?

Thanks,
Stephan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
