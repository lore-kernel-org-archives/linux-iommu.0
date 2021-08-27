Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B77C4320E
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:22:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B0660FF2
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39B0660FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BDAA61596;
	Fri, 27 Aug 2021 17:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n4KOyuz3TOXt; Fri, 27 Aug 2021 17:21:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 085A66158E;
	Fri, 27 Aug 2021 17:21:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6FE2C001A;
	Fri, 27 Aug 2021 17:21:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4AF0C000E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C657C83B31
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XMGv6hxZ1mdI for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 17:21:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E75FF83B3E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:21:55 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id y23so6487752pgi.7
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gLQw+gOkOgBpF527SY7hnRVsopMwR8pUZ+6p/+sCMZE=;
 b=jqKW1cLVDQjLgxObfit7zrVrS1J/x3pPdbxN1asI4+M8zeuts6wiVmaF5gUPo9V2FS
 JXeBFTb/jNQsN8TVkdzk5dR/ZI/RL9bT7w6c7bid9edxLa0DUGokGuxk8lS91UGkaZj4
 eqhtySo2OVg6q8KSYAGPGN96kFNqzBoVPg3X/PK5X2nNp/aialOuUPCIlZMUG0e+PnrF
 loz3O3FeTYg3uZwrb5yAi3OMvnSUXqfLmi7a7GhGDDQYfkSFFvgBDn2e4Y2I1ay7oW87
 728MiFOG393bdP8GnvBwKHUYm2+UuifhwCPpfKTJJH5Hk/ZtBiCsSRaDaNOT026pRuBy
 Imzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gLQw+gOkOgBpF527SY7hnRVsopMwR8pUZ+6p/+sCMZE=;
 b=nMSmq98JcszqCDe6Wb4gZyTloH+X+6TkDfIRNSlFmXWewEcXCvvP5hdRqaaXCQA5PK
 bChUHR7o6SkW+jvpi4LtW9MqtalPK55ZxCXUHFtjGCIGOuoownnuHzTNMcpfyzeU9aW2
 2YYGRECKKNjMT2FZ0mo0KU7N7/wi/n5cSmmgqWTUNhUEuLWR6hGhQChNiwdQsiKDGEi8
 YvWPhPnaDRCSHHCQfU36/+fn+LLQp7IaY9ZoMkrYzidd20mWlobn6cU3vwgMOjxhdbKV
 8o0LAhCSBJguqvAKqwkP59TtWEsLyoEQrRbyu/taeeeGYLy6RXdf32Ke8fuehphdPMAg
 aMwA==
X-Gm-Message-State: AOAM531DLNNG1hfni0LVhJ3/E2gV4W6SdbidiciUWaUaRsWj4JE9RURh
 iv/M4BFyZYtJ6XpIkswqgWg=
X-Google-Smtp-Source: ABdhPJwuiMDXHrHAjE5Ue90v/UaZtCN02djvrlnnwi5m/AZBQrrgZl+iVNvLmQEttw3bmm/01KlJZg==
X-Received: by 2002:a05:6a00:a94:b029:384:1dc6:7012 with SMTP id
 b20-20020a056a000a94b02903841dc67012mr10074419pfl.53.1630084915337; 
 Fri, 27 Aug 2021 10:21:55 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:36:ef50:8fcd:44d1:eb17])
 by smtp.gmail.com with ESMTPSA id f5sm7155015pjo.23.2021.08.27.10.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Aug 2021 10:21:54 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 joro@8bytes.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 brijesh.singh@amd.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 pgonda@google.com, martin.b.radev@gmail.com, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, hannes@cmpxchg.org,
 aneesh.kumar@linux.ibm.com, krish.sadhukhan@oracle.com, saravanand@fb.com,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org,
 rientjes@google.com, ardb@kernel.org, michael.h.kelley@microsoft.com
Subject: [PATCH V4 13/13] hv_storvsc: Add Isolation VM support for storvsc
 driver
Date: Fri, 27 Aug 2021 13:21:11 -0400
Message-Id: <20210827172114.414281-14-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827172114.414281-1-ltykernel@gmail.com>
References: <20210827172114.414281-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com
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
mpb_desc() still needs to be handled. Use DMA API(dma_map_sg) to map
these memory during sending/receiving packet and return swiotlb bounce
buffer dma address. In Isolation VM, swiotlb  bounce buffer is marked
to be visible to host and the swiotlb force mode is enabled.

Set device's dma min align mask to HV_HYP_PAGE_SIZE - 1 in order to
keep the original data offset in the bounce buffer.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v3:
	* Rplace dma_map_page with dma_map_sg()
	* Use for_each_sg() to populate payload->range.pfn_array.
	* Remove storvsc_dma_map macro
