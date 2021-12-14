Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89744C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 16:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1856B4057B;
	Tue, 14 Dec 2021 16:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xTnRtaPogR1U; Tue, 14 Dec 2021 16:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 314C740560;
	Tue, 14 Dec 2021 16:23:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 031ACC001E;
	Tue, 14 Dec 2021 16:23:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9334FC0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 16:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E0AF4056B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 16:23:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ICjvTP_u4kZ2 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 16:23:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09CC940560
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 16:23:27 +0000 (UTC)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BEGMmuO025468;
 Tue, 14 Dec 2021 10:22:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1639498968;
 bh=j8vcNDlyu6rGGlbNXrHIPndlfNexrjOXKWOfEEIJnnk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xgTGUZkLvFa0MkQp65s/DUVAeZv9Jh6bDvETBxkkXt9kHUJh2S2ely6DWwhAEv7nE
 9sCLwo7TGhPOwJHN4Tpl9RtuWpdVoaxfjasPPolvZWeFEwB03D/XW8/nuRUiuxjvP2
 bQ7FHOHAdSfs79apWvV8d5LiB3urN2udwFKj+JSg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BEGMmM0085080
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Dec 2021 10:22:48 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Dec 2021 10:22:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Dec 2021 10:22:47 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BEGMllf122522;
 Tue, 14 Dec 2021 10:22:47 -0600
Date: Tue, 14 Dec 2021 10:22:47 -0600
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
Message-ID: <20211214162247.ocjm7ihg5oi7uiuv@slider>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator> <87fsqvttfv.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87fsqvttfv.ffs@tglx>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: Mark Rutland <mark.rutland@arm.com>, Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>, Johannes Berg <johannes.berg@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Marc Zygnier <maz@kernel.org>,
 dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

On 10:41-20211214, Thomas Gleixner wrote:
> On Mon, Dec 13 2021 at 12:29, Nishanth Menon wrote:
> > On 23:18-20211210, Thomas Gleixner wrote:
> > Also while testing on TI K3 platforms, I noticed:
> >
> > msi_device_data_release/msi_device_destroy_sysfs in am64xx-evm / j7200
> 
> The warning complains about a device being released with MSI descriptors
> still attached to the device. This was added by:
> 
>   5b012cede0f7 ("device: Add device::msi_data pointer and struct msi_device_data")
> 
> That's not a regression caused by this commit. The warning is just
> exposing an already existing problem in the iwlwifi driver, which seems
> to do:
> 
>    probe()
>      setup_pci_msi[x]_interrupts()
>      start_drv()
>        if (try_to_load_firmware() == FAIL)
>        	   device_release_driver()
>                 ...
>                 msi_device_data_release()
>                     WARN()
> 

Agreed that the warning is fine, the null pointer exception that follows
[1] [2] it however does'nt look right and it can be trivially fixed with the
following fixup for ee90787487bc ("genirq/msi: Provide
msi_device_populate/destroy_sysfs()") below, with that the log looks
like [3] - the warn is good, the null pointer exception and resultant
crash could be avoided (not saying this is the best solution):

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ab5e83f41188..24edb870c66f 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -252,11 +252,14 @@ int msi_device_populate_sysfs(struct device *dev)
  */
 void msi_device_destroy_sysfs(struct device *dev)
 {
-	const struct attribute_group **msi_irq_groups = dev->msi.data->attrs;
+	const struct attribute_group **msi_irq_groups;
 	struct device_attribute *dev_attr;
 	struct attribute **msi_attrs;
 	int count = 0;
 
+	if (!dev->msi.data)
+		return;
+	msi_irq_groups = dev->msi.data->attrs;
 	dev->msi.data->attrs = NULL;
 	if (!msi_irq_groups)
 		return;

[1] https://gist.github.com/nmenon/36899c7819681026cfe1ef185fb95f33#file-am64xx-evm-txt-L1049
[2] https://gist.github.com/nmenon/36899c7819681026cfe1ef185fb95f33#file-j7200-evm-txt-L1111

[3] https://gist.github.com/nmenon/575afe7d04463026a7e420a76c2c1c5b
	https://gist.github.com/nmenon/575afe7d04463026a7e420a76c2c1c5b#file-am64xx-evm-txt-L1018
	https://gist.github.com/nmenon/575afe7d04463026a7e420a76c2c1c5b#file-j7200-evm-txt-L1053
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
