Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A9421226
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791973606; cv=none; b=gsQcw9ecqTN2Dv7AwRCUGOFy5VBQHvQFJUM5imE9Y26IJcKdIIgBdxGViwu8ruoyg9oszx/P7aAHTzm6h87CTUsZZcp2aZoHIU+0vOvgzRdqL0M7/MzOqC5PO85+B5GsP5izfzw9cK6XtALeUqkPoKxbCruWjnvQJfbA+3gCX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791973606; c=relaxed/simple;
	bh=gDHWDcYK2QanyrU6NUlrYkRMYYGX2rjQ5QCZVztfKm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l9II0J8KeJlp9SjyXoBHOmoA9ny0IM/l7riY96WbMECKthYor9WUIiitflcZ+HLJXlfCagHkSoEdV1Wvsy4CJb143bU0oFtpewDbikkZAZZbYsnqXL0V7/uIhVao41ccryy2F1z+rg37U2UhokKgBB/aMqY1NAancrWRSKudd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=fhOIoSjB; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="fhOIoSjB"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15354aa70e8so1935178c88.1
        for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791973602; x=1792578402; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VtYMXNbVtRfmsxMVZSkEhD6PvdF6VjEcdjKsoIPRggg=;
        b=fhOIoSjBL4VSVK/0GFQ+2JG82QrFpmdh5SmTGhV7RC7nLbbBqknVOjRl7op+B+8nPB
         iiBrUuOGn1yfPgG/3Ul4uBfVvejpAPGMgLyrk+0EFUD0Yjh8j5wRlRZK5VuD+s88NfAc
         +GEzaG1BtbyZjThczujIRvTpxh/1q1X0AsgeI5i2K4/Q5tD5v9LQGpcI3S6zq+OdrLkZ
         MLU+D4dtN3m4VJ/cLqGLoE8dAMfs6h+NmZdnDfOja7xC8U9hpA5YyHBdnvCDxzY4erbZ
         O7XWe3SDzfH+uWu6pf1fEHPfuWzoRjEhToqT6VRzuHFDnM3pPns7aK1PUwtI5Jf1SmiK
         tKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791973602; x=1792578402;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VtYMXNbVtRfmsxMVZSkEhD6PvdF6VjEcdjKsoIPRggg=;
        b=HBProvN58qdSRhdugmfxVeK2yuxDZaGl+ylNQE7Uz6UF9AIhGcD3wIPNIyDbFX7VD6
         kgf4yo3ZJYk84FqBK4XwobzymGGQq5vZ3AmPFiadmVvoM/bo+s5WzjIynxSrsT38B8iD
         Fx0YgO59vcXIjkr27juQXkG4godFB3fJh4NE7hYXl/FrEjM5ItFWeZQn+GZ74k+MXW9f
         R1sAjYr7oAOoYR/8Lp2HNPQ66l+Bnk129IEPgN5XJ4By7dfFHdf5sx1XTCHDsIQjUzLq
         YhR9aGFo8mt3A5tLTSlaYzJHmcIqUB74bB2uW7+Vsdd7AJVyxSRJPizGORgpp89qXrBH
         vykQ==
X-Gm-Message-State: AFq9FYJXCJeDW5Zi62khcrjrCLghMzdO6fgvo/UVpHK5sSdRTmh1pNDt
	ldfVJZtae8pOWG+OM/fQs1M6ZhI/vMhlqcJuFhhiSYq8Flip4vRel9TZ7G9r+QNVJdk=
