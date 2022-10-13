Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF73D9C;
	Thu, 13 Oct 2022 18:12:48 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id w18so5624549ejq.11;
        Thu, 13 Oct 2022 11:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oow4Z/54Ywu9hc74bLjW+CtYs8QrvcOSZ9QuyKFYcEc=;
        b=ED9AlBSj+HB3AoaKj7DQ6M9wpZ6f6w4GodqNMB1xfK/zk6oF6HLxanhqwuG7Fd6R3S
         Na43xZWDhuMEVhpRgGli0KufczMvg+iDIQia5e4MkKK7NnuzBjYr9uWV/zTXJ2FFJ9mQ
         CDyD4aWS4JrSGufnnIK1XfXmJDZocqpnWKg50JoUJhnQJlrDPJUjqGK+uFLhPwnvQaLm
         DgG4sQ4tmE0ckxaWchNtaudUhH51Q6d4aBK2QPPGJznLm1RAeOMbO6udAqa5gRk6vBbw
         nvOjXEF3+QAHeLVvYUsrPzaVR7kXWBH6YABlCbDTIH1fcLYhwp2wbMHea3TwU0W1rPJk
         mbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oow4Z/54Ywu9hc74bLjW+CtYs8QrvcOSZ9QuyKFYcEc=;
        b=nRQX1KibSqR6rKejiWoKpbUwabOS99rZmTUO4ng47R0zNRMZ8U2PCE2PETGwoTjaiV
         gr4ilZeD+UMVxnVeUPAOEHku1h9I7gqto/1Zy9Eww/XLXN3Z3j///YjiURsbojfX65t2
         L8bBMzBQRBetdz0eROxxvIXwUdTQXjC3NCi4z06kxZ4QkOwJ6sBK8iqYwi3XnSuKw6QU
         sFpWxNFSAvA3yzLpFo42klPQdbyypISW3Q5vtuhvgl6oMtG6WZ6w5bWYsR124KVfnT4P
         Afi1/m9sIOnVHVNRIs7AAquh68VUFoWn5/ryn5C3JBL7W61BNB3pKy4OssyHSg7ZCk7n
         cRHw==
X-Gm-Message-State: ACrzQf3HaRxu3n/S1hN9r59TOpnWWQvBfVm10+SoFoa/DbNYKdgd7aEW
	LIo8AYMItIkGKma+yMiG/Dc=
X-Google-Smtp-Source: AMsMyM7zbaKTyyrnltI3FlR5A/IP6LXwZcu3J1BPdc+HmT8j7TiQ8hkdI+Pf+LW56SPwakrGxverFA==
X-Received: by 2002:a17:906:3fd2:b0:78d:b793:5ef9 with SMTP id k18-20020a1709063fd200b0078db7935ef9mr730855ejj.496.1665684767259;
        Thu, 13 Oct 2022 11:12:47 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:46 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: maxime@cerno.tech,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	wens@csie.org,
	samuel@sholland.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/5] iommu/sun50i: Consider all fault sources for reset
Date: Thu, 13 Oct 2022 20:12:17 +0200
Message-Id: <20221013181221.3247429-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
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
index c777882d0ec2..38d1069cf383 100644
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
2.38.0

