Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CA8C433F5
	for <iommu@archiver.kernel.org>; Sat, 18 Dec 2021 10:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5BD6409FD;
	Sat, 18 Dec 2021 10:25:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b09JDQfaXc8r; Sat, 18 Dec 2021 10:25:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 613E040103;
	Sat, 18 Dec 2021 10:25:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39286C002F;
	Sat, 18 Dec 2021 10:25:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A397BC0012
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 10:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F3CE42223
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 10:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="tn5AlMpl";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="rrfck+zS"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uYLyok0cX53i for <iommu@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 10:25:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7BC442211
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 10:25:18 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639823115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nl4ddDnB1oKo0fcoNLd0K0Xuyht31044PvDVab+sRz0=;
 b=tn5AlMplZSyHPZ4eu4NMTH2tosi8XfO1/mNklSs+ImTlR8P5gfKJgKJLi6NJ4TFAklevD0
 1avFcMo8k3hGWDd1Iy/rc1ZPeM7eACV1BbuVnX4QY/eXDhd48j/Sh4CvcSDSL9IbisUp7z
 caDqaSpU9ud+i2NkshpSak1RSaSSAW8O+tSdpPZC1vhiTXp+kGqQePG8eL1c519ZMa10bj
 4A/PikhGc/SgM12CbM14omQUZtwMCPY58ymXGe2D8aFAWliD8DPNhbbTAoxPao+HsDqHhF
 X3Af3aTvpYn3Z94vxqiwZNOhBtC+RdSsTPCSCauo8T9TOXtM5vssh7kfd7kvGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639823115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nl4ddDnB1oKo0fcoNLd0K0Xuyht31044PvDVab+sRz0=;
 b=rrfck+zS5tliLA0jRIoJ5g0PCCswYFJD7whCSlQHRXayW7rMo7mOMzACWAo8/AkVTaI5km
 I03oaHuan7mQiiAA==
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
In-Reply-To: <Yb0PaCyo/6z3XOlf@archlinux-ax161>
References: <20211210221642.869015045@linutronix.de>
 <20211210221814.900929381@linutronix.de>
 <Yb0PaCyo/6z3XOlf@archlinux-ax161>
Date: Sat, 18 Dec 2021 11:25:14 +0100
Message-ID: <87v8zm9pmd.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

On Fri, Dec 17 2021 at 15:30, Nathan Chancellor wrote:
> On Fri, Dec 10, 2021 at 11:19:26PM +0100, Thomas Gleixner wrote:
> I just bisected a boot failure on my AMD test desktop to this patch as
> commit f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()") in
> -next. It looks like there is a problem with the NVMe drive after this
> change according to the logs. Given that the hard drive is not getting
> mounted for journald to write logs to, I am not really sure how to get
> them from the machine so I have at least taken a picture of what I see
> on my screen; open to ideas on that front!

Bah. Fix below.

Thanks,

        tglx
---
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 71802410e2ab..9b4910befeda 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1100,7 +1100,7 @@ EXPORT_SYMBOL(pci_irq_vector);
  */
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 {
-	int irq = pci_irq_vector(dev, nr);
+	int idx, irq = pci_irq_vector(dev, nr);
 	struct msi_desc *desc;
 
 	if (WARN_ON_ONCE(irq <= 0))
@@ -1113,7 +1113,10 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 
 	if (WARN_ON_ONCE(!desc->affinity))
 		return NULL;
-	return &desc->affinity[nr].mask;
+
+	/* MSI has a mask array in the descriptor. */
+	idx = dev->msi_enabled ? nr : 0;
+	return &desc->affinity[idx].mask;
 }
 EXPORT_SYMBOL(pci_irq_get_affinity);
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
