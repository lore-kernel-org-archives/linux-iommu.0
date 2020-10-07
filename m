Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCE8C47095
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 13:37:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409C1208C7
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 13:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HW5HXQV3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MKTe4LJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409C1208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 66CD6862BC;
	Wed,  7 Oct 2020 13:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XVOwfVqm61P4; Wed,  7 Oct 2020 13:37:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C5A3286274;
	Wed,  7 Oct 2020 13:37:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FFDEC07FF;
	Wed,  7 Oct 2020 13:37:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74D8CC0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 13:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 623ED20002
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 13:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f6uBNVX4fBsH for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 13:37:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 7FF1C1FCA0
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 13:37:42 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602077860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZUt/fRAzcQQKkeUzrcwPraubNG6JI07bzPBHwzVZIgQ=;
 b=HW5HXQV3gvvUAmzOgKsr4dezYeSmHLOR8iy6zUzQaUcHLGktBjwmlNLTw/6QrvMrORy72D
 Rucl3nOYVdeBElsLHa07uFtvk/M+uU5i8c3Ks0JCzdwn93FAKBjEhG1ob9iBSuyinFjI9z
 kTVvQvyEk9jgRH8QDHbAKc05Hn1/GfoPr0j4rz6XWX3kajMnUvWYZnXNN3DCdcTqMaB1Rn
 GbQ1Ij2qXUU7/JDFz1WKh9TJmczHRhynpKVFsHA+TXbRnxxZRpLZCpXplcDbmmlhwqwdGr
 s7/6ezwliI21q0gPxk592Y0jsMwQhZpYLSMLG3DET8eMJkeSbSkmgw6Zi2l+fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602077860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZUt/fRAzcQQKkeUzrcwPraubNG6JI07bzPBHwzVZIgQ=;
 b=MKTe4LJhkKRejWCeZylCr0cq7MMOKpAD+4goDzh+miVH4LV7POjXNqtUtN6NikIW1rl+sW
 p69rlmKsnBdzuYCQ==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 07/13] irqdomain: Add max_affinity argument to
 irq_domain_alloc_descs()
In-Reply-To: <75d79c50d586c18f0b1509423ed673670fc76431.camel@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-7-dwmw2@infradead.org>
 <87lfgj59mp.fsf@nanos.tec.linutronix.de>
 <75d79c50d586c18f0b1509423ed673670fc76431.camel@infradead.org>
Date: Wed, 07 Oct 2020 15:37:39 +0200
Message-ID: <87tuv640nw.fsf@nanos.tec.linutronix.de>
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

On Wed, Oct 07 2020 at 08:19, David Woodhouse wrote:
> On Tue, 2020-10-06 at 23:26 +0200, Thomas Gleixner wrote:
>> On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:
>> > From: David Woodhouse <dwmw@amazon.co.uk>
>> > 
>> > This is the maximum possible set of CPUs which can be used. Use it
>> > to calculate the default affinity requested from __irq_alloc_descs()
>> > by first attempting to find the intersection with irq_default_affinity,
>> > or falling back to using just the max_affinity if the intersection
>> > would be empty.
>> 
>> And why do we need that as yet another argument?
>> 
>> This is an optional property of the irq domain, really and no caller has
>> any business with that. 
>
> Because irq_domain_alloc_descs() doesn't actually *take* the domain as
> an argument. It's more of an internal function, which is only non-
> static because it's used from kernel/irq/ipi.c too for some reason. If
> we convert the IPI code to just call __irq_alloc_descs() directly,
> perhaps that we can actually make irq_domain_alloc_decs() static.

What is preventing you to change the function signature? But handing
down irqdomain here is not cutting it. The right thing to do is to
replace 'struct irq_affinity_desc *affinity' with something more
flexible.

>> >  int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
>> > -			   int node, const struct irq_affinity_desc *affinity)
>> > +			   int node, const struct irq_affinity_desc *affinity,
>> > +			   const struct cpumask *max_affinity)
>> >  {
>> > +	cpumask_var_t default_affinity;
>> >  	unsigned int hint;
>> > +	int i;
>> > +
>> > +	/* Check requested per-IRQ affinities are in the possible range */
>> > +	if (affinity && max_affinity) {
>> > +		for (i = 0; i < cnt; i++)
>> > +			if (!cpumask_subset(&affinity[i].mask, max_affinity))
>> > +				return -EINVAL;
>> 
>> https://lore.kernel.org/r/alpine.DEB.2.20.1701171956290.3645@nanos
>> 
>> What is preventing the affinity spreading code from spreading the masks
>> out to unusable CPUs? The changelog is silent about that part.
>
> I'm coming to the conclusion that we should allow unusable CPUs to be
> specified at this point, just as we do offline CPUs. That's largely
> driven by the realisation that our x86_non_ir_cpumask is only going to
> contain online CPUs anyway, and hotplugged CPUs only get added to it as
> they are brought online.

Can you please stop looking at this from a x86 only perspective. It's
largely irrelevant what particular needs x86 or virt or whatever has.

Fact is, that if there are CPUs which cannot be targeted by device
interrupts then the multiqueue affinity mechanism has to be fixed to
handle this. Right now it's just broken.

Passing yet more cpumasks and random pointers around through device
drivers and whatever is just not going to happen. Neither are we going
to have

        arch_can_be_used_for_device_interrupts_mask

or whatever you come up with and claim it to be 'generic'.

The whole affinity control mechanism needs to be refactored from ground
up and the information about CPUs which can be targeted has to be
retrievable through the irqdomain hierarchy.

Anything else is just tinkering and I have zero interest in mopping up
after you.

It's pretty obvious that the irq domains are the right place to store
that information:

const struct cpumask *irqdomain_get_possible_affinity(struct irq_domain *d)
{
        while (d) {
        	if (d->get_possible_affinity)
                	return d->get_possible_affinity(d);
                d = d->parent;
        }
        return cpu_possible_mask;
}

So if you look at X86 then you have either:

   [VECTOR] ----------------- [IO/APIC]
                          |-- [MSI]
                          |-- [WHATEVER]

or

   [VECTOR] ---[REMAP]------- [IO/APIC]
             |            |-- [MSI]
             |----------------[WHATEVER]

So if REMAP allows cpu_possible_mask and VECTOR some restricted subset
then irqdomain_get_possible_affinity() will return the correct result
independent whether remapping is enabled or not.

This allows to use that for other things like per node restrictions or
whatever people come up with, without sprinkling more insanities through
the tree.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
