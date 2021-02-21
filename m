Return-Path: <SRS0=WS+C=HX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D814C433E0
	for <iommu@archiver.kernel.org>; Sun, 21 Feb 2021 03:32:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56B464EF6
	for <iommu@archiver.kernel.org>; Sun, 21 Feb 2021 03:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56B464EF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A37785F31;
	Sun, 21 Feb 2021 03:32:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5_OFV52eRO-Z; Sun, 21 Feb 2021 03:32:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BF8B85F9A;
	Sun, 21 Feb 2021 03:32:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FB34C000A;
	Sun, 21 Feb 2021 03:32:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07B41C0001
 for <iommu@lists.linux-foundation.org>; Sun, 21 Feb 2021 03:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E0E43870E9
 for <iommu@lists.linux-foundation.org>; Sun, 21 Feb 2021 03:32:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lbdo5zWRi5wY for <iommu@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 03:32:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from angie.orcam.me.uk (angie.orcam.me.uk [157.25.102.26])
 by hemlock.osuosl.org (Postfix) with ESMTP id 91D228712E
 for <iommu@lists.linux-foundation.org>; Sun, 21 Feb 2021 03:32:40 +0000 (UTC)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 87AEC92009C; Sun, 21 Feb 2021 04:32:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 7D0A092009B;
 Sun, 21 Feb 2021 04:32:38 +0100 (CET)
Date: Sun, 21 Feb 2021 04:32:38 +0100 (CET)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] driver core: lift dma_default_coherent into common
 code
In-Reply-To: <alpine.DEB.2.21.2102151342050.1521@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2102210407090.2021@angie.orcam.me.uk>
References: <20210208145024.3320420-1-hch@lst.de>
 <20210208145024.3320420-6-hch@lst.de>
 <alpine.DEB.2.21.2102081654060.35623@angie.orcam.me.uk>
 <20210208161043.GA14083@lst.de>
 <alpine.DEB.2.21.2102091213070.35623@angie.orcam.me.uk>
 <alpine.DEB.2.21.2102151342050.1521@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

On Mon, 15 Feb 2021, Maciej W. Rozycki wrote:

>  I hope to have the adapter properly fixed soon and I'll look at the Malta 
> side now, possibly using the old server whose DEFPA has worked flawlessly 
> for some 20 years now.  I have planned to use the interface to supply NFS 
> root, which I think should be enough of a stress test.

 Card reworked now and network wired, so using the new server actually.  
I haven't booted Linux on my Malta for a while now, but it turns out to 
work just fine, and your patch set does not regress it booting multi-user 
NFS-rooted over FDDI.

 I note however that the system does not reboot properly:

sd 0:0:0:0: [sda] Synchronizing SCSI cache
reboot: Restarting system
Reboot failed -- System halted

which is a regression, and also the MMIO-mapped discrete CBUS UART (ttyS2) 
does not sign in anymore either:

Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
printk: console [ttyS0] disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [uart8250] disabled
printk: bootconsole [uart8250] disabled
serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A

while long ago:

Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS28 at 0x03f8 (irq = 4) is a 16550A
ttyS29 at 0x02f8 (irq = 3) is a 16550A
ttyS30 at 0x0000 (irq = 20) is a 16550

(I don't know why the line numbers reported were so odd back then, but the 
standard character device major:minor numbers for ttyS0-2 just worked), so 
there's probably something wrong with platform device registration.  ISTR 
using the CBUS UART as a console device at one point too.

  Maciej
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
