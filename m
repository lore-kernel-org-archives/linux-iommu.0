Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CADCA35
	for <iommu@lists.linux.dev>; Thu, 30 Jun 2022 06:40:15 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id n8so11252262eda.0
        for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YRjk+I1tOU+IE/aXdonB59E6sy7aNXVn8XEDauefqQ=;
        b=CrZpADPV9qdNUMyNR0WCBSyyHAhUtDgoCe0NWzMNFi7M0+7nQsggCNreJqHql8H0fW
         KlM22JXiYUrKpr5EJ6rPKnNYXjnARkmT5KB4NB/pCauB+Th4HD0raxHvl2s5mWV+3lCm
         zKjto8Ywx97VLoTHMQqZGZbOjpJ792BwqAqHE9tXD5QOOFY2LVyk6NqsGsJWAz7hziTA
         4Vb1pWTLsq7a1L0ezJz/P61elhmqGzWJ0UixxQAVgqv8biN+mLnS4NwvBP7Ly73s1ZyK
         PVskO49lOWESGRRH/ESlnaQ3KWrWC331sruD+A1XHMOePno/2SStnsvFH6rkf+tvQFSy
         LFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YRjk+I1tOU+IE/aXdonB59E6sy7aNXVn8XEDauefqQ=;
        b=L0MYb75H8TtUSLHFbcFvWPPNTXCTxJlyOQ4qopsAUcAru0RpZnU6ylbRiPPMiDbgNm
         KYi1SRA9BjQK/zukppDGnmTYdB2yA6swD4GeEyuAEM0jNuiFUIO6T0vmafNP/6sRPXgy
         EnLMmErsFNI0STjhsZa+qChwjor1E3C2F3OQhSk9ikwxJQVvRBTnfB0eW89hx3MNkN+F
         Sn6a8cPANWsdqcNPfmQouJJJpd8v0CFprK87L2XT5HPdWjq8bprgWyMo+06md2RZKAI7
         oGbSD+dOdWgcWnK4eohdSO4mO/68cWYnymaYvTD8LJ/ohShJAfJmblAMRbo4yt2pxWL6
         OEBw==
X-Gm-Message-State: AJIora9fF1MIBK9dIVJZfA7rUh0Vyirhtl8Lua2cZGRxxLCKjVf/LqTb
	F0YqfZ5StByGfzybPqE3I0c=
X-Google-Smtp-Source: AGRyM1vRJhE//LmjjGmIeJh5OLMJsvM8XsEeSlrk8TO1LDZBLk7KUtQzYrQE/U3WiDU0tnr5r4BYPA==
X-Received: by 2002:a05:6402:50ce:b0:435:a2bf:e44d with SMTP id h14-20020a05640250ce00b00435a2bfe44dmr9465489edb.386.1656571213480;
        Wed, 29 Jun 2022 23:40:13 -0700 (PDT)
Received: from uni.. (adsl-146.37.6.170.tellas.gr. [37.6.170.146])
        by smtp.googlemail.com with ESMTPSA id g4-20020a170906868400b006fee98045cdsm8834469ejx.10.2022.06.29.23.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 23:40:13 -0700 (PDT)
From: Xenia Ragiadakou <burzalodowa@gmail.com>
To: will@kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix undefined behavior in GBPA_UPDATE
Date: Thu, 30 Jun 2022 09:39:59 +0300
Message-ID: <20220630063959.27226-1-burzalodowa@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220630063959.uUw9C4QyQUZ9fENeN75WP0qWmMFL3pbOGh43kRKvyh8@z>

The expression 1 << 31 results in undefined behaviour because the type of
integer constant 1 is (signed) int and the result of shifting 1 by 31 bits
is not representable in the (signed) int type.

Change the type of 1 to unsigned int by adding the U suffix.

Signed-off-by: Xenia Ragiadakou <burzalodowa@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cd48590ada30..44fbd499edea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -96,7 +96,7 @@
 #define CR2_E2H				(1 << 0)
 
 #define ARM_SMMU_GBPA			0x44
-#define GBPA_UPDATE			(1 << 31)
+#define GBPA_UPDATE			(1U << 31)
 #define GBPA_ABORT			(1 << 20)
 
 #define ARM_SMMU_IRQ_CTRL		0x50
-- 
2.34.1

