Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7011D1F5C;
	Thu, 22 Aug 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351876; cv=none; b=hbiJsyTbvmG+tKkStgkutNviS7sBB5ig5LvhOhohwZuaqtaapwDSYpciQosEwJnFZilMXzFoppMJ4blgwOKDYxHHJ0yhcSSuoOGdco8yd9X6jyqFPdxDgZ5De07gak8Exqey81OsE1D6EP9TetKebqomtjhjqrqq7ddXyAR476Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351876; c=relaxed/simple;
	bh=vZUjHFmFvrYfCCwn47JEj2O7xPIiU/Pgnb18WTQj4is=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsxOE+WsGBQ2KA6WPGpQJ3Qt/jPvGTChFdWvgT7E/pNBmK8FZvzewg4PNw7APvaHM4SIH+HcJGmhpOWnvX4tKRzMn9I9NGvqqGG+l4sS2RlgFAmCFAmXYRz/odaeKVNJuE6woZHKJw7gZOwevrDlBRBNUCbAPJMkf3RHLGtgJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz6yJk1S; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz6yJk1S"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fec34f94abso11359455ad.2;
        Thu, 22 Aug 2024 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351874; x=1724956674; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Hlc/i1KYMFZn1UW3B36jY0bAKWAgeG5KXhGYCaItEQ=;
        b=Gz6yJk1Sfi9cDs5G3zzxehu9oyRcNA240GYftoHhFW0mxwoQWkDmGiXwXooiD1QggV
         k5IjnWunn6ZJlUJ1DtgwTJojThV4mplvZjQBkIbd6IqrcawKBvrLtjln4xZS2BmPFIBB
         3XTvCkHewgn4NfYBOJVDr6eZryDQsAmYtM5a7DfnccypEe1c4T+KlwNtZXGysOOirOh4
         B5xh+q/BN71d2P4X+Zg1n+QXJHdNP8KZ3Q91cR03UdU6DU2lc4V497fIYXwvYvtEmfjY
         /vdjH80ym10aTtDq2+pYptGRTAPdGaZnTz1MWQOd7299bRb30p8x1wKUdrWM+uhJS+XY
         dsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351874; x=1724956674;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Hlc/i1KYMFZn1UW3B36jY0bAKWAgeG5KXhGYCaItEQ=;
        b=cfxCDvrb222ySEF+1XZsQcIGOc13IKhwkUPtGLC+ITCXqfAgFIr49XNvCfaN69wK5v
         bfsbqXqiwQSUDiPXjHRtXzShWZlh1CNZuFBS3W01rn5sL/x9c2Z3Jc70z8wfuzHuunVF
         TUrlb1pA+rytG28Xv2vBcuVf4sB/fP5FQQpildKlbLXvAMGLJmdCR3ldZsBu7AgsRKDE
         LR5oNLoueV8OfCQl1I6xz599DZa02bPAk8Dn/YjFHLYhrdwcT+r+FtPQUxr64Z4xa323
         wItuyEVbEhGmCUeuRgvOSx6+lVGeC4TgoG4wMWKy49wQ6x0Vm6w1wTo2dP9RM/Fk9F1n
         tFxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYWUIobvBbnwBeEr3HN97Sut7PBbObuRUQiqs/oKHKroZ56LxXwrUssq3Qge4jVPGrYoQZDw==@lists.linux.dev, AJvYcCXlx1WgoP9QYvly+MJ7gCIMVvbTNyTu1CzFw0DrRwVUlfxGaGCRI2tEBXdhJECAcK8GxSa/pgtW7PmnHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyToXrMqos6JXeYG1NSLwjjhCsDoylvak82atRMp5rrqb1ymF4A
	kpAIxkpSvplalgPfZtiDxEZHMioBbaMtt/KdEGxjMuMC+ClUnqMz
X-Google-Smtp-Source: AGHT+IE+oTsuXbaq9ZvaSNrcslYkvt3uX+Tvp8+A11rBrdRfV8hOJKmntJKX/3gWBiFYZVMV3hYEuw==
X-Received: by 2002:a17:902:d2ce:b0:202:13ca:d73e with SMTP id d9443c01a7336-20388240fbcmr30142745ad.28.1724351873947;
        Thu, 22 Aug 2024 11:37:53 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:53 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 7/7] nvme: Enable swiotlb throttling for NVMe PCI devices
Date: Thu, 22 Aug 2024 11:37:18 -0700
Message-Id: <20240822183718.1234-8-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

In a CoCo VM, all DMA-based I/O must use swiotlb bounce buffers
because DMA cannot be done to private (encrypted) portions of VM
memory. The bounce buffer memory is marked shared (decrypted) at
boot time, so I/O is done to/from the bounce buffer memory and then
copied by the CPU to/from the final target memory (i.e, "bounced").
Storage devices can be large consumers of bounce buffer memory because
it is possible to have large numbers of I/Os in flight across multiple
devices. Bounce buffer memory must be pre-allocated at boot time, and
it is difficult to know how much memory to allocate to handle peak
storage I/O loads. Consequently, bounce buffer memory is typically
over-provisioned, which wastes memory, and may still not avoid a peak
that exhausts bounce buffer memory and cause storage I/O errors.

For Coco VMs running with NVMe PCI devices, update the driver to
permit bounce buffer throttling. Gate the throttling behavior
on a DMA layer check indicating that throttling is useful, so that
no change occurs in a non-CoCo VM. If throttling is useful, enable
the BLK_MQ_F_BLOCKING flag, and pass the DMA_ATTR_MAY_BLOCK attribute
into dma_map_bvec() and dma_map_sgtable() calls. With these options in
place, DMA map requests are pended when necessary to reduce the
likelihood of usage peaks caused by the NVMe driver that could exhaust
bounce buffer memory and generate errors.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/nvme/host/pci.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec..2c39943a87f8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -156,6 +156,7 @@ struct nvme_dev {
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
 	void **host_mem_desc_bufs;
+	unsigned long dma_attrs;
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
 	unsigned int nr_poll_queues;
@@ -735,7 +736,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
 	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
 
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
+	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req),
+					dev->dma_attrs);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
 		return BLK_STS_RESOURCE;
 	iod->dma_len = bv->bv_len;
@@ -754,7 +756,8 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
+	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req),
+					dev->dma_attrs);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
 		return BLK_STS_RESOURCE;
 	iod->dma_len = bv->bv_len;
@@ -800,7 +803,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 
 	rc = dma_map_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
+			     dev->dma_attrs | DMA_ATTR_NO_WARN);
 	if (rc) {
 		if (rc == -EREMOTEIO)
 			ret = BLK_STS_TARGET;
@@ -828,7 +831,8 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct bio_vec bv = rq_integrity_vec(req);
 
-	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
+	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req),
+					dev->dma_attrs);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
@@ -3040,6 +3044,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 * a single integrity segment for the separate metadata pointer.
 	 */
 	dev->ctrl.max_integrity_segments = 1;
+
+	if (dma_recommend_may_block(dev->dev)) {
+		dev->ctrl.blocking = true;
+		dev->dma_attrs = DMA_ATTR_MAY_BLOCK;
+	}
+
 	return dev;
 
 out_put_device:
-- 
2.25.1

