Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6C44C51D
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832427; cv=none; b=iNmSecG3zk3yfF3B9nY8tfIWVIuhVvA/ve3PPljxBweaKjhbFL4VDHP7BO6rGCHFRjFHn3zwwshHRurWwVi3Gm0CcYVaPyh/F5FpOZPrIe/L4Xf+lE0kkq29j2ps8TnjAbc4TTPXFXa2dytIC7krouliBa6ZS/QlwAvnAfayDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832427; c=relaxed/simple;
	bh=d0EWrVZ42EPe2bhaOHHufbmj44DuHjUEdUtjBw/ex20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6ESBUzWVh3FJNBEbQVM0fBimNEpGtWyOaYhooqo1dMz6pJdm8NqDkPJfrOxSOFEPI7hFHUkPpObaPy1i9T82ZPr0Wy6x2ZamrhrFGjnAOCcDaGuc5r+JCJ1gPq/4FAfUaq6zQePyfgkWvh+Q7qtWgz4YgfFTGXo7GSlCFr9u3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElMSKzYE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElMSKzYE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so820197a91.0
        for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832416; x=1785437216; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pa9RhyBV4RDq7tkQpwKRVUOOI8N+P6srYqSVADpe3nI=;
        b=ElMSKzYED8UzTQTLec1z81FJ3G9n/ThuZNS0xYEANtThgjCQKTjvlmFM2wXYUIhsC0
         5WOq3uKIXHkrljFJOTzMcmLWGFqHqHxCu4tlkhgxGnv2gf99jkr0Z3Xcb4Bc+BJc2DUf
         u3m9CIUz9yjlmEYoxSub6TCBPppvB03Az0TPK7EybYbrMeYCThP9IXP7H53IXzwk67ip
         6OvdjbDooDiGpI7LKxHtL3DPARfbQzrkCHUi4xkU0WhSdZjNM7CTcQhJfLTzYI7bctc+
         6vVVMeyihRcC+Qb0oM3yb2eaVCzgLJmxgRHbiaWY9RIpeOnnSmFwbyMOh/pNIXWXlaF9
         GeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832416; x=1785437216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pa9RhyBV4RDq7tkQpwKRVUOOI8N+P6srYqSVADpe3nI=;
        b=W0Jx8uR8I3gB+3q8LiLycSUTj3CNkorggLblnhW/9S9uIobRNqeNDBctHHXJMed0Ah
         NWeOLHAhgqCwIz50f/+1yeCq2AJ9Qcno6/z7tFfaj1hlxKGToS+3GQbo+TYPAocYi3Yx
         BW/aQ8Cm5uCSoICh6TJk43JgW0cEadjKwm/f65e7vnZTBnb75vjiysNFFRrH0gI+D5F4
         wBuMi/NfwhAY+XiRJCX4rTxqK5gNOcVEFiZb/qFQ98jDR3fS5NzfMxAPkxWEsyTbxokV
         s+g0mOvfWtqfq/fnsrmUHCE7m0cAPmnbj59c/yS5M6w0Km/gSPXvMNZ5wOrAxT5pRxVD
         QdwA==
X-Forwarded-Encrypted: i=1; AHgh+RoLfpB3QSEKoG/qyEUvA29FikS9hY2lNdV41zaFA87Sxx5SUJv5f9/Pnb93+W5ZKFZyHLeTMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxF9iIaf4pB+DgYCPnwjmzDM6AvsPJ9/+hLbRtn8tCm1+3TVWhI
	rvxcR+FrxiPoKnEstl6W3x6nZ9QXHjnPQc0PLYfwZQUOefJNW8vqtCR6
X-Gm-Gg: AR+sD13VhFsXNaF7W3oRiHkmQAvNcodUF/DLxrIVfoEOaoL+E0GWnYoymKym66BxpN/
	jIH0aL438Psjaf03TT6sP+O6XW32R1tbz6XLSepNA6xv91I5feB3wiuSDuT5lMrTrxbYTtibjm3
	+WLn3B3Vi4d60Ztf+uAF8cGKazsVEFXBiEDUr5zBE3OlY2IZXDVoC2jc5/z25jIkomG2Tu/sW6j
	i1IkCWGgVAIgDGH0UDwESQR/vYUEv5gZ/yAziHE5OOhLQq1tgON1Q2Yaoj7VVj3XjtvtgPFgLmr
	4Pjf32UhkZ4POfQmM40AB5vT6bULIQTXgAHqtAndDLjjT0C83tKc+FQlIfKKNOq+3MiJm9mDkgt
	t+GKAsAy24ImQBtOC9KdE45ZH4LnSSCog8LcFtYv5bcEGoKzVRzSi3WGdVzGZFmkHKhm2Tlc+
X-Received: by 2002:a17:90b:2b47:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-38ec6454e6dmr4309241a91.10.1784832415649;
        Thu, 23 Jul 2026 11:46:55 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:55 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: cocci@inria.fr,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 22/36] iommu/s390: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:24 +0900
Message-ID: <20260723184538.3888637-23-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iommu/s390-iommu.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f148f559ac56..d008b1d14a9e 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -1115,8 +1115,6 @@ __setup("s390_iommu_aperture=", s390_iommu_aperture_setup);
 
 static int __init s390_iommu_init(void)
 {
-	int rc;
-
 	iommu_dma_forcedac = true;
 	s390_iommu_aperture = (u64)virt_to_phys(high_memory);
 	if (!s390_iommu_aperture_factor)
@@ -1124,11 +1122,7 @@ static int __init s390_iommu_init(void)
 	else
 		s390_iommu_aperture *= s390_iommu_aperture_factor;
 
-	rc = dma_alloc_cpu_table_caches();
-	if (rc)
-		return rc;
-
-	return rc;
+	return dma_alloc_cpu_table_caches();
 }
 subsys_initcall(s390_iommu_init);
 
-- 
2.43.0

