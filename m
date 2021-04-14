Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC1C46461
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9D0611EE
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9D0611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7A34401AE;
	Wed, 14 Apr 2021 14:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RQdtTsdQErSk; Wed, 14 Apr 2021 14:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AF8640185;
	Wed, 14 Apr 2021 14:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 474BEC0014;
	Wed, 14 Apr 2021 14:50:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BD3FC000B
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15877607BD
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ko0ncUm1smlD for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:50:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D7B8607CA
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:35 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id r13so6609067pjf.2
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rEnojfxzKMIKinSbA6nTujnDRb/izr87Op+NW+5m2CE=;
 b=o/koGepbeM26DluIG2Fi9arPS0eBN/lI4S0aDxn3Xk9LzgaVt6M7oJgL5HXo7UWY41
 pbvQM7udAhKMXg/b1zc4VAc50+yOXH3kPlRulsY7eIuVt3ETUFqssKsQPT64CndQo7uX
 K5kByBP3DsifozzJLYCf3UXuTBfEx+iYDrIIK070FEErgIte1KuXT3IlsUs9ovAEV2Mb
 ro8JRMoBHlZnOio/fG9AIqPzZkHsEx9ZOMT8aYJ6FeP1dFo124kw6eCzR9iBLLydqRmw
 SYu7YIoO8ykwu9slOG50CLRu8T5SbbBLLwkws+qpqpC5VBap8oYs4XoOX4/RBZFAhi8w
 sQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rEnojfxzKMIKinSbA6nTujnDRb/izr87Op+NW+5m2CE=;
 b=EDby69rIkMxqTTv1/oJAUpmSWMsQMB7eItVXiVCnAsWxeUlfGJpMXwb/lzUC5OKxYY
 zocDBu/oPqQNdj4OXsymwJjMKE/jjdR6vOpZi3c2RiSrYbUb3uvgULsGRgSDTJ+LDjUV
 aGrKyi5HMJ0HXLBBfpdRTRuE3lFjUN9G9LC4WCMQi4RDZNTZYvIPKBNVh8aHq+0Vg4US
 4Ot1wwgmvH6P7OMCWKeYhnQ8fH+hazz73+WLJjN6ELDUvl3NnHxcgpTfUJC8aVWkTU+z
 pbVC9fpJ/Xad/w6G7vRvo8Y/z5dCZr15KJomxAy6QNn/JKJLAHvRpKce5JKBA/rvRYSL
 EyzQ==
X-Gm-Message-State: AOAM533wq2sO6xHoRKk6YRj7TaGzQMFTAtheAyYMX1nQqGDCfvyiN+Hc
 1Oz5NDp1JHhu7eI/fw6awcg=
X-Google-Smtp-Source: ABdhPJymBmW993DhTofbaszulRmUAiPb/+8poEshIM9VBunj5uilMiDDp5eNxLDJEiVrIn8kvigDbg==
X-Received: by 2002:a17:90a:528b:: with SMTP id
 w11mr4092618pjh.162.1618411834737; 
 Wed, 14 Apr 2021 07:50:34 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:35:ebad:12c1:f579:e332])
 by smtp.gmail.com with ESMTPSA id w67sm17732522pgb.87.2021.04.14.07.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 07:50:34 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Subject: [Resend RFC PATCH V2 11/12] HV/Netvsc: Add Isolation VM support for
 netvsc driver
Date: Wed, 14 Apr 2021 10:49:44 -0400
Message-Id: <20210414144945.3460554-12-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414144945.3460554-1-ltykernel@gmail.com>
References: <20210414144945.3460554-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 sunilmut@microsoft.com
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

In Isolation VM, all shared memory with host needs to mark visible
to host via hvcall. vmbus_establish_gpadl() has already done it for
netvsc rx/tx ring buffer. The page buffer used by vmbus_sendpacket_
pagebuffer() still need to handle. Use DMA API to map/umap these
memory during sending/receiving packet and Hyper-V DMA ops callback
will use swiotlb fucntion to allocate bounce buffer and copy data
from/to bounce buffer.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h   |  11 +++
 drivers/net/hyperv/netvsc.c       | 137 ++++++++++++++++++++++++++++--
 drivers/net/hyperv/rndis_filter.c |   3 +
 3 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 2a87cfa27ac0..d85f811238c7 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -130,6 +130,7 @@ struct hv_netvsc_packet {
 	u32 total_bytes;
 	u32 send_buf_index;
 	u32 total_data_buflen;
+	struct dma_range *dma_range;
 };
 
 #define NETVSC_HASH_KEYLEN 40
