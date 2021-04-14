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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4311C43611
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F0F611F2
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F0F611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D0B14018F;
	Wed, 14 Apr 2021 14:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fl-RPx_wvGHt; Wed, 14 Apr 2021 14:50:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 227274018C;
	Wed, 14 Apr 2021 14:50:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0DB1C000A;
	Wed, 14 Apr 2021 14:50:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AD63C000B
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 238E7607B7
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cak6LOiVkrMD for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:50:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25D2D60733
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:35 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id o123so13909186pfb.4
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FJbcZ8KnexDAAQ5C4Sah9FWkqLY6Pv3HeJbolDJY4aA=;
 b=pJqRunkA+uvhxmvikCt8JBi6ru5mMAHBSouNbpNF9rJ0/UZBeBZbNJBCihskZckNdz
 VF19al63x7JcKIwSaI+KgRMKfSCSAY1Rw9bm3SeZTFumtAQ1F6F2t95WHbTa7fd9i7Tn
 oYWyOXXwTN9+AehaDQOGu3IYPhNL0uJPAF/Y5xrfhILPXupgDCaiPCDkfxwVRVWqt8q+
 v1FJRcKkKffDj4UMUcXDwJEin7yz4TBxBoW5ErGESAAdJKNwJ1ukgEYbn+s0z/MPExFU
 EV7Gn16e8uqLMsjL1/Ua5qlsNxwABA+5vNnnX0j44xHWZEyyVt04dkbZk7p6QtVwr46f
 qTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FJbcZ8KnexDAAQ5C4Sah9FWkqLY6Pv3HeJbolDJY4aA=;
 b=g96Xh+AmYcfY4fROrWrxW8BQ6S56H1XbUvSmX2crQISJ5GescBxY+amGEX5KKhLN0V
 7aPA7FHKaq4sNW9AzdNdkDUttKoXKXfzxCW+zW+0ivxF4ZszjHp1QdhljwIo56s9fmXr
 1lSOLZRglGPpM2Xzi9WBOWlsaZFLb/6XguoOGpKdStY0qx4wMrvwqAdWlXn4PoE5T4+r
 O/EC0rPddj8o+2E1OwavoJIULxDjfcupSKdOZWrH4LmWyTPEq3Gbw7yMD9GwdLyVVYmR
 YyL3JV5rv7bvvLEExtDaS7rpC1M5K5c12GKJg5pnkP0AOaDcZ9uW7VtGJ3UdMHlg4GeQ
 ZDWQ==
X-Gm-Message-State: AOAM531PqYUxB8gL1OReW//TESdd7aQ/gvLCBcioGWGKZfNQAjD94US1
 JwSJpn+jqKbbzAp2PvVD5m4=
X-Google-Smtp-Source: ABdhPJxHAv83JdLDizjV20z7u62dRC/ZGAyfJ/XHZQUwINjnLav8NcwqNU6XQrZbUuAS+bM3Dz+Utw==
X-Received: by 2002:a63:1646:: with SMTP id 6mr39049996pgw.321.1618411835543; 
 Wed, 14 Apr 2021 07:50:35 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:35:ebad:12c1:f579:e332])
 by smtp.gmail.com with ESMTPSA id w67sm17732522pgb.87.2021.04.14.07.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 07:50:35 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Subject: [Resend RFC PATCH V2 12/12] HV/Storvsc: Add Isolation VM support for
 storvsc driver
Date: Wed, 14 Apr 2021 10:49:45 -0400
Message-Id: <20210414144945.3460554-13-ltykernel@gmail.com>
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
mpb_desc() still need to handle. Use DMA API to map/umap these
memory during sending/receiving packet and Hyper-V DMA ops callback
will use swiotlb fucntion to allocate bounce buffer and copy data
from/to bounce buffer.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 67 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 2e4fa77445fd..d271578b1811 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -21,6 +21,8 @@
 #include <linux/device.h>
 #include <linux/hyperv.h>
 #include <linux/blkdev.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -414,6 +416,11 @@ static void storvsc_on_channel_callback(void *context);
 #define STORVSC_IDE_MAX_TARGETS				1
 #define STORVSC_IDE_MAX_CHANNELS			1
 
