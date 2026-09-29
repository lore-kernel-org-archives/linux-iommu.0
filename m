Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0BD3E00A0
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651652; cv=none; b=jJYDu1gPs7lnJuzpRTk7vK/qs2xcIZTNt+jn3Gw8hSmFxGxC6uv2uYx7X/nBY+zbReJ7IaOAtyfLvpKomWCMMvXFv7grPRYWm40XWXw7LUnxLSaXRcvyFYA4ilr9hOapmt/7CfJHAbpD47F/6wOL992hdQCF6wisfMRgTR43aIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651652; c=relaxed/simple;
	bh=E0QVRun1Rtl9by+zxe8bI3xBduqYg8w0MLEhejpTV+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQ5A9ELM0vuGt/AJPs6Q368NohZcA+YGU0mCU3CJDRjl4z/JRW7EYEJMcJuvwthfgi756q1RvYDzYiD6mPTXRwYYSRtmj/Jqnf+c4fHJydSjIlUsdyP0BvKhbv5sgljG4AYKDbiJQSJB3KmMZbqPNTLHWjfGzY53m+QMI+AeXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkR+HLbW; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkR+HLbW"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so1485423a12.3
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790651648; x=1791256448; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8KiajsX9AXzugaV+rM1roV/GBOKr61T0qmPfAwnIkdk=;
        b=gkR+HLbW3daIpQg1G1eAMZ3vHfiK8KHReDfesh+YCICW1ocK05Ty08HUFyUurhmbQs
         avyVM9kGObrzdXbf6rZDF2Dh5PTINNx/ZJ3U0rTFuy1Owzvk+d1SfjgzssrXmb3ezL4h
         Olu3wKeZvxcgTi5e+F911qMAQZPYsLJE2tRefJE5TNlCUX0MUxi01qTdiK1Su1BxnQ22
         9+AoAN+j+frZL9/AypX+dvjCqHlj1gCDifPNru7/dGd6LRT7Oht01ZCZfUV4ExSP7W9b
         o/xw7+a7oJC0J84igzSUsGbkdVqzo2aJBGxZ2z9tm/p2S643lpwgIqIG0KT2nPyNOWPZ
         oPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651648; x=1791256448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8KiajsX9AXzugaV+rM1roV/GBOKr61T0qmPfAwnIkdk=;
        b=qlNg2ZAsSCsyIWOa+nyNcWhpApkXW8DuUq094+V0V/sSE9Z1wx9mNEbRz+TrAwrO+6
         lEsvNHRcEFN0RhMjK8Wxn/VbHXHM3sV64HfTGKXV/zL7DcxcK2FFd0hRZqMM74Y58cel
         el1VIVRAuPTkHFT49y1jBWChkvtRbThm48Bfq5OOksov7y0aypWqB2mG7RMkc7HcjKq5
         rhV2m4zmQrEafFgmMH7DZ250bHYOeAwUHvSL4nDK78SBcoM0n9RHYpiWzQj47eKPkz4e
         PSXp0go/NU0HLBpcn/ffBRUVU41HuQBeCo1R1KoPoE547tlrAGBUw7Jvp75+1v0MUJw9
         burw==
X-Forwarded-Encrypted: i=1; AKwUvBzyBq/uHY/iB+u3Zb0DYFGDockgYZOFFenA0aKllhsVi8jULqkhZc3Pp3/I0ryMmhHFMFe+7Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYIBQAGt4qt9s80gUjocz5gz/eHrQBrYiKiNnr07qUm7V2AVEYJB
	jxvTzgkmEzCeBDBjaxilk5TwetaGJcJ2fxU1w1tpLAOQtWjMRyK1+Ak=
