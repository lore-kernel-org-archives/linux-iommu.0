Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_DBL_ABUSE_MALW,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038AEC10F0E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 04:27:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C540C2082E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 04:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C540C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 74D079F0;
	Fri, 12 Apr 2019 04:27:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8878EF4F
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 04:19:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BB9C87ED
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 04:19:27 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Apr 2019 21:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; d="scan'208";a="142094920"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2019 21:19:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kirti Wankhede <kwankhede@nvidia.com>
Subject: [PATCH v9 0/3] vfio/mdev: IOMMU aware mediated device
Date: Fri, 12 Apr 2019 12:13:23 +0800
Message-Id: <20190412041326.19914-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
	jacob.jun.pan@intel.com, kvm@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190412041323.ZDpYUuhg620tOEz5tITh4AzyuXQNV_JX-TYiZBNUzB0@z>

Hi,

The Mediate Device is a framework for fine-grained physical device
sharing across the isolated domains. Currently the mdev framework
is designed to be independent of the platform IOMMU support. As the
result, the DMA isolation relies on the mdev parent device in a
vendor specific way.

There are several cases where a mediated device could be protected
and isolated by the platform IOMMU. For example, Intel vt-d rev3.0
[1] introduces a new translation mode called 'scalable mode', which
enables PASID-granular translations. The vt-d scalable mode is the
key ingredient for Scalable I/O Virtualization [2] [3] which allows
sharing a device in minimal possible granularity (ADI - Assignable
Device Interface).

A mediated device backed by an ADI could be protected and isolated
by the IOMMU since 1) the parent device supports tagging an unique
PASID to all DMA traffic out of the mediated device; and 2) the DMA
translation unit (IOMMU) supports the PASID granular translation.
We can apply IOMMU protection and isolation to this kind of devices
just as what we are doing with an assignable PCI device.

In order to distinguish the IOMMU-capable mediated devices from those
which still need to rely on parent devices, this patch set adds one
new member in struct mdev_device.

* iommu_device
  - This, if set, indicates that the mediated device could
    be fully isolated and protected by IOMMU via attaching
    an iommu domain to this device. If empty, it indicates
    using vendor defined isolation.

Below helpers are added to set and get above iommu device in mdev core
implementation.

* mdev_set/get_iommu_device(dev, iommu_device)
  - Set or get the iommu device which represents this mdev
    in IOMMU's device scope. Drivers don't need to set the
    iommu device if it uses vendor defined isolation.

The mdev parent device driver could opt-in that the mdev could be
fully isolated and protected by the IOMMU when the mdev is being
created by invoking mdev_set_iommu_device() in its @create().

In the vfio_iommu_type1_attach_group(), a domain allocated through
iommu_domain_alloc() will be attached to the mdev iommu device if
an iommu device has been set. Otherwise, the dummy external domain
will be used and all the DMA isolation and protection are routed to
parent driver as the result.

On IOMMU side, a basic requirement is allowing to attach multiple
domains to a PCI device if the device advertises the capability
and the IOMMU hardware supports finer granularity translations than
the normal PCI Source ID based translation.

As the result, a PCI device could work in two modes: normal mode
and auxiliary mode. In the normal mode, a pci device could be
isolated in the Source ID granularity; the pci device itself could
be assigned to a user application by attaching a single domain
to it. In the auxiliary mode, a pci device could be isolated in
finer granularity, hence subsets of the device could be assigned
to different user level application by attaching a different domain
to each subset.

Below APIs are introduced in iommu generic layer for aux-domain
purpose:

* iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)
  - Detect both IOMMU and PCI endpoint devices supporting
    the feature (aux-domain here) without the host driver
    dependency.

* iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)
  - Check the enabling status of the feature (aux-domain
    here). The aux-domain interfaces are available only
    if this returns true.

* iommu_dev_enable/disable_feature(dev, IOMMU_DEV_FEAT_AUX)
  - Enable/disable device specific aux-domain feature.

* iommu_aux_attach_device(domain, dev)
  - Attaches @domain to @dev in the auxiliary mode. Multiple
    domains could be attached to a single device in the
    auxiliary mode with each domain representing an isolated
    address space for an assignable subset of the device.

* iommu_aux_detach_device(domain, dev)
  - Detach @domain which has been attached to @dev in the
    auxiliary mode.

