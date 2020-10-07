Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABABC41604
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 17:23:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8009206F7
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 17:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QIG24b30";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2cRl4Fva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8009206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3124F872DB;
	Wed,  7 Oct 2020 17:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmvhTYy3c-3n; Wed,  7 Oct 2020 17:23:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 819EF871D9;
	Wed,  7 Oct 2020 17:23:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A79CC07FF;
	Wed,  7 Oct 2020 17:23:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88A7AC0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 17:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 621E923600
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 17:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V4rA5Xnxg5QZ for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 17:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 2DC9B203B2
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 17:23:29 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602091405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=US7OlZB3Wbd40lN+C7dejW8T4VUhOzqwycXqKeH1chA=;
 b=QIG24b30dkPJU+bwwhTSk8gJh6XPe2rUyTiPSLsWd4EG0orRqjbdFDCNycbz6yThp1SxBp
 y4gl81oKkoxGH4yLQdeGTjVmS1gezWE8x+VJKwPv2F+Sgd+P8P85+zJlYkpBZqtY8vHMw2
 oSzoVBcMrLvuX0i3MVGPuEnCXPe0NK6lri3KoP9ins8/YjRYvSnxOPVVUZUn8XWQo9vXC/
 xJuGVJnvqAsGwv9IDJAT9uG68Wb+QYVQMh22rraUekqZXOgQWIB5Y5wzyVkcZyHFr9ZND2
 WH2JVcX8FSinw2ho9Nms+9MDJn8DOop3KAqKLzyrLIaQlRpC26+zuRm2WAZDLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602091405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=US7OlZB3Wbd40lN+C7dejW8T4VUhOzqwycXqKeH1chA=;
 b=2cRl4Fva7xJupCoSyVzWI4Md54ZIcgq3iaG+hUCZcRdCP5oQWa2sq+1ACWV3i/AQuyDlzD
 bf6ZhuqDBgw8PmAA==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 10/13] x86/irq: Limit IOAPIC and MSI domains' affinity
 without IR
In-Reply-To: <2f09a1f97d97e638e90c6eca3ebeebb4be852f58.camel@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-10-dwmw2@infradead.org>
 <87d01v58bw.fsf@nanos.tec.linutronix.de>
 <d34efce9ca5a4a9d8d8609f872143e306bf5ee98.camel@infradead.org>
 <874kn65h0r.fsf@nanos.tec.linutronix.de>
 <F9476D19-3D08-4CE6-A535-6C1D2E9BA88D@infradead.org>
 <87imbm3zdq.fsf@nanos.tec.linutronix.de>
 <f73340328712558c3329e11b75e32c364d01edf6.camel@infradead.org>
 <87d01u3vo6.fsf@nanos.tec.linutronix.de>
 <2f09a1f97d97e638e90c6eca3ebeebb4be852f58.camel@infradead.org>
Date: Wed, 07 Oct 2020 19:23:25 +0200
Message-ID: <874kn63q7m.fsf@nanos.tec.linutronix.de>
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

On Wed, Oct 07 2020 at 16:46, David Woodhouse wrote:
> The PCI MSI domain, HPET, and even the IOAPIC are just the things out
> there on the bus which might perform those physical address cycles. And
> yes, as you say they're just a message store sending exactly the
> message that was composed for them. They know absolutely nothing about
> what the message means and how it is composed.

That's what I said.

> It so happens that in Linux, we don't really architect the software
> like that. So each of the PCI MSI domain, HPET, and IOAPIC have their
> *own* message composer which has the same limits and composes basically
> the same messages as if it was *their* format, not dictated to them by
> the APIC upstream. And that's what we're both getting our panties in a
> knot about, I think.

Are you actually reading what I write and caring to look at the code?

PCI-MSI does not have a compose message callback in the irq chip. The
message is composed by the underlying parent domain. Same for HPET.

The only dogdy part is the IO/APIC for hysterical raisins and because
I did not come around yet to sort that out.

> It really doesn't matter that much to the underlying generic irqdomain
> support for limited affinities. Except that you want to make the
> generic code support the concept of a child domain supporting *more*
> CPUs than its parent, which really doesn't make much sense if you think
> about it.

Right. So we really want to stick the restriction into a compat-MSI
domain to make stuff match reality and to avoid banging the head against
the wall sooner than later.

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
