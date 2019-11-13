Return-Path: <SRS0=M1C0=ZF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BFEC43331
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 12:24:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CA5222CD
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 12:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D3lCwSqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CA5222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9543D1186;
	Wed, 13 Nov 2019 12:24:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A7EE811A4
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 12:24:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
	(mail-eopbgr00058.outbound.protection.outlook.com [40.107.0.58])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A9FDE82B
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 12:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=JPqrVTqoWRwCk/+hwWC/HCXdi0l4sDJ+lJ/uKkcwEdNqIkr+YZq+Qxmp+eI40GHpD3BrzFNsY3WdnBAZigtBBlwaO+d4Bpcv/33q7XMNaDtnz4AzcCYyoeR8lO8DIBj67R7SFXh96eOHtMdbje69Y2e4lUljta0QbMh5SOhiw4bc+/z7WFCRmvPIZubOTwFCXVjMzzbC+qVFwqzEMNctxs6ftgoK4yPCxuOYYoPnVgQOPGw5XxPuvx+eL6M2CxnAYc684DNvQyMUfW6VA3aajGPyW8fHB8YxrmuIqBRYTjFCPNo3z5talVKZ+3KHEcqZk15K1wqSQySnL/d9sF8HQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=P+vaRnofyPqmOegx40qWQhu07WoA/qgeBw2RKBJeH7E=;
	b=Hr0YsjzHqTtHwPz5weMCJYWrkYwMES/9mjiG3adKu6JcrRWoqeMfInJtupLfIC2pifobmSPT/dMES1VssG4CpHXxk7Knyd9kAxvzE5rTRMH49cNahY5ZU8gTQYXH295TeFXlosh5bQYXAi/j6qU9k4pDBbzkwhSKCnJvLcxyle4WdAbX2J+6pncw5nCQTFA23bL4iKhdB4Q1AzWrWK+ST46wkHEBekvn6X6OMBGIzcG+yxSdiTA9x7mkTyvqAXWwCK4HBhEZww+r7NUNJGzv18BOLQxt8JcbLgjVpn45zVTJ/skt4OaS7XR7Czb5AVkiMd5H46NBC/EkEynzW/3jnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com;
	dkim=pass header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=P+vaRnofyPqmOegx40qWQhu07WoA/qgeBw2RKBJeH7E=;
	b=D3lCwSqQAb0wZsUIIkVekjWmORagiTx6m3dl/N6ELrcFI1R9Y6ntN3/MZ3IBCtEJJGmCs1JaK141DsRTGeus3uQhSgwz9yWbFY0Dwqc5y0kruDw6nOg0U4G86BwBaPrX0WcRxvUO+88/RYhN4XNDxcIhHEqUXxx4GO0ZbFTO1sQ=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.51.208) by
	VI1PR04MB6142.eurprd04.prod.outlook.com (20.179.27.138) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2430.25; Wed, 13 Nov 2019 12:24:24 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::71d2:55b3:810d:c75b]) by
	VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::71d2:55b3:810d:c75b%7]) with mapi id 15.20.2451.023;
	Wed, 13 Nov 2019 12:24:24 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: "hch@lst.de" <hch@lst.de>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"joro@8bytes.org" <joro@8bytes.org>, Ioana Ciocoi Radulescu
	<ruxandra.radulescu@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 4/4] dpaa2_eth: use new unmap and sync dma api variants
Thread-Topic: [PATCH v3 4/4] dpaa2_eth: use new unmap and sync dma api variants
Thread-Index: AQHVmh1JgfD4RpohtUqf48sTd7I87w==
Date: Wed, 13 Nov 2019 12:24:24 +0000
Message-ID: <20191113122407.1171-5-laurentiu.tudor@nxp.com>
References: <20191113122407.1171-1-laurentiu.tudor@nxp.com>
In-Reply-To: <20191113122407.1171-1-laurentiu.tudor@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0008.eurprd02.prod.outlook.com
	(2603:10a6:208:3e::21) To VI1PR04MB5134.eurprd04.prod.outlook.com
	(2603:10a6:803:5f::16)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6168649c-f078-487f-b96e-08d768346b5e
