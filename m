Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AE7C433EF
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 12:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97C9C402DF;
	Mon, 29 Nov 2021 12:58:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eKvJ61kEchxC; Mon, 29 Nov 2021 12:58:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C86440295;
	Mon, 29 Nov 2021 12:58:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F4BAC001C;
	Mon, 29 Nov 2021 12:58:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88473C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 12:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 635BF402DF
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 12:58:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KCH7pw28OFyK for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 12:58:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B80B340295
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 12:58:49 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638190727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3FciFdKO2khQ7f3Cmj7EZjTaeR+RNoaHikUdH9wKA4=;
 b=n/cJ6xXeDR0gfPdjD4YQQT6Q6+jc5VrNxxb/wMO1CCL68nw2ivWvCi9Oc5jRQP1vmykI2L
 wpM4ivbSXnNWtwWg2OMXcPoZHzFO/AGGAjG93eYJmpri4EZB5NYcUKVTUA6tLcXbKQxiVf
 PgtATQCKLuF+FaTJEgRWVfVNRjp4fW0VBSqZRDYs1JIvyPxR2VSAtYwkT2Ktl7we2swKMa
 g5AVSA4LFn5citpFX56X18aS9mj7c9i9SbNhRQePzqQeBXdCP73LY2CoabUjdXkXf4G7SV
 XE6SiQ1P1OMABrt6rekZNAKLNNTpwhPlI8WmKH8Vf+HIO7MpEkvLG1D22S5tnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638190727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3FciFdKO2khQ7f3Cmj7EZjTaeR+RNoaHikUdH9wKA4=;
 b=uzqwAVQ3mlWAmoUWkKfqvuEYkEasky/aV9Ezf1NXjZIqVG+VhtAHegMwxJu+JHXrQe2PJm
 sxMNfZT3wK1xjhCg==
To: Will Deacon <will@kernel.org>
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
In-Reply-To: <87lf17dsyp.ffs@tglx>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck> <87lf17dsyp.ffs@tglx>
Date: Mon, 29 Nov 2021 13:58:46 +0100
Message-ID: <87ilwbdsop.ffs@tglx>
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

On Mon, Nov 29 2021 at 13:52, Thomas Gleixner wrote:
> On Mon, Nov 29 2021 at 10:55, Will Deacon wrote:
>> On Sat, Nov 27, 2021 at 02:20:59AM +0100, Thomas Gleixner wrote:
>>> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>>> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
>>> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>>
>> Prviously, if retrieval of the MSI failed then we'd fall back to wired
>> interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
>> we make the assignments to smmu->*irq here conditional on the MSI being
>> valid, please?
>
> So the wired irq number is in ->irq already and MSI does an override
> if available. Not really obvious...

But, this happens right after:

     ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);

So if that succeeded then the descriptors exist and have interrupts
assigned.

Thanks,

        tglx



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
