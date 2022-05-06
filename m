Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B44C433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 21:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 063EF409FB;
	Fri,  6 May 2022 21:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QhBoQ_xwRar7; Fri,  6 May 2022 21:23:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8F57F409FE;
	Fri,  6 May 2022 21:23:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 604EDC0039;
	Fri,  6 May 2022 21:23:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0DB5C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 890C682423
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:23:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="1gitIq8F";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="kbgZs5Io"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oc32tbAQ6t6q for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 21:23:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCFAB823E3
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:23:26 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651872204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Qt7CUp/pjOXetxeeCEQTHQJVA1rcx9ZBnwtcdpqF+0=;
 b=1gitIq8FJN+a0xsKA2F9S/IkXhuehmIu/V1V6fDWUg4SgYJ6GNR70nqfi6IKrkT0vv4Yae
 ZCuqm/hYF1OxK74tQBPRc0TS/NELz45bgd73c1EXtOB7GCDM8SKQ7JiVY/gGbu0/kBholF
 JCPN0OvDqROnL3mfI+OVoJn1DJwxkm1w/Y3xe4jMDPcQgffkYct2evhH90bBtQYroQhHVQ
 9i8FfLmF9G8vaSrdByk6xcyydCReNyG8txnHNUi2JYzjXsYbUvxSIRC6g/Zy35cqfeWuEr
 XMxMC6wWl98ijxGTdbdsJG7bZbtwAoS6+gKor1KCGSBIS1sDipmE+IsdzaWeTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651872204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Qt7CUp/pjOXetxeeCEQTHQJVA1rcx9ZBnwtcdpqF+0=;
 b=kbgZs5IojxdNYid2PCX/up8UYQ0YquDeCHiNJom3jcEaJQf4cp68zTUaibdsa1SEQ7jM4L
 U3OxdSYz2NZABvDA==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 10/29] iommu/vt-d: Implement minor tweaks for NMI irqs
In-Reply-To: <20220506000008.30892-11-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-11-ricardo.neri-calderon@linux.intel.com>
Date: Fri, 06 May 2022 23:23:23 +0200
Message-ID: <87wneyfj90.ffs@tglx>
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

On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> The Intel IOMMU interrupt remapping driver already programs correctly the
> delivery mode of individual irqs as per their irq_data. Improve handling
> of NMIs. Allow only one irq per NMI. Also, it is not necessary to cleanup
> irq vectors after updating affinity.

Structuring a changelog in paragraphs might make it readable. New lines
exist for a reason.

> NMIs do not have associated vectors.

Again. NMI has an vector associated, but it is not subject to dynamic
vector management.

> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index fb2d71bea98d..791a9331e257 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1198,8 +1198,12 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  	 * After this point, all the interrupts will start arriving
>  	 * at the new destination. So, time to cleanup the previous
>  	 * vector allocation.
> +	 *
> +	 * Do it only for non-NMI irqs. NMIs don't have associated
> +	 * vectors.

See above.

>  	 */
> -	send_cleanup_vector(cfg);
> +	if (cfg->delivery_mode != APIC_DELIVERY_MODE_NMI)
> +		send_cleanup_vector(cfg);

So this needs to be replicated for all invocations of
send_cleanup_vector(), right? Why can't you put it into that function?
  
>  	return IRQ_SET_MASK_OK_DONE;
>  }
> @@ -1352,6 +1356,9 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
>  	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
>  		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
>  
> +	if ((info->flags & X86_IRQ_ALLOC_AS_NMI) && nr_irqs != 1)
> +		return -EINVAL;

This cannot be reached when the vector allocation domain already
rejected it, but copy & pasta is wonderful and increases the line count.

Thanks,

        tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
