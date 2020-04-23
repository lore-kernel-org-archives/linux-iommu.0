Return-Path: <SRS0=eKRE=6H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4003AC54FCB
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 12:55:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083EA2077D
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 12:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFnqmzSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083EA2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2A2087D93;
	Thu, 23 Apr 2020 12:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7j5C9Dbc2cI1; Thu, 23 Apr 2020 12:55:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5DCCF87D86;
	Thu, 23 Apr 2020 12:55:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44209C1797;
	Thu, 23 Apr 2020 12:55:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18E72C0175
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 12:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0793487D86
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 12:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rFsUJ7MUX4S8 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Apr 2020 12:55:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 173E787E25
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 12:55:08 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id x17so5978301wrt.5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mAtotZb3HoQP8At/R7JCcCdnVqt/Uy4yJMzlNbA6wSw=;
 b=zFnqmzSQ8aKGWEpx4L3tsEp4ceQKvpgUmWkWGIvrVqXEKuhpzbNFQ0D/+C2DL60zV0
 auMppdPN/kSk6N/tlIIJm8ixqSkETT+5/TdaAnE1/62v3BvP10M+Sk11P0oOr4228QPE
 2Oeau9auSNgChG5FsmdZDwMUw1nA/R/BZkWrK5dNxmPWFc94xKlHqpKbzLT5C2O35mMR
 rOaR6jqrcM1j8mnS1qef17LkDtCQyAdbvyIeZr1K4o/g2IOD0amYATmmdMeDUOyA30Wr
 /3URvrz7rEsj2cKJ0wAQN9DKjk3ZOBcRT34+645+3vsBR0oXyw52WhJyTwvpT19iByth
 m6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mAtotZb3HoQP8At/R7JCcCdnVqt/Uy4yJMzlNbA6wSw=;
 b=HKBemKsckRHKF8/lJy6cd85VF3wI8o8bjF9fBy7cJy91s69n5DDn/ZLYANn7agF5Zo
 9HtMLM2SA2byhTKCGFLStkaJ6d+okj/LK+BVHXgCoKN6dtvV1n7HM2eTGLdT1uerR7HK
 6hyn12FE5NZpgpsHvEYYCr9Nh0YvsU8MuRZVou96X4iYiJQfa9WPnqJEIeUy9J4hPGHw
 z8TGppl6ZZXf4bldxYK1PED3YwcqaLkG30EtrieNEWnNtcP3xT3RK0rd9P6P1IWhAgN3
 U6Uff/4ukVyMh4U7QhXDWMnxyT8uEnCz5h/bemYiLOp1UyfIBp4v1wXvpQnAtJ3cDkxi
 ZWoQ==
X-Gm-Message-State: AGi0PuawL2yB1Ae7I6lPmyf85mJUtmXXpZceH14mQzcODFXMDgd/8w4h
 4oWaKxPbeMA727GzBkr/+ab/ehBoHJ0=
X-Google-Smtp-Source: APiQypI992fAlnfE9gAL9VSb2ij4psvSU4IQfwpqYewJWV/vtiG8G9sxYldPF6T5wN+5yVfR36iqsw==
X-Received: by 2002:a5d:6b89:: with SMTP id n9mr4882307wrx.356.1587646506137; 
 Thu, 23 Apr 2020 05:55:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x23sm3482784wmj.6.2020.04.23.05.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 05:55:05 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-accelerators@lists.ozlabs.org
Subject: [PATCH v2 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Date: Thu, 23 Apr 2020 14:53:27 +0200
Message-Id: <20200423125329.782066-1-jean-philippe@linaro.org>
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
release() notifier might cause synchronization issues. Device drivers
must in any case call unbind() to remove their bond, after stopping DMA
from a more favorable context (release of a file descriptor).

Patch 1 removes the mm_exit() callback from the uacce module, and patch
2 removes it from the IOMMU API. Since v1 [1] I fixed the uacce unbind
reported by Zhangfei and added details in the commit message of patch 2.

Jean-Philippe Brucker (2):
  uacce: Remove mm_exit() op
  iommu: Remove iommu_sva_ops::mm_exit()

 include/linux/iommu.h      |  30 -------
 include/linux/uacce.h      |  34 ++------
 drivers/iommu/iommu.c      |  11 ---
 drivers/misc/uacce/uacce.c | 172 +++++++++----------------------------
 4 files changed, 51 insertions(+), 196 deletions(-)

-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
