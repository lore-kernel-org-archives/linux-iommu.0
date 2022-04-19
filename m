Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D438DC433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 23:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4EF5C4011A;
	Tue, 19 Apr 2022 23:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AilopS7XmGAk; Tue, 19 Apr 2022 23:10:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 423144012F;
	Tue, 19 Apr 2022 23:10:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10C76C0033;
	Tue, 19 Apr 2022 23:10:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84C21C002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 23:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EF65830C5
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 23:10:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YmRO7u_pK--s for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 23:10:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B65183054
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 23:10:37 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id n11so201061qvl.0
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 16:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BqRJfE9wcxy/J31E/EGSuMmVa/+tMH9w0KWrjCNItEs=;
 b=Lq9P2L3c2nv2ArDspJSfMNUzfpZpnfo8tq6OIHQlEvfH4Tmd1hklwyZEJk/fF4JCyE
 L496nczWfywcca2n+zz298hZ2WpckS2BclllYcsf2Dwa1bUkxVpbafDTUdlNipAc0iAC
 ADWwmZ9lRQJ8DNlcruObZH7mt25t1VagS6bRJX3D18FJZ63KB4w5wtx4W5+AMakVV997
 s5qVrDO62GwSFXQ92AEHktII+39ta3oK0+WOrg0teoL/PPOsLofmcczCTZN2n3HL9jlW
 uzUTqJ5HFipcfZTYrYRviFRGHORfguhOrrSS4Jd/Z5Jxr1iWlZ8I8p/YufoX7NVASe8T
 mynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BqRJfE9wcxy/J31E/EGSuMmVa/+tMH9w0KWrjCNItEs=;
 b=gKaQxkrzYaAg+qPdgU35EcaIFGffmnA4i6OIsDolkFfNZc/RILN3tRNl/UZO8uA7io
 HsGyNkNE7BGYOY8kMPmKURKhbCt7sukXlsJ8PKw4Ze4TesROlnH8sk0erd0wJB7gn6vW
 wVuZJ6Lw5xH3qE0ffEpoPWt8oyWEEUmnCEHlkmmern0oLCoU+zlcMwd8iXYvUerDeL7v
 O0vqIW8/ZFy9Xg02nN75KtVLAzEj/9avDOy129/S4QG37LeKgYV/a3NIVsQOplDIolSq
 2QPJRLBpeRqjHi0tm/mu8MbJhglcwxOKaetST1woN+lAuWi3PsPX7YXefESP0zgeuwL4
 cDGA==
X-Gm-Message-State: AOAM531VnneDZcFxbe26fM8cGOI02dVdoQdOPTCHseFmulDuN8xSno5J
 Ou1ErdlW4/CvHZsql11WGhFX9Q==
X-Google-Smtp-Source: ABdhPJxjyWezaqzPwLzIfphtO9gz87De0TwN3le3tUOtbPKBMtK7d2Kl55kLcz08VPBnyPF7JgxmXA==
X-Received: by 2002:a05:6214:2aaf:b0:446:70be:8377 with SMTP id
 js15-20020a0562142aaf00b0044670be8377mr4632304qvb.105.1650409836152; 
 Tue, 19 Apr 2022 16:10:36 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 n3-20020a05620a152300b0069ec409e679sm673684qkk.48.2022.04.19.16.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 16:10:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1ngwzS-005iPf-Hz; Tue, 19 Apr 2022 20:10:34 -0300
Date: Tue, 19 Apr 2022 20:10:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix size calculation in
 arm_smmu_mm_invalidate_range()
Message-ID: <20220419231034.GP64706@ziepe.ca>
References: <20220419210158.21320-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220419210158.21320-1-nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, fenghua.yu@intel.com, will@kernel.org,
 linux-kernel@vger.kernel.org, rikard.falkeborn@gmail.com,
 iommu@lists.linux-foundation.org, stable@vger.kernel.org, robin.murphy@arm.com,
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

On Tue, Apr 19, 2022 at 02:01:58PM -0700, Nicolin Chen wrote:
> The arm_smmu_mm_invalidate_range function is designed to be called
> by mm core for Shared Virtual Addressing purpose between IOMMU and
> CPU MMU. However, the ways of two subsystems defining their "end"
> addresses are slightly different. IOMMU defines its "end" address
> using the last address of an address range, while mm core defines
> that using the following address of an address range:
> 
> 	include/linux/mm_types.h:
> 		unsigned long vm_end;
> 		/* The first byte after our end address ...
> 
> This mismatch resulted in an incorrect calculation for size so it
> failed to be page-size aligned. Further, it caused a dead loop at
> "while (iova < end)" check in __arm_smmu_tlb_inv_range function.
> 
> This patch fixes the issue by doing the calculation correctly.
> 
> Fixes: 2f7e8c553e98d ("iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> -	size_t size = end - start + 1;
> +	size_t size;
> +
> +	/*
> +	 * The mm_types defines vm_end as the first byte after the end address,
> +	 * different from IOMMU subsystem using the last address of an address
> +	 * range. So do a simple translation here by calculating size correctly.
> +	 */
> +	size = end - start;

I would skip the comment though

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
