Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FADC433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 23:48:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258AB64F90
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 23:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258AB64F90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1EF94651F;
	Thu, 11 Mar 2021 23:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SNORWkPTrroB; Thu, 11 Mar 2021 23:48:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1C8A45E00;
	Thu, 11 Mar 2021 23:48:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6020CC000B;
	Thu, 11 Mar 2021 23:48:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97C23C0012
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F67546804
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RgoWoRSXHOy5 for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 23:48:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64A2E45BF2
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=p6LSuxLxIXhW56xVX60ERoOIubTQKg0kFsUTFXBJO+A=; b=KvuTM+MB3gjvIolcULjFn23dNB
 3UTcV/MdnfIXaNhLXS0a6rZH29zcNJFPH69erQKmEMF5Us9dBYKvKT+cwUnXcVVfkHmoSfRX8WPai
 K8M6TbmudsvF4nPi214vAODKBReiwl70HbEUINS//9CLpBrmWytPjko8FzX0jH0oKXnKz6JIpHCnG
 MDZ3uAQYYiD3i8bG4wDYOe1PrAaOL2kYOIuUOoONKVRQOznvCE2vkBlTujANvlJn5HAvzkEV7v7EY
 DAdA+NzNmhMoK6wFXyvdDV9raMZtrodSamhEKKTgZxJGwGLXqT+iYTFkagT3nR+ql1sjAqryz+oId
 4O7xEzbA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lKUmZ-0003er-Rv; Thu, 11 Mar 2021 16:32:15 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lKUmV-00024M-T0; Thu, 11 Mar 2021 16:31:51 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 11 Mar 2021 16:31:31 -0700
Message-Id: <20210311233142.7900-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210311233142.7900-1-logang@deltatee.com>
References: <20210311233142.7900-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, dan.j.williams@intel.com,
 iweiny@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH v2 01/11] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <iweiny@intel.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

In order to call this function from a dma_map function, it must not sleep.
The only reason it does sleep so to allocate the seqbuf to print
which devices are within the ACS path.

Switch the kmalloc call to use a passed in gfp_mask  and don't print that
message if the buffer fails to be allocated.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 196382630363..bd89437faf06 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -267,7 +267,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
 
 static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 {
-	if (!buf)
+	if (!buf || !buf->buffer)
 		return;
 
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
@@ -495,25 +495,26 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 
 static enum pci_p2pdma_map_type
 upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
-			      int *dist)
+			      int *dist, gfp_t gfp_mask)
 {
 	struct seq_buf acs_list;
 	bool acs_redirects;
 	int ret;
 
-	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
-	if (!acs_list.buffer)
-		return -ENOMEM;
+	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, gfp_mask), PAGE_SIZE);
 
 	ret = upstream_bridge_distance(provider, client, dist, &acs_redirects,
 				       &acs_list);
 	if (acs_redirects) {
 		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
 			 pci_name(provider));
-		/* Drop final semicolon */
-		acs_list.buffer[acs_list.len-1] = 0;
-		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
-			 acs_list.buffer);
+
+		if (acs_list.buffer) {
+			/* Drop final semicolon */
+			acs_list.buffer[acs_list.len - 1] = 0;
+			pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
+				 acs_list.buffer);
+		}
 	}
 
 	if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED) {
@@ -566,7 +567,7 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 
 		if (verbose)
 			ret = upstream_bridge_distance_warn(provider,
-					pci_client, &distance);
+					pci_client, &distance, GFP_KERNEL);
 		else
 			ret = upstream_bridge_distance(provider, pci_client,
 						       &distance, NULL, NULL);
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
