Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC6BC43217
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:20:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5D361A6F
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A5D361A6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E39B606F2;
	Fri,  1 Oct 2021 14:20:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7kyrLLHAsC0B; Fri,  1 Oct 2021 14:20:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 22826607D8;
	Fri,  1 Oct 2021 14:20:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50AFFC0027;
	Fri,  1 Oct 2021 14:20:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23BB6C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 13:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CDFE614CA
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 13:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gJBryeelHeSe for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 13:49:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48EDC60604
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 13:49:56 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 a131-20020a1c7f89000000b0030d4c90fa87so1583762wmd.2
 for <iommu@lists.linux-foundation.org>; Fri, 01 Oct 2021 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=YIf6Rv5U5rLBxZR1wkJIP6+YB2q/3igVhhZVWCzzQAI=;
 b=q4iTyIqFrBdfhb6tROekXeq3O/9j+zeQdMJ9tfF2MjhpZYcmKKfXwcP93UdnV/+kaS
 VkcX2HF5gyRhsfJLc1nAOy6Ovlp7sYcj1vYPu+YQuqa5FiiUZZ4s6SaKCCPmfqSUq1LW
 SvpPsjB8pI118oAzLmB/Y0uUJQbxCM1DpdBUzqenOEjhHoGdkDaG4yXmyuhYZpq/2ZnE
 npZRgt5M1zZVOEWGGn1OHsSqwEfLwuwtvm5lPd1iBW4Gz7DZKzrFPVRQQu1M8ymugXjc
 Hjxzg0xqDrWYdbusTqHU9wMdHWPFqCl08eAt2SiCbieqgPoGXJrF+kjjmRkLnncX8Ynp
 dv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YIf6Rv5U5rLBxZR1wkJIP6+YB2q/3igVhhZVWCzzQAI=;
 b=e/k2hqmusiujEgGbg2SVQPJZ7WEjgmkR79qMxzdGpkwViGcFbRt4OzDkOABeW9QWx2
 YSf6baJsLYFkmcVJXsNeyk0r22Uw1XM/AYkjkQXMwqYcJNkPHCGKXPi74xTEHYK0+1/n
 sOvKR8Dtt5LBVMGz9vkHcVSdsxpDvd1rFfN8JckPbDXBCg3dgzjhaEE8Bu+YvCIzfQjw
 c2R3FYZiPBfuvR9hnUhp+Fz9Fw8DmTEIbsqHD0BH7fYp6GA0bWo9hItmHTS7fEoCEtkr
 CFmoBQKD/m3X1IQmScXruv8LhL+XXt1sEVUG0SW4yDNkD5TmBQEYRpjdQyC6C6gFJVo7
 Gfkw==
X-Gm-Message-State: AOAM530ypO97hAQ/6tuyi1kaa/X7pWN3vaPvqeZlf06s6gidyavkuB30
 j126MLEKi//gItyNG6Uxr7YCdg==
X-Google-Smtp-Source: ABdhPJysr8rAAwvbm9P36j5GMkqhmzMtNZlkDoctNG9VDQUHLIzeDfKXIH/uVkiobQ0Q7C82vd5vOw==
X-Received: by 2002:a05:600c:35d0:: with SMTP id
 r16mr4570013wmq.26.1633096194289; 
 Fri, 01 Oct 2021 06:49:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:426:4b95:c465:7a47])
 by smtp.gmail.com with ESMTPSA id l11sm7471658wms.45.2021.10.01.06.49.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Oct 2021 06:49:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@linaro.org>
To: will@kernel.org,
	robh+dt@kernel.org,
	joro@8bytes.org
Subject: [PATCH 1/2] iommu: arm-smmu-qcom: Add compatible for qcm2290
Date: Fri,  1 Oct 2021 16:00:31 +0200
Message-Id: <1633096832-7762-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Fri, 01 Oct 2021 14:20:38 +0000
Cc: devicetree@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
 iommu@lists.linux-foundation.org, shawn.guo@linaro.org, robin.murphy@arm.com
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

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 55690af..d105186 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -412,6 +412,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8150-smmu-500" },
 	{ .compatible = "qcom,sm8250-smmu-500" },
 	{ .compatible = "qcom,sm8350-smmu-500" },
+	{ .compatible = "qcom,qcm2290-smmu-500" },
 	{ }
 };
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