---
 drivers/hv/vmbus_drv.c     |  1 +
 drivers/scsi/storvsc_drv.c | 41 +++++++++++++++-----------------------
 include/linux/hyperv.h     |  1 +
 3 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index f068e22a5636..270d526fd9de 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2124,6 +2124,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	hv_debug_add_dev_dir(child_device_obj);
 
 	child_device_obj->device.dma_mask = &vmbus_dma_mask;
+	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
 	return 0;
 
 err_kset_unregister:
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 328bb961c281..4f1793be1fdc 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -21,6 +21,8 @@
 #include <linux/device.h>
 #include <linux/hyperv.h>
 #include <linux/blkdev.h>
+#include <linux/dma-mapping.h>
+
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -1312,6 +1314,9 @@ static void storvsc_on_channel_callback(void *context)
 					continue;
 				}
 				request = (struct storvsc_cmd_request *)scsi_cmd_priv(scmnd);
+				if (scsi_sg_count(scmnd))
+					dma_unmap_sg(&device->device, scsi_sglist(scmnd),
+						     scsi_sg_count(scmnd), scmnd->sc_data_direction);
 			}
 
 			storvsc_on_receive(stor_device, packet, request);
@@ -1725,7 +1730,6 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	struct hv_host_device *host_dev = shost_priv(host);
 	struct hv_device *dev = host_dev->dev;
 	struct storvsc_cmd_request *cmd_request = scsi_cmd_priv(scmnd);
-	int i;
 	struct scatterlist *sgl;
 	unsigned int sg_count;
 	struct vmscsi_request *vm_srb;
@@ -1807,10 +1811,11 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	payload_sz = sizeof(cmd_request->mpb);
 
 	if (sg_count) {
-		unsigned int hvpgoff, hvpfns_to_add;
 		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
 		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
-		u64 hvpfn;
+		struct scatterlist *sg;
+		unsigned long hvpfn, hvpfns_to_add;
+		int j, i = 0;
 
 		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
 
@@ -1824,31 +1829,16 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
+		if (dma_map_sg(&dev->device, sgl, sg_count,
+		    scmnd->sc_data_direction) == 0)
+			return SCSI_MLQUEUE_DEVICE_BUSY;
 
-		for (i = 0; sgl != NULL; sgl = sg_next(sgl)) {
-			/*
-			 * Init values for the current sgl entry. hvpgoff
-			 * and hvpfns_to_add are in units of Hyper-V size
-			 * pages. Handling the PAGE_SIZE != HV_HYP_PAGE_SIZE
-			 * case also handles values of sgl->offset that are
-			 * larger than PAGE_SIZE. Such offsets are handled
-			 * even on other than the first sgl entry, provided
-			 * they are a multiple of PAGE_SIZE.
-			 */
-			hvpgoff = HVPFN_DOWN(sgl->offset);
-			hvpfn = page_to_hvpfn(sg_page(sgl)) + hvpgoff;
-			hvpfns_to_add =	HVPFN_UP(sgl->offset + sgl->length) -
-						hvpgoff;
+		for_each_sg(sgl, sg, sg_count, j) {
+			hvpfns_to_add = HVPFN_UP(sg_dma_len(sg));
+			hvpfn = HVPFN_DOWN(sg_dma_address(sg));
 
-			/*
-			 * Fill the next portion of the PFN array with
-			 * sequential Hyper-V PFNs for the continguous physical
-			 * memory described by the sgl entry. The end of the
-			 * last sgl should be reached at the same time that
-			 * the PFN array is filled.
-			 */
 			while (hvpfns_to_add--)
-				payload->range.pfn_array[i++] =	hvpfn++;
+				payload->range.pfn_array[i++] = hvpfn++;
 		}
 	}
 
@@ -1992,6 +1982,7 @@ static int storvsc_probe(struct hv_device *device,
 	stor_device->vmscsi_size_delta = sizeof(struct vmscsi_win8_extension);
 	spin_lock_init(&stor_device->lock);
 	hv_set_drvdata(device, stor_device);
+	dma_set_min_align_mask(&device->device, HV_HYP_PAGE_SIZE - 1);
 
 	stor_device->port_number = host->host_no;
 	ret = storvsc_connect_to_vsp(device, storvsc_ringbuffer_size, is_fc);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 139a43ad65a1..8f39893f8ccf 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1274,6 +1274,7 @@ struct hv_device {
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
+	struct device_dma_parameters dma_parms;
 
 	/* place holder to keep track of the dir for hv device in debugfs */
 	struct dentry *debug_dir;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
