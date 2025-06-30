Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F521C84C9
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 03:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255304; cv=none; b=A5zrHaFQE5kETU0W98cHFnoC+t7GafUNejfEkb6fQnGx0kbSQvViM/mDwRGqkY43yqfPSWAWt3y56+1h4k8OBS0TjhRQSFFJrVqb9M9buWqDEkEe8JYjAq3bmQFG3JHN2EH8iJyLOzUdv79cejtZOTItigt1FpwWWrSRCxiVf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255304; c=relaxed/simple;
	bh=rcXB8sUVYbgV/LLd1eTDWsHjfWUpMTfAU5sX2LEsSqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0Ouz260msHlAZPpN3hlEsUgENbqf5HlfKAY9LdEYoeCDqc6mY8b8sPQE3+0Rf/VAdN40gBUxmWI9i6KjLb0KZo3A0+wPDTNXsp8uPQIlGYIryA7MpeCV6/tvtzB17I42Ps1gPu0VupwYpFq1b5A1hn5Fv6N+G/uiNHuyY46nic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=T2dZZWs6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="T2dZZWs6"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7490cb9a892so2864922b3a.0
        for <iommu@lists.linux.dev>; Sun, 29 Jun 2025 20:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751255302; x=1751860102; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri1e7xvqfD1xJqzMHYa8cxstKVT8liDfwJUs4Nyy/QU=;
        b=T2dZZWs6OkVPLRf2ge0YllgCnz6ICQ9dFBlW5+szKfEm4OkEtlLrO4fp6BrfqXJz1o
         YmEesAqtWpUsq8F+cX3SRKcfLFi31oRmUSqEf9irraLVWo3b0ImXNKg8Wa1lY3+TU10O
         /vhRzlke1g11fVfcAMaeQUBRqTFQVMUGOPUMlH5cmsn2SGeWX3tztJe78Fd2KK6UwHJ2
         HgmaM28WxIA6V/woPI53hhLWnTZn08tA8k8xvH+n0K+XhRu1rClr96kYY9BpVbWF5Ye3
         j6cRGvVGvAAioajQXKRyrogf2BgJflPWs9Wbxd2oK6hnI5mh+7ByWlaSiOheQJ4ZBltM
         k0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751255302; x=1751860102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri1e7xvqfD1xJqzMHYa8cxstKVT8liDfwJUs4Nyy/QU=;
        b=QMIc2y3y8Fu12uWSysTzeRfD5TcgkH4ablL36fgiAUJO/D/SYGTETcZiAn/6M1k0vN
         rqLqOXBzC7SfkdWTd1ksbxbTtfs6TrN1xNE2THev1hrF7mtaptJ9XnTmB1d22STtIzVC
         exBHOjpp4eP/qEWuS9T/scpZpW9+ZX8i0guHKHM0mJIJGHa6vtPyB6DVwudLwnDlgVsw
         Z04bqDcz9AnGU2TeW3hRh4ORVkYudLnJNFXwOWZFhWu34hQmQ/If6f1p6qWDNLPkHf7o
         mPuqaNm7E4EHm3w+ogCEP7sYsq+2dx9p7ac1BCjPHuGPo/LAE5JOwln/jaq8+XStSgcg
         zbkg==
X-Forwarded-Encrypted: i=1; AJvYcCWOym4dqCPAbk1VSsU0BWU495AUs1+kFk7FFdGEtgsKxOpaRk2corAWct1a1gyfM4/L3YBOqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwY9VSd+g1kHkdJQzCMQh2aj1vVgUnp6AocfWRnUPyN/nlq3r6a
	CPCFmahgJzvhj/l5pCAaoVkuTGCH2hSvug1axbzKSqIrP5Jw6Y6UPW3Gv9+REeigcXw=
X-Gm-Gg: ASbGncucxT1YCEVUMGPkp5B8j5FUAnHDnKK+PyLPDCB9sMTM9fdd4Kv2+CfHy5aepeX
	xW4z9FGri4TdQQpnld2JNA7LLnXCLX5q1nkcAZbR1iauatKwvIsucG+HKWm0SYXwjwtPDAd+YnU
	HK7LIzN3m4DCf3hHcDlJ/38XSVC9lemvdb5G6kxFBDLCUsKToa1qHVRjQZd6XNL+lF2H48+ne6B
	SQfXhmBlB4ugy3V7rmuLOSnlmkUlfmJIJuxYLOElKYrw5IhEAdwAQhywltTng56XnWzYITi1Znn
	1l5wBCGz1lVDXBg10sakM/uss0fCshVZejtaRpHR+9lyLgQBkdXmms5oGrSjkJwTB5DHc4w+
X-Google-Smtp-Source: AGHT+IG71WwVUzest/mJtvn+9x2w5xMiAsY0zQAJe8GnER+ZaxhJXmmKNzdMlkrBD48ocwYkdyfatg==
X-Received: by 2002:a05:6a00:1813:b0:746:2591:e531 with SMTP id d2e1a72fcca58-74af6f081c9mr17099430b3a.12.1751255302416;
        Sun, 29 Jun 2025 20:48:22 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57efaecsm7837862b3a.161.2025.06.29.20.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:48:21 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
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
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Mon, 30 Jun 2025 09:18:02 +0530
Message-ID: <20250630034803.1611262-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
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

