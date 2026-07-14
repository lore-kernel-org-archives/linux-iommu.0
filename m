Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0146AEF5
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034458; cv=none; b=jIGsA3F3HLGRB+3wp8ve7+XN6krlG3H5FUz0oGJFyMrXfSnhm2pSwlNGvlsBGMUNvK3GoYWmux4CYhqhp1yPdNPOqvFr98hjvog5AKEH5w4OJOSo69H+cXWvHV2ph0o67DeKGhrpv6QJPZJo1vw/8CNp60Py7qS45SElFoYeyJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034458; c=relaxed/simple;
	bh=zWI3HgS6VNdfgTHEihXvnUhJkpLl5h08ZrZ1Oj9J3pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdzpBomYOTCMs0iAkLCQCJudfiS+JRqahIKLVCh++bVfjHuEleTxh/ZAqWIO4fPJLy6I8xizh9mzb+SdULGVpB2vN/KshsRAoA+ynfuZvelKlNu6IO4VuhQcM/AS6MnoSbO1AFwHi3JVX29teuXqF+bXahBDkUY5y7MVlJEMgR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=loZFoESy; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="loZFoESy"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so699591a34.2
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784034455; x=1784639255; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PgO28qqQ1xeK9Yvst4+iTUEqQXClh8oO6Jm7DHD/RdA=;
        b=loZFoESyzDTwM5tRYV6HSPxjKyQZW4+qoAv2OAD9hXniWpUihlXwqA+PnEI3od+i0U
         /VHy94JUIpA+yfDNn3SsgQOHkE2SdgmlLukNLVw6t21N2YylxfyFdn2Y3QnBtry7EH1D
         edGvuAGLQvfySTMTSCE/NRpTh5Dqx00bpLb8QuV/jEg7phkBK2hw1B715bbEC7QQOJjR
         KhdeV7Fx20qnb+OeJ3SgKXDblUgVB9bjQAwUgdo3TujnE/5t7dzZiEWe8hIxbJ8TxxnJ
         Q0tURtNximUQQwtGJURZWaAUhdZPepHPO4DoKkIeUoV+lcDNhddNwm1RowOhs5O1dXnX
         Y4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034455; x=1784639255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PgO28qqQ1xeK9Yvst4+iTUEqQXClh8oO6Jm7DHD/RdA=;
        b=pJ0DtvRv4n4bxcWejn4TPzik4keSpAnL/BkCuY8ljmWNEPeecskY+kdlkYd2UF+Gwn
         Egf/LMG8quC4IX74Zaz1b2dFTHFt8ei/gQ25cYHTZavkajk5YVdDybtkEHr/h0kGf57b
         DG3ACUrbbQmgQWpcAz1kNyZTP0pB0K8I+OfpnVO3iStjbnkkgnvHteAAB7OO+jPIOIsM
         bx3txljO53L1ejsDbbnrUcXQ69NBCS59L6R7NKW5ATqXhiitCf332+KntMCRhJMKcf/l
         FFlq8YUXT3qZrLQrOpfxxVYr6u4vI2pLROBib7jJcn3mvhBxacaW/AIWJLQYHMEyY5jn
         RjHg==
X-Forwarded-Encrypted: i=1; AFNElJ/9boIwjgNO6Xtrk3w9VPlIToixoBg8XMf5G22qhbvAi561b3PWhZp4XeusWIz0XoSjXvmOGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyG+no7s3PnfNwkk0/iwaGiNssScS0yACxCVKD/tAz9f4Kskmsq
	AdqomeAfs0SEfxnB1WsWKHXrvbM4eDw1GkUnQ/VXJwfn1X7xTliSNGgtXcWg36LqEKc=
