Return-Path: <SRS0=QcZA=YE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED18C47404
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 03:58:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CDE206A1
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 03:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLcqMomL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CDE206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E4FCE1027;
	Fri, 11 Oct 2019 03:57:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 769D3F2F
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 03:47:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2E8E714D
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 03:47:16 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id q7so5220810pfh.8
	for <iommu@lists.linux-foundation.org>;
	Thu, 10 Oct 2019 20:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BFpgtLfpcuYnuHOZcClguxk/FizlRVOUrFmBGFft3Zc=;
	b=QLcqMomL195A0XFbz+6bmeHusd3RisVyozm1U6ZbnH9aFniTaqdqnyKC7dNvxtJX3x
	HK19zjIgzOfgQwXQDNp4IHbkwrsqsctxL6VgdOBZlTalLA2CQQ3Z2SNxkRz2MQRggiYJ
	NRZ1UL1syb8XfJPFupZoV2toUR6AkkJ8C0DBd/YD1fUE8Yxd6B5rImdVcmvNtywWA7W/
	IbkxT69IsFJZUiOq4I9WJnKe/WtK5ZYoSSxCWFOx97vfJkCjc4FBe0ln+hcfS9BVyEEp
	TuSgX62DRBym5hMIe0/UW0IU+w6vLpMK4gk2xFaDb5/UF3mI70O0MoAGDHqJwQd0oLO/
	W2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BFpgtLfpcuYnuHOZcClguxk/FizlRVOUrFmBGFft3Zc=;
	b=gBT6KTkynIn/u/j5NWS6gSrhoqBvMYVsm6exTUp392P8oTgBvRVR2Eg65TrQG4a/xL
	WvT7lazaBva/KDk0gXjIjsfsyo29JJ68CzWk0kY2AUThN2aYALyBoWOhGlKUIjcbxzR/
	ED+kwrYBxSWIrNPHR5aL0koWp4j/l4lV4tPVMyUvHqAP3DNjJUuAIgSTF3C3lzqiktfy
	K+/V3mY9A4ApAfzIXIFj7DVtyTN2UZ7sZNz1jyu5EFVsQxrfYx+OyQXRDJ6ZYWCrpm3b
	F8bQpjcOIZ3P24NkoT9SZ2/sPL8H8eZjTKg4W23V5hJmBk1xU2K7M5VfBvtC7VtHFP57
	RvTg==
X-Gm-Message-State: APjAAAUVxlHD0sjsmmSUaqWUXlPuhFgAg/xE3U1wsYUNNdTkLsTAGxVv
	YBRHyY0veAe410UPyHRVmb4=
X-Google-Smtp-Source: APXvYqxmaqxpu7ohA7yHdWnf/4vQ5UFS1d9Fe43rR+v7KPX4qiC0Xq8qwegGxBu2z0qBDzrtwmo3WQ==
X-Received: by 2002:a65:53c4:: with SMTP id z4mr14216342pgr.155.1570765635475; 
	Thu, 10 Oct 2019 20:47:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	u3sm7493267pfn.134.2019.10.10.20.47.14
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 10 Oct 2019 20:47:15 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, will@kernel.org,
	robin.murphy@arm.com
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add an optional
	"input-address-size" property
Date: Thu, 10 Oct 2019 20:46:08 -0700
Message-Id: <20191011034609.13319-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011034609.13319-1-nicoleotsuka@gmail.com>
References: <20191011034609.13319-1-nicoleotsuka@gmail.com>
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Some SMMU instances may not connect all input address lines physically
but drive some upper address bits to logical zero, depending on their
SoC designs. Some of them even connect only 39 bits that is not in the
list of IAS/OAS from SMMU internal IDR registers.

Since this can be an SoC design decision, this patch adds an optional
property to specify how many input bits being physically connected.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 3133f3ba7567..a9373a2964a3 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -97,6 +97,13 @@ conditions.
 - power-domains:  Specifiers for power domains required to be powered on for
                   the SMMU to operate, as per generic power domain bindings.
 
+- input-address-size: Number of address bits being physically connected to an
+                  SMMU instance, as the input virtual address width. SoC might
+                  tie some upper address bits to logical zero inside the SMMU
+                  wrapper, so SMMU would only support a virtual address input
+                  size, corresponding to physically connected bits, instead of
+                  the reading from register.
+
 ** Deprecated properties:
 
 - mmu-masters (deprecated in favour of the generic "iommus" binding) :
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
