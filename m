Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4E57D213;
	Thu, 17 Sep 2026 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653811; cv=none; b=ZLwEYwrepcLPGow8aM/z+v1Yf36fFdKOhyPfHs8f1LR7sM+lf2JBg86BUemaFMwpUfSJkiLsCwV6q2JPTm1BynCPfExjgp4C18vWJs5hVp8il/iQfqf9+9qvC8hF0V40tCSgCuJNI84tX/MR9nxqftOf0xq1/Gsz7cXQKrIrjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653811; c=relaxed/simple;
	bh=CRlkuVSNCL+K3guGa60sK05FvrUBw5E/lQqAmg8TnEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7WYwiPEge8qgfCL4sDG/wyJ9jS041mjo/yNAhL2PzQsR0cNL3BBUQ648v3AUC9HLA+ihM/lNuJO6NpPdmwJ1g4V/Mt/rQFUmx754SL6+08GcIp+OuswopU4UwJK66AdWHL2eMqJZQV92dH3dZPk+vEOu+3YtzUZe0igeTGAe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNqaNV0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNqaNV0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045DE1F000FF;
	Thu, 17 Sep 2026 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653807;
	bh=kYPOci51J9ymg5YOitMfoWSrOdVs2KNRRIQ8zCl/hJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LNqaNV0Ut43iYq70CLaSD0ZTt0bYFypaQi3zO8BVNPfytGo5DCwjoHUqagLLW1p3W
	 jQuVm2mHopBer9//guyT8FmtTCAsLCXebfZjxjqa7EY3KD5MgJhIittg+z2CanMX3a
	 UDqd74eyCrDjsHK4lio6MEvPXjVZc3yy4SFF7DF0nHW0hd1c49wCljBSv7TBHDHenj
	 /XrvSrUC9NX+rG9RikHAFfifAtL4WGl6lO6JfJkNF3NYPk0S1KHTjGeF8yzgCC1ccv
	 oqw/wrm1AHB1eA8Rap9bLgje2ejDimM6H6zi9AMrCclS3ZySsdIU4pTzYAWh1MS0iw
	 bVSnpO0v3DRTg==
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
Subject: [RFC PATCH v6 06/11] iommu: Add a helper to query vIOMMU hardware parameters
Date: Thu, 17 Sep 2026 19:31:54 +0530
Message-ID: <20260917140159.1163281-7-aneesh.kumar@kernel.org>
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

Expose a type-specific kernel parameter query through the physical IOMMU
driver. This lets an external vIOMMU provider obtain hardware parameters
without depending on private driver structures.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommu.c | 11 +++++++++++
 include/linux/iommu.h |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 04cd5a686e18..70ca10380742 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -58,6 +58,17 @@ int iommu_viommu_validate_parent(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_viommu_validate_parent);
 
+int iommu_viommu_get_params(struct device *dev,
+		enum iommu_viommu_type type, void *params, size_t params_size)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	if (!ops->viommu_get_params)
+		return -EOPNOTSUPP;
+	return ops->viommu_get_params(dev, type, params, params_size);
+}
+EXPORT_SYMBOL_GPL(iommu_viommu_get_params);
+
 /* Tags used with xa_tag_pointer() in group->pasid_array */
 enum { IOMMU_PASID_ARRAY_DOMAIN = 0, IOMMU_PASID_ARRAY_HANDLE = 1 };
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ee016a7c7a41..c006478c4b04 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -437,6 +437,8 @@ struct iommu_user_data {
 
 int iommu_viommu_validate_parent(struct device *dev,
 		enum iommu_viommu_type type, struct iommu_domain *parent_domain);
+int iommu_viommu_get_params(struct device *dev,
+		enum iommu_viommu_type type, void *params, size_t params_size);
 
 /**
  * struct iommu_user_data_array - iommu driver specific user space data array
@@ -684,6 +686,8 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  *               set @viommu->ops pointing to its own viommu_ops
  * @viommu_validate_parent: Validate that @parent_domain is compatible with
  *                          @dev for @viommu_type.
+ * @viommu_get_params: Fill a kernel buffer with parameters for @viommu_type.
+ *                     The buffer format is defined by that vIOMMU type.
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
  *                   translation.
@@ -742,6 +746,9 @@ struct iommu_ops {
 	int (*viommu_validate_parent)(struct device *dev,
 				      enum iommu_viommu_type viommu_type,
 				      struct iommu_domain *parent_domain);
+	int (*viommu_get_params)(struct device *dev,
+				 enum iommu_viommu_type viommu_type,
+				 void *params, size_t params_size);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	struct module *owner;
-- 
2.43.0

