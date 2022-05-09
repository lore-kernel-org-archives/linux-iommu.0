Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC41C433F5
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 13:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E68F440915;
	Mon,  9 May 2022 13:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ok0D_BMTJb5k; Mon,  9 May 2022 13:59:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D05B14012A;
	Mon,  9 May 2022 13:59:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6F89C0032;
	Mon,  9 May 2022 13:59:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FE37C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 13:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58005409EF
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 13:59:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="vmKUlABh";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="VlTE3d1m"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ncn8yGeiZhOy for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 13:59:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6133740907
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 13:59:45 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1652104781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FDSynU42H0ANPTpjgbswkYJXVZufPOPf8nzkhHqjA9g=;
 b=vmKUlABhaBvEYz0X9LA3g5SRs3q6NK9pjEq5HDfdrkv8DNhJiu+xhSkMA6zdgQEprlDzCg
 uQWR46Hiz1n5Y0hzLAPihWXSh1PrxlSYk2hsuQTYX1OFGec+wVrZGK7qp4we6RqTX+Qakh
 BSagp92ogKOfiZ4quMyZMILbTxMIr02LfddqQvQLeX/k6xcU1kjTJJJN9L3wNd+67mHM8m
 16UrGlt5n8Yz3RlqdYJT1GHL7F4HJ3T/aHL+iOWbDqGgRE84ihDkeISbp4UTxCINqutLyz
 0i120YG1QFJBnP0HMncXXV9Af4R86Xe56Ls8BflDNQUL6C1XIO8Zsz+kiLneKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1652104781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FDSynU42H0ANPTpjgbswkYJXVZufPOPf8nzkhHqjA9g=;
 b=VlTE3d1mTqdZW3KhBs4KorVfZhqO0/Xdh68Ua4w6Qxm6hC/qsLC7dU9afDjI28gB3NaJhD
 xlvkhK2X24Pr7XCw==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 21/29] x86/nmi: Add an NMI_WATCHDOG NMI handler category
In-Reply-To: <20220506000008.30892-22-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-22-ricardo.neri-calderon@linux.intel.com>
Date: Mon, 09 May 2022 15:59:40 +0200
Message-ID: <87a6bqrelv.ffs@tglx>
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
> Add a NMI_WATCHDOG as a new category of NMI handler. This new category
> is to be used with the HPET-based hardlockup detector. This detector
> does not have a direct way of checking if the HPET timer is the source of
> the NMI. Instead, it indirectly estimates it using the time-stamp counter.
>
> Therefore, we may have false-positives in case another NMI occurs within
> the estimated time window. For this reason, we want the handler of the
> detector to be called after all the NMI_LOCAL handlers. A simple way
> of achieving this with a new NMI handler category.
>
> @@ -379,6 +385,10 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
>  	}
>  	raw_spin_unlock(&nmi_reason_lock);
>  
> +	handled = nmi_handle(NMI_WATCHDOG, regs);
> +	if (handled == NMI_HANDLED)
> +		goto out;
> +

How is this supposed to work reliably?

If perf is active and the HPET NMI and the perf NMI come in around the
same time, then nmi_handle(LOCAL) can swallow the NMI and the watchdog
won't be checked. Because MSI is strictly edge and the message is only
sent once, this can result in a stale watchdog, no?

Thanks,

        tglx



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
