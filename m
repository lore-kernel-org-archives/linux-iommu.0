Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D39477999
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034494; cv=none; b=mC1arvx/Wex0SWtotBr3Ccd6xObJEHUsCIjYTRtSMF2mGoFltlKWktSma1ru2pxXDVgqOSfH63ZBhDAWl/6qG6ELT/bNupjfFT84poVBW8ug6Yf9Q6qZ5MUU7GhXTUAs1jsWJj1zyJZFD1qzhCcKEzZMrhoLBs7TQTyPRv5QObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034494; c=relaxed/simple;
	bh=8nc2OVUHCKRxT0Ws6HOAWmw/VzTaZ0aIVfDSOxFg04M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPvTOW3Le9AfIB/DblHhuNT82BBk6aZBktRJIFXNEwLMaWM7du1PLpc2PztcmPipxnA6LvRFJJ0EyDSvBHGsxTwrZVUFcX2xR/rA2S6nPmmjBjQKi+45FJq1AFhVm5KfezVptUOvxBA2JZK8XV6VhZtwnJTNC2sTh56U/6BR3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DyoKW8+Q; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DyoKW8+Q"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso458767a34.1
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784034491; x=1784639291; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tyPwfho2+gt5VglzPQUkATM5bIbB7AhJfPglM91knA4=;
        b=DyoKW8+QI2fM4uTgazdhvOEvfcwZESADgafpkwx+lK23GwJjr/4h9rWv3sfn087K3b
         QRG6bq8cL0wqsa6c5Dzhw6X6uweVKvxEsNpQ9bBH1m10L2ZLbsBGmSNuUI3G7cG6bJCP
         FK81Bgxc+CkdRVd4U07KyOoehn7kJJkv7uUakYPx/ZA0RKwcS/nxKN7AF44Nhmys+xF+
         fmHgttmrzhTOlHriEm7g2kYK1ZNxTZ/sadOtRpbxPUmIlzqcBMmuFYMb4TjCipjCumOZ
         bGLOkIio0yfoKUP4qqu7dsbEonmmSk6e8FK4hfeugy+dyY1xg9gMcdBkuE+GN6dK3yUV
         2zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034491; x=1784639291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tyPwfho2+gt5VglzPQUkATM5bIbB7AhJfPglM91knA4=;
        b=ZlqXFM8rL4+DUmPR0FIV3Dg3/IEoOyJ5yH7H2jMGXQhiQVFkEPATnCYSqXTYLyUSZ4
         REYC2mXelgT6XYeYWuwX/a2khcO38YrJtI3Q1xiwD8WNJSQGfpMfQ5UDj8q1bSNRdDfQ
         QMLrSd4nPDLDp2c7viIWRGTSaL+UHLpOWoFF5RR5Hj8iVIRgu7luoYb8hmaK5vcThzRE
         /ceA1iAa43onsUngvUrpkB9URNbGIHakaQNM/VAo6aPPp2VTUmtcgB+oBGdtncqUEEHH
         knMNBW+w7dZ5y9rwKAfadcY2/SLOPBtU/5haQtKi5kMRdT6GXOK4pljGwOuDcub21m7h
         3kvg==
X-Forwarded-Encrypted: i=1; AFNElJ85i2Faumwg/nN8eHFvJyIHxyhbCbucf8ADaoIpzybg15EoiaU1B/e62qbxCohfUVwoKQCeLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywok2KSuKJ9NEqwd2iHeOTA2ccxoy4mgMQAL1OZ0/69wvCc94Ba
	Rz0TKdJAzN7KQSWkahpx1iQ2RKDiIxj+Di27j9X/J4kNtjXtutWwfSpJrMABH95US/E=