x-ms-traffictypediagnostic: VI1PR04MB6142:|VI1PR04MB6142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB61421E49190338F9757E0D14EC760@VI1PR04MB6142.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(189003)(199004)(6486002)(66066001)(486006)(446003)(110136005)(86362001)(6436002)(44832011)(5660300002)(54906003)(2906002)(305945005)(476003)(14454004)(2201001)(6512007)(186003)(3846002)(11346002)(316002)(6116002)(66946007)(2616005)(7736002)(256004)(14444005)(66556008)(66446008)(99286004)(52116002)(76176011)(6636002)(36756003)(64756008)(25786009)(2501003)(386003)(71190400001)(6506007)(478600001)(1076003)(8936002)(71200400001)(26005)(50226002)(102836004)(81156014)(81166006)(4326008)(66476007)(8676002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6142;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUCNPXAPdEJCJ+lPN70DLFOoCL+0oPDPKwNpHHJ90fBQLzfWOI5xieB29ekIsnUQKkVHX7lETKs2+rNRuoqW4rRih+rIKd0lBpTwdTu3W4yl4DjEKm3gca3mMBhO5LqY2x4Oo7aC9jbbLKY2U+FuUA8tIQ/+RV7+oyZUaTfxZM581e4bin1QANMjsdmHtDBUr0sGCXs9Y5PGEKLa8Iu7dS9EMIbmcBJ6pK78HpZeJFV+ApKh5rUWBNnbLA+3BMQe9uecm0oCuuKovqgLdEnVcqpXMcQs/iCuT8dhiC+cqSDyHL1/xjyMnIp4GUY/1wngRCa3Imq9gLZwgVRRJ7tRxBYD/djEzlRUEAVxwXJYtoj9ahNDuvBSEbUQxN5qbfwGUlrUnnWIfQ9t/ya80OcgvV96+IbN4VionMo0pZg85kP7DBQXfcM4m9QImL1Bd5kF
Content-ID: <3D1B4AA2386E4A4192091C84DA8A635F@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6168649c-f078-487f-b96e-08d768346b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:24:24.8196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGcX8Bne2FcSZSvqS7FIaELmFRcjHreqFBpRqNZcrStg+cXdUORURBEHvP/TAG0QliSoqnr1kmVtE5XwxaIPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6142
Cc: Madalin Bucur <madalin.bucur@nxp.com>, Leo Li <leoyang.li@nxp.com>,
	Camelia Alexandra Groza <camelia.groza@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Convert this driver to usage of the newly introduced dma unmap and
sync DMA APIs. This will get rid of the unsupported direct usage of
iommu_iova_to_phys() API.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 43 ++++++++-----------
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.h  |  1 -
 2 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 19379bae0144..6b941b753106 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -29,16 +29,6 @@ MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Freescale Semiconductor, Inc");
 MODULE_DESCRIPTION("Freescale DPAA2 Ethernet Driver");
 
-static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
-				dma_addr_t iova_addr)
-{
-	phys_addr_t phys_addr;
-
-	phys_addr = domain ? iommu_iova_to_phys(domain, iova_addr) : iova_addr;
-
-	return phys_to_virt(phys_addr);
-}
-
 static void validate_rx_csum(struct dpaa2_eth_priv *priv,
 			     u32 fd_status,
 			     struct sk_buff *skb)
