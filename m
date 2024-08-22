Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926EE1D172C;
	Thu, 22 Aug 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351874; cv=none; b=WsXnL/6O/+nQ8+0ds8GkmGjV/qcfT7Nw5oJnhIa4GKWCpmq5f94KzlinwVG4IzCXIZefCsTLBCDke2jUzF0EC4V+Ms3vxexfEHY3rOSanF18bNSACwpBHuiqa6BYPtSPZYtQb5pI+AWDJoT4bb+rSAYk6I5KYTs1eZfDXY3Ou+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351874; c=relaxed/simple;
	bh=KQxA10ny3y7ONujVrMwgPmKcFbuUbkjllbN6PgK2qYA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nguua3ER5QJZxL8TjvUabpbFhgXBIaJKZLgJwKDt0fKyrFSsYjQ6YdYP7PFoPgoD5t9tmpHbharJaqwgkjf0qBqeAv53XP2x4cyxtk/81DY0FdZfm+QQ7/iXTvslUTLisnVXho46V+DoYihdVdxvFlmDdTVqUx8UID/LSAZtCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwidH0AC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwidH0AC"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-202146e93f6so11470835ad.3;
        Thu, 22 Aug 2024 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351872; x=1724956672; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JDb2lC6vkxiQiFZDx7okJ0uyYWyOojJCyTq1IY1j8o=;
        b=BwidH0ACSRzS635iGDBmM0fZWMEMLaCjd7Y5YEIdDXm2AMsfZSWYzkxc2tPCkoeq3p
         gTGKLAGPpCZKSfL4dn4slNBi9RW/Un+ETsOEF9t1jnpfnqWGfBOIGMfUOQgCy989FP42
         UmFF3BxxEBa42+w0x/UkDXLUbIZ59s+dJQPN60xtWpBsyt0pbwGkwwXO6kzmJCi/OQgi
         7TIkJ4k4ju2WD6o02LmObCc2Gvgju3UbsWJtSGOn8XTGkmF7e7mANBOo7S+KsBkc1WPk
         HRrbSoW9cQcsxfIBtOgqVnPkYjOjamFY/PWcDhZBWPz6UVMZNXH6f+D/p4iT5krHtGkX
         a04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351872; x=1724956672;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4JDb2lC6vkxiQiFZDx7okJ0uyYWyOojJCyTq1IY1j8o=;
        b=VDMEBgvqFrDcnN3stiTDNeV6fTc4LuQKnh9cYNcbQItaN0RfcbL157panScSfU0uO0
         5aMP/8TJVJFUHm1gOL7IstVH92Wzs2xVxP+jKFEoRJRbJqpzeAchyZjdvhjROIiyli3g
         YzSTKL3BiVvhFh4XDOjWlHIWLNkMbj/xHC4eqc+Y+bAC418J1OxAXNtoCWWbQZU1r395
         gLNkbqbMp1ZRY+Vjof+urFT2Xl+sp3Mqe01ezwVRqOnfVm7rC5Ykg7m+WSRdg//L1+YH
         jML2BizzEFqDMce+W5Lsy+WDDodOKTxiGAxcgTd4bIxCanAs0SXAw2EbJUYO9qnG8k3P
         YLTg==
X-Forwarded-Encrypted: i=1; AJvYcCW1PEI0Yl6jAgp48HMDEVAbmdlKyQ1kgQvg8+Q+BtFt9Y9VqFXhS7Q4fJsx/4eSqpGMy3MvFw==@lists.linux.dev, AJvYcCWOAIjntE5G4aSZrq3d9bTDaoTHvyDq9Sne0EsP6x+XAB2JMX7lW5KNPVrMWtx4qKHWA1Y1U7Qr14xdWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YycAMZ02VM+jHhLWSlhOJeZ02D85eHalS2P0A8eKDUxcaxD3M9Z
	b3q18SEbeGRUYW/7ANtof80bqkk44ISLH3mt8687xa74vh9067p9
X-Google-Smtp-Source: AGHT+IEoJ1gpzNrcpekG/3JPJrpxwsytoY1vLLalws9b/ZRPgjfwB0Ov7rhSrw2br36PLdiErGBT6A==
X-Received: by 2002:a17:903:1cc:b0:1fb:9b91:d7c9 with SMTP id d9443c01a7336-20367d32768mr57195805ad.4.1724351871710;
        Thu, 22 Aug 2024 11:37:51 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:51 -0700 (PDT)
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
Subject: [RFC 5/7] scsi: storvsc: Enable swiotlb throttling
Date: Thu, 22 Aug 2024 11:37:16 -0700
Message-Id: <20240822183718.1234-6-mhklinux@outlook.com>
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
Storage devices can be large consumers of bounce buffer memory because it
is possible to have large numbers of I/Os in flight across multiple
devices. Bounce buffer memory must be pre-allocated at boot time, and
it is difficult to know how much memory to allocate to handle peak
storage I/O loads. Consequently, bounce buffer memory is typically
over-provisioned, which wastes memory, and may still not avoid a peak
that exhausts bounce buffer memory and cause storage I/O errors.

To solve this problem for Coco VMs running on Hyper-V, update the
storvsc driver to permit bounce buffer throttling. First, use
scsi_dma_map_attrs() instead of scsi_dma_map(). Then gate the
throttling behavior on a DMA layer check indicating that throttling is
useful, so that no change occurs in a non-CoCo VM. If throttling is
useful, pass the DMA_ATTR_MAY_BLOCK attribute, and set the block queue
flag indicating that the I/O request submission path may sleep, which
could happen when throttling. With these options in place, DMA map
requests are pended when necessary to reduce the likelihood of usage
peaks caused by storvsc that could exhaust bounce buffer memory and
generate errors.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/storvsc_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7ceb982040a5..7bedd5502d07 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -457,6 +457,7 @@ struct hv_host_device {
 	struct workqueue_struct *handle_error_wq;
 	struct work_struct host_scan_work;
 	struct Scsi_Host *host;
+	unsigned long dma_attrs;
 };
 
 struct storvsc_scan_work {
@@ -1810,7 +1811,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
-		sg_count = scsi_dma_map(scmnd);
+		sg_count = scsi_dma_map_attrs(scmnd, host_dev->dma_attrs);
 		if (sg_count < 0) {
 			ret = SCSI_MLQUEUE_DEVICE_BUSY;
 			goto err_free_payload;
@@ -2030,6 +2031,12 @@ static int storvsc_probe(struct hv_device *device,
 	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE.
 	 */
 	host->sg_tablesize = (max_xfer_bytes >> HV_HYP_PAGE_SHIFT) + 1;
+
+	if (dma_recommend_may_block(&device->device)) {
+		host->queuecommand_may_block = true;
+		host_dev->dma_attrs = DMA_ATTR_MAY_BLOCK;
+	}
+
 	/*
 	 * For non-IDE disks, the host supports multiple channels.
 	 * Set the number of HW queues we are supporting.
-- 
2.25.1

