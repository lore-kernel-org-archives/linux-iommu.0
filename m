Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBE7479;
	Tue, 25 Oct 2022 16:54:37 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id bs21so6256650wrb.4;
        Tue, 25 Oct 2022 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxmsLKzFVvKcS3WMj1YQZz1vx7/2bMhWnQ94H0bmWEY=;
        b=Nykt+sLEadPMO+cbi45gb3Ye9NF4TPpULSSO3kp+XegRbPdux6w/+ZO3CR3SXQRW8I
         R3TuAZZf1w7TrwlmiHAZ86B2JWU42B4iOt8JBUaz6eJeiBBy1XkUogeLCwFtGfszG9uR
         Z3rcrOhRdGx2cafEhzZkq8e1iQe9O7MFXbfFvujOvM5KHs0wioEYKntJ/BBvMa941RoX
         +hpKjDKTz1JH+yS0JdHZ4RzjqXIc5ObsolSvx7vq9a++fXRWX1RlSr6DmT9rqchhO4LG
         KvJzUCvEhmdpE1rxgBVZ1ozzNn44JG024aTd8a59jr+v0PkKHBZ0JwY5do5aEDVyYWDQ
         UwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxmsLKzFVvKcS3WMj1YQZz1vx7/2bMhWnQ94H0bmWEY=;
        b=Zo8dUyCgDBEh4nxEfb7W5jq8NW4O3JW/XcXzNsvJXo2R6KpHEB/cCk75ANqV9u828H
         4GuKdnyfkbBrSa7r3U3b81q6JWzCJvrT6h57hWZyD2ZkvCXMwDMfAI6TqELLSRl0CVSg
         ZvolP0H16VnYPEtwFEP3pfiRxf1k37yrDphvnxUGUyE3iSQ6N2R7U2nHtwEt4mMmx4VY
         BMfgWznRkZwXWijJd04YmaUYTQBqeDs1iVc6/oJkbQ+w+X+tF1LKW5Whxwu6bhFO5xUL
         9vUJMknSqQYSM8ieukR9Di3O3288s7UzLheL0oP6m8UxdG0756aTFFJcN/yKawS758J4
         yNmg==
X-Gm-Message-State: ACrzQf0FvPQeTtdxmBVSgmRIpKtt5rIYKCitP51UhADdnUXyKn1p5/2C
	slx3fPm1Tt+jfI3SXia1xgeIZ5sUujK0sg==
X-Google-Smtp-Source: AMsMyM4kPGoX2AJWIBlWQttHFd0s9iY+Inu6HTE/NlV0jO9C0/NXk1FfdKL8gAxUmJyeRSU69QkXEg==
X-Received: by 2002:a5d:42c7:0:b0:236:4ddd:3576 with SMTP id t7-20020a5d42c7000000b002364ddd3576mr18079744wrr.289.1666716875926;
        Tue, 25 Oct 2022 09:54:35 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:35 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: maxime@cerno.tech,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: wens@csie.org,
	samuel@sholland.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 2/5] iommu/sun50i: Consider all fault sources for reset
Date: Tue, 25 Oct 2022 18:54:12 +0200
Message-Id: <20221025165415.307591-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025165415.307591-1-jernej.skrabec@gmail.com>
References: <20221025165415.307591-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have to reset masters for all faults - permissions, L1 fault or L2
fault. Currently it's done only for permissions. If other type of fault
happens, master is in locked up state. Fix that by really considering
all fault sources.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 270204a6ec4a..bbc269500800 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -869,8 +869,8 @@ static phys_addr_t sun50i_iommu_handle_perm_irq(struct sun50i_iommu *iommu)
 
 static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 {
+	u32 status, l1_status, l2_status, resets;
 	struct sun50i_iommu *iommu = dev_id;
-	u32 status;
 
 	spin_lock(&iommu->iommu_lock);
 
@@ -880,6 +880,9 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
+	l1_status = iommu_read(iommu, IOMMU_L1PG_INT_REG);
+	l2_status = iommu_read(iommu, IOMMU_L2PG_INT_REG);
+
 	if (status & IOMMU_INT_INVALID_L2PG)
 		sun50i_iommu_handle_pt_irq(iommu,
 					    IOMMU_INT_ERR_ADDR_L2_REG,
@@ -893,7 +896,8 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 
 	iommu_write(iommu, IOMMU_INT_CLR_REG, status);
 
-	iommu_write(iommu, IOMMU_RESET_REG, ~status);
+	resets = (status | l1_status | l2_status) & IOMMU_INT_MASTER_MASK;
+	iommu_write(iommu, IOMMU_RESET_REG, ~resets);
 	iommu_write(iommu, IOMMU_RESET_REG, IOMMU_RESET_RELEASE_ALL);
 
 	spin_unlock(&iommu->iommu_lock);
-- 
2.38.1