* iommu_aux_get_pasid(domain, dev)
  - Return ID used for finer-granularity DMA translation.
    For the Intel Scalable IOV usage model, this will be
    a PASID. The device which supports Scalable IOV needs
    to write this ID to the device register so that DMA
    requests could be tagged with a right PASID prefix.

In order for the ease of discussion, sometimes we call "a domain in
auxiliary mode' or simply 'an auxiliary domain' when a domain is
attached to a device for finer granularity translations. But we need
to keep in mind that this doesn't mean there is a differnt domain
type. A same domain could be bound to a device for Source ID based
translation, and bound to another device for finer granularity
translation at the same time.

This patch series extends both IOMMU and vfio components to support
mdev device passing through when it could be isolated and protected
by the IOMMU units. The first part of this series (PATCH 1/09~6/09)
adds the interfaces and implementation of the multiple domains per
device. The second part (PATCH 7/09~9/09) adds the iommu device
attribute to each mdev, determines isolation type according to the
existence of an iommu device when attaching group in vfio type1 iommu
module, and attaches the domain to iommu aware mediated devices.

References:
[1] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
[2] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf

Best regards,
Lu Baolu

Change log:
  v8->v9:
  - Remove the patches which have been picked by Joerg.
    https://lkml.org/lkml/2019/4/11/559
  - The patches have been updated by fixing the minor concern, add
    all reviewed-by and acked-by.
  - Patches are based on v5.1-rc4.

  v7->v8:
  - [PATCH 9/9] Remove the iommu->external_domain check in both
    vfio_iommu_type1_pin_pages() and vfio_iommu_type1_unpin_pages()
  - Rebase all patches to 5.1-rc2.

  v6->v7:
  - Update PATCH 1/9 and the cover letter with Jean's comments
    posted at https://patchwork.kernel.org/patch/10809093/.
  - Add Jean's Reviewed-by in patch 1,7,8,9.

  v5->v6:
  - Add a new API iommu_dev_feature_enabled() to check whether
    an IOMMU specific feature is enabled.
  - Rework the vt-d specific per device feature ops according
    to Joerg's comments. [https://lkml.org/lkml/2019/1/11/302].
  - PATCH 2/9 is added to move intel_iommu_enable_pasid() out
    of the scope of CONFIG_INTEL_IOMMU_SVM without functional
    changes.
  - All patches are rebased on top of vt-d branch of Joerg's
    iommu tree.

  v4->v5:
  - The iommu APIs have been updated with Joerg's proposal posted
    here https://www.spinics.net/lists/iommu/msg31874.html.
  - Some typos in commit message and comments have been fixed.
  - PATCH 3/8 was split from 4/8 to ease code review.
  - mdev->domain was removed and could bring back when there's a
    real consumer.
  - Other code review comments I received during v4 review period
    except the EXPORT_SYMBOL vs. EXPORT_SYMBOL_GPL in PATCH 6/8.
  - Rebase all patches to 5.0-rc1.

  v3->v4:
  - Use aux domain specific interfaces for domain attach and detach.
  - Rebase all patches to 4.20-rc1.

  v2->v3:
  - Remove domain type enum and use a pointer on mdev_device instead.
  - Add a generic interface for getting/setting per device iommu
    attributions. And use it for query aux domain capability, enable
    aux domain and disable aux domain purpose.
  - Reuse iommu_domain_get_attr() to retrieve the id in a aux domain.
  - We discussed the impact of the default domain implementation
    on reusing iommu_at(de)tach_device() interfaces. We agreed
    that reusing iommu_at(de)tach_device() interfaces is the right
    direction and we could tweak the code to remove the impact.
    https://www.spinics.net/lists/kvm/msg175285.html  
  - Removed the RFC tag since no objections received.
  - This patch has been submitted separately.
    https://www.spinics.net/lists/kvm/msg173936.html

  v1->v2:
  - Rewrite the patches with the concept of auxiliary domains.

Lu Baolu (3):
  vfio/mdev: Add iommu related member in mdev_device
  vfio/type1: Add domain at(de)taching group helpers
  vfio/type1: Handle different mdev isolation type

 drivers/vfio/mdev/mdev_core.c    |  18 ++++
 drivers/vfio/mdev/mdev_private.h |   1 +
 drivers/vfio/vfio_iommu_type1.c  | 139 ++++++++++++++++++++++++++-----
 include/linux/mdev.h             |  14 ++++
 4 files changed, 152 insertions(+), 20 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
