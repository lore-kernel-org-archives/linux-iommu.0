Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F2EC433EF
	for <iommu@archiver.kernel.org>; Tue, 30 Nov 2021 12:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EC054043E;
	Tue, 30 Nov 2021 12:31:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CNRSf09ZZbUX; Tue, 30 Nov 2021 12:31:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D82040438;
	Tue, 30 Nov 2021 12:31:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 672C6C0012;
	Tue, 30 Nov 2021 12:31:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C512C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 12:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 915636069F
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 12:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="By9F2Cxz";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="b3LRCCra"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gg3Bcitr-d3s for <iommu@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 12:30:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 780496058F
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 12:30:57 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638275453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MoxU22IJJPvJRa8OS7V+vWzcBzYBFKmJ+AzUDqGDJ0c=;
 b=By9F2CxzS/o9ToFNEiRxLUVS4AyQNuM7azBeEiD814EleLq+hJGIFbr5Pb7s+yxDcghQJZ
 bz+QmgZkMouYYFY+n8NIMmEVrzBGnKypYEtqksbB0LcQcsXrqkseVFUPXnb/sd5ZkkeCjp
 Pnu87QVrfqY+aPFRcb2JbkA20ryw2kwZX8Zt58hXMuKopfKcpJeEcYrsQaBCBid5TfxvzR
 pg01jc6fTOy30S6/4paKJbL3nUdr+wHzyl4B2pcoryuGOAyzDqtURCC8EFqCHDYt+1EdmP
 Tn7K/VVDH3bM9b/JWsuJU4BSSPJHX1HAmQQ17NBsztNZhn1jdrGHUG7vESjD7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638275453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MoxU22IJJPvJRa8OS7V+vWzcBzYBFKmJ+AzUDqGDJ0c=;
 b=b3LRCCrahGv4zVsp1t2g38jgPS8/TbYK4NCKubQCW9LmpN8f4nz/THoNrepB7KLN6Bne8n
 caFNq7QymQ+tnnDg==
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
In-Reply-To: <20211130093607.GA23941@willie-the-truck>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
 <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com> <87czmjdnw9.ffs@tglx>
 <b192ad88-5e4e-6f32-1cc7-7a50fc0676a1@arm.com>
 <20211130093607.GA23941@willie-the-truck>
Date: Tue, 30 Nov 2021 13:30:53 +0100
Message-ID: <878rx5ddvm.ffs@tglx>
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

On Tue, Nov 30 2021 at 09:36, Will Deacon wrote:
> On Mon, Nov 29, 2021 at 02:54:18PM +0000, Robin Murphy wrote:
>> On 2021-11-29 14:42, Thomas Gleixner wrote:
>> > It's actually 0 when the vector cannot be found.
>> 
>> Oh, -1 for my reading comprehension but +1 for my confidence in the patch
>> then :)
>> 
>> I'll let Will have the final say over how cautious we really want to be
>> here, but as far as I'm concerned it's a welcome cleanup as-is. Ditto for
>> patch #32 based on the same reasoning, although I don't have a suitable test
>> platform on-hand to sanity-check that one.
>
> If, as it appears, msi_get_virq() isn't going to fail meaningfully after
> we've successfully called platform_msi_domain_alloc_irqs() then it sounds
> like the patch is fine. Just wanted to check though, as Spring cleaning at
> the end of November raised an eyebrow over here :)

Fair enough. Next time I'll name it 'Cleaning the Augean stables' when
it's the wrong season.

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
