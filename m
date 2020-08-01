Return-Path: <SRS0=Zw9n=BL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84714C433E3
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 01:45:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553172072A
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 01:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1SkbLbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553172072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 33C9B887C0;
	Sat,  1 Aug 2020 01:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7yTLHRqkQvJ; Sat,  1 Aug 2020 01:45:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 85F32887A1;
	Sat,  1 Aug 2020 01:45:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69192C0050;
	Sat,  1 Aug 2020 01:45:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91284C004D
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 01:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7CF43887C0
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 01:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WdcH8HGDj+Sm for <iommu@lists.linux-foundation.org>;
 Sat,  1 Aug 2020 01:45:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AD87B887A1
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 01:45:09 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4175E22D00
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 01:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596246309;
 bh=sjM/fAEGxClBOS+U8ynUmUP8+Aqqz5vPbhJDNMh/upo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=F1SkbLbUJ63XFPRTdKYmubCKNKuEDUn5TJzuwqzFh27nWgv3Rr/Uql7ap51TY6DiB
 qppf/kYJ0H7ph2yfZ8MdEFAaHqL48XD2XHiWnKGm7vQVhlDW671FZNWLt5H0Ofw0nx
 jW3YfBAep/edgRAqc1YIvwdTIjnwfAbjQ+zglJQA=
Received: by mail-ed1-f44.google.com with SMTP id v22so12781973edy.0
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 18:45:09 -0700 (PDT)
X-Gm-Message-State: AOAM53042DQKJ/LR6SxntuvkOeT4FAxCxFqW7r3hTF25KlI5monqeX6D
 2WO862untzsjwlKBfuUDaFX7eBIFDCw1XdcSL30l+Q==
X-Google-Smtp-Source: ABdhPJyh2ARx8wi/UN9nL/otfHQZd5+RGHN7quC5P7hkzkPIb5B7BkSWz9rivA5myA2qOsQl6oEslOsrzUBxG9umpGs=
X-Received: by 2002:adf:fa85:: with SMTP id h5mr5822401wrr.18.1596246306953;
 Fri, 31 Jul 2020 18:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-10-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1594684087-61184-10-git-send-email-fenghua.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 31 Jul 2020 18:44:55 -0700
X-Gmail-Original-Message-ID: <CALCETrVZiCG4rcdMrs2F437oyBooQ2xt+feZLeK7qPk90gmOSw@mail.gmail.com>
Message-ID: <CALCETrVZiCG4rcdMrs2F437oyBooQ2xt+feZLeK7qPk90gmOSw@mail.gmail.com>
Subject: Re: [PATCH v6 09/12] x86/process: Clear PASID state for a newly
 forked/cloned thread
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, Jul 13, 2020 at 4:48 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> The PASID state has to be cleared on forks, since the child has a
> different address space. The PASID is also cleared for thread clone. While
> it would be correct to inherit the PASID in this case, it is unknown
> whether the new task will use ENQCMD. Giving it the PASID "just in case"
> would have the downside of increased context switch overhead to setting
> the PASID MSR.
>
> Since #GP faults have to be handled on any threads that were created before
> the PASID was assigned to the mm of the process, newly created threads
> might as well be treated in a consistent way.

Just how much context switch overhead are we talking about here?
Unless the CPU works differently than I expect, I would guess you are
saving exactly zero cycles.  What am I missing?

--Andy


>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v2:
> - Modify init_task_pasid().
>
>  arch/x86/kernel/process.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index f362ce0d5ac0..1b1492e337a6 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -121,6 +121,21 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
>                 return do_set_thread_area_64(p, ARCH_SET_FS, tls);
>  }
>
> +/* Initialize the PASID state for the forked/cloned thread. */
> +static void init_task_pasid(struct task_struct *task)
> +{
> +       struct ia32_pasid_state *ppasid;
> +
> +       /*
> +        * Initialize the PASID state so that the PASID MSR will be
> +        * initialized to its initial state (0) by XRSTORS when the task is
> +        * scheduled for the first time.
> +        */
> +       ppasid = get_xsave_addr(&task->thread.fpu.state.xsave, XFEATURE_PASID);
> +       if (ppasid)
> +               ppasid->pasid = INIT_PASID;
> +}
> +
>  int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
>                     unsigned long arg, struct task_struct *p, unsigned long tls)
>  {
> @@ -174,6 +189,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
>         task_user_gs(p) = get_user_gs(current_pt_regs());
>  #endif
>
> +       if (static_cpu_has(X86_FEATURE_ENQCMD))
> +               init_task_pasid(p);
> +
>         /* Set a new TLS for the child thread? */
>         if (clone_flags & CLONE_SETTLS)
>                 ret = set_new_tls(p, tls);
> --
> 2.19.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