X-Gm-Gg: AfdE7cmGg5DeUmYK5oaAm9bfZUU2VyMmy+Ns2sB9MGkqtlhfL0iZwLHXSbAVCPF/LIO
	ocCvPU40d9iahY+IGuQmfTqpdZJElBMh5vrZ/Bkxz1eQjQZz3kTSJ4pMjJ7s+UeJHH38puwErQP
	ltOClInnPADXv7ciZ4Iht/eS1du2wJttTULFdDngbM9ao50bkJC1kSlOgVkrjRRNk/c3PoDadE4
	YWKLLybi4vZ0DVmEApaVQZdiJE7EatNyWH3mVICY2EGooUlGG8U40hCehTx2a0eCL662C/kqtLL
	BIJuc9LSYnW6jroEzwPE4j/WM90ALm/pG1GT+o2Akg5pEwHgO+VsxcRW9k6yBE+uIXveqRMiebV
	aerqN1WQRRDqE9XHreBeP/w31mijI5N7gk4E4FMeQAspqF1KyWEYhSZ3dzUjk9gijyvhguubipj
	lLqJww45bhW8TReJxfwTWyYsdT/J+wEWYhdAHRBqIkvb/tD+9KNO9q4II++eG+5g==
X-Received: by 2002:a05:6830:82ad:b0:7eb:3af8:8c1a with SMTP id 46e09a7af769-7ec096ecdc5mr8483705a34.9.1784034490998;
        Tue, 14 Jul 2026 06:08:10 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcab8efc3sm14657738a34.0.2026.07.14.06.07.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 06:08:10 -0700 (PDT)
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
Subject: [RFC PATCH 5/7] iommu/riscv: Expose global QoS IDs in sysfs
Date: Tue, 14 Jul 2026 21:06:55 +0800
Message-ID: <20260714130657.46963-6-zhangzhanpeng.jasper@bytedance.com>
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

The RISC-V IOMMU QoS extension provides iommu_qosid as a per-IOMMU
global default tag. It is used for IOMMU-originated DDT, CQ, FQ, PQ, and
MSI accesses, and for device-originated requests when DDTP is in BARE
mode.

Initialize iommu_qosid to RCID 0 and MCID 0 when the hardware advertises
QOSID support. Preserve reserved and WPRI bits with read-modify-write,
and use register readback to reject values which the WARL fields do not
retain.

Add a qosid attribute to the RISC-V IOMMU class device. Reading returns
the current RCID and MCID values. Writing the documented
'rcid=<rcid> mcid=<mcid>' form updates both fields while preserving the
other register bits.

Keep this interface separate from resctrl group QoS. The sysfs attribute
controls the IOMMU-wide default, while resctrl device assignment programs
per-device DC.ta in translated modes.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 .../ABI/testing/sysfs-class-iommu-riscv-iommu |  27 +++
 MAINTAINERS                                   |  10 ++
 drivers/iommu/riscv/iommu.c                   | 159 +++++++++++++++++-
 drivers/iommu/riscv/iommu.h                   |   9 +-
 4 files changed, 202 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu

diff --git a/Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu b/Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
new file mode 100644
index 000000000000..b0cd68997f17
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
@@ -0,0 +1,27 @@
+What:		/sys/class/iommu/<iommu>/qosid
+Date:		June 2026
+KernelVersion:	6.18
+Contact:	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
+Description:
+		The RISC-V IOMMU global default QoS IDs for this IOMMU.
+		The file is present only when the IOMMU reports the QOSID
+		capability.
+
+		Reading the file returns the RCID and MCID fields from the
+		iommu_qosid register:
+
+		  rcid=<rcid> mcid=<mcid>
+
+		Writing the file updates the RCID and MCID fields while
+		preserving reserved/WPRI bits:
+
+		  rcid=<rcid> mcid=<mcid>
+
+		Writes fail with ERANGE when either value cannot be represented
+		by the IOMMU. A successful write is verified by reading the WARL
+		fields back from the register.
+
+		The iommu_qosid register is a per-IOMMU global default. It
+		tags IOMMU-originated DDT, CQ, FQ, PQ and MSI accesses, and
+		in BARE mode device-originated requests. It does not assign
+		per-device or per-IOMMU-group QoS IDs in translated modes.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0b5d38b772e0..c59be02c8f02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23279,6 +23279,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 F:	drivers/iommu/riscv/
 
