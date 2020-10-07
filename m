Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40BC41604
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 15:25:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E17921548
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 15:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hG/eyD5c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ph0vAVpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E17921548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0433987285;
	Wed,  7 Oct 2020 15:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2HoeiuNnCN7C; Wed,  7 Oct 2020 15:25:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F3348727C;
	Wed,  7 Oct 2020 15:25:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F895C07FF;
	Wed,  7 Oct 2020 15:25:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB3D3C0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 15:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 911B487281
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 15:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FkffbHwk8Kuz for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 15:25:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 505598727C
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 15:25:33 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602084330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kiCPfqTAmORWmLAjTEc4XeS46cNwMzONgAXKlkWAebM=;
 b=hG/eyD5caDYgfDBbiW+TGbLPUOv41+4TrMG2q+2yP08Yh5Cnzbx3evZyfO3P84Hd1Qx0Ki
 lJiYwsDb03QKwNnEp4CqYqdTU3Cor73ZS6Driz/6psgwDJupDW6iDPWBYiLXQqdCmFtPol
 D9dvR5nc1QseyT5pX1+jdKFZd0Xjkr0nSkcxokUlQOZKl/ufDaPY6HQf4WV38w88RN01P+
 FI/lJMkiE1ym5md4HGRvmA5nwg7/igZEckY5tJHhIrEvQcdDDUJaxG4TMtzrptcWoMmmpb
 58K+0vUnX+Syn0Di0rMo+6zLD3J1lHqJcxaEltW+6tvNvhKAMomwzhzGrH7QhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602084330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kiCPfqTAmORWmLAjTEc4XeS46cNwMzONgAXKlkWAebM=;
 b=ph0vAVplpydDLLyAPvUsYQZ8RAAKjLxuve5muHLeg/9YxcppWuYI6fMzantfArp5NcG3GG
 KWgqAElZvf6AXlDg==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 10/13] x86/irq: Limit IOAPIC and MSI domains' affinity
 without IR
In-Reply-To: <f73340328712558c3329e11b75e32c364d01edf6.camel@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-10-dwmw2@infradead.org>
 <87d01v58bw.fsf@nanos.tec.linutronix.de>
 <d34efce9ca5a4a9d8d8609f872143e306bf5ee98.camel@infradead.org>
 <874kn65h0r.fsf@nanos.tec.linutronix.de>
 <F9476D19-3D08-4CE6-A535-6C1D2E9BA88D@infradead.org>
 <87imbm3zdq.fsf@nanos.tec.linutronix.de>
 <f73340328712558c3329e11b75e32c364d01edf6.camel@infradead.org>
Date: Wed, 07 Oct 2020 17:25:29 +0200
Message-ID: <87d01u3vo6.fsf@nanos.tec.linutronix.de>
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

On Wed, Oct 07 2020 at 16:05, David Woodhouse wrote:
> On Wed, 2020-10-07 at 16:05 +0200, Thomas Gleixner wrote:
>> The top most MSI irq chip does not even have a compose function, neither
>> for the remap nor for the vector case. The composition is done by the
>> parent domain from the data which the parent domain constructed. Same
>> for the IO/APIC just less clearly separated.
>> 
>> The top most chip just takes what the underlying domain constructed and
>> writes it to the message store, because that's what the top most chip
>> controls. It does not control the content.
>
> Sure, whatever. The way we arrange the IRQ domain hierarchy in x86
> Linux doesn't really match my understanding of the real hardware, or
> how qemu emulates it either. But it is at least internally self-
> consistent, and in this model it probably does make some sense to claim
> the 8-bit limit on x86_vector_domain itself, and *remove* that limit in
> the remapping irqdomain.

It's clearly how the hardware works. MSI has a message store of some
sorts and if the entry is enabled then the MSI chip (in PCI or
elsewhere) will send exactly the message which is in that message
store. It knows absolutely nothing about what the message means and how
it is composed. The only things which MSI knows about is whether the
message address is 64bit wide or not and whether the entries are
maskable or not and how many entries it can store.

Software allocates a message target at the underlying irq domain (vector
or remap) and that underlying irq domain defines the properties.

If qemu emulates it differently then it's qemu's problem, but that does
not make it in anyway something which influences the irq domain
abstractions which are correctly modeled after how the hardware works.

> Not really the important part to deal with right now, either way.

Oh yes it is. We define that upfront and not after the fact.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
