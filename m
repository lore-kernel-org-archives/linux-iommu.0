Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B8EC4167E
	for <iommu@archiver.kernel.org>; Sun,  5 Dec 2021 08:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BFBD82B51;
	Sun,  5 Dec 2021 08:18:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jymYzl6AotsO; Sun,  5 Dec 2021 08:18:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C9FD982BA7;
	Sun,  5 Dec 2021 08:18:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D771C0039;
	Sun,  5 Dec 2021 08:18:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10612C0012
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F38DD82BA7
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UuLhQduSSHjO for <iommu@lists.linux-foundation.org>;
 Sun,  5 Dec 2021 08:18:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36D5C82B1A
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:24 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id gt5so5487795pjb.1
 for <iommu@lists.linux-foundation.org>; Sun, 05 Dec 2021 00:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=brPB+isubduGZ0dFkchshqyMjV+4uHMaO2+7Xc0wGRk=;
 b=d+pRTiyTvRH5TOIdeq8tkDweJDBPZRanHXQhj0YflzD4Il2KCdLON3cC58pHDs8qX9
 OGEp/At7kf/f/+6HkyyKsAqzvAGnInBSq0i+DqkcYw3qOwJNcz5v/DdzlqrsWBz4dp3r
 ZrUePPnfHGvvxMJ8axGmVh/ZjNrM6QEcFVD5j49e0lYjjHlQN9RN9/AqEVHhOVaGGenW
 gtzqWAeiHKj1f/U/EfydqsGjRVi6DCB3x4MgQhKfD33v6xwaiSXh2e2GWM2D2iVnFMLP
 yQbMKY3jgpbGK4JwlKTX8SQfCFNQpLUcN96i5b7r6lFGqNBYGmwfN8dQSHd9Ipcb2/Mo
 U55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=brPB+isubduGZ0dFkchshqyMjV+4uHMaO2+7Xc0wGRk=;
 b=ptXFtjDJq/I1iBrUUvGX+RQV5P7Y5jLujMc67jN7nf60h/evUgawdm395X/YCD7hbQ
 GC9DTRnWzCXLkpRyifWVb2H66yaJbulCnBJ4FaIccAx7T5YkYihBcKTRkX/GxSxBPgL4
 bWFjBKeahLfgHlo3t36JSaIpwVuE2xxx+F/Rb8yELER+qjcg4IAcIK6p/Rc6CfB+Ssa4
 5inA2/lPKlzFZWKFAw09x4khi6xohMCsn1YPBpPlrON/OcAVWp5/j5FZ81KhDvRzl3Xf
 XWWCZyjxUJgyX4S8zd6aIfLDwnD7w+GKkdLpT8o/syieiPEL1lPlZiUvagDy6bGhXFL0
 qGWQ==
X-Gm-Message-State: AOAM5305aEC0boUdMCfbtGPStkbXXPzmg1/99qY0c8+qMcnYQ8cE+NUL
 vzGVPdChraA6vZPbZn8a+5c=
X-Google-Smtp-Source: ABdhPJzWds7gw4/7Hsf56r+CojhqWW7GcWTPaWgp5Pi8SFfxCERK/Yp6qhd5zk9W3uMOhKEfc1n27g==
X-Received: by 2002:a17:90a:c287:: with SMTP id
 f7mr28508697pjt.114.1638692303692; 
 Sun, 05 Dec 2021 00:18:23 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:7:87aa:e334:f070:ebca])
 by smtp.gmail.com with ESMTPSA id s8sm6439905pgl.77.2021.12.05.00.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Dec 2021 00:18:23 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, jgross@suse.com, sstabellini@kernel.org,
 boris.ostrovsky@oracle.com, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, xen-devel@lists.xenproject.org,
 michael.h.kelley@microsoft.com
Subject: [PATCH V4 4/5] scsi: storvsc: Add Isolation VM support for storvsc
 driver
Date: Sun,  5 Dec 2021 03:18:12 -0500
Message-Id: <20211205081815.129276-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205081815.129276-1-ltykernel@gmail.com>
References: <20211205081815.129276-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, hch@lst.de
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
mpb_desc() still needs to be handled. Use DMA API(scsi_dma_map/unmap)
to map these memory during sending/receiving packet and return swiotlb
bounce buffer dma address. In Isolation VM, swiotlb  bounce buffer is
marked to be visible to host and the swiotlb force mode is enabled.

