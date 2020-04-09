Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677B3C2BB55
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 17:26:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDB620771
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 17:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovy0PS17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDB620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9464786B77;
	Thu,  9 Apr 2020 17:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oWz4P7wb1f2x; Thu,  9 Apr 2020 17:26:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44E3486B34;
	Thu,  9 Apr 2020 17:26:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24DEBC1D7E;
	Thu,  9 Apr 2020 17:26:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 885F6C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 74A9486B12
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:08:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SFXmPhFyAdq3 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 16:08:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D584186B18
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:08:30 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id n10so4328071pff.3
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Bv5T4MVa9umd8pCEPysPH2jSGjRAmk+aGGhx29rknXE=;
 b=ovy0PS179BjEGMUbAV2YUjlkuVA7wmm5oMqdDajjp0TOKuVkoKJNQkBmal3FBh3iyk
 6uQVZEQZEmdg0/J26gmqgI3Xbf+Y9SwaKDT64/0Z8CygXa+0ktwKWdiNPZDog7inLt6j
 EkNOW+ZQR5kRoBjRRrAAWzyEACYmqWpUvYZJGZKKegZXwil+zgJHu093SKQthM1j8MLC
 8Rf5ULsWMKhJYVAk3C2yHu3UnAeVJgnEj0auKCeACDctiuS3MWj/DOurMbx2MkaY2pLJ
 LiDf/+F+qoyR8JD20gbatncLOb49n47pMUxVIU2+YzFasivC6WMkGvIWS3obeKnzK4ew
 qc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=Bv5T4MVa9umd8pCEPysPH2jSGjRAmk+aGGhx29rknXE=;
 b=AiffSkmkRXU9mpu5tUg4UAzXx1U4uxw4JI8o9cizme7W7d8+NG4VBasUsw3sRoP8uv
 R4WdYUlz7jFlYaX2GhCCMyIHN4ADdsGkzHnM9lmG2/hoXjQBrYseCjql7iwZJUHx4ojz
 fVoDPb15mMMlq9ymFX/GEgjW1APICPmPSLfJGoWqCfetrFyuXzPwHMjlYHY3jxy91Hov
 3b9CvGleG0bThKtFO8excJRYGWG4eRF1M9Me4Nn4OL/CiO1uQvkD7FVAh682MZhI7LBt
 crrD4qM2wTZlxd1I1AnRPIW06VxYrnTSxCMly8AwSH+qosRUWczMyE5cSawCYfboxsQH
 vdRw==
X-Gm-Message-State: AGi0Pua8E1wGp0+CpztAIRi4aUeSlQaHXDXKbTTM3ptSqJdBzpuPkxBY
 VyV+mSwEH4o2Qkmm4slQf2w=
X-Google-Smtp-Source: APiQypJFLGcG6dVXLdib9gF5oJvHoXpdIxKhy+0DVfXFFx+ZgGNqEvh6DF50PGrfKmNfspKnDLZDsQ==
X-Received: by 2002:a62:7e0e:: with SMTP id z14mr269015pfc.27.1586448510359;
 Thu, 09 Apr 2020 09:08:30 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
 by smtp.gmail.com with ESMTPSA id k12sm5867045pgj.33.2020.04.09.09.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 09:08:29 -0700 (PDT)
Date: Thu, 9 Apr 2020 09:08:26 -0700
From: Minchan Kim <minchan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200409160826.GC247701@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-11-hch@lst.de>
X-Mailman-Approved-At: Thu, 09 Apr 2020 17:26:42 +0000
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>,
 linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 sergey.senozhatsky@gmail.com, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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

On Wed, Apr 08, 2020 at 01:59:08PM +0200, Christoph Hellwig wrote:
> This allows to unexport map_vm_area and unmap_kernel_range, which are
> rather deep internal and should not be available to modules.

Even though I don't know how many usecase we have using zsmalloc as
module(I heard only once by dumb reason), it could affect existing
users. Thus, please include concrete explanation in the patch to
justify when the complain occurs.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/Kconfig   | 2 +-
>  mm/vmalloc.c | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 36949a9425b8..614cc786b519 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -702,7 +702,7 @@ config ZSMALLOC
>  
>  config ZSMALLOC_PGTABLE_MAPPING
>  	bool "Use page table mapping to access object in zsmalloc"
> -	depends on ZSMALLOC
> +	depends on ZSMALLOC=y
>  	help
>  	  By default, zsmalloc uses a copy-based object mapping method to
>  	  access allocations that span two pages. However, if a particular
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3375f9508ef6..9183fc0d365a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2046,7 +2046,6 @@ void unmap_kernel_range(unsigned long addr, unsigned long size)
>  	vunmap_page_range(addr, end);
>  	flush_tlb_kernel_range(addr, end);
>  }
> -EXPORT_SYMBOL_GPL(unmap_kernel_range);
>  
>  int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
>  {
> @@ -2058,7 +2057,6 @@ int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
>  
>  	return err > 0 ? 0 : err;
>  }
> -EXPORT_SYMBOL_GPL(map_vm_area);
>  
>  static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
>  	struct vmap_area *va, unsigned long flags, const void *caller)
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
