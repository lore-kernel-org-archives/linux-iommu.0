Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8430C433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 10:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8164A4060B;
	Tue, 10 May 2022 10:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 66oqjlszLrj7; Tue, 10 May 2022 10:38:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 58D00400FB;
	Tue, 10 May 2022 10:38:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31F77C0032;
	Tue, 10 May 2022 10:38:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48D85C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 10:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36FC84025B
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 10:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Tu06Evvy3sm for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 10:38:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F8F740227
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 10:38:29 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 cu23-20020a17090afa9700b001d98d8e53b7so1731162pjb.0
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=6xgLoNI7AnkdMdRdHZQagLXDT+gwi8Sv7gdjtmJ1fxI=;
 b=T6qTS7KHImoKYcUCIh2yTrk/nUW/TK4BnMIPOFRnS9ToQQVZJX9ZQlKbCYW31c0IO1
 sld+XwFSToNAnhrZX50PHWDSBciQxB1A1RxgrcgIGnv6JHAzjXReB/MXWFCFV1eqNL8R
 zBQ7FeiOEgXkvzCOiwCT0pSLOrweX9bIzu5VO4rO5gOMQVvJQXKNQ3nj+sxXeS2UYmnB
 Th/dZASZ6FfFx9+0esk1NwNw8WLNRmvGyDvRgR4GIQQpmPPg/dYU3gadMQHwJAjLI+Dx
 aXMMfwDArKIjZPekEHfETJ+t1AGFD6AQCbQx3K9QxF3fKNhbNDXdBr+9DlvJlXOLF214
 WLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=6xgLoNI7AnkdMdRdHZQagLXDT+gwi8Sv7gdjtmJ1fxI=;
 b=ymHtaCB5xzcoTftE18a/byI05xyQIqz91Ea5RQl4YZNwFjJBER3H6Z+cqO9Wpr4nwS
 8ZRGBukYRGp5gjQ4loCwJCYj94Q14Poag/wgWVUZ4dqyWiQSd0RvzmjzTX/VKRLifduJ
 rTl/Okg0KuufR/vN0EC3svVDqGhV72v/unTOEZ/HFHQrXCrfYncp9uZ8I/fPuXA08vvV
 d/MvCty+fwGqs9kjqGN8doJm+2R9fMCyRhZHV5UIl3rY6bB8iWy2s1u9FRUyd9rVMRA+
 grvQle9TRdTKlvZMQwQ2MS88uM0stSvHWBWS0PB1tAgoLl8dEMyAMa9N6N8fAnisstQS
 5llQ==
X-Gm-Message-State: AOAM5316GBoM8pEwHWMd7W5a8CFlNtCr+5lpLE1mDMqvjBy4gRLpr00+
 045DyWH54s30eDINyGl3IUY=
X-Google-Smtp-Source: ABdhPJy2sDqUG4iE+M+9nKV8e7Dm6QX1UaW6u+uuX44X6Avdb00Clu5Sf5FhxTQSr0RHx4FiuKvk6Q==
X-Received: by 2002:a17:90b:314e:b0:1dc:d143:a15d with SMTP id
 ip14-20020a17090b314e00b001dcd143a15dmr23660047pjb.111.1652179108887; 
 Tue, 10 May 2022 03:38:28 -0700 (PDT)
Received: from localhost (193-116-127-232.tpgi.com.au. [193.116.127.232])
 by smtp.gmail.com with ESMTPSA id
 j192-20020a638bc9000000b003c14af505fcsm10107925pge.20.2022.05.10.03.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 03:38:28 -0700 (PDT)
Date: Tue, 10 May 2022 20:38:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 20/29] init/main: Delay initialization of the lockup
 detector after smp_init()
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, x86@kernel.org
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-21-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220506000008.30892-21-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-Id: <1652178524.7j2o02lrl8.astroid@bobo.none>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

Excerpts from Ricardo Neri's message of May 6, 2022 9:59 am:
> Certain implementations of the hardlockup detector require support for
> Inter-Processor Interrupt shorthands. On x86, support for these can only
> be determined after all the possible CPUs have booted once (in
> smp_init()). Other architectures may not need such check.
> 
> lockup_detector_init() only performs the initializations of data
> structures of the lockup detector. Hence, there are no dependencies on
> smp_init().

I think this is the only real thing which affects other watchdog types?

Not sure if it's a big problem, the secondary CPUs coming up won't
have their watchdog active until quite late, and the primary could
implement its own timeout in __cpu_up for secondary coming up, and
IPI it to get traces if necessary which is probably more robust.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v5:
>  * Introduced this patch
> 
> Changes since v4:
>  * N/A
> 
> Changes since v3:
>  * N/A
> 
> Changes since v2:
>  * N/A
> 
> Changes since v1:
>  * N/A
> ---
>  init/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 98182c3c2c4b..62c52c9e4c2b 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1600,9 +1600,11 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	rcu_init_tasks_generic();
>  	do_pre_smp_initcalls();
> -	lockup_detector_init();
>  
>  	smp_init();
> +
> +	lockup_detector_init();
> +
>  	sched_init_smp();
>  
>  	padata_init();
> -- 
> 2.17.1
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
