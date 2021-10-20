Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEC2C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 00:08:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72A9611EF
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 00:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B72A9611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ixit.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C2FC40177;
	Thu, 21 Oct 2021 00:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MwtuOrKcfhSY; Thu, 21 Oct 2021 00:08:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 17BD2400E1;
	Thu, 21 Oct 2021 00:08:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1BDBC0011;
	Thu, 21 Oct 2021 00:08:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15789C000D
 for <iommu@lists.linux-foundation.org>; Wed, 20 Oct 2021 23:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F29B560BC4
 for <iommu@lists.linux-foundation.org>; Wed, 20 Oct 2021 23:25:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ixit.cz
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0D-PUzMKsngd for <iommu@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 23:25:10 +0000 (UTC)
X-Greylist: delayed 00:07:58 by SQLgrey-1.8.0
Received: from ixit.cz (ixit.cz [94.230.151.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9669560BC3
 for <iommu@lists.linux-foundation.org>; Wed, 20 Oct 2021 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz
 [89.176.96.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 94411236BE;
 Thu, 21 Oct 2021 01:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1634771826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=997v4bghoI2OwZJOdMtQH10QCmvL+vjH9bUCFTSkQXU=;
 b=vrtBpxB8fdof2H90vp1/UQ3IHSJ2NehNBvsM4Szb8jiBPXEwJN0am0ZaMwHqX43I41IEJs
 dFqovI5BC0J4f/IS3tDMR/5b+4l+nqFdhQMnlh3QHpICdGGP8A0Ha/E3LrJ9t6uSTRT449
 64L2RkiuJSnF3qwcN3tcLMA/fzCw894=
From: David Heidelberg <david@ixit.cz>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] dt-bindings: arm-smmu: Add compatible for the SDX55 SoC
Date: Thu, 21 Oct 2021 01:17:00 +0200
Message-Id: <20211020231701.278846-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 21 Oct 2021 00:08:39 +0000
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Heidelberg <david@ixit.cz>, iommu@lists.linux-foundation.org,
 ~okias/devicetree@lists.sr.ht, linux-arm-kernel@lists.infradead.org
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

Add missing compatible for the SDX55 SoC.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 03f2b2d4db30..5ccf0025ffa9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sdm845-smmu-500
+              - qcom,sdx55-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
