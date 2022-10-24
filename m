Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827707B
	for <iommu@lists.linux.dev>; Mon, 24 Oct 2022 13:43:04 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id t4so6594894wmj.5
        for <iommu@lists.linux.dev>; Mon, 24 Oct 2022 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRj1cqu6ZDGIi0GvzZmHfr4LAYPZfxkfNSfRcqY4dyA=;
        b=NHcjGBQp4SKHvwjl+StT6XdDtmgvDaf23lrNvgs4/Cn8kibjjcgons46bofssI5bg4
         x7sOB1WLbd3o0NjfwMBtCYpcl/hI5sN6jcnbygYLyY4nZeFKxt3NxFweiGXKUXvnr1QR
         FmPNn2XpFYKJeHOEQXVAZ3BRqh4XFT2uj8wVsagBC+LWXhp36OaEHB65n2BUSy2iIf1T
         hNyyJ4vwX1dW3B5s6wCpTLxfN9oVWOFAKJQM7cedbgX45oZAgU1PV5CKh2zOp/JbXTLn
         YlpbSPvfA+k1z/qm2zNxIbLPwqfpimplvFzS5aFy7CC8xD9e22k/sqviP086EXl2i2e8
         DjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRj1cqu6ZDGIi0GvzZmHfr4LAYPZfxkfNSfRcqY4dyA=;
        b=KHRyL3yRmFUvnlURPOe29R0XKKqzatpD7k6Yl6ZA+wpJWChjg+jE3uiTmnp2EPkNmt
         0c0IdU7NNaaWRS+fQeqH3iwPMVRwzBNfpyiIqftGhs6bD+leWyOewzngZpMHxs1PsJb3
         KAl19ybhiUV8ixJuIyjGRfvF3K2utyUKhhIgGJy83582Tu5dB5X74RBPQphLRc4zhRV0
         SQcHwQmH2RZk/9lzd5bgc7a7hOnoLOLqXxOclAqvpODC0xPdLfn9DiCzhcEA91LOMHyj
         hLTjxhMshQTYFhOCEgAtcMQe/VMXhxMVM0B4jeO+jyY4kHVBEn6E3GoZJ1N7KTAsEjHG
         YxUw==
X-Gm-Message-State: ACrzQf02a984kXHhCmwt/u3gUMkDjr97AOiz9Wzc+lQgwSao6yz3muOU
	vfsDqMQ5kNV0q0s+O9RcAlA=
X-Google-Smtp-Source: AMsMyM4zk5qjWz0R3AOZmyDJE7Bfs+4pAoZbge5x5b0BeN2Sw6aLUcBPETtPkUGrv2z5FRJ2WzeX1Q==
X-Received: by 2002:a05:600c:35c4:b0:3c7:1831:6d8f with SMTP id r4-20020a05600c35c400b003c718316d8fmr12816588wmq.48.1666618982676;
        Mon, 24 Oct 2022 06:43:02 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j18-20020adff552000000b002365730eae8sm8912690wrp.55.2022.10.24.06.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:43:02 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: remove variable cnt
Date: Mon, 24 Oct 2022 14:43:01 +0100
Message-Id: <20221024134301.2158939-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable cnt is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iommu/amd/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d3b39d0416fa..3847f3bdc568 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -767,7 +767,7 @@ EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
 
 static void iommu_poll_ga_log(struct amd_iommu *iommu)
 {
-	u32 head, tail, cnt = 0;
+	u32 head, tail;
 
 	if (iommu->ga_log == NULL)
 		return;
@@ -780,7 +780,6 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
 		u64 log_entry;
 
 		raw = (u64 *)(iommu->ga_log + head);
-		cnt++;
 
 		/* Avoid memcpy function-call overhead */
 		log_entry = *raw;
-- 
2.37.3

