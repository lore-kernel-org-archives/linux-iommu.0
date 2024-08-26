Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEDC155CBA
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672464; cv=none; b=rplaUa8CPBxBkqjmZVPpkvykfnuxQ1OgEAYhKMrxWSFSCz/h963Tb28whCWAAjanpBJsutmXna9xbshnr2Gn9gNBrRD+0ndtP7YYEj/72z+n2qgnayWqmVF2D6EVihSW0LgQ3JRNOub+w6x125PuvLd6BOXfFRvSaqj3eFq9b48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672464; c=relaxed/simple;
	bh=QwdKBKUjHQcCaR0COG6te3pLXHZzB3VkLWQ3UeLhuyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HeF7hyrX2M9BmS/rTj/4gHV6eXlk7w7mJn80Lt85zw+J6g9pOchIVcLCt9oLDlya07EaN5TCCd+1fvW9p2Rqr6FWThEpHVk8vN5vI0oJvTUs33Ueh7HCEef08XxVhNBxMheRK+lMFpXt4J2TKP/FEytfC5z5vObaiw8a+gTP3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk; spf=pass smtp.mailfrom=irrelevant.dk; dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b=T/OwSFlz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C0pvuL7g; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="T/OwSFlz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C0pvuL7g"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9B37E1390066;
	Mon, 26 Aug 2024 07:41:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 26 Aug 2024 07:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1724672461; x=1724758861; bh=vE8VUoDK+3jeL5mY3Ecz/OM6t9sanOqw
	7sgab91lrt8=; b=T/OwSFlz2XJSoFtJfY2CsLrGqn/vjjfixer91VAvCoqWtr6o
	8uAOscJMH1LfqaldqxKXX+9ic7/CXPeJGbNlKl41R4Uy3vZx4xly2GTq1Ikly7Tm
	bfCtUengkHpn6I5J6xy3ukWvZgweNZ+0DFVtdHHcwhySF7Q6gYC/jrCf+Z2d6lWf
	wcfbrZEzmQilkG4vGLkNjMu54u7eEh0iN5omF8xXnBPFJDduTzs4DD5XD0o1yPbZ
	RBynv+bnSTknGLeP9vLIDZlUcii8tg/lxBOTN44qojCi7QBHQDMJJNjLS9dC2q95
	qUeorRf9tZ4AP6fIEycEFeZoEIJarTjcaGHqAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724672461; x=
	1724758861; bh=vE8VUoDK+3jeL5mY3Ecz/OM6t9sanOqw7sgab91lrt8=; b=C
	0pvuL7gCsAnY5h/7ilr9x2SrJ6UApMzEeqbJzuo3QG/1e+/woPT9DnDyRNNDsFGR
	zYtwcssiqV10JkYmbhBtsxyaJ7r+4T4RlVlxGiXP23OZtV2Xi3IqF0QixKPCvkjJ
	hNaitrhvcMiw99fXfgZkzysDERy49DgaoQw+TZKoc4RlexbVOpzuGxe4sMTuXo7V
	eZfAUjq+eCmMUzOSk05ZFOgQ44ZP+tNcUmXK42w/twU3rQoPivfghHQW/eAxKUe3
	vdmz2RoVOp6ojQWS1UPmGwD+a8QFcUOit9pKvFUqCKnyduTHpn6VqkXBlzjO6W5z
	qKfZb6ERllA4TcMVikrkQ==
X-ME-Sender: <xms:zWnMZmLMbXJ2WQgoCz3c4nsaJnR5sph3eYjClnmrGP9qoNS4yBQt_w>
    <xme:zWnMZuItrgyjHexPHEGvw8Pzcs3Yl1O9hahgSMB6G0tz5oCqxgPk65NfVOQjbbBcD
    vZ4guESsOb84sMSvxc>
X-ME-Received: <xmr:zWnMZmvtGiO6_EEm74Fh64w-ZtI9dOKeFrmw0obgJFcafgynTD9cZ2u2BNagKql44URuuJ4DeQiZF9Ioo1UW1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
    drughkqeenucggtffrrghtthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudev
    gefgffeiteevfffhhefggefhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
    thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhdrghhrrghnrgguoh
    hssehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhu
    nhhgrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpd
    hrtghpthhtohepugifmhifvdesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehi
    ohhmmhhusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhhosghinhdrmh
    hurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepsggrohhluhdrlhhusehlihhnuhig
    rdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhinhifohhordhimhesshgrmhhsuhhngh
    drtghomhdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhg
X-ME-Proxy: <xmx:zWnMZrakTBGnb7-XKnGV7hynZHBBVBkXsHmL1TzTyRjs4_69CzsMXw>
    <xmx:zWnMZtZpqSFJJWY27RC6O4UcddMkUfFVE-dZDHYZQkPgFkp2SUl2mA>
    <xmx:zWnMZnDwZjDCKnmIOBR8LLNfiIGc2g7AzDR4KPY1jvP98v-9nz-DWw>
    <xmx:zWnMZjaRtlHlxHo083zaqysknmZuvUnKgFtoXPjg260oebhI5IV4aw>
    <xmx:zWnMZhRLod86NFJP2wNd6fJJG_B2GLc133fPyWDQ3tsdi9Hn9RGHHoM1>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 07:40:59 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 26 Aug 2024 13:40:30 +0200
