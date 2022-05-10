Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0360C433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 11:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C9C3401B7;
	Tue, 10 May 2022 11:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xmqIFeAWX9Vt; Tue, 10 May 2022 11:16:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55AFD400FB;
	Tue, 10 May 2022 11:16:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18B05C0039;
	Tue, 10 May 2022 11:16:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E457FC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2146812A4
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gSEV7UUFUYr5 for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:16:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DB738126A
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:16:28 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id y41so9838735pfw.12
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 04:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=itXK+rSLc1QihSjSoLaf7Q70y9HboDnIPkUMbBBhjnc=;
 b=P3c5o4HPneI+4Z47/3z0XyAHSGtCqvR/q0W4Nq/bwgtUcYH0Uy0Jd0jWxYk3ghvprP
 M0MmtF9mSteO6SObGM+KeBSRL/Th4Qu4mVxig0ifQZanH/5wImDWSHEoJhwowNlgQztq
 +fdho63/Z8O8Z+lPnO6hj/iRJm5XvhSDG1+J1izpbMQslnk4JvepsnrwPHrDGzxgn5TR
 vcaqxwR/GfEGirCr+I2kPVsku19Q8PppQZVPQfxI8KglDGZCMvJ1WONiiaZUQFmDypie
 o8tTi9z3MKBG9nHO9duRSWery/b9fOyTFXWIIbFoAAf1r0nJxinLTdMxGhUiFTNW8gL+
 06eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=itXK+rSLc1QihSjSoLaf7Q70y9HboDnIPkUMbBBhjnc=;
 b=IPKkCjZ4I91WOVovQig8hpsBgN9jniROG+xF7RICARDz4ANdwzTXxA2k6BTVqiJcrH
 DFKU66NiBpeiU21EWhphOxb5h8tw5xGIr0PFQCrMoHP4pcHMFiHezktaDzcJRdpIkriU
 lBl+GR5ClBL+No5iafsnXvIIkdIcaoBd6eYCQhW2WnxUFJnLcFUk49jiLr2z1Y7MaqKj
 CgwftXZx6whgDzfSO6u6lDzqCLUMg32IaGklqd29mmzyvF6PJi3te6LHSHqnCdsk1W2t
 zkelivmucFFimnB2ca5XRXV4Mp/Ck2kNtR/wVrqkDXP+kNHnhG0ktCPT3BXy/g+w9wVa
 hTdw==
X-Gm-Message-State: AOAM533//zqSXnKHxZpeQC7q7ANjL59N7xkL0urAiE+eWlf45fll3dso
 Qil1fepl79Qs/tpiOgEoqVY=
X-Google-Smtp-Source: ABdhPJzVsABH4Oig0yRdlWGkgOiTbMOjWkvb+1zdab8hPOxvRkmGZAkmCY+fGQiGE352GRJimRZReg==
X-Received: by 2002:a05:6a00:21c2:b0:4fe:81f:46c7 with SMTP id
 t2-20020a056a0021c200b004fe081f46c7mr19960372pfj.5.1652181387580; 
 Tue, 10 May 2022 04:16:27 -0700 (PDT)
Received: from localhost (193-116-127-232.tpgi.com.au. [193.116.127.232])
 by smtp.gmail.com with ESMTPSA id
 z29-20020aa79f9d000000b0050dc7628170sm10462375pfr.74.2022.05.10.04.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 04:16:26 -0700 (PDT)
Date: Tue, 10 May 2022 21:16:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 28/29] x86/tsc: Restart NMI watchdog after refining
 tsc_khz
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, x86@kernel.org
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-Id: <1652180070.1r874kr0tg.astroid@bobo.none>
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

Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> The HPET hardlockup detector relies on tsc_khz to estimate the value of
> that the TSC will have when its HPET channel fires. A refined tsc_khz
> helps to estimate better the expected TSC value.
> 
> Using the early value of tsc_khz may lead to a large error in the expected
> TSC value. Restarting the NMI watchdog detector has the effect of kicking
> its HPET channel and make use of the refined tsc_khz.
> 
> When the HPET hardlockup is not in use, restarting the NMI watchdog is
> a noop.
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v5:
>  * Introduced this patch
> 
> Changes since v4
>  * N/A
> 
> Changes since v3
>  * N/A
> 
> Changes since v2:
>  * N/A
> 
> Changes since v1:
>  * N/A
> ---
>  arch/x86/kernel/tsc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index cafacb2e58cc..cc1843044d88 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1386,6 +1386,12 @@ static void tsc_refine_calibration_work(struct work_struct *work)
>  	/* Inform the TSC deadline clockevent devices about the recalibration */
>  	lapic_update_tsc_freq();
>  
> +	/*
> +	 * If in use, the HPET hardlockup detector relies on tsc_khz.
> +	 * Reconfigure it to make use of the refined tsc_khz.
> +	 */
> +	lockup_detector_reconfigure();

I don't know if the API is conceptually good.

You change something that the lockup detector is currently using, 
*while* the detector is running asynchronously, and then reconfigure
it. What happens in the window? If this code is only used for small
adjustments maybe it does not really matter but in principle it's
a bad API to export.

lockup_detector_reconfigure as an internal API is okay because it
reconfigures things while the watchdog is stopped [actually that
looks untrue for soft dog which uses watchdog_thresh in
is_softlockup(), but that should be fixed].

You're the arch so you're allowed to stop the watchdog and configure
it, e.g., hardlockup_detector_perf_stop() is called in arch/.

So you want to disable HPET watchdog if it was enabled, then update
wherever you're using tsc_khz, then re-enable.

Thanks,
Nick
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
