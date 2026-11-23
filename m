Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409407;
	b=oLRczdiYUN/YQqgmeBhZeksDOrkGqqtCZoO4iDmN9n4tbKnG/UdiuoouojO5EoOSETL5
	 yFMW1UfVxHW3wQ0t7JgDMzsKX4KwQ/VfEqxEpWy4W8Ke97CfjDHQ3JFynZfSbquRez6aD
	 fS/z0hZHDVPG9/WgMoQFfnG+tNl0AMc6QaZQ9MJX0XSfgua2SXlUGC1ssaMd078coRMvC
	 xZFO17VFEpe8z4B0t8rlxzR1CxDiDF/R0EeO1vxo+RQOty4DhqLa/J+3Ng0WAOjJeyZTm
	 MncGcooTUptEDNaCnuKH1dMfbim/ztaOzchyEG3kTwXrddt8fl8rrml4mASwfNr1rqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=TZMq+/zpLeRacFwEoqnJChMXkGO66CqIjVvdz5YYwDY=;
	b=fEbhmplGjsPowCdmMBlcvKuh/gPHje+AUCORUMEA3dPdP6Mf2gFTH+Qeho4VOp7yS9I+
	 v6p7wwa5JRbEtAoNTtVJZkAL37E3VkVZQ5SicdUzyg5DN30Cdjbi8d9GTKcoGtZXjHrdy
	 i5gV1EvNXlyBxFdg9kmhuKLJX96v3J5Dxraj0jCAmZ8sr0hRFDZ7lZn4HgDmhbc+wZhYX
	 WXp2r5xe2W/NcS+KFaqdnXlSo0MwaMDzwRDDTb4f8opPrMnSVsmY8ccTgwDrTRBR+wtmn
	 4z5qOKp/wKSNQ/WfXYDBAZg3Li8S4vH/rrAIO4PVO3jzhFdQ2BRxNnuCoqeZ+E+WnQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cgHUgKhZ;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADC606A693
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26ADC606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cgHUgKhZ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b191f8a9b3so3878214a91.1
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409406; x=1796014206; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZMq+/zpLeRacFwEoqnJChMXkGO66CqIjVvdz5YYwDY=;
        b=cgHUgKhZ62NiXI0piVNQDzSqL1Zp1RE57XvcT3ybNGOVZ6fl9KiV8jbRWJBayjYEOa
         DXrMgH5b1JGpkP4d/Lf1pW0dzgSEldmann41KE6VeSAcE1XFIpEB7qBtlOHTXmERjrNB
         50inhTWciw72/kA1R+x2zWZqWDb6bMv4FjEIuKZ+2EWOPAtJWgQn0h3SxNd8LaAUDlTV
         X0kk1CtY9I5EjnINyTG7FloSXGBn2WZHQgqZglnFzXWdjxZWlIIDXk/F5gA5W6YSpvWX
         D5XfyoIB7U48KCCADELqEXJ3RFHQxgqAHKFSG/5OGRQ3JMiAXC4mdH5tbZ9RMMNACzfT
         8bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409406; x=1796014206;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZMq+/zpLeRacFwEoqnJChMXkGO66CqIjVvdz5YYwDY=;
        b=hAC3PVgOBav92JPXksJchpyRmT0u362cG3/aBSGenTMHtJzzGDyiz6FQeJ9+9uLydh
         1jV8CrgOXFg6QZS9CU2DavOK716BRo9D6CI7462Mx6odiibM25+JwYe9geMSGkgmzl/W
         VZqdL8puWYusOkO9WBnETp+g6dpTdOvvDa4nEjqsWMF9TTs/8PzY7OLCtDRp/DcD/dQN
         En1N2Ua71VKL7cgeNCiqBBK+a58FZzGnNMjHAj1VdhdF5tl/io5HgOFNV2zaORpDDR+M
         KmSBNeuxyBQZqSeLtgpUij73Vb5GA03/TPOI1cn8soQHccymmg+b2erq5u5Ssv5YVwge
         XW5g==
