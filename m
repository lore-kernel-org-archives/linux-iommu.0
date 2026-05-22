Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB233783DB
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461995; cv=none; b=r26+zF1HIM2MbSb3VfCnN+pkoadW+cNUEkMMkKEnzSPIv+MSQiC5LJi4YqWt5a3Q2UnHSaWO6x8Q8UDhIXswdXH0lBcifQA2kdDNHjfZz6DgY+b1kFQkZh3MInBd4vFBYEPvkDgV94G+CATKy0TEfjlRvWSiEnPh+cqw4aQ141I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461995; c=relaxed/simple;
	bh=9zUTOYb+g+3EZt7oIye6rhzKcFrhONL8UItJ3EnXyfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ErjOVyZ02vAwCpM0QRr96guPMu90/KZdPiJMzPPwFuE72OBWK9xLKkBW7Sm42/IXGaAp74duDvCP5DoEoHiPS3P6J0oqu2TXUC5/YjSN9QU9WfgtmFroE+JdxueGiH7na/3pIP/9mp7z8+/baJTUmfLXaootj3Lk922KYXH2AO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=G6dBG58A; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="G6dBG58A"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49041e84237so8474135e9.1
        for <iommu@lists.linux.dev>; Fri, 22 May 2026 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779461991; x=1780066791; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DLi6X6odP8H/h8Y8Pr/vuDUyKcCjgbdHGCb8Tzve4fY=;
        b=G6dBG58ADd5+3DaCz2gm1BWkcCdhmtWbO6JHjhx9YvnPCpRCmFxjVzQR5oc+hBN7f8
         NX/J9X/six1Xfm8DGLxPCrgc8GfRo3i+RqSVoXJAPalc92ho/odnCeeDfyhR36Yq7ce1
         owbyZZJ+DsXfFxWQGDJk3qSPSvsHjjfiC6O6lVX4sGgOxHkkZ93SgXI7G2rSOzvuodwG
         0UnGoMM42i0gQFGvP/POTbNvAxeQSErzBpE3rntm9NtgtfZcy2kfwUXz4oCWpohwj6AD
         /HwGr8jVQ20govFvHsolFE0q5kOp6eYRRvM4rqhqLps7pv73F9rrcvhqw0JEXKHbEadH
         ROLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779461991; x=1780066791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLi6X6odP8H/h8Y8Pr/vuDUyKcCjgbdHGCb8Tzve4fY=;
        b=kLO+8iD8tHBIUgwZ98389Uol+yO1RXUs/pRB/UWsPCUAHZHWM11qCtBVToYF/NJp+E
         HTVi3bcYDeqNQ7qbStdmZIQTWqGeU2PMlyUZtSuvp9XcPFaJnbPCpNIdEL0J3kQjnt87
         2yI5bi3oHnbJzVbkimt7aHu+6RXpLNlc6zRh/L1YWqQQxtzJmoDx1YpS7ysGfYoeS8vC
         I02R5niyJ/nXNcg+o461aW9YJK27+4pfTFcXY2yA3nCwpcvJmk9R8EwzO25WxZ55xnU4
         KNcfCXAhUqcZu7rGfuKqBFbMvC5MyTdqMnGm5MK+rJyqlbTILWnLIpPL+s/CFuE5KLMj
         qaSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZNHVFBpxhPFV6CSnsYIe5hSnGK5XIdQ9Kf3+8/GvhhLLmqNcoZMbUahLb0HEdjuAD3L0sPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrPVgCYVSJkv7u2SrnSytCHdKwSY2tCFGa7iF5XtQE3pIa0yTv
	+MvVUkXarG0jswOGqnNCjnrAzkGjMlGV0pq/2ohn0sg/CQPXkHJcfm5zVxs7H5Vuk4A=
X-Gm-Gg: Acq92OEt3A/mbdOrNhN9zKgaiQ9jhP7TgR1RNjJcIl2g96+KWA6dwQDR1J8wF+ii6Xb
	cqhDbnt6GCWNMqRuXE55rvKkNQ0HRcdUhGUAUcclMaSsZ4ouSN41F3Tnk023b7zdybk9qpREKM3
	fsC4/xHBLVVAXrZqI7zrPU9fbbFjOiuINacaN8Ec+6m4OBB9a2KJKIcU27q1QpV/DL08aKVkS4s
	RtL5ONYu7bIWt0S4aVORrR036YzgrwGzJhtbg+qdqoEgTDQnpd9iGnFq9zzWO71hUr+jlKSO2vd
	djReguzYqkhXbxiuzT9m8uESEPqeVi/Vc52vG3oNrNdfQsbp26rd1d4qyiMEelvnXCpZ9Y41SUA
	CU7YwE8sxhaDZziff4+txIXqUzvCkAllh7zHPfBeo39t9uw2OnaU+Jepg1KHyjCTOKK33PSEpBt
	Y+HBlkfYQgODr2q5BG6zMm9jYy6NHsHuPnKlQwbFJppk6vxgV6beEhwNbmOhxkp49qFsIrlM6Jr
	x60NV1GlmcdBbE=
