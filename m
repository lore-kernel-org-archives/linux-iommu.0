Return-Path: <SRS0=Pr8R=H6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B90C4332B
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9743964E02
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9743964E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DAEC6F893;
	Sun, 28 Feb 2021 06:33:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7V_t7Getgs5a; Sun, 28 Feb 2021 06:33:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A903B6F943;
	Sun, 28 Feb 2021 06:33:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BE27C001D;
	Sun, 28 Feb 2021 06:33:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79B78C000B
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 431914F063
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DfYe-cdJ_tGK for <iommu@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 06:33:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 704154F05F
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:10 +0000 (UTC)
IronPort-SDR: 2925cRGlMBzlBWTqKn7BUU60sPaKTw0hRgQi8U0LE5L62hQ3dczH/y1q/YYL/hkdxnt4dVpnHC
 pOD+QykACUaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="183755893"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="183755893"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 22:33:09 -0800
IronPort-SDR: zSBJxdwQZHoVezvXYEeout6/nD544xO1VQhICbjae1zditmZikHAouc4meKPjvOYojqXrUKKsp
 ejANQKMuy2Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="517029695"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH V4 00/18] IOASID extensions for guest SVA
Date: Sat, 27 Feb 2021 14:01:08 -0800
Message-Id: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Wu Hao <hao.wu@intel.com>
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

I/O Address Space ID (IOASID) core code was introduced in v5.5 as a generic
kernel allocator service for both PCIe Process Address Space ID (PASID) and
ARM SMMU's Substream ID. IOASIDs are used to associate DMA requests with
virtual address spaces, including both host and guest.

In addition to providing basic ID allocation, ioasid_set was defined as a
token that is shared by a group of IOASIDs. This set token can be used
for permission checking, but lack some features to address the following
needs by guest Shared Virtual Address (SVA).
- Manage IOASIDs by group, group ownership, quota, etc.
- State synchronization among IOASID users (e.g. IOMMU driver, KVM, device
drivers)
- Non-identity guest-host IOASID mapping
- Lifecycle management

This patchset introduces the following extensions as solutions to the
problems above.
- Redefine and extend IOASID set such that IOASIDs can be managed by groups/pools.
- Add notifications for IOASID state synchronization
- Extend reference counting for life cycle alignment among multiple users
- Support ioasid_set private IDs, which can be used as guest IOASIDs
- Add a new cgroup controller for resource distribution

Please refer to Documentation/admin-guide/cgroup-v1/ioasids.rst and
Documentation/driver-api/ioasid.rst in the enclosed patches for more
details.

Based on discussions on LKML[1], a direction change was made in v4 such that
the user interfaces for IOASID allocation are extracted from VFIO
subsystem. The proposed IOASID subsystem now consists of three components:
1. IOASID core[01-14]: provides APIs for allocation, pool management,
  notifications, and refcounting.
2. IOASID cgroup controller[RFC 15-17]: manage resource distribution[2].
3. IOASID user[RFC 18]:  provides user allocation interface via /dev/ioasid 

This patchset only included VT-d driver as users of some of the new APIs.
VFIO and KVM patches are coming up to fully utilize the APIs introduced here.

[1] https://lore.kernel.org/linux-iommu/1599734733-6431-1-git-send-email-yi.l.liu@intel.com/
[2] Note that ioasid quota management code can be removed once the IOASIDs
cgroup is ratified.

You can find this series, VFIO, KVM, and IOASID user at:
https://github.com/jacobpan/linux.git ioasid_v4
(VFIO and KVM patches will be available at this branch when published.)

This work is a result of collaboration with many people:
Liu, Yi L <yi.l.liu@intel.com>
Wu Hao <hao.wu@intel.com>
Ashok Raj <ashok.raj@intel.com>
Kevin Tian <kevin.tian@intel.com>

Thanks,

Jacob

Changelog:

