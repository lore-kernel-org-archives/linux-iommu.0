Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEA3C433E3
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 18:20:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A8422BEA
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 18:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkvStWoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A8422BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BCD428612B;
	Thu, 27 Aug 2020 18:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xf8DW3k0ZPb8; Thu, 27 Aug 2020 18:20:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3A86586101;
	Thu, 27 Aug 2020 18:20:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F105C07FF;
	Thu, 27 Aug 2020 18:20:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BECAC0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 18:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E6AAB86119
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 18:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RBHobFE_alCd for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 18:20:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5612786101
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 18:20:42 +0000 (UTC)
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A730E2087E;
 Thu, 27 Aug 2020 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598552442;
 bh=m7vhbAFnI7P7AwdKlzAn0wqD1YPTHJSRQ+ZyXNR7MXY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=UkvStWoB1OiC87isw5L+RU0aRZ6Byn64sN6W7fqyqnYslW1VbyUto3Ot7HnJdzmV/
 BpHMqJ6kR2FuX03H7NAUtZrH7Q62VQWR+Hm7VJz4TNIG5szeBamrDedrrHkWMj3Ds6
 qwX6HCvJ0Dk2KiupyPg7/GXt0z0MFg9xlpzjsATc=
Date: Thu, 27 Aug 2020 13:20:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
Message-ID: <20200827182040.GA2049623@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826112333.992429909@linutronix.de>
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Rob Herring <robh@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

[+cc Rob,
cover https://lore.kernel.org/r/20200826111628.794979401@linutronix.de/
this  https://lore.kernel.org/r/20200826112333.992429909@linutronix.de/]

On Wed, Aug 26, 2020 at 01:17:02PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The arch_.*_msi_irq[s] fallbacks are compiled in whether an architecture
> requires them or not. Architectures which are fully utilizing hierarchical
> irq domains should never call into that code.
> 
> It's not only architectures which depend on that by implementing one or
> more of the weak functions, there is also a bunch of drivers which relies
> on the weak functions which invoke msi_controller::setup_irq[s] and
> msi_controller::teardown_irq.
> 
> Make the architectures and drivers which rely on them select them in Kconfig
> and if not selected replace them by stub functions which emit a warning and
> fail the PCI/MSI interrupt allocation.

Sorry, I really don't understand this, so these are probably stupid
questions.

If CONFIG_PCI_MSI_ARCH_FALLBACKS is defined, we will supply
implementations of:

  arch_setup_msi_irq
  arch_teardown_msi_irq
  arch_setup_msi_irqs
  arch_teardown_msi_irqs
  default_teardown_msi_irqs    # non-weak

You select CONFIG_PCI_MSI_ARCH_FALLBACKS for ia64, mips, powerpc,
s390, sparc, and x86.  I see that all of those arches implement at
least one of the functions above.  But x86 doesn't and I can't figure
out why it needs to select CONFIG_PCI_MSI_ARCH_FALLBACKS.

I assume there's a way to convert these arches to hierarchical irq
domains so they wouldn't need this at all?  Is there a sample
conversion to look at?

And I can't figure out what's special about tegra, rcar, and xilinx
that makes them need it as well.  Is there something I could grep for
to identify them?  Is there a way to convert them so they don't need
it?

> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -193,17 +193,38 @@ void pci_msi_mask_irq(struct irq_data *d
>  void pci_msi_unmask_irq(struct irq_data *data);
>  
>  /*
> - * The arch hooks to setup up msi irqs. Those functions are
> - * implemented as weak symbols so that they /can/ be overriden by
> - * architecture specific code if needed.
> + * The arch hooks to setup up msi irqs. Default functions are implemented

s/msi/MSI/ to match the one below.

> + * as weak symbols so that they /can/ be overriden by architecture specific
> + * code if needed. These hooks must be enabled by the architecture or by
> + * drivers which depend on them via msi_controller based MSI handling.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