X-Gm-Gg: AYBFou3wOs2qc7lea6CcNZCDS+/Jia8AzO74Kv2gJokKGplh9yCmEZHlYGZf2DfMIZn
	fJKDpa/VCGpJtgJ9YG4llshxqZQDfZRpvgX9Py4ZnjYMZifwWA2mPuBqP3EaBVuFdCVT/jfzYaV
	8mDF/fmfvPSSBnVVJIjdV0sBZAaTxJCx5kIzt2QYyCgYcn6BqrQgAAMcqNN38ggXwR2XFHkBxHB
	CU2clrNGd0dBLG2Nofir2+4Ws7L3T9HNgOD0CShXwDKX1UW91G22rCw7ncRPX3i39BriWNVmm79
	prWEKpFoQL31C++hImtZwH8ELv2aCUTZYD0f0fD/0WiZ6RbYzGan4TeH2gq68/jW3ZNxbzl1suR
	cw4uLD4QWxQAkuhoKCvqghEtp06iAAeu9xxqMu0+ys6x8dwFsFrPIrqkU8BnkzAHgzDoWvG1jzh
	8sOuLdx3h6KG68vhsvoebIVfb5q58To378fg2ov0eaM0Z2JoU18GH5g3lp8jcb7lBw6+kOj0xNE
	ceqHKHpcOdqcw==
X-Received: by 2002:a05:701b:450a:10b0:151:bbe4:b6ab with SMTP id a92af1059eb24-16a5ed3d9bcmr20307029c88.17.1791973602335;
        Wed, 14 Oct 2026 03:26:42 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:bf23:2386:c0c:815])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442ac67sm70318219c88.18.2026.10.14.03.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 03:26:41 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 14 Oct 2026 11:26:33 +0100
Subject: [PATCH] iommu/riscv: Use named initializers for acpi_device_id
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-acpi-iommu-v1-1-1744523fa658@thegoodpenguin.co.uk>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDUxIiSuIhbTdjASrbSIRNxds
 XyL/y+IHIQjtNkFgQ+J4l0C5hmYidzISmwylEVZY4GVIrOKEr8su2JEy1bbhkhDCtbAg5zfrOt
 /x13PbLb3APf9AIDyXE5uAAAA
X-Change-ID: 20261014-acpi-iommu-e11dedbd7aab
To: Tomasz Jeznach <tomasz.jeznach@linux.dev>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791973598; l=2641;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=gDHWDcYK2QanyrU6NUlrYkRMYYGX2rjQ5QCZVztfKm8=;
 b=AwtnJHIiJrTb4iNCDXIUiIfMWQQpeSjBoeHg0K9C/FGGtJ2S2EBE/Vbsc2hjBGRj6UWaaVaOG
 0c5IzhdxGZQDYbImcQizT8FBGigNg/gaCupWKWysURa6+HbfFZBsZtA
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Unify the list terminator to have a single space between the brackets and
no trailing comma.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
This series is converting lists that contain the acpi_device_id struct,
which is defined in the include/linux/device-id/acpi.h to make use of named
initializers (which they do not use currently). This work is part of the on
going effort in the kernel associated with device-ids [1]

The plan is to convert acpi_device_id::driver_data to have an anonymous
union, similarly to what was introduced for PCI and I2C device ID tables.
The goal is to increase type-safety (most of the existing casts are gone),
to improve readability and to make use intent a bit more clear:

```
union {
	kernel_ulong_t driver_data;
	const void *driver_data_ptr;
}
```

But for that to work all lists containing the structs need to use named
initializers first to avoid triggering -Wmissing-braces. I already have
patches that implement this and touching a lot of kernel subsystmes that
use the acpi_device_id struct and that list keeps on growing. Therefore,
I have decided to split the series per every subsystem into:
- pre-clean-ups that convert the lists to use named initializers
  (which is this series)
- actual implementations that make some of the modules use the new
  driver_data_ptr member (does not apply to this tree)

That way the task can be fragmented into manageable and independent chunks
of work and makes this effort easier to review.

[1] https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
---
 drivers/iommu/riscv/iommu-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 399ba8fe1b3e..5680424e36c4 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -164,8 +164,8 @@ static const struct of_device_id riscv_iommu_of_match[] = {
 };
 
 static const struct acpi_device_id riscv_iommu_acpi_match[] = {
-	{ "RSCV0004", 0 },
-	{}
+	{ .id = "RSCV0004" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, riscv_iommu_acpi_match);
 

---
base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
change-id: 20261014-acpi-iommu-e11dedbd7aab

Best regards,
--  
Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>

