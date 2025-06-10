Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84F28D82A
	for <iommu@lists.linux.dev>; Tue, 10 Jun 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552424; cv=none; b=CSCbeArsB6pUYUnzCLEpOdIY64ZW7BK1V4bV7aHZEpIbbRd27EbH7YBswjC28AOQsWQryJJ+hp3nSsFXvHboPhkbdIjj5EVR1EpjfWm9gR4tFm+RCnnEQAm0j8Y0eLgHDWwrRO6BNKX66RhsEcq26ogJ080Oca73QgYS6ISFIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552424; c=relaxed/simple;
	bh=h73ucvaKC7tusoZ366WFdpRJo5bbH+f6qpcdSe3pUX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrF+KZ2Vuvyp9o/4OG+o4yisKR8B0pTbMhKHPyb+YIYduoOTcY9CTTU8s7+xy1zd3ClLT41UH0eJN/s7wi6IMSE5X2zLKRbQ/dHK6vNIlO9FKe1doIalHmCRrBTz92TKTn/xlOe9zRZttY9W9B0DexBEq2vdI+vfFJmitl6KO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fHxBhwyE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fHxBhwyE"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so3961191b3a.1
        for <iommu@lists.linux.dev>; Tue, 10 Jun 2025 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1749552422; x=1750157222; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOPKLQETC23awiI7CT9ZOjIxOZ+G4ZqvM0do3bqdxho=;
        b=fHxBhwyED2br+ABpWIL2LTIbp+nFeqiNcJytcqk2Q7kmCI2jwwFk1NZvel641v+4nB
         1FD/mV1QZ+3Zg8ce6ywYYYW+b0tC0XNxnqL9/me12DhWAbv5bVeiMAUNgZnQ5zkKdXez
         hVpemfX6y8f09CmkHesAK3gfrldrmGfDjl8WWCNCqnb5D9WKHhtKYSVPcBmABks1W3l8
         Z9DxQurW9z2vjrMoJL1LcqyAieE0GjVMFAGhNhlnWHyW+QBrVc0RUGFNn8sshGbdTnIO
         O0cT5SOOHJ5bnpYdlujSG3qo6hBTAM0vd3Cx+LSEFHTs8qqUH1zsDwRiw5tmJXFgKE8W
         mIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749552422; x=1750157222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOPKLQETC23awiI7CT9ZOjIxOZ+G4ZqvM0do3bqdxho=;
        b=UHZRc74yjDSN4HYFqTlAzyc1dRcZKAGFbd8nZ0DnSE8QYHJ5svzrddoqklqJS+syzk
         OqVBkV2tArlkMbRJg8QVONKzOOsNR1UEMRE1Jqev/2HX4+win0ufR4vPjzF4eVdcKbCW
         5lWHYp+DyNrUhsr1bwhRrRv4RI+bpDJ/Rex+qoMc4gxYzaKStr1/rTcykZub1jSwUL8l
         ThG7jqsHr1z8gkfzQPyUa74GckCzFuB7BA/nUbl2MXZcmPgOAfoDOtLhW9tUZoJWu2CJ
         LckSu6yFOtCmwqX8oWrB7M77F3FEMrY5pdSf6lg5rHFroovscL1ICAKu23ElW0Z7xckp
         QW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4BekU2kJqK/AezVdI5Eg6oBM/z3KGzddeZFUG/+Zus3S0oscb+NVsKZROr2Dk0UY/M8JDRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr4fZMtK22j8k6zHAsO2ZfAnT4qS1At73K564yniMUSIcyVBHc
	h/s1N6T7l4OdQXZmXArunsRhcmN4DqEmI9yUsJ32oTIGDih7AbCvagEIJbC2bGUHG0U=
X-Gm-Gg: ASbGncvyIOatVIofT/DHKivQHO1O7rlsQbzsFsqHamUK17276dWA05vYtHumGRLWViz
	7T+lUXy7RWiHK2n5s6CgXTcprv/RqjZZhSaSBZPgB30Ny9+Rk7/TbCu/Z8dI02HPAsY8sZjaEXm
	b4d8Qgo8Ml6i5gXLxzlKD35LlJLdMMs/5vngYx0l9WLoNjlmOtPCuwUqCV5wyKuymuIIXFCMpnQ
	gmrKRmELNiGlmgNLMOUVZjiGhDV5uUhhYQNbTQ2c64649jm+8qgE0LA1Y6wSXhODYnFZ58LT4+/
	7SiW7qz39ZshI5wwKdun/+v0v/CctpjYmPTaPGfpvQ4c/+ktcmJcA5/TzY6agSndpMImVK85
X-Google-Smtp-Source: AGHT+IEY8u8v01mFisc/TL0W6gCvBjvkLcKdurAn91xGLMr57xfYjH/zVaAAA3K7rATTcPpWb32wlw==
X-Received: by 2002:a05:6a00:9292:b0:746:2ae9:fc49 with SMTP id d2e1a72fcca58-7485ea78f73mr3883622b3a.9.1749552422541;
        Tue, 10 Jun 2025 03:47:02 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0842c0sm7152448b3a.73.2025.06.10.03.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 03:47:02 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
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
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Tue, 10 Jun 2025 16:16:40 +0530
Message-ID: <20250610104641.700940-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610104641.700940-1-sunilvl@ventanamicro.com>
References: <20250610104641.700940-1-sunilvl@ventanamicro.com>
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
Link: https://lore.kernel.org/r/20250514055723.1328557-4-sunilvl@ventanamicro.com
Signed-off-by: Anup Patel <anup@brainfault.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

