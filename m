Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D28EC47425
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 00:11:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BC82193E
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 00:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BC82193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A184687268;
	Thu,  1 Oct 2020 00:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 85A2vw0NU-08; Thu,  1 Oct 2020 00:11:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C901A862B2;
	Thu,  1 Oct 2020 00:11:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE546C0890;
	Thu,  1 Oct 2020 00:11:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35223C0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 00:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2E81386B2C
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 00:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ovGQ4Za8bAOL for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 00:11:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9CFE686450
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 00:11:54 +0000 (UTC)
IronPort-SDR: zc9bStTSZAqpmam+lTFNvfnfj0tvbEVXJTGFI+KReslYWlJyI1p6XGzAuti960mvw/eNFSQ0UB
 s0MA/W547Qtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="180732768"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="180732768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 17:11:53 -0700
IronPort-SDR: 4R3BVebGzy45SAg5UmoEuqws7o6A/pzDV/eMbxD6JOlYwo9zf93OGFUDzgrW9SirHQ1+z8GsbP
 B2peItqXGUiA==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="500276811"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 17:11:52 -0700
From: Kyung Min Park <kyung.min.park@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [RESEND PATCH 0/4] Audit Capability and Extended Capability among
 IOMMUs
Date: Wed, 30 Sep 2020 16:53:05 -0700
Message-Id: <20200930235309.22841-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: ravi.v.shankar@intel.com, kevin.tian@intel.com, ashok.raj@intel.com,
 ricardo.neri@intel.com, kyung.min.park@intel.com, dwmw2@infradead.org
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

Kyung Min Park (4):
  iommu/vt-d: Disable SVM in the platform when IOMMUs have
    inconsistencies
  iommu/vt-d: Report out when IOMMU features have inconsistencies
  iommu/vt-d: Audit IOMMUs for Interrupt Remapping features
  iommu/vt-d: Scale capability to the lowest supported between the
    IOMMUs

 drivers/iommu/intel/Makefile        |   4 +-
 drivers/iommu/intel/audit.c         | 193 ++++++++++++++++++++++++++++
 drivers/iommu/intel/audit.h         | 103 +++++++++++++++
 drivers/iommu/intel/iommu.c         |  12 +-
 drivers/iommu/intel/irq_remapping.c |   8 ++
 include/linux/intel-iommu.h         |   3 +
 6 files changed, 320 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/intel/audit.c
 create mode 100644 drivers/iommu/intel/audit.h

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
