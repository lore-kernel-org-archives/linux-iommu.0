Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721E0C41604
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 13:08:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A816620870
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 13:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pUn1H7J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A816620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 30EC687257;
	Wed,  7 Oct 2020 13:08:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vVU1JboUPsed; Wed,  7 Oct 2020 13:08:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9654587244;
	Wed,  7 Oct 2020 13:08:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CABBC016F;
	Wed,  7 Oct 2020 13:08:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08D11C0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 13:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EF9DA860F6
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 13:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CISq_QNvhgEf for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 13:08:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 08780860BE
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 13:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Message-ID:From:CC:To:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
 Date:Sender:Reply-To:Content-ID:Content-Description;
 bh=MLWrFRdqNIgAposi7IkoIjLJgrHHB/ryW+Kmcpuy9RI=; b=pUn1H7J5DnVS5L3J2RCT4AwktL
 JhUzwP+tkrOwapHPyY1bbwLjCQxUMCknVqcoCG3BUEhyld71eor0C0z9DIaM92K/XszWih/M1aCn0
 +aFdgQ4vNGtkgzitqN/4OHMO3Vh6SCfcQVkonMRoOE+tllBHP/8Qp+i/8WpAm7DO0aJTTKO32utny
 D6JcPzjPGb+1BkS6Y3+F1iFQR5hogp7TEGIUDzm/zE2hKO3uRptfdNBBuBKcwMZIC7y+QEXCUYn71
 84ycEZtFnlMStpRztl3dKDKwSXXDW3LtygIW5vJgpfIH08PUh+w9BkF6FGRsd/E6XCg1wvtaSvmnX
 D4/fqEsQ==;
Received: from [2a01:4c8:1095:4638:609d:719a:b13b:be97]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQ9Ar-0005yl-0v; Wed, 07 Oct 2020 13:08:05 +0000
Date: Wed, 07 Oct 2020 14:08:01 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <874kn65h0r.fsf@nanos.tec.linutronix.de>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-10-dwmw2@infradead.org>
 <87d01v58bw.fsf@nanos.tec.linutronix.de>
 <d34efce9ca5a4a9d8d8609f872143e306bf5ee98.camel@infradead.org>
 <874kn65h0r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH 10/13] x86/irq: Limit IOAPIC and MSI domains' affinity
 without IR
To: Thomas Gleixner <tglx@linutronix.de>,x86@kernel.org
From: David Woodhouse <dwmw2@infradead.org>
Message-ID: <F9476D19-3D08-4CE6-A535-6C1D2E9BA88D@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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



On 7 October 2020 13:59:00 BST, Thomas Gleixner <tglx@linutronix.de> wrote:
>On Wed, Oct 07 2020 at 08:48, David Woodhouse wrote:
>> On Tue, 2020-10-06 at 23:54 +0200, Thomas Gleixner wrote:
>>> On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:
>> This is the case I called out in the cover letter:
>>
>>     This patch series implements a per-domain "maximum affinity" set
>and
>>     uses it for the non-remapped IOAPIC and MSI domains on x86. As
>well as
>>     allowing more CPUs to be used without interrupt remapping, this
>also
>>     fixes the case where some IOAPICs or PCI devices aren't actually
>in
>>     scope of any active IOMMU and are operating without remapping.
>>
>> To fix *that* case, we really do need the whole series giving us per-
>> domain restricted affinity, and to use it for those MSIs/IOAPICs that
>> the IRQ remapping doesn't cover.
>
>Which do not exist today.

Sure. But at patch 10/13 into this particular patch series, it *does* exist.

(Ignoring, for the moment, that I'm about to rewrite half the preceding patches to take a different approach)


>>> >  	ip->irqdomain->parent = parent;
>>> > +	if (parent == x86_vector_domain)
>>> > +		irq_domain_set_affinity(ip->irqdomain, &x86_non_ir_cpumask);
>>> 
>>> OMG
>>
>> This IOAPIC function may or may not be behind remapping.
>
>>> >  		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
>>> > +		irq_domain_set_affinity(d, &x86_non_ir_cpumask);
>>> 
>>> So here it's unconditional
>>
>> Yes, this code is only for the non-remapped case and there's a
>separate
>> arch_create_remap_msi_irq_domain() function a few lines further down
>> which creates the IR-PCI-MSI IRQ domain. So no need for a condition
>> here.
>>
>>> > +	if (parent == x86_vector_domain)
>>> > +		irq_domain_set_affinity(d, &x86_non_ir_cpumask);
>>> 
>>> And here we need a condition again. Completely obvious and
>reviewable - NOT.
>>
>> And HPET may or may not be behind remapping so again needs the
>> condition. I had figured that part was fairly obvious but can note it
>> in the commit comment.
>
>And all of this is completely wrong to begin with.
>
>The information has to property of the relevant irq domains and the
>hierarchy allows you nicely to retrieve it from there instead of
>sprinkling this all over the place.

No. This is not a property of the parent domain per se. Especially if you're thinking that we could inherit the affinity mask from the parent, then twice no.

This is a property of the MSI domain itself, and how many bits of destination ID the hardware at *this* level can interpret and pass on to the parent domain.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
