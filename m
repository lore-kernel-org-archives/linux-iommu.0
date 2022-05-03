Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD632C433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 16:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58FA141655;
	Tue,  3 May 2022 16:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cqc4LEyymVEj; Tue,  3 May 2022 16:32:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CFB04410AE;
	Tue,  3 May 2022 16:32:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93369C0032;
	Tue,  3 May 2022 16:32:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15BEFC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF6E36102C
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apZszEFVcQyo for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:32:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 561636102B
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:32:47 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-d39f741ba0so17682063fac.13
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jp8Z/hUeLP23KvvSUAkBlWhJEZRAAaKOAZwprobHvBo=;
 b=ZWNTtDvt05fyhSOqHVAlqD562SO5r0AjFz08VS431jt2+vWW4mV6o8/q4xujLAqptP
 E/8fYNIuddQGoanfU6R90qJA8YSRndiRv+9f0k6g4Rf0LFlmT55Isdb5U3hLfG0OG6/O
 e2yowjegUn0jUc0Kt7sE2u7vOU9TJcyZT3HvjlMFphSpN1tPJvpURJ2EeSv1jYwaAjeO
 Pj7KJ/RfNa0CmmZygAVZn8ZfSoX1YNK2NE6iOmGBkFEDtwqg6KRLQMX3xVDOrcHTcaOa
 lSQQijHxSSfKK6xbqci9QWCksqS82afezFNqGgWnZAPb0LcuKYM+aUT840WFeRSZ7VyW
 3Wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jp8Z/hUeLP23KvvSUAkBlWhJEZRAAaKOAZwprobHvBo=;
 b=F7LmiFpI6lINEuBNs6mOCerz04xhkTpWQqsveg3DSLWKsYMN4vVkOEhlx02HmZDThk
 hb63yVIG4cVsEBBURuCyxR0df8VvyVhBhn2umH5OszeCbIHuE7e/w0bnKWR+ms9PP0Ow
 m3LwX4pALINTzLgJke9WvrFfZoqaQWtAq332z+ErYfHHyWl+ih8jmqE6s6eoIYxbGeOg
 09/8wqD6C9MtdVbkRWTOE3ZyUtXeRdPtj8rC9OfzGWmA9nJ0bJ2m67TpMahrhKfqDOzB
 1xUHluWukBe6D49SqG3KKdRJT/yPmaDHE/hAnJ79R4vsq+ljm0NI/8M+SySlN0KFmzPm
 yGeA==
X-Gm-Message-State: AOAM5315E2dVlv71u0GRmbpBhPKJ8TLgEC/46QE+dafrc4ZQ9yEbHY4j
 9NXd2kANGFx2lfrehij4YNxQAg==
X-Google-Smtp-Source: ABdhPJwReRtrO6xB097gOrPSYR+neB6cLjmKw2HS51B9RII40zRWisxMt/uRLJTu3w5yH67xiBwsDA==
X-Received: by 2002:a05:6870:a2d0:b0:d9:ae66:b8e2 with SMTP id
 w16-20020a056870a2d000b000d9ae66b8e2mr2021333oak.7.1651595566241; 
 Tue, 03 May 2022 09:32:46 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186]) by smtp.gmail.com with ESMTPSA id
 v15-20020a4ae6cf000000b0035eb4e5a6cdsm5027404oot.35.2022.05.03.09.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 09:32:45 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for Qualcomm
 SC8280XP
Date: Tue,  3 May 2022 09:34:28 -0700
Message-Id: <20220503163429.960998-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503163429.960998-1-bjorn.andersson@linaro.org>
References: <20220503163429.960998-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Add compatible for the Qualcomm SC8280XP platform to the ARM SMMU
DeviceTree binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index da5381c8ee11..ba38ce054062 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sc7180-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
+              - qcom,sc8280xp-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sm6350-smmu-500
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