X-Gm-Gg: AYBFou0AxTMHkj2ht5HsjuKBbJgAo6cRAa1rj/ezgXqqxThKh1wcH4tcWhi1c43RUQ7
	8QSs4nZB+Vqx4LaTMDkR7PeE815WJWbro56aTi9MXj7g4M5ixXANjBNCjsc9lVBWeaROqD1Xa6/
	kmyeSqLO5SR4QlctZYV5cUOF+9gyaf/ug/uq7q98bueiZ9RSAECTNQI4G75xgsmx+1+WK6VxO0b
	/o1Qx1j7UsFATpDVMAQVvKl6ojGFmcTwOR0U0ocJgCgmXFf6/RtfNr1SIMVGVPTzymNmSiEHVys
	m3UTkLDyQM7huFomRHFcPfj6ZdcjJiNwk19V6S65JNIMk+IhBVFLBg6lMTS2UjeQwos3DNjI3lL
	NwTD3cPgsD/mygjTN0OuGCVsaPObUn2J8eIg+isXE2HiBtjldl5Uthn6z+w78qyoqHYHBBGPy7+
	cwqsF+++/z7HWKoxhm41hUWhiQyIfdcqlwX7Zpv2FuC3n70nDtTI7DbaUa75oz9VLZuQozxD0lu
	tK0htC2IFOw71B4Frhk/x5qoQ==
X-Received: by 2002:a17:90a:e70f:b0:3a4:9a7a:360 with SMTP id 98e67ed59e1d1-3a49a7a0402mr1413209a91.29.1790651647749;
        Mon, 28 Sep 2026 20:14:07 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:712c:b4ae:1eb:26ce:7dc5:ed80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497e90180sm2756476a91.2.2026.09.28.20.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:14:07 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH] iommufd: Keep reserved IOVA ranges when a replace within one IOAS fails
Date: Tue, 29 Sep 2026 12:14:02 +0900
Message-ID: <20260929031402.1998253-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd_device_do_replace() installs the group's reserved IOVA ranges in
the new hwpt's IOAS only when it differs from the old hwpt's IOAS. If the
replace fails in iommufd_device_do_replace() or
iommufd_group_do_replace_reserved_iova(), the error paths remove the
ranges from the new hwpt's IOAS whether or not the IOAS is shared
between the old and new hwpt, which removes the ranges that the old hwpt
still needs.

For example, on x86 with intel-iommu, after a replace within a shared
IOAS fails with -ENODEV, IOMMU_IOAS_IOVA_RANGES goes from

  0x0-0xfedfffff
  0xfef00000-0xffffffffffff

to

  0x0-0xffffffffffff

and IOMMU_IOAS_MAP at 0xfee00000 succeeds.

Remove the ranges on failure only when the replace installed them, and
look up the old hwpt_paging before the replace so that the error path
can compare the IOAS.

Fixes: e88d4ec154a8 ("iommufd: Add iommufd_device_replace()")
Assisted-by: LLM
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Tested on 72d3fcf802c4 in QEMU (q35, intel-iommu) with vfio-pci devices.
The replace was made to fail by moving a device without PRI to a hwpt
allocated with IOMMU_HWPT_FAULT_ID_VALID, which intel-iommu rejects.
Checked whether the MSI window (0xfee00000-0xfeefffff) is still reserved
in the original IOAS after each case:

  case                                  unpatched   patched
  replace fails, shared IOAS            no          yes
  replace fails twice, then succeeds    no          yes
  replace fails, different IOAS         yes         yes
  replace succeeds, shared IOAS         yes         yes
  replace succeeds, different IOAS      no (moved)  no (moved)

tools/testing/selftests/iommu: identical per-test results on both kernels.

 drivers/iommu/iommufd/device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a664c70a6fe73..1b0bdf57ac8ab 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -849,7 +849,8 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 	return 0;
 
 err_unresv:
-	iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
+	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas)
+		iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
 	return rc;
 }
 
@@ -889,6 +890,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 		return NULL;
 	}
 
+	old_hwpt_paging = find_hwpt_paging(old_hwpt);
 	if (attach_resv) {
 		rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt_paging);
 		if (rc)
@@ -899,7 +901,6 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	if (rc)
 		goto err_unresv;
 
-	old_hwpt_paging = find_hwpt_paging(old_hwpt);
 	if (old_hwpt_paging && pasid == IOMMU_NO_PASID &&
 	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
 		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);
@@ -920,7 +921,8 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
 err_unresv:
-	if (attach_resv)
+	if (attach_resv &&
+	    (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
 		iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
 err_unlock:
 	mutex_unlock(&igroup->lock);
-- 
2.53.0

