Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C19C47429
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 20:16:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B795238D7
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 20:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV8LXosR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B795238D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C82E5228EA;
	Tue, 22 Sep 2020 20:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W5Kn70yg2B8V; Tue, 22 Sep 2020 20:15:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 32F9D228D5;
	Tue, 22 Sep 2020 20:15:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C08DC0889;
	Tue, 22 Sep 2020 20:15:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B7EBC0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 20:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 070C78676E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 20:15:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K6zE11TxX87D for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 20:15:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9026486770
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 20:15:36 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id x22so8679255pfo.12
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sKGrNkNTHjkBPRsVfP9DsBVB9vQeFFiSFha5UW0riiY=;
 b=PV8LXosRad6T4RYxgZNMRQszFuw2OftjACPsz9ly+3HmL/+ACHPK3Bb38Klv20gOSA
 7NwVmEZZeTSHmcWQFxJzrwpLghysDVUOzcMyOi7Xp1MFU4zl7pXKLxBAxVhaGvLayluv
 lifRJEl69A6YsZeGm6K9tQS7bDZXX6Dr9ir4bF3+XoPjA6MLIu4/YBqM/gXl9suKvaXw
 7hl7B3l+Uk3sCFtdW8ZLmrB4/yyh/Qc7pFa6/vZkkFSlwmvmkFkp/kfB2wfIf3ls9zhP
 KDLCRAq5sZiyKF1NjaCwhiiobKGvtuu9kd5+9VVlZqN1RC8jPH8I9gYCCARo7zr4gDWS
 N2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sKGrNkNTHjkBPRsVfP9DsBVB9vQeFFiSFha5UW0riiY=;
 b=NeE6onCu5xZNI5SLujv/ldpxhAbOll4Zzuw86NmC0u13Lqo2LEg2vslA06L1GdYJoW
 i3un6EnwV9fuKandZufBQQtSc1PIdBKxN6tUdIsX2MfmeTx2EtML8EBTSc8ksfV4RTE7
 dwb1FsWv1Rk/9nrY4fxF8bm/MEiSJDP+scNa2/A0q8N99R6XuEwxPUrUAgLrmlefyncP
 bKCa6cNSoby7MwSWZyiwWlwDr/PJDzRXfSXSUPwk8IwDhrEJMDx/JOsZL9twaRjv6zgU
 FhRnABmGl4lBeF6UH+kaIGb/cJVNIySPGPzX+J42f+CM/uuoqmbM8uNwL3c8gdbhN8W+
 RKlg==
X-Gm-Message-State: AOAM532P37ZarKnOCndsPXhj91CuZjTrbC33zUukZ2KEZzrZVOX04CvD
 4TZuLKucWmjg0J2TQTEFAXN6BRZw/ng=
X-Google-Smtp-Source: ABdhPJxFPpWYdP/rbDYYF9In9wTLg6tp19iNquLjJLErQuemXIs08VoOZLQpepPk/Ogiya//jKKfdQ==
X-Received: by 2002:a62:cfc4:0:b029:142:440e:231d with SMTP id
 b187-20020a62cfc40000b0290142440e231dmr5460767pfg.7.1600805735748; 
 Tue, 22 Sep 2020 13:15:35 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id e10sm15793028pgb.45.2020.09.22.13.15.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2020 13:15:35 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v10 1/7] docs: IOMMU user API
Date: Tue, 22 Sep 2020 13:16:56 -0700
Message-Id: <1600805822-1177-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Yi Sun <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IOMMU UAPI is newly introduced to support communications between guest
virtual IOMMU and host IOMMU. There has been lots of discussions on how
it should work with VFIO UAPI and userspace in general.

This document is intended to clarify the UAPI design and usage. The
mechanics of how future extensions should be achieved are also covered
in this documentation.

Cc: linux-api@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 Documentation/userspace-api/iommu.rst | 210 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 2 files changed, 211 insertions(+)
 create mode 100644 Documentation/userspace-api/iommu.rst

