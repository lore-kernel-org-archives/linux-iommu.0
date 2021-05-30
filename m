Return-Path: <SRS0=A9HU=KZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7F2C47250
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 15:06:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBB8611CE
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 15:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBB8611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A425183A90;
	Sun, 30 May 2021 15:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vpWv8y8A0qAj; Sun, 30 May 2021 15:06:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 786C583AD1;
	Sun, 30 May 2021 15:06:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EFA0C0022;
	Sun, 30 May 2021 15:06:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37574C0001
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 15:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18CDE403C8
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 15:06:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QaA9mnpuz79v for <iommu@lists.linux-foundation.org>;
 Sun, 30 May 2021 15:06:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 178B6403A4
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 15:06:54 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id l70so6453405pga.1
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M1xVjAHigQsVBryVftpCCjvg81+wOTUQfr50wSa0z0o=;
 b=sNrdoZzEG12p5juMA3jBGdhwekq2aogyv4cWLt3Q9FFTt7/sBUDijWvM58X66976BO
 kJv1GfqQauUiQ6UDwB4KHSHKbqJdsTij6qKiS0I1JyaL90iuEOJ7P6aw8mucrerUw4kZ
 ynS7ThiT7E4/MDPzHnf4KZGFeGtrUHktekJ3Mt5GvomdItXJaCyBS0do306K1hhxXMvs
 vsFRVkYt5+hsjyFrhhoRTY51WzHW2c3gzdOCyN9MeS3XIsh08U9XZ1UHO+ZUZlEe0ZZh
 UW0FBTRMxa8o7owQlLms0NBS25OrbKF7Oojybmwzo1E4d4fQhPlIDfgLBDz6BGXt3erV
 1vmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M1xVjAHigQsVBryVftpCCjvg81+wOTUQfr50wSa0z0o=;
 b=I8YTChCfQ/k/2CHiX6vr16fBOB0WMAk0RYIYpzh6S+4xf64Mn3J19BItCcoKgrtNq6
 p6elcd8tyaN2GHsZCuTa0yJH8RfEfpi64wUOZ8P7+7uetB1kw5ZRcwiQwjukWgnDEIEe
 mZyk28mDw7P//iD35wOXtN8wSFc01rjChQbFSZDgs9GniWS7B3Z2AfXBalakJx/OaRgX
 rTbZR2chhpLPzL/dalcyFnzOYfMdA0G4XtuwyuWRkUIdgTGHQCrREa0lNS+pjmsWvtBg
 5tfFVEB8s0yJWY3lWUaqjDlR/Ty7T2r1HBOS67OQ6ecewLWPWQenynSDBqnDaSlHGBuy
 b76Q==
X-Gm-Message-State: AOAM533vCUdbEpijnfUzPU03QSvlYnftObx6YawocgKJSJ84MKBNEqo2
 t9s8itCt/TsJy0jLtTvEOYs=
X-Google-Smtp-Source: ABdhPJziJtspWVCmOHJqaVbfIhz+FLD7bwtV5SoxX2/+91foGt0Wvcd+JVLZUDMoLpg47iIDkrNTHQ==
X-Received: by 2002:a05:6a00:1c6b:b029:2e2:caff:13fa with SMTP id
 s43-20020a056a001c6bb02902e2caff13famr12601991pfw.59.1622387213561; 
 Sun, 30 May 2021 08:06:53 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:9:dc2d:80ab:c3f3:1524])
 by smtp.gmail.com with ESMTPSA id b15sm8679688pfi.100.2021.05.30.08.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 May 2021 08:06:53 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, hannes@cmpxchg.org,
 cai@lca.pw, krish.sadhukhan@oracle.com, saravanand@fb.com,
 Tianyu.Lan@microsoft.com, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, boris.ostrovsky@oracle.com,
 jgross@suse.com, sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 xen-devel@lists.xenproject.org, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com
Subject: [RFC PATCH V3 11/11] HV/Storvsc: Add Isolation VM support for storvsc
 driver