X-Gm-Gg: AfdE7clOocih6RdkCzH5U4uAQfs+tOFmDGAwgmwfrgRqUlKy6mVK6GycQtZvkyPu41l
	ni/oWhjK0xVUFDkSlrjprR2vYlbqy6os8K6Wq2Dci9PPC2AuEkuJEsvuH2lAHgSl1DejKPcTXsS
	HoR72bfOg1Z0Y9im/+TqOxqMNQjwKXXT60BSMrsjzUBh1Bp0bDJ3Ra7uFoJkzIdfuHNwGaABDxE
	hhVWTI4MyMQ5Oo8Eo10hgw9bu/mrpx5n1m4YzQWB42YP5RFi5rGIWmY6sjRyMt4rr34m/MZL01x
	ZTSHtAIuDKh76ZSE/SeIc/7I8upIW3mAvRZqbzANzFthDULTgFVpZPqexz8l3gIMk+ZMxKzabA2
	fldXMWZwFLX74YC79eYPTeGpQSZqboFYwuXncMHmUACcjlNbyxosIercUuUjQFaQ4J3H5reEU2/
	sJR3/AW8ifC37Z2atW21YedDIhFUfjtBPbP9Zi6wNfcC+YVPxjt6w4rMs1EmXpdw==
X-Received: by 2002:a05:6830:f88:b0:7e9:fe5f:4406 with SMTP id 46e09a7af769-7ec0997528bmr8084846a34.30.1784034455345;
        Tue, 14 Jul 2026 06:07:35 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcab8efc3sm14657738a34.0.2026.07.14.06.07.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 06:07:34 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: joro@8bytes.org,
	palmer@dabbelt.com,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	tomasz.jeznach@linux.dev
Cc: will@kernel.org,
	robin.murphy@arm.com,
	fustini@kernel.org,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	corbet@lwn.net,
	shuah@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH 2/7] iommu: Add checked group device update helper
Date: Tue, 14 Jul 2026 21:06:52 +0800
Message-ID: <20260714130657.46963-3-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some group-wide operations must validate every member before changing
any device. Separate iommu_group_for_each_dev() calls cannot provide
that guarantee because group membership may change between traversals.

Add iommu_group_update_devices() to keep the group membership mutex held
across a validation pass and a non-failing update pass. This provides
all-or-none validation without exposing IOMMU group internals to
callers.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 drivers/iommu/iommu.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 13 +++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index da269d10f6bf..9a6c4a7e7df6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1436,6 +1436,39 @@ int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 }
 EXPORT_SYMBOL_GPL(iommu_group_for_each_dev);
 
+/**
+ * iommu_group_update_devices - Check and update every device in a group
+ * @group: the group
+ * @data: caller data passed to both callbacks
+ * @check: validates whether one device can be updated
+ * @update: updates one device after every check has succeeded
+ *
+ * Keep group membership stable while first checking every device and then
+ * applying an update which cannot fail. No device is updated if a check fails.
+ */
+int iommu_group_update_devices(struct iommu_group *group, void *data,
+			       int (*check)(struct device *, void *),
+			       void (*update)(struct device *, void *))
+{
+	struct group_device *device;
+	int ret = 0;
+
+	mutex_lock(&group->mutex);
+	for_each_group_device(group, device) {
+		ret = check(device->dev, data);
+		if (ret)
+			goto unlock;
+	}
+
+	for_each_group_device(group, device)
+		update(device->dev, data);
+
+unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_group_update_devices);
+
 /**
  * iommu_group_get - Return the group for a device and increment reference
  * @dev: get the group that this device belongs to
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e771b4a92f5b..befba0683e06 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -988,6 +988,9 @@ extern int iommu_group_add_device(struct iommu_group *group,
 extern void iommu_group_remove_device(struct device *dev);
 extern int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				    int (*fn)(struct device *, void *));
+int iommu_group_update_devices(struct iommu_group *group, void *data,
+			       int (*check)(struct device *, void *),
+			       void (*update)(struct device *, void *));
 extern struct iommu_group *iommu_group_get(struct device *dev);
 struct iommu_group *iommu_group_get_by_id(int id);
 void iommu_group_put_by_id(struct iommu_group *group);
@@ -1399,6 +1402,16 @@ static inline int iommu_group_for_each_dev(struct iommu_group *group,
 	return -ENODEV;
 }
 
+static inline int iommu_group_update_devices(struct iommu_group *group,
+					     void *data,
+					     int (*check)(struct device *,
+							  void *),
+					     void (*update)(struct device *,
+							    void *))
+{
+	return -ENODEV;
+}
+
 static inline struct iommu_group *iommu_group_get(struct device *dev)
 {
 	return NULL;
-- 
2.50.1 (Apple Git-155)

