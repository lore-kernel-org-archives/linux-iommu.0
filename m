Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63DBC4332F
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 07:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5655780FA3;
	Wed,  1 Dec 2021 07:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZRtpSFZ-5TZ; Wed,  1 Dec 2021 07:40:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6616880F7F;
	Wed,  1 Dec 2021 07:40:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36D2AC0012;
	Wed,  1 Dec 2021 07:40:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ABC1C000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 07:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25A9480F3B
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 07:40:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OkigXXbEE0ku for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 07:40:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E64480F47
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 07:40:02 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 95C96B81691;
 Wed,  1 Dec 2021 07:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDC8C53FD2;
 Wed,  1 Dec 2021 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638344398;
 bh=hR6uODSSw97kZgq/T1oJExxGLZlH/ku0xAQ6Ys0Dbf4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IvP6WIbUXo5u5nfVooLIjWp03lxeC1ftv1hpmNGNjYMv7CwpCEJQ4JfXP1NVTqj9H
 TqDnKGrhRT9yfOVz/AV7i2MSAryp2xKsSNjhdIMr3RHrEug47s88MyTxpFBXnB85+Z
 mrLVQofA4ucmk1ln14euWdU7OCS3mnv7G2qB2SvwsGo0ImVr8QiY8Ro8axhkFp0tai
 ygbJCODloVb19I7RTkG4LwnuQ93oSORBtTLE4GjgsmBEggWbAhK1up4kjV0AT51RA7
 FEfpZLfb37FgF26Vley4ck8aiw3h+w5riIeWSwX2Snt8HuUbrn/kZeQTvQ/a9IxTQ4
 jSuDpYKRm92IQ==
From: Vinod Koul <vkoul@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for SM8450 SoC
Date: Wed,  1 Dec 2021 13:09:42 +0530
Message-Id: <20211201073943.3969549-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201073943.3969549-1-vkoul@kernel.org>
References: <20211201073943.3969549-1-vkoul@kernel.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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

Add the SoC specific compatible for SM8450 implementing
arm,mmu-500.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index f66a3effba73..8d15b281b0ac 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -42,6 +42,7 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
+              - qcom,sm8450-smmu-500
           - const: arm,mmu-500
       - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
         items:
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
