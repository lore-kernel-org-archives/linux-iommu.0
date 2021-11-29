Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25BEC433F5
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 12:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D6969403DD;
	Mon, 29 Nov 2021 12:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XiwwtOdldUyo; Mon, 29 Nov 2021 12:52:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7B8A040371;
	Mon, 29 Nov 2021 12:52:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47063C001C;
	Mon, 29 Nov 2021 12:52:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C720C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 12:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 272A381770
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 12:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="HplVWLUy";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="/vtVlvS+"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ELuSoZNW2Wv8 for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 12:52:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA6AD80C03
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 12:52:50 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638190367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4YfGqtKfqcg/VBb4scc+UNPvXNHJqUnbrO9jfKPdvNc=;
 b=HplVWLUyXX2hGBuDuAzepO9k9vKo4+aigansIMG5A6PgvComp9g/A8szrWNGO+DISdY1cO
 HzmwbYFzpO7Q/2IoKG933FYvlI+iakLvkkI3MW676OVlnc7A8MPybqGncMhSM56B+JB5UN
 PWbU+6wCNcKBNO1A+j34akq/xZ3+3aX1ItXbhwlzVpIdbOCrNj9jP2pah7Z/DMh8iXi0vY
 WQ4WxZl0EvS+kKrLf6K04nLtKxRo+NFQ3CXHYtdg12/OZVLnw9TMiwzne+FekVyS17Msmp
 St+PtqpCeGz+AJ4jXwZIiSDeE/g+SbXuSG9NDgfDEF4UJQ+4uLGw3cZ+2GnJcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638190367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4YfGqtKfqcg/VBb4scc+UNPvXNHJqUnbrO9jfKPdvNc=;
 b=/vtVlvS+jCeXqOvFdJKQpUuqX073/P52p4KqQKu8Yr9vhveVqL5kazEV6dmh03ToVmk41R
 neyuByPAuatkkHDQ==
To: Will Deacon <will@kernel.org>
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
In-Reply-To: <20211129105506.GA22761@willie-the-truck>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
Date: Mon, 29 Nov 2021 13:52:46 +0100
Message-ID: <87lf17dsyp.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Ashok Raj <ashok.raj@intel.com>, Marc Zygnier <maz@kernel.org>, x86@kernel.org,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, Megha Dey <megha.dey@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
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

Will,

On Mon, Nov 29 2021 at 10:55, Will Deacon wrote:
> On Sat, Nov 27, 2021 at 02:20:59AM +0100, Thomas Gleixner wrote:
>> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
>> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>
> Prviously, if retrieval of the MSI failed then we'd fall back to wired
> interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
> we make the assignments to smmu->*irq here conditional on the MSI being
> valid, please?

So the wired irq number is in ->irq already and MSI does an override
if available. Not really obvious...

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
