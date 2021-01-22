Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D404EC433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 15:15:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8268223AAC
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 15:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8268223AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 12F348738A;
	Fri, 22 Jan 2021 15:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5xAZwyW3x6Kj; Fri, 22 Jan 2021 15:15:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82045872E4;
	Fri, 22 Jan 2021 15:15:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 715A3C08A1;
	Fri, 22 Jan 2021 15:15:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53CC3C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 15:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 42081872F2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 15:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vq+Rwy6X9qKz for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 15:15:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 52AC3872E4
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 15:15:11 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id c12so5422390wrc.7
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 07:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=69jBLNDQCDih7BbYaZQUyDgS1+kzJvyef3wrHErr4Jo=;
 b=zyIFN2OmMm+dEmbCYUY1wq7s6Zy/8eC9VnEqnPUz+6uGZZu7NM/axQ7coBt5inaDy7
 dSHnUmoqK2Aqp1tNsEc003zvLiCjNRpXYPeNB9lvB6ZPxsYta545PQIUHLxFjTulB3jQ
 o8ExiyiQ/rqnjmNzfEe1XLpq/eb2OaGnEYxld55zGVigINDXERH6fSNLYdDcgWjzZTzn
 JP7mPKli961WTJhX/s5NpfvadZOx78BOhVljnyU9TiD8J0VXt4P4cy7tj72gcG2DIMhf
 bPwuuezkPDOnqHc9ToBcd8y/cTYJlvrrAayVzoff2H6j3hEAMPt69kWQ+bZkddJ+LzbS
 v7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=69jBLNDQCDih7BbYaZQUyDgS1+kzJvyef3wrHErr4Jo=;
 b=K4zDNILE2vbHMNMUoKmZvxSnNP4LPTMgAmkn/66atrQFxhwGamgk+l1seE6d0AddV4
 zrq6oXaCjMLbP2tWuslXIWwD9m1iMduPdqMbnE817sTTWPSSEwR62D9mtcN19DXGScTc
 kXpdttBBbHTkkG6ggP0aRw/mW2unDmFzAIrkal2uPkaPFfBnx7GefQPZSopMTawwNiVL
 Vwr2BJn02LvYm1V1vPQ6F8nKGp+OmwT2yA6UZWgzhsFW6ipxJ9hvPFIJlrbtiZhSMP37
 +iFHV9nFeVmsaV34lHfIz28hHpK7SxH9kjy7ZaZJuil5DXwjryitEQaSg7n2aKc8eDTG
 lJuw==
X-Gm-Message-State: AOAM531cKElwPOFlWkwx73ng5rUDyTE/5n/i9iCv9WAOp4zJfA2SPrLH
 VdXO16sw3Z8IxvDF7+CkumJxvw==
X-Google-Smtp-Source: ABdhPJwESn3gG+jfg7U/Om8rYxxXFwuePy1Y1K0jVZLgP2kh/U4ERKodFo7adoXxRPaMyBD8jtgwcw==
X-Received: by 2002:adf:fa02:: with SMTP id m2mr4883994wrr.130.1611328509895; 
 Fri, 22 Jan 2021 07:15:09 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h1sm9001945wrr.73.2021.01.22.07.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 07:15:09 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: [PATCH v2 0/3] iommu/arm-smmu-v3: TLB invalidation for SVA
Date: Fri, 22 Jan 2021 16:10:53 +0100
Message-Id: <20210122151054.2833521-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, vivek.gautam@arm.com,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 linux-arm-kernel@lists.infradead.org
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

Since v1 [1]
* Renamed arm_smmu_tlb_inv_range()
* Removed unnecessary tlb_inv_command variable
* Rebased onto for-joerg/arm-smmu/updates (oddly I didn't get any
  conflict, I hope it will apply this time)

[1] https://lore.kernel.org/linux-iommu/20210122115257.2502526-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (3):
  iommu/arm-smmu-v3: Split arm_smmu_tlb_inv_range()
  iommu/arm-smmu-v3: Make BTM optional for SVA
  iommu/arm-smmu-v3: Add support for VHE

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   6 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  10 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 106 ++++++++++++------
 3 files changed, 87 insertions(+), 35 deletions(-)

-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
