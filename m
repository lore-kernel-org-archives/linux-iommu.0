Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280A56E05D;
	Thu, 17 Sep 2026 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653799; cv=none; b=UF7UhkMfSkSTbAe4+YadyRLgxCZL+ycS3Hq8k/16vr8bceHu0xsIr+pSqLonXbXZnjR+KJMpnRX91n1JW/ZwhOPwrIdQbZS2N8A/K7CxpTcAsDx6Fu1wmIEG9caEYharIS1lhPuj4wmo3KujHJ4pU077vYg/8PM02NAOVlLa+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653799; c=relaxed/simple;
	bh=14Js+dHOD1nUBg/odeDxXKAu4rbFwEKOFsL+RT7+odU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjDv2byPXaUQmlNtWJ6mgyEauvXooJMHR1wieoWJRM89HkPWbdtE+ISvMBsal6ZnPzV54Om1E4o7uEhheQWHsybBt0KJ24OlwU5z3ZTMCunw+9nP3LBZ3EJKJkDe2vnLoB/u/NbyOD/KGa1qyyEkuOZxZJVOm2RXySZJLDXulms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMWO7rI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMWO7rI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9941F00893;
	Thu, 17 Sep 2026 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653798;
	bh=j++GxayTN2VHprz5XrBEAWC/QN1HnZASp2sGP+7sISQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMWO7rI8UUV355gbOkwO/E7b7Pbh7IPsL957TYRtX05nGQ+B35OYDFHo/L9bO4hl3
	 e5GTaj2mLAJpjCVd+/Flh7SaBYeYQORDveOXZdXTh9kFIkdDdwJ+bRjZWxeyy549ph
	 8b8Dr51BDVAx5aDpWBjwcVqDJDcCRHapql/Wbwkp+GT9aZa9nkgS9PNWqin6lojS9c
	 qEKXC8ZyASEzQWhymufnZn3I6vX2NeWBE1cHX+Dgd/1a1TYldv/MBXjkpNYFWwJ5F+
	 UYVNZeEGhDi0QJCV9qq57vwWw7uRzPHXpRzhXNfDTQqQ/pKaW2+K49pyesNQ1SHrrO
	 pt7gHQxrsjvUA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU parent
Date: Thu, 17 Sep 2026 19:31:53 +0530
Message-ID: <20260917140159.1163281-6-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let a vIOMMU implementation ask the physical IOMMU driver whether a
device and nesting parent are compatible. Return EOPNOTSUPP when the
driver does not supply the validation callback.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommu.c | 11 +++++++++++
 include/linux/iommu.h |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dcebbde..04cd5a686e18 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -47,6 +47,17 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
+int iommu_viommu_validate_parent(struct device *dev,
+		enum iommu_viommu_type type, struct iommu_domain *parent_domain)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	if (!ops->viommu_validate_parent)
+		return -EOPNOTSUPP;
+	return ops->viommu_validate_parent(dev, type, parent_domain);
+}
+EXPORT_SYMBOL_GPL(iommu_viommu_validate_parent);
+
 /* Tags used with xa_tag_pointer() in group->pasid_array */
 enum { IOMMU_PASID_ARRAY_DOMAIN = 0, IOMMU_PASID_ARRAY_HANDLE = 1 };
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863a..ee016a7c7a41 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -435,6 +435,9 @@ struct iommu_user_data {
 	size_t len;
 };
 
+int iommu_viommu_validate_parent(struct device *dev,
+		enum iommu_viommu_type type, struct iommu_domain *parent_domain);
+
 /**
  * struct iommu_user_data_array - iommu driver specific user space data array
  * @type: The data type of all the entries in the user buffer array
@@ -679,6 +682,8 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  *               resources shared/passed to user space IOMMU instance. Associate
  *               it with a nesting @parent_domain. It is required for driver to
  *               set @viommu->ops pointing to its own viommu_ops
+ * @viommu_validate_parent: Validate that @parent_domain is compatible with
+ *                          @dev for @viommu_type.
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
  *                   translation.
@@ -734,6 +739,9 @@ struct iommu_ops {
 	int (*viommu_init)(struct iommufd_viommu *viommu,
 			   struct iommu_domain *parent_domain,
 			   const struct iommu_user_data *user_data);
+	int (*viommu_validate_parent)(struct device *dev,
+				      enum iommu_viommu_type viommu_type,
+				      struct iommu_domain *parent_domain);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	struct module *owner;
-- 
2.43.0

