Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E04C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 22:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 98E0D40122;
	Fri, 17 Dec 2021 22:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CAkG3BgHPprr; Fri, 17 Dec 2021 22:30:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A9A5404A6;
	Fri, 17 Dec 2021 22:30:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2FC5C001E;
	Fri, 17 Dec 2021 22:30:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA8BAC0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C148E6116F
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eA9KcxgLnaTS for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 22:30:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8DAC61162
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:30:13 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id AEC59B82B21;
 Fri, 17 Dec 2021 22:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E46BC36AE2;
 Fri, 17 Dec 2021 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639780209;
 bh=8wwtNzd+gqMtJWZe56YrMEoqcAh58nCen38oaJYWaO8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iEDPDsKO98XO/jvJbm+yFgRmQxDl4CmwNCCZ9O7HpbCSEXJA25pw5YHPwb3s5TQNN
 i9BY1ubFlnf5uG9DhdB1upZgn3wBZ2U7zEKoZbzzSqONfP1iWr0lR/mc6vKNukUu4Y
 v3rmzZ7PuTCgGnrM38gn5DW9gYtmVN5J+BeNUM4EZYyS4A+dHs/rlpxPuADA19S0dn
 neVNoMO0dY5ql14VUQ62/P1PHlq3AtDvEc5p5JSO8vS0wwfJA0S0NhJ71hctL2lZr6
 u+JH0mJiYdoKOw4PkNyE8E1OMgv4ObOm4BwqrAiECJ8clDjSowxx7LeV6ApqW7P8A6
 w01dCRvRkkngQ==
Date: Fri, 17 Dec 2021 15:30:00 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
Message-ID: <Yb0PaCyo/6z3XOlf@archlinux-ax161>
References: <20211210221642.869015045@linutronix.de>
 <20211210221814.900929381@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211210221814.900929381@linutronix.de>
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

Hi Thomas,

On Fri, Dec 10, 2021 at 11:19:26PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace open coded MSI descriptor chasing and use the proper accessor
> functions instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Apologies if this has already been reported somewhere else or already
fixed, I did a search of all of lore and did not see anything similar to
it and I did not see any new commits in -tip around this.

I just bisected a boot failure on my AMD test desktop to this patch as
commit f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()") in
-next. It looks like there is a problem with the NVMe drive after this
change according to the logs. Given that the hard drive is not getting
mounted for journald to write logs to, I am not really sure how to get
them from the machine so I have at least taken a picture of what I see
on my screen; open to ideas on that front!

https://github.com/nathanchance/bug-files/blob/0d25d78b5bc1d5e9c15192b3bc80676364de8287/f48235900182/crash.jpg

Please let me know what information I can provide to make debugging this
easier and I am more than happy to apply and test patches as needed.

Cheers,
Nathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
