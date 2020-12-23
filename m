Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7780C433E6
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 00:50:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81414207F7
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 00:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81414207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1D314872C4;
	Wed, 23 Dec 2020 00:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mFOWJcf8Ng42; Wed, 23 Dec 2020 00:50:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34DB387285;
	Wed, 23 Dec 2020 00:50:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 151CEC1825;
	Wed, 23 Dec 2020 00:50:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66697C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 59A5685F5C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yr50Mff-lIDU for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 00:50:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8471F85F58
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:50:53 +0000 (UTC)
IronPort-SDR: GsN6YfWmvVK7HTkLmhrnJXDhzPdesQ+AgZ8xekOcg0ZpQ9mmCHyGNpUQb1vXiVTlFQ2EiZadPs
 uJwo2/pVWhfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="173372349"
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; d="scan'208";a="173372349"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 16:50:25 -0800
IronPort-SDR: al2gQmAe6shFl/QBKdY1AAtjG3IgHecQva40t44FuSDqIR9Clw/CjSLqlha8jCbNxQJy9ZwBo1
 JJBW4/mLIF3w==
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; d="scan'208";a="397599451"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.146])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 16:50:25 -0800
From: Kyung Min Park <kyung.min.park@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 0/3] Audit Capability and Extended Capability among IOMMUs
Date: Tue, 22 Dec 2020 16:29:01 -0800
Message-Id: <20201223002904.13872-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: ravi.v.shankar@intel.com, kevin.tian@intel.com, ashok.raj@intel.com,
 dwmw2@infradead.org, ricardo.neri@intel.com, kyung.min.park@intel.com,
 will@kernel.org
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

Modern platforms have more than one IOMMU. Each IOMMU has its own
feature set. Some of these features must be consistent among IOMMUs.
Otherwise, these differences can lead to improper behavior in the system.
On the other hand, for some features, each IOMMU can have different
capacity values. So, different actions are required to deal with the
inconsistencies depending on the IOMMU features.

Currently, some inconsistencies are ignored by the IOMMU driver.
This patchset checks IOMMU capabilities and extended capabilities
centralizedly during boot and take different actions according to
the impacts caused by the mismatches.

For example:
 1. Disable Shared Virtual Memory.
 2. Use common capacity values (normally the lowest capacity value) for
    all IOMMUs.
 3. Report feature mismatches.

Detailed information on the IOMMU Capability / Extended Capability can
be found in Intel VT-d Specification.

Link: https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf

ChangeLog:
- Change from v2 to v3:
  1. fix the wrong macro names and rebase to v5.10.
- Change from v1 to v2:
  1. Add missing cap/ecaps for audit.
  2. Refactor function/macros overal suggested by Lu, Baolu.
  2. Skip audit for gfx dedicated IOMMU.
  3. Change commit message.

Kyung Min Park (3):
  iommu/vt-d: Audit IOMMU Capabilities and add helper functions
  iommu/vt-d: Move capability check code to cap_audit files
  iommu/vt-d: Disable SVM in the platform when IOMMUs have
    inconsistencies

 drivers/iommu/intel/Makefile        |   2 +-
 drivers/iommu/intel/cap_audit.c     | 219 ++++++++++++++++++++++++++++
 drivers/iommu/intel/cap_audit.h     | 132 +++++++++++++++++
 drivers/iommu/intel/iommu.c         |  85 ++---------
 drivers/iommu/intel/irq_remapping.c |   8 +
 drivers/iommu/intel/svm.c           |   3 +-
 include/linux/intel-iommu.h         |  39 ++---
 7 files changed, 394 insertions(+), 94 deletions(-)
 create mode 100644 drivers/iommu/intel/cap_audit.c
 create mode 100644 drivers/iommu/intel/cap_audit.h

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
