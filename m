Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428B4C433EF
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 14:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9699401C9;
	Mon,  9 May 2022 14:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HtoR11WrCD_N; Mon,  9 May 2022 14:03:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A4C72401C8;
	Mon,  9 May 2022 14:03:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75C7EC0082;
	Mon,  9 May 2022 14:03:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F174C0039
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 14:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 76F9A401CA
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 14:03:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uEJ5-7s69Bmn for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 14:03:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A624401C9
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 14:03:41 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1652105019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GqbJqls16FNy0vugLmt3uGKWWGVnEjYiGmRysMH1yNs=;
 b=tvslSlziDv2t2phpzE4lNj+wrzJgX67KxhCt1FuyD1ceg6sJFkBlxDhpRcOusXD3vCH1GO
 rrwBIOqwLBE/09DZS1RWIEpRUyzO4Ylxq9wypMWnCjV9KtGMgRRbEooy5Av5VpyEFRGz5A
 ZhYHIWm3yehXFdD4iBjXd6R7PU5v8T6fgojfu0Xj9/TcO08hmV7QXMv6URnVkVzfzFLPYQ
 nCVwI6uHnWtOiluEEbY/QZ0aJobXPwV6uKRnLdA5YA8RqQpeGlC+MXbMXss77eJLujwtT7
 ZzQK/ggooLf32/huA0pdmI4dXrznLN0honUiqbA/ZsXU29EKPlPPYg33zHC8PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1652105019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GqbJqls16FNy0vugLmt3uGKWWGVnEjYiGmRysMH1yNs=;
 b=B+umBlaN/4/EfvGP0sahg2ByBcjgBKcjCmDqM6xwlN4Jeh/lEDpTcEWCOSnSQddUEZRznA
 Ju1piRkbSamhYbAA==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 22/29] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
In-Reply-To: <20220506000008.30892-23-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-23-ricardo.neri-calderon@linux.intel.com>
Date: Mon, 09 May 2022 16:03:39 +0200
Message-ID: <877d6uref8.ffs@tglx>
MIME-Version: 1.0
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, May 05 2022 at 17:00, Ricardo Neri wrote:
> +	if (is_hpet_hld_interrupt(hdata)) {
> +		/*
> +		 * Kick the timer first. If the HPET channel is periodic, it
> +		 * helps to reduce the delta between the expected TSC value and
> +		 * its actual value the next time the HPET channel fires.
> +		 */
> +		kick_timer(hdata, !(hdata->has_periodic));
> +
> +		if (cpumask_weight(hld_data->monitored_cpumask) > 1) {
> +			/*
> +			 * Since we cannot know the source of an NMI, the best
> +			 * we can do is to use a flag to indicate to all online
> +			 * CPUs that they will get an NMI and that the source of
> +			 * that NMI is the hardlockup detector. Offline CPUs
> +			 * also receive the NMI but they ignore it.
> +			 *
> +			 * Even though we are in NMI context, we have concluded
> +			 * that the NMI came from the HPET channel assigned to
> +			 * the detector, an event that is infrequent and only
> +			 * occurs in the handling CPU. There should not be races
> +			 * with other NMIs.
> +			 */
> +			cpumask_copy(hld_data->inspect_cpumask,
> +				     cpu_online_mask);
> +
> +			/* If we are here, IPI shorthands are enabled. */
> +			apic->send_IPI_allbutself(NMI_VECTOR);

So if the monitored cpumask is a subset of online CPUs, which is the
case when isolation features are enabled, then you still send NMIs to
those isolated CPUs. I'm sure the isolation folks will be enthused.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
