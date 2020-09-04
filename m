Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C9BC43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A9B2074D
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZadVWzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A9B2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2EF2A86EC0;
	Fri,  4 Sep 2020 15:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3BCtOzTDEfOT; Fri,  4 Sep 2020 15:55:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AC88186EB3;
	Fri,  4 Sep 2020 15:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91EF5C0052;
	Fri,  4 Sep 2020 15:55:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1467C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 84B3F20357
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gqXplENrw7ow for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 15:55:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 8269E203AF
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 15:55:16 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id o64so6696784qkb.10
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4q/8n4d9Oz9Vv/K5aJK8Mp8Y2lRkWj0qSrttp/CroxE=;
 b=oZadVWzKzjT6kVlQDdSaTMxHoRTYYXuhfeHAqu6JmmOp3XCU0blzfKn1tJhWzX2HeS
 sK1QUgw4eOALlLrqiIa5mJ5RjG5DDMC/GfAoKvUlju9deCt1Z1cQt3mFi6Jp8dh8eAcL
 b47lB644qnhBgKdHPTa65f3vcbqa8pR/OGmGhW1uCRNIq0IP9XUGZp7dua1GTQzH7pbj
 3kOSW84l/lOtcT1dCSPEMna3Qn0g0ssFDfacD5B1snlLor1iC7Zmm6UoHviENlQKr4s3
 lC89jtyARRDB8fr0n/NnuYQLdQ/YywQuWqkj40BnJg+qClOjhyEKiVWTZ/r3SCq8UT/u
 +arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4q/8n4d9Oz9Vv/K5aJK8Mp8Y2lRkWj0qSrttp/CroxE=;
 b=Xif95LPJVdOs3slCQZ6mFaRhJCz0MdZL9lvVbc0fQZK9D5hTNKFDJ6Tnq70d4Ph0G7
 saEEtdP0FankhOWFVodHXG6gCmqeIiLCon+EHj6ERINbrkrR7RTm3yvkytad/CJvin2c
 bHzuMbyKGS8Rn1SfT9irhmSMiiwqwJ9+IGoX3lD186i0bZe5gdWL1h7GNi2F+L3uTMYn
 abaylM5WdEO9e4AqN4ETu4wdU/rTGnIvTRR2Zdpcb2lBAC9W0En+KmdzeAhioYIBHZG8
 YjatJ20zjkWwanjRiVELYWxKrJD+j9XXC/JADfzqED+PDxdFcbfvhYrvK/tKdN5rr4DE
 vKAQ==
X-Gm-Message-State: AOAM533dx/aOYk9P0FBHpW8yqVEoO3+8h9/Fun0xCm9f2RFP/1zd/pow
 13+d6U5+rysc392KyO0JgsVXTw==
X-Google-Smtp-Source: ABdhPJxHXnDF5Yz7KMj3dP1Wot9aBwDE24PK5PObq0P6DKGWMzJC3jbF9SemUpoG0/uTgsf96ikT4Q==
X-Received: by 2002:a37:314:: with SMTP id 20mr8208333qkd.274.1599234915063;
 Fri, 04 Sep 2020 08:55:15 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:55:14 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 0/8] iommu/arm-smmu: Support maintaining bootloader mappings
Date: Fri,  4 Sep 2020 15:55:05 +0000
Message-Id: <20200904155513.282067-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

Based on previous attempts and discussions this is the latest attempt at
inheriting stream mappings set up by the bootloader, for e.g. boot splash or
efifb.

Per Will's request this builds on the work by Jordan and Rob for the Adreno
SMMU support. It applies cleanly ontop of v16 of their series, which can be
found at
https://lore.kernel.org/linux-arm-msm/20200901164707.2645413-1-robdclark@gmail.com/

Bjorn Andersson (8):
  iommu/arm-smmu: Refactor context bank allocation
  iommu/arm-smmu: Delay modifying domain during init
  iommu/arm-smmu: Consult context bank allocator for identify domains
  iommu/arm-smmu-qcom: Emulate bypass by using context banks
  iommu/arm-smmu-qcom: Consistently initialize stream mappings
  iommu/arm-smmu: Add impl hook for inherit boot mappings
  iommu/arm-smmu: Provide helper for allocating identity domain
  iommu/arm-smmu-qcom: Setup identity domain for boot mappings

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 111 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 122 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  14 ++-
 3 files changed, 205 insertions(+), 42 deletions(-)

-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
