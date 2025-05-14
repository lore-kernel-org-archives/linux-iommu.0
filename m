Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44A1FA859
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202272; cv=none; b=et8FKNXbhvCwpfxA4qnczaXLM+7nMjYcVrzBLx0kr5jj+T76FqcMxfJLI5BTRjDsHTC4/LFckGzkSNnXJWyMrLzWdncMn5cOhMIinpcKMp3XDejDIEJ7N1tUMqWJdwHq9JWRDhMdhGgzCTOiw1LW8Q9Yjq12kMaceUyJBnpwGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202272; c=relaxed/simple;
	bh=j10W9ERtTCLuRtXkzV2FgTmpZyoQoyxJASYgwPYwbms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3ZOtZ9dDAtRKzWiJ9k7J8JwSJb1On4/jpSKFKTwrPtif4tc4ZfwU47WIEO89LKUgalzVRu0u/M3skH0FGJVZJ1FHSpY4+Bxsu7GreD8QeYVNGRLK3KQSiB7EZawjy96DsUEJ1bv7brT+C4a9voBnExVRw7pjesunHjgzaHlKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Wa3E+byj; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Wa3E+byj"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b1f7357b5b6so4111416a12.0
        for <iommu@lists.linux.dev>; Tue, 13 May 2025 22:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1747202270; x=1747807070; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnkjvbjcuENvVJ26saTSRizx+WjEaICu8Lhi+aJlcF8=;
        b=Wa3E+byjTPQWTThKH/3oSazvUr8BR61TN7JVyIW8X4cPtXb1Exfiim2tYOZo5FJBOl
         s4MTg31AHcUDmuP4U3KtZoi2ahiVF1MP6ILnEKVyb8vmfIyhEpmUA3crK6tIHJkxebdP
         DO5s1xfUPSMePs2OMyU+QF1yMDojlSaSn9zvpFJmczHNkC4oIDgAIcGIoJMQayOSagDN
         JGNf/BGhNd2mFTVuUVMXV5PDxiGr43CxbsYsPHNOBPUaWpgLmUtqNzJavoljQkcoRdIh
         ZNmJj26dQOY1BaJ7ZRfvF877VzQTY30fgrvw1AZDVZPWzN6U/yEYen1GP90D83/LVa5f
         N/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202270; x=1747807070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnkjvbjcuENvVJ26saTSRizx+WjEaICu8Lhi+aJlcF8=;
        b=DhdrBST+ELWKOgbW6n6fIA8qEySCCGckjIzhIZw1My67Hxm6Hv0pxN9NZBe7RjLFwW
         jcIiA6v17j2xRYOj3rBMdrpwYgt4jEB6CuHP7Dl43Lujdx0XLBVdBekprLd3XF5zVC5w
         b4cDQwDvkFD2K2KIEjlIXaSpq0zlOxrS74fDrD4V6homeIqQCPyPYeKL2H6Al02jZA74
         L79oGnKVpgpQDPSIPahY5P2iWmVW+VM+RJ0AhQMonoELX89vFy/Kjwee3W0Cy1UYPcSz
         0gBxQucDnyGacaoxrELDzNw8syfny0oSiZUF6k7VV0n2gtrYdsZYC0i8fgjpdcQPl/CY
         edBg==
X-Forwarded-Encrypted: i=1; AJvYcCU7gcFLSe2Iv7IP3v9DXIRUEWHWquRQIlgyHg4Eo3tDKOkSPZNuZZGxi+vcfZ9tEwFEE3qfnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxT0UtloxyQqhJ2sei10QFVUFEMOfgG6ZkiKHh64S/rp1EA5CE8
	H9vXyZxHo4zv0CB/rBcqz3ObNnlNxPk4F9ZO959BZZc9iCP/UVj/7sIY+jjh3MU=
X-Gm-Gg: ASbGncv/59ZJSSxV9C3wnWjlnCRFXm22GyDPLeHndK1EhrmJBnyoXfL2UR5bSe858Es
	xnCvdQdcxIW1TVXIIAdi+BxuneADoJIDKhYtTIzbP9LKufv7gYWATrl4UKuyJIbCGZb9SJ+Mdu6
	MEU7j5XZuG8csvuJ0qXZYU2IkYtF0mbW6esU5fF8hccbPSUcVZeTSer2aFhPzn4+QJX8nBG2COZ
	8e29yi2jTqCLrvIMjGVPIIhCj24bQVXmarqb63UZzik6Pcs9IWbMMaqJZNp5QddbbfrBIIrHXse
	HF7IDn5OMmEmcMyTRNEsQ5qxBOfCJjt/xNpuR2OL5hpT4cZKqn3wMZmC9di06w==
X-Google-Smtp-Source: AGHT+IGOnxIH4YjGEW5GtZaYNs+W/C6hB2R8AaG0BsyNWrPx0B0lajN6mf6PqMko8vPxUuZYiIe5uA==
X-Received: by 2002:a17:903:3ba3:b0:223:3396:15e8 with SMTP id d9443c01a7336-2319810114emr33089565ad.22.1747202270073;
        Tue, 13 May 2025 22:57:50 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c2dsm91721615ad.135.2025.05.13.22.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:57:49 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	acpica-devel@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 3/4] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Wed, 14 May 2025 11:27:22 +0530
Message-ID: <20250514055723.1328557-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
References: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
Add support for RISC-V as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..70f57d58fd61 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/acpi_rimt.h>
 #include <linux/acpi_viot.h>
 #include <linux/iommu.h>
 #include <linux/signal.h>
@@ -1628,8 +1629,12 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	}
 
 	err = iort_iommu_configure_id(dev, id_in);
-	if (err && err != -EPROBE_DEFER)
-		err = viot_iommu_configure(dev);
+	if (err && err != -EPROBE_DEFER) {
+		err = rimt_iommu_configure_id(dev, id_in);
+		if (err && err != -EPROBE_DEFER)
+			err = viot_iommu_configure(dev);
+	}
+
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return err;
-- 
2.43.0

