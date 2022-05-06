Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58E1C433FE
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 21:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4777F81396;
	Fri,  6 May 2022 21:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OExpbAoeqzJp; Fri,  6 May 2022 21:51:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3000D81389;
	Fri,  6 May 2022 21:51:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09FB6C0039;
	Fri,  6 May 2022 21:51:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A409C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B33481377
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qkSy6TunmXhA for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 21:51:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC08881373
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:51:55 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651873913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kJ3McpVzRFsgMBX23wgT/+qwHu2rZPiW0v6oIUJCIkI=;
 b=igj0qkwuwc7TJty88qJFZzgeFNtRFh7UFPJIoYtA35jxy2m3y6o5O4BdduJ2eTQP9yoEOj
 Y/Pma7uZ5nWvIQhbGPHLJmY6SG3i1CJVChRqzHb1xg1wCqo9z7wxEHAXtt5f9+bWp12aKl
 yxCDDHDVcTytIFMWLuivfqlaAY9rBazDQQyIjF1A+y1F0wqODasPHnEJyRNpLJt15J6YsH
 E5X1+fUKoagpdADMaiiKzhZbUA2CMwr6sDFvgkwLGqIpuqPfaj+XgnRcnoX0GKhhe7+t9y
 p/OQVpvdQapJpV5hYP5MRwR5/f2imVDr8Suxn6wvt2CDlZBIK6rpU9RNXp1y6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651873913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kJ3McpVzRFsgMBX23wgT/+qwHu2rZPiW0v6oIUJCIkI=;
 b=JhebiFX5xqgDI1pfgNQ3AdRq6c3Eu2eESoBA4srTY5Ncp8q55tWwCzdaaNdIoRN0NdxHUo
 pfYq18JFAjczX9Dg==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 15/29] x86/hpet: Add helper function
 hpet_set_comparator_periodic()
In-Reply-To: <87mtfufifa.ffs@tglx>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
 <87mtfufifa.ffs@tglx>
Date: Fri, 06 May 2022 23:51:52 +0200
Message-ID: <87ilqifhxj.ffs@tglx>
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

On Fri, May 06 2022 at 23:41, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
>> Programming an HPET channel as periodic requires setting the
>> HPET_TN_SETVAL bit in the channel configuration. Plus, the comparator
>> register must be written twice (once for the comparator value and once for
>> the periodic value). Since this programming might be needed in several
>> places (e.g., the HPET clocksource and the HPET-based hardlockup detector),
>> add a helper function for this purpose.
>>
>> A helper function hpet_set_comparator_oneshot() could also be implemented.
>> However, such function would only program the comparator register and the
>> function would be quite small. Hence, it is better to not bloat the code
>> with such an obvious function.
>
> This word salad above does not provide a single reason why the periodic
> programming function is required and better suited for the NMI watchdog
> case and then goes on and blurbs about why a function which is not
> required is not implemented. The argument about not bloating the code
> with an "obvious???" function which is quite small is slightly beyond my
> comprehension level.

What's even more uncomprehensible is that the patch which actually sets
up that NMI watchdog cruft has:

> +       if (hc->boot_cfg & HPET_TN_PERIODIC_CAP)
> +               hld_data->has_periodic = true;

So how the heck does that work with a HPET which does not support
periodic mode?

That watchdog muck will still happily invoke that set periodic function
in the hope that it works by chance?

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
