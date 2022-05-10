Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F06C433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 12:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12B70823A0;
	Tue, 10 May 2022 12:14:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5sOADRzp7oKO; Tue, 10 May 2022 12:14:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C3DB781DA3;
	Tue, 10 May 2022 12:14:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AD01C0032;
	Tue, 10 May 2022 12:14:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EB5FC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 12:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0827140144
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 12:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3xBoV4D8HqFJ for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 12:14:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 521D2400FB
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 12:14:07 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id i17so16559618pla.10
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=4P2EaKGEH+jdcOlX4AfyzB/ukf7xEI4yNHJh/y1RIOk=;
 b=hXbDIpkhGyRok8d2v7bgOpLFS9XYvJYr9I+ID5KHWzxG4BbiZAjIAmNEK87ukmll7n
 7UJKz4lUEfAPthNA9yFFoSyJ1Ai2Z7WmqbDxRs6BvDlJ2HoZfwx/j5SCPo2XuN3NMWIH
 O4+MhBLI/8T0QAi2W8izPKsLZVnwyZYihJ3flz3DahvBjPR+vsZWxi9oXsCEJZoNsRmQ
 hJv3g7QSJpEWU89iflrnveCx/2PXNU7m8MKYR+vjbEkxSivEWUVmLq5CrpE5W62pXTu8
 360wskvzONw3pNMAfBoTnwIN1C9gv8QiAXJs5pw4BI8J2YNaxXpS4++DZ/osnV6pJYSi
 zmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=4P2EaKGEH+jdcOlX4AfyzB/ukf7xEI4yNHJh/y1RIOk=;
 b=5n51xsXY9BHA2+CvPY6PkeMhbJRWaPyaARhOtI/t1VJfVz6VAC9kndiS+UzRNnpX5x
 XI+PoAur46X2oBRzI2CmkhV3sVV7siIR2hp64fcp1V9qcMOjlSZ8V5038567ajz3PNzd
 yq/a021ZLE0pA+He4WEFxftRpOpMiEocnEPjUSbEtiSFZn1VwJYthEpqbBoBOcY/9tg/
 X5p2nDukAC9I6b8U8udslqr07TQp5t1UchgdUy3oGTTC30ukaPpy6blhwWCXibhRLOz/
 lp4f9QNhq5nAyF4uKVFxHl0WWPpDLw+zeaj5bmZERerrBCnTZgJwx+r/OXF5/Tpt4aHm
 VE7Q==
X-Gm-Message-State: AOAM530YhE9xTc9PeDa01WoYrXy564LKi/QaXKXyLRfIpAZuyTjFPj5h
 4E5abgBsZb4NpecQPNN3S40=
X-Google-Smtp-Source: ABdhPJzJAToQf1bsuvOx1j/eutoC/7K7S0JvO2rKDs7VCIhTV7yNnNXkOt3ghkj3E+FkIR2Go2yu5A==
X-Received: by 2002:a17:90b:3b4c:b0:1dc:7edf:c92f with SMTP id
 ot12-20020a17090b3b4c00b001dc7edfc92fmr22394368pjb.91.1652184846778; 
 Tue, 10 May 2022 05:14:06 -0700 (PDT)
Received: from localhost (193-116-127-232.tpgi.com.au. [193.116.127.232])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a056a00150400b0050dc76281a1sm10909855pfu.123.2022.05.10.05.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 05:14:05 -0700 (PDT)
Date: Tue, 10 May 2022 22:14:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 29/29] x86/tsc: Switch to perf-based hardlockup
 detector if TSC become unstable
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, x86@kernel.org
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-30-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220506000008.30892-30-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-Id: <1652184158.yhzceh3nwk.astroid@bobo.none>
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
> The HPET-based hardlockup detector relies on the TSC to determine if an
> observed NMI interrupt was originated by HPET timer. Hence, this detector
> can no longer be used with an unstable TSC.
> 
> In such case, permanently stop the HPET-based hardlockup detector and
> start the perf-based detector.
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v5:
>  * Relocated the delcaration of hardlockup_detector_switch_to_perf() to
>    x86/nmi.h It does not depend on HPET.
>  * Removed function stub. The shim hardlockup detector is always for x86.
> 
> Changes since v4:
>  * Added a stub version of hardlockup_detector_switch_to_perf() for
>    !CONFIG_HPET_TIMER. (lkp)
>  * Reconfigure the whole lockup detector instead of unconditionally
>    starting the perf-based hardlockup detector.
> 
> Changes since v3:
>  * None
> 
> Changes since v2:
>  * Introduced this patch.
> 
> Changes since v1:
>  * N/A
> ---
>  arch/x86/include/asm/nmi.h     | 6 ++++++
>  arch/x86/kernel/tsc.c          | 2 ++
>  arch/x86/kernel/watchdog_hld.c | 6 ++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
> index 4a0d5b562c91..47752ff67d8b 100644
> --- a/arch/x86/include/asm/nmi.h
> +++ b/arch/x86/include/asm/nmi.h
> @@ -63,4 +63,10 @@ void stop_nmi(void);
>  void restart_nmi(void);
>  void local_touch_nmi(void);
>  
> +#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR
> +void hardlockup_detector_switch_to_perf(void);
> +#else
> +static inline void hardlockup_detector_switch_to_perf(void) { }
> +#endif
> +
>  #endif /* _ASM_X86_NMI_H */
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index cc1843044d88..74772ffc79d1 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1176,6 +1176,8 @@ void mark_tsc_unstable(char *reason)
>  
>  	clocksource_mark_unstable(&clocksource_tsc_early);
>  	clocksource_mark_unstable(&clocksource_tsc);
> +
> +	hardlockup_detector_switch_to_perf();
>  }
>  
>  EXPORT_SYMBOL_GPL(mark_tsc_unstable);
> diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
> index ef11f0af4ef5..7940977c6312 100644
> --- a/arch/x86/kernel/watchdog_hld.c
> +++ b/arch/x86/kernel/watchdog_hld.c
> @@ -83,3 +83,9 @@ void watchdog_nmi_start(void)
>  	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
>  		hardlockup_detector_hpet_start();
>  }
> +
> +void hardlockup_detector_switch_to_perf(void)
> +{
> +	detector_type = X86_HARDLOCKUP_DETECTOR_PERF;

Another possible problem along the same lines here,
isn't your watchdog still running at this point? And
it uses detector_type in the switch.

> +	lockup_detector_reconfigure();

Actually the detector_type switch is used in some
functions called by lockup_detector_reconfigure()
e.g., watchdog_nmi_stop, so this seems buggy even
without concurrent watchdog.

Is this switching a good idea in general? The admin
has asked for non-standard option because they want
more PMU counterss available and now it eats a
counter potentially causing a problem rather than
detecting one.

I would rather just disable with a warning if it were
up to me. If you *really* wanted to be fancy then
allow admin to re-enable via proc maybe.

Thanks,
Nick

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
