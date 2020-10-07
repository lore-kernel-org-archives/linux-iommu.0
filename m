Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDE0C4363C
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 20:53:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123E32083B
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 20:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AVOpOeOw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uUXdWeB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123E32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 80746869ED;
	Wed,  7 Oct 2020 20:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PYvGnTw-SF5q; Wed,  7 Oct 2020 20:53:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EA011862FB;
	Wed,  7 Oct 2020 20:53:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2DFDC016F;
	Wed,  7 Oct 2020 20:53:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19E95C0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 20:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0073B862FB
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 20:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P4aEpTCR3a_g for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 20:53:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E19E2862A9
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 20:53:21 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602103997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vtcDCCITF2nkZPQBpg36c9Atf4ukHGwLOFXCwRKCklg=;
 b=AVOpOeOwTC7C9yDmwrVPcB9C1aPMvhP/5PdP/qru4UkSe/Tg4pCe1Ov9uEYmh05Pn0Q0O1
 njUkv+k7Hbf3l2DqWYdLQP4gb2+2Hpo0MffsYbxrvGzTW1kryRFPNq7DuLRZs4RnfEUJAL
 Ce5FKKgPccq9WUrVPutCxus8e4M2PRseZsfw/COTCVvsKrngI7uYglaFkoxmV8aaFczyhx
 4fZzfBjBSiF/RTkCxSVFeXV9U9TAXodE1e+4d/p7A8eD8EmICmC+2FDDJBTaJwix0w0xga
 u8+31OmCuh8cj5+eKe28oQ6NiW5YG4AvVQ35FRelSHvkwColN93pjwFEjzbJRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602103997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vtcDCCITF2nkZPQBpg36c9Atf4ukHGwLOFXCwRKCklg=;
 b=uUXdWeB5iUUDQ1glmjUlfVx7FfzR42lEIjygybtN2704wXPeHGr8n5iedwh+Gwwo5mRYe/
 FbUVKijLxJK86VBA==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 07/13] irqdomain: Add max_affinity argument to
 irq_domain_alloc_descs()
In-Reply-To: <7FA24FCF-E197-4502-BC89-0902E4053554@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-7-dwmw2@infradead.org>
 <87lfgj59mp.fsf@nanos.tec.linutronix.de>
 <75d79c50d586c18f0b1509423ed673670fc76431.camel@infradead.org>
 <87tuv640nw.fsf@nanos.tec.linutronix.de>
 <336029ca32524147a61b6fa1eb734debc9d51a00.camel@infradead.org>
 <87a6wy3u6n.fsf@nanos.tec.linutronix.de>
 <7FA24FCF-E197-4502-BC89-0902E4053554@infradead.org>
Date: Wed, 07 Oct 2020 22:53:17 +0200
Message-ID: <87tuv53ghu.fsf@nanos.tec.linutronix.de>
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

On Wed, Oct 07 2020 at 17:11, David Woodhouse wrote:
> On 7 October 2020 16:57:36 BST, Thomas Gleixner <tglx@linutronix.de> wrote:
>>There is not lot's of nastiness.
>
> OK, but I think we do have to cope with the fact that the limit is
> dynamic, and a CPU might be added which widens the mask. I think
> that's fundamental and not x86-specific.

Yes, but it needs some thoughts vs. serialization against CPU hotplug.

The stability of that cpumask is architecture specific if the calling
context cannot serialize against CPU hotplug. The hot-unplug case is
less interesting because the mask does not shrink, it only get's wider.

That's why I want a callback instead of a pointer assignment and that
callback cannot return a pointer to something which can be modified
concurrently, it needs to update a caller provided mask so that the
result is at least consistent in itself.

It just occured to me that there is something which needs some more
thought vs. CPU hotunplug as well:

  Right now we just check whether there are enough vectors available on
  the remaining online CPUs so that the interrupts which have an
  effective affinity directed to the outgoing CPU can be migrated away
  (modulo the managed ones).

  That check obviously needs to take the target CPU restrictions into
  account to prevent that devices end up with no target at the end.

I bet there are some other interesting bits and pieces which need
some care...

Thanks,

        tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