X-Forwarded-Encrypted: i=1; AL+hErG9pwXNekJJtd7pLNVWUEvPwJwomu8pUpjJoEmQCn3x39ZYMxFa6gxLz6cc+VsyZQlXk9LMDg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+tc6uXMG4vPSlq94R+sJazahhLKLCyQUZ2RWonGH13MA3+fcaS
	22X3V3EqG7i+lEup2hjPAZlYZlxMrAnWB4J2wHpqNBcqr1B910mkpxhfx/pUZPNs7lwhH8SJ2ke
	c5VmPiR5V5a2bAg==
X-Received: from pjbct21.prod.google.com ([2002:a17:90a:f595:b0:3a5:f1d:43a6])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d89:b0:3b4:3c33:3e5d with SMTP id 98e67ed59e1d1-3b43c334caemr4000575a91.67.1795409406304;
 Sun, 22 Nov 2026 20:50:06 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:49 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-19-skhawaja@google.com>
Subject: [PATCH v8 18/18] iommufd/selftest: Add test to verify iommufd preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Test iommufd preservation by setting up an iommufd with a HWPT and
preserving it across live update. The test takes the VFIO cdev path of a
device bound to the vfio-pci driver, binds it to the iommufd and attaches
it to the HWPT that is marked for preservation. It also checks that the
iommufd can't be preserved without its memfd or with hole-punched pages.

Add IOMMU_TEST_OP_LIVEUPDATE_PRESERVE_DEV to preserve the device, since
the vfio cdev preservation is not available yet.

On restore, the test verifies that the restored device can't be bound to
a new iommufd, that the iommufd can't be retrieved, as the iommufd
restore is not supported yet, and that the LUO session finish fails.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 drivers/iommu/iommufd/device.c                |  47 ++-
 drivers/iommu/iommufd/iommufd_private.h       |   1 +
 drivers/iommu/iommufd/iommufd_test.h          |   1 +
 drivers/iommu/iommufd/selftest.c              |  29 ++
 tools/testing/selftests/iommu/Makefile        |  21 ++
 .../iommu/iommufd_liveupdate_kexec_test.c     | 276 ++++++++++++++++++
 6 files changed, 359 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ebfc96445f71..95e31d398b84 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1774,17 +1774,8 @@ static bool _iommufd_device_has_pasid_attachments(struct iommufd_device *idev)
 	return false;
 }
 
