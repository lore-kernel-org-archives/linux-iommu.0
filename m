Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9162EC47423
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 06:15:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F90206DC
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 06:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVOALg2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F90206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8E48D204E9;
	Fri,  2 Oct 2020 06:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58dcrdquG2WS; Fri,  2 Oct 2020 06:14:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 97051204D9;
	Fri,  2 Oct 2020 06:14:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87D36C0889;
	Fri,  2 Oct 2020 06:14:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF1DC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 06:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4A18E872D5
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 06:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L7TBu6mgEGKW for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 06:14:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C3941872C6
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 06:14:56 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id b17so227939pji.1
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=2q/oTmH3kZ+Yc6Epzks1Kzv6rqnQJPyOrzwLjdgg9AQ=;
 b=lVOALg2vj/xq/3vCp/mo596ub/QGT+sIQ0KD29J1NAc4VFcPdOCg4OXTsz4OUpRkCp
 rAZffe2nOlwBx1Uz5t4RZQmJ9rC+CDkJhirIpB3EFHmLDEQp9Ur7MRDtR0/SQOj//XCK
 u8UhM3TE64ENOQI/pxQQMp7EfiQ9mFpNxwIpXnsUB44lj1XtlkrS/mCoiS79gFyO7Sel
 /33QvQAC6RQpwHGlNUHwqAjabxD8g9fNloJMZc9qv9YpcsURx3w9KYnJ88ejGaPKNZeZ
 rzWQZGgpbIrIt+tIVmfdDO2I8litrGVkhj3sqYz/AY1N5V6Nj8kVgKsm6ajcFYTh5rXF
 NEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2q/oTmH3kZ+Yc6Epzks1Kzv6rqnQJPyOrzwLjdgg9AQ=;
 b=C9lwMgoa7ysBiEVKqhcJT8Ci9Rt4nlggYbobSLvos4pgSPkHMr1DZfgenZ+GEn1Oiu
 ZC72/sLFsEgFY4EHSdOCip1WH+CW9hnUHkt0eQ6CAYsi+ANbtkb3iFeMwfoid37B0gEa
 xBLPaZi06HLXMX39U4klkLvY/3xq9LtWCKBkW+Qw7tmQFUf9El60/bgyGhr3OLj+L9D0
 tGF/ZjfGLrBBhidJQp6FvGccYt9AZBtH2O3jCWkdXNGty05lcOskB7G239gOM00tLgDg
 u+w2rKItU9NFUHix7sf4u4pk/3KmmOkW3pKk5VqQPLOup9ibD86K1mOlQpoClgoWwdW2
 dwYQ==
X-Gm-Message-State: AOAM533i44tVnjp+Ijdu9Xuov6p2citzopW3ikcYPV+XEO1MACPsEBn6
 NhsX9q0R1m/DEOXJquSYPXA=
X-Google-Smtp-Source: ABdhPJzjDlu8UeoudA4M3CFxiBY+oelv4pMVn67m1p3wD5j0WECnIVyr2j/P+hFe5sV6sn2yzDBbUQ==
X-Received: by 2002:a17:90a:f187:: with SMTP id
 bv7mr22770pjb.198.1601619296301; 
 Thu, 01 Oct 2020 23:14:56 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x4sm577429pfm.86.2020.10.01.23.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 23:14:55 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	digetx@gmail.com
Subject: [PATCH v4 0/3] iommu/tegra-smmu: Add PCI support
Date: Thu,  1 Oct 2020 23:08:04 -0700
Message-Id: <20201002060807.32138-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

This series is to add PCI support in tegra-smmu driver.

Changelog (Detail in each patch)
v3->v4
 * Dropped helper function
 * Found another way to get smmu pointer
v2->v3
 * Replaced with devm_tegra_get_memory_controller
 * Updated changes by following Dmitry's comments
v1->v2
 * Added PATCH-1 suggested by Dmitry
 * Reworked PATCH-2 to unify certain code

Nicolin Chen (3):
  iommu/tegra-smmu: Use fwspec in tegra_smmu_(de)attach_dev
  iommu/tegra-smmu: Rework tegra_smmu_probe_device()
  iommu/tegra-smmu: Add PCI support

 drivers/iommu/tegra-smmu.c | 177 ++++++++++++-------------------------
 1 file changed, 56 insertions(+), 121 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