X-Received: by 2002:a7b:c053:0:b0:488:7d01:f67b with SMTP id 5b1f17b1804b1-49035f2e1a1mr79160285e9.6.1779461990892;
        Fri, 22 May 2026 07:59:50 -0700 (PDT)
Received: from localhost (p200300f65f47db04fdedbb26b9ad100d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:fded:bb26:b9ad:100d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6d5cb9asm5241495f8f.27.2026.05.22.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:59:50 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] iommu/riscv: Drop superflous zeros in pci_device_id array
Date: Fri, 22 May 2026 16:59:43 +0200
Message-ID: <20260522145943.774344-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=9zUTOYb+g+3EZt7oIye6rhzKcFrhONL8UItJ3EnXyfg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqEG9f52lyWQQzuWjlCjyQbzzJzLwj5lurSUYrB 8lZOKPaAFKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahBvXwAKCRCPgPtYfRL+ TvWLB/9ik2N5fGT6RT2UEJFI4kuhLU1DsBWTnMQHyJtT6Dy/pmmAAC6CIojtti5tyTJO8ywoAVD YZ+CAUqwr8oLBppm7sXXNBgKOLDVIbJna98X9bmu7Xy/WuADWjhn8gXdGne+9KHA4rPK2EJm/YX JYmLeOMqyfLToW1LO4V1j1D8HkzhX0+36IEMU93LlqSjjvw3JFv08Uvuco7ySvFEirKujasQrbt D7iLYpurq7JBh53BCeTqSDbhrL5jk4Voax26uGO7Hb2nHnspZRQYQhQL8n/OWarN+Tri8hNhiWC yb1vF1KMsKnCWpem7hQ81E38SGitkv6JLnfYQsvbkrHFDe56
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .driver_data member of the struct pci_device_id array were
initialized by a list expressions to zero without making use of that
value. In this case it's better to not specify a value at all and let
the compiler fill in the zeros. Same for the list terminator that can
better be completely empty.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

while being a cleanup that can stand on its own this is also a
preparation for making driver_data an anonymous union that requires that
.driver_data is initialized by name and not by list order. The union
allows to make better use of the C type system and drops the need for
casting. The change to a driver will look as follows:

	diff --git a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
	index 1739971478ff..c0d9da81d512 100644
	--- a/arch/x86/platform/intel-mid/pwr.c
	+++ b/arch/x86/platform/intel-mid/pwr.c
	@@ -347,7 +347,7 @@ struct mid_pwr_device_info {
	 
	 static int mid_pwr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
	 {
	-	struct mid_pwr_device_info *info = (void *)id->driver_data;
	+	struct mid_pwr_device_info *info = id->driver_data_ptr;
		struct device *dev = &pdev->dev;
		struct mid_pwr *pwr;
		int ret;
	@@ -471,8 +471,8 @@ static const struct mid_pwr_device_info tng_info = {
	 
	 /* This table should be in sync with the one in drivers/pci/pci-mid.c */
	 static const struct pci_device_id mid_pwr_pci_ids[] = {
	-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PENWELL), .driver_data = (kernel_ulong_t)&pnw_info },
	-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_TANGIER), .driver_data = (kernel_ulong_t)&tng_info },
	+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PENWELL), .driver_data_ptr = &pnw_info },
	+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_TANGIER), .driver_data_ptr = &tng_info },
		{}
	 };
 
which is a nice improvement dropping three casts and that will make the
compiler say:

arch/x86/platform/intel-mid/pwr.c: In function ‘mid_pwr_probe’:
arch/x86/platform/intel-mid/pwr.c:350:44: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  350 |         struct mid_pwr_device_info *info = id->driver_data_ptr;
      |                                            ^~

(so it promotes that driver data is supposed to be const).

There is no iommu driver using pointers for driver data, so the example
is from a different subsystem. Also this is the only pci driver in
drivers/iommu, so no further patches for this part of my quest to that
subsystem.

Best regards
Uwe

 drivers/iommu/riscv/iommu-pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
index d82d2b00904c..8abf52dfb4c9 100644
--- a/drivers/iommu/riscv/iommu-pci.c
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -109,9 +109,9 @@ static void riscv_iommu_pci_shutdown(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id riscv_iommu_pci_tbl[] = {
-	{PCI_VDEVICE(REDHAT, PCI_DEVICE_ID_REDHAT_RISCV_IOMMU), 0},
-	{PCI_VDEVICE(RIVOS, PCI_DEVICE_ID_RIVOS_RISCV_IOMMU_GA), 0},
-	{0,}
+	{ PCI_VDEVICE(REDHAT, PCI_DEVICE_ID_REDHAT_RISCV_IOMMU) },
+	{ PCI_VDEVICE(RIVOS, PCI_DEVICE_ID_RIVOS_RISCV_IOMMU_GA) },
+	{ }
 };
 
 static struct pci_driver riscv_iommu_pci_driver = {

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

