Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C11D0DE7;
	Thu, 22 Aug 2024 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351873; cv=none; b=A59TKIIM1tRZBDK0+q33KKMVAVv2L9o/qJ+vc+0mJkPeRI0xMjr/4VGzDo5oJAC281fo+4zYmawh8Ojtlgu5AwTOnlFn9CLZs/cygkaOkeybXymrhpAUPSzXrforbWe5FaQgib9wc8A5gvOlkcwcbn1PnOLT1yVVEn9NIxKocBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351873; c=relaxed/simple;
	bh=htxc2DqPCapb6n7XzlxbqGRMERf/FZW0+ZevZ0VUTwQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ct6TOn77tv/TX4ffr+dz6LrlAw+vixa46+YiUX8Jvr74pCWaPcKBofVIBpu/lziWdI7WUgJ1argiGuD2kJuAWmH+KC+RuHGV/nMrhBzIA/wdpLeVrWjkDc7f4W9kLsjG1XL2VG/jbuZkq35+l1YPGwSW5PN5De85spkr3RBCqCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRq+4TGD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRq+4TGD"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201e64607a5so8719935ad.2;
        Thu, 22 Aug 2024 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351870; x=1724956670; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FSttR6p2yucCC2C1ycZHoGqThcAXEf4kSal+8QkByQ=;
        b=IRq+4TGD7901/TtslH32On30QUc4oPUxkitGoY+YfgrNYnVUDt3ZM/ZXUTCrERIKFt
         Y25zSvgf72Run1+hCCT202heqjEu5Dzu7fRuJH085b8x2RQT4N8QEZaDfJtHBllU6mji
         HqdS2DZkbn/cGvJuAowDe0FoMn96S9cdp6AEUwAUk+0p22KTgisCjAdEp86PUEyApi7V
         UsH/eLXcISneRa0au1cCJmU/4rVp6FZi6DmRbWvp342Zt7BVEMwHtt8NrPIjF87RgiMD
         sH1rFS4bqfn2QYH17vsEa1amAkMz0vQeib8nnGvBENvp3L+9bfRKmdCv+T/1aEjErXcu
         MF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351870; x=1724956670;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/FSttR6p2yucCC2C1ycZHoGqThcAXEf4kSal+8QkByQ=;
        b=TI+2eBXIKDMPI9PDJHrl/PWzdVC/M7739ixSulkVHVmzFBs8gzUaWlpNuyZzuilMj/
         H8rQh5C9D9gV4zGDZPIIFwb4zbnPwhTQNSOCMHgs0h7MX8mzVgYW89OBeJ8GE93uwCB9
         aKknTQ5IYXoMAyvyUiUVWNUGEQtI7wUDQirnMDkVXFNgW4+5YIiLM5wPGQ//t8rrs0uK
         c+a3n1AEBXU7DD1v8ipMvkz4mFyCHhM120dQr/nRMFY2o5UrRQ+rk/zZXt3JryNdCyVI
         o8dTFcoqC4It+rEU21slDbQpOE47/3mxwZreIsyUPxDwE0H5BmOx9IZXrIrmWmI+hrRV
         TvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb47xV1EAvEVfhRp0KCWDenq//X37ZDYXDF2KJC60J2YwaIv0DPEW4WybODt7TNFmRWrifiGnaCwzjIA==@lists.linux.dev, AJvYcCXxu9L1iVs7gKp3U7FfP61h2mj9L9wiFSc15zKZWtOB+s+DPIQYV8OKpbMRrt1rjUUV8oeRsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFNCr9Zv7YT5eJ7LroqIJRXHB0+eGco7bDU4GDBzIoPuoYSTZE
	Y0XpdI8MaXzbEYwN7Iyqex/f3suLfVPPvxe/ml+J5AZoloSBj0M0
X-Google-Smtp-Source: AGHT+IG0xFiyyhUEAVqUeNP4awQwMQmb0ao3xlY9kk2g+DZ4RUL1iV7dvaFZrYLPjHsqT4Fbvb/IyA==
X-Received: by 2002:a17:902:ce85:b0:1fc:6740:3ce6 with SMTP id d9443c01a7336-2038822be0cmr36095425ad.20.1724351870494;
        Thu, 22 Aug 2024 11:37:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:50 -0700 (PDT)
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
Subject: [RFC 4/7] scsi_lib_dma: Add _attrs variant of scsi_dma_map()
Date: Thu, 22 Aug 2024 11:37:15 -0700
Message-Id: <20240822183718.1234-5-mhklinux@outlook.com>
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

Extend the SCSI DMA mapping interfaces by adding the "_attrs" variant
of scsi_dma_map(). This variant allows passing DMA_ATTR_* values, such
as is needed to support swiotlb throttling. The existing scsi_dma_map()
interface is unchanged, so no incompatibilities are introduced.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/scsi_lib_dma.c | 13 +++++++------
 include/scsi/scsi_cmnd.h    |  7 +++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib_dma.c b/drivers/scsi/scsi_lib_dma.c
index 5723915275ad..34453a79be97 100644
--- a/drivers/scsi/scsi_lib_dma.c
+++ b/drivers/scsi/scsi_lib_dma.c
@@ -14,30 +14,31 @@
 #include <scsi/scsi_host.h>
 
 /**
- * scsi_dma_map - perform DMA mapping against command's sg lists
+ * scsi_dma_map_attrs - perform DMA mapping against command's sg lists
  * @cmd:	scsi command
+ * @attrs:	DMA attribute flags
  *
  * Returns the number of sg lists actually used, zero if the sg lists
  * is NULL, or -ENOMEM if the mapping failed.
  */
-int scsi_dma_map(struct scsi_cmnd *cmd)
+int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs)
 {
 	int nseg = 0;
 
 	if (scsi_sg_count(cmd)) {
 		struct device *dev = cmd->device->host->dma_dev;
 
-		nseg = dma_map_sg(dev, scsi_sglist(cmd), scsi_sg_count(cmd),
-				  cmd->sc_data_direction);
+		nseg = dma_map_sg_attrs(dev, scsi_sglist(cmd),
+			scsi_sg_count(cmd), cmd->sc_data_direction, attrs);
 		if (unlikely(!nseg))
 			return -ENOMEM;
 	}
 	return nseg;
 }
-EXPORT_SYMBOL(scsi_dma_map);
+EXPORT_SYMBOL(scsi_dma_map_attrs);
 
 /**
- * scsi_dma_unmap - unmap command's sg lists mapped by scsi_dma_map
+ * scsi_dma_unmap - unmap command's sg lists mapped by scsi_dma_map_attrs
  * @cmd:	scsi command
  */
 void scsi_dma_unmap(struct scsi_cmnd *cmd)
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 45c40d200154..6603003bc588 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -170,11 +170,14 @@ extern void scsi_kunmap_atomic_sg(void *virt);
 blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd);
 void scsi_free_sgtables(struct scsi_cmnd *cmd);
 
+#define scsi_dma_map(cmd) scsi_dma_map_attrs(cmd, 0)
+
 #ifdef CONFIG_SCSI_DMA
-extern int scsi_dma_map(struct scsi_cmnd *cmd);
+extern int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs);
 extern void scsi_dma_unmap(struct scsi_cmnd *cmd);
 #else /* !CONFIG_SCSI_DMA */
-static inline int scsi_dma_map(struct scsi_cmnd *cmd) { return -ENOSYS; }
+static inline int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs)
+						{ return -ENOSYS; }
 static inline void scsi_dma_unmap(struct scsi_cmnd *cmd) { }
 #endif /* !CONFIG_SCSI_DMA */
 
-- 
2.25.1

