Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3262EC433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 20:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF7694058C;
	Fri,  6 May 2022 20:05:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LNwCUSUvJRPw; Fri,  6 May 2022 20:05:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C81B440558;
	Fri,  6 May 2022 20:05:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BCB3C0039;
	Fri,  6 May 2022 20:05:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7B22C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 20:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F92660D6E
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 20:05:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="zS7mT4GO";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="5wkuYkNH"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7u2rGWIwQCDe for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 20:05:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5837D60D66
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 20:05:37 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651867535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVppxWloPHGJWVXPfoL2Mp1gCDmCbq5jYvkOUctTPwE=;
 b=zS7mT4GOFbktfGjTiNzsOezexuL61fgcFzjZlZAaPH7GPyJ2Q7bJAFEDsyscoPuCfFVQXy
 MQv9fxTolSCsKtYLSyZInAmifCbsge2rcmwRurq4fs6letvqkFnJbaTyhjCsRTPV60X6uE
 rinuSxovZT2eQZmTTINCqVtTXoHEFIdOgI1zfPR/KL1VUfVwn2fIFHM766ozhigodnfH5s
 jReDujbvbA2//EkDSTXQNLuOihMxNNQNvdzlCmWip8r6V8GGcekFaYq43MM8Slzjs9F8uF
 PGtWQGOFlmpNWcrTP2AzpuqH8ZoMSNTnNEko3cwpIKeOk6ve9AbhRkGjDS/MIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651867535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVppxWloPHGJWVXPfoL2Mp1gCDmCbq5jYvkOUctTPwE=;
 b=5wkuYkNHIkwqACUXoQDb2h1xfBOD4wVbdnhxKNW06YuXNMEFHsj/QnO9X2mOg3FHRYYiy1
 G0NPRPNdhl+hS1AA==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 03/29] x86/apic/msi: Set the delivery mode
 individually for each IRQ
In-Reply-To: <20220506000008.30892-4-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-4-ricardo.neri-calderon@linux.intel.com>
Date: Fri, 06 May 2022 22:05:34 +0200
Message-ID: <8735hmh1f5.ffs@tglx>
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
> There are no restrictions in hardware to set  MSI messages with its
> own delivery mode.

"messages with its own" ? Plural/singular confusion.

> Use the mode specified in the provided IRQ hardware
> configuration data. Since most of the IRQs are configured to use the
> delivery mode of the APIC driver in use (set in all of them to
> APIC_DELIVERY_MODE_FIXED), the only functional changes are where
> IRQs are configured to use a specific delivery mode.

This does not parse. There are no functional changes due to this patch
and there is no point talking about functional changes in subsequent
patches here.

> Changing the utility function __irq_msi_compose_msg() takes care of
> implementing the change in the in the local APIC, PCI-MSI, and DMAR-MSI

in the in the

> irq_chips.
>
> The IO-APIC irq_chip configures the entries in the interrupt redirection
> table using the delivery mode specified in the corresponding MSI message.
> Since the MSI message is composed by a higher irq_chip in the hierarchy,
> it does not need to be updated.

The point is that updating __irq_msi_compose_msg() covers _all_ MSI
consumers including IO-APIC.

I had to read that changelog 3 times to make sense of it. Something like
this perhaps:

  "x86/apic/msi: Use the delivery mode from irq_cfg for message composition

   irq_cfg provides a delivery mode for each interrupt. Use it instead
   of the hardcoded APIC_DELIVERY_MODE_FIXED. This allows to compose
   messages for NMI delivery mode which is required to implement a HPET
   based NMI watchdog.

   No functional change as the default delivery mode is set to
   APIC_DELIVERY_MODE_FIXED."

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
