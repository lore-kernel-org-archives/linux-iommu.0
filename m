Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442F9C433DF
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 07:38:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15EEB206E2
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 07:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EEB206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF84F88166;
	Wed, 24 Jun 2020 07:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p6Bggp0bvxOW; Wed, 24 Jun 2020 07:38:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B4C458815C;
	Wed, 24 Jun 2020 07:38:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92FA5C088E;
	Wed, 24 Jun 2020 07:38:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE8CAC016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 07:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B4BAE88D7C
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 07:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L3O7snwe88ic for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 07:38:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D348088BC3
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 07:38:21 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id BB98368B02; Wed, 24 Jun 2020 09:38:16 +0200 (CEST)
Date: Wed, 24 Jun 2020 09:38:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
Message-ID: <20200624073815.GE18609@lst.de>
References: <20200608132217.29945-1-geert@linux-m68k.org>
 <20200620200936.GA106151@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200620200936.GA106151@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 David Rientjes <rientjes@google.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Guenter,

can you try the patch below?  This just converts the huge allocations
in mptbase to use GFP_KERNEL.  Christophe (added to Cc) actually has
a scripted conversion for the rest that he hasn't posted yet, so I'll
aim for the minimal version here.


diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 68aea22f2b8978..5216487db4fbea 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1324,13 +1324,13 @@ mpt_host_page_alloc(MPT_ADAPTER *ioc, pIOCInit_t ioc_init)
 			return 0; /* fw doesn't need any host buffers */
 
 		/* spin till we get enough memory */
-		while(host_page_buffer_sz > 0) {
-
-			if((ioc->HostPageBuffer = pci_alloc_consistent(
-			    ioc->pcidev,
-			    host_page_buffer_sz,
-			    &ioc->HostPageBuffer_dma)) != NULL) {
-
+		while (host_page_buffer_sz > 0) {
+			ioc->HostPageBuffer =
+				dma_alloc_coherent(&ioc->pcidev->dev,
+						host_page_buffer_sz,
+						&ioc->HostPageBuffer_dma,
+						GFP_KERNEL);
+			if (ioc->HostPageBuffer) {
 				dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT
 				    "host_page_buffer @ %p, dma @ %x, sz=%d bytes\n",
 				    ioc->name, ioc->HostPageBuffer,
@@ -2741,8 +2741,8 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
 		sz = ioc->alloc_sz;
 		dexitprintk(ioc, printk(MYIOC_s_INFO_FMT "free  @ %p, sz=%d bytes\n",
 		    ioc->name, ioc->alloc, ioc->alloc_sz));
-		pci_free_consistent(ioc->pcidev, sz,
-				ioc->alloc, ioc->alloc_dma);
+		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->alloc,
+				ioc->alloc_dma);
 		ioc->reply_frames = NULL;
 		ioc->req_frames = NULL;
 		ioc->alloc = NULL;
@@ -2751,8 +2751,8 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
 
 	if (ioc->sense_buf_pool != NULL) {
 		sz = (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);
-		pci_free_consistent(ioc->pcidev, sz,
-				ioc->sense_buf_pool, ioc->sense_buf_pool_dma);
+		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->sense_buf_pool,
+				ioc->sense_buf_pool_dma);
 		ioc->sense_buf_pool = NULL;
 		ioc->alloc_total -= sz;
 	}
@@ -2802,7 +2802,7 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
 			"HostPageBuffer free  @ %p, sz=%d bytes\n",
 			ioc->name, ioc->HostPageBuffer,
 			ioc->HostPageBuffer_sz));
-		pci_free_consistent(ioc->pcidev, ioc->HostPageBuffer_sz,
+		dma_free_coherent(&ioc->pcidev->dev, ioc->HostPageBuffer_sz,
 		    ioc->HostPageBuffer, ioc->HostPageBuffer_dma);
 		ioc->HostPageBuffer = NULL;
 		ioc->HostPageBuffer_sz = 0;
@@ -4497,7 +4497,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 			 	ioc->name, sz, sz, num_chain));
 
 		total_size += sz;
-		mem = pci_alloc_consistent(ioc->pcidev, total_size, &alloc_dma);
+		mem = dma_alloc_coherent(&ioc->pcidev->dev, total_size,
+				&alloc_dma, GFP_KERNEL);
 		if (mem == NULL) {
 			printk(MYIOC_s_ERR_FMT "Unable to allocate Reply, Request, Chain Buffers!\n",
 				ioc->name);
@@ -4574,8 +4575,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		spin_unlock_irqrestore(&ioc->FreeQlock, flags);
 
 		sz = (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);
-		ioc->sense_buf_pool =
-			pci_alloc_consistent(ioc->pcidev, sz, &ioc->sense_buf_pool_dma);
+		ioc->sense_buf_pool = dma_alloc_coherent(&ioc->pcidev->dev, sz,
+				&ioc->sense_buf_pool_dma, GFP_KERNEL);
 		if (ioc->sense_buf_pool == NULL) {
 			printk(MYIOC_s_ERR_FMT "Unable to allocate Sense Buffers!\n",
 				ioc->name);
@@ -4613,18 +4614,16 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 
 	if (ioc->alloc != NULL) {
 		sz = ioc->alloc_sz;
-		pci_free_consistent(ioc->pcidev,
-				sz,
-				ioc->alloc, ioc->alloc_dma);
+		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->alloc,
+				ioc->alloc_dma);
 		ioc->reply_frames = NULL;
 		ioc->req_frames = NULL;
 		ioc->alloc_total -= sz;
 	}
 	if (ioc->sense_buf_pool != NULL) {
 		sz = (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);
-		pci_free_consistent(ioc->pcidev,
-				sz,
-				ioc->sense_buf_pool, ioc->sense_buf_pool_dma);
+		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->sense_buf_pool,
+				ioc->sense_buf_pool_dma);
 		ioc->sense_buf_pool = NULL;
 	}
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
