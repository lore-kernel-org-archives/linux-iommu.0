Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790228E56B
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137842; cv=none; b=Ag9w9D4K7KLFGCZDQRVHfIUBXTv1nD93L3QW83WVR94BRSBhwdjO8wJRsKleAX+nUkiBlCGRG5NXnWS79Jr4YY0E+ehhRMXW1QIKPU9dWVTEp7audvd/dO7D4rJy6P/+Cb2oHCoA1vjJNGgRfKaJ2yiN3AVi0w+fMkukC22f2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137842; c=relaxed/simple;
	bh=yeEgt3B7oP+kZLvu/rWotic5mkE4aCWzjFVNCBZaVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sY0HtSfkPNywwvgGlmjj2CgQaxsqYKp58FvB2RVunaMmbeU2aOSqFQ5gT2NZcaA/HQFitKlkXeqw5Llh2h1/Tui07N14WcgjSoI8bkagkfG5QoHpOn/L+ZYvAH7u9AZLbLFmr9Qg87fW75WSCt9Misp9IqP2KlGFEij6sd2pYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oBSnum8+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oBSnum8+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748f5a4a423so509063b3a.1
        for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752137841; x=1752742641; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=oBSnum8+YL61bwJ5MVILMomHgmDVmYSvuoJ2GgqPBNBmUC28eS++eon/W4sXWQtk+f
         sEwQHoKJZ7cCSTLjv9q5xpDAmAPJlg2fCHjmWCYqc4q9q7aaNs0ajU45mlcQVm+peVXw
         bUJw20yTwAnBz5xTNBX4horT8FL0wtcs3nQZLqo+q+G+cVgXQ0K6Khm4kF1usyv4z4DV
         P0p8wr+7jXDkwAnlKvDQ8hfMjEesedIlgkIfQYM8mNe7kupiG+CFwVP0Z07LK/+ii8WJ
         NDnoTb2k9U9GNqCte8n65vy+COTep06etNEg4ObPCBYLKdTdPUWzsWDdi6AlyrdWPps1
         ukPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137841; x=1752742641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=dMQAYb9mcZp/mBenI0M82005VUE90SYOhFvO70JBXl+yaO+/ZffS4+ZxccHLuvII98
         NB/xtuWz4Vy6YozdKDBdN2fQSt+aumhk+v9t9p8KvrrUPH5jI4SjsgsHnuw4ySUjIVSB
         +1+/AtgFaECDoEzjRujpoiWG1tVgpQAn/Bq5xlLrfR5J3Oky/8ukUCmLo35chf2Uktyi
         TbQJlEV/MUwo7heOJJqKXz26QYPaNpfjbE31lm3ZXsvN5MT6Ji+lle1Ro38MkzrZoz3o
         Vzdb6uq6suM78BuwWggOvcVa+TlBn6bPB/E6rs8IoAbK1zMDbMP+C5Wb+Wr6SoLdCzrt
         BALQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7V7epv4avU7GNJiWO/mfMxKAnFNruvJ7A/AkdKZOWoOe+X4IKRuTKqsBCXcyDfcQ7aX0ohw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyR0+fSSIANVbnTnaxnd4NxCDnPCYh6tMogfkjeYZo9PTnD47so
	gkYpPvni7MbOOkfr+nPkZABq2zcTYyb0CEZsov6oN+H3ziZtDo2Yt0h37bH9QeZpOf0=
X-Gm-Gg: ASbGnculn3MDZ600V1CNgbR1zr3GK5zRj/xzAlpFYZBc5zl1ha5GVmCYCPNlivWH4xg
	wvAbDpyt3ZjSkidH8YkzvxnIQPQXndKFHEap1WSxgvCi1MU+lsjKaC77j9XlRcSCrp93scNHzNh
	uy2sx2qV8cZV0c0OMWHXKABtUL2fdYtigkeabAEOyfYEhv5MJ8WMxZyjrLpH5BnkNi5TVEtpyLt
	N0hihKBjIQEqxGGfWBXSunrfes4ayXhR9oLJvy/1/yvl0xa6AEe/HCqpCgmFUg/LZiGgmfNMpSq
	ez6cgVMj8RqW8AYdThEv4zKU7CvrTDYpD/BLlwF3JOuCMy1IlPJIdIFooyedguNE+MyPRJS2lJ8
	odt7vKUw=
X-Google-Smtp-Source: AGHT+IGTMhySvFIKwSkWciVZb8lELRF3nbSYJnKAx6xboIUomqUcgBH56UpRO0apylqo7r2SLhP6yw==
X-Received: by 2002:a05:6a21:6e4b:b0:226:c204:3c40 with SMTP id adf61e73a8af0-23003af63admr2908259637.5.1752137840711;
        Thu, 10 Jul 2025 01:57:20 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52ecdcsm1522323a12.14.2025.07.10.01.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:57:20 -0700 (PDT)
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
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Thu, 10 Jul 2025 14:26:56 +0530
Message-ID: <20250710085657.2844330-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
References: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
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
 drivers/acpi/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..f022f32de8a4 100644
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
@@ -1628,8 +1629,11 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	}
 
 	err = iort_iommu_configure_id(dev, id_in);
+	if (err && err != -EPROBE_DEFER)
+		err = rimt_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = viot_iommu_configure(dev);
+
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return err;
-- 
2.43.0

