Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC4EC433F5
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 12:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F18C4401C9;
	Sat, 27 Nov 2021 12:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qnj1LQHvQqKl; Sat, 27 Nov 2021 12:17:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A5AD44019D;
	Sat, 27 Nov 2021 12:17:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75DAFC001C;
	Sat, 27 Nov 2021 12:17:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62C4AC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 12:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58DC260736
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 12:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dg9yj9PRkbKV for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 12:17:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A91F606F9
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 12:17:07 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CDDB760AB1;
 Sat, 27 Nov 2021 12:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEB7C53FAD;
 Sat, 27 Nov 2021 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1638015426;
 bh=M6KvGcYrDtqG4OBO1gHapd1tDJsuhzzacZxeaaXXH6w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=doyQfESCcBzpnRFpLoKwXz+i4FTuaUYgFKnb7y/BPmpr5XafmAT6LvSwSB1VQqFTV
 jQ1NPvskhZ74XU97cJlDOyNb/rTXfh5nE5F2zaiQ90FTxBTrQfn5W/LTsdTMn0Wq0q
 NaCTokaE44OOwbXoUtzd8OESp8iL9ekPzopagvxM=
Date: Sat, 27 Nov 2021 13:17:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/37] genirq/msi, PCI/MSI: Spring cleaning - Part 2
Message-ID: <YaIhv0Cparn92Lz3@kroah.com>
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211126224100.303046749@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
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

On Sat, Nov 27, 2021 at 02:20:06AM +0100, Thomas Gleixner wrote:
> This is the second part of [PCI]MSI refactoring which aims to provide the
> ability of expanding MSI-X vectors after enabling MSI-X.
> 
> The first part of this work can be found here:
> 
>     https://lore.kernel.org/r/20211126222700.862407977@linutronix.de
> 
> This second part has the following important changes:
> 
>    1) Cleanup of the MSI related data in struct device
> 
>       struct device contains at the moment various MSI related parts. Some
>       of them (the irq domain pointer) cannot be moved out, but the rest
>       can be allocated on first use. This is in preparation of adding more
>       per device MSI data later on.
> 
>    2) Consolidation of sysfs handling
> 
>       As a first step this moves the sysfs pointer from struct msi_desc
>       into the new per device MSI data structure where it belongs.
> 
>       Later changes will cleanup this code further, but that's not possible
>       at this point.
> 
>    3) Store per device properties in the per device MSI data to avoid
>       looking up MSI descriptors and analysing their data. Cleanup all
>       related use cases.
> 
>    4) Provide a function to retrieve the Linux interrupt number for a given
>       MSI index similar to pci_irq_vector() and cleanup all open coded
>       variants.
> 
> This second series is based on:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-1
> 
> and also available from git:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-2
> 

Instead of responding to each individual patch, I've read them all,
thanks for the cleanups, look good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
