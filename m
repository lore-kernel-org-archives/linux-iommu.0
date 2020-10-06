Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51014C4363D
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 21:32:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C731B206BE
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 21:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2+AYqpz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZMJwnHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C731B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 529FF867E8;
	Tue,  6 Oct 2020 21:32:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3cLe-m4-81oW; Tue,  6 Oct 2020 21:32:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 58D3E867E0;
	Tue,  6 Oct 2020 21:32:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D29BC016F;
	Tue,  6 Oct 2020 21:32:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C594C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0A10A2155D
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8y5mJQAxTV-s for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 21:32:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 416682153E
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:32:07 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602019925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RAllStXUlg+AiDlHucG15WJGldjEYpu7ef3AjJW7I7g=;
 b=P2+AYqpzchLK62fKUQ80gjgTsbtfUS4zuhN8OtrqKS5LsYSssUAEmPRzflu1xgrPE0dMdJ
 ZV/aISe4wuEFK1dQiRQEq7SFXLY6uiBTBV7y48PFmmIPclv/Y/wghICFjVAJ10uwyZHUWM
 HwYQkGvdQioNgj6GeOvK0zp2lqtL/e/cTxOqZZKCi94GRGwItmCcau6a4mmrLNBvgW2Sp9
 kN8mcDb7FUw/cHr0jswrovOlND7c2oyxePD6DklpaY43FYWTqbMl05tAs5+AtTcf+mTtGH
 lJSvJB4TP2xiIGL+U7pmP5Y+e6KxAAILWh/wZiHSm3vGZK42NJBfKtw2uk48HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602019925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RAllStXUlg+AiDlHucG15WJGldjEYpu7ef3AjJW7I7g=;
 b=cZMJwnHd6tWgvwvZzxj4qBKC3MBLENnkZFUQuzgd9e7eFik0v56WN+Pdg8+u/ua4Q4EE2N
 Ewghf2L76ZjpveBQ==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 08/13] genirq: Add irq_domain_set_affinity()
In-Reply-To: <20201005152856.974112-8-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-8-dwmw2@infradead.org>
Date: Tue, 06 Oct 2020 23:32:05 +0200
Message-ID: <87imbn59d6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 iommu <iommu@lists.linux-foundation.org>, linux-hyperv@vger.kernel.org,
 kvm <kvm@vger.kernel.org>
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

On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:
> +/**
> + * irq_domain_set_affinity - Set maximum CPU affinity for domain
> + * @parent:	Domain to set affinity for
> + * @affinity:	Pointer to cpumask, consumed by domain
> + *
> + * Sets the maximal set of CPUs to which interrupts in this domain may
> + * be delivered. Must only be called after creation, before any interrupts
> + * have been in the domain.
> + *
> + * This function retains a pointer to the cpumask which is passed in.
> + */
> +int irq_domain_set_affinity(struct irq_domain *domain,
> +			    const struct cpumask *affinity)
> +{
> +	if (cpumask_empty(affinity))
> +		return -EINVAL;
> +	domain->max_affinity = affinity;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(irq_domain_set_affinity);

What the heck? Why does this need a setter function which is exported?
So that random driver writers can fiddle with it?

The affinity mask restriction of an irq domain is already known when the
domain is created.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
