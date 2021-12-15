Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1246BC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 17:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A74E8409AF;
	Wed, 15 Dec 2021 17:46:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hWZsLqHxMTUa; Wed, 15 Dec 2021 17:46:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 451E4402D0;
	Wed, 15 Dec 2021 17:46:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CB34C001E;
	Wed, 15 Dec 2021 17:46:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66019C0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 17:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC4F1400F4
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 17:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YNS_VePV2E0m for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 17:46:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4504A4005C
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 17:46:37 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 21FF8618FF;
 Wed, 15 Dec 2021 17:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC38C36AE0;
 Wed, 15 Dec 2021 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1639590395;
 bh=8eon80aBZeFq23Odf9TNhXLZ0kuufkyxyEQ2UyQvkqg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UkCoNkhqYhaWsFSTKJpb77W8nbK6xBhgXx04HDrtcU3wqKWjQXiGzgyhrmLZyIcpi
 MQjyZk+Z77/94x42VRHSfHDxYxwbhzyU1x8FRVQnYWLIzTIG39Is2wA6fDhqQ2fpqP
 n5B4SefG3RtkmGRq+Q9AMgbeRnK4rPW85FgQYoxs=
Date: Wed, 15 Dec 2021 18:46:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V4 09-01/35] PCI/MSI: Decouple MSI[-X] disable from
 pcim_release()
Message-ID: <Ybop+ZdUQSqGkOxe@kroah.com>
References: <20211210221642.869015045@linutronix.de>
 <20211210221813.740644351@linutronix.de> <87tuf9rdoj.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87tuf9rdoj.ffs@tglx>
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
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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

On Wed, Dec 15, 2021 at 06:16:44PM +0100, Thomas Gleixner wrote:
> The MSI core will introduce runtime allocation of MSI related data. This
> data will be devres managed and has to be set up before enabling
> PCI/MSI[-X]. This would introduce an ordering issue vs. pcim_release().
> 
> The setup order is:
> 
>    pcim_enable_device()
> 	devres_alloc(pcim_release...);
> 	...
> 	pci_irq_alloc()
> 	  msi_setup_device_data()
> 	     devres_alloc(msi_device_data_release, ...)
> 
> and once the device is released these release functions are invoked in the
> opposite order:
> 
>     msi_device_data_release()
>     ...
>     pcim_release()
>        pci_disable_msi[x]()
> 
> which is obviously wrong, because pci_disable_msi[x]() requires the MSI
> data to be available to tear down the MSI[-X] interrupts.
> 
> Remove the MSI[-X] teardown from pcim_release() and add an explicit action
> to be installed on the attempt of enabling PCI/MSI[-X].
> 
> This allows the MSI core data allocation to be ordered correctly in a
> subsequent step.
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V4: New patch


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
