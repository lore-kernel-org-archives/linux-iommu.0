Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAB1C04AB5
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 00:51:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632FA20840
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 00:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="u+E9n/fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632FA20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 26FDFC74;
	Fri,  7 Jun 2019 00:51:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6C8A2AE0
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 00:36:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 530E1623
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 00:36:03 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id r135so244715ith.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 06 Jun 2019 17:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=7A9RUvu0n3Bt4UhAjkzkVndEPIfQbQzuowpA9agMyKM=;
	b=u+E9n/fcYZRBIG6EiOxDT0c67KRaVQVHtGEahegng3IZMA+9yNEYmGnxT6Au5lp3xS
	DUrdtztMxD/Kp/PaZL0jhiAHwzfCX4CZylNl3sf+59X5Wt5gilaY15vcPdysh6h37xys
	C8UWU6W3FTPCoNytPeNsyFFoiu8tHiB3a/NIC3mY01MpIrCmUNMLkRVPTHm9erFOCboE
	Yy0Di1jgzPS4w10Q+UMZb7fwhXF1supmVLVPK76XfAS7HircfVRJ/9ujq6a0/j+HM11E
	/42MHTZ9ImvuQbpJXIuvYvdfKsChLrXiycBJ2hOhrJvQWZVR43eqFGwFLuOP6QJxI3ZU
	bb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7A9RUvu0n3Bt4UhAjkzkVndEPIfQbQzuowpA9agMyKM=;
	b=ZD+GrTXWb8bkojLWbD/NShOpvEbgwjM9vFRtDXNGjomLlDLvdauC3MdJJPKP7an449
	czJj4gRQn/RpVNLjyOZPLHIewXyA1Q/1aKY/nvjIVSv1qaNi2d8Fepf2vggaIe3MQ3ES
	fvNTFWx+1ZvDKjTGNPfPgObOMkFVuTNav/zNLYsQEuAqFlbReJ/j4agUXptQAwFP2ddT
	nemv5mrUp0o2wqGwl4F3PfQ4QwB7y2BNaBsx+t1JdECGM7X4RtC8+PeDwANDFrdM1cnX
	KwpBlT4XIiAdLI8K+Slak+DRi05IWvOsDWzF5NR7RDgJYSkZ0BkRHTX53P0Tmu8zf2TW
	4FtA==
X-Gm-Message-State: APjAAAVKRMoobFn5JWl+wQ3aMRmMgc2gQqGDcrIBnZYa0qZmr3Q7Gk0o
	jLns2Ea0blENAPcZWwztCC/J4tihWFu/4iA/9M1y6g==
X-Google-Smtp-Source: APXvYqyHqN66GDCIO8XLc++aamWWvQQKrduhAh07DngI3gLNjcuViZej77vdnJNs6dUOjxfZcuoMFMraNXWWbgERJdU=
X-Received: by 2002:a24:6b52:: with SMTP id v79mr2047862itc.20.1559867762475; 
	Thu, 06 Jun 2019 17:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1558660583-28561-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
Date: Thu, 6 Jun 2019 17:35:51 -0700
Message-ID: <CABPqkBQP=JxpiQE7SVuJO3xPWvsFbAPj916RTYUgaMBDG1OdaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 17/21] x86/tsc: Switch to perf-based hardlockup
	detector if TSC become unstable
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailman-Approved-At: Fri, 07 Jun 2019 00:51:18 +0000
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
	Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
	Andi Kleen <andi.kleen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
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
From: Stephane Eranian via iommu <iommu@lists.linux-foundation.org>
Reply-To: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Ricardo,
Thanks for your contribution here. It is very important to move the
watchdog out of the PMU wherever possible.

On Thu, May 23, 2019 at 6:17 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The HPET-based hardlockup detector relies on the TSC to determine if an
> observed NMI interrupt was originated by HPET timer. Hence, this detector
> can no longer be used with an unstable TSC.
>
> In such case, permanently stop the HPET-based hardlockup detector and
> start the perf-based detector.
>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  arch/x86/include/asm/hpet.h    | 2 ++
>  arch/x86/kernel/tsc.c          | 2 ++
>  arch/x86/kernel/watchdog_hld.c | 7 +++++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
> index fd99f2390714..a82cbe17479d 100644
> --- a/arch/x86/include/asm/hpet.h
> +++ b/arch/x86/include/asm/hpet.h
> @@ -128,6 +128,7 @@ extern int hardlockup_detector_hpet_init(void);
>  extern void hardlockup_detector_hpet_stop(void);
>  extern void hardlockup_detector_hpet_enable(unsigned int cpu);
>  extern void hardlockup_detector_hpet_disable(unsigned int cpu);
> +extern void hardlockup_detector_switch_to_perf(void);
>  #else
>  static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
>  { return NULL; }
> @@ -136,6 +137,7 @@ static inline int hardlockup_detector_hpet_init(void)
>  static inline void hardlockup_detector_hpet_stop(void) {}
>  static inline void hardlockup_detector_hpet_enable(unsigned int cpu) {}
>  static inline void hardlockup_detector_hpet_disable(unsigned int cpu) {}
> +static void harrdlockup_detector_switch_to_perf(void) {}
>  #endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
>
This does not compile for me when CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
is not enabled.
because:
   1- you have a typo on the function name
    2- you are missing the inline keyword


>  #else /* CONFIG_HPET_TIMER */
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 59b57605e66c..b2210728ce3d 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1158,6 +1158,8 @@ void mark_tsc_unstable(char *reason)
>
>         clocksource_mark_unstable(&clocksource_tsc_early);
>         clocksource_mark_unstable(&clocksource_tsc);
> +
> +       hardlockup_detector_switch_to_perf();
>  }
>
>  EXPORT_SYMBOL_GPL(mark_tsc_unstable);
> diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
> index c2512d4c79c5..c8547c227a41 100644
> --- a/arch/x86/kernel/watchdog_hld.c
> +++ b/arch/x86/kernel/watchdog_hld.c
> @@ -76,3 +76,10 @@ void watchdog_nmi_stop(void)
>         if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
>                 hardlockup_detector_hpet_stop();
>  }
> +
> +void hardlockup_detector_switch_to_perf(void)
> +{
> +       detector_type = X86_HARDLOCKUP_DETECTOR_PERF;
> +       hardlockup_detector_hpet_stop();
> +       hardlockup_start_all();
> +}
> --
> 2.17.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
