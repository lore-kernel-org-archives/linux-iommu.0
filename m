Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF8C04AB4
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 13:15:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A0F20856
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 13:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A0F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 59B69C3E;
	Tue, 21 May 2019 13:15:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AB191C03
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 13:15:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5A05287A
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 13:15:27 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 4C85168AFE; Tue, 21 May 2019 15:15:04 +0200 (CEST)
Date: Tue, 21 May 2019 15:15:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/2] dma-mapping: truncate dma masks to what dma_addr_t
	can hold
Message-ID: <20190521131503.GA5258@lst.de>
References: <20190521124729.23559-1-hch@lst.de>
	<20190521124729.23559-2-hch@lst.de>
	<20190521130436.bgt53bf7nshz62ip@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190521130436.bgt53bf7nshz62ip@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, May 21, 2019 at 02:04:37PM +0100, Russell King - ARM Linux admin wrote:
> So how does the driver negotiation for >32bit addresses work if we don't
> fail for large masks?
> 
> I'm thinking about all those PCI drivers that need DAC cycles for >32bit
> addresses, such as e1000, which negotiate via (eg):
> 
>         /* there is a workaround being applied below that limits
>          * 64-bit DMA addresses to 64-bit hardware.  There are some
>          * 32-bit adapters that Tx hang when given 64-bit DMA addresses
>          */
>         pci_using_dac = 0;
>         if ((hw->bus_type == e1000_bus_type_pcix) &&
>             !dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
>                 pci_using_dac = 1;
>         } else {
>                 err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>                 if (err) {
>                         pr_err("No usable DMA config, aborting\n");
>                         goto err_dma;
>                 }
>         }
> 
> and similar.  If we blindly trunate the 64-bit to 32-bit, aren't we
> going to end up with PCI cards using DAC cycles to a host bridge that
> do not support DAC cycles?

In general PCI devices just use DAC cycles when they need it.  I only
know of about a handful of devices that need to negotiate their
addressing mode, and those already use the proper API for that, which
is dma_get_required_mask.

The e1000 example is a good case of how the old API confused people.
First it only sets the 64-bit mask for devices which can support it,
which is good, but then it sets the NETIF_F_HIGHDMA flag only if we
set a 64-bit mask, which is completely unrelated to the DMA mask,
it just means the driver can handle sk_buff fragments that do not
have a kernel mapping, which really is a driver and not a hardware
issue.

So what this driver really should do is something like:


diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 551de8c2fef2..d9236083da94 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -925,7 +925,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	static int cards_found;
 	static int global_quad_port_a; /* global ksp3 port a indication */
-	int i, err, pci_using_dac;
+	int i, err;
 	u16 eeprom_data = 0;
 	u16 tmp = 0;
 	u16 eeprom_apme_mask = E1000_EEPROM_APME;
@@ -996,16 +996,11 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * 64-bit DMA addresses to 64-bit hardware.  There are some
 	 * 32-bit adapters that Tx hang when given 64-bit DMA addresses
 	 */
-	pci_using_dac = 0;
-	if ((hw->bus_type == e1000_bus_type_pcix) &&
-	    !dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
-		pci_using_dac = 1;
-	} else {
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			pr_err("No usable DMA config, aborting\n");
-			goto err_dma;
-		}
+	err = dma_set_mask_and_coherent(&pdev->dev,
+		DMA_BIT_MASK(hw->bus_type == e1000_bus_type_pcix ? 64 : 32));
+	if (err) {
+		pr_err("No usable DMA config, aborting\n");
+		goto err_dma;
 	}
 
 	netdev->netdev_ops = &e1000_netdev_ops;
@@ -1047,19 +1042,15 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 
-	netdev->features |= netdev->hw_features;
+	netdev->features |= netdev->hw_features | NETIF_F_HIGHDMA;
 	netdev->hw_features |= (NETIF_F_RXCSUM |
 				NETIF_F_RXALL |
 				NETIF_F_RXFCS);
 
-	if (pci_using_dac) {
-		netdev->features |= NETIF_F_HIGHDMA;
-		netdev->vlan_features |= NETIF_F_HIGHDMA;
-	}
-
 	netdev->vlan_features |= (NETIF_F_TSO |
 				  NETIF_F_HW_CSUM |
-				  NETIF_F_SG);
+				  NETIF_F_SG |
+				  NETIF_F_HIGHDMA);
 
 	/* Do not set IFF_UNICAST_FLT for VMWare's 82545EM */
 	if (hw->device_id != E1000_DEV_ID_82545EM_COPPER ||

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
