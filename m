Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F378C433DF
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 16:49:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8699222260
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 16:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8699222260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0EB7886F80;
	Mon, 19 Oct 2020 16:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N+XouXcNpHVn; Mon, 19 Oct 2020 16:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02AEE86F78;
	Mon, 19 Oct 2020 16:49:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9D77C088B;
	Mon, 19 Oct 2020 16:49:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44A97C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 16:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2D2E620035
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 16:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3MNHa2ACiXSm for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 16:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id B6C802E0F2
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 16:49:07 +0000 (UTC)
IronPort-SDR: 9s2X3+0Kuhh8PLBwLVB/Xe6Wa5wHv6uI/8/SWBLN+NqH9hip7jluoiVMFIH4c5Shw1hmEYxxUy
 ndKyEqhnxtFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="167176521"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; d="scan'208";a="167176521"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2020 09:49:06 -0700
IronPort-SDR: oiK2RFjYHsNVVqZa6B8pgPwSyVV0MbY1DxgphPSU3WzJPjycIhZxMhTyTE6I4R+NIZUgpRmeqd
 wQ4uJo9Bj3EQ==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; d="scan'208";a="320336768"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2020 09:49:06 -0700
Date: Mon, 19 Oct 2020 09:51:25 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v3 00/14] IOASID extensions for guest SVA
Message-ID: <20201019095125.291915b2@jacob-builder>
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Yi Sun <yi.y.sun@intel.com>
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

Hi,

Any comments on this? I know we have some opens w.r.t. PASID management
UAPI, but I think having this common kernel API features should be
justified.

Thanks!

Jacob


On Mon, 28 Sep 2020 14:38:27 -0700, Jacob Pan <jacob.pan.linux@gmail.com>
wrote:

> IOASID was introduced in v5.5 as a generic kernel allocator service for
> both PCIe Process Address Space ID (PASID) and ARM SMMU's Sub Stream
> ID. In addition to basic ID allocation, ioasid_set was defined as a
> token that is shared by a group of IOASIDs. This set token can be used
> for permission checking, but lack of some features to address the
> following needs by guest Shared Virtual Address (SVA).
> - Manage IOASIDs by group, group ownership, quota, etc.
> - State synchronization among IOASID users
> - Non-identity guest-host IOASID mapping
> - Lifecycle management across many users
> 
> This patchset introduces the following extensions as solutions to the
> problems above.
> - Redefine and extend IOASID set such that IOASIDs can be managed by
> groups.
> - Add notifications for IOASID state synchronization
> - Add reference counting for life cycle alignment among users
> - Support ioasid_set private IDs, which can be used as guest IOASIDs
> Please refer to Documentation/ioasid.rst in enclosed patch 1/9 for more
> details.
> 
> This patchset only included VT-d driver as users of some of the new APIs.
> VFIO and KVM patches are coming up to fully utilize the APIs introduced
> here.
> 
> You can find this series at:
> https://github.com/jacobpan/linux.git ioasid_v3
> (VFIO and KVM patches will be available at this branch when published.)
> 
> This work is a result of collaboration with many people:
> Liu, Yi L <yi.l.liu@intel.com>
> Wu Hao <hao.wu@intel.com>
> Ashok Raj <ashok.raj@intel.com>
> Kevin Tian <kevin.tian@intel.com>
> 
> Thanks,
> 
> Jacob
> 
> Changelog:
> 
> V3:
> - Use consistent ioasid_set_ prefix for ioasid_set level APIs
> - Make SPID and private detach/attach APIs symmetric
> - Use the same ioasid_put semantics as Jean-Phillippe IOASID reference
> patch
> - Take away the public ioasid_notify() function, notifications are now
> emitted by IOASID core as a result of certain IOASID APIs
> - Partition into finer incremental patches
> - Miscellaneous cleanup, locking, exception handling fixes based on v2
> reviews
> 
> V2:
> - Redesigned ioasid_set APIs, removed set ID
> - Added set private ID (SPID) for guest PASID usage.
> - Add per ioasid_set notification and priority support.
> - Back to use spinlocks and atomic notifications.
> - Added async work in VT-d driver to perform teardown outside atomic
> context
> 
> Jacob Pan (14):
>   docs: Document IO Address Space ID (IOASID) APIs
>   iommu/ioasid: Rename ioasid_set_data()
>   iommu/ioasid: Add a separate function for detach data
>   iommu/ioasid: Support setting system-wide capacity
>   iommu/ioasid: Redefine IOASID set and allocation APIs
>   iommu/ioasid: Introduce API to adjust the quota of an ioasid_set
>   iommu/ioasid: Add an iterator API for ioasid_set
>   iommu/ioasid: Add reference couting functions
>   iommu/ioasid: Introduce ioasid_set private ID
>   iommu/ioasid: Introduce notification APIs
>   iommu/ioasid: Support mm type ioasid_set notifications
>   iommu/vt-d: Remove mm reference for guest SVA
>   iommu/vt-d: Listen to IOASID notifications
>   iommu/vt-d: Store guest PASID during bind
> 
>  Documentation/driver-api/ioasid.rst | 648 ++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.c         |  29 +-
>  drivers/iommu/intel/pasid.h         |   1 +
>  drivers/iommu/intel/svm.c           | 132 +++++-
>  drivers/iommu/ioasid.c              | 890
> ++++++++++++++++++++++++++++++++++-- include/linux/intel-iommu.h
> |   2 + include/linux/ioasid.h              | 197 +++++++-
>  7 files changed, 1830 insertions(+), 69 deletions(-)
>  create mode 100644 Documentation/driver-api/ioasid.rst
> 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