diff --git a/Documentation/userspace-api/iommu.rst b/Documentation/userspace-api/iommu.rst
new file mode 100644
index 000000000000..591609863cdc
--- /dev/null
+++ b/Documentation/userspace-api/iommu.rst
@@ -0,0 +1,210 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. iommu:
+
+=====================================
+IOMMU Userspace API
+=====================================
+
+IOMMU UAPI is used for virtualization cases where communications are
+needed between physical and virtual IOMMU drivers. For baremetal
+usage, the IOMMU is a system device which does not need to communicate
+with userspace directly.
+
+The primary use cases are guest Shared Virtual Address (SVA) and
+guest IO virtual address (IOVA), wherein the vIOMMU implementation
+relies on the physical IOMMU and for this reason requires interactions
+with the host driver.
+
+.. contents:: :local:
+
+Functionalities
+===============
+Communications of user and kernel involve both directions. The
+supported user-kernel APIs are as follows:
+
+1. Alloc/Free PASID
+2. Bind/Unbind guest PASID (e.g. Intel VT-d)
+3. Bind/Unbind guest PASID table (e.g. ARM SMMU)
+4. Invalidate IOMMU caches upon guest requests
+5. Report errors to the guest and serve page requests
+
+Requirements
+============
+The IOMMU UAPIs are generic and extensible to meet the following
+requirements:
+
+1. Emulated and para-virtualised vIOMMUs
+2. Multiple vendors (Intel VT-d, ARM SMMU, etc.)
+3. Extensions to the UAPI shall not break existing userspace
+
+Interfaces
+==========
+Although the data structures defined in IOMMU UAPI are self-contained,
+there are no user API functions introduced. Instead, IOMMU UAPI is
+designed to work with existing user driver frameworks such as VFIO.
+
+Extension Rules & Precautions
+-----------------------------
+When IOMMU UAPI gets extended, the data structures can *only* be
+modified in two ways:
+
+1. Adding new fields by re-purposing the padding[] field. No size change.
+2. Adding new union members at the end. May increase the structure sizes.
+
+No new fields can be added *after* the variable sized union in that it
+will break backward compatibility when offset moves. A new flag must
+be introduced whenever a change affects the structure using either
+method. The IOMMU driver processes the data based on flags which
+ensures backward compatibility.
+
+Version field is only reserved for the unlikely event of UAPI upgrade
+at its entirety.
+
+It's *always* the caller's responsibility to indicate the size of the
+structure passed by setting argsz appropriately.
+Though at the same time, argsz is user provided data which is not
+trusted. The argsz field allows the user app to indicate how much data
+it is providing; it's still the kernel's responsibility to validate
+whether it's correct and sufficient for the requested operation.
+
+Compatibility Checking
+----------------------
+When IOMMU UAPI extension results in some structure size increase,
+IOMMU UAPI code shall handle the following cases:
+
+1. User and kernel has exact size match
+2. An older user with older kernel header (smaller UAPI size) running on a
+   newer kernel (larger UAPI size)
+3. A newer user with newer kernel header (larger UAPI size) running
+   on an older kernel.
+4. A malicious/misbehaving user passing illegal/invalid size but within
+   range. The data may contain garbage.
+
+Feature Checking
+----------------
+While launching a guest with vIOMMU, it is strongly advised to check
+the compatibility upfront, as some subsequent errors happening during
+vIOMMU operation, such as cache invalidation failures cannot be nicely
+escalated to the guest due to IOMMU specifications. This can lead to
+catastrophic failures for the users.
+
+User applications such as QEMU are expected to import kernel UAPI
+headers. Backward compatibility is supported per feature flags.
+For example, an older QEMU (with older kernel header) can run on newer
+kernel. Newer QEMU (with new kernel header) may refuse to initialize
+on an older kernel if new feature flags are not supported by older
+kernel. Simply recompiling existing code with newer kernel header should
+not be an issue in that only existing flags are used.
+
+IOMMU vendor driver should report the below features to IOMMU UAPI
+consumers (e.g. via VFIO).
+
+1. IOMMU_NESTING_FEAT_SYSWIDE_PASID
+2. IOMMU_NESTING_FEAT_BIND_PGTBL
+3. IOMMU_NESTING_FEAT_BIND_PASID_TABLE
+4. IOMMU_NESTING_FEAT_CACHE_INVLD
+5. IOMMU_NESTING_FEAT_PAGE_REQUEST
+
+Take VFIO as example, upon request from VFIO userspace (e.g. QEMU),
+VFIO kernel code shall query IOMMU vendor driver for the support of
+the above features. Query result can then be reported back to the
+userspace caller. Details can be found in
+Documentation/driver-api/vfio.rst.
+
+
+Data Passing Example with VFIO
+------------------------------
+As the ubiquitous userspace driver framework, VFIO is already IOMMU
+aware and shares many key concepts such as device model, group, and
+protection domain. Other user driver frameworks can also be extended
+to support IOMMU UAPI but it is outside the scope of this document.
+
+In this tight-knit VFIO-IOMMU interface, the ultimate consumer of the
+IOMMU UAPI data is the host IOMMU driver. VFIO facilitates user-kernel
+transport, capability checking, security, and life cycle management of
+process address space ID (PASID).
+
+VFIO layer conveys the data structures down to the IOMMU driver. It
+follows the pattern below::
+
+   struct {
+	__u32 argsz;
+	__u32 flags;
+	__u8  data[];
+   };
+
+Here data[] contains the IOMMU UAPI data structures. VFIO has the
+freedom to bundle the data as well as parse data size based on its own flags.
+
+In order to determine the size and feature set of the user data, argsz
+and flags (or the equivalent) are also embedded in the IOMMU UAPI data
+structures.
+
+A "__u32 argsz" field is *always* at the beginning of each structure.
+
+For example:
+::
+
+   struct iommu_cache_invalidate_info {
+	__u32	argsz;
+	#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
+	__u32	version;
+	/* IOMMU paging structure cache */
+	#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
+	#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device IOTLB */
+	#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */
+	#define IOMMU_CACHE_INV_TYPE_NR		(3)
+	__u8	cache;
+	__u8	granularity;
+	__u8	padding[6];
+	union {
+		struct iommu_inv_pasid_info pasid_info;
+		struct iommu_inv_addr_info addr_info;
+	} granu;
+   };
+
+VFIO is responsible for checking its own argsz and flags. It then
+invokes appropriate IOMMU UAPI functions. The user pointers are passed
+to the IOMMU layer for further processing. The responsibilities are
+divided as follows:
+
+- Generic IOMMU layer checks argsz range based on UAPI data in the
+  current kernel version.
+
+- Generic IOMMU layer checks content of the UAPI data for non-zero
+  reserved bits in flags, padding fields, and unsupported version.
+  This is to ensure not breaking userspace in the future when these
+  fields or flags are used.
+
+- Vendor IOMMU driver checks argsz based on vendor flags. UAPI data
+  is consumed based on flags. Vendor driver has access to
+  unadulterated argsz value in case of vendor specific future
+  extensions. Currently, it does not perform the copy_from_user()
+  itself. A __user pointer can be provided in some future scenarios
+  where there's vendor data outside of the structure definition.
+
+IOMMU code treats UAPI data in two categories:
+
+- structure contains vendor data
+  (Example: iommu_uapi_cache_invalidate())
+
+- structure contains only generic data
+  (Example: iommu_uapi_sva_bind_gpasid())
+
+
+
+Sharing UAPI with in-kernel users
+---------------------------------
+For UAPIs that are shared with in-kernel users, a wrapper function is
+provided to distinguish the callers. For example,
+
+Userspace caller ::
+
+  int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
+                                   struct device *dev,
+                                   void __user *udata)
+
+In-kernel caller ::
+
+  int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+                              struct device *dev, ioasid_t ioasid);
diff --git a/MAINTAINERS b/MAINTAINERS
index 0d0862b19ce5..5766583e4383 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9125,6 +9125,7 @@ L:	iommu@lists.linux-foundation.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	Documentation/devicetree/bindings/iommu/
+F:	Documentation/userspace-api/iommu.rst
 F:	drivers/iommu/
 F:	include/linux/iommu.h
 F:	include/linux/iova.h
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