v4
- Introduced IOASIDs cgroup controller
- Introduced /dev/ioasid user API for allocation/free
- Added IOASID states and free function, aligned refcounting on v5.11
  introduced by Jean.
- Support iommu-sva-lib (will converge VT-d code afterward)
- Added a shared ordered workqueue for notification work that requires
  thread context. Streamlined notification framework among multiple IOASID
  users.
- Added ioasid_set helper functions for taking per set operations

V3:
- Use consistent ioasid_set_ prefix for ioasid_set level APIs
- Make SPID and private detach/attach APIs symmetric
- Use the same ioasid_put semantics as Jean-Phillippe IOASID reference patch
- Take away the public ioasid_notify() function, notifications are now emitted
  by IOASID core as a result of certain IOASID APIs
- Partition into finer incremental patches
- Miscellaneous cleanup, locking, exception handling fixes based on v2 reviews

V2:
- Redesigned ioasid_set APIs, removed set ID
- Added set private ID (SPID) for guest PASID usage.
- Add per ioasid_set notification and priority support.
- Back to use spinlocks and atomic notifications.
- Added async work in VT-d driver to perform teardown outside atomic context


Jacob Pan (17):
  docs: Document IO Address Space ID (IOASID) APIs
  iommu/ioasid: Rename ioasid_set_data()
  iommu/ioasid: Add a separate function for detach data
  iommu/ioasid: Support setting system-wide capacity
  iommu/ioasid: Redefine IOASID set and allocation APIs
  iommu/ioasid: Add free function and states
  iommu/ioasid: Add ioasid_set iterator helper functions
  iommu/ioasid: Introduce ioasid_set private ID
  iommu/ioasid: Introduce notification APIs
  iommu/ioasid: Support mm token type ioasid_set notifications
  iommu/ioasid: Add ownership check in guest bind
  iommu/vt-d: Remove mm reference for guest SVA
  iommu/ioasid: Add a workqueue for cleanup work
  iommu/vt-d: Listen to IOASID notifications
  cgroup: Introduce ioasids controller
  iommu/ioasid: Consult IOASIDs cgroup for allocation
  docs: cgroup-v1: Add IOASIDs controller

Liu Yi L (1):
  ioasid: Add /dev/ioasid for userspace

 Documentation/admin-guide/cgroup-v1/index.rst |   1 +
 .../admin-guide/cgroup-v1/ioasids.rst         | 107 ++
 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/ioasid.rst           | 510 +++++++++
 Documentation/userspace-api/index.rst         |   1 +
 Documentation/userspace-api/ioasid.rst        |  49 +
 drivers/iommu/Kconfig                         |   5 +
 drivers/iommu/Makefile                        |   1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   1 +
 drivers/iommu/intel/Kconfig                   |   1 +
 drivers/iommu/intel/iommu.c                   |  32 +-
 drivers/iommu/intel/pasid.h                   |   1 +
 drivers/iommu/intel/svm.c                     | 145 ++-
 drivers/iommu/ioasid.c                        | 983 +++++++++++++++++-
 drivers/iommu/ioasid_user.c                   | 297 ++++++
 drivers/iommu/iommu-sva-lib.c                 |  19 +-
 drivers/iommu/iommu.c                         |  16 +-
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/intel-iommu.h                   |   2 +
 include/linux/ioasid.h                        | 256 ++++-
 include/linux/miscdevice.h                    |   1 +
 include/uapi/linux/ioasid.h                   |  98 ++
 init/Kconfig                                  |   7 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/ioasids.c                       | 345 ++++++
 25 files changed, 2794 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/admin-guide/cgroup-v1/ioasids.rst
 create mode 100644 Documentation/driver-api/ioasid.rst
 create mode 100644 Documentation/userspace-api/ioasid.rst
 create mode 100644 drivers/iommu/ioasid_user.c
 create mode 100644 include/uapi/linux/ioasid.h
 create mode 100644 kernel/cgroup/ioasids.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
