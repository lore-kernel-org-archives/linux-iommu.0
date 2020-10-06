Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3268C4363D
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 21:06:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36538206F7
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 21:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BumlTzJo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q0LCsvJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36538206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A956A858B5;
	Tue,  6 Oct 2020 21:06:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CAXZqCkdo85m; Tue,  6 Oct 2020 21:06:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EF16A856E4;
	Tue,  6 Oct 2020 21:06:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF5C0C07FF;
	Tue,  6 Oct 2020 21:06:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A65D2C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8B21B20453
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:06:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ewzUOTKYeQM8 for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 21:06:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 8666E2041D
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:06:26 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602018384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJsRLR/GkQ9y55O/CRKVyWEVz7Xo2QXtu4Qp1z7vboQ=;
 b=BumlTzJoaEazB1qg0hEMqrqLjk17pzwuyeAZCv8B4WQH/n5eEctgvA3WOsEaB+xaeEj+90
 lQh/ds6d9BQaeYTOcnM0nd0ikZC+V/UWeMf6jAVNbdNT3av9BL7qrNoCMvqbdziHzy2m0z
 PN0XKqhnVwosi+iqtZ68xm76qYs0EvC29/02kJB5g/CQUvFBEl36w3PCVACLkAm9573ZUL
 19qaTmLc/HKZ/RXQvhNYqUBF2jDQzytl3MhfR3nOPuqsge//c8VdtQUrnQT1N/9HG56kcC
 AXTqAmFjMJWgHN7ExlPSLGXBa2TdzK079Htko7R+C/ilxyUS0EXVvV1k+o4xDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602018384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJsRLR/GkQ9y55O/CRKVyWEVz7Xo2QXtu4Qp1z7vboQ=;
 b=q0LCsvJPrT9MflDeA3d4nXkFpjov+sYU6mnQ6FkKbfUFdxZE9G83qKg9++8n7MHXDg04nh
 3YNP1h4k2nv0+eDg==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 06/13] genirq: Add default_affinity argument to
 __irq_alloc_descs()
In-Reply-To: <20201005152856.974112-6-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-6-dwmw2@infradead.org>
Date: Tue, 06 Oct 2020 23:06:23 +0200
Message-ID: <87o8lf5ak0.fsf@nanos.tec.linutronix.de>
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
> From: David Woodhouse <dwmw@amazon.co.uk>
> It already takes an array of affinities for each individual irq being
> allocated but that's awkward to allocate and populate in the case
> where they're all the same and inherited from the irqdomain, so pass
> the default in separately as a simple cpumask.

So we need another cpumask argument exposed to the world just because
it's so hard to extend struct irq_affinity_desc so it supports that use
case as well. It's not written in stone that this struct can only
support arrays.

> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  include/linux/irq.h    | 10 ++++++----
>  kernel/irq/devres.c    |  8 ++++++--
>  kernel/irq/irqdesc.c   | 10 ++++++++--
>  kernel/irq/irqdomain.c |  6 +++---

git grep __irq_alloc_descs() might help you to find _all_ instances ...

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
