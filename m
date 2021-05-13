Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C56C2BCF8
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2967B61442
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2967B61442
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F018240419;
	Thu, 13 May 2021 22:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6SOxDKhhbp5i; Thu, 13 May 2021 22:32:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBBB64041D;
	Thu, 13 May 2021 22:32:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E80BC0027;
	Thu, 13 May 2021 22:32:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41EA6C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2326140436
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K1thNK9f_3zl for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 22:32:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59FE440425
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=hPXhcihXAoH8RGaPYoi+qDN3LVubyQfJAgOHoQY58UM=; b=AJLAGCyL3f4e5xzFbUQ1yVN3cU
 cfpilAC8VhbDKR/rU1qGZpfArLVz5bmlSiNDtkd9Rd8yH0+gfwKMVE80p9zm5420S5vX4IJvKZ6j/
 T2TwuNQpSwbVaD8vI4CePH2nNGQsM0SbEeTBtaU9GwmpHvDHRX3pug4qLd3rpAdbY5agFTV1UO9Iq
 8xOs+p+PX8CFAJ8wtQnJ5SXl0GGWAh+NQiysec3JJ0JzBppU3VYYCchvsyhROMI4sovCFKTEL2biO
 29H9YJoEh5bn7UTnpiUzssbA/UMM9v1OeaKmCk90ULINe+TO62pIjvtvLHXrnmcB2t2q+61rYbfzD
 8MUkVIkw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsZ-0000nF-AO; Thu, 13 May 2021 16:32:27 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsG-0001Sh-AJ; Thu, 13 May 2021 16:32:08 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 13 May 2021 16:31:46 -0600
Message-Id: <20210513223203.5542-6-logang@deltatee.com>
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
Subject: [PATCH v2 05/22] PCI/P2PDMA: Print a warning if the host bridge is
 not in the whitelist
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

If the host bridge is not in the whitelist print a warning in the
calc_map_type_and_dist_warn() path detailing the vendor and device IDs
that would need to be added to the whitelist.

Suggested-by: Don Dutile <ddutile@redhat.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 175da3a9c8fb..0e0b2218eacd 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -340,7 +340,7 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 }
 
 static bool __host_bridge_whitelist(struct pci_host_bridge *host,
-				    bool same_host_bridge)
+				    bool same_host_bridge, bool warn)
 {
 	struct pci_dev *root = pci_host_bridge_dev(host);
 	const struct pci_p2pdma_whitelist_entry *entry;
@@ -361,6 +361,10 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 		return true;
 	}
 
+	if (warn)
+		pci_warn(root, "Host bridge not in P2PDMA whitelist: %04x:%04x\n",
+			 vendor, device);
+
 	return false;
 }
 
@@ -368,16 +372,17 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
  * If we can't find a common upstream bridge take a look at the root
  * complex and compare it to a whitelist of known good hardware.
  */
-static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
+static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b,
+				  bool warn)
 {
 	struct pci_host_bridge *host_a = pci_find_host_bridge(a->bus);
 	struct pci_host_bridge *host_b = pci_find_host_bridge(b->bus);
 
 	if (host_a == host_b)
-		return __host_bridge_whitelist(host_a, true);
+		return __host_bridge_whitelist(host_a, true, warn);
 
-	if (__host_bridge_whitelist(host_a, false) &&
-	    __host_bridge_whitelist(host_b, false))
+	if (__host_bridge_whitelist(host_a, false, warn) &&
+	    __host_bridge_whitelist(host_b, false, warn))
 		return true;
 
 	return false;
@@ -513,7 +518,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
 		if (!cpu_supports_p2pdma() &&
-		    !host_bridge_whitelist(provider, client))
+		    !host_bridge_whitelist(provider, client, acs_redirects))
 			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
