Return-Path: <SRS0=KEvp=CA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C71C433E3
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C979320724
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loWFE4rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C979320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A89EA23376;
	Sat, 22 Aug 2020 07:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SJWNN9qhoKnW; Sat, 22 Aug 2020 07:09:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2C46F203AA;
	Sat, 22 Aug 2020 07:09:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D97CC07FF;
	Sat, 22 Aug 2020 07:09:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFBD3C0051
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CDB8188686
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9P0UcCQgjlj0 for <iommu@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 04:28:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ECD3188587
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:22 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id d4so1666973pjx.5
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 21:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YYpeb/PkPwRbYOwET4nNHLv4kDK8jDR1mJWP198+wu4=;
 b=loWFE4rMVDX8IGXeu/alOJRUkonwP9feeX6uYFVfzGYkUYTqL0rN1TSZox0V/jBcyE
 ST0IcVmRzqfvHAw59t0VXChNV9zmzKHttulB69GBPiMG+Zrf25IK179q5Z+pPQY+X69a
 BdTrJxCFPs99S9DEJGUsAljDdRDO0zuWgQeODz3iY3GcIi6iqLbsT22dMqgr/ZA+7ulJ
 fDeI4TBx18g9TnJnrtonVP9OLRI2oiJt32HScRYg4A3t22ALg9tfafoLn+MEo+T0Xeho
 kg7zMvakUzqOY6fTRrb/HvAKBjQJ99Iww5ownAxZe1ZpugIu1tbk8qh1uF/Uxe0VkhJZ
 B97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YYpeb/PkPwRbYOwET4nNHLv4kDK8jDR1mJWP198+wu4=;
 b=T8zF3x/RzBDRtQcLub4h069UnY7AnTDB21TZVQGsQNAx8EJcWxJZIGBhDHlueSk+3V
 0ag5Sel3NbwhzMySaBKIpY/UmCkrb7grvAdQvOGcWIRA5L1NpXXWNr3qHzCIvznwSD9z
 eeWxodyr6iugO6/1UoBYlAt85MGKa9LaME8NFnTc12pFsfs1u2KuWpk8WwvOetwNPskX
 FvzeWCckzCMUw9sHVPsPs9UFyE1eabwRt891a4zt+w8og8CcAVUBf2Vzd6Rihj4K1MaS
 J3c3nqMPsJvt0MB6M4heheQN8YocjcOOkVsSLvywosX48annlUnHgRmvtEvp9SCGv+g0
 H9Wg==
X-Gm-Message-State: AOAM530B5cp4jQKrhx6u7eDSnC6t/vaRlOBOuPmFmRHZeaFHJSC5M9nm
 ULo97/0vimPpxoSbalic4HwberR7HlDBJWwP
X-Google-Smtp-Source: ABdhPJymyNPfeAEVglq7lG1V+0IlRKVWGITLjG2VC6ZG7AQXKNBReKqOjLFGvlAWcjuhjRyR29xPQA==
X-Received: by 2002:a17:902:690a:: with SMTP id
 j10mr4872494plk.155.1598070502310; 
 Fri, 21 Aug 2020 21:28:22 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
 by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2020 21:28:21 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 0/9] IOASID extensions for guest SVA
Date: Fri, 21 Aug 2020 21:35:09 -0700
Message-Id: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 22 Aug 2020 07:09:31 +0000
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
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
https://github.com/jacobpan/linux.git ioasid_ext_v2
(VFIO and KVM patches will be available at this branch when published.)

This work is a result of collaboration with many people:
Liu, Yi L <yi.l.liu@intel.com>
Wu Hao <hao.wu@intel.com>
Ashok Raj <ashok.raj@intel.com>
Kevin Tian <kevin.tian@intel.com>

Thanks,

Jacob

Changelog

V2:
- Redesigned ioasid_set APIs, removed set ID
- Added set private ID (SPID) for guest PASID usage.
- Add per ioasid_set notification and priority support.
- Back to use spinlocks and atomic notifications.
- Added async work in VT-d driver to perform teardown outside atomic context

Jacob Pan (9):
  docs: Document IO Address Space ID (IOASID) APIs
  iommu/ioasid: Rename ioasid_set_data()
  iommu/ioasid: Introduce ioasid_set APIs
  iommu/ioasid: Add reference couting functions
  iommu/ioasid: Introduce ioasid_set private ID
  iommu/ioasid: Introduce notification APIs
  iommu/vt-d: Listen to IOASID notifications
  iommu/vt-d: Send IOASID bind/unbind notifications
  iommu/vt-d: Store guest PASID during bind

 Documentation/ioasid.rst    | 618 ++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c |  27 +-
 drivers/iommu/intel/pasid.h |   1 +
 drivers/iommu/intel/svm.c   |  97 ++++-
 drivers/iommu/ioasid.c      | 835 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h |   2 +
 include/linux/ioasid.h      | 166 ++++++++-
 7 files changed, 1699 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/ioasid.rst

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
