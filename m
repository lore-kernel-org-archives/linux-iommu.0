Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07641C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 21:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EE73408AF;
	Tue, 14 Dec 2021 21:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8MGZipcB9VWC; Tue, 14 Dec 2021 21:20:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CACAF402FE;
	Tue, 14 Dec 2021 21:20:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEE53C002F;
	Tue, 14 Dec 2021 21:20:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A64F7C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 21:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FF508176B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 21:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="EzQFCHRv";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="lDR2zL85"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fL1PtKmxLRW for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 21:20:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED4A48176C
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 21:20:01 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639516798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UY5SIbLiQJhNf3IcwLAaYT3af81CnBCUSA3qSWP4dj0=;
 b=EzQFCHRvraOq6euqkQn1B+tUeoQ1uw1bo4mwk9Q+vKSF8S8PO4nMGeLKZ/WNHEDZ5eJhpq
 mjggZFTuoIKEO/OrzzxxfitzasNIFFxeDKcRyrdk7DdmUaNmMFC1unLIMtUfaK38TWwXYn
 h2orgm5VCZyrGWnjQirGszYr8438eZQal4q/1iuBvD2zWg9nOeapYD6mAyJQRKxCWoQSAd
 enz2/bCSy9StMuvCnU8bbCEhKsc+iX17V3lbzwiD4WPpGEDgVUswHFbLH8z54QbwfbJl42
 iPxl/XpXV7+3L/A3q2mlzAY6VVHUHz35mnJZ8s3Ze10jfDmKSXRCDaOkhFkkdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639516798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UY5SIbLiQJhNf3IcwLAaYT3af81CnBCUSA3qSWP4dj0=;
 b=lDR2zL85oMI4BdOLKEJ1Arl/dti0X9kWdevk0BKKPLGWBqf9hwgLOpBluOuP1fE4iBCR8Y
 5fOFMFfQxW57zEAA==
To: Nishanth Menon <nm@ti.com>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
In-Reply-To: <20211214205626.lrnddha6bd6d6es5@possibly>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator> <87fsqvttfv.ffs@tglx>
 <20211214162247.ocjm7ihg5oi7uiuv@slider> <87wnk7rvnz.ffs@tglx>
 <87tufbrudl.ffs@tglx> <87mtl3rli1.ffs@tglx>
 <20211214205626.lrnddha6bd6d6es5@possibly>
Date: Tue, 14 Dec 2021 22:19:57 +0100
Message-ID: <87h7basx36.ffs@tglx>
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>, Johannes Berg <johannes.berg@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Marc Zygnier <maz@kernel.org>,
 dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

Nishanth,

On Tue, Dec 14 2021 at 14:56, Nishanth Menon wrote:
> On 21:15-20211214, Thomas Gleixner wrote:
>> I think I managed to distangle this. Can you please give:
>> 
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v4-part-2
>
>
> Umm.. I am not entirely sure what is going on.. but all kinds of weird
> corruption seems to occur with msi-v4-part-2 that does'nt seem to be
> present in v5.16-rc5. (I use NFS since ethernet in K3 platforms use
> inta/intr and dma that is impacted by this series).
>
> I will try and rebase your patches on v5.16-rc4 to be sure as well and
> report back later today once i get some time.
>
> [1] https://gist.github.com/nmenon/a66e022926c4c15313c45d44313d860c msi-v4-part-2
> [2] https://gist.github.com/nmenon/43085664d69ad846d596e76a06ed0656  v5.16-rc5

thanks for trying. I'll have a look again with brain awake tomorrow
morning.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
