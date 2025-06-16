Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3ABA42
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105963; cv=none; b=hTuLOuNUJlERTwNHx5ImtbXVBQpwINeV49ubp1xK14pw3Xh9o/wUYETBmmLeBpcs1u+HJzuUJfg1A9cGubU4lG5YBA4sfhWYkHIti7HLwfuhfD23ryQ5NxvNNilQWGLjnsIOKNnzz9I2jNp9KALu5ZoUXUQMcRGmu8/Eh3Ujrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105963; c=relaxed/simple;
	bh=UPkjGjE2CZ9KN+r5I5XSzBk2ZdmBz32TTgYE4B93myU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CrJy9O0Sr/WbJUvKwVMtbj4QFwubCHtdh7MsG3luW/5FTCc4HZrigdk1nJ/mrX+n2nUIewVNwWDlikNIcsaGusjF2IJ1lJ1JlrDGYiFo6mlEnD/WWqEAcj6tZLuQXn/TwUQ/1WHclY92I7/gzeer1ZAr/8k4YKQB2ARy0UDIZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vijckf6Z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vijckf6Z"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7462aff55bfso3684837b3a.2
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750105961; x=1750710761; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gbf5LmaTy9+rHIJ6intAp3ynX0PVAE0acrvy2apYxsg=;
        b=Vijckf6Z3kQ+LlVHn/58sTP+4GnXmEmBbYGk9CyU/wncrI3qi+6bAdLBhr6Z3TuE5i
         PvNSbBWvCMMU2Q3kx3Q/k7A+RcKX4oA9lID3uDG1nrUNWZ7BjNycCVAERCXGH1YVFiJr
         lUtXMAeCf0laHGXuGYlLEn3myf5FYA3ycIFo8rkDEwsfMSErLeeWNRnh/9VUM2kZSxpn
         TOM8jUw8BSNMksh2t+eqtO2dQPouYPLJ33lqsw/m+lyCkaIobWfpRXax74VmN8h1MBbl
         KuGNrhELVifQDZ5V8/KKcPuTGf9/joT1jr9KACJR9TOmUTJFMdBixQF6l+IY5urRwoWS
         FnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105961; x=1750710761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gbf5LmaTy9+rHIJ6intAp3ynX0PVAE0acrvy2apYxsg=;
        b=s4Dhd8yM6rhvV7WjUh0YFgk7zZsCYv+7hil3xeiFGLvlhJQMwuVlQUUnq+kqQeN+p3
         5Q0FzV8qmhAUVi7zX8XZD+VDdGxFM+XD2EF8LHZev0fUGnnsRgAARj3zQKc3/cn6TlYG
         TmjVAFC0DEjb7pTmdrrUypbXJHAu9gG0BkJQEh6tr2TpoYnCkQsffqPPAG2ApHj2vjiU
         53R+JC2DbE1VHAgAwVS21CSJ7uQ1ivIHnu55u1afNfboytUnrJkWlZtLmTWJs770LgKR
         VOB3hv/KeTw3kkUCxEiQbdsQmE5NQs4gdIMutDVJumEx2hqhdv2jdxMjtsJ4jFB2NtXL
         38ag==
X-Forwarded-Encrypted: i=1; AJvYcCVcQRNaq4mUKvBJJ6mRZuwukl8xD6gcY02dtRBvKAnO124O8WYI45J1/b8ly6rhDRSlITPVGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4J+wa7JN8OKhX4tPEUd8nse2pWv+ex23gktBAAt1p1hfpJ9Vd
	RZxJfCqdO+HEnQ6CrGw/sTioSHnULb95Mv61qZ94HSfBTF7Q1oqSKCpJ04BHre9TobyYqEC0Ws9
	TZA==
X-Google-Smtp-Source: AGHT+IFwHHwwcoA3enp5TJdcNml8d4CukTTuNq5Mpo1oZFzjcrCRpu+Di5vpX78aiFybWBHun4Sc7Id4rA==
X-Received: from pfjd18.prod.google.com ([2002:a05:6a00:2452:b0:747:af58:72ca])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:806:b0:740:9d7c:aeb9
 with SMTP id d2e1a72fcca58-7489cfdce76mr16246006b3a.21.1750105961567; Mon, 16
 Jun 2025 13:32:41 -0700 (PDT)
