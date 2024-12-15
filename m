Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFA1990A2
	for <iommu@lists.linux.dev>; Sun, 15 Dec 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734293060; cv=none; b=hGjpIBpq7/pzh69lv2i/i2Jo+TI+gG7v2lsxsI5F46IMpQnMlz9OGbbJhE95f5txqfxfchhA3N7UB/do1J82jmTSb4xwHJZ/Oo6mBfXN6F1DhANLzPLogacgMFDe8Ott75tHVoqxADohnOA6xdhmN+yL5KR9J8m/G2CbUrcA820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734293060; c=relaxed/simple;
	bh=eLHtqR5A9wpX6zbeuRVIgqm9V748jbpbrIaWzgxiUGk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Fpl8EHX93C/IFAJOIV/i4ha/7NYEz+tGMtUGvoBxyX8kqKrB3WoJh5mr+IRdVtQ2Tk2JgeuAktLIxJlHGUESQTlXkNncCvZ/tMD6kufHnF5J7aSQivK5eoCsEdMYuA5sFvyuvhbyPRUU82Ht6iDVIxynuqLx2DOUJRaAudWlBt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AaL3KbJp; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AaL3KbJp"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361f371908so29962005e9.0
        for <iommu@lists.linux.dev>; Sun, 15 Dec 2024 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734293056; x=1734897856; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwBupfT+fyxXmEmly7oBmZ1BClZCHwQUt9Ls+vVmCiA=;
        b=AaL3KbJpJpr67J1X9vJIliu4AKu/y39ImBYyz7uERatqDjhmjthJc309ib/xgJKwO5
         vuKF8V8PnE+DhMrjrePAnf5kQ8IefVcMOy8JsO/WZ+m9thMlKl8wDuSkrAOSmSuCu6wE
         t7ezKMRpibfV7Q7010bm/oMyIDidel91QERnTAlBJrtV4PvKt0tYKfS4RdjflP55yScQ
         Cc10AYW/tlPsjnl2yFnWqAP6QgpSe26sEdSBe0SddfNy8hBVaXKD6KPzSXJoGKI3Eq6w
         MkYkNu5pCDri07cE8uW9vk3ryugEXMxrwkRY06GINsTCIxOvG/bEyvYYjlaAnlQ8Oyz1
         r7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734293056; x=1734897856;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwBupfT+fyxXmEmly7oBmZ1BClZCHwQUt9Ls+vVmCiA=;
        b=aUznRHJ+tBJRe6JHKJw0fnEPpqHJOpRP5NESEWcBbHcSyl5f6oZmgnOwSWLr93YnCA
         Xe75wbrjnXLHii3Xyc1OumB53HY08pybE9k63H/36nfw4t9lEoZuVa4R4XAuZzODVUFP
         77cPyGhAdZfdteGJ6sm4nWuCdLjmkvOYw66bsPDHZ+KZHrTwoncotyefhwbYZc7I7zrv
         1V+vhSqQyWVF8A9co/3j8V7gMsDgApCaGLpGLmDVIUMtx5htTEe+6JP03N44NBUori6Q
         7FZeBVwDV8fLqPMrSOV0s5cWpGDbHbIRTTtC2IZOxyUeTxMEWXVift4u5GHvO4VHkw1B
         ewHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPU0FcZBsJ+/bcdSmbGQazydAso45id2L51O6ru4cTf62l0qLx1f4/kHZhIWMO0XSaijEMiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YySAgpc0hH4PYBATslBFF9oRbJiTJUmMyhRflnFywljNoFoNT6A
	mgBK7w1Pz9MUDn1LxhSXS7zGD7JcxcEQ9bhQCtu7dnwZjxO3iQy/PKqy21qaScPeN9o96fe/sSd
	5jB6+D1cvbA==
X-Google-Smtp-Source: AGHT+IFZBtol4MC3NA/MQiwAphEXkZPoxFlwPmucl0GZUYpBLZ8Bn8rpWMLd0hZKVOn4cpUk5W+HN7MQj3EJUQ==
X-Received: from wmaz22.prod.google.com ([2002:a05:600c:6d96:b0:434:f173:a51])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e87:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-4362aa113f1mr83361525e9.4.1734293056465;
 Sun, 15 Dec 2024 12:04:16 -0800 (PST)
Date: Sun, 15 Dec 2024 20:04:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241215200412.561400-1-smostafa@google.com>
Subject: [PATCH] iommu/io-pgtable-arm: Fix cfg reading in arm_lpae_concat_mandatory()
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I messed up the newly introduced function arm_lpae_concat_mandatory()
where ias/oas are read from the io_pgtable_cfg copy in arm_lpae_io_pgtable.

However, this copy is set later in alloc_io_pgtable_ops() after alloc()
function was called.

I didn=E2=80=99t catch that with my selftesting as arm_lpae_io_pgtable is
allocated from kmalloc, which was caching old configs.

While at it, fix a couple of spaces.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.=
c
index c1b62c7d81ba..7e53ee51270b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -232,12 +232,13 @@ static inline int arm_lpae_max_entries(int i, struct =
arm_lpae_io_pgtable *data)
  *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tables =
for ias =3D oas)
  *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 tables=
 for ias =3D oas)
  */
-static inline bool arm_lpae_concat_mandatory(struct arm_lpae_io_pgtable *d=
ata)
+static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
+					     struct arm_lpae_io_pgtable *data)
 {
-	unsigned int ias =3D data->iop.cfg.ias;
-	unsigned int oas =3D data->iop.cfg.oas;
+	unsigned int ias =3D cfg->ias;
+	unsigned int oas =3D cfg->oas;
=20
-	/* Covers 1  and 2.d */
+	/* Covers 1 and 2.d */
 	if ((ARM_LPAE_GRANULE(data) =3D=3D SZ_16K) && (data->start_level =3D=3D 0=
))
 		return (oas =3D=3D 48) || (ias =3D=3D 48);
=20
@@ -1033,7 +1034,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *c=
fg, void *cookie)
 	if (!data)
 		return NULL;
=20
-	if (arm_lpae_concat_mandatory(data))  {
+	if (arm_lpae_concat_mandatory(cfg, data)) {
 		if (WARN_ON((ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte)) >
 			    ARM_LPAE_S2_MAX_CONCAT_PAGES))
 			return NULL;
--=20
2.47.1.613.gc27f4b7a9f-goog