Set device's dma min align mask to HV_HYP_PAGE_SIZE - 1 in order to
keep the original data offset in the bounce buffer.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/vmbus_drv.c     |  1 +
 drivers/scsi/storvsc_drv.c | 37 +++++++++++++++++++++----------------
 include/linux/hyperv.h     |  1 +
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0a64ccfafb8b..ae6ec503399a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2121,6 +2121,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	hv_debug_add_dev_dir(child_device_obj);
 
 	child_device_obj->device.dma_mask = &vmbus_dma_mask;
+	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
 	return 0;
 
 err_kset_unregister:
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 20595c0ba0ae..ae293600d799 100644
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
@@ -1336,6 +1338,7 @@ static void storvsc_on_channel_callback(void *context)
 					continue;
 				}
 				request = (struct storvsc_cmd_request *)scsi_cmd_priv(scmnd);
+				scsi_dma_unmap(scmnd);
 			}
 
 			storvsc_on_receive(stor_device, packet, request);
@@ -1749,7 +1752,6 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	struct hv_host_device *host_dev = shost_priv(host);
 	struct hv_device *dev = host_dev->dev;
 	struct storvsc_cmd_request *cmd_request = scsi_cmd_priv(scmnd);
-	int i;
 	struct scatterlist *sgl;
 	unsigned int sg_count;
 	struct vmscsi_request *vm_srb;
@@ -1831,10 +1833,11 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
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
 
@@ -1848,21 +1851,22 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
+		sg_count = scsi_dma_map(scmnd);
+		if (sg_count < 0)
+			return SCSI_MLQUEUE_DEVICE_BUSY;
 
-		for (i = 0; sgl != NULL; sgl = sg_next(sgl)) {
+		for_each_sg(sgl, sg, sg_count, j) {
 			/*
-			 * Init values for the current sgl entry. hvpgoff
-			 * and hvpfns_to_add are in units of Hyper-V size
-			 * pages. Handling the PAGE_SIZE != HV_HYP_PAGE_SIZE
-			 * case also handles values of sgl->offset that are
-			 * larger than PAGE_SIZE. Such offsets are handled
-			 * even on other than the first sgl entry, provided
-			 * they are a multiple of PAGE_SIZE.
+			 * Init values for the current sgl entry. hvpfns_to_add
+			 * is in units of Hyper-V size pages. Handling the
+			 * PAGE_SIZE != HV_HYP_PAGE_SIZE case also handles
+			 * values of sgl->offset that are larger than PAGE_SIZE.
+			 * Such offsets are handled even on other than the first
+			 * sgl entry, provided they are a multiple of PAGE_SIZE.
 			 */
-			hvpgoff = HVPFN_DOWN(sgl->offset);
-			hvpfn = page_to_hvpfn(sg_page(sgl)) + hvpgoff;
-			hvpfns_to_add =	HVPFN_UP(sgl->offset + sgl->length) -
-						hvpgoff;
+			hvpfn = HVPFN_DOWN(sg_dma_address(sg));
+			hvpfns_to_add = HVPFN_UP(sg_dma_address(sg) +
+						 sg_dma_len(sg)) - hvpfn;
 
 			/*
 			 * Fill the next portion of the PFN array with
@@ -1872,7 +1876,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 			 * the PFN array is filled.
 			 */
 			while (hvpfns_to_add--)
-				payload->range.pfn_array[i++] =	hvpfn++;
+				payload->range.pfn_array[i++] = hvpfn++;
 		}
 	}
 
@@ -2016,6 +2020,7 @@ static int storvsc_probe(struct hv_device *device,
 	stor_device->vmscsi_size_delta = sizeof(struct vmscsi_win8_extension);
 	spin_lock_init(&stor_device->lock);
 	hv_set_drvdata(device, stor_device);
+	dma_set_min_align_mask(&device->device, HV_HYP_PAGE_SIZE - 1);
 
 	stor_device->port_number = host->host_no;
 	ret = storvsc_connect_to_vsp(device, storvsc_ringbuffer_size, is_fc);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 1f037e114dc8..74f5e92f91a0 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1261,6 +1261,7 @@ struct hv_device {
 
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