-/**
- * iommufd_device_preserve() - Preserve an iommufd device across live update
- * @s: Live update session
- * @idev: Target iommufd device
- * @iommufd_tokenp: Pointer to store outgoing iommufd token
- *
- * Return: 0 on success, or negative error code.
- */
-int iommufd_device_preserve(struct liveupdate_session *s,
-			    struct iommufd_device *idev,
-			    u64 *iommufd_tokenp)
+/* Preserve @idev using @token as its DMA owner token. */
+int __iommufd_device_preserve(struct iommufd_device *idev, u64 token)
 {
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
@@ -1828,10 +1819,6 @@ int iommufd_device_preserve(struct liveupdate_session *s,
 	}
 
 	hwpt_paging = to_hwpt_paging(hwpt);
-	ret = liveupdate_get_token_outgoing(s, idev->ictx->file, iommufd_tokenp);
-	if (ret)
-		goto out;
-
 	if (!hwpt_paging->liveupdate_preserved) {
 		ret = -EINVAL;
 		goto out;
@@ -1839,7 +1826,7 @@ int iommufd_device_preserve(struct liveupdate_session *s,
 
 	ret = iommu_preserve_device(hwpt_paging->common.domain,
 				    idev->dev,
-				    *iommufd_tokenp);
+				    token);
 
 	if (!ret)
 		idev->liveupdate_preserved = true;
@@ -1847,6 +1834,34 @@ int iommufd_device_preserve(struct liveupdate_session *s,
 	mutex_unlock(&igroup->lock);
 	return ret;
 }
+
+/**
+ * iommufd_device_preserve() - Preserve an iommufd device across live update
+ * @s: Live update session
+ * @idev: Target iommufd device
+ * @iommufd_tokenp: Pointer to store outgoing iommufd token
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommufd_device_preserve(struct liveupdate_session *s,
+			    struct iommufd_device *idev,
+			    u64 *iommufd_tokenp)
+{
+	int ret;
+
+	if (!idev)
+		return -EINVAL;
+
+	/*
+	 * The iommufd must be preserved in the same session, which also makes
+	 * sure its HWPT preservation is done before the device is preserved.
+	 */
+	ret = liveupdate_get_token_outgoing(s, idev->ictx->file, iommufd_tokenp);
+	if (ret)
+		return ret;
+
+	return __iommufd_device_preserve(idev, *iommufd_tokenp);
+}
 EXPORT_SYMBOL_NS_GPL(iommufd_device_preserve, "IOMMUFD");
 
 /**
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index df231d1e7d09..b342ee5b8ed3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -749,6 +749,7 @@ int iommufd_liveupdate_register(void);
 void iommufd_liveupdate_unregister(void);
 
 int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd);
+int __iommufd_device_preserve(struct iommufd_device *idev, u64 token);
 #else
 static inline int iommufd_liveupdate_register(void)
 {
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 52b78cbcc920..2f68abe52bfe 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -31,6 +31,7 @@ enum {
 	IOMMU_TEST_OP_PASID_CHECK_HWPT,
 	IOMMU_TEST_OP_DMABUF_GET,
 	IOMMU_TEST_OP_DMABUF_REVOKE,
+	IOMMU_TEST_OP_LIVEUPDATE_PRESERVE_DEV,
 };
 
 enum {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 037e54f3d2ba..d904482124e1 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -2115,6 +2115,33 @@ static int iommufd_test_dmabuf_revoke(struct iommufd_ucmd *ucmd, int fd,
 	return rc;
 }
 
+/*
+ * Preserve the IOMMU state of a device bound to this iommufd, as a vfio cdev
+ * preserved in the same live update session would. The iommufd must already
+ * be preserved, so the HWPT of the device is preserved.
+ */
+static int iommufd_test_liveupdate_preserve_dev(struct iommufd_ucmd *ucmd,
+						u32 dev_id)
+{
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommufd_device *idev;
+	int rc;
+
+	idev = iommufd_get_device(ucmd, dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	mutex_lock(&ucmd->ictx->liveupdate_mutex);
+	rc = __iommufd_device_preserve(idev, 0);
+	mutex_unlock(&ucmd->ictx->liveupdate_mutex);
+
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 int iommufd_test(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_test_cmd *cmd = ucmd->cmd;
@@ -2200,6 +2227,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_dmabuf_revoke(ucmd,
 						  cmd->dmabuf_revoke.dmabuf_fd,
 						  cmd->dmabuf_revoke.revoked);
+	case IOMMU_TEST_OP_LIVEUPDATE_PRESERVE_DEV:
+		return iommufd_test_liveupdate_preserve_dev(ucmd, cmd->id);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 84abeb2f0949..89be2ff830c6 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -7,4 +7,25 @@ TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
 
+TEST_GEN_PROGS_EXTENDED += iommufd_liveupdate_kexec_test
+
 include ../lib.mk
+include ../liveupdate/lib/libliveupdate.mk
+
+CFLAGS += -I$(top_srcdir)/tools/include
+CFLAGS += -MD
+CFLAGS += $(EXTRA_CFLAGS)
+
+TEST_O := $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+$(TEST_O): $(OUTPUT)/%.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(LIBLIVEUPDATE_O) $(TEST_O))
+-include $(TEST_DEP_FILES)
+
+$(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBLIVEUPDATE_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -o $@
+
+EXTRA_CLEAN += $(TEST_O)
+EXTRA_CLEAN += $(TEST_DEP_FILES)
+EXTRA_CLEAN += $(patsubst %, %.d, $(TEST_GEN_PROGS))
diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c b/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c
new file mode 100644
index 000000000000..3202272ec27c
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <limits.h>
+
+#define __EXPORTED_HEADERS__
+#include <linux/iommufd.h>
+#include <linux/types.h>
+#include <linux/vfio.h>
+#include <linux/sizes.h>
+#include <libliveupdate.h>
+
+#include "../kselftest.h"
+#include "../../../../drivers/iommu/iommufd/iommufd_test.h"
+
+#define ksft_assert(condition) \
+	do { \
+		if (!(condition)) \
+			fail_exit("Failed: %s", #condition); \
+	} while (0)
+
+static const char *device_cdev_path;
+static const char state_session[] = "state-iommufd-cdev";
+static const char iommufd_session[] = "iommufd-test-cdev";
+
+static const uint64_t STATE_TOKEN;
+static const uint64_t IOMMUFD_TOKEN = 0x123456;
+static const uint64_t HWPT_TOKEN = 0x789012;
+static const uint64_t MEMFD_TOKEN = 0x890123;
+
+static int open_cdev(const char *vfio_cdev_path)
+{
+	int cdev_fd;
+
+	cdev_fd = open(vfio_cdev_path, O_RDWR);
+	if (cdev_fd < 0)
+		ksft_exit_skip("Failed to open VFIO cdev: %s\n", vfio_cdev_path);
+
+	return cdev_fd;
+}
+
+static int open_iommufd(void)
+{
+	int iommufd;
+
+	iommufd = open("/dev/iommu", O_RDWR);
+	if (iommufd < 0)
+		ksft_exit_skip("Failed to open /dev/iommu. IOMMUFD support not enabled.\n");
+
+	return iommufd;
+}
+
+static int create_memfd(size_t size)
+{
+	int fd, ret;
+
+	fd = memfd_create("buffer", 0);
+	if (fd < 0)
+		fail_exit("memfd_create failed");
+
+	ret = ftruncate(fd, size);
+	if (ret)
+		fail_exit("ftruncate failed");
+
+	return fd;
+}
+
+#define test_ioctl(fd, cmd, arg) \
+	do { \
+		if (ioctl(fd, cmd, arg)) \
+			fail_exit("ioctl(%s) failed", #cmd); \
+	} while (0)
+
+#define test_luo_session_preserve_fd(session, fd, token) \
+	do { \
+		if (luo_session_preserve_fd(session, fd, token)) \
+			fail_exit("luo_session_preserve_fd(%s) failed", #token); \
+	} while (0)
+
+static uint32_t setup_iommufd(int iommufd, int memfd, int cdev_fd,
+			      uint32_t *dev_id)
+{
+	struct vfio_device_bind_iommufd bind = {
+		.argsz = sizeof(bind),
+		.flags = 0,
+		.iommufd = iommufd,
+	};
+	struct iommu_ioas_alloc alloc_data = {
+		.size = sizeof(alloc_data),
+		.flags = 0,
+	};
+	struct iommu_hwpt_alloc hwpt_alloc = {
+		.size = sizeof(hwpt_alloc),
+		.flags = 0,
+	};
+	struct vfio_device_attach_iommufd_pt attach_data = {
+		.argsz = sizeof(attach_data),
+		.flags = 0,
+	};
+	struct iommu_hwpt_liveupdate_mark_preserve mark_preserve = {
+		.size = sizeof(mark_preserve),
+		.hwpt_token = HWPT_TOKEN,
+	};
+	struct iommu_ioas_map_file map_file = {
+		.size = sizeof(map_file),
+		.length = SZ_1M,
+		.flags = IOMMU_IOAS_MAP_WRITEABLE |
+				IOMMU_IOAS_MAP_READABLE |
+				IOMMU_IOAS_MAP_FIXED_IOVA,
+		.iova = SZ_4G,
+		.fd = memfd,
+		.start = 0,
+	};
+
+	test_ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+
+	test_ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
+
+	hwpt_alloc.dev_id = bind.out_devid;
+	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
+	test_ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
+
+	attach_data.pt_id = hwpt_alloc.out_hwpt_id;
+	test_ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+
+	map_file.ioas_id = alloc_data.out_ioas_id;
+	test_ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
+
+	map_file.iova = SZ_4G + SZ_1M;
+	map_file.start = SZ_1M;
+	test_ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
+
+	mark_preserve.hwpt_id = attach_data.pt_id;
+	test_ioctl(iommufd, IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE, &mark_preserve);
+
+	*dev_id = bind.out_devid;
+	return alloc_data.out_ioas_id;
+}
+
+/* Preserve the IOMMU state of the device, using the iommufd selftest support. */
+static int preserve_device(int iommufd, uint32_t dev_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_LIVEUPDATE_PRESERVE_DEV,
+		.id = dev_id,
+	};
+
+	return ioctl(iommufd, IOMMU_TEST_CMD, &cmd);
+}
+
+static void before_kexec(int luo_fd)
+{
+	struct iommu_ioas_unmap unmap = {
+		.size = sizeof(unmap),
+		.iova = SZ_4G + SZ_1M,
+		.length = SZ_1M,
+	};
+	int iommufd, cdev_fd, memfd, session;
+	uint32_t ioas_id, dev_id;
+
+	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
+
+	session = luo_create_session(luo_fd, iommufd_session);
+	if (session < 0)
+		fail_exit("luo_create_session failed");
+
+	iommufd = open_iommufd();
+	memfd = create_memfd(SZ_2M);
+	cdev_fd = open_cdev(device_cdev_path);
+
+	ioas_id = setup_iommufd(iommufd, memfd, cdev_fd, &dev_id);
+
+	/* Cannot preserve the device before its HWPT is preserved. */
+	if (!preserve_device(iommufd, dev_id))
+		fail_exit("Preserving device before iommufd should fail");
+	if (errno == ENOTTY)
+		ksft_exit_skip("IOMMUFD selftest support not enabled\n");
+
+	/* Cannot preserve iommufd without preserving memfd. */
+	if (!luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN))
+		fail_exit("Preserving iommufd without memfd should fail");
+
+	if (fallocate(memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+		      SZ_1M, SZ_1M))
+		fail_exit("fallocate punch hole failed");
+
+	test_luo_session_preserve_fd(session, memfd, MEMFD_TOKEN);
+
+	/* Cannot preserve iommufd when mapped memfd pages have a hole punched. */
+	if (!luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN))
+		fail_exit("Preserving iommufd with hole-punched pages should fail");
+
+	unmap.ioas_id = ioas_id;
+	test_ioctl(iommufd, IOMMU_IOAS_UNMAP, &unmap);
+
+	test_luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN);
+
+	if (preserve_device(iommufd, dev_id))
+		fail_exit("Preserving device failed");
+
+	if (!preserve_device(iommufd, dev_id) || errno != EBUSY)
+		fail_exit("Preserving device twice should fail with EBUSY");
+
+	/* Closing the session unpreserves the device and the iommufd. */
+	close(session);
+	session = luo_create_session(luo_fd, iommufd_session);
+	if (session < 0)
+		fail_exit("luo_create_session failed");
+
+	test_luo_session_preserve_fd(session, memfd, MEMFD_TOKEN);
+	test_luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN);
+
+	if (preserve_device(iommufd, dev_id))
+		fail_exit("Preserving device failed");
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+static void after_kexec(int luo_fd, int state_session_fd)
+{
+	struct vfio_device_bind_iommufd bind = {
+		.argsz = sizeof(bind),
+		.flags = 0,
+	};
+	int iommufd, cdev_fd, session, stage;
+
+	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
+	ksft_assert(stage == 2);
+
+	/* The restored device is owned until its iommufd is restored. */
+	cdev_fd = open_cdev(device_cdev_path);
+	bind.iommufd = open_iommufd();
+	if (!ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind) || errno != EPERM)
+		fail_exit("Binding the restored device should fail with EPERM");
+
+	session = luo_retrieve_session(luo_fd, iommufd_session);
+	if (session < 0)
+		fail_exit("luo_retrieve_session failed");
+
+	iommufd = luo_session_retrieve_fd(session, IOMMUFD_TOKEN);
+	if (iommufd >= 0)
+		fail_exit("iommufd should not be retrievable yet");
+
+	/* Should fail */
+	if (luo_session_finish(session) == 0)
+		fail_exit("luo_session_finish should fail if iommufd is not restored");
+}
+
+int main(int argc, char *argv[])
+{
+	/* Skip the stage option, luo_test() parses it again. */
+	while (getopt(argc, argv, "s:") != -1)
+		;
+
+	if (optind >= argc) {
+		printf("Usage: %s [-s <stage>] <vfio_cdev_path>\n", argv[0]);
+		return 1;
+	}
+
+	device_cdev_path = argv[optind];
+
+	return luo_test(argc, argv, state_session, before_kexec, after_kexec);
+}
-- 
2.56.1.809.ga0b61035b5-goog

