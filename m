Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8F296BCB
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808723; cv=none; b=XWuv0c/CRzvHlDFVPPradVYtcuRaeEEHAM0EwMnXbyg2vBRR1JKJp5qyqYv/q2RY/6hWC64t2oqNd5DRtCw5GV0xauqWNxS88KmWRbuW/W4lSpsQKTTWLZYXVKlo6nwR+Bnn88KCpSpukSnSb6Mld+goA/qMELtwnt25K+vSMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808723; c=relaxed/simple;
	bh=UxWopZEaQm0aPm59atwtT4/L/v4FLHyW4ZpGbmFDrLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dh5aRgGaiQba+qYi336qw/yUlQ44USxSdMfUuhHTC/yLgFWupYZd0+Clj7W1BKnSiR6T9zw1UDrezEWciEOsLsZeokxg0aZrlB1GL1hAhp/xO9LpSOONm6jjkHAG/7Lwez2x6HMLK0ui8R8GRc1esYC/+hu/beHjSO60SKe/+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YiZMxp+x; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YiZMxp+x"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30cac93dfd7so322403eec.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782808722; x=1783413522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOC0O5L8yCrTPyUO6WSb6ea4HWyqtXRV/3bmbz0pQTM=;
        b=YiZMxp+xgOYsRAalzWZudr1r7REGMt6cEvE616oOuEOLYGUDMwJXry0X2Tygwg462c
         tnI94UxyetTv8gJ65ffSSkdT7798EU0pEdRvti9ty86xLPmNi0kQxUs+9YWoseiBzGI7
         uKf4r4eN5p85bey6eunYbAbjeEf60YAb3Vz9Wcnzq+4jW8EAvYK5q5MMuFfrM+EZiLkF
         /Nthrlw8YTUVJNUZF91ZqX/DMf92sGrfOfM2sqKhLNuxqVS6ygGkQgZS7QZ4M5i/+JgV
         OKn3I0RRKv1T/Ov3NrdnLhCD81nTiCmcgZuomCcIaaUm+Mbv8hqtv4FhThoAoH6zRyec
         2K1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782808722; x=1783413522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOC0O5L8yCrTPyUO6WSb6ea4HWyqtXRV/3bmbz0pQTM=;
        b=JN6UcKPGN0PrDlBzvK8n3aXIiAwHkAbPL0F8VyUCMoZQ6hkn/E4F6okeRfgyfq5IVF
         SbXd+4GWO3FV6POKt6yUmgPafpMuGRRTTBKzn3WGlwEyrE/jjFoauCmqOz8FNrmBNI+W
         1IzvFME24NjkuhYXnYL8ip+gQPZhOKTZOqoL1Pn8m4o2PPFPKKWB2R6z+xwf7BVXclEb
         qdsNAH40oejTTuHF4TYKsGp7sa9vfShDqJ/c/WN+vKDU1sY4KBYjF+jwpZL8X2YkiKju
         FGZJZy4fS4TvRMRLdffTE78Yrq4eu/l9hWMJV2rXOWdxqBkz5SYWQ4uT1obH/0QomKgE
         voJA==
X-Forwarded-Encrypted: i=1; AHgh+Ro0JgDyIikhtQ8E4mJ+3fRup1ZHKRUUAnoOCdAuq1cHKKSXtyXVszKiZ3cpM8piZCAAOvqodg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSxl9cvRqQGki+Ybqo2SZX70niqFmzerhL3klz0Loilnv1KB6y
	bafvxpZ7vpS8K3Vo40uxlwk5c43QxKJAF7yhnLTUbamzyGXPjZdVXfCnYfD6PijsRt4=
X-Gm-Gg: AfdE7clt/Oa2bXRHMzaG0yr/KzNjRoG0+x4GSc/fkuVnO0Dw+dkOu5/7+ncwRUNFoaK
	dw5W/uE4AqT7y8yB4VMf0jF0B6qOyi3MJQ5z5Psxkd7p/CrrJy5j0g6Sx4CP9vbEHCTwaEhsaNh
	pzOG81qTJWYePHPBcShuyNFBdb1rW0sYMi/6quzO8czvwd2+ShYq+p2Jq5Cr4FwMgqr07WKFu7g
	B8UITgCBAqWmy90b76L6I1YT1mqtABop0EuZdyxngVssPU3PoGO+aUZlf4sjOSC6APeYdosr8F7
	Hyhs27xKzYosWpnaa8StyR7OBujVUWnVMMWc7+a4ye4OSXE7UK5XVjiv1Rrd55z9sJMF1acJt+e
	HSYZvE4rN5FyZNWji9rmrP0XRbVwzpmcd8Iu8rczFyvP5/GFv6Ys6tdU3oZd63DY6kfEFW7TiSS
	gP1i4ywdI0W/di23ZZ3JP3oUIi86x+g4GEOeQ=
X-Received: by 2002:a05:7301:2a27:b0:30c:ab96:7304 with SMTP id 5a478bee46e88-30eea0b83b6mr831847eec.20.1782808721684;
        Tue, 30 Jun 2026 01:38:41 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5aeb0sm6756444eec.3.2026.06.30.01.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 01:38:41 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	andrew.jones@oss.qualcomm.com,
	guoren@kernel.org,
	david.laight.linux@gmail.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Tue, 30 Jun 2026 01:38:07 -0700
Message-ID: <20260630083833.1275837-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260630083833.1275837-1-zong.li@sifive.com>
References: <20260630083833.1275837-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an auxiliary device for HPM when the IOMMU supports a
hardware performance monitor.

Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab10..36ad4aa81465 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_rimt.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -565,6 +566,21 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	struct auxiliary_device *auxdev;
+
+	auxdev = __devm_auxiliary_device_create(iommu->dev, KBUILD_MODNAME,
+						"pmu", iommu, 0);
+	if (!auxdev)
+		return -ENODEV;
+
+	return 0;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1613,6 +1629,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

