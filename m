Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2128FC433F5
	for <iommu@archiver.kernel.org>; Mon, 31 Jan 2022 21:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB78B60EF1;
	Mon, 31 Jan 2022 21:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XstcHWZPQ42t; Mon, 31 Jan 2022 21:16:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9EFFC60B03;
	Mon, 31 Jan 2022 21:16:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7564CC001A;
	Mon, 31 Jan 2022 21:16:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D9A7C000B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 21:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6888182BBC
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 21:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="KmPtM4Xy";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="+0otG72A"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bZzUv1Q5T_Np for <iommu@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 21:16:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1E3282BBA
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 21:16:45 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1643663802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tU8NK9NTEirj5O/+bd9d0PukMKUVqECyFzPD3aLKDXk=;
 b=KmPtM4XylI1QpBV825qhL/YVm9F73QsW9H0dQ5UPcPGil3mXgUuoX3HprH/+a3ZG/ShNJr
 BjlGsc1ndAOmgHyQvIvZUOUD6HLDHOBCi/Ji6X9uEEf7jDK1BzH1apOdzDHBzBMfjkAtXZ
 8BD8lWMmiKDXbdlCTK3THWqdS9xoq1KFr2G35OtVX67EMI6vGc6c9cosnIZIpe5sYh+au2
 PL1LZWmdvONdEfE18CsyjWjHM6gOUgcS0xyBIooTsaH48TF002qdkFf00iF1dJ2JVj/0SI
 eh6W7ozcJJE4CPYA3I/LgUWnchhhUB5lvUTPvZV1OWQ8MM0o/wu35qDKV5db6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1643663802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tU8NK9NTEirj5O/+bd9d0PukMKUVqECyFzPD3aLKDXk=;
 b=+0otG72AhE6uKJBBtoOAEgmDIjBRXfGv02FMllL7V8PEVFVne4ebGZPaDcAGYon+0st4ER
 /th5pds4YqGCrMCA==
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
In-Reply-To: <c78df469-1a9f-5778-24d1-8f08a6bf5bcc@roeck-us.net>
References: <87mtjc2lhe.ffs@tglx>
 <c78df469-1a9f-5778-24d1-8f08a6bf5bcc@roeck-us.net>
Date: Mon, 31 Jan 2022 22:16:41 +0100
Message-ID: <87ee4n38sm.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Ashok Raj <ashok.raj@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sinan Kaya <okaya@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
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

Guenter,

On Mon, Jan 31 2022 at 07:21, Guenter Roeck wrote:
> Sure. Please see http://server.roeck-us.net/qemu/x86/.
> The logs are generated with with v5.16.4.

thanks for providing the data. It definitely helped me to leave the
state of not seeing the wood for the trees. Fix below.

Thanks,

        tglx
---
Subject: PCI/MSI: Remove bogus warning in pci_irq_get_affinity()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 31 Jan 2022 22:02:46 +0100

The recent overhaul of pci_irq_get_affinity() introduced a regression when
pci_irq_get_affinity() is called for an MSI-X interrupt which was not
allocated with affinity descriptor information.

The original code just returned a NULL pointer in that case, but the rework
added a WARN_ON() under the assumption that the corresponding WARN_ON() in
the MSI case can be applied to MSI-X as well.

In fact the MSI warning in the original code does not make sense either
because it's legitimate to invoke pci_irq_get_affinity() for a MSI
interrupt which was not allocated with affinity descriptor information.

Remove it and just return NULL as the original code did.

Fixes: f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1111,7 +1111,8 @@ const struct cpumask *pci_irq_get_affini
 	if (!desc)
 		return cpu_possible_mask;
 
-	if (WARN_ON_ONCE(!desc->affinity))
+	/* MSI[X] interrupts can be allocated without affinity descriptor */
+	if (!desc->affinity)
 		return NULL;
 
 	/*
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
