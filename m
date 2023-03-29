Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E1A23
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 12:34:36 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso1956394wmo.1
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680093275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7k3Pknpt+FEvPFnkTWZnOtAOiCcWdoby7FCUyoCPirk=;
        b=eSTGarnH/zmuvSNqMiK+j3gUub4rdGlUmgMXGMZSB22aaAjp3aVRN/rirW64CE1pw7
         LmSkOZTkhgJ8KuBU4Q55udhOd6+/1Ifum5Z8t+uFsbHueg5TsR9ggN30Bl4DdelXSpZA
         LfKP/JNmNGkLwOokH+4tvwlvCXd6kVjDaVTBfJ+8FA2FjVZrclXbUVSFxmvkui2fZ5lT
         EI2iefa6zWJbr3TgvdTOT5U/bVnmAnNFE4VvD7YOPsiAMnjvN2tGweJnxGVPD2XJ5qxj
         rVonai3gldWgqeFtq3fbqj8AYIg8uiMtokiW7E/Y4QR6hmS9yaZTkGlZu1ZT6TkhGbcX
         Fo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680093275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7k3Pknpt+FEvPFnkTWZnOtAOiCcWdoby7FCUyoCPirk=;
        b=OO+HVX+xcRMRdLEzpnTX+doxeexnujd67UrcSCiLj3a5wzhNeCtymYR8JFXY0bkWv+
         5W/FfVpd8Cb/Bbj8RFa8s/s34HwOAUJltUiNl0fHY9t6AN41yDP/gbGHbRdpBXipORLX
         HXbA+Octn+/IcmXx0SZ9+WSDD0hWGPnrgnTE2L9TuYVgfcPEuXAxF27BS/Ul+zHZ+KVo
         Zi78gHBd85xo5csWbDDQ+hRqXC4GS/BPe+nlNiieoKAQRmi54GPJgKqH/N5iLK7DYZgl
         ZH+TasX7ScQVY7qdvORf4q1SInE4CrH5FMFAdw0+DXbZ3AE25a17gvCNd4O9B9WOEIM2
         ByPg==
X-Gm-Message-State: AO0yUKWMfyqtqHTfDoSt/iRF/3FEKPzIbocMSWqUaB4v4Of27uucMSF2
	v6txJwsZBgJRMEvhvxgPYvY=
X-Google-Smtp-Source: AK7set9CwcmF1pMBPEcBJD7EKQVp+E6VRC0xGZObxJ2FH27ScUsoi1HLiTGPjJXd0Fet7MkW06Qd1Q==
X-Received: by 2002:a05:600c:21d8:b0:3ed:2b49:eefc with SMTP id x24-20020a05600c21d800b003ed2b49eefcmr15666798wmj.3.1680093274790;
        Wed, 29 Mar 2023 05:34:34 -0700 (PDT)
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id b39-20020a05600c4aa700b003ed29189777sm2167726wmp.47.2023.03.29.05.34.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Mar 2023 05:34:34 -0700 (PDT)
From: tomas.krcka@gmail.com
To: will@kernel.org
Cc: Tomas Krcka <krckatom@amazon.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any
Date: Wed, 29 Mar 2023 12:34:19 +0000
Message-Id: <20230329123420.34641-1-tomas.krcka@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomas Krcka <krckatom@amazon.de>

When an overflow occurs in the PRI queue, the SMMU toggles the overflow
flag in the PROD register. To exit the overflow condition, the PRI thread
is supposed to acknowledge it by toggling this flag in the CONS register.
Unacknowledged overflow causes the queue to stop adding anything new.

Currently, the priq thread always writes the CONS register back to the
SMMU after clearing the queue.

The writeback is not necessary if the OVFLG in the PROD register has not
been changed, no overflow has occured.

This commit checks the difference of the overflow flag between CONS and
PROD register. If it's different, toggles the OVACKFLG flag in the CONS
register and write it to the SMMU.

The situation is similar for the event queue.
The acknowledge register is also toggled after clearing the event
queue but never propagated to the hardware. This would only be done the
next time when executing evtq thread.

Unacknowledged event queue overflow doesn't affect the event
queue, because the SMMU still adds elements to that queue when the
overflow condition is active.
But it feel nicer to keep SMMU in sync when possible, so use the same
way here as well.

Signed-off-by: Tomas Krcka <krckatom@amazon.de>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f2425b0f0cd6..7614739ea2c1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -152,6 +152,18 @@ static void queue_inc_cons(struct arm_smmu_ll_queue *q)
 	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
 }
 
+static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
+{
+	struct arm_smmu_ll_queue *llq = &q->llq;
+
+	if (likely(Q_OVF(llq->prod) == Q_OVF(llq->cons)))
+		return;
+
+	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
+		      Q_IDX(llq, llq->cons);
+	queue_sync_cons_out(q);
+}
+
 static int queue_sync_prod_in(struct arm_smmu_queue *q)
 {
 	u32 prod;
@@ -1577,8 +1589,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		    Q_IDX(llq, llq->cons);
+	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
 }
 
@@ -1636,9 +1647,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		      Q_IDX(llq, llq->cons);
-	queue_sync_cons_out(q);
+	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
 }
 
-- 
2.39.2

