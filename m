Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322523AE19F
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321341; cv=none; b=KLwqk+yDZcE37ZKvKO3UQEePRq6umT1pf2oHTw/MTmZb/6j84TtV1JZLn0rXewodXzYBep2InLbmRNaq8YIABFPVffwkWyGtqMgLjey2fPmNhvhkGs9zs88L3xKNPZW++bclpObZth8mGq2zHcQ2e805ERTglEDXwLr24U8b+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321341; c=relaxed/simple;
	bh=d9ra7+VpNlaICDKwllpNtvFlzWuKQw76LK9YtUjnPP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VrNiejKhKylqJsTslLcO0ADkLOXyGBgzlQ/NO0EyG4rUPzMN0TRV+9cKfiJA/ZVzajVuWQxVX+tHbQ+Rl7WaJKGZ+OrHik6IUokUUQXXTU2f4Ilz2jTWwIurJjnPhGpSzTJhu8zj9msJzkYYcvYBHdOsb8v75GT/eTXg6jFv0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=od4gQAT3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="od4gQAT3"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84240683a82so1120449b3a.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321338; x=1780926138; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHVa4tUQPxfN3QUwaWtlq81eFxiSoG8gp/4WszuwXdI=;
        b=od4gQAT3izWaGTfJ1KzH7eifT7Bq9gg7H/22y61gHIoYQ7bkc/GVyGJi0i7n1YF7eS
         8lfj7svxiA0+EdMvayEcFEd8le8lfjLkxIamTUUFRArCg0MZFNrnZYWDipdZ8qSmo8Oq
         Eao9soMV9G8GTCk9wrTs7PxpCqOHD2hPQKO+tT4vEfPsikO3lfPXsoSsAH5HB/77NmO3
         csuW2JjHidV0th73v+s8xzjUG6/ibL2Rrb4ohOJI0+MpkBBeR9wGZtTvvAF7QX+98hMF
         1TYnf6QJv+ICtYGF07/Aglh2bDWzRLE0IiMUByAUrsfQQyA4ExaF9MwJlACgchLOhDV1
         GnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321338; x=1780926138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHVa4tUQPxfN3QUwaWtlq81eFxiSoG8gp/4WszuwXdI=;
        b=PCmfSbdG9FQmkPj4SDpDlgEkCTpRT6bv+aeKT2WmQCfQKvzAIGLYfxBsmB2DOLgN0Q
         GjcvFLtwwHepwrEisf2GkTcC40wrpsgHAnDU5IqSpwTYDQ+Q6+Llwk2OOCb3/OqkbXfu
         YHbPQ1YoxeMzvHFAqh9m9FuXOhn4VXAxVu6G+o0Mw7bUEqCT8/UOjTYvRlklchC7Kk29
         eAbbk0Eh+idJfwcuP/VnR5Ecfpkv4mGBIEE7TyU1xuNwTPxQjfopVJ+qwE4mBpjCP/fN
         yD2sFepQoe70bIZerkM3esCedEzVa3uEBqv2eC0NSR0oU6av9+OhiwQNZo4fZDxLo1vl
         a9zw==
X-Gm-Message-State: AOJu0YwUwwJekkpiFiobJ/GWZY+wILCKfTTRQRTHoUEd7N4QckrSaq6C
	mWZ89m1ffMWVrWzzunKS0xu2k9ujXcRIT1S2IbmsgV7PA/Jhn7LXDpasIQPQpxjzlYRm0GK9wim
	9fN8uIAdm2dqhCS1WJgtyIX1bASWAlETrT6DYo/l2mfD0kkgvQXGVLdMiBAlltfgXt8NN4wh6Ni
	cXHgciXGXDlP9cj8Hr1qNa0wuF2/8usQ==
X-Received: from pfbdi4.prod.google.com ([2002:a05:6a00:4804:b0:842:3a6c:99f5])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:278b:b0:842:4c2f:a576
 with SMTP id d2e1a72fcca58-8424c2fc01dmr3577714b3a.16.1780321338241; Mon, 01
 Jun 2026 06:42:18 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:42:02 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-5-praan@google.com>
Subject: [PATCH 4/6] iommu/amd: Fix Use-After-Free in non-fatal probe error path
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

When amd_iommu_probe_device() fails for optional features (e.g.
PD_MODE_NONE), the dev_data remains globally linked with a pointer
to the struct device. Since the IOMMU core does not invoke
release_device() after a probe failure, this could lead to a UAF once
the physical device is removed.

Fix this by introducing amd_iommu_clear_device_dte() to clear the HW
state and setting dev_data->dev = NULL on the non-fatal error path.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c3b3750d4a22..4ef6024c5a4e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -734,6 +734,15 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	return 0;
 }
 
+static void amd_iommu_clear_device_dte(struct amd_iommu *iommu,
+				       struct iommu_dev_data *dev_data)
+{
+	struct dev_table_entry new = {};
+
+	amd_iommu_make_clear_dte(dev_data, &new);
+	update_dte256(iommu, dev_data, &new);
+}
+
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
@@ -753,14 +762,10 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 	pci_seg->rlookup_table[devid] = NULL;
 
 	/* Clear DTE if we have a live entry */
-	if (dev_data) {
-		struct dev_table_entry new = {};
-
-		amd_iommu_make_clear_dte(dev_data, &new);
-		update_dte256(iommu, dev_data, &new);
-	} else {
+	if (dev_data)
+		amd_iommu_clear_device_dte(iommu, dev_data);
+	else
 		memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
-	}
 }
 
 
@@ -2517,6 +2522,11 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 err_deinit:
 	iommu_ignore_device(iommu, dev);
 out_err:
+	if (dev_data) {
+		amd_iommu_clear_device_dte(iommu, dev_data);
+		dev_data->dev = NULL;
+	}
+
 	return iommu_dev;
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