Subject: [PATCH RFC PREVIEW 4/6] iommu: init pasid array while doing
 domain_replace and iopf is active
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-iopf-for-all-v1-4-59174e6a7528@samsung.com>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
In-Reply-To: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, Joel Granados <j.granados@samsung.com>, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4192; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=lXHuPImJ6cuCzq6Nq2YtwMc4JoBLUbpYEcsoNAUv1f0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2JNYWIrdzlQVU5NNG1RSEpiYnAzYmI3azRCCnVSdUk4NE9OMi9wRkk1c29J
 N0VaSTRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbXpHbS9
 BQW9KRUUzaHJ6RnRUdzNwWng0SUFKd3pud1d3TzlWd3RlYnp6QUtWMWprazFHQVBhSnNacTAxNQ
 pkYTBEdTFYenJCVTFUMnZuVi94OGgxL2JkNjJ3VlJLM2U2clJ0aHd0ajJPYXJORDdEK09OU3ove
 TdwK0I1VWNvCmxUdW5tanBDQkVDQXZZVlNDZ0d3N01qWkk1WC8rRUpKM25uVFhBd2cxZEwxVllj
 Y2h3amk4VGwyMVNrQlJPdGoKcTZFd00ybS8wbEhEYkRFeEp4UndRZ0syNkliUFQwMTY0cTZiZUh
 EQkU0NHlLSEV3VWxyYVNiSDQ0SlpmRGp1RwplL0RkSXJoZFdUNjZMdnhMaDJhbUZ2d3hGUk9uQk
 tRUHZZOUEraGRSZUQ1UUR0QndoOTlhdXBYK1h3SHNwRmh2Cm11VFc2SEFvSkhZYkxBaUtMc0o5c
 EF6N1J6S1YrSW9VaytPTjlEbm0rdVhHZGU2dzl0OVZIS3BKCj1wSDRvCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838

From: Joel Granados <j.granados@samsung.com>

iommu_report_device_fault expects a pasid array to have an
iommu_attach_handle when a fault is detected. Add this handle when the
replacing hwpt has a valid iommufd fault object. Remove it when we
release ownership of the group.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/iommu-priv.h    |  3 +++
 drivers/iommu/iommu.c         | 31 +++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/fault.c | 22 ++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index de5b54eaa8bf..493e501badc7 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -38,6 +38,9 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group *group,
 						    ioasid_t pasid,
 						    unsigned int type);
+int iommu_init_pasid_array(struct iommu_domain *domain,
+			   struct iommu_group *group,
+			   struct iommu_attach_handle *handle);
 int iommu_attach_group_handle(struct iommu_domain *domain,
 			      struct iommu_group *group,
 			      struct iommu_attach_handle *handle);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed6c5cb60c5a..083bf1bbad93 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3262,6 +3262,9 @@ EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
 
 static void __iommu_release_dma_ownership(struct iommu_group *group)
 {
+	if (!xa_empty(&group->pasid_array))
+		xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+
 	if (WARN_ON(!group->owner_cnt || !group->owner ||
 		    !xa_empty(&group->pasid_array)))
 		return;
@@ -3495,6 +3498,33 @@ iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int
 }
 EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_get, IOMMUFD_INTERNAL);
 
+/**
+ * iommu_init_pasid_array - Initialize pasid array in the domain group
+ *
+ * Returns 0 on success. Error code on failure
+ *
+ * An IOMMU_NO_PASID element is *NOT* replaced if there is one already there.
+ */
+int iommu_init_pasid_array(struct iommu_domain *domain,
+			   struct iommu_group *group,
+			   struct iommu_attach_handle *handle)
+{
+	int ret;
+
+	if (handle)
+		handle->domain = domain;
+
+	mutex_lock(&group->mutex);
+	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
+	mutex_unlock(&group->mutex);
+
+	if (ret == -EBUSY)
+		ret = 0;
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_init_pasid_array, IOMMUFD_INTERNAL);
+
 /**
  * iommu_attach_group_handle - Attach an IOMMU domain to an IOMMU group
  * @domain: IOMMU domain to attach
@@ -3535,6 +3565,7 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_NS_GPL(iommu_attach_group_handle, IOMMUFD_INTERNAL);
 
+
 /**
  * iommu_detach_group_handle - Detach an IOMMU domain from an IOMMU group
  * @domain: IOMMU domain to attach
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index a643d5c7c535..ea7f1bf64892 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -178,6 +178,25 @@ static int __fault_domain_replace_dev(struct iommufd_device *idev,
 	return ret;
 }
 
+static int iommufd_init_pasid_array(struct iommu_domain *domain,
+				  struct iommufd_device *idev)
+{
+	int ret;
+	struct iommufd_attach_handle *handle;
+	struct iommu_group *group = idev->igroup->group;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+	handle->idev = idev;
+
+	ret = iommu_init_pasid_array(domain, group, &handle->handle);
+	if (ret)
+		kfree(handle);
+
+	return ret;
+}
+
 int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 				     struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_hw_pagetable *old)
@@ -190,6 +209,9 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 		ret = iommufd_fault_iopf_enable(idev);
 		if (ret)
 			return ret;
+
+		if (iommufd_init_pasid_array(hwpt->domain, idev))
+			return -EINVAL;
 	}
 
 	ret = __fault_domain_replace_dev(idev, hwpt, old);

-- 
2.45.2