@@ -85,9 +75,9 @@ static void free_rx_fd(struct dpaa2_eth_priv *priv,
 	sgt = vaddr + dpaa2_fd_get_offset(fd);
 	for (i = 1; i < DPAA2_ETH_MAX_SG_ENTRIES; i++) {
 		addr = dpaa2_sg_get_addr(&sgt[i]);
-		sg_vaddr = dpaa2_iova_to_virt(priv->iommu_domain, addr);
-		dma_unmap_page(dev, addr, DPAA2_ETH_RX_BUF_SIZE,
-			       DMA_BIDIRECTIONAL);
+		sg_vaddr = dma_unmap_single_desc(dev, addr,
+						 DPAA2_ETH_RX_BUF_SIZE,
+						 DMA_BIDIRECTIONAL);
 
 		free_pages((unsigned long)sg_vaddr, 0);
 		if (dpaa2_sg_is_final(&sgt[i]))
@@ -143,9 +133,9 @@ static struct sk_buff *build_frag_skb(struct dpaa2_eth_priv *priv,
 
 		/* Get the address and length from the S/G entry */
 		sg_addr = dpaa2_sg_get_addr(sge);
-		sg_vaddr = dpaa2_iova_to_virt(priv->iommu_domain, sg_addr);
-		dma_unmap_page(dev, sg_addr, DPAA2_ETH_RX_BUF_SIZE,
-			       DMA_BIDIRECTIONAL);
+		sg_vaddr = dma_unmap_single_desc(dev, sg_addr,
+						 DPAA2_ETH_RX_BUF_SIZE,
+						 DMA_BIDIRECTIONAL);
 
 		sg_length = dpaa2_sg_get_len(sge);
 
@@ -210,9 +200,9 @@ static void free_bufs(struct dpaa2_eth_priv *priv, u64 *buf_array, int count)
 	int i;
 
 	for (i = 0; i < count; i++) {
-		vaddr = dpaa2_iova_to_virt(priv->iommu_domain, buf_array[i]);
-		dma_unmap_page(dev, buf_array[i], DPAA2_ETH_RX_BUF_SIZE,
-			       DMA_BIDIRECTIONAL);
+		vaddr = dma_unmap_single_desc(dev, buf_array[i],
+					      DPAA2_ETH_RX_BUF_SIZE,
+					      DMA_BIDIRECTIONAL);
 		free_pages((unsigned long)vaddr, 0);
 	}
 }
@@ -369,9 +359,8 @@ static void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 	/* Tracing point */
 	trace_dpaa2_rx_fd(priv->net_dev, fd);
 
-	vaddr = dpaa2_iova_to_virt(priv->iommu_domain, addr);
-	dma_sync_single_for_cpu(dev, addr, DPAA2_ETH_RX_BUF_SIZE,
-				DMA_BIDIRECTIONAL);
+	vaddr = dma_sync_single_for_cpu_desc(dev, addr, DPAA2_ETH_RX_BUF_SIZE,
+					     DMA_BIDIRECTIONAL);
 
 	fas = dpaa2_get_fas(vaddr, false);
 	prefetch(fas);
@@ -682,7 +671,8 @@ static void free_tx_fd(const struct dpaa2_eth_priv *priv,
 	u32 fd_len = dpaa2_fd_get_len(fd);
 
 	fd_addr = dpaa2_fd_get_addr(fd);
-	buffer_start = dpaa2_iova_to_virt(priv->iommu_domain, fd_addr);
+	buffer_start = dma_sync_single_for_cpu_desc(dev, fd_addr, sizeof(*swa),
+						    DMA_BIDIRECTIONAL);
 	swa = (struct dpaa2_eth_swa *)buffer_start;
 
 	if (fd_format == dpaa2_fd_single) {
@@ -3435,6 +3425,11 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 
 	dev = &dpni_dev->dev;
 
+	if (!dma_can_unmap_by_dma_addr(dev)) {
+		dev_err(dev, "required dma unmap/sync APIs not available\n");
+		return -ENOTSUPP;
+	}
+
 	/* Net device */
 	net_dev = alloc_etherdev_mq(sizeof(*priv), DPAA2_ETH_MAX_NETDEV_QUEUES);
 	if (!net_dev) {
@@ -3448,8 +3443,6 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	priv = netdev_priv(net_dev);
 	priv->net_dev = net_dev;
 
-	priv->iommu_domain = iommu_get_domain_for_dev(dev);
-
 	/* Obtain a MC portal */
 	err = fsl_mc_portal_allocate(dpni_dev, FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
 				     &priv->mc_io);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
index 8a0e65b3267f..4e5183617ebd 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
@@ -374,7 +374,6 @@ struct dpaa2_eth_priv {
 
 	struct fsl_mc_device *dpbp_dev;
 	u16 bpid;
-	struct iommu_domain *iommu_domain;
 
 	bool tx_tstamp; /* Tx timestamping enabled */
 	bool rx_tstamp; /* Rx timestamping enabled */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
