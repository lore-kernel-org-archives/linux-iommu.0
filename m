Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7204C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 16:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E4EA40580;
	Tue, 14 Dec 2021 16:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1_fT5NuMbBVy; Tue, 14 Dec 2021 16:36:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 337094056B;
	Tue, 14 Dec 2021 16:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBC1BC001E;
	Tue, 14 Dec 2021 16:36:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC448C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 16:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC198408C2
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 16:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="x+UREoz0";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="JRPDqiMe"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RMuMej6XtNXi for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 16:36:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DFBF408BC
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 16:36:04 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639499761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHkEiVG0BVT8V/9kbAcBq/GVsYt3jqgvF40FkGyKrlo=;
 b=x+UREoz0tV0ByegvETONzIcJg/btHkYAeUTOB9Cwk6fF4WS4tcdqSKPZhosLY9Kw8fzkL2
 iAO8dxlrohDcjOfDmK3UIx35hhe0gnfY1J6UUVxyO061FZZ9igOXoMxu0oZsfFw4GbgpYB
 Q5rK3Ehp3GsvY/ZWFqOBDe34LxDsXDQAfeXwgAzwLGuRTF6/6fajjiB+l4faY58KyXYRd9
 TRvQUMx4KhjpOhAQjyD53NZ44/KDHNZzen3o5CWSSmMuXJs7tSK49MGIkP5L/9Tw/0p3r8
 ob+7BJIhXKuW4vpCWZYdUoDVrJaJ+Ar127CVhFKQjgeiplPgqNc0w3IVyPx/sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639499761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHkEiVG0BVT8V/9kbAcBq/GVsYt3jqgvF40FkGyKrlo=;
 b=JRPDqiMesD5qMuzHSYGkN8LOEMskH9IhyPnRCqMbSThsy+YATwXU6QDtFhGJhGuZcxfILm
 UyvW8q3ctT/IqHDg==
To: Nishanth Menon <nm@ti.com>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
In-Reply-To: <20211214162247.ocjm7ihg5oi7uiuv@slider>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator> <87fsqvttfv.ffs@tglx>
 <20211214162247.ocjm7ihg5oi7uiuv@slider>
Date: Tue, 14 Dec 2021 17:36:00 +0100
Message-ID: <87wnk7rvnz.ffs@tglx>
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

On Tue, Dec 14 2021 at 10:22, Nishanth Menon wrote:
> On 10:41-20211214, Thomas Gleixner wrote:
> Agreed that the warning is fine, the null pointer exception that follows
> [1] [2] it however does'nt look right and it can be trivially fixed with the
> following fixup for ee90787487bc ("genirq/msi: Provide
> msi_device_populate/destroy_sysfs()") below, with that the log looks
> like [3] - the warn is good, the null pointer exception and resultant
> crash could be avoided (not saying this is the best solution):

Aaargh.

[   13.478122] Call trace:
[   13.509042]  msi_device_destroy_sysfs+0x18/0x88
[   13.509058]  msi_domain_free_irqs+0x34/0x58
[   13.509064]  pci_msi_teardown_msi_irqs+0x30/0x3c
[   13.509072]  free_msi_irqs+0x78/0xd4
[   13.509077]  pci_disable_msix+0x138/0x164
[   13.529930]  pcim_release+0x70/0x238
[   13.529942]  devres_release_all+0x9c/0xfc
[   13.529951]  device_release_driver_internal+0x1a0/0x244
[   13.542725]  device_release_driver+0x18/0x24
[   13.542741]  iwl_req_fw_callback+0x1a28/0x1ddc [iwlwifi]
[   13.552308]  request_firmware_work_func+0x50/0x9c
[   13.552320]  process_one_work+0x194/0x25c

That's not a driver problem, that's an ordering issue vs. the devres
muck. Let me go back to the drawing board. Sigh...

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
