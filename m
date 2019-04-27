Return-Path: <SRS0=j+PZ=S5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA6BC43218
	for <iommu@archiver.kernel.org>; Sat, 27 Apr 2019 07:13:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB46F2067D
	for <iommu@archiver.kernel.org>; Sat, 27 Apr 2019 07:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB46F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8F41C19A8;
	Sat, 27 Apr 2019 07:13:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 72360198C
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 07:10:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 113DD786
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 07:10:42 +0000 (UTC)
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB7272000C5;
	Sat, 27 Apr 2019 09:10:40 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
	[134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D5CE200004;
	Sat, 27 Apr 2019 09:10:40 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net
	(fsr-ub1864-101.ea.freescale.net [10.171.82.13])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 142B3205ED;
	Sat, 27 Apr 2019 09:10:40 +0200 (CEST)
From: laurentiu.tudor@nxp.com
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
	camelia.groza@nxp.com, leoyang.li@nxp.com
Subject: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Date: Sat, 27 Apr 2019 10:10:31 +0300
Message-Id: <20190427071031.6563-10-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
	linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190427071031.H-UtgpnVcn9IAw4qDpYBGCa29_uuGZjdydbv5UIfjzI@z>

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Fix issue with the entry indexing in the sg frame cleanup code being
off-by-1. This problem showed up when doing some basic iperf tests and
manifested in traffic coming to a halt.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index daede7272768..40420edc9ce6 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1663,7 +1663,7 @@ static struct sk_buff *dpaa_cleanup_tx_fd(const struct dpaa_priv *priv,
 				 qm_sg_entry_get_len(&sgt[0]), dma_dir);
 
 		/* remaining pages were mapped with skb_frag_dma_map() */
-		for (i = 1; i < nr_frags; i++) {
+		for (i = 1; i <= nr_frags; i++) {
 			WARN_ON(qm_sg_entry_is_ext(&sgt[i]));
 
 			dma_unmap_page(dev, qm_sg_addr(&sgt[i]),
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
