Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB47481;
	Tue, 25 Oct 2022 16:54:36 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id a14so19353586wru.5;
        Tue, 25 Oct 2022 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XVDf5CNGXohyTDwQXIUTQefWV+zveKEvdiJ0iEMiCo=;
        b=nWWvtDEnIFtSZIk2LCzs577LelT3TwOr923486IySggt0BodjQKLBytOshOzTgOkYW
         ShmNzTVUSj8yF8YpAsjkfXnqZw9wZ5Uxu9cFvPR9mPLSpXrh+BkPuGjsXfVTCZW1lhnx
         0nTXG8MyhhmQg8vNm8SyUcRZLE8mXL8mUBGwSQHSBzwib4mvgtW7KuJzCIXJrps8u9xz
         lEykKyUDhLTep6wRxxb1huTpc2j03/jY6taCCgvFu/pOHj1NuUf4lp0rjTTClFpPNGUX
         f7e54GNHC3jhmlr7DPiVXmhJPTzx5nKyRS2lKAXqqXmREcNaaQYCs2/OmzZLNBHc8nHX
         604Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XVDf5CNGXohyTDwQXIUTQefWV+zveKEvdiJ0iEMiCo=;
        b=7PP5STZxThl8o1ylCiYqZuxFK/R4VnAfBAlHNQDoUIMWw9fgoTNBAxe7cfwFvlx35Q
         IYK/RgvNPi5hBl90UgEONzIPLO8IOCbGJsOkLgxP/pUVZUEWcvTlBWBeON4dnfYB7ZE+
         QUP0GLZBhVDszkpuHyGphWADnzgSBfVeCXfFMhbl9S2DENzcuExoMS2u9B/WsWmzc6Vz
         L7rduYs6Tt1PIUWRsJyYYuGXC4hZU8o0eRnSQ5v1u+Z8hIhEC317C9skrBfXltmc4ce9
         AJT6dA9QFpbXYavFYe5oWTkbHgdWiKnzcjYMLrBDuvRMYa9JTV75qF+Ab4jaApTIZT8C
         cfgQ==
X-Gm-Message-State: ACrzQf2JRRR1F4tamYrk9DNZ2WN/toEzePkagOhVt8EYbYLp21Ntcy8t
	WhvwXNr7jktXqUCzKUMghOw=
X-Google-Smtp-Source: AMsMyM4URGw014tILeGzQZ66S57zVWE5z6thpheFKt2ksgimTOOtljhHjSVf/MlhT/s/B/o2zDdIQA==
X-Received: by 2002:a5d:6dcd:0:b0:235:f087:fec2 with SMTP id d13-20020a5d6dcd000000b00235f087fec2mr18867780wrz.444.1666716874910;
        Tue, 25 Oct 2022 09:54:34 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:34 -0700 (PDT)
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
Subject: [PATCH v2 1/5] iommu/sun50i: Fix reset release
Date: Tue, 25 Oct 2022 18:54:11 +0200
Message-Id: <20221025165415.307591-2-jernej.skrabec@gmail.com>
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

Reset signal is asserted by writing 0 to the corresponding locations of
masters we want to reset. So in order to deassert all reset signals, we
should write 1's to all locations.

Current code writes 1's to locations of masters which were just reset
which is good. However, at the same time it also writes 0's to other
locations and thus asserts reset signals of remaining masters. Fix code
by writing all 1's when we want to deassert all reset signals.

This bug was discovered when working with Cedrus (video decoder). When
it faulted, display went blank due to reset signal assertion.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index cd9b74ee24de..270204a6ec4a 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -27,6 +27,7 @@
 #include <linux/types.h>
 
 #define IOMMU_RESET_REG			0x010
+#define IOMMU_RESET_RELEASE_ALL			0xffffffff
 #define IOMMU_ENABLE_REG		0x020
 #define IOMMU_ENABLE_ENABLE			BIT(0)
 
@@ -893,7 +894,7 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 	iommu_write(iommu, IOMMU_INT_CLR_REG, status);
 
 	iommu_write(iommu, IOMMU_RESET_REG, ~status);
-	iommu_write(iommu, IOMMU_RESET_REG, status);
+	iommu_write(iommu, IOMMU_RESET_REG, IOMMU_RESET_RELEASE_ALL);
 
 	spin_unlock(&iommu->iommu_lock);
 
-- 
2.38.1

