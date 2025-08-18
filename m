Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22ED26E70D
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493107; cv=none; b=lpmE1SHs85+q37lHg/lkQspKbs4156z6I2j3SmLzgmL8V6FYb04pThDgPeEMM4nZGVMD7HURIKCrRuClJBjdK8RLV4fzqaQ80uVAD0c4kYpvkMElYVWgAbjjoNwPT+WUXIQLdwmRE1zUFVMUx+DTnflP4vCaXrfhy/fbjQgszbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493107; c=relaxed/simple;
	bh=yeEgt3B7oP+kZLvu/rWotic5mkE4aCWzjFVNCBZaVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQXeQwC67azP0mfc2zo2El3VDs15AI2t2844TQCthMHtF0vGNPKGuRHhPiu99cRStVFNPHuS4ABLah7rJQeEzEM9As3hItKCpD5fn7wM/Py2DHuolHJnEt/KJ5iCBpAEDphDIeZESabYJd7zPUe0ISIeQtvWqcR47E3/vIxZTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CkuVdnya; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CkuVdnya"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso2188674b3a.3
        for <iommu@lists.linux.dev>; Sun, 17 Aug 2025 21:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755493105; x=1756097905; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=CkuVdnyaYavutvDEgAVeWE9aH4w/PP7gnRTHYqzMZBbIV63Y0d1XBZzK3pq5IcUWdg
         s2opNw90hDGUKjVgXY31JGETeiiwD3w8Hz0jQ8F1B0J2Q6VihpNfuD+s+vGeqjSLU/ER
         uIJL16rhfaY/Vt/8olYPoJ/n2GgrgT+7PuEEMcBcTJR0Kqr9oKHQ/fAivLR4JvR049ou
         xMZk7jNzhEVeP4OFAlpVFAZHkv8360Wl3RL0TFos0BSzGDuNB6ZWii70YZDYu8eYNaIL
         ngpP5BMzLGe7id5269jyt4NQC1uJJp4eBq+OjGca39sBO4G/T9mNVDkJxLEn5vRQW7N2
         /ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755493105; x=1756097905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=gCNEdQ2hbRFog4YRX0TImnFm1NpqyqPd+fYZeVT3YdE2nDNREzu3PvJmTYF6Irjd/e
         cWeiaG6V6fXBZW2i3bja/QkB0BP4kFjFdCIcSCWFUrRDEiRbhsAg2fOoZBqVDfhcB3qk
         OyIh0/AKeZqRuvITng1oIahMY62CJ5sRGEefU6vJvCcoR84GBnYVPiF7UppeNBUryWA1
         4ssS82um+/lzfSyZFlrsIhmVc4JgCjTDqN4nzf+jHoMGUsX6OuAViL+LNXHjLUO+DJXv
         WITq/zAQLr/k5rX81tjHjTXdJ+6SIEuUtfa62x4XbphFBbsGnBibe0wzzGnKPN89HQpQ
         fKOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGgYExtS0QPtEwK39oBKASmugT/2AKjzyrOS6uzNAkUINKmvBeWONzFWswb4H5ATnuJrtsHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAr/68OBhMF36k+luqp+R71maOXPPJvgTTSj08/TwhaNO1ylIw
	eJQe5LK9tvpg6nZxyY/fE7Hm5mp+QvJP3HLUxzpIjwNqxuivBd0ZFYDyE7ZOC+9BVUc=
X-Gm-Gg: ASbGncu7Jh2k7wffKuGYIk/MSq0byDt8XgIb4cg3QWziXz5+YTp1lT32wz+ckIei7n1
	hojNfBTQFKE3T7gLw3NQjKWhxxcIcOcNn4JxoYl10scZZ696weahnM/oZNQV3qGnG4Rb/8XyB2F
	Zaj88v0XtSPxkX094s7ZYxQ1pKMax+bnvtVVexol1obDTao5eVlNnCjRjqre53uhGopX7Eo4yy2
	IokcQYsWa1rZKb7n7Ec96jd/yILN7u2VVL4M5ej2EXH2rsfyoNPkWXIiD02F+ZqgH0H+fbe3CZ9
	b7ZMe2BN7XuXjla0NQ6hugPGLsvQcB8Zin+rYiF4b2v2IuwjxB6aaxTuhxsWL3e07YU0KryGZ8d
	/jJL4GQQrk9RAd196aMSGx/BgoLGardhVFD3MRA+L
X-Google-Smtp-Source: AGHT+IEemk+BWiEUx5FojBtceZEGdoOXlJtGCjztrL0+XbJGAKrKEJt4aBwM+DlqJqMugoECLw6zgA==
X-Received: by 2002:a05:6a20:5493:b0:22b:8f7f:5cb2 with SMTP id adf61e73a8af0-240d2dec932mr14433397637.8.1755493105211;
        Sun, 17 Aug 2025 21:58:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c264sm6124047b3a.43.2025.08.17.21.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:58:24 -0700 (PDT)
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
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Mon, 18 Aug 2025 10:28:06 +0530
Message-ID: <20250818045807.763922-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818045807.763922-1-sunilvl@ventanamicro.com>
References: <20250818045807.763922-1-sunilvl@ventanamicro.com>
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

