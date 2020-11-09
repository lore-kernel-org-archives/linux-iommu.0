Return-Path: <SRS0=JucZ=EP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64126C388F7
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 18:47:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BB6206E3
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 18:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="EEeT1Ef0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BB6206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 70437861A3;
	Mon,  9 Nov 2020 18:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sujafDebDm06; Mon,  9 Nov 2020 18:47:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F68D86190;
	Mon,  9 Nov 2020 18:47:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0320C088B;
	Mon,  9 Nov 2020 18:47:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 103FBC016F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 18:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F0C1E8723F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 18:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JHG5OBIAcHMC for <iommu@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 18:47:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DA10C87286
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 18:47:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1604947675; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=6UrsemL2jWeeyuPw8ChAxb9oFLES8IbOgLxwjsSBSbU=;
 b=EEeT1Ef0mTl+z1ocugR/Hh09SjGOQGGPPoU+4xBQJ4nEvCdMEXCp68LhguhJOcnvK3inmCai
 zEnHKTlKWJL4Xgd/l5C5fGJZBhIZE8cf7yK8tY5SsAUHveWasvipLIXiHHSow8BGw7s3JkWO
 9DnUvFNQJMl3rDcfRQT96qASWdM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fa98ec818b2aa4b1fa5861d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Nov 2020 18:47:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 3DE34C43395; Mon,  9 Nov 2020 18:47:36 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BAE1C433C8;
 Mon,  9 Nov 2020 18:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BAE1C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v19 0/4] iommu/arm-smmu: Add adreno-smmu implementation and
 bindings
Date: Mon,  9 Nov 2020 11:47:24 -0700
Message-Id: <20201109184728.2463097-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Hanna Hawa <hannah@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

This short series adds support for the adreno-smmu implementation of the
arm-smmu driver and the device-tree bindings to turn on the implementation
for the sm845 and sc7180 GPUs. These changes are the last ones needed to enable
per-instance pagetables in the drm/msm driver.

v19: Rebase to kernel/git/will/linux.git for-joerg/arm-smmu/updates to pick up
     system cache patches and devm_realloc() updates. Use a function hook to
     modify / write sctlr
v18: No deltas in this patchset since the last go-around for 5.10 [1].

[1] https://patchwork.freedesktop.org/series/81393/

Jordan Crouse (3):
  iommu/arm-smmu-qcom: Add implementation for the adreno GPU SMMU
  dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU
  arm: dts: qcom: sm845: Set the compatible string for the GPU SMMU

Rob Clark (1):
  iommu/arm-smmu: Add a way for implementations to influence SCTLR

 .../devicetree/bindings/iommu/arm,smmu.yaml   |   9 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |   9 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |   3 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    | 164 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |   3 +
 7 files changed, 189 insertions(+), 6 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
