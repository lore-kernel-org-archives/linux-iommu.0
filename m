Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E124417D87
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574244; cv=none; b=Jcf0tbWvpWwONSQGgFmYCdRjK0HkNsFvkyDnQ3qrgp3zzE1L8l/zELIJhgJrSO2uRq+7rCY7uIl0jUpJ/qDpT0EBTv8eVM8B9fWrZbIgboNQ+TRE4urVvygj1lG3ER38ZKnS7RWPNpfV14/pR3nPXry1mCRozgvqU8TTaHAtxZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574244; c=relaxed/simple;
	bh=I60yTaMjb5bVKB+wvVecyXVEeYAbub5ZMoYnTj+sZEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XC8BLuld8PIFfuOs4nyTh8knKsp1kOs2KUKfjyBHaATS/EQte7uQWuhUTF53jTzSc6uuDF7Lvaij7Tw7tpjFD/j6Ccw1pazbnCzD7ag8ZLn0OcYN4m76fYggXjk4ps1mRL0UfbtC99Lbvg7lAwo/7brL+OMtl2oA1Az2qL/Hh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIiiTr2Z; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIiiTr2Z"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cacf17c7e0so55178305ad.0
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787574242; x=1788179042; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfAbKSbfKhboyVQcKl7Sv1k2EzxFQ1LM/Y8jps789BU=;
        b=eIiiTr2ZekWwBFvY7TsUIwPW+YLO0pGkI2dFUl1pOhrUrlxKGocmzFqcpIvNn5YSRe
         3g5/eur0zsYGsHiSQ5o2ZClNHvsDcENXsN9CSgJhyVlrLL0W8/Dk/v0NMly8El47ANEr
         XSrB3UXZMx/GHPSKpUUU/vA8/j0aBODXRMU9/yPV3Ww1B/M03IozNErwoKPlJj011Aq/
         naB9gnsL03bwE/797xtLU5bOa852WaZx8a7A5BVv2qd1KM/bTCWvAkNY0OW9aD5Sky7+
         MjrTYndjpeWYxt+atxQw/JOEaKDDhNyis9DSNOcGORhp4rVQkSuhfWqL15cGQSbUqgXP
         1r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574242; x=1788179042;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfAbKSbfKhboyVQcKl7Sv1k2EzxFQ1LM/Y8jps789BU=;
        b=ghqKvgpxrkI/omYkz7yA47H/YGVXeUV+fD95BfajYyCg0+rAgxCdqJFSC1UadZn/KJ
         /B8BL8QM2a3c4goH3+OpC66kQX1+OAcI1uKmeRmcZhvd6S5RvkFL+M3yzWM8vn2Sn8t5
         Mpy+jFC/B+R4sjKc0gTdgORCoxmnvRiH9TZGfxsH8Y+57ei3sbIARTqNn104Q+WPAt4E
         Rktvibf7wgToq7f2B7LZbxaRrIhotF5tuls+2Jk4fOD3HwbGwQOrNh8VysE+ksOvQXi+
         7UDMOIloaXw6BQ/0FJSNNtWfweE0p4NVhscEvsn6g86eJJByyTVU2BCIbxkCPSCJnO0w
         37mQ==
X-Gm-Message-State: AFuF++nDh5pvFygnQSat0Pvk6LBGUEkkiImehmq+rBfFoPRmE61z9kEE
	gA2nBTuEZ28xfMgemFu1EonlXk1Z6TzEm8U2rUOmjpf7qbDX0cwtk+PYvkSXmyb/oE5Gcc6BoOW
	7FnHH8iAQG6ukX94FeuMCCbN0k5m1b6dGFDBHpYqaNehap5xMUyTetZggybmLzlqUkYzcFXgs/B
	WyC1SPo8NSxW4VB0nYyEqrmC42jvYIgQ==
X-Received: from plbkq5.prod.google.com ([2002:a17:903:2845:b0:2d0:1ce9:b121])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e546:b0:2c8:2808:3ec9
 with SMTP id d9443c01a7336-2d64b0c4e5cmr412549775ad.12.1787574242094; Mon, 24
 Aug 2026 05:24:02 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:23:45 +0000
In-Reply-To: <20260824122347.1588592-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260824122347.1588592-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824122347.1588592-4-praan@google.com>
Subject: [PATCH v3 3/5] iommu/amd: Split probe error paths to preserve IRQ remapping
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Split the amd_iommu_probe_device() error paths into err_deinit and
out_err. Proper init failures continue to call iommu_disable_device_dma()
while configuration failures (like PD_MODE_NONE or ATS mismatches) skip
it to preserve the rlookup_table entry required for IRQ remapping.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Suggested-by: Ankit Soni <ankit.soni@amd.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8e382317709d..ed336bca1a2e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2540,8 +2540,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		ret = PTR_ERR(dev_data);
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
-		iommu_disable_device(iommu, dev);
-		goto out_err;
+		goto err_deinit;
 	}
 
 	iommu_init_device_caps(dev_data, dev, iommu);
@@ -2559,6 +2558,10 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto out_err;
 	}
 
+	return iommu_dev;
+
+err_deinit:
+	iommu_disable_device(iommu, dev);
 out_err:
 	return iommu_dev;
 }
-- 
2.55.0.766.g2966f0265a-goog