Date: Sun, 30 May 2021 11:06:28 -0400
Message-Id: <20210530150628.2063957-12-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210530150628.2063957-1-ltykernel@gmail.com>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, sunilmut@microsoft.com
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
storvsc rx/tx ring buffer. The page buffer used by vmbus_sendpacket_
mpb_desc() still need to handle. Use DMA API to map/umap these
memory during sending/receiving packet and Hyper-V DMA ops callback
will use swiotlb function to allocate bounce buffer and copy data
from/to bounce buffer.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 63 +++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 403753929320..32da419c134e 100644
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
@@ -427,6 +429,8 @@ struct storvsc_cmd_request {
 	u32 payload_sz;
 
 	struct vstor_packet vstor_packet;
+	u32 hvpg_count;
+	struct hv_dma_range *dma_range;
 };
 
 
@@ -1267,6 +1271,7 @@ static void storvsc_on_channel_callback(void *context)
 	struct hv_device *device;
 	struct storvsc_device *stor_device;
 	struct Scsi_Host *shost;
+	int i;
 
 	if (channel->primary_channel != NULL)
 		device = channel->primary_channel->device_obj;
@@ -1321,6 +1326,17 @@ static void storvsc_on_channel_callback(void *context)
 				request = (struct storvsc_cmd_request *)scsi_cmd_priv(scmnd);
 			}
 
+			if (request->dma_range) {
+				for (i = 0; i < request->hvpg_count; i++)
+					dma_unmap_page(&device->device,
+							request->dma_range[i].dma,
+							request->dma_range[i].mapping_size,
+							request->vstor_packet.vm_srb.data_in
+							     == READ_TYPE ?
+							DMA_FROM_DEVICE : DMA_TO_DEVICE);
+				kfree(request->dma_range);
+			}
+
 			storvsc_on_receive(stor_device, packet, request);
 			continue;
 		}
@@ -1817,7 +1833,9 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		unsigned int hvpgoff, hvpfns_to_add;
 		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
 		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
+		dma_addr_t dma;
 		u64 hvpfn;
+		u32 size;
 
 		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
 
@@ -1831,6 +1849,13 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
+		cmd_request->dma_range = kcalloc(hvpg_count,
+				 sizeof(*cmd_request->dma_range),
+				 GFP_ATOMIC);
+		if (!cmd_request->dma_range) {
+			ret = -ENOMEM;
+			goto free_payload;
+		}
 
 		for (i = 0; sgl != NULL; sgl = sg_next(sgl)) {
 			/*
@@ -1854,9 +1879,30 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 			 * last sgl should be reached at the same time that
 			 * the PFN array is filled.
 			 */
-			while (hvpfns_to_add--)
-				payload->range.pfn_array[i++] =	hvpfn++;
+			while (hvpfns_to_add--) {
+				size = min(HV_HYP_PAGE_SIZE - offset_in_hvpg,
+					   (unsigned long)length);
+				dma = dma_map_page(&dev->device,
+							 pfn_to_page(hvpfn++),
+							 offset_in_hvpg, size,
+							 scmnd->sc_data_direction);
+				if (dma_mapping_error(&dev->device, dma)) {
+					ret = -ENOMEM;
+					goto free_dma_range;
+				}
+
+				if (offset_in_hvpg) {
+					payload->range.offset = dma & ~HV_HYP_PAGE_MASK;
+					offset_in_hvpg = 0;
+				}
+
+				cmd_request->dma_range[i].dma = dma;
+				cmd_request->dma_range[i].mapping_size = size;
+				payload->range.pfn_array[i++] = dma >> HV_HYP_PAGE_SHIFT;
+				length -= size;
+			}
 		}
+		cmd_request->hvpg_count = hvpg_count;
 	}
 
 	cmd_request->payload = payload;
@@ -1867,13 +1913,20 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	put_cpu();
 
 	if (ret == -EAGAIN) {
-		if (payload_sz > sizeof(cmd_request->mpb))
-			kfree(payload);
 		/* no more space */
-		return SCSI_MLQUEUE_DEVICE_BUSY;
+		ret = SCSI_MLQUEUE_DEVICE_BUSY;
+		goto free_dma_range;
 	}
 
 	return 0;
+
+free_dma_range:
+	kfree(cmd_request->dma_range);
+
+free_payload:
+	if (payload_sz > sizeof(cmd_request->mpb))
+		kfree(payload);
+	return ret;
 }
 
 static struct scsi_host_template scsi_driver = {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
