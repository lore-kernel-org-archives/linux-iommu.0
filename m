Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D020C43460
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216C061354
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216C061354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A87964041D;
	Thu, 13 May 2021 22:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ci9JHMK_L98; Thu, 13 May 2021 22:32:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 534E240421;
	Thu, 13 May 2021 22:32:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22B9BC002B;
	Thu, 13 May 2021 22:32:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 659DAC000D
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FCD183C0F
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EoRdkMKpiBzq for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 22:32:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9BB683C08
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=DGEbO1eDsmi+omtiZtoL8bN3wHWEYyZxOXmeMgj8t5E=; b=YeD+bra3l3uIf07AwPoKcCDa4Z
 JfnhnF/wgBgfdJ84A3ZDSr+qlE7cCVn2z0uGxlci+fWP7OKTeWw3/yzUEp1ZhC2t9KgFJ0qYmkNKd
 FH9FUq94L7wlEqzzOlnpClMKI2U7IpxFXwQVaGzI7Khfkt9nzLl+RSS8QHlF8nglOnJrADHtYn1Zv
 cIzkZK72rbD+ve6pt291ikLf40mIxO2vGdumHGtH3Ykc+TyNm2TafzntSERgJ2bbZ8OQIDciQWDfg
 QB60+m/XtVqPSUGx7WKmh8O/rFhKxYTYKSdWAyWvClIyOO1Sz74t2kBUCAMGdulRNKr8U11s9LDND
 bDQMd57g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsL-0000nC-QQ; Thu, 13 May 2021 16:32:14 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsF-0001SV-Pg; Thu, 13 May 2021 16:32:07 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 13 May 2021 16:31:42 -0600
Message-Id: <20210513223203.5542-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 01/22] PCI/P2PDMA: Rename upstream_bridge_distance() and
 rework documentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
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

The function upstream_bridge_distance() has evolved such that it's name
is no longer entirely reflective of what the function does.

The function not only calculates the distance between two peers but also
calculates how the DMA addresses for those two peers should be mapped.

Thus, rename the function to calc_map_type_and_dist() and rework the
documentation some to better describe the two pieces of information
the function returns.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 63 ++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 196382630363..6f90e9812f6e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -354,7 +354,7 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
 }
 
 static enum pci_p2pdma_map_type
-__upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
+__calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
 {
 	struct pci_dev *a = provider, *b = client, *bb;
@@ -433,17 +433,18 @@ static unsigned long map_types_idx(struct pci_dev *client)
 }
 
 /*
- * Find the distance through the nearest common upstream bridge between
- * two PCI devices.
+ * Calculate the P2PDMA mapping type and distance between two PCI devices.
  *
- * If the two devices are the same device then 0 will be returned.
+ * If the two devices are the same device then PCI_P2PDMA_MAP_BUS_ADDR
+ * and a distance of 0 will be returned.
  *
  * If there are two virtual functions of the same device behind the same
- * bridge port then 2 will be returned (one step down to the PCIe switch,
- * then one step back to the same device).
+ * bridge port then PCI_P2PDMA_MAP_BUS_ADDR and a distance of 2 will be
+ * returned (one step down to the PCIe switch, then one step back to the
+ * same device).
  *
  * In the case where two devices are connected to the same PCIe switch, the
- * value 4 will be returned. This corresponds to the following PCI tree:
+ * distance of 4 will be returned. This corresponds to the following PCI tree:
  *
  *     -+  Root Port
  *      \+ Switch Upstream Port
@@ -454,31 +455,31 @@ static unsigned long map_types_idx(struct pci_dev *client)
  *
  * The distance is 4 because we traverse from Device A through the downstream
  * port of the switch, to the common upstream port, back up to the second
- * downstream port and then to Device B.
- *
- * Any two devices that cannot communicate using p2pdma will return
- * PCI_P2PDMA_MAP_NOT_SUPPORTED.
+ * downstream port and then to Device B. The mapping type returned will depend
+ * on the ACS redirection setting of the bridges along the path. If ACS
+ * redirect is set on any bridge port in the path then the TLPs will go through
+ * the host bridge. Otherwise PCI_P2PDMA_MAP_BUS_ADDR is returned.
  *
  * Any two devices that have a data path that goes through the host bridge
- * will consult a whitelist. If the host bridges are on the whitelist,
- * this function will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE.
- *
- * If either bridge is not on the whitelist this function returns
- * PCI_P2PDMA_MAP_NOT_SUPPORTED.
+ * will consult a whitelist. If the host bridge is in the whitelist,
+ * this function will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE with the
+ * distance set to the number of ports per above. If the device is not
+ * in the whitelist the type will be returned PCI_P2PDMA_MAP_NOT_SUPPORTED.
  *
- * If a bridge which has any ACS redirection bits set is in the path,
- * acs_redirects will be set to true. In this case, a list of all infringing
- * bridge addresses will be populated in acs_list (assuming it's non-null)
- * for printk purposes.
+ * If any ACS redirect bits are set, then the acs_redirects boolean will be
+ * set to true and their pci device name will be appended to the acs_list
+ * seq_buf. This seq_buf is used to print a warning informing the user
+ * how to disable ACS using a command line parameter.
+ * (See calc_map_type_and_dist_warn() below)
  */
 static enum pci_p2pdma_map_type
-upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
+calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
 {
 	enum pci_p2pdma_map_type map_type;
 
-	map_type = __upstream_bridge_distance(provider, client, dist,
-					      acs_redirects, acs_list);
+	map_type = __calc_map_type_and_dist(provider, client, dist,
+					    acs_redirects, acs_list);
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
 		if (!cpu_supports_p2pdma() &&
@@ -494,8 +495,8 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 }
 
 static enum pci_p2pdma_map_type
-upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
-			      int *dist)
+calc_map_type_and_dist_warn(struct pci_dev *provider, struct pci_dev *client,
+			    int *dist)
 {
 	struct seq_buf acs_list;
 	bool acs_redirects;
@@ -505,8 +506,8 @@ upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
 	if (!acs_list.buffer)
 		return -ENOMEM;
 
-	ret = upstream_bridge_distance(provider, client, dist, &acs_redirects,
-				       &acs_list);
+	ret = calc_map_type_and_dist(provider, client, dist, &acs_redirects,
+				     &acs_list);
 	if (acs_redirects) {
 		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
 			 pci_name(provider));
@@ -565,11 +566,11 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 		}
 
 		if (verbose)
-			ret = upstream_bridge_distance_warn(provider,
-					pci_client, &distance);
+			ret = calc_map_type_and_dist_warn(provider, pci_client,
+							  &distance);
 		else
-			ret = upstream_bridge_distance(provider, pci_client,
-						       &distance, NULL, NULL);
+			ret = calc_map_type_and_dist(provider, pci_client,
+						     &distance, NULL, NULL);
 
 		pci_dev_put(pci_client);
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
