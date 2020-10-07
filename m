Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47A5C47095
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 16:11:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DE921707
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 16:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uue6SlPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DE921707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 97C4623120;
	Wed,  7 Oct 2020 16:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yBCYqII6UDwa; Wed,  7 Oct 2020 16:11:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 75760230FB;
	Wed,  7 Oct 2020 16:11:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65F6EC016F;
	Wed,  7 Oct 2020 16:11:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67E67C0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 16:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 44C5C23100
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 16:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3GopxXesYXgs for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 16:11:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by silver.osuosl.org (Postfix) with ESMTPS id 13086230FB
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Message-ID:From:CC:To:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
 Date:Sender:Reply-To:Content-ID:Content-Description;
 bh=ZMdK3AHaeXJWIQjVp8QzT64GGu36CKZgTfpbzrWwLxY=; b=Uue6SlPblmjJZ3dyLwQtp+wvu4
 FlG8/wt3Nm8Ph3OeQ3/eOFT9td3gqSZZqOjd7y4sc8NXpsAf0OrEw7ngzsqmde3YtlbgXfzVQJ52b
 GRgUGkqhWlm/vmNwqXAOe28C1I8rtH8nnLPonMKmQ2Av64yoR9xGo+gjylkBEMKT6I9o0xDtr3Zxp
 RoY/SAOxE4Zno+fe1zpgJaEVcBPFvtxvqNzzIILIPJshK0+fXCU5u7h+dWFKie+ydqERQ+ylfKpLf
 jeq4y39aWWvylHgvUgkvd4DKnA1KEIs8wDHn+nOCTzGiRGIyTDFnYUjK4C81TjOnCi8Vm7TklVCdd
 n0AljzQg==;
Received: from [2001:8b0:10b:1:ad95:471b:fe64:9cc3]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQC2M-0005Ea-24; Wed, 07 Oct 2020 16:11:30 +0000
Date: Wed, 07 Oct 2020 17:11:25 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <87a6wy3u6n.fsf@nanos.tec.linutronix.de>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-7-dwmw2@infradead.org>
 <87lfgj59mp.fsf@nanos.tec.linutronix.de>
 <75d79c50d586c18f0b1509423ed673670fc76431.camel@infradead.org>
 <87tuv640nw.fsf@nanos.tec.linutronix.de>
 <336029ca32524147a61b6fa1eb734debc9d51a00.camel@infradead.org>
 <87a6wy3u6n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH 07/13] irqdomain: Add max_affinity argument to
 irq_domain_alloc_descs()
To: Thomas Gleixner <tglx@linutronix.de>,x86@kernel.org
From: David Woodhouse <dwmw2@infradead.org>
Message-ID: <7FA24FCF-E197-4502-BC89-0902E4053554@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 merlin.infradead.org. See http://www.infradead.org/rpr.html
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



On 7 October 2020 16:57:36 BST, Thomas Gleixner <tglx@linutronix.de> wrote:
>On Wed, Oct 07 2020 at 15:10, David Woodhouse wrote:
>> On Wed, 2020-10-07 at 15:37 +0200, Thomas Gleixner wrote:
>>> What is preventing you to change the function signature? But handing
>>> down irqdomain here is not cutting it. The right thing to do is to
>>> replace 'struct irq_affinity_desc *affinity' with something more
>>> flexible.
>>
>> Yeah, although I do think I want to ditch this part completely, and
>> treat the "possible" mask for the domain very much more like we do
>> cpu_online_mask. In that we can allow affinities to be *requested*
>> which are outside it, and they can just never be *effective* while
>> those CPUs aren't present and reachable.
>
>Huch?
>
>> That way a lot of the nastiness about preparing an "acceptable" mask
>in
>> advance can go away.
>
>There is not lot's of nastiness.

OK, but I think we do have to cope with the fact that the limit is dynamic, and a CPU might be added which widens the mask. I think that's fundamental and not x86-specific.

>> It's *also* driven, as I noted, by the realisation that on x86, the
>> x86_non_ir_cpumask will only ever contain those CPUs which have been
>> brought online so far and meet the criteria... but won't that be true
>> on *any* system where CPU numbers are virtual and not 1:1 mapped with
>> whatever determines reachability by the IRQ domain? It isn't *such*
>an
>> x86ism, surely?
>
>Yes, but that's exactly the reason why I don't want to have whatever
>mask name you chose to be directly exposed and want it to be part of
>the
>irq domains because then you can express arbitrary per domain limits.

The x86_non_ir_mask isn't intended to be directly exposed to any generic IRQ code.

It's set up by the x86 APIC code so that those x86 IRQ domains which are affected by it, can set it with irqdomain_set_max_affinity() for the generic code to see. Without each having to create the cpumask from scratch for themselves.

> ... reading for once the kids are elsewhere...

Thanks.

>It's not rocket science to fix that as the irq remapping code already
>differentiates between the device types.

I don't actually like that very much. The IRQ remapping code could just compose the MSI messages that it desires without really having to care so much about the child device. The bit where IRQ remapping actually composes IOAPIC RTEs makes me particularly sad.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
