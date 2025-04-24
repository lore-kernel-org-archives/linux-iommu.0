Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D76284681
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516498; cv=none; b=WuP3JHtAMVyceTOIXsGpT9H8ABJxGkhk7W1mjM95ATwmFWxKpDTtLPgrxUFjH3vBN/aQv5wXNSg6V8IMS/V3WQpNQLCuzGRWCZoMDlQsxUM2txDm7uHX7wXRZyV0V+HoTTIAJ7J7V2YaE/RpEZnZV82MejTR8PIN+1PHpP03pyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516498; c=relaxed/simple;
	bh=fXCjcwkEtcDQ7QCB1IGaY0tTIBvn8gLp0aN7PhKhDnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KTc0zR7eZYcnCTdRwZ6aC99JcpD84CifFA5GGF+0iBLxk2inw6pLwW+OmFLRzR35m58B06Zya6EN9oMYflI1UpykpgJ8eqwH4yQpWASNA3zDj++mJKG5gJm1NeOxmkhJ4LpxO0FmWiiILlZWxCuGSY0o8nLHdVTt0Yk248sjS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22FE61063;
	Thu, 24 Apr 2025 10:41:30 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C4253F5A1;
	Thu, 24 Apr 2025 10:41:34 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] iommu: Handle yet another race around registration
Date: Thu, 24 Apr 2025 18:41:28 +0100
Message-Id: <88d54c1b48fed8279aa47d30f3d75173685bb26a.1745516488.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Next up on our list of race windows to close is another one during
iommu_device_register() - it's now OK again for multiple instances to
run their bus_iommu_probe() in parallel, but an iommu_probe_device() can
still also race against a running bus_iommu_probe(). As Johan has
managed to prove, this has now become a lot more visible on DT platforms
wth driver_async_probe where a client driver is attempting to probe in
parallel with its IOMMU driver - although commit b46064a18810 ("iommu:
Handle race with default domain setup") resolves this from the client
driver's point of view, this isn't before of_iommu_configure() has had
the chance to attempt to "replay" a probe that the bus walk hasn't even
tried yet, and so still cause the out-of-order group allocation
behaviour that we're trying to clean up (and now warning about).

The most reliable thing to do here is to explicitly keep track of the
"iommu_device_register() is still running" state, so we can then
special-case the ops lookup for the replay path (based on dev->iommu
again) to let that think it's still waiting for the IOMMU driver to
appear at all. This still leaves the longstanding theoretical case of
iommu_bus_notifier() being triggered during bus_iommu_probe(), but it's
not so simple to defer a notifier, and nobody's ever reported that being
a visible issue, so let's quietly kick that can down the road for now...

Reported-by: Johan Hovold <johan@kernel.org>
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 26 ++++++++++++++++++--------
 include/linux/iommu.h |  2 ++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 264383b507bc..2605dab818a0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -277,6 +277,8 @@ int iommu_device_register(struct iommu_device *iommu,
 		err = bus_iommu_probe(iommu_buses[i]);
 	if (err)
 		iommu_device_unregister(iommu);
+	else
+		WRITE_ONCE(iommu->ready, true);
 	return err;
 }
 EXPORT_SYMBOL_GPL(iommu_device_register);
@@ -2832,31 +2834,39 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode)
+static const struct iommu_device *iommu_from_fwnode(const struct fwnode_handle *fwnode)
 {
-	const struct iommu_ops *ops = NULL;
-	struct iommu_device *iommu;
+	const struct iommu_device *iommu, *ret = NULL;
 
 	spin_lock(&iommu_device_lock);
 	list_for_each_entry(iommu, &iommu_device_list, list)
 		if (iommu->fwnode == fwnode) {
-			ops = iommu->ops;
+			ret = iommu;
 			break;
 		}
 	spin_unlock(&iommu_device_lock);
-	return ops;
+	return ret;
+}
+
+const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode)
+{
+	const struct iommu_device *iommu = iommu_from_fwnode(fwnode);
+
+	return iommu ? iommu->ops : NULL;
 }
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 {
-	const struct iommu_ops *ops = iommu_ops_from_fwnode(iommu_fwnode);
+	const struct iommu_device *iommu = iommu_from_fwnode(iommu_fwnode);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!ops)
+	if (!iommu)
 		return driver_deferred_probe_check_state(dev);
+	if (!dev->iommu && !READ_ONCE(iommu->ready))
+		return -EPROBE_DEFER;
 
 	if (fwspec)
-		return ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
+		return iommu->ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
 
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ccce8a751e2a..cbb1520005c3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -750,6 +750,7 @@ struct iommu_domain_ops {
  * @dev: struct device for sysfs handling
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
+ * @ready: set once iommu_device_register() has completed successfully
  */
 struct iommu_device {
 	struct list_head list;
@@ -758,6 +759,7 @@ struct iommu_device {
 	struct device *dev;
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
+	bool ready;
 };
 
 /**
-- 
2.39.2.101.g768bb238c484.dirty

