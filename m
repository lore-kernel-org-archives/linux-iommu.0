Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BF0C4727D
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 20:15:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4035523787
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 20:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1rUdoLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4035523787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 811D0228E3;
	Tue, 22 Sep 2020 20:15:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GEH2bg8WgBXz; Tue, 22 Sep 2020 20:15:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1172C203EB;
	Tue, 22 Sep 2020 20:15:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00035C0889;
	Tue, 22 Sep 2020 20:15:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E4B6C0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 20:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 13031203F9
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 20:15:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0z7cXCZiEDGg for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 20:15:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id C7AF1203EB
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 20:15:33 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id u24so2068456pgi.1
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=hn6et9LbYd8DuVyzW2thhcz6VZuD8GdG4uKwbIXOb50=;
 b=L1rUdoLclGSVBza/7wOpYY8ml/ZUxKH4wjY5LU820mOjsxd04jcg+HlQCmL179hWO2
 JvQgv7YapT+ocwEE4i8l8H7G1tULRf7itL6VvemEh1TLT0w0uLIA6ZAd8L/TXIb7gn0m
 oZXfdSWFv0vZoiU/lqVHLT/bGrVxbVejElaf+26Yne/a0kz+M83FclZ6VvimMuUSLuk3
 hyIMU+42B4aHSuvFAAvIvwXYIPxqDOYlGKggmpQcyn6BWTPYJsKHyxUEbL2oNiS6qzIo
 oN36BxQtB4xg+9LTgMJy17o8gnmzA1KxTZ4ZzJNo/6ffyucwbigoEAT6aXiFxrMfyGHB
 HiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=hn6et9LbYd8DuVyzW2thhcz6VZuD8GdG4uKwbIXOb50=;
 b=jlD2qDFYmN+uMahArEbUtWy9ppSmlrTZzwgOVLz02QatSZ70RA0YG7lWlu4jCKtTZZ
 0UD5ucZN7cUoIVZeDAlvyLInAOhh5o5VhRREY0HgoD03cRIafdAXTVzR3qXqkLb29RbK
 IK9JBbqCU15ZZ40xi3lRLuoCE0476J5mVY3FLeKPqZtWXGQ6HCytoK/hwdEcn6kOk8aa
 Ljo2ajfJgrEorQ0TRQQ8L3Vv9LSoS538vj/G7xKP/TZ1fXb31vdritcBQNUAxWFpmwuw
 e0KOlcskLNc4SmgICQ9DGqh4ya/at3n/EzlZXzhat9NK05c1envsIl/Pdr19kh9DjICn
 rdaw==
X-Gm-Message-State: AOAM532fLS0uhmExB2enpLdGxOCD5Pi178hVD1LvBYzVkT6dfTyZzaBT
 DKSUs6s7ycstU9M2xOPspPgLqA3SA4o=
X-Google-Smtp-Source: ABdhPJzEPDUhfqu6NbM4GZAuqgCh4rpYrCNwa9Rrcdh9kGjLXyYxyeXhqo7dh8JiTyamXowx9V1Gwg==
X-Received: by 2002:a17:902:a402:b029:d2:21a:d994 with SMTP id
 p2-20020a170902a402b02900d2021ad994mr6196232plq.52.1600805732950; 
 Tue, 22 Sep 2020 13:15:32 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id e10sm15793028pgb.45.2020.09.22.13.15.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2020 13:15:32 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v10 0/7] IOMMU user API enhancement
Date: Tue, 22 Sep 2020 13:16:55 -0700
Message-Id: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Yi Sun <yi.y.sun@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IOMMU user API header was introduced to support nested DMA translation and
related fault handling. The current UAPI data structures consist of three
areas that cover the interactions between host kernel and guest:
 - fault handling
 - cache invalidation
 - bind guest page tables, i.e. guest PASID

Future extensions are likely to support more architectures and vIOMMU features.

In the previous discussion, using user-filled data size and feature flags is
made a preferred approach over a unified version number.
https://lkml.org/lkml/2020/1/29/45

In addition to introduce argsz field to data structures, this patchset is also
trying to document the UAPI design, usage, and extension rules. VT-d driver
changes to utilize the new argsz field is included, VFIO usage is to follow.

This set is available at:
https://github.com/jacobpan/linux.git vsva_v5.9_uapi_v10

Thanks,

Jacob


Changelog:
v10
	- Documentation grammar fixes based on Randy's review
v9
	- Directly pass PASID value to iommu_sva_unbind_gpasid() without
	  the superfluous data in struct iommu_gpasid_bind_data.
v8
	- Rebased to v5.9-rc2
	- Addressed review comments from Eric Auger
	  1. added a check for the unused vendor flags
	  2. commit message improvements
v7
	- Added PASID data format enum for range checking
	- Tidy up based on reviews from Alex W.
	- Removed doc section for vIOMMU fault handling
v6
	- Renamed all UAPI functions with iommu_uapi_ prefix
	- Replaced argsz maxsz checking with flag specific size checks
	- Documentation improvements based on suggestions by Eric Auger
	  Replaced example code with a pointer to the actual code
	- Added more checks for illegal flags combinations
	- Added doc file to MAINTAINERS
v5
	- Addjusted paddings in UAPI data to be 8 byte aligned
	- Do not clobber argsz in IOMMU core before passing on to vendor driver
	- Removed pr_warn_ for invalid UAPI data check, just return -EINVAL
	- Clarified VFIO responsibility in UAPI data handling
	- Use iommu_uapi prefix to differentiate APIs has in-kernel caller
	- Added comment for unchecked flags of invalidation granularity
	- Added example in doc to show vendor data checking

v4
	- Added checks of UAPI data for reserved fields, version, and flags.
	- Removed version check from vendor driver (vt-d)
	- Relaxed argsz check to match the UAPI struct size instead of variable
	  union size
	- Updated documentation

v3:
	- Rewrote backward compatibility rule to support existing code
	  re-compiled with newer kernel UAPI header that runs on older
	  kernel. Based on review comment from Alex W.
	  https://lore.kernel.org/linux-iommu/20200611094741.6d118fa8@w520.home/
	- Take user pointer directly in UAPI functions. Perform argsz check
	  and copy_from_user() in IOMMU driver. Eliminate the need for
	  VFIO or other upper layer to parse IOMMU data.
	- Create wrapper function for in-kernel users of UAPI functions
v2:
	- Removed unified API version and helper
	- Introduced argsz for each UAPI data
	- Introduced UAPI doc


Jacob Pan (7):
  docs: IOMMU user API
  iommu/uapi: Add argsz for user filled data
  iommu/uapi: Introduce enum type for PASID data format
  iommu/uapi: Use named union for user data
  iommu/uapi: Rename uapi functions
  iommu/uapi: Handle data and argsz filled by users
  iommu/vt-d: Check UAPI data processed by IOMMU core

 Documentation/userspace-api/iommu.rst | 210 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 drivers/iommu/intel/iommu.c           |  25 ++--
 drivers/iommu/intel/svm.c             |  13 ++-
 drivers/iommu/iommu.c                 | 201 ++++++++++++++++++++++++++++++--
 include/linux/iommu.h                 |  35 ++++--
 include/uapi/linux/iommu.h            |  25 ++--
 7 files changed, 467 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/userspace-api/iommu.rst

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
