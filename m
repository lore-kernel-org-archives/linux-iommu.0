Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA142F4334
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662484; cv=none; b=uL8TB8TdqxjgRdRW4pft7Nk6Wmn//T/xuufEyKF89QLxUyAVL3pQBFSUkEcV7D/lHbjm0m3a2AzBrguW7WPPhok1jDf5YVHEhvv+fwfG/KX/NLuPSJb2RkB49wDM8cDGTFqp55d0PZdaT/w3sPnmdWN/aeYxlchyX35YVmZx8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662484; c=relaxed/simple;
	bh=yeEgt3B7oP+kZLvu/rWotic5mkE4aCWzjFVNCBZaVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFkFFpJyC7m0STw5XGLj314DDG2eJB+PuFlaIs/0QsTv5PDdAlVb/o2Te6gvBlmOMv9c3i0uoZD1V2ESEpw1+ZHhOSSBHB1U9HzTh0lktu+aALXuXoz4twSj1YH5QP7/scDjZnTUjLn81TovGMEr5DxujX2LvuEdTF+IMCPat0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Z07OkHPp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Z07OkHPp"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c7a52e97so5334147b3a.3
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752662482; x=1753267282; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=Z07OkHPp77OtgAcn8vV0qFb+YnBMOm+2K2M+10WpmA4iwy7vBX8MT8Ss45rsTExHVW
         pbP6fCF03nfo9/mLQEsRzC/lwFtmtYqhZVlFySCVYKeaJNZnBjq3eoCwz4C7YLvxKfzw
         5cqNmX8COwT6+kvo6mG1O8/k7WRv6YR+l3DWch0A3qWAOiE4cZRmaNtU9icbMiPWWXJk
         kHHjZoVdlRylNP2+JmSDN+RarWfZYO/6YVr8mIQJCmC3O0z71RxS7xrF9FeRQ3r2CLek
         jubh+NDpbtRGFxACeNAuQn5X8OTwnlVWoA8fzwd7VZxmnkCUsiNumiqrLcNGevHC8z04
         hItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662482; x=1753267282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=BG0Ca6D62y5IYWcCgFBq1uS9g2wHNaju3MIpKITnhyHMkiW8Fo9o2c9wM7DAXziuNF
         dLgMEOwhuyH2/unWDcIP1OdM8QxPvoXv0q2F+Dbe97PyZOqRbAdynr4jxp178L5gn1ff
         zgLnHdeybTHrcF4WNq/ZnIBZv06Sgo+ZeU0l/Luo0tXoaXdTKyrxLfQ0738Wd9o2rZdM
         BfUCdjRwIOG25v1cx5mpk9iLKZsv5E+z9TTbVaoNBishtdSwNIf4OqLCJWZNCJPCK5qm
         RrQQlZvx16kvj44xvm6DIEUE+4TTLA7EetJkgVafeEGwFeV81DiT/gBogWA1+1OsDJ2s
         Xv2g==
X-Forwarded-Encrypted: i=1; AJvYcCV4iRLT//mf9LqAncdEtCh92y8ZLUJ/MQW0rlQbagbbayr7YX33KBoE5zuNyoiYMbKGPe5Lpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzihQTfdjoljbDidOWzAeCPaSYXVyymAQiW7DfdFGUmAhhSCnho
	qeHdx+y0/7Pk5DQ840jmr8pO4o2e+VHaqc+nezcyL+BMU8njKHPfgptHgAJz6Vdrfnc=
X-Gm-Gg: ASbGncu2JCibFK3g5n9Dz/vInh8oSIsYvpTM1BGa9C1PBg0RFmDdsAqaZ3bGpNX3MLX
	7Rs4ylA3ln8pe4317KtWpYs9bK70crFHrisHOk8n/CWduG2Q4CuylvSE753lKk4LQyHquA1k2we
	eiwBN661Fwumh8coxI2q8qF0a3kwink6htii4Gr35HkOvhIsRlfbni2CHzDNiVPynRvxOeh2cW7
	ZeC+b20/pAn6B1zahp0M2bkFJ7xiRfGAPtsifn70MhME1xlXZWnp9GbqMvgF2gp51aqtkgjKBEy
	Xhceu6Q8AvdA009nNGgWdZ1bs1HIfkj6MEIzpF2moQb3wIy5HMcHp2k7+ESlOg27zErrP9utBTG
	TjkxJi6oPuP1VrA588Jtidxux4nWK1idY
X-Google-Smtp-Source: AGHT+IEC8Wh248xbvV7SVKKzD0alSVzVgeFsgJh9ogEs3+/ngP7xonwyOrkgTHqNNgbjcXTmqAIWTg==
X-Received: by 2002:a05:6a00:2387:b0:749:540:ca72 with SMTP id d2e1a72fcca58-756ea8b944bmr4580850b3a.24.1752662481956;
        Wed, 16 Jul 2025 03:41:21 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm13946709b3a.72.2025.07.16.03.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:41:21 -0700 (PDT)
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
Subject: [PATCH v5 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Wed, 16 Jul 2025 16:10:58 +0530
Message-ID: <20250716104059.3539482-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
References: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
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

