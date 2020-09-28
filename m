Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC628C4727C
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401EC2083B
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvCZ0nRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401EC2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B612C20764;
	Mon, 28 Sep 2020 21:36:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MTT4op67UJem; Mon, 28 Sep 2020 21:36:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 954922052E;
	Mon, 28 Sep 2020 21:36:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F97EC016F;
	Mon, 28 Sep 2020 21:36:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 181B0C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F40A685521
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uqMTN8aXIvsV for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 21:36:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5A2F584DE6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:43 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id d9so2412010pfd.3
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WHiQmkkK2NJuMpdF84U1p8BgO8doyJ+ubIf1vtzVkMU=;
 b=ZvCZ0nRk+mPGK3HxzkDtiCXgRQS+HZ9mDv5od0kf5cW4cXXEytUF1TNSDrg/0qiHAJ
 gOaBO0Z9f3ZFMTVaSttSCv3jRpYCdU8sEwjJH+RAKI1I0UXWNDTLi21rlGwsHqWmQqPP
 GUDLXrexJhPthsBZaKjZ1WcemJMT6g1a0NgL4hZcmzU0pJvxh4V0G08LiAziz1mlXip7
 zJnzSeVeHCBA3a5pa2TzbkAivXN6I08OvquXGR3ApOa5qV2BIGHFuN3d78DDG0hih5ZY
 m6kDJWVMn77C6PXj84Qd0ij2w5Mm/cwtVQ54gVsUa3C/IwqbsMLOigqSXkfoT2AQTll2
 RXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WHiQmkkK2NJuMpdF84U1p8BgO8doyJ+ubIf1vtzVkMU=;
 b=oSNoVeZ8oKkz1/AIcCVFk4VWYPgo88355ppB27Oa25WJKZGi3Yb6k/UfPwXXqEdCbS
 V5dFCfwpJZdJXXAr4fnoC5IY0kpE0MKFTiEq3E3cWbpiOARMKJJXfahBOWZGNF3gtoQF
 W/sLsSF3wfuJ8+teIEkNRI8QRnlzhFmAZToJ21OpkI6Xq+L7NLYHqmAtv0BCh8JK/R8g
 PMx9NfCeR97l0QBrWYpbYq5T4cNzRqpMoLfB+KvHBftK7kVWJbn9lnBa+WWcbKwj1AfE
 ZCGRk02H9sd2BJ09NlF8LyAzvpc1/MXjapnvqjFtP/HDH19fRAedbHLH1xWwhvgGuDmx
 7Iiw==
X-Gm-Message-State: AOAM530TPYJdNPAEAqWPNDZ9RmNZ2YksjmQ8lQsq5aJZSqcoH99Nt+Ol
 bunW5q9kVDJeQDklxVOGhkiGbiAloow=
X-Google-Smtp-Source: ABdhPJxdu2bPX+w7b00QUlcN/F3zpKQph9sX+X/W3d3IiEF5PpxH0ceFbZOkwxqhCiSFkNFLgbC4fA==
X-Received: by 2002:a63:f74a:: with SMTP id f10mr792980pgk.263.1601329002652; 
 Mon, 28 Sep 2020 14:36:42 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 14:36:41 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 00/14] IOASID extensions for guest SVA
Date: Mon, 28 Sep 2020 14:38:27 -0700
Message-Id: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, linux-api@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IOASID was introduced in v5.5 as a generic kernel allocator service for
both PCIe Process Address Space ID (PASID) and ARM SMMU's Sub Stream
ID. In addition to basic ID allocation, ioasid_set was defined as a
token that is shared by a group of IOASIDs. This set token can be used
for permission checking, but lack of some features to address the
following needs by guest Shared Virtual Address (SVA).
- Manage IOASIDs by group, group ownership, quota, etc.
- State synchronization among IOASID users
- Non-identity guest-host IOASID mapping
- Lifecycle management across many users

This patchset introduces the following extensions as solutions to the
problems above.
- Redefine and extend IOASID set such that IOASIDs can be managed by groups.
- Add notifications for IOASID state synchronization
- Add reference counting for life cycle alignment among users
- Support ioasid_set private IDs, which can be used as guest IOASIDs
Please refer to Documentation/ioasid.rst in enclosed patch 1/9 for more
details.

This patchset only included VT-d driver as users of some of the new APIs.
VFIO and KVM patches are coming up to fully utilize the APIs introduced
here.

You can find this series at:
https://github.com/jacobpan/linux.git ioasid_v3
(VFIO and KVM patches will be available at this branch when published.)

This work is a result of collaboration with many people:
Liu, Yi L <yi.l.liu@intel.com>
Wu Hao <hao.wu@intel.com>
Ashok Raj <ashok.raj@intel.com>
Kevin Tian <kevin.tian@intel.com>

Thanks,

Jacob

Changelog:

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

Jacob Pan (14):
  docs: Document IO Address Space ID (IOASID) APIs
  iommu/ioasid: Rename ioasid_set_data()
  iommu/ioasid: Add a separate function for detach data
  iommu/ioasid: Support setting system-wide capacity
  iommu/ioasid: Redefine IOASID set and allocation APIs
  iommu/ioasid: Introduce API to adjust the quota of an ioasid_set
  iommu/ioasid: Add an iterator API for ioasid_set
  iommu/ioasid: Add reference couting functions
  iommu/ioasid: Introduce ioasid_set private ID
  iommu/ioasid: Introduce notification APIs
  iommu/ioasid: Support mm type ioasid_set notifications
  iommu/vt-d: Remove mm reference for guest SVA
  iommu/vt-d: Listen to IOASID notifications
  iommu/vt-d: Store guest PASID during bind

 Documentation/driver-api/ioasid.rst | 648 ++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c         |  29 +-
 drivers/iommu/intel/pasid.h         |   1 +
 drivers/iommu/intel/svm.c           | 132 +++++-
 drivers/iommu/ioasid.c              | 890 ++++++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h         |   2 +
 include/linux/ioasid.h              | 197 +++++++-
 7 files changed, 1830 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/driver-api/ioasid.rst

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
