Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16524402;
	Thu, 13 Oct 2022 18:12:47 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id g27so3724791edf.11;
        Thu, 13 Oct 2022 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy++TP4MEmK9+IncYVXW5dpqxIdw3c9kXrFdre+ha14=;
        b=CQ9TnzAPgu0twXcz51eJtm0MYyiV+U12yy5ia/sBn3YqCfoEQNZbJox/YeWnpaIBoE
         TYEM9Hw0EGjn2tXKlAWjrkaORyfaKwcar28Ec7NSFIeLYAllGCqNh2pU2PYx3LxsqxFG
         6z6XuuKosJtWm6yPV0CdYsnYS7GdnBmUj7R82Ws3yOFTwaIxD32pVpcKhNvW/hq4azh/
         pyxMhT+TJGWjw77Bz/d7ZlNR59kXaW9mCpfOPX3rRypwf8LOMd1e3Oc7h8YH1pyz08E5
         rppEhw2WHhCkDKW3evmIBSWV1bQ5vA0vM4LjoFtItLlNwt+gYHNoOtSigZItkYpjUT00
         NUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy++TP4MEmK9+IncYVXW5dpqxIdw3c9kXrFdre+ha14=;
        b=ivhmWynwLVnp8veJzvPHPloZY+CLksc91HSBl/JwemG6PQh95lBy4fq9H6SQd1FgHD
         clvQzL5qz6h54t7iRy4WnDWTApg1dLAxlFsY21yl35xVKqKifsy0473gGNQITsjUdIDu
         r49p6HmTsAOTqeTkVxfNEDBozbwoFGKxMDMN3CCMqhlqHaz+TTazSLyXjf2dY84hMzs/
         w0FDxI4uiZnWJxwcjN7yAYjOQFzrQl7/BtHBsVRC8ig3Z3HARcEw+R162PNIqO//1H2h
         2hyIxWVLaBRka/NIkHNVmFC6OWzIdMmIYgXMXWWZoF04FDJ0rNeKkEOg9T+Xhx8Sx2ZZ
         7ELA==
X-Gm-Message-State: ACrzQf1z6XjFE0Q6/IwgzRqeR0im8jajKaNhiiFNQdt9jeM5TY2/TZp/
	TWdTVVToh5cbs3NtZDRvavk=
X-Google-Smtp-Source: AMsMyM4ICzUCjoigsNUFgWVeKqBHqBJ1tuJkf0WbPLqftDEHH2D+3WKsfapHPDp486t6zWZt35VE2A==
X-Received: by 2002:a05:6402:1944:b0:457:fed7:5c30 with SMTP id f4-20020a056402194400b00457fed75c30mr873109edz.278.1665684766034;
        Thu, 13 Oct 2022 11:12:46 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:45 -0700 (PDT)
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
Subject: [PATCH 1/5] iommu/sun50i: Fix reset release
Date: Thu, 13 Oct 2022 20:12:16 +0200
Message-Id: <20221013181221.3247429-2-jernej.skrabec@gmail.com>
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
index a84c63518773..c777882d0ec2 100644
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
2.38.0

