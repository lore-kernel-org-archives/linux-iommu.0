Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8617A2E6
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764128197; cv=none; b=cSJcTumO1/IebAJhfZ9tlGlUaUcYBtM97r5WqLdZzqvsCJv+LfFQKbOi67azCq2Ns2ZOAgp1ohlsWwuvoYRjz4EiGQoR6EJUQ4VPM9UvM3CBo3ABQFkQOrFmvDZ9VwGROy+nQ/sw5TbQwxoFqRuPcKV28VNRpdPw8DiqmJp+n/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764128197; c=relaxed/simple;
	bh=zMFu608CuZ2nFKv6LrMzd1ndQlr9L32dHna+WZ3FQVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Avd9XNbYMijYfk0d4/FKw6xUBqZEm5bN+SwD+xAYCxfT5IdbBmPOVgJJQ6H7afJeGqrb3ktNVjbF0/6HwLFgp4oMMmtZRpf/BQ5VfcYmmzbrcmn3sDRhqKHbt+wTZi0HB1//vMAF4j+7TEPP98vo0Nnd4w7tDWcIAUDz8chL5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWY/a+dF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWY/a+dF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29ba9249e9dso20284855ad.3
        for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 19:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764128196; x=1764732996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCO8CV5c2NCEpiVClP+pH7mBZNCDGS0UxQk7d2nRlcg=;
        b=AWY/a+dFDdpgv/mopdeA878Gb1Hqm6wogOpNHKcWRatVkssMAJtctbrs6MWliTuJye
         LJ60PoiEzkYpMWy3WUx/4VnpTVj+ya0I2XixXDbWhgYY0mYDWVX9NgWdzAc7OD0IYnBl
         BKW2rgSpokbnfWC5i6NpMZOjyjZlJmaewykh4xfSGlYVVnvdk7GyZSFhHKIh5gCej4ul
         IQkU9byGoh1etEuF6duh+2F0BK/F77o9m6y4RYBqTX3xwwDE966I1a0EQ254brspuEYd
         DHDPT+GLHzwbRc6EDt2hldWrgfnzYLRunlOMz+AA81fWBpYS8psJN9xmZlclvaO8I0u1
         wuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764128196; x=1764732996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCO8CV5c2NCEpiVClP+pH7mBZNCDGS0UxQk7d2nRlcg=;
        b=ehGfX077iMSj9OsEQhrC1FnngSjCVcPHI/kPspYGOfjQ2wS+yKqLSiEiQdggRn0G7+
         RzsXj/4Q6GW42GBVbe3xFKjQgm0Xs/oAvh5OO6WJujYXa0vbJIBLbGtmIyLujV2LkrNf
         UHF4JdkNdrR9ZaGsOV/uB/QTIxWnUpdRnddmPUFg6xn1OO17O07yL9yt57tf4wkqnUXk
         8o36yDViw0Cec0RGhjjAH+A2mOKZIGavM0IzxO2WQ2vz+vxzxdNL2qbD8db9RWcC4vjI
         uiEzHnAfzLYy2JKU23fzI6pPu3xzWlaxTeiAR936hFwoKJfEjH+La8Az1l+nEoz5skPC
         wyEw==
X-Forwarded-Encrypted: i=1; AJvYcCVGBhAQAvEgzD2v5Plo9gjuMbeyUDZrfr6EiBrw47rZeZL9qctFiYoRRkKNw5s4R1XGdaiJLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm56qxSkDWwRO6WckNjEGMJkk4lYKf5iTUzAYEgj/6lR0ZnJw4
	K7RMVzthfaowkXes6GSSFOKFXy7XQx2EXIRMISF0RWS9UmZZ74XIGJ+4
X-Gm-Gg: ASbGncvzFRxjUAISH2AdnsRdN+0OljYHW09eCzzRErVFHLAeH2ItuVPi2pk5RA/ph8x
	M/+uDgNkmkqBeiebAsFVCxtnNjV9MY3Pc57lwCvSQScvDUXM4uG68G5jqjHMtKgouBhrVQDgVOH
	QKrIcpMakUFGiHteOfBKQll4kNCZ4i02M23aNzNC/y3U1SkwygX/pXVbTFpUgd0jc42UnAXm26D
	KfPImQYIi033t9zdtlLtSR20fd3LZfoBDumBIBQWfoNMcvQcPqjYFtQD7eWvXfC0s7yT2+TIFUX
	YgALcuMTR5aa017womQ8MbYzMaETIJdcwsPWBhSzg3TpnR51YllbHfqwyiBcogw6v3KQ9NgBzMh
	H7XwD/z25xKBBsZNznA/keShGSoshVMJP/5oyWvqOTIpZaRoHHKl0SFR99xB0fvvO3tdg1moT5M
	yq2kVV9X9C/0c=
X-Google-Smtp-Source: AGHT+IHhd9qGaeJS/wuZiqSRNY4Ryl1sXYPai0Ym3EV+uvefn07sPl23ppcrOh+ZZhr2mVGD/7vGEg==
X-Received: by 2002:a17:903:98c:b0:298:250b:19eb with SMTP id d9443c01a7336-29b6c6f04a1mr183093425ad.60.1764128195749;
        Tue, 25 Nov 2025 19:36:35 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ae1c3sm183730025ad.92.2025.11.25.19.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:36:35 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5C35D476D832; Wed, 26 Nov 2025 10:36:33 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] iommu/arm-smmu-v3-iommufd: Separate vDEVICE allocation list
Date: Wed, 26 Nov 2025 10:36:03 +0700
Message-ID: <20251126033602.28871-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=bagasdotme@gmail.com; h=from:subject; bh=zMFu608CuZ2nFKv6LrMzd1ndQlr9L32dHna+WZ3FQVs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJlqpeHpx9StrIVfv88+78DG8cEv1If1faPRD5PJE45/Z 7ym8uFhRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYiasLwV1ap/Xu74jOjzorc TOlLZgdjPDwEnuiazbn7VXPB1kcTIxkZlqfJXpU03GcX8dl9/T9L9hXGi3idFHx8zink35CRDSh mBAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warnings when merging iommufd tree:

Documentation/userspace-api/iommufd:335: include/uapi/linux/iommufd.h:456: ERROR: Unexpected indentation. [docutils]
Documentation/userspace-api/iommufd:335: include/uapi/linux/iommufd.h:457: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]

Fix them by separating vDEVICE allocation list from preceding paragraph.

Fixes: 9f0b286fe40130 ("iommu/arm-smmu-v3-iommufd: Allow attaching nested domain for GBPA cases")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251126125920.207fc959@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/uapi/linux/iommufd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 225671603ade66..2c41920b641dc1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -453,6 +453,7 @@ struct iommu_hwpt_vtd_s1 {
  *
  * It's suggested to allocate a vDEVICE object carrying vSID and then re-attach
  * the nested domain, as soon as the vSID is available in the VMM level:
+ *
  * - when Cfg=translate, a vDEVICE must be allocated prior to attaching to the
  *   allocated nested domain, as CD/ATS invalidations and vevents need a vSID.
  * - when Cfg=bypass/abort, a vDEVICE is not enforced during the nested domain

base-commit: 800b311b5afbca04e204eec98ee12667c88e9ae5
-- 
An old man doll... just what I always wanted! - Clara

