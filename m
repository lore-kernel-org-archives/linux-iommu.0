Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8B1F0E44
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458942; cv=none; b=b5uwoeuEqpTw7AlOHZA/tnkkzIcTd/3BIF2euubu2oTu0ocqFl0EC+T0Rca+oBjYpXTZHetGKBV148M8sx7vY6rTz97+qjUg2xB9Aaxkubge6L1lexrL/lzLrvFzdxvQRhW54rggxufovlgEQV0rlxGFrSlOyt5A6EeoFvP/vKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458942; c=relaxed/simple;
	bh=Bo0v5aRaDzPqvoydQcrBJPn7q9FSqKp9DJF3+UnQwoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlgI6Bwb4fFJNi/C2iaRHIgw1WyPeI8iokLl8fJ3oSTa7xyoNn/mliW38q9AvEonFVD9AwVYtftoYcAgsRFxIxITbS6+KiuX1T8F5ROpM9cr7bBbH7LtMTW4+6ZEa0DjmQmd+T/h1/nyhOWbQe003qniidpAInqJDF4/HcosRys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ+yOF2/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ+yOF2/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb95317so97646635ad.1
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 03:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737458940; x=1738063740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5a4wofP0E6vgMXtYk2R7pF6NDbjnXiV9YnBTUjkP3o=;
        b=gQ+yOF2/+oY+F9AogZw54OhAELt2E8tsb2WrdHcieBIRrDnblt/x5Puma8gFAICJ8b
         LwIs5nubczqHU2NYc4KQWniMYMXai9OYtzWmlEsEStyIAJIvBpT9BrVfSXu1CTojL3cN
         4Z04qZMdXsFffj5P4xttvxJB18k3Sepzz0+FYCB4nlxIh9FjArcCKk8ClgXSC8c0lUkl
         LwKkBaNjrP1NVgqvve5ZcVTCKC00ZRvJS9AkBXPWJH+oViPMYJvptLk7M8y+e717EIoc
         rFz2BopWqJMSmDI0RHKFuM+d1KXVl70UKy+z9XnGItSCXsPDjGamdebiolk18TJ+3QnT
         W2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737458940; x=1738063740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5a4wofP0E6vgMXtYk2R7pF6NDbjnXiV9YnBTUjkP3o=;
        b=n82YmmQQxn1zBfCPFC2WTvX2Ythj9nW5sFaPKww87WrEtO3EgI5rKnuMlC1R05RE6a
         WxAJvnGxFJC2IkW+d7dQZl6n9Bk6V8QKkHjX+TuwEIsrm5clzWbWyhbvjHHbuZspacrI
         SQsIO4JiyxcTGL7xlbk0cfxD6Sai0GGjzbitXfM7rP6ZfMzL6aIfKLEmtQ10VERh5N9G
         rn2AkoL8Tfnb1ry7XWnRZg9dMmXtmgg56W54BZJ9SUN+DuJScT2E1NtPfWHEqhuVtLEM
         6k0p8E14ZOKqajYwVnS9DpvCPotO6xNijoO2BJ+egFQ8xZQW0Gavk9KDJQcat75yJhvR
         uupg==
X-Gm-Message-State: AOJu0YxzO6pnd7yJ8B+i/P4YcBA4I+taJUueofPgUt0lLSvBUN8L7aDj
	pwAh7Jutpxj1ld5mxh29zfqU7eLDxuCeYAmqJv6QO4em1zBo27Kp
X-Gm-Gg: ASbGncu7ZeHFmdZlOsdZySiSSX8ltWfPcMnV866dTereX9rAIoMsw9dYafs/naINUhq
	pjOcSRR0ZyuKhgw3IqZDjOKffo3TYRN6WTwLLRJK46BuuXwDqFvTTL+nmVepF1tBAyv7ij9qurF
	9z0ccw0ycGSAR603NndBOr9uMWeRLM77j4diSChRFM7CJZZ7ehkjNS0Vv9aKLrqs62RDEEIjFu0
	sFA8vCZXlooP6W9ajGHDDUMMDY+vjYwwWn+GoF0sR8EfEGLSqs9WdxCgRYkf62Crb7FEYwN00JE
	yFCx+FoC
X-Google-Smtp-Source: AGHT+IEnO0MUrq69t5u503b7yFJyykRzPXOMC4CCZR6vu5qS1x/UI2lZ7qnZuoxHX4BSZoPVYb0Xpg==
X-Received: by 2002:a17:903:8cb:b0:21a:874e:8adf with SMTP id d9443c01a7336-21c355dc4eemr248202715ad.45.1737458939824;
        Tue, 21 Jan 2025 03:28:59 -0800 (PST)
Received: from tiger.hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea1fdesm75385965ad.26.2025.01.21.03.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 03:28:59 -0800 (PST)
From: Wencheng Yang <east.moutain.yang@gmail.com>
To: east.moutain.yang@gmail.com,
	alex.williamson@redhat.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	joro@8bytes.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org
Subject: [PATCH v3 1/3] uapi/linux/vfio:Add VFIO_DMA_MAP_FLAG_MMIO flag
Date: Tue, 21 Jan 2025 19:28:34 +0800
Message-ID: <20250121112836.525046-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CALrP2iW11zHNVWCz3JXjPHxyJ=j3FsVdTGetMoxQvmNZo2X_yQ@mail.gmail.com>
References: <CALrP2iW11zHNVWCz3JXjPHxyJ=j3FsVdTGetMoxQvmNZo2X_yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag will be used by VFIO to map DMA for device MMIO on IOMMU page table.

Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
---
 include/uapi/linux/vfio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index c8dbf8219c4f..68002c8f1157 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {
 #define VFIO_DMA_MAP_FLAG_READ (1 << 0)		/* readable from device */
 #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)	/* writable from device */
 #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
+#define VFIO_DMA_MAP_FLAG_MMIO (1 << 3)     /* map of mmio */
 	__u64	vaddr;				/* Process virtual address */
 	__u64	iova;				/* IO virtual address */
 	__u64	size;				/* Size of mapping (bytes) */
-- 
2.43.0

