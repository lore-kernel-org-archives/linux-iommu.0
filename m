Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D776C433F5
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 14:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EE6F60A6B;
	Mon, 29 Nov 2021 14:42:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aZHOS0Ts6sPY; Mon, 29 Nov 2021 14:42:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02023605B7;
	Mon, 29 Nov 2021 14:42:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCFC4C001C;
	Mon, 29 Nov 2021 14:42:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFD0AC000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 14:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE71560A6B
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 14:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JBV_dl_M56ET for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 14:42:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B219605B7
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 14:42:18 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638196934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CT0v0AI6Phc8QVXrts/Xgc4HRVQEDE2q+21sbaFe3Ag=;
 b=FLmFznUrsgGdCbkY18htm7AVhrJXD8U/COCS8SobY/Fs5q0hzBOjNa5VOMzAo8uh3ixtor
 Si29Nben+KPEqz1+N0yD6PS3qluBIuq3elGrNncT23ydzQDK2l9SnDPo2CnUq8qH8j8MZ6
 vdvCp+IY+fkqSwwbS7Vke5ucVqUPyZqIAnlw2remRg1r2/dstE2w/iGMIhhlHtUzXuGfyg
 PeIFtoJzVGaUJsD95eDn+sZvgevfzRe7bt6oelu5NOVNC0Y5uWJCfO8sg7SGeqm/QUZ5F8
 9idHosPV4IKLQIULp5+Ee114KeQfrHkYLH1gL8+nGq99mmniKOQJkHCZ2aVDWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638196934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CT0v0AI6Phc8QVXrts/Xgc4HRVQEDE2q+21sbaFe3Ag=;
 b=1lha+hOs5XE61wIA5Q6/xFS1hVtMHYwWSYlH+AylgvE8sxOiU/hMvfsbJ4+lxuc4mz54M/
 UkoehTAc13TFlPDw==
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
In-Reply-To: <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
 <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com>
Date: Mon, 29 Nov 2021 15:42:14 +0100
Message-ID: <87czmjdnw9.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zygnier <maz@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
 Tero Kristo <kristo@kernel.org>, Megha Dey <megha.dey@intel.com>
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

On Mon, Nov 29 2021 at 13:13, Robin Murphy wrote:
> On 2021-11-29 10:55, Will Deacon wrote:
>>> -	}
>>> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>>> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
>>> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>> 
>> Prviously, if retrieval of the MSI failed then we'd fall back to wired
>> interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
>> we make the assignments to smmu->*irq here conditional on the MSI being
>> valid, please?
>
> I was just looking at that too, but reached the conclusion that it's 
> probably OK, since consumption of this value later is gated on 
> ARM_SMMU_FEAT_PRI, so the fact that it changes from 0 to an error value 
> in the absence of PRI should make no practical difference.

It's actually 0 when the vector cannot be found.

> If we don't have MSIs at all, we'd presumably still fail earlier
> either at the dev->msi_domain check or upon trying to allocate the
> vectors, so we'll still fall back to any previously-set wired values
> before getting here.  The only remaining case is if we've
> *successfully* allocated the expected number of vectors yet are then
> somehow unable to retrieve one or more of them - presumably the system
> has to be massively borked for that to happen, at which point do we
> really want to bother trying to reason about anything?

Probably not. At that point something is going to explode sooner than
later in colorful ways.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
