Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2413BADF
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601137; cv=none; b=mvXZ4QM2tShZJDPvPo+tZuIotUXrf4Y1Afvt7VIAOaOt3b6CLIX6+okqq3tnvbTenFi9QU5jW84dNQkM2SZ+HXxHQzu/hQl4B0QIYGu3FtO865y3GnTusDVvmgI8mJj2cjQsZNvhYSiRAvnWP/YFhKKKBOTmqVneeHAXlNjmvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601137; c=relaxed/simple;
	bh=0mPWdQkW2KKBDaAhQDqapvf02Htw+fq40OqWkKngxqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDA975M+R6xi4ZIGybRqP4Yxj4pV3ZJU6DE0q8i1h61lePtqJ/TBN7oN8IO5cEKWadARUJDnFccVC0B9pKNgijzJvZPbwvYa4CGiQKa7qYVwyboFyTgU/2c03WNatOk1Fm1lMJ0tjUv3nmND+/HWwrcR5KOXeptjGF+8nI6KVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=XjSPMbnJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XjSPMbnJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43159c9f617so6939585e9.2
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601132; x=1732205932; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3RScEb/zQMeNBIY0PtZD1/ZjJQ2IegD9nNkwkqM6gc=;
        b=XjSPMbnJbxnNEe34f1gC8P07ZnpuuM+k9NLkoLB4rpCv/iGl/cC0xKvX0VLhqBMFzv
         dCtxSjl/lDlI9+IOlmWiFQNqVNamJjcvvCoe1myiXDCm4BEpUhNXJF7oNzyh0WbdWtCf
         axQ5CIfuNn9BgPL0o+KWCffw/xedJxkTQSg6LjHN9vA8/BHFAWTm2SjUPNdcMHILK+km
         PHqKJl8uqDfCG7y3eDwEdRz+/rTn1Dh8hbv+MfuieGagj7do8Gpn1sEn5M7Tsdy+1rvr
         +gf4TL4pJY10qFtQP7I95VQty4OfrulMTZUOmZO/5UInWQ7V2iqm30QFX3V3Wu6mMlJb
         9HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601132; x=1732205932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3RScEb/zQMeNBIY0PtZD1/ZjJQ2IegD9nNkwkqM6gc=;
        b=IH+TPdKtSB3sbVdWHHOCZUUUevHUkhK2Qe01ASD7br4ZkphRc/EPdukIovQI9zcHtk
         0VjUcrMkhMDT9Rm2m8Vs6VPtl38HBnR8sQ+3u3dwb8KwSEZ532b+K3mrZvQtAc0MYAIH
         M5bHXNNx0CAzFoQs09SH1XlmeFAEO2aoUdgXMuAhVXDVR/rmjlDBSb7QTX7hlUqLWyb0
         G9didBG5qvrBEPphfvwxMJfHDZi3YrgOlMRaJjTlNoEwJQBOcSzlcyRvXzXxOVm/P0d8
         tMTVcpcviUg9Q80tmudZTLKnzcty18KnCfoeLA0Jb4UGhZ1QYsfOz8u3hfKaNRt++KTF
         j32A==
X-Gm-Message-State: AOJu0Yw+wRJ4/d+xacb+ZDMsyitwm+pAS20n1IvVUxpmX8sMi9H0+M0x
	ypy7WNjvyh9kilC5Lbi+0VJ3+1HwL7S09OXYNlwlhSvSTf/E/A2F03800oU7FoX0Vc3uTTwhNsU
	MSBk=
X-Google-Smtp-Source: AGHT+IETarykQuvm6+z3/CASGfAXpcrdoszeWN3rsEIL+bc92gQplNjgpnYXoIwCDFze+tOTvORF1Q==
X-Received: by 2002:a05:600c:3c8f:b0:431:4e25:fe42 with SMTP id 5b1f17b1804b1-432b751e28fmr192523985e9.32.1731601132365;
        Thu, 14 Nov 2024 08:18:52 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab72184sm24967935e9.2.2024.11.14.08.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:18:51 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 04/15] iommu/riscv: report iommu capabilities
Date: Thu, 14 Nov 2024 17:18:49 +0100
Message-ID: <20241114161845.502027-21-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Report RISC-V IOMMU capabilities required by VFIO subsystem
to enable PCIe device assignment.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8a05def774bd..3fe4ceba8dd3 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1462,6 +1462,17 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
+static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+	case IOMMU_CAP_DEFERRED_FLUSH:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -1526,6 +1537,7 @@ static void riscv_iommu_release_device(struct device *dev)
 static const struct iommu_ops riscv_iommu_ops = {
 	.pgsize_bitmap = SZ_4K,
 	.of_xlate = riscv_iommu_of_xlate,
+	.capable = riscv_iommu_capable,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-- 
2.47.0

