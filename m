Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493E3C433EF
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B38761051
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B38761051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0E51605AF;
	Sun, 19 Sep 2021 06:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e0MQvCJxMdpu; Sun, 19 Sep 2021 06:43:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E60D605D0;
	Sun, 19 Sep 2021 06:43:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D98EC0011;
	Sun, 19 Sep 2021 06:43:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B00AC000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A55E40332
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hrupXb14f9vE for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:43:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C1404031B
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="203156228"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="203156228"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:43:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510702199"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:43:39 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 20/20] Doc: Add documentation for /dev/iommu
Date: Sun, 19 Sep 2021 14:38:48 +0800
Message-Id: <20210919063848.1476776-21-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210919063848.1476776-1-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, kwankhede@nvidia.com, jean-philippe@linaro.org,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
 david@gibson.dropbear.id.au, robin.murphy@arm.com, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, dwmw2@infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Document the /dev/iommu framework for user.

Open:
Do we want to document /dev/iommu in Documentation/userspace-api/iommu.rst?
Existing iommu.rst is for the vSVA interfaces, honestly, may need to rewrite
this doc entirely.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 Documentation/userspace-api/index.rst   |   1 +
 Documentation/userspace-api/iommufd.rst | 183 ++++++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 Documentation/userspace-api/iommufd.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 0b5eefed027e..54df5a278023 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -25,6 +25,7 @@ place where this information is gathered.
    ebpf/index
    ioctl/index
    iommu
+   iommufd
    media/index
    sysfs-platform_profile
 
diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
new file mode 100644
index 000000000000..abffbb47dc02
--- /dev/null
+++ b/Documentation/userspace-api/iommufd.rst
@@ -0,0 +1,183 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. iommu:
+
+===================
+IOMMU Userspace API
+===================
+
+Direct device access from userspace has been a crtical feature in
+high performance computing and virtualization usages. Linux now
+includes multiple device-passthrough frameworks (e.g. VFIO and vDPA)
+to manage secure device access from the userspace. One critical
+task of those frameworks is to put the assigned device in a secure,
+IOMMU-protected context so the device is prevented from doing harm
+to the rest of the system.
+
+Currently those frameworks implement their own logic for managing
+I/O page tables to isolate user-initiated DMAs. This doesn't scale
+to support many new IOMMU features, such as PASID-granular DMA
+remapping, nested translation, I/O page fault, IOMMU dirty bit, etc.
+
+The /dev/iommu framework provides an unified interface for managing
+I/O page tables for passthrough devices. Existing passthrough
+frameworks are expected to use this interface instead of continuing
+their ad-hoc implementations.
+
+IOMMUFDs, IOASIDs, Devices and Groups
+-------------------------------------
+
+The core concepts in /dev/iommu are IOMMUFDs and IOASIDs. IOMMUFD (by
+opening /dev/iommu) is the container holding multiple I/O address
+spaces for a user, while IOASID is the fd-local software handle
+representing an I/O address space and associated with a single I/O
+page table. User manages those address spaces through fd operations,
+e.g. by using vfio type1v2 mapping semantics to manage respective
+I/O page tables.
+
+IOASID is comparable to the conatiner concept in VFIO. The latter
+is also associated to a single I/O address space. A main difference
+between them is that multiple IOASIDs in the same IOMMUFD can be
+nested together (not supported yet) to allow centralized accounting
+of locked pages, while multiple containers are disconnected thus
+duplicated accounting is incurred. Typically one IOMMUFD is
+sufficient for all intended IOMMU usages for a user.
+
+An I/O address space takes effect in the IOMMU only after it is
+attached by a device. One I/O address space can be attached by
+multiple devices. One device can be only attached to a single I/O
+address space at this point (on par with current vfio behavior).
+
+Device must be bound to an iommufd before the attach operation can
+be conducted. The binding operation builds the connection between
+the devicefd (opened via device-passthrough framework) and IOMMUFD.
+IOMMU-protected security context is esbliashed when the binding
+operation is completed. The passthrough framework must block user
+access to the assigned device until bind() returns success.
+
+The entire /dev/iommu framework adopts a device-centric model w/o
+carrying any container/group legacy as current vfio does. However
+the group is the minimum granularity that must be used to ensure
+secure user access (refer to vfio.rst). This framework relies on
+the IOMMU core layer to map device-centric model into group-granular
+isolation.
+
+Managing I/O Address Spaces
+---------------------------
+
+When creating an I/O address space (by allocating IOASID), the user
+must specify the type of underlying I/O page table. Currently only
+one type (kernel-managed) is supported. In the future other types
+will be introduced, e.g. to support user-managed I/O page table or
+a shared I/O page table which is managed by another kernel sub-
+system (mm, ept, etc.). Kernel-managed I/O page table is currently
+managed via vfio type1v2 equivalent mapping semantics.
+
+The user also needs to specify the format of the I/O page table
+when allocating an IOASID. The format must be compatible to the
+attached devices (or more specifically to the IOMMU which serves
+the DMA from the attached devices). User can query the device IOMMU
+format via IOMMUFD once a device is successfully bound. Attaching a
+device to an IOASID with incompatible format is simply rejected.
+
+Currently no-snoop DMA is not supported yet. This implies that
+IOASID must be created in an enforce-snoop format and only devices
+which can be forced to snoop cache by IOMMU are allowed to be
+attached to IOASID. The user should check uAPI extension and get
+device info via IOMMUFD to handle such restriction.
+
+Usage Example
+-------------
+
+Assume user wants to access PCI device 0000:06:0d.0, which is
+exposed under the new /dev/vfio/devices directory by VFIO:
+
+	/* Open device-centric interface and /dev/iommu interface */
+	device_fd = open("/dev/vfio/devices/0000:06:0d.0", O_RDWR);
+	iommu_fd = open("/dev/iommu", O_RDWR);
+
+	/* Bind device to IOMMUFD */
+	bind_data = { .iommu_fd = iommu_fd, .dev_cookie = cookie };
+	ioctl(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind_data);
+
+	/* Query per-device IOMMU capability/format */
+	info = { .dev_cookie = cookie, };
+	ioctl(iommu_fd, IOMMU_DEVICE_GET_INFO, &info);
+
+	if (!(info.flags & IOMMU_DEVICE_INFO_ENFORCE_SNOOP)) {
+		if (!ioctl(iommu_fd, IOMMU_CHECK_EXTENSION,
+				EXT_DMA_NO_SNOOP))
+			/* No support of no-snoop DMA */
+	}
+
+	if (!ioctl(iommu_fd, IOMMU_CHECK_EXTENSION, EXT_MAP_TYPE1V2))
+		/* No support of vfio type1v2 mapping semantics */
+
+	/* Decides IOASID alloc fields based on info */
+	alloc_data = { .type = IOMMU_IOASID_TYPE_KERNEL,
+		       .flags = IOMMU_IOASID_ENFORCE_SNOOP,
+		       .addr_width = info.addr_width, };
+
+	/* Allocate IOASID */
+	gpa_ioasid = ioctl(iommu_fd, IOMMU_IOASID_ALLOC, &alloc_data);
+
+	/* Attach device to an IOASID */
+	at_data = { .iommu_fd = iommu_fd; .ioasid = gpa_ioasid};
+	ioctl(device_fd, VFIO_DEVICE_ATTACH_IOASID, &at_data);
+
+	/* Setup GPA mapping [0 - 1GB] */
+	dma_map = {
+		.ioasid	= gpa_ioasid,
+		.data {
+			.flags  = R/W		/* permission */
+			.iova	= 0,		/* GPA */
+			.vaddr	= 0x40000000,	/* HVA */
+			.size	= 1GB,
+		},
+	};
+	ioctl(iommu_fd, IOMMU_MAP_DMA, &dma_map);
+
+	/* DMA */
+
+	/* Unmap GPA mapping [0 - 1GB] */
+	dma_unmap = {
+		.ioasid	= gpa_ioasid,
+		.data {
+			.iova	= 0,		/* GPA */
+			.size	= 1GB,
+		},
+	};
+	ioctl(iommu_fd, IOMMU_UNMAP_DMA, &dma_unmap);
+
+	/* Detach device from an IOASID */
+	dt_data = { .iommu_fd = iommu_fd; .ioasid = gpa_ioasid};
+	ioctl(device_fd, VFIO_DEVICE_DETACH_IOASID, &dt_data);
+
+	/* Free IOASID */
+	ioctl(iommu_fd, IOMMU_IOASID_FREE, gpa_ioasid);
+
+	close(device_fd);
+	close(iommu_fd);
+
+API for device-passthrough frameworks
+-------------------------------------
+
+iommufd binding and IOASID attach/detach are initiated via the device-
+passthrough framework uAPI.
+
+When a binding operation is requested by the user, the passthrough
+framework should call iommufd_bind_device(). When the device fd is
+closed by the user, iommufd_unbind_device() should be called
+automatically::
+
+	struct iommufd_device *
+	iommufd_bind_device(int fd, struct device *dev,
+			   u64 dev_cookie);
+	void iommufd_unbind_device(struct iommufd_device *idev);
+
+IOASID attach/detach operations are per iommufd_device which is
+returned by iommufd_bind_device():
+
+	int iommufd_device_attach_ioasid(struct iommufd_device *idev,
+					int ioasid);
+	void iommufd_device_detach_ioasid(struct iommufd_device *idev,
+					int ioasid);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