+struct dma_range {
+	dma_addr_t dma;
+	u32 mapping_size;
+};
+
 struct storvsc_cmd_request {
 	struct scsi_cmnd *cmd;
 
@@ -427,6 +434,8 @@ struct storvsc_cmd_request {
 	u32 payload_sz;
 
 	struct vstor_packet vstor_packet;
+	u32 hvpg_count;
+	struct dma_range *dma_range;
 };
 
 
@@ -1236,6 +1245,7 @@ static void storvsc_on_channel_callback(void *context)
 	const struct vmpacket_descriptor *desc;
 	struct hv_device *device;
 	struct storvsc_device *stor_device;
+	int i;
 
 	if (channel->primary_channel != NULL)
 		device = channel->primary_channel->device_obj;
@@ -1249,6 +1259,8 @@ static void storvsc_on_channel_callback(void *context)
 	foreach_vmbus_pkt(desc, channel) {
 		void *packet = hv_pkt_data(desc);
 		struct storvsc_cmd_request *request;
+		enum dma_data_direction dir;
+		u32 attrs;
 		u64 cmd_rqst;
 
 		cmd_rqst = vmbus_request_addr(&channel->requestor,
@@ -1261,6 +1273,22 @@ static void storvsc_on_channel_callback(void *context)
 
 		request = (struct storvsc_cmd_request *)(unsigned long)cmd_rqst;
 
+		if (request->vstor_packet.vm_srb.data_in == READ_TYPE)
+			dir = DMA_FROM_DEVICE;
+		 else
+			dir = DMA_TO_DEVICE;
+
+		if (request->dma_range) {
+			for (i = 0; i < request->hvpg_count; i++)
+				dma_unmap_page_attrs(&device->device,
+						request->dma_range[i].dma,
+						request->dma_range[i].mapping_size,
+						request->vstor_packet.vm_srb.data_in
+						     == READ_TYPE ?
+						DMA_FROM_DEVICE : DMA_TO_DEVICE, attrs);
+			kfree(request->dma_range);
+		}
+
 		if (request == &stor_device->init_request ||
 		    request == &stor_device->reset_request) {
 			memcpy(&request->vstor_packet, packet,
@@ -1682,8 +1710,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	struct vmscsi_request *vm_srb;
 	struct scatterlist *cur_sgl;
 	struct vmbus_packet_mpb_array  *payload;
+	enum dma_data_direction dir;
 	u32 payload_sz;
 	u32 length;
+	u32 attrs;
 
 	if (vmstor_proto_version <= VMSTOR_PROTO_VERSION_WIN8) {
 		/*
@@ -1722,14 +1752,17 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	case DMA_TO_DEVICE:
 		vm_srb->data_in = WRITE_TYPE;
 		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_DATA_OUT;
+		dir = DMA_TO_DEVICE;
 		break;
 	case DMA_FROM_DEVICE:
 		vm_srb->data_in = READ_TYPE;
 		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_DATA_IN;
+		dir = DMA_FROM_DEVICE;
 		break;
 	case DMA_NONE:
 		vm_srb->data_in = UNKNOWN_TYPE;
 		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_NO_DATA_TRANSFER;
+		dir = DMA_NONE;
 		break;
 	default:
 		/*
@@ -1786,6 +1819,12 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		hvpgoff = sgl->offset >> HV_HYP_PAGE_SHIFT;
 
 		cur_sgl = sgl;
+
+		cmd_request->dma_range = kzalloc(sizeof(struct dma_range) * hvpg_count,
+			      GFP_ATOMIC);
+		if (!cmd_request->dma_range)
+			return -ENOMEM;
+
 		for (i = 0; i < hvpg_count; i++) {
 			/*
 			 * 'i' is the index of hv pages in the payload and
@@ -1805,6 +1844,8 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 			 */
 			unsigned int hvpgoff_in_page =
 				(i + hvpgoff) % NR_HV_HYP_PAGES_IN_PAGE;
+			dma_addr_t dma;
+			u32 size;
 
 			/*
 			 * Two cases that we need to fetch a page:
@@ -1817,8 +1858,28 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 				cur_sgl = sg_next(cur_sgl);
 			}
 
-			payload->range.pfn_array[i] = hvpfn + hvpgoff_in_page;
+			size = min(HV_HYP_PAGE_SIZE - offset_in_hvpg, (unsigned long)length);
+			dma = dma_map_page_attrs(&dev->device,
+						 pfn_to_page(hvpfn),
+						 offset_in_hvpg, size,
+						 scmnd->sc_data_direction, attrs);
+			if (dma_mapping_error(&dev->device, dma)) {
+				pr_warn("dma map error.\n");
+				ret = -ENOMEM;
+				goto free_dma_range;
+			}
+
+			if (offset_in_hvpg) {
+				payload->range.offset = dma & ~HV_HYP_PAGE_MASK;
+				offset_in_hvpg = 0;
+			}
+
+			cmd_request->dma_range[i].dma = dma;
+			cmd_request->dma_range[i].mapping_size = size;
+			payload->range.pfn_array[i] = dma >> HV_HYP_PAGE_SHIFT;
+			length -= size;
 		}
+		cmd_request->hvpg_count = hvpg_count;
 	}
 
 	cmd_request->payload = payload;
@@ -1836,6 +1897,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	}
 
 	return 0;
+
+free_dma_range:
+	kfree(cmd_request->dma_range);
+	return ret;
 }
 
 static struct scsi_host_template scsi_driver = {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
