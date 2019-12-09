Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA51C2BD09
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2712467C
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tts/uxwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2712467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1BDEA877A7;
	Mon,  9 Dec 2019 18:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hi8Pj0TAStIU; Mon,  9 Dec 2019 18:12:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AB80F8777D;
	Mon,  9 Dec 2019 18:12:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99818C1796;
	Mon,  9 Dec 2019 18:12:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F18CC0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7BED887C76
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ebyRQEHZ08eZ for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 18:12:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B03D187C20
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:11:59 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id d16so17240187wre.10
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KOPwmsVGim8uksddBYEL5Xr/XEk+fQ6sygiouqBeFpU=;
 b=Tts/uxwAulwDWx38JQ7vQN1vchjW9BMQPwqFcz5u8er0ybt0fOUvBHt+WEAB24gXyc
 BlO6xJwA59upCQs0IseN693yMmNMgDbbFgWrWiT8ZWofkwrA7Seq9O/D4Gx//cyDdaGE
 /guIbq5MoYH70/5n63vUCderClZlhJs3YBa2U9WpDRuoNG3S47hAE8+Ww4p9KU6i+ziJ
 sceo5n1ghS7WbisS3mMyOWUi5Kf2+viwAkPdhnJOYSbUXUfLBHgRWi46jnVUHnae9E52
 Wr8TWOQ6BMPwQ+bvP0D1ypo0U6Cun3Y1noijEKy7UPoDC+Idhr8iP2SN8THAoGBBnKww
 bVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KOPwmsVGim8uksddBYEL5Xr/XEk+fQ6sygiouqBeFpU=;
 b=ERUgXtmL8/ZBjJe/XzUmMaY0jl+TZszjjQL5X73PBgpQk1DyZTts0N7XEyHWeie63x
 Bzhn4TfUHPCtsxS4ZOdgYOoKZVjjfq+E2HSeL0yy8t0sL3qYsIBPRvZS3Lsgd3GkU5Gw
 SudmoY1OLQpRQtFs2a9JdgG93Ti93keD0gwV+unBol0Ua5f3ZJC3zSK5ZyIMQOwMqEL8
 GVEe8fwrlqYzHAS7VPBUIvLK2joOsx9Xme/zIZd/vRi6UmaT4RrkhSCt+BVzij/S9ftk
 yKmq0c46WeTyxGgECQWLtDyx/hwBd1NNIMRmnsOnII9Sj4/LzBqCCDPprJeVMMPPB4EO
 lqbQ==
X-Gm-Message-State: APjAAAWa5aMWX8UGAGx01DFTqJhSl/tcQ+SeqVxY/ZbwMk1bnLeqHXgn
 HpL6bw9mVLJbMQY5ew5N+NyoGg==
X-Google-Smtp-Source: APXvYqwd75VErNxunler74D2aYIuUwxtIPPyshTDCbkZm56YpyIMcPHPAkjo50SdxP2In7GjOAaXhw==
X-Received: by 2002:adf:f581:: with SMTP id f1mr3704624wro.264.1575915118236; 
 Mon, 09 Dec 2019 10:11:58 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch.
 [62.167.101.88])
 by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 10:11:57 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v3 02/13] dt-bindings: document PASID property for IOMMU
 masters
Date: Mon,  9 Dec 2019 19:05:03 +0100
Message-Id: <20191209180514.272727-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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

On Arm systems, some platform devices behind an SMMU may support the PASID
feature, which offers multiple address space. Let the firmware tell us
when a device supports PASID.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b4624defc..3c36334e4f94 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -86,6 +86,12 @@ have a means to turn off translation. But it is invalid in such cases to
 disable the IOMMU's device tree node in the first place because it would
 prevent any driver from properly setting up the translations.
 
+Optional properties:
+--------------------
+- pasid-num-bits: Some masters support multiple address spaces for DMA, by
+  tagging DMA transactions with an address space identifier. By default,
+  this is 0, which means that the device only has one address space.
+
 
 Notes:
 ======
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
