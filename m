Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110E2D46B7
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400737; cv=none; b=j5dLH6gTKAYeRoI4DDLj5aVoI7YBmkykUEO08ubVKmoGZcYUZ9sDBI/Gw6nzCfU/nnYfqnLbKcfV5oPDCoKAxRgE6yiwfwHQBoW3S1h3zwFoGcTdg4psc5hP8JxG01qMPNcIyP/Cr3+ydH7ci1T17cMDwjJOFxzXpzpL9KRIDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400737; c=relaxed/simple;
	bh=pJK4i1P2/F+SaIV5Ypd6TZyTjZsa46FZIsC86e9sDFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXZhmBLjBLasaKCEIB/kI7JqPgpxEFxU1yXm2NBGnMClfrwA28aD9rhhWMORe6QwEM6i4hWejXDuyEX+gaPCWbHKuK5JApSU5IS8QRbPI5ss+oToyfvvrXxnsKJ0y+dVIAVe8PEyfXdMUlvXztsl5W/LTfrw8ge0OWCXT4Jap6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mW47sveZ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mW47sveZ"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-89336854730so112501239f.1
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400734; x=1759005534; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfdnGB1sHNv96VJcVAg715QoFjcIQwVKNMZEvz9AAmU=;
        b=mW47sveZmiKelqYDrY7rbo4gz53JpsihQbbtQaQuwfXh1eT6Ite5EPJO09ow2t0TUx
         hF5dlQHAjsHtZy3ESewjyFAdZqYqpYbg7r3RHNFPWA6+YqHRE6BVV2rYyORB0eyE74oy
         GrI6hGISLip99Jrt7t2JYTFJJWooxzBeowmIiQrZlQtUN9AN3v/jjVLfH+iSDl8q7AmC
         D8ItdyiTIBjYvHi4YXTcSUj3Y46dhq9aNKqJKMtVNPl1oUE8xuOw4KkVDmIXZIQ+c3vh
         LYlvk9fCBJzMLCQHqiB7U96TTfIER2CwXYKHnIHNOwgOKyDXnZEj09k7dMBR8TVL42Xv
         KArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400734; x=1759005534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfdnGB1sHNv96VJcVAg715QoFjcIQwVKNMZEvz9AAmU=;
        b=MqRc1DybORbpti87BUSHhQPxBqqm8FGKyI8E3DYRUleKLUlLO8JoKV/kutwSKJiNU5
         WH8Ig1WFOCAHyYn5a+zSVoueJdqty473/Q18epsL7vNln7/jblJfxuIVh1g+8La68QBC
         h5YpCKxzwVd+rK8iF0bfDSZmXv47CUkkhia4DyfGtPVsu68E8ZlT7gOnRxTYR82Rs7Sq
         7qa+y6A+Be5TIzeMIsrzhhvHAcsgYHA0FGFZgTzS+mMNjNDGDyRv6oKrRPcMzJEt5g6/
         +X9rokisn9qnpCUScHZJNIXn19S2Bdc1EbBFlxvJlg1NVaT4I5B+0nR8eDn8w3kjSiEc
         1LZg==
X-Gm-Message-State: AOJu0YyehELZ7Qi8+FIKIrfk7LQU9CQ/XAnUDYYYin+5WvEICV/vN4xM
	28GPrT2B8CkIKc+lnhgPmij7AIM31wKd/kvxrKwDSYUOo2nHF4Ngtto7gynfhw0r6y6FWSSTqnb
	GvLHvN/c=
X-Gm-Gg: ASbGnctn2nq6xEm1bOEcyJisJQjw/2DRvWsT/IFOBsFn1AY8ETyS4R+dSmt4WrT9UjU
	CVW9XMP1pEa6N6vvQpNJNK4q+5GiWnR5m+4czGDJgldQuvJL9zZBno4UOmS6clJYhoZAAuRAGVp
	ZgSggz2kekhY0RzwLf9KMXkEAkw7KPVCZVR6k5g19EO2oJq3bzoQ9mIRYpijyC1D9gl1GUYSQJO
	pRB9fgux//a0g9S2UphktW1SyW5Pjpm3o3mycHLrCdaF3ac/6OhqDE6RtCyl3vhizD11IUndeso
	/Z6kjXml7y5f6W/eYsgvwLRx/uicCrF9kg1pygXBMissk3sDJXQkaN9KokFXMScLdfp3SySFEdH
	ZlD83XZtn+55sAXpsp1TmZ1KC
X-Google-Smtp-Source: AGHT+IER7JqLT6oTfCQWU199+6p/3PvuPfDuYsKata5YQ6Fx68IZQQdwLhEBfg4EZlP9xJt6h7cJ2Q==
X-Received: by 2002:a05:6e02:d07:b0:424:8c2d:ca45 with SMTP id e9e14a558f8ab-4248c2dccf6mr34706195ab.31.1758400734326;
        Sat, 20 Sep 2025 13:38:54 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3e337de1sm3755155173.25.2025.09.20.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:38:54 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 01/18] genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
Date: Sat, 20 Sep 2025 15:38:51 -0500
Message-ID: <20250920203851.2205115-21-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a domain bus token for the upcoming support for the RISC-V
IOMMU interrupt remapping domain, which needs to be distinguished
from NEXUS domains. The new token name is generic, as the only
information that needs to be conveyed is that the IRQ domain will
remap MSIs, i.e. there's nothing RISC-V specific to convey.

Since the MSI_REMAP domain implements init_dev_msi_info() with
msi_parent_init_dev_msi_info(), which makes 'domain' point to
the NEXUS domain, while keeping 'msi_parent_domain' pointing to
itself, there's nothing to do in msi-lib to add support except
to accept the token.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/irqchip/irq-msi-lib.c  | 8 ++++----
 include/linux/irqdomain_defs.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 908944009c21..90ef0af866eb 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -36,14 +36,14 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		return false;
 
 	/*
-	 * MSI parent domain specific settings. For now there is only the
-	 * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
-	 * possible to stack MSI parents. See x86 vector -> irq remapping
+	 * MSI parent domain specific settings. There may be only the root
+	 * parent domain, e.g. NEXUS, acting as a MSI parent, or there may
+	 * be stacked MSI parents, typically used for remapping.
 	 */
 	if (domain->bus_token == pops->bus_select_token) {
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
-	} else {
+	} else if (real_parent->bus_token != DOMAIN_BUS_MSI_REMAP) {
 		WARN_ON_ONCE(1);
 		return false;
 	}
diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index 36653e2ee1c9..676eca8147ae 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -27,6 +27,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_AMDVI,
 	DOMAIN_BUS_DEVICE_MSI,
 	DOMAIN_BUS_WIRED_TO_MSI,
+	DOMAIN_BUS_MSI_REMAP,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
-- 
2.49.0

