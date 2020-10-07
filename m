Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17506C4363D
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 12:59:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DE720789
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 12:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ygQhpekb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dz/tx+RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DE720789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E867B8725F;
	Wed,  7 Oct 2020 12:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BHFjvM3ddpVq; Wed,  7 Oct 2020 12:59:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4C7F687256;
	Wed,  7 Oct 2020 12:59:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 332BEC016F;
	Wed,  7 Oct 2020 12:59:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03401C0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 12:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F321B87244
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 12:59:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ac3SVAqJMnXp for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 12:59:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AF71B8725F
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 12:59:04 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602075541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUlXpRcdjDMd7cwhwzUEPO97AvYbTkCdBAMwSiAXy90=;
 b=ygQhpekbSZb+0bHmfd9+EwqUEQHh2ATtKLZJUgxN2aZRx+vibKErUl+OB+IclL9e2CLvJJ
 BFSj/tzbVFvPm9AW1U+wVwxqIN11eTmbpA18ZEmvaGjBUIKdyJIIFRY4G+8fgc6gjmoaYv
 JtJLCupbyM/ps8yAN3x96nYDbL6n+Ia/91H+tBfth4P9J2RQDGPPEEA2nqpoMzK+LpyEw9
 HHaz3U+2iXrpKcNnUFsjXpMgY2sfDv0eIp8y98+fqD1NDA0ABNj/n6Hmwe79tG5UdSz3UQ
 Z9XYgDNwJsD+NrGHCaYXoSMoSa0ZOcghpNg/5fFouxyYXvGsjh1KK02bJzxZrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602075541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUlXpRcdjDMd7cwhwzUEPO97AvYbTkCdBAMwSiAXy90=;
 b=dz/tx+RV0UESDPh1neqXFJC7LRS0By4Wn08o1mSZYG5vCaBGEwri/Rk7HvtoDSyFYsQIb1
 Gv4NHE4xTe+gkvCA==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 10/13] x86/irq: Limit IOAPIC and MSI domains' affinity
 without IR
In-Reply-To: <d34efce9ca5a4a9d8d8609f872143e306bf5ee98.camel@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-10-dwmw2@infradead.org>
 <87d01v58bw.fsf@nanos.tec.linutronix.de>
 <d34efce9ca5a4a9d8d8609f872143e306bf5ee98.camel@infradead.org>
Date: Wed, 07 Oct 2020 14:59:00 +0200
Message-ID: <874kn65h0r.fsf@nanos.tec.linutronix.de>
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

On Wed, Oct 07 2020 at 08:48, David Woodhouse wrote:
> On Tue, 2020-10-06 at 23:54 +0200, Thomas Gleixner wrote:
>> On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:
> This is the case I called out in the cover letter:
>
>     This patch series implements a per-domain "maximum affinity" set and
>     uses it for the non-remapped IOAPIC and MSI domains on x86. As well as
>     allowing more CPUs to be used without interrupt remapping, this also
>     fixes the case where some IOAPICs or PCI devices aren't actually in
>     scope of any active IOMMU and are operating without remapping.
>
> To fix *that* case, we really do need the whole series giving us per-
> domain restricted affinity, and to use it for those MSIs/IOAPICs that
> the IRQ remapping doesn't cover.

Which do not exist today.

>> >  	ip->irqdomain->parent = parent;
>> > +	if (parent == x86_vector_domain)
>> > +		irq_domain_set_affinity(ip->irqdomain, &x86_non_ir_cpumask);
>> 
>> OMG
>
> This IOAPIC function may or may not be behind remapping.

>> >  		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
>> > +		irq_domain_set_affinity(d, &x86_non_ir_cpumask);
>> 
>> So here it's unconditional
>
> Yes, this code is only for the non-remapped case and there's a separate
> arch_create_remap_msi_irq_domain() function a few lines further down
> which creates the IR-PCI-MSI IRQ domain. So no need for a condition
> here.
>
>> > +	if (parent == x86_vector_domain)
>> > +		irq_domain_set_affinity(d, &x86_non_ir_cpumask);
>> 
>> And here we need a condition again. Completely obvious and reviewable - NOT.
>
> And HPET may or may not be behind remapping so again needs the
> condition. I had figured that part was fairly obvious but can note it
> in the commit comment.

And all of this is completely wrong to begin with.

The information has to property of the relevant irq domains and the
hierarchy allows you nicely to retrieve it from there instead of
sprinkling this all over the place.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
