Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED02C433E2
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F18C2071B
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYbTNLLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F18C2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 290A48678D;
	Mon, 31 Aug 2020 18:18:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DrHjOVy2MRDv; Mon, 31 Aug 2020 18:18:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F51286787;
	Mon, 31 Aug 2020 18:18:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F123FC07FF;
	Mon, 31 Aug 2020 18:18:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3674C0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A217E86789
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qWxWL6fAEyTK for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 18:18:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E770286787
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:08 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id x18so2236829pll.6
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=MpFriyvAVeQ141rIrcIndLwo0DUmN70bXB2sWFslHOk=;
 b=CYbTNLLmCL49w91IM5M3uXNUfoSE6oHvpIAkNLlVESMhUK6NmISqV1D+AkqANbx7XK
 tOBGuw0pBMvj1P7ufyt3JsggppG+gUW9bk1PEBUkl3mu/WNyHzZJX5Tkzi1GCiCm0BZo
 0U7mPqPBe741/nE0YMT3Xpo7dhG1EzYx860aDt5e6HFSrvdaI8umZVJL3zI6bJYaBDx+
 4UjPigd1KKIapNzv3snW2bGwrAa1KoUJPr2IZadaifIjXekg31xDWuL1Z33irviJZ52B
 xEHWXbSBMvw84ul/PC1myxzJfrA4h500U02gF9hEJpFeQYY3YFsVW2Ay5dk5fLDGXgLz
 37Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=MpFriyvAVeQ141rIrcIndLwo0DUmN70bXB2sWFslHOk=;
 b=MLLzy79Lc0JdGbxSk95Daq9YyRcFZhIGtDCeo1SmSPRy31v+EjaeTwjgpfTRDDu6qU
 LVD0zAnDrjfce0fPQ9HZraN1CGCJ0XnVrCc2/+frkMxYWIY0Bsw+CBMtfy1R2nlcOqSN
 6LwuoDYqSd3LfYWTsn+ofBgbjh1HvPjm1OnVdY91YcDcqPCkpDKpoznrc3PYPL0BOp2L
 x4lbybsts3jxSvhT/n13a1sd9r5tk81nuE3uP8f4WcdIYw932qDfKMsv9FDMxlhDS0OJ
 NK/DGOkqLfORJhx+kJvHb3WfHq4ePxZ1EadWm3GBP9AbMvTZh1BichLuftPhmK+ZqdJw
 /iEA==
X-Gm-Message-State: AOAM532Kb83Lh6rkR0aFm5SPlSpaLUuT32Cx02o6cuBwubpl0+1dS24T
 e7MD0vu9KySNjK4vUq3cGa9tVb0QGj8=
X-Google-Smtp-Source: ABdhPJwP7zltm3ArpzQIspT7vqdtpmsGr+eUheO6zFc7IftXzIUHuCABd0FmfCHiIODG0bQ3x9S6eg==
X-Received: by 2002:a17:902:8bc1:: with SMTP id
 r1mr1960303plo.328.1598897888174; 
 Mon, 31 Aug 2020 11:18:08 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id y128sm8672547pfy.74.2020.08.31.11.18.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 11:18:07 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v8 0/7] IOMMU user API enhancement
Date: Mon, 31 Aug 2020 11:24:53 -0700
Message-Id: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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
https://github.com/jacobpan/linux.git vsva_v5.8_uapi_v8

Thanks,

Jacob


Changelog:
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

 Documentation/userspace-api/iommu.rst | 211 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 drivers/iommu/intel/iommu.c           |  25 ++--
 drivers/iommu/intel/svm.c             |  13 ++-
 drivers/iommu/iommu.c                 | 205 +++++++++++++++++++++++++++++++--
 include/linux/iommu.h                 |  35 ++++--
 include/uapi/linux/iommu.h            |  25 ++--
 7 files changed, 470 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/userspace-api/iommu.rst

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
