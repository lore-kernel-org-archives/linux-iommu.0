Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195F0C433F5
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 16:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7815B41580;
	Wed, 15 Dec 2021 16:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nDj88gXPZaGb; Wed, 15 Dec 2021 16:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2DBFA415A0;
	Wed, 15 Dec 2021 16:35:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51349C0073;
	Wed, 15 Dec 2021 16:35:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 879E6C0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 16:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 70AEA409DD
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 16:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="UJE/DKAA";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="FmacxqQd"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3zYhbIFv2KDI for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 16:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A18CB409D8
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 16:35:48 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639586146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UB4Bw8MahD5M8h/NI3Qg8AnbGIqaExPOcnRrzmSiao=;
 b=UJE/DKAABkBqFfjPbQnvYAH3rAoH/vlj0D3tBq02glY+Xwhi8IpuF/pdE8zOIh+LNq59Nl
 kIqPjL89RcIzLEag1h7k2fjb+cwOgjLe2MPvqWGyX6pPIlfV1AnbJNO0RuBaUEb7/o0lvf
 q7lAhQWh+jCRH3tIOsFsqmXut2p3+pY+woMjHpqHODXs3CqrcekUWtGDQ70j670MFnLBTT
 aQ4wHJwfbR6HaCSKuK7oh9/3WwrmyLBIAATt4Nc3Q80k12NK8vG02zW6aIuT4FiJH5XBgo
 uSp+QB7y3cnGolmhLgdyTIlgvw5ujoxSylCKtVjDQrixkhMxYakcLekWYL3jCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639586146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UB4Bw8MahD5M8h/NI3Qg8AnbGIqaExPOcnRrzmSiao=;
 b=FmacxqQdf9S6/zcHrLZoWNqKtU3gTCf8SLlCTPXPqPhR+QBO0MStt+qlts1rWvFXaKykO/
 d3arXts9WnCbrmDA==
To: Nishanth Menon <nm@ti.com>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
In-Reply-To: <87zgp1rge4.ffs@tglx>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator> <87fsqvttfv.ffs@tglx>
 <20211214162247.ocjm7ihg5oi7uiuv@slider> <87wnk7rvnz.ffs@tglx>
 <87tufbrudl.ffs@tglx> <87mtl3rli1.ffs@tglx>
 <20211214205626.lrnddha6bd6d6es5@possibly> <87h7basx36.ffs@tglx>
 <87zgp1rge4.ffs@tglx>
Date: Wed, 15 Dec 2021 17:35:46 +0100
Message-ID: <87wnk5rfkt.ffs@tglx>
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

On Wed, Dec 15 2021 at 17:18, Thomas Gleixner wrote:

> On Tue, Dec 14 2021 at 22:19, Thomas Gleixner wrote:
>> On Tue, Dec 14 2021 at 14:56, Nishanth Menon wrote:
>>
>> thanks for trying. I'll have a look again with brain awake tomorrow
>> morning.
>
> Morning was busy with other things, but I found what my sleepy brain
> managed to do wrong yesterday evening.
>
> Let me reintegrate the pile and I'll send you an update.

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v4.1-part-2
   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v4.2-part-3

That should cure the problem.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
