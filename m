Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985F0C43219
	for <iommu@archiver.kernel.org>; Thu, 16 Dec 2021 17:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17FCF40B34;
	Thu, 16 Dec 2021 17:23:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3I_mcgDyJCc1; Thu, 16 Dec 2021 17:23:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C38A40360;
	Thu, 16 Dec 2021 17:23:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32086C002F;
	Thu, 16 Dec 2021 17:23:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F622C0012
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 17:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14A1061031
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 17:23:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="OMVjennJ";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="KLmanqyV"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMWkqUXiTbHR for <iommu@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 17:23:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73B8C61030
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 17:23:46 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639675422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ih3MOpW/yCW+x5F+uZuuVRHaDZ9exo66WfrPCFsrhAY=;
 b=OMVjennJ3dIFrwVfMs8MzDcb41Xr30oKty6fkqZ9/dg2KPX2j01Itd6kvCYu1225sOnYuo
 IeaHw/JoJkXrtGr3oWwJMzzEwGmbkJFG3vgu9mNytV1jkcv4dag6oBGHon+mbf9Ogyak6J
 JF0hQ4F7JA1yDzHNDLmTJM8en1l9nh0l4RtyKkhJNdGp1qF+PkIKoY49IEUHTkOsVif77X
 EDZmJYVvTSc9g7y9TRGoIHjKz9B63drgsnnIlXTKDk1IKqeYDrXtl+Qq6LpiQy1hqLdDie
 mG/yWvrQXdNGXa7j6B8oNi6M8Sbe5B02MnwHdqWu6fekNoxcotWWNW+EPmJPkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639675422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ih3MOpW/yCW+x5F+uZuuVRHaDZ9exo66WfrPCFsrhAY=;
 b=KLmanqyVLTn1a9p7GzpJVoRlRAGdDGqehRu/zZHojbSx8/zpp5uAkFxpqxeluTK3IDEpyQ
 hmWFXp91ZBiOKlBQ==
To: Nishanth Menon <nm@ti.com>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
In-Reply-To: <20211216014527.5d3sqs2klrqjmm2k@lunacy>
References: <20211213182958.ytj4m6gsg35u77cv@detonator>
 <87fsqvttfv.ffs@tglx> <20211214162247.ocjm7ihg5oi7uiuv@slider>
 <87wnk7rvnz.ffs@tglx> <87tufbrudl.ffs@tglx> <87mtl3rli1.ffs@tglx>
 <20211214205626.lrnddha6bd6d6es5@possibly> <87h7basx36.ffs@tglx>
 <87zgp1rge4.ffs@tglx> <87wnk5rfkt.ffs@tglx>
 <20211216014527.5d3sqs2klrqjmm2k@lunacy>
Date: Thu, 16 Dec 2021 18:23:41 +0100
Message-ID: <87wnk4cvky.ffs@tglx>
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

On Wed, Dec 15 2021 at 19:45, Nishanth Menon wrote:
> On 17:35-20211215, Thomas Gleixner wrote:
> Thanks once again for your help. Hope we can roll in the fixes for
> part3.

Sure, it's only the one-liner for ti sci. Got it folded already.

Thanks for your help and testing!

       tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
