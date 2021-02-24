Return-Path: <SRS0=SJ72=H2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C9FC433E0
	for <iommu@archiver.kernel.org>; Wed, 24 Feb 2021 10:19:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F130C64ECB
	for <iommu@archiver.kernel.org>; Wed, 24 Feb 2021 10:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F130C64ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A76B83CD3;
	Wed, 24 Feb 2021 10:19:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id irCzsQ_mzoKq; Wed, 24 Feb 2021 10:19:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6834383C86;
	Wed, 24 Feb 2021 10:19:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DC90C000A;
	Wed, 24 Feb 2021 10:19:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62D13C0001
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 10:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51ACF4EBFD
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 10:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IzCYnLdjABbk for <iommu@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 10:19:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FAA74ABAD
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 10:19:48 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id b3so1329888wrj.5
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 02:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/FE7tvrvqoJrGxZtO1M2WLOCJzVWjV9STY44PZX27ks=;
 b=I+hKBBRhc37miRhiK8ZHrqDkDbC9ZQjaR5dVS+zd58oLtjUmKZm5Zq5kbd4+AwzinV
 L5Mykd0nm3IjEea2Rzw8z3ekuMvJHPInvHCZx/h8DGBqUQooGetyjVlF+7RgyAP8R8hQ
 mgBlVMqp4d9I1wwMJ7mYi/kTGeFmNrgu9a+43IKP3OYuJ+1N3j2N/z3Y4Wed9txt1qQV
 YE5Yu0tgHe4NGY6kWQHm/bgOf0NQXzC0aqwOG4C+y0QK0NZCcHJM6aPY6paaRZV5aoBl
 fG+XXh+JXLPl7e9TwPOy4rAkFYKSXm2aMjZQ50wtP3BngAZEVQIFWHIOI5yBQ9wanzEE
 VwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/FE7tvrvqoJrGxZtO1M2WLOCJzVWjV9STY44PZX27ks=;
 b=ruY/hl6RbC89NDhBlspulEPqe5eXeDWMf0SpFreE7Fn0ihP9KYph0SF8J/8QoPeN7+
 AGNsIkEyJEPpvzlbcE3d2RUN7xj/U/4eEXWyRadVQ6xcd5APasyZsVezxLdRVi4PvdLr
 Y6fqZTHpMD/Ng51/noV7/oJrJRwoWqPtnq2TkiU3087GifMxVxxdWy9dktWJotRYAtyV
 EXoYue4aH7Al8LcTPWeRk5brik8j4FdJudHoUQ+/S8P7CTbfmG12Q8/iGVJYKDNLnkkQ
 dnM6x54eDRuIvRh2iK5kZFFUqiDa2dkonTYlJ2OgH/akGlrxLLa7v+WsmVvdGEuKHVxi
 CrzQ==
X-Gm-Message-State: AOAM533AlLpON5nWMA0GBKiwBKQ960VhR5A5f4cJGUDdVuuba/GspGt+
 mjWIzmpQo4leTDipy1aU1YJv4Q==
X-Google-Smtp-Source: ABdhPJyKndYC691It/7gqXtAE5RbW9Z17Tm2vdDWURKYH/LNKjlcRD8BPcuGIEs1+3EkHAospr4whg==
X-Received: by 2002:adf:f941:: with SMTP id q1mr31859042wrr.189.1614161986271; 
 Wed, 24 Feb 2021 02:19:46 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v5sm2015023wmh.2.2021.02.24.02.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 02:19:45 -0800 (PST)
Date: Wed, 24 Feb 2021 11:19:27 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v6 08/12] fork: Clear PASID for new mm
Message-ID: <YDYoL/zZ9YaGgwSV@myrica>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-9-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1594684087-61184-9-git-send-email-fenghua.yu@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>, zhangfei.gao@foxmail.com,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Jacob Jun Pan <jacob.jun.pan@intel.com>
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

Hi Fenghua,

[Trimmed the Cc list]

On Mon, Jul 13, 2020 at 04:48:03PM -0700, Fenghua Yu wrote:
> When a new mm is created, its PASID should be cleared, i.e. the PASID is
> initialized to its init state 0 on both ARM and X86.

I just noticed this patch was dropped in v7, and am wondering whether we
could still upstream it. Does x86 need a child with a new address space
(!CLONE_VM) to inherit the PASID of the parent?  That doesn't make much
sense with regard to IOMMU structures - same PASID indexing multiple PGDs?

Currently iommu_sva_alloc_pasid() assumes mm->pasid is always initialized
to 0 and fails on forked tasks. I'm trying to figure out how to fix this.
Could we clear the pasid on fork or does it break the x86 model?

Thanks,
Jean

> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v2:
> - Add this patch to initialize PASID value for a new mm.
> 
>  include/linux/mm_types.h | 2 ++
>  kernel/fork.c            | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index d61285cfe027..d60d2ec10881 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -22,6 +22,8 @@
>  #endif
>  #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
>  
> +/* Initial PASID value is 0. */
> +#define INIT_PASID	0
>  
>  struct address_space;
>  struct mem_cgroup;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 142b23645d82..43b5f112604d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1007,6 +1007,13 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
>  #endif
>  }
>  
> +static void mm_init_pasid(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_IOMMU_SUPPORT
> +	mm->pasid = INIT_PASID;
> +#endif
> +}
> +
>  static void mm_init_uprobes_state(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_UPROBES
> @@ -1035,6 +1042,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm_init_cpumask(mm);
>  	mm_init_aio(mm);
>  	mm_init_owner(mm, p);
> +	mm_init_pasid(mm);
>  	RCU_INIT_POINTER(mm->exe_file, NULL);
>  	mmu_notifier_subscriptions_init(mm);
>  	init_tlb_flush_pending(mm);
> -- 
> 2.19.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
