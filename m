Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39FEC433FE
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 18:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9691A40217;
	Mon, 13 Dec 2021 18:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7DSmTCT8SwmM; Mon, 13 Dec 2021 18:33:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 88983408A2;
	Mon, 13 Dec 2021 18:33:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA3CBC0012;
	Mon, 13 Dec 2021 18:33:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A0E7C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 18:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AC6660B2A
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 18:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ti.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qpvxfHyavDLc for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 18:30:49 +0000 (UTC)
X-Greylist: delayed 00:33:15 by SQLgrey-1.8.0
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 265D660B29
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 18:30:48 +0000 (UTC)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BDITweD032784;
 Mon, 13 Dec 2021 12:29:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1639420199;
 bh=CIwJXsDVc6MpWMxloZbtRdlpLw1Ztan/9G2UzPwMY0E=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=aQr+rT7AbNmri1BYm4glcZYUB4D0/LtbXNn0eGzLe1Xq4LgTziMH/fZw9NMlUSxOJ
 eUvgRnz/JUOtWmI/LUlydZmqlDtGvShVqc/335BSewifnzHFovUoMb7LUYizCR9g/k
 /rYDbql0vQTQMlM2Nnxl+1kL4PPvB9mCQmf5UIQI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BDITwlR038320
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Dec 2021 12:29:58 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 13
 Dec 2021 12:29:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 13 Dec 2021 12:29:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BDITwZX089938;
 Mon, 13 Dec 2021 12:29:58 -0600
Date: Mon, 13 Dec 2021 12:29:58 -0600
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
Message-ID: <20211213182958.ytj4m6gsg35u77cv@detonator>
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211210221642.869015045@linutronix.de>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 13 Dec 2021 18:33:25 +0000
Cc: Mark Rutland <mark.rutland@arm.com>, Stuart Yoder <stuyoder@gmail.com>,
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
From: Nishanth Menon via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 23:18-20211210, Thomas Gleixner wrote:
[...]

> 
> It's also available from git:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v3-part-2

[...]

> ---
>  drivers/dma/ti/k3-udma-private.c                    |    6 
>  drivers/dma/ti/k3-udma.c                            |   14 -
>  drivers/irqchip/irq-ti-sci-inta.c                   |    2 
>  drivers/soc/ti/k3-ringacc.c                         |    6 
>  drivers/soc/ti/ti_sci_inta_msi.c                    |   22 --
>  include/linux/soc/ti/ti_sci_inta_msi.h              |    1 

Also while testing on TI K3 platforms, I noticed:

msi_device_data_release/msi_device_destroy_sysfs in am64xx-evm / j7200
[1] https://gist.github.com/nmenon/36899c7819681026cfe1ef185fb95f33#file-am64xx-evm-txt-L1018
[2] https://gist.github.com/nmenon/36899c7819681026cfe1ef185fb95f33#file-j7200-evm-txt-L1076

Which is not present in vanilla v5.16-rc4

v5.16-rc4:
https://gist.github.com/nmenon/1aee3f0a7da47d5e9dcb7336b32a70cb

msi-v3-part-2:
https://gist.github.com/nmenon/36899c7819681026cfe1ef185fb95f33

(.config https://gist.github.com/nmenon/ec6f95303828abf16a64022d8e3a269f)

Vs:
next-20211208:
https://gist.github.com/nmenon/f5ca3558bd5c1fbe62dc5ceb420b536e

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
