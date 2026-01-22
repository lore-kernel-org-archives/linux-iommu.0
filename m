Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE33AEF3D;
	Thu, 22 Jan 2026 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118166; cv=none; b=TPc2f+aGTIqdIaQ/m/Sv77iy5my2c6jqGEFY2rUHYTrQcQs1Lx1KXYgnFn/E4MRm0o3VNY5VGLG9xHpPkXSWeEijHmyBI5Oq5riMSuwk7RfbFCZgZxveXlbkC38z412hijW1roP3sUAAcmuymd90ZhOAMzHio0HFzWEV1KOaLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118166; c=relaxed/simple;
	bh=1Jo3ET0g+chyT/LH63OP3cihESO47HbvWSXedosLLtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UKHPXVM/WoU/0X0TSHWkJSB+LQcinXFjeOpl6woB6s3lBMCmAYSbKWfSjawtOr5ZpnsKzfa6rKHaxerPyfj1AzG0P/XMjKbrmWUEMPK4geBbbP9Xp/sh7VCSWoTOkq66gqrVrhX6JmhW5YSkPkjpbRlYKSgErCPitRBCJSNqcQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abYgJNPa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abYgJNPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB188C116C6;
	Thu, 22 Jan 2026 21:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769118165;
	bh=1Jo3ET0g+chyT/LH63OP3cihESO47HbvWSXedosLLtE=;
	h=From:Date:Subject:To:Cc:From;
	b=abYgJNPaua+jCv+EiTo3eJ3k3nal3wvlM0Li3cwjSYl9qwyls68vcAxD5GzyrIGwF
	 YbUJcflrGEGbNjAyPGPCxqcO83HV1hkSnLuzDSIaTWkPwjorBgkfMQgFLcvNIFFrp8
	 RrP0i0ErYAMHpX7gZmWNQf82UsB5YlNG7Q2kCDE4zUvMV8in9T36acdTGW/GRNyy9b
	 xVV0BnR8m4QtxQwccrptLYREvr7HUEwZx3OsD6rsyF2S41EmvCxGs9fMpW/ORdnyjI
	 2L8ukcziSXxQCXoLFIhnsD01keuEeAj3RqgyO7shxn4EFp60EpjBvorSivXrcdujxx
	 F93ljT5DaSjJQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 22 Jan 2026 14:42:38 -0700
Subject: [PATCH] iommu/amd: Fix type of type parameter to
 amd_iommufd_hw_info()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-amd-iommufd-fix-wifpts-v1-1-8ee604527875@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqEMAyF4VeRrA3YIg7jq4gLbdKZDFSl8Qbiu
 1vH5cfh/AcoR2GFOjsg8ioq45Bg8gzctxs+jELJYAtbFcZa7AKhjCEsntDLjpv4aVYkT++ydL0
 zL4Z0niKn9R9u2se69D92812D87wA4YiHg3oAAAA=
X-Change-ID: 20260122-amd-iommufd-fix-wifpts-dfd944cbc17e
To: Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743; i=nathan@kernel.org;
 h=from:subject:message-id; bh=1Jo3ET0g+chyT/LH63OP3cihESO47HbvWSXedosLLtE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlFMy/LeUfNTe65vudDg9FzgchnW8+97shZc4c3OpbHp
 S6S93prRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZgIgzrDP02re9fTmvaYz/Zt
 kfVgjbZueDUt9Z9+dHbXfva9i455cDAyHHgozbDfP15Oe42Z+8Xpi1qyOJfy11e9n7Wwaad00qu
 NPAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with -Wincompatible-function-pointer-types-strict, a
warning designed to catch kernel control flow integrity (kCFI) issues at
build time, there is an instance around amd_iommufd_hw_info():

  drivers/iommu/amd/iommu.c:3141:13: error: incompatible function pointer types initializing 'void *(*)(struct device *, u32 *, enum iommu_hw_info_type *)' (aka 'void *(*)(struct device *, unsigned int *, enum iommu_hw_info_type *)') with an expression of type 'void *(struct device *, u32 *, u32 *)' (aka 'void *(struct device *, unsigned int *, unsigned int *)') [-Werror,-Wincompatible-function-pointer-types-strict]
   3141 |         .hw_info = amd_iommufd_hw_info,
        |                    ^~~~~~~~~~~~~~~~~~~

While 'u32 *' and 'enum iommu_hw_info_type *' are ABI compatible, hence
no regular warning from -Wincompatible-function-pointer-types, the
mismatch will trigger a kCFI violation when amd_iommufd_hw_info() is
called indirectly.

Update the type parameter of amd_iommufd_hw_info() to be
'enum iommu_hw_info_type *' to match the prototype in
'struct iommu_ops', clearing up the warning and kCFI violation.

Fixes: 7d8b06ecc45b ("iommu/amd: Add support for hw_info for iommu capability query")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/iommu/amd/iommufd.c | 2 +-
 drivers/iommu/amd/iommufd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index ad627fd5ccc7..96ec6a4a760d 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -11,7 +11,7 @@
 
 static const struct iommufd_viommu_ops amd_viommu_ops;
 
-void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
+void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_type *type)
 {
 	struct iommu_hw_info_amd *hwinfo;
 
diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
index f05aad495b5b..62e9e1bebfbe 100644
--- a/drivers/iommu/amd/iommufd.h
+++ b/drivers/iommu/amd/iommufd.h
@@ -7,7 +7,7 @@
 #define AMD_IOMMUFD_H
 
 #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
-void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
+void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_type *type);
 size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type);
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data);

---
base-commit: c0a652a3d1970caa0023632ae3a4ea21991d2f1a
change-id: 20260122-amd-iommufd-fix-wifpts-dfd944cbc17e

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>