Date: Mon, 16 Jun 2025 20:31:46 +0000
In-Reply-To: <20250616203149.2649118-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250616203149.2649118-6-praan@google.com>
Subject: [RFC PATCH v3 5/8] pm: runtime: Introduce pm_runtime_get_if_not_suspended()
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The existing opportunistic helpers like pm_runtime_get_if_active() and
pm_runtime_get_if_in_use(), are too strict for certain use cases. They
fail if the device is in a transient state like RPM_SUSPENDING, which
can lead to drivers making incorrect assumptions about the dev's state.

These helpers don't suffice for cases where one wishes to elide HW clean
up like queue flushes or TLB invalidations if the device is powered off.
It is wasteful to wake up the device in cases where the resume callback
resets the device well OR if the HW resets in a clean state. Thus, if a
device is powered off, it is preferred to elide any clean-up HW ops like
queue flushes / TLB invalidations when the device will resume afresh.

Consider the following sequence of operations:

1. The device is in `RPM_SUSPENDING` state
2. The driver calls pm_runtime_get_if_active/in_use
3. Depending on these API, the driver elides a HW clean-up op like:

if (pm_runtime_get_if_in_active(dev))
	invalidate_tlb(dev);
else
	// Skip flush, assuming device will fully suspend

4. Now, another rpm dev-linked device wakes up, causing the device's
   state to bounce from RPM_SUSPENDING to RPM_ACTIVE without invoking
   any rpm callbacks, preventing them from resetting the dev correctly.

5. The device continues to be active with an invalid HW state (e.g.
   stale TLB entries, unflushed packets/commands etc.)

Introduce a new helper function, pm_runtime_get_if_not_suspended(),
to address the problem. The pm_runtime_get_if_not_suspended() increments
the device's runtime PM reference only if it's rpm state is NOT
RPM_SUSPENDED and it cancels any pending autosuspend timers.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/base/power/runtime.c | 41 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |  5 +++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0e127b0329c0..f1c81b6723cc 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1260,6 +1260,47 @@ int pm_runtime_get_if_in_use(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_use);
 
+/**
+ * pm_runtime_get_if_not_suspended - Conditionally bump up runtime PM usage count.
+ * @dev: Target device.
+ *
+ * Increment the runtime PM usage counter of @dev if its runtime PM status is NOT
+ * %RPM_SUSPENDED, in which case it returns 1. If the device state is %RPM_SUSPENDED
+ * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device, in
+ * which case also the usage_count will remain unmodified.
+ *
+ * NOTE: This also cancels any pending autosuspend request.
+ */
+int pm_runtime_get_if_not_suspended(struct device *dev)
+{
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	if (dev->power.disable_depth > 0) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	if (dev->power.runtime_status == RPM_SUSPENDED) {
+		retval = 0;
+		goto out;
+	}
+
+	/* Cancel the auto-suspend timer */
+	pm_runtime_cancel_pending(dev);
+	atomic_inc(&dev->power.usage_count);
+	__update_runtime_status(dev, RPM_ACTIVE);
+	retval = 1;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	return retval;
+out:
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+	return retval;
+}
+EXPORT_SYMBOL_GPL(pm_runtime_get_if_not_suspended);
+
 /**
  * __pm_runtime_set_status - Set runtime PM status of a device.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 7fb5a459847e..d07bca2b6a83 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -75,6 +75,7 @@ extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
 extern int __pm_runtime_resume(struct device *dev, int rpmflags);
 extern int pm_runtime_get_if_active(struct device *dev);
 extern int pm_runtime_get_if_in_use(struct device *dev);
+extern int pm_runtime_get_if_not_suspended(struct device *dev);
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
@@ -283,6 +284,10 @@ static inline int pm_runtime_get_if_active(struct device *dev)
 {
 	return -EINVAL;
 }
+static int pm_runtime_get_if_not_suspended(struct device *dev)
+{
+	return -EINVAL;
+}
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
 static inline int pm_runtime_barrier(struct device *dev) { return 0; }
-- 
2.50.0.rc2.692.g299adb8693-goog

