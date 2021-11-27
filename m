Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D738C433FE
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 12:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4242D808AB;
	Sat, 27 Nov 2021 12:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LvAPRJtIy8a2; Sat, 27 Nov 2021 12:21:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C63780ACC;
	Sat, 27 Nov 2021 12:21:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91D4BC0030;
	Sat, 27 Nov 2021 12:21:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98205C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 12:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 876E1808AB
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 12:21:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UOXHinMPYdmO for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 12:21:39 +0000 (UTC)
X-Greylist: delayed 00:09:44 by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95E30801E0
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 12:21:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 54151B817B9;
 Sat, 27 Nov 2021 12:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DB7C53FBF;
 Sat, 27 Nov 2021 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1638015110;
 bh=/XPeQ1hFhyBOZd/fOEzJpKNA/3j261q99S9wRv9Ei2c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vJEmWjyfKy/Ykqefyq5ESJyVx4tFUS8o7AaDPBdBP68fLuKNHf42fJrbUbJ4DcVWC
 wtdw1zd30d8uY3crZt8GTJbaP3VXRVKOhuJsD/BEANJ7wuZiJYWl/w2fltiVBxKcHV
 z4HAxvDW7WvmuYc8vd724ImvHTKbnxH/tRBogIHc=
Date: Sat, 27 Nov 2021 13:11:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 01/37] device: Move MSI related data into a struct
Message-ID: <YaIgg0tpnuGG6oda@kroah.com>
References: <20211126224100.303046749@linutronix.de>
 <20211126230523.982881381@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211126230523.982881381@linutronix.de>
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

On Sat, Nov 27, 2021 at 02:20:08AM +0100, Thomas Gleixner wrote:
> The only unconditional part of MSI data in struct device is the irqdomain
> pointer. Everything else can be allocated on demand. Create a data
> structure and move the irqdomain pointer into it. The other MSI specific
> parts are going to be removed from struct device in later steps.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: iommu@lists.linux-foundation.org
> Cc: dmaengine@vger.kernel.org
> ---
>  drivers/base/platform-msi.c                 |   12 ++++++------
>  drivers/dma/ti/k3-udma.c                    |    4 ++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |    2 +-
>  drivers/irqchip/irq-mvebu-icu.c             |    6 +++---
>  drivers/soc/ti/k3-ringacc.c                 |    4 ++--
>  drivers/soc/ti/ti_sci_inta_msi.c            |    2 +-
>  include/linux/device.h                      |   19 +++++++++++++------
>  7 files changed, 28 insertions(+), 21 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
