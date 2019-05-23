Return-Path: <SRS0=aUVl=TX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98F5C282DD
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 22:31:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A3820879
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 22:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A3820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 483CD102D;
	Thu, 23 May 2019 22:31:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1A15BF2B
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 22:31:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CB2CA875
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 22:31:09 +0000 (UTC)
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <gunthorp@deltatee.com>)
	id 1hTwEs-00062P-Ev; Thu, 23 May 2019 16:31:09 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
	(envelope-from <gunthorp@deltatee.com>)
	id 1hTwEp-0001S8-Tc; Thu, 23 May 2019 16:31:03 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Joerg Roedel <joro@8bytes.org>
Date: Thu, 23 May 2019 16:30:53 -0600
Message-Id: <20190523223100.5526-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523223100.5526-1-logang@deltatee.com>
References: <20190523223100.5526-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, jdmason@kudzu.us,
	joro@8bytes.org, bhelgaas@google.com, dave.jiang@intel.com,
	allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com,
	logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 03/10] NTB: Introduce helper functions to calculate logical
	port number
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>
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

This patch introduces the "Logical Port Number" which is similar to the
"Port Number" in that it enumerates the ports in the system.

The original (or Physical) "Port Number" can be any number used by the
hardware to uniquely identify a port in the system. The "Logical Port
Number" enumerates all ports in the system from 0 to the number of
ports minus one.

For example a system with 5 ports might have the following port numbers
which would be enumerated thusly:

Port Number:           1  2  5  7  116
Logical Port Number:   0  1  2  3  4

The logical port number is useful when calculating which resources
to use for which peers. So we thus define two helper functions:
ntb_logical_port_number() and ntb_peer_logical_port_number() which
provide the "Logical Port Number" for the local port and any peer
respectively.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>
---
 include/linux/ntb.h | 53 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 56a92e3ae3ae..91cf492b16a0 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -616,7 +616,6 @@ static inline int ntb_port_number(struct ntb_dev *ntb)
 
 	return ntb->ops->port_number(ntb);
 }
-
 /**
  * ntb_peer_port_count() - get the number of peer device ports
  * @ntb:	NTB device context.
@@ -653,6 +652,58 @@ static inline int ntb_peer_port_number(struct ntb_dev *ntb, int pidx)
 	return ntb->ops->peer_port_number(ntb, pidx);
 }
 
+/**
+ * ntb_logical_port_number() - get the logical port number of the local port
+ * @ntb:	NTB device context.
+ *
+ * The Logical Port Number is defined to be a unique number for each
+ * port starting from zero through to the number of ports minus one.
+ * This is in contrast to the Port Number where each port can be assigned
+ * any unique physical number by the hardware.
+ *
+ * The logical port number is useful for calculating the resource indexes
+ * used by peers.
+ *
+ * Return: the logical port number or negative value indicating an error
+ */
+static inline int ntb_logical_port_number(struct ntb_dev *ntb)
+{
+	int lport = ntb_port_number(ntb);
+	int pidx;
+
+	if (lport < 0)
+		return lport;
+
+	for (pidx = 0; pidx < ntb_peer_port_count(ntb); pidx++)
+		if (lport <= ntb_peer_port_number(ntb, pidx))
+			return pidx;
+
+	return pidx;
+}
+
+/**
+ * ntb_peer_logical_port_number() - get the logical peer port by given index
+ * @ntb:	NTB device context.
+ * @pidx:	Peer port index.
+ *
+ * The Logical Port Number is defined to be a unique number for each
+ * port starting from zero through to the number of ports minus one.
+ * This is in contrast to the Port Number where each port can be assigned
+ * any unique physical number by the hardware.
+ *
+ * The logical port number is useful for calculating the resource indexes
+ * used by peers.
+ *
+ * Return: the peer's logical port number or negative value indicating an error
+ */
+static inline int ntb_peer_logical_port_number(struct ntb_dev *ntb, int pidx)
+{
+	if (ntb_peer_port_number(ntb, pidx) < ntb_port_number(ntb))
+		return pidx;
+	else
+		return pidx + 1;
+}
+
 /**
  * ntb_peer_port_idx() - get the peer device port index by given port number
  * @ntb:	NTB device context.
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