@@ -1026,6 +1027,7 @@ struct netvsc_device {
 
 	/* Receive buffer allocated by us but manages by NetVSP */
 	void *recv_buf;
+	void *recv_original_buf;
 	u32 recv_buf_size; /* allocated bytes */
 	u32 recv_buf_gpadl_handle;
 	u32 recv_section_cnt;
@@ -1034,6 +1036,8 @@ struct netvsc_device {
 
 	/* Send buffer allocated by us */
 	void *send_buf;
+	void *send_original_buf;
+	u32 send_buf_size;
 	u32 send_buf_gpadl_handle;
 	u32 send_section_cnt;
 	u32 send_section_size;
@@ -1715,4 +1719,11 @@ struct rndis_message {
 #define TRANSPORT_INFO_IPV6_TCP 0x10
 #define TRANSPORT_INFO_IPV6_UDP 0x20
 
+struct dma_range {
+	dma_addr_t dma;
+	u32 mapping_size;
+};
+
+void netvsc_dma_unmap(struct hv_device *hv_dev,
+		      struct hv_netvsc_packet *packet);
 #endif /* _HYPERV_NET_H */
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 2353623259f3..1a5f5be4eeea 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -26,6 +26,7 @@
 
 #include "hyperv_net.h"
 #include "netvsc_trace.h"
+#include "../../hv/hyperv_vmbus.h"
 
 /*
  * Switch the data path from the synthetic interface to the VF
@@ -119,8 +120,21 @@ static void free_netvsc_device(struct rcu_head *head)
 	int i;
 
 	kfree(nvdev->extension);
-	vfree(nvdev->recv_buf);
-	vfree(nvdev->send_buf);
+
+	if (nvdev->recv_original_buf) {
+		iounmap(nvdev->recv_buf);
+		vfree(nvdev->recv_original_buf);
+	} else {
+		vfree(nvdev->recv_buf);
+	}
+
+	if (nvdev->send_original_buf) {
+		iounmap(nvdev->send_buf);
+		vfree(nvdev->send_original_buf);
+	} else {
+		vfree(nvdev->send_buf);
+	}
+
 	kfree(nvdev->send_section_map);
 
 	for (i = 0; i < VRSS_CHANNEL_MAX; i++) {
@@ -302,9 +316,12 @@ static int netvsc_init_buf(struct hv_device *device,
 	struct nvsp_1_message_send_receive_buffer_complete *resp;
 	struct net_device *ndev = hv_get_drvdata(device);
 	struct nvsp_message *init_packet;
+	struct vm_struct *area;
+	u64 extra_phys;
 	unsigned int buf_size;
+	unsigned long vaddr;
 	size_t map_words;
-	int ret = 0;
+	int ret = 0, i;
 
 	/* Get receive buffer area. */
 	buf_size = device_info->recv_sections * device_info->recv_section_size;
@@ -340,6 +357,27 @@ static int netvsc_init_buf(struct hv_device *device,
 		goto cleanup;
 	}
 
+	if (hv_isolation_type_snp()) {
+		area = get_vm_area(buf_size, VM_IOREMAP);
+		if (!area)
+			goto cleanup;
+
+		vaddr = (unsigned long)area->addr;
+		for (i = 0; i < buf_size / HV_HYP_PAGE_SIZE; i++) {
+			extra_phys = (virt_to_hvpfn(net_device->recv_buf + i * HV_HYP_PAGE_SIZE)
+				<< HV_HYP_PAGE_SHIFT) + ms_hyperv.shared_gpa_boundary;
+			ret |= ioremap_page_range(vaddr + i * HV_HYP_PAGE_SIZE,
+					   vaddr + (i + 1) * HV_HYP_PAGE_SIZE,
+					   extra_phys, PAGE_KERNEL_IO);
+		}
+
+		if (ret)
+			goto cleanup;
+
+		net_device->recv_original_buf = net_device->recv_buf;
+		net_device->recv_buf = (void *)vaddr;
+	}
+
 	/* Notify the NetVsp of the gpadl handle */
 	init_packet = &net_device->channel_init_pkt;
 	memset(init_packet, 0, sizeof(struct nvsp_message));
@@ -432,6 +470,28 @@ static int netvsc_init_buf(struct hv_device *device,
 		goto cleanup;
 	}
 
+	if (hv_isolation_type_snp()) {
+		area = get_vm_area(buf_size, VM_IOREMAP);
+		if (!area)
+			goto cleanup;
+
+		vaddr = (unsigned long)area->addr;
+
+		for (i = 0; i < buf_size / HV_HYP_PAGE_SIZE; i++) {
+			extra_phys = (virt_to_hvpfn(net_device->send_buf + i * HV_HYP_PAGE_SIZE)
+				<< HV_HYP_PAGE_SHIFT) + ms_hyperv.shared_gpa_boundary;
+			ret |= ioremap_page_range(vaddr + i * HV_HYP_PAGE_SIZE,
+					   vaddr + (i + 1) * HV_HYP_PAGE_SIZE,
+					   extra_phys, PAGE_KERNEL_IO);
+		}
+
+		if (ret)
+			goto cleanup;
+
+		net_device->send_original_buf = net_device->send_buf;
+		net_device->send_buf = (void *)vaddr;
+	}
+
 	/* Notify the NetVsp of the gpadl handle */
 	init_packet = &net_device->channel_init_pkt;
 	memset(init_packet, 0, sizeof(struct nvsp_message));
@@ -722,7 +782,7 @@ static void netvsc_send_tx_complete(struct net_device *ndev,
 
 	/* Notify the layer above us */
 	if (likely(skb)) {
-		const struct hv_netvsc_packet *packet
+		struct hv_netvsc_packet *packet
 			= (struct hv_netvsc_packet *)skb->cb;
 		u32 send_index = packet->send_buf_index;
 		struct netvsc_stats *tx_stats;
@@ -738,6 +798,7 @@ static void netvsc_send_tx_complete(struct net_device *ndev,
 		tx_stats->bytes += packet->total_bytes;
 		u64_stats_update_end(&tx_stats->syncp);
 
+		netvsc_dma_unmap(ndev_ctx->device_ctx, packet);
 		napi_consume_skb(skb, budget);
 	}
 
@@ -878,6 +939,60 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 		memset(dest, 0, padding);
 }
 
+void netvsc_dma_unmap(struct hv_device *hv_dev,
+		      struct hv_netvsc_packet *packet)
+{
+	u32 page_count = packet->cp_partial ?
+		packet->page_buf_cnt - packet->rmsg_pgcnt :
+		packet->page_buf_cnt;
+	int i;
+
+	if (!packet->dma_range)
+		return;
+
+	for (i = 0; i < page_count; i++)
+		dma_unmap_single(&hv_dev->device, packet->dma_range[i].dma,
+				 packet->dma_range[i].mapping_size,
+				 DMA_TO_DEVICE);
+
+	kfree(packet->dma_range);
+}
+
+int netvsc_dma_map(struct hv_device *hv_dev,
+		   struct hv_netvsc_packet *packet,
+		   struct hv_page_buffer *pb)
+{
+	u32 page_count =  packet->cp_partial ?
+		packet->page_buf_cnt - packet->rmsg_pgcnt :
+		packet->page_buf_cnt;
+	dma_addr_t dma;
+	int i;
+
+	packet->dma_range = kzalloc(sizeof(struct dma_range) * page_count,
+			      GFP_KERNEL);
+	if (!packet->dma_range)
+		return -ENOMEM;
+
+	for (i = 0; i < page_count; i++) {
+		char *src = phys_to_virt((pb[i].pfn << HV_HYP_PAGE_SHIFT)
+					 + pb[i].offset);
+		u32 len = pb[i].len;
+
+		dma = dma_map_single(&hv_dev->device, src, len,
+				     DMA_TO_DEVICE);
+		if (dma_mapping_error(&hv_dev->device, dma))
+			return -ENOMEM;
+
+		packet->dma_range[i].dma = dma;
+		packet->dma_range[i].mapping_size = len;
+		pb[i].pfn = dma >> HV_HYP_PAGE_SHIFT;
+		pb[i].offset = offset_in_hvpage(dma);
+		pb[i].len = len;
+	}
+
+	return 0;
+}
+
 static inline int netvsc_send_pkt(
 	struct hv_device *device,
 	struct hv_netvsc_packet *packet,
@@ -917,14 +1032,22 @@ static inline int netvsc_send_pkt(
 
 	trace_nvsp_send_pkt(ndev, out_channel, rpkt);
 
+	packet->dma_range = NULL;
 	if (packet->page_buf_cnt) {
 		if (packet->cp_partial)
 			pb += packet->rmsg_pgcnt;
 
+		ret = netvsc_dma_map(ndev_ctx->device_ctx, packet, pb);
+		if (ret)
+			return ret;
+
 		ret = vmbus_sendpacket_pagebuffer(out_channel,
-						  pb, packet->page_buf_cnt,
-						  &nvmsg, sizeof(nvmsg),
-						  req_id);
+					  pb, packet->page_buf_cnt,
+					  &nvmsg, sizeof(nvmsg),
+					  req_id);
+
+		if (ret)
+			netvsc_dma_unmap(ndev_ctx->device_ctx, packet);
 	} else {
 		ret = vmbus_sendpacket(out_channel,
 				       &nvmsg, sizeof(nvmsg),
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 598713c0d5a8..b19243f5874c 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -263,6 +263,8 @@ static void rndis_filter_receive_response(struct net_device *ndev,
 {
 	struct rndis_device *dev = nvdev->extension;
 	struct rndis_request *request = NULL;
+	struct hv_device *hv_dev = ((struct net_device_context *)
+			netdev_priv(ndev))->device_ctx;
 	bool found = false;
 	unsigned long flags;
 
@@ -327,6 +329,7 @@ static void rndis_filter_receive_response(struct net_device *ndev,
 			}
 		}
 
+		netvsc_dma_unmap(hv_dev, &request->pkt);
 		complete(&request->wait_event);
 	} else {
 		netdev_err(ndev,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