+RISC-V IOMMU QoS
+M:	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
+R:	Tomasz Jeznach <tomasz.jeznach@linux.dev>
+R:	Drew Fustini <fustini@kernel.org>
+R:	yunhui cui <cuiyunhui@bytedance.com>
+L:	iommu@lists.linux.dev
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
+
 RISC-V MICROCHIP SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index deab646bb1ea..e85da9eef58e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1658,6 +1658,7 @@ int riscv_iommu_group_set_qosid(struct iommu_group *group, u32 rcid, u32 mcid)
 	};
 	int ret;
 
+	/* Resctrl IDs are bounded by the system's reported controller counts. */
 	if (rcid > FIELD_MAX(RISCV_IOMMU_DC_TA_RCID) ||
 	    mcid > FIELD_MAX(RISCV_IOMMU_DC_TA_MCID))
 		return -ERANGE;
@@ -1688,9 +1689,154 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.release_device	= riscv_iommu_release_device,
 };
 
+static int riscv_iommu_set_default_qosid(struct riscv_iommu_device *iommu,
+					 u32 rcid, u32 mcid)
+{
+	u32 old_qosid;
+	u32 qosid;
+	int ret = 0;
+
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_QOSID))
+		return -EOPNOTSUPP;
+
+	if (rcid > FIELD_MAX(RISCV_IOMMU_IOMMU_QOSID_RCID) ||
+	    mcid > FIELD_MAX(RISCV_IOMMU_IOMMU_QOSID_MCID))
+		return -ERANGE;
+
+	/*
+	 * iommu_qosid is a per-IOMMU global default. It tags IOMMU-originated
+	 * DDT/CQ/FQ/PQ and MSI accesses, and in BARE mode device-originated
+	 * requests. Per-device group QoS is still handled separately through
+	 * DC.ta.
+	 */
+	mutex_lock(&iommu->qosid_lock);
+	old_qosid = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IOMMU_QOSID);
+	qosid = old_qosid & ~(RISCV_IOMMU_IOMMU_QOSID_RCID |
+				RISCV_IOMMU_IOMMU_QOSID_MCID);
+	qosid |= FIELD_PREP(RISCV_IOMMU_IOMMU_QOSID_RCID, rcid) |
+		 FIELD_PREP(RISCV_IOMMU_IOMMU_QOSID_MCID, mcid);
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IOMMU_QOSID, qosid);
+
+	qosid = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IOMMU_QOSID);
+	if (FIELD_GET(RISCV_IOMMU_IOMMU_QOSID_RCID, qosid) != rcid ||
+	    FIELD_GET(RISCV_IOMMU_IOMMU_QOSID_MCID, qosid) != mcid) {
+		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IOMMU_QOSID,
+				   old_qosid);
+		ret = -ERANGE;
+	}
+	mutex_unlock(&iommu->qosid_lock);
+	if (ret)
+		return ret;
+
+	dev_dbg(iommu->dev, "set global QoS IDs rcid=%u mcid=%u\n",
+		(u32)FIELD_GET(RISCV_IOMMU_IOMMU_QOSID_RCID, qosid),
+		(u32)FIELD_GET(RISCV_IOMMU_IOMMU_QOSID_MCID, qosid));
+
+	return ret;
+}
+
+static int riscv_iommu_get_default_qosid(struct riscv_iommu_device *iommu,
+					 u32 *rcid, u32 *mcid)
+{
+	u32 qosid;
+
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_QOSID))
+		return -EOPNOTSUPP;
+
+	qosid = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IOMMU_QOSID);
+	if (rcid)
+		*rcid = FIELD_GET(RISCV_IOMMU_IOMMU_QOSID_RCID, qosid);
+	if (mcid)
+		*mcid = FIELD_GET(RISCV_IOMMU_IOMMU_QOSID_MCID, qosid);
+
+	return 0;
+}
+
+static int riscv_iommu_init_default_qosid(struct riscv_iommu_device *iommu)
+{
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_QOSID))
+		return 0;
+
+	/* Avoid probing the live WARL fields with all-ones while in BARE mode. */
+	return riscv_iommu_set_default_qosid(iommu, 0, 0);
+}
+
+static struct riscv_iommu_device *dev_to_riscv_iommu(struct device *dev)
+{
+	struct iommu_device *iommu = dev_to_iommu_device(dev);
+
+	return iommu ? container_of(iommu, struct riscv_iommu_device, iommu) : NULL;
+}
+
+static ssize_t qosid_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct riscv_iommu_device *iommu = dev_to_riscv_iommu(dev);
+	u32 rcid, mcid;
+	int ret;
+
+	if (!iommu)
+		return -ENODEV;
+
+	ret = riscv_iommu_get_default_qosid(iommu, &rcid, &mcid);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "rcid=%u mcid=%u\n", rcid, mcid);
+}
+
+static ssize_t qosid_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct riscv_iommu_device *iommu = dev_to_riscv_iommu(dev);
+	char *args, *key, *value;
+	char *input;
+	u32 rcid, mcid;
+	int ret = -EINVAL;
+
+	if (!iommu)
+		return -ENODEV;
+
+	input = kstrdup(buf, GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+
+	args = strim(input);
+	args = next_arg(args, &key, &value);
+	if (!value || strcmp(key, "rcid") || kstrtou32(value, 10, &rcid))
+		goto out;
+
+	args = next_arg(args, &key, &value);
+	if (!value || strcmp(key, "mcid") || kstrtou32(value, 10, &mcid) ||
+	    *skip_spaces(args))
+		goto out;
+
+	ret = riscv_iommu_set_default_qosid(iommu, rcid, mcid);
+out:
+	kfree(input);
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(qosid);
+
+static struct attribute *riscv_iommu_attrs[] = {
+	&dev_attr_qosid.attr,
+	NULL,
+};
+
+static const struct attribute_group riscv_iommu_group = {
+	.attrs = riscv_iommu_attrs,
+};
+
+static const struct attribute_group *riscv_iommu_groups[] = {
+	&riscv_iommu_group,
+	NULL,
+};
+
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 {
 	u64 ddtp;
+	int ret;
 
 	/*
 	 * Make sure the IOMMU is switched off or in pass-through mode during
@@ -1721,6 +1867,10 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 			return -EINVAL;
 	}
 
+	ret = riscv_iommu_init_default_qosid(iommu);
+	if (ret)
+		return ret;
+
 	/*
 	 * Distribute interrupt vectors, always use first vector for CIV.
 	 * At least one interrupt is required. Read back and verify.
@@ -1753,10 +1903,12 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
 {
+	const struct attribute_group **sysfs_groups = NULL;
 	int rc;
 
 	RISCV_IOMMU_QUEUE_INIT(&iommu->cmdq, CQ);
 	RISCV_IOMMU_QUEUE_INIT(&iommu->fltq, FQ);
+	mutex_init(&iommu->qosid_lock);
 
 	rc = riscv_iommu_init_check(iommu);
 	if (rc)
@@ -1788,8 +1940,11 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	if (rc)
 		goto err_queue_disable;
 
-	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
-				    dev_name(iommu->dev));
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_QOSID)
+		sysfs_groups = riscv_iommu_groups;
+
+	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, sysfs_groups,
+				    "riscv-iommu@%s", dev_name(iommu->dev));
 	if (rc) {
 		dev_err_probe(iommu->dev, rc, "cannot register sysfs interface\n");
 		goto err_iodir_off;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 2c57625637bf..13ea67b7e42d 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -12,8 +12,12 @@
 #define _RISCV_IOMMU_H_
 
 #include <linux/iommu.h>
-#include <linux/types.h>
 #include <linux/iopoll.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#ifdef CONFIG_RISCV_IOMMU_32BIT
+#include <linux/spinlock.h>
+#endif
 
 #include "iommu-bits.h"
 
@@ -50,6 +54,9 @@ struct riscv_iommu_device {
 	u64 caps;
 	u32 fctl;
 
+	/* Serializes QoS updates to iommu_qosid and device contexts. */
+	struct mutex qosid_lock;
+
 	/* available interrupt numbers, MSI or WSI */
 	unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
 	unsigned int irqs_count;
-- 
2.50.1 (Apple Git-155)

