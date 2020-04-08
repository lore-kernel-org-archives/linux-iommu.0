Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45D2C2D0EA
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 14:28:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7952C206F5
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 14:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WI5DnnOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7952C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 48B8E87D33;
	Wed,  8 Apr 2020 14:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iw0jJ+yT+qpx; Wed,  8 Apr 2020 14:27:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B49E87B18;
	Wed,  8 Apr 2020 14:27:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73183C1D7E;
	Wed,  8 Apr 2020 14:27:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B760C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 14:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 91CE92226B
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 14:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XIyiZc6ZAkHM for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 14:27:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 49DDD20762
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 14:27:57 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id n17so7793712lji.8
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a12j7R0Z2EPaNYDW7mpuMVOpfAzUryY1hyhNZySOfSo=;
 b=WI5DnnOj79ItETEYi2puTp+SVmuj39uOzJiNj6MBMoTV0Pb/PVuB973hjVe0Hh1cfS
 XT/NC25FNR/LVuUBwqfP65gaV2vftLrxioi/w/Q/6Erd674i5TjiLlsHOh3lxaAl2yvT
 Gh+/6oDwnsz2Jyz2AqhL3jyjSznsdSEhNHh1UhDsWEwDT6ORo3lCDPl2InESKZs6BSuZ
 OVZxI4qo4zIavenk+ilzV83vlM7PXIZO6cZzVzJeyc7muHD0+4d02XOuMuGeSCZp+TMD
 w3uNZfgqcKgkgDIPVOQ8DBE8M8lRC9sDxNf8pKE2CquOi4H3G7kXv/CG9nH9M5UNNg8X
 LcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a12j7R0Z2EPaNYDW7mpuMVOpfAzUryY1hyhNZySOfSo=;
 b=BaJQm4Gcfd8tJVl2D2lIsGVJN0X1s8vaLxxKaeAjrWy/bf2EjKEfRPoj6K7ARv4goT
 Y9uqDb8jg885qwVc0wUJqgyfu7hAHMX37vkCuS+zzAiYuBOHANAig5yy+IElSVdY+pXx
 Pho4L92832j8asb8eRggTbqkfmKcMjxFCJGZ1F3DfxLnZjND15dyBM7cALM2MBYGAh+E
 p4zetD7Oo6S1tw2HctARDKaDWQS62e3F3ncKcBBQ4DqSO5qRPadJ6dlJYeEZxDWVuWO7
 ocEZDgSZpVaQU8WkBP1hGt8PnwkLJ3U2eKx9ZCr7wmKcsZghxejgwotc9CixaZTeREFk
 5Evw==
X-Gm-Message-State: AGi0PuYkO/vcpuSZKzmcsJuEAj7JOKdxrMA7eactINPLXubKsNy1oWYn
 Ip6XCM9EaE7kMemR9tu12vkS19HU9KfhxA==
X-Google-Smtp-Source: APiQypLqHUZpAbsE8S4L0cjXP07wH/BR3cxsk2OQ9vWKHZRavd7i80DBpesJ2ckwxRIfS6gEFzuCgA==
X-Received: by 2002:adf:ce83:: with SMTP id r3mr8721264wrn.419.1586354783388; 
 Wed, 08 Apr 2020 07:06:23 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h2sm6788351wmb.16.2020.04.08.07.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 07:06:22 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-accelerators@lists.ozlabs.org
Subject: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Date: Wed,  8 Apr 2020 16:04:25 +0200
Message-Id: <20200408140427.212807-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, arnd@arndb.de,
 gregkh@linuxfoundation.org, jgg@ziepe.ca, zhangfei.gao@linaro.org
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

The IOMMU SVA API currently requires device drivers to implement an
mm_exit() callback, which stops device jobs that do DMA. This function
is called in the release() MMU notifier, when an address space that is
shared with a device exits.

It has been noted several time during discussions about SVA that
cancelling DMA jobs can be slow and complex, and doing it in the
release() notifier might cause synchronization issues (patch 2 has more
background). Device drivers must in any case call unbind() to remove
their bond, after stopping DMA from a more favorable context (release of
a file descriptor).

So after mm exits, rather than notifying device drivers, we can hold on
to the PASID until unbind(), ask IOMMU drivers to silently abort DMA and
Page Requests in the meantime. This change should relieve the mmput()
path.

Patch 1 removes the mm_exit() callback from the uacce module, and patch
2 removes it from the IOMMU API.

Jean-Philippe Brucker (2):
  uacce: Remove mm_exit() op
  iommu: Remove iommu_sva_ops::mm_exit()

 include/linux/iommu.h      |  30 -------
 include/linux/uacce.h      |  34 ++------
 drivers/iommu/iommu.c      |  11 ---
 drivers/misc/uacce/uacce.c | 171 +++++++++----------------------------
 4 files changed, 50 insertions(+), 196 deletions(-)

-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
