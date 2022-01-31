Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63D7C433F5
	for <iommu@archiver.kernel.org>; Mon, 31 Jan 2022 11:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7144D83FDD;
	Mon, 31 Jan 2022 11:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OLTfZthDd-ub; Mon, 31 Jan 2022 11:28:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3833683F88;
	Mon, 31 Jan 2022 11:28:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19B69C001A;
	Mon, 31 Jan 2022 11:28:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EEBBC000B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 11:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CF9460E3C
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 11:28:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="08+adjG5";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="F4vMMMS/"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rdaCn0VhBJs for <iommu@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 11:28:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50F0D60D68
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 11:28:02 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1643628478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=4vunJSw+29nMhKwarhIq3XOACVtrs68uDOcnGTjBogA=;
 b=08+adjG5kvqly9R27r6UQqPVlHuuR0wvg7AraR+yb44p1SYXk6tzK2abtw7IGSi2A3wXfI
 6U1PBy/jkvuCM3fKrPHG2APL7p9nnSGR9rg89/6St5G9+Iod6wSzgG4//1TPbjInXUs8YN
 AwxB3zkSRCSMca4ho01kA/XiGI4WDXwyqGA/Q1QoCwvYXEwS/NWbubISSEMuoN2RNNZk6X
 k+mIQEs2lRbseraKMG1ylwlb9XmMSJiXrB/5Msv2UG1+iYWWGnwuZaVGTtIizxYMk1wpBk
 7RxcI8ct1tXsnuKIrqrBOd4gsj7C5lweoLU2Rx7EKaWcOJBL6ltT48oEiUJlEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1643628478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=4vunJSw+29nMhKwarhIq3XOACVtrs68uDOcnGTjBogA=;
 b=F4vMMMS/RR2647UpQl2u4kgknqNjM8y1uiJemITMdVUuEzICexEkSEXuPmcOo4kKXCPGTF
 66aXb64gMDoB5SDg==
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
In-Reply-To: <20220130171210.GA3545402@roeck-us.net>
Date: Mon, 31 Jan 2022 12:27:57 +0100
Message-ID: <87mtjc2lhe.ffs@tglx>
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

On Sun, Jan 30 2022 at 09:12, Guenter Roeck wrote:
> On Fri, Dec 10, 2021 at 11:19:26PM +0100, Thomas Gleixner wrote:
> This patch results in the following runtime warning when booting x86
> (32 bit) nosmp images from NVME in qemu.
>
> [   14.825482] nvme nvme0: 1/0/0 default/read/poll queues
> ILLOPC: ca7c6d10: 0f 0b
> [   14.826188] ------------[ cut here ]------------
> [   14.826307] WARNING: CPU: 0 PID: 7 at drivers/pci/msi/msi.c:1114 pci_irq_get_affinity+0x80/0x90

This complains about msi_desc->affinity being NULL.

> git bisect bad f48235900182d64537c6e8f8dc0932b57a1a0638
> # first bad commit: [f48235900182d64537c6e8f8dc0932b57a1a0638] PCI/MSI: Simplify pci_irq_get_affinity()

Hrm. Can you please provide dmesg and /proc/interrupts from a
kernel before that commit?

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
