Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710FD3254A2
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716630; cv=none; b=b+qtmYRaeCMebeAP3dWvu6vLdIbywOF4LZtg4BMFKvPEHGasMk8Ml0x8d5KNzNbBBYCweM/AYtSLVveyimi587aR0v8Nlf3b+9S1+uyywWGF9qxmZjDLxbDhPcKPdlmm1+9hyKdotduM+amasSLh+RoxZAhl6WVyKsXHKmJ6B5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716630; c=relaxed/simple;
	bh=tuMmnL8kWBlel7HULWOxQsUVB1nLdJi3c5N1cwgmLXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XY6TVhlfikOOmtW0+nQ7fIbpSzNsS++sWwWDtzZZPwzM02khG8EUP/+Ef7gPXN8OvGVhyzAaqNXQYpRXvvbYDET4kQtUbLpgvfHTF3SiIU7ah+4ivA2BXr5BElXhiYhQKn0Tfl5XKKZYmS1EWSNeqdMGjC+DCSkELnUGPNqifYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFzdQMmE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFzdQMmE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b895b520a2so5483726b3a.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716629; x=1765321429; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k59EbfleIcJoy+5EzizBoaCnf/ll7pOIinGcBu3hfz4=;
        b=zFzdQMmEgAykz6kdR3LmzN7s2N6le5zRBZbsG7A0JxE5ccYnKrZmvtzLJ51A1W6aki
         q9w5468mBZfQk0q9gyNYdeJ7yGm7rs2l+5WYni3W0DZbzywRrxvt94QXA27XRYcnMFGJ
         7spCs4XH3noSyNwKH/OKPam6SDMyvRtPs/pnfd047172VIWF4cjHuND+8zUPSWW43cpL
         9KO11+z0W0X7cpaty/VQzjs9a7Dk5Vi6Vu5T3lY+m8c2QnGkor1fURk6lyPRRxYpIVOL
         /c6Q7x7dUUtFinfS2QgQQ4lI9s8Pyy+8MOeyYsHQTQm0hZXNs4Sv6rC6iPNQlJWOdVy3
         uQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716629; x=1765321429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k59EbfleIcJoy+5EzizBoaCnf/ll7pOIinGcBu3hfz4=;
        b=HhNN+2KUmvjPBnJV93E3Ip7JF/UXsL2PO42XqV1CpipfWHyKqtEMTAw3RYtD5DZLEf
         0xAFj1i80KkatgHXisWasLaL0dBYEOMt0evhcSe/VR8Bj09U6zBs3XiUqUGE2gJOkZzr
         mRS1SDFx/jtdwktY1cAB0pVyE2goR6R6tEUktQ+/XA72m6gcIAn0KOe55Y8nIrrt9Tn4
         ilutVDy7em7AbffB+yJmUMGASNFHgAGZHrGB/ugWpGEGRH9W/pNorSr51hyWIn0pv4+5
         4lrDjnhXBwveani58DQ0TzNHICBWTwNPPo+6xr36eBYhqQJhETwHJH9BxrJoyxt6ck1h
         vmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk18Wy3VCSy33jjImRQmkOkw7wIZWHVQAjJ0qptt4evwSb8Uz32AtRh3f66gLCCcUdIGIrjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwulwHA/HABkpYJoEeh66M4bzky1vJv70W/u3ikC/s4kEahlYX3
	JN/GCgzZFp34Gs610JhehUomzzZFdjjoeUv8MxeMeerGo3f3a3ABJwp5aH17dsS7gs936ADNKxh
	m3N4q31t081Jz/A==
X-Google-Smtp-Source: AGHT+IHNZF7hxsRSp55PFXeM9EtFqxELzPE8x8BH2lj5GjmzOZvrRqo6QMh5gMNPIfQGqxqKmNSvKLvn/TVNsw==
X-Received: from pfoh7.prod.google.com ([2002:aa7:86c7:0:b0:7b9:3791:eaee])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d46:b0:7bf:1a4b:1670 with SMTP id d2e1a72fcca58-7e00a0df2f2mr192443b3a.6.1764716628794;
 Tue, 02 Dec 2025 15:03:48 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:59 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-30-skhawaja@google.com>
Subject: [RFC PATCH v2 29/32] iommufd: Handle the iommufd can_finish properly
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

IOMMUFD cannot finish until the restored domains have attachments. The
devices attached to the restored domains should be detached or
hotswapped to different iommu domains before the finish can happen.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  4 +-
 drivers/iommu/iommufd/liveupdate.c      | 55 ++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0d358e5486d0..3ae324d7da14 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -383,6 +383,7 @@ struct iommufd_hwpt_paging {
 	bool nest_parent : 1;
 #ifdef CONFIG_LIVEUPDATE
 	bool lu_preserved : 1;
+	bool lu_restored : 1;
 	u32 lu_token;
 #endif
 	/* Head at iommufd_ioas::hwpt_list */
@@ -728,9 +729,6 @@ int iommufd_liveupdate_unregister_lufs(void);
 
 int iommufd_hwpt_lu_set_preserved(struct iommufd_ucmd *ucmd);
 int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd);
-
-/* TODO */
-#define iommu_domain_has_attachments(x) (false)
 #else
 static inline int iommufd_liveupdate_register_lufs(void)
 {
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index 5b45071d7dd2..fe4c514811a4 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -265,16 +265,6 @@ static int iommufd_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 	return rc;
 }
 
-static bool iommufd_liveupdate_can_finish(struct liveupdate_file_op_args *args)
-{
-	if (!args->retrieved || !args->file) {
-		pr_warn("%s: fd not reclaimed\n", __func__);
-		return false;
-	}
-
-	return true;
-}
-
 int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_lu_restore *cmd = ucmd->cmd;
@@ -319,6 +309,7 @@ int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd)
 	iommufd_object_finalize(ictx, &hwpt->common.obj);
 
 	hwpt_lu->reclaimed = true;
+	hwpt->lu_restored = true;
 	cmd->pt_id = hwpt->common.obj.id;
 	return 0;
 
@@ -327,6 +318,50 @@ int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+static bool iommufd_liveupdate_can_finish(struct liveupdate_file_op_args *args)
+{
+	struct iommufd_hwpt_paging *hwpt;
+	struct iommufd_hwpt_lu *hwpt_lu;
+	struct iommufd_lu *iommufd_lu;
+	struct iommufd_object *obj;
+	struct iommufd_ctx *ictx;
+	unsigned long index;
+	unsigned int i;
+
+	if (!args->retrieved || !args->file) {
+		pr_warn("%s: fd not reclaimed\n", __func__);
+		return false;
+	}
+
+	ictx = iommufd_ctx_from_file(args->file);
+	iommufd_lu = ictx->lu;
+
+	for (i = 0; i < iommufd_lu->nr_hwpts; i++) {
+		hwpt_lu = &iommufd_lu->hwpts[i];
+
+		if (!hwpt_lu->reclaimed)
+			return false;
+	}
+
+	xa_lock(&ictx->objects);
+	xa_for_each(&ictx->objects, index, obj) {
+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
+			continue;
+
+		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
+		if (!hwpt->lu_restored)
+			continue;
+
+		if (!hwpt->common.domain || iommu_domain_has_attachments(hwpt->common.domain)) {
+			xa_unlock(&ictx->objects);
+			return false;
+		}
+	}
+	xa_unlock(&ictx->objects);
+
+	return true;
+}
+
 static void iommufd_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
 	struct iommufd_lu *iommufd_lu;
-- 
2.52.0.158.g65b55ccf14-goog

