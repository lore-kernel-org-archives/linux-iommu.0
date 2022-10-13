Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D93D9C;
	Thu, 13 Oct 2022 18:12:51 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id w18so5624715ejq.11;
        Thu, 13 Oct 2022 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEldd9wQdL+BNIpPagsN4syvK2Vu5z+yJRpIhSRKQMc=;
        b=qzluUBhJwWMerMPUe1gwWm6V5osUfex8TSHWUCaPokvqy+9fQRlP7jpgo9iflEUD6g
         clMX3iYM7P+JkEBVsDGWP/fJycFBwJwEj5F7/evQJKj89Q9Uq+rtrU5D8kLD3Ptz9o8W
         QGPC6LRUw4nVWr7SnJBkCg1O3NStZ/Bsmo/XcHOMkIUJNkLEjKN/2cGlflJjwhEtjDLG
         aVUbu9K3c9BXOsCY1+KOE1S1+NeKycL2yjfht2mOAaOSQDvmGRyMZH7+rF77Glo/k7LB
         ip6ygGlGS3didO4QLZtugOcfuvhQsFAyIWPR+8jGmCITGDyYQ9DxS+TGWikBtW/zo4qc
         DzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEldd9wQdL+BNIpPagsN4syvK2Vu5z+yJRpIhSRKQMc=;
        b=ebpGMq9jR5hYBLElUel1sN+uqR8BlzkxDwUdSzD2oOdQKYgsKqqVU0WhZGn+vUwEH0
         stOx4Fl/v8JmbjtoNE+YzsRzEWEyj5j6cGFZB7AtCfYI5Sbd2ETIxx+9nM5aQ6OuIwQC
         YvZiItEwpODlRiHKBvopK/higsn9nm4/WbUz02bFgPtLKR23asfyJV7HdeZx7AWTTm8k
         TbOKdjd3F50TBhsKRSpp4q1CGTOC4ID6iZafDCl6UZM3wUFLC5NUnopgIZlq5/i6goau
         O3mNxIlknAL2dUFRsNKmdbH1bsAtprMCw7XRU7Guq3J1OE7LpkJxJwRKHBS7ER63B2DD
         IriA==
X-Gm-Message-State: ACrzQf2tW8TXKhmFBSdGysTos5BUKv292b9DK7CUlltzE+EPhWBCjRPo
	RLnJNarY18Dvm0wIdLTGa5k=
X-Google-Smtp-Source: AMsMyM4KGX8o0jIoAtj6ooSj5qXqHN5XuDxpnQzzmUfbe78ND/6Vh84BPIfk+ap5UfNfS6dxEyMQNA==
X-Received: by 2002:a17:907:3d91:b0:78d:f675:5659 with SMTP id he17-20020a1709073d9100b0078df6755659mr766140ejc.92.1665684769534;
        Thu, 13 Oct 2022 11:12:49 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:49 -0700 (PDT)
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
Subject: [PATCH 4/5] iommu/sun50i: Fix flush size
Date: Thu, 13 Oct 2022 20:12:19 +0200
Message-Id: <20221013181221.3247429-5-jernej.skrabec@gmail.com>
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

Function sun50i_table_flush() takes number of entries as an argument,
not number of bytes. Fix that mistake in sun50i_dte_get_page_table().

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 135df6934a9e..7c3b2ac552da 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -512,7 +512,7 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
 		sun50i_iommu_free_page_table(iommu, drop_pt);
 	}
 
-	sun50i_table_flush(sun50i_domain, page_table, PT_SIZE);
+	sun50i_table_flush(sun50i_domain, page_table, NUM_PT_ENTRIES);
 	sun50i_table_flush(sun50i_domain, dte_addr, 1);
 
 	return page_table;
-- 
2.38.0

