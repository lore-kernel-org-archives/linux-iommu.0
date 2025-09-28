Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F58273805
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086483; cv=none; b=LkfPTFpnv4CPGaJeqNdUUiEn1d1YDab2SKKj7v1TpDSYNMHKCbqDUwwGH/pCPmoh0cf+BidZidFSpq0yybofz96+Ebf132bHK5Jc3m2nwHrtvrNft5BnJbPM/y48BdpobGN5mGO3W9w3ql6FMhUQ/saQL8XLWpgFa5N4cOOfFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086483; c=relaxed/simple;
	bh=eE4YtWNaCXed6BZ7yxa8qvhRb0ZMJlu8yifPEfR7bgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g6SPv23hyFrb9Ln4mUA7x2Bwj3T9lL9AIur5hFy3TZeE+NMkR2FzkA2AybrZvlBi43MRrJqgPfbtrNw7Xdn9faEHzORacbZSsaq4UmJsKRMheQsCw8HwI8jvG3kDKLE87s0joCjq+b/GO0Dhv/OUAiiR5ZXnek806LDJlNrnOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1uhto3c; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1uhto3c"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32df881dce2so4128848a91.2
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086480; x=1759691280; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi5xSv0ip63020Fps6lPWkegEnm0TGf/4Ss482K5u6o=;
        b=R1uhto3c7JAv4zTpzLp96byQJMj5sDejuXY18WYADqI9oa+WerZXJNab10rHyXTg5R
         VZUvPtqKy8iXXelYCULmW30n1N60pecjuSf2HOcVnlvQqo5p2mMoozwvGoYWzRWTt3na
         hNlRsmfpTh23XPR0DXlFXud08O5ipYuC+1wXXc6rIc6kKNgpGDMEni7HkkUhgJNc1TUe
         lH8gTQ9RwJWGDZ3u4W4PF0qln1MlnTFMCDr0taIniquMVOmfNBnhuJVJ0b9ghOW7Ia+g
         Dth7wbbr6i/QkL0OlINjIVSpLbwnxwR3ZGd/H4qgxwQWMExc4HHZVLHDlvHtwx5pt2cO
         NpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086480; x=1759691280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi5xSv0ip63020Fps6lPWkegEnm0TGf/4Ss482K5u6o=;
        b=GvwltTZYTOpJgKaoV221bP4SURq5nX9wLPqg3dNGaA4Arc4jk7o7UiOozVdFaQRMS5
         OVlknJZg4l13jzxpE5tGS/uDXRhzvEJ8N1a+NI51E5oZBsZVYrlMxWx6ijAHQ3Pup2+p
         34Jt2xT0Y47R9HgIBvHxYY2BjJxKaKkJL3lT6ZlK77deAZ4/P+Qbww6V0MrscpFhTqA8
         5aicGKoVRBDA7sXuHL8fTVPh6cxB3r2HXwN2qMp+MuxEg03peB4mJ0+xCW2AF24Dd1ez
         le5OtAPUPIjOK6YqB2WavP1lalOowUkHEX68QJMjSQODlQWpVKFpc5bqK3jjb9vNQPnc
         OEgw==
X-Forwarded-Encrypted: i=1; AJvYcCXCXoD9LUi5Ei8gpR0TUbnHpkBjzyxM3x/08kFlhJ9dr9yRMbZvugsV+oD8RLDignPql5in6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHbkbhR3G8MliVFosfZc3jOFgkhaCIcsO0VLCiZfLyLfjk+7f9
	TkT+sR6LfRSfZinRwIG2H3qBqvxhFpFTuTcdIlSK1Zr/0rkhNf71E1/+zQ2Up7sDQlE/wn/nA8S
	nPfJhd1PFmwClqw==
X-Google-Smtp-Source: AGHT+IG0pDvpM9G54/3TjfbvcFpmO/TqiGthSy0imZbx93Glz7wAQ23TYddREy6lbjR0p5lw+B7srvLFeianPg==
X-Received: from pjjk3.prod.google.com ([2002:a17:90a:6583:b0:32d:a0b1:2b14])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d10:b0:330:6d5e:f178 with SMTP id 98e67ed59e1d1-3342a30c47amr3373951a91.26.1759086480539;
 Sun, 28 Sep 2025 12:08:00 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:21 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-14-skhawaja@google.com>
Subject: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

Iterate through all the IOAS objects and the underlying hwpt_paging
objects. Persist each iommu domain using API iommu_domain_preserve.

This is temporary as only the domains attached to the persisted devices
need to preserved.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/liveupdate.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index 1bdd5a82af90..0af0c6fadff1 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -8,9 +8,52 @@
 #include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 
 #include "iommufd_private.h"
 
+static int iommufd_save_ioas(struct iommufd_ctx *ictx,
+			     struct iommufd_lu *iommufd_lu)
+{
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_ioas *ioas = NULL;
+	struct iommufd_object *obj;
+	unsigned long index;
+	int rc;
+
+	/* Iterate each ioas. */
+	xa_for_each(&ictx->objects, index, obj) {
+		if (obj->type != IOMMUFD_OBJ_IOAS)
+			continue;
+
+		ioas = (struct iommufd_ioas *)obj;
+		mutex_lock(&ioas->mutex);
+
+		/*
+		 * TODO: Iterate over each device of this iommufd and only save
+		 * hwpt/domain if the device is persisted.
+		 */
+		list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_item) {
+			if (!hwpt_paging->common.domain)
+				continue;
+
+			rc = iommu_domain_preserve(hwpt_paging->common.domain);
+			if (rc)
+				goto err;
+		}
+
+		mutex_unlock(&ioas->mutex);
+		ioas = NULL;
+	}
+
+	return 0;
+
+err:
+	if (ioas)
+		mutex_unlock(&ioas->mutex);
+	return rc;
+}
+
 static int iommufd_liveupdate_prepare(struct liveupdate_file_handler *handler,
 				      struct file *file, u64 *data)
 {
@@ -33,6 +76,10 @@ static int iommufd_liveupdate_prepare(struct liveupdate_file_handler *handler,
 
 	iommufd_lu = folio_address(folio_lu);
 
+	rc = iommufd_save_ioas(ictx, iommufd_lu);
+	if (rc)
+		goto err_folio_put;
+
 	rc = kho_preserve_folio(folio_lu);
 	if (rc)
 		goto err_folio_put;
-- 
2.51.0.536.g15c5d4f767-goog

