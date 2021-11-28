Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D435C433EF
	for <iommu@archiver.kernel.org>; Sun, 28 Nov 2021 20:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C7AC60689;
	Sun, 28 Nov 2021 20:27:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RuIOfkQbeJgF; Sun, 28 Nov 2021 20:27:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFEFB60658;
	Sun, 28 Nov 2021 20:27:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A064C0012;
	Sun, 28 Nov 2021 20:27:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C16EC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 20:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 055B082CCA
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 20:27:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="oPRc3eq0";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="qYh8H7dU"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xz5oZ8G1RQEj for <iommu@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 20:27:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6105B82C84
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 20:27:24 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638131240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34cEonPYoHn2wOD4iyX9ID5tmiVh/WyoVyXwqDXryy0=;
 b=oPRc3eq0k+Tw8NUVD33WjmT1yTwdDLqkvp0k8L0fhSlgI1D7uqHcq0GMPi3xW2KkValqF4
 f5+puEWtkAmZQdWC59ouxHon7GH94O2JlbvCxRQE9FC0LWhmJpHAbFNeQ3DsfMLG+EixpT
 hZSGFuc3YgBIjuAqAs5dcF3jT9Jqg1fD8TVHhI2W7B6NwkElYoFJ/x3rfoBW9TCXYktSB/
 7JCQiSAnY6v16Mi6SX4hF9iVphpSdW7rzPWmj9h3jzBE1irCfw+8iZ1z8Ba0yvELN0tdUE
 jvbgs+JgRTKN87ldu+pCs8ssio7C6Aj2xXaDx576hfi5qFT2JGCWpokNJEKoGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638131240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34cEonPYoHn2wOD4iyX9ID5tmiVh/WyoVyXwqDXryy0=;
 b=qYh8H7dUzo5GOUV8STynfR6skQ9RyXxzWobJRhhOvRzBoMIDa6HMBwwWiZzqU46S2s7nZL
 1Dk2qEe1TKRHefAQ==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 00/37] genirq/msi, PCI/MSI: Spring cleaning - Part 2
In-Reply-To: <20211128003905.GU4670@nvidia.com>
References: <20211126224100.303046749@linutronix.de>
 <20211128003905.GU4670@nvidia.com>
Date: Sun, 28 Nov 2021 21:27:19 +0100
Message-ID: <87y258do0o.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
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

On Sat, Nov 27 2021 at 20:39, Jason Gunthorpe wrote:
> On Sat, Nov 27, 2021 at 02:21:17AM +0100, Thomas Gleixner wrote:
>>    4) Provide a function to retrieve the Linux interrupt number for a given
>>       MSI index similar to pci_irq_vector() and cleanup all open coded
>>       variants.
>
> The msi_get_virq() sure does make a big difference.. Though it does
> highlight there is some asymmetry with how platform and PCI works here
> where PCI fills some 'struct msix_entry *'. Many drivers would be
> quite happy to just call msi_get_virq() and avoid the extra memory, so
> I think the msi_get_virq() version is good.

struct msix_entry should just go away.

90+% of the use cases fill it with a linear index range 0...N and then
use the virq entry for request_irq(). So they can just use
pci_alloc_irs_vectors_affinity() and retrieve the interrupt number via
pci_irq_vector().

The few drivers which actually use it to allocate a sparse populated MSI
index, e.g. 0, 12, 14 can be converted over to alloc vector 0 and then
use the dynamic extenstion for the rest.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
