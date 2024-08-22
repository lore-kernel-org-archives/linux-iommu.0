Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAD1D1749;
	Thu, 22 Aug 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351875; cv=none; b=JUObRr/+YvQU3ha/wcKrdE96M3sh92PIcVbi1gtzMQ6eFR+Lb/hzp5wKCbk7ci60xVUScB3p/SMLITUEJp0EI1Wq/up8KWN7R+nHjcX4PM4nUvFmQM+EhMvq+sq4jNmOfMi5/5HTC3Ba/kGTQmSBoavK1wBo6RcRJcO3EGDe2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351875; c=relaxed/simple;
	bh=h7/QaozXkfleYoirlRN16+9s8z8TVAPkUO7bp7owxBs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzjP1Up18RCsTZzo8oQgvCOMBvLE2/6Er++9/m1bBd0BrHhW6d4BC1UJHK6gscVY05KJaRSA4USZ4xcxlLuydOVls1v6VtbNpm7ytVGphyn0pBDPXLk3W6TqBD26iPTwgzaeiPYTQ7hk2Sa9UAaIg6tJW5sjYMr9ZRh2JzwwTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReugMbHN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReugMbHN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20231aa8908so10879485ad.0;
        Thu, 22 Aug 2024 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351873; x=1724956673; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/YtNwLPh5pTk6gSo6t/PeLiCmJLTlpJ+ybh0IcUxoY=;
        b=ReugMbHNkHumtOb758+R9PGZSrbxnqQm3EQ3Enf/7ovkKDkDKl0vr0h6DFi2MpFqRE
         sbCP3/xFGSjYWDd/nHaHPLxEV8YZleSr29Cz5HZhqMsJTs4bOSn/SV9BedpWCfS/A73+
         YetQ78ZoLEfFvw7ADfQMKLb27xN0lejbUVZ2YX89kb5w5RHwHTr3jxw215J1EOLfDkIq
         psBi2SbeMGlpfSDHMKVMs8EyBKU0NayskXx3x+IVr0Gr+Uo8CjRmnk5ilJa4EkUSSEDn
         9ykvc0nHrr3m5YoJB6GO7FcX3xtcECkbdymWw7nF5+oCt6itmFvI7DDTQt2vyKJe2HJn
         GBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351873; x=1724956673;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/YtNwLPh5pTk6gSo6t/PeLiCmJLTlpJ+ybh0IcUxoY=;
        b=uST6zf3m8gz4O2QotrrqluDEa4DxazWqz4qcDQ+nMbGZkQzSM41xzfkg2JHAgrnEBR
         yGm5KNEDy5UnTPqQ+wZbxU936PfHfOIW1u0wTHV0buDUD+L3aiRHe4KDW5k4cvKnGKHl
         SUntCTDNOaJo1aC1D/+HUFI4CqPEkINEuKoyLjlHfDSVjD+90xxuNc0t+MnK+AJmMJmY
         Fzsn9l5bHjLej8wJS5GKDXZlkIpMtb4uZiLPyxDjL5bEEI0erFZX955wil0bN/N49vJP
         GeCaB31KcokdgZxKtfG+8XBPczUFCYgo+zXuWNrw4LpP68We0qOw27XeTCmGT2Bhh4C1
         KO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0ktKJ2/sUWR9EfKb3ydVz1F9zovwey7G3ikPV+824LFb/7ySPBlr2K5PLiYVpwviofQYGkg==@lists.linux.dev, AJvYcCWdc9xv9l5+S7DiYbw2udjb8NpWoKQni7uROf0fe5caYqBXJ3aOpUvvjxvM+TSCuDw4CJl89QBkMh7YYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVHbG5ZiDgCUYULpvEJQo3WMwH+M7ZGSfmX5TupXrSiLsykMRt
	CMgnnpudYZtRHqkxlNmWM+lDg/pkgDaCKl9BECzZBTFq7zCqXW0B
X-Google-Smtp-Source: AGHT+IHsbZYUaJ+JFNxFtzKvzmApZirKvGrVSmexHXzuMk4WrKRW/BVna5OKSIa9Rz2aGy+9FiDPnQ==
X-Received: by 2002:a17:902:e84a:b0:202:1529:3b01 with SMTP id d9443c01a7336-20367e651d0mr80002225ad.39.1724351872813;
        Thu, 22 Aug 2024 11:37:52 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:52 -0700 (PDT)
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
Subject: [RFC 6/7] nvme: Move BLK_MQ_F_BLOCKING indicator to struct nvme_ctrl
Date: Thu, 22 Aug 2024 11:37:17 -0700
Message-Id: <20240822183718.1234-7-mhklinux@outlook.com>
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

The NVMe setting that controls the BLK_MQ_F_BLOCKING flag on the
request queue is currently a flag in struct nvme_ctrl_ops, where
it is not writable. A new use case needs this flag to be writable
based on a determination made during the NVMe device probe function.

Move this setting to struct nvme_ctrl, and update the only user to
set it in the new location.

No functional change.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/nvme/host/core.c | 4 ++--
 drivers/nvme/host/nvme.h | 2 +-
 drivers/nvme/host/tcp.c  | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 33fa01c599ad..f1ce325471f1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4495,7 +4495,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
-	if (ctrl->ops->flags & NVME_F_BLOCKING)
+	if (ctrl->blocking)
 		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size;
 	set->driver_data = ctrl;
@@ -4565,7 +4565,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		set->reserved_tags = 1;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
-	if (ctrl->ops->flags & NVME_F_BLOCKING)
+	if (ctrl->blocking)
 		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size,
 	set->driver_data = ctrl;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ae5314d32943..28709f166cab 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -338,6 +338,7 @@ struct nvme_ctrl {
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
+	bool blocking;
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
@@ -546,7 +547,6 @@ struct nvme_ctrl_ops {
 	unsigned int flags;
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
-#define NVME_F_BLOCKING			(1 << 2)
 
 	const struct attribute_group **dev_attr_groups;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9ea6be0b0392..6b9fdf7dc1ac 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2658,7 +2658,7 @@ static const struct blk_mq_ops nvme_tcp_admin_mq_ops = {
 static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.name			= "tcp",
 	.module			= THIS_MODULE,
-	.flags			= NVME_F_FABRICS | NVME_F_BLOCKING,
+	.flags			= NVME_F_FABRICS,
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
@@ -2762,6 +2762,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	if (ret)
 		goto out_kfree_queues;
 
+	ctrl->ctrl.blocking = true;
 	return ctrl;
 out_kfree_queues:
 	kfree(ctrl->queues);
-- 
2.25.1

