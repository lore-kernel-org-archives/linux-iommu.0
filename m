Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E620C43334
	for <iommu@archiver.kernel.org>; Sat,  2 Jul 2022 21:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D08C78149E;
	Sat,  2 Jul 2022 21:37:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D08C78149E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wVSILGBG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pSe_oPw0MkEW; Sat,  2 Jul 2022 21:37:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB21581469;
	Sat,  2 Jul 2022 21:37:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB21581469
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85F24C0032;
	Sat,  2 Jul 2022 21:37:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D3EFC002D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27D0F60A89
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27D0F60A89
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=wVSILGBG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mLla96CexiDu for <iommu@lists.linux-foundation.org>;
 Sat,  2 Jul 2022 21:37:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7C0A60A69
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7C0A60A69
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:28 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id sb34so9986218ejc.11
 for <iommu@lists.linux-foundation.org>; Sat, 02 Jul 2022 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aWfZE2YpB25R+rCMwVNZi2s9IwZn0JfO+IgsGnjhYqY=;
 b=wVSILGBGUjVOC+cfuxxbSMyxpvn6GttZQpREPJStje8Jo1kxV0hOiJBQjYgcMjnGO8
 HzrlHKacg6/F0WF0UTTYxmtVqmcttqofFOrJX6K+BP9MvvRdIR7qYrVcD7+DFCx3EKT0
 v7Hte9vIx/BKEL3aPNq1az2t5Nf5ERiriNAhe4KwSJOAyDfa58FaLw+AHHh0SnQeL6jn
 UMtj1LphcAYF+SCg6rTx11cw/9TDH61FUx3QLb2jvIAt9clvxCy6iYOFU5DZ9Kgf8G9u
 J/kArGjS3bdmqxj4yPJLCgNcdbkBX/TWXfqGZSQ3YUT28PeuTlKYSuvKmAr01wazLM4f
 ZKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aWfZE2YpB25R+rCMwVNZi2s9IwZn0JfO+IgsGnjhYqY=;
 b=q0aK0fIK7FQtX8xNUBUkxYPEWKtqbkATYFL42XXs0qQrL+bJbRH2uYmC3+0fJc7AxS
 p62C9LjAMGpod7POUBDetSvv0qNhXdtzXhOVXgZVC04ev+5o55nlsio7I/V6lRm4ewP1
 9sVfWQ+QR1WexErApAQZKmTHip7GspRypCBnr0hRDA6cgO/xAz2MiIgf+QwkGAA4PA7g
 DqHyvPb5xlmN8st7a0i/xqU7PRZFwGyC0uvcFfGEGICR1oc+pWJ+FJQGyjqHtnjv6Lrb
 +cUs9YVVfUtdVuPLflEqoS5h5npfN/f2VM5hdw0VZK9O4aKyuQiWsJKGsyyn2XBxWsVx
 SLQw==
X-Gm-Message-State: AJIora/aVfzow7qo8Xd8vI9DZJ6s48y2mGpYAFqvzhZPx9HAV35+rMBO
 Xa6sVemxMZ6N4FBU1xyjE5ohVQ==
X-Google-Smtp-Source: AGRyM1sjE5ZjIaY+GfCnbQmj6BkapC2AnzQE+mzuISXF0GaEPi7w7Vucxh56Irz739GXVnorjZvvIA==
X-Received: by 2002:a17:906:1018:b0:718:dd3f:f28c with SMTP id
 24-20020a170906101800b00718dd3ff28cmr21490786ejm.55.1656797846558; 
 Sat, 02 Jul 2022 14:37:26 -0700 (PDT)
Received: from localhost ([31.134.121.151]) by smtp.gmail.com with ESMTPSA id
 a18-20020a170906671200b00718e4e64b7bsm12214247ejp.79.2022.07.02.14.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Jul 2022 14:37:26 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] iommu/exynos: Set correct dma mask for SysMMU v5+
Date: Sun,  3 Jul 2022 00:37:21 +0300
Message-Id: <20220702213724.3949-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220702213724.3949-1-semen.protsenko@linaro.org>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Cho KyongHo <pullip.cho@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
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

SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
mask to avoid falling back to SWTLBIO usage in dma_map_single() because
of failed dma_capable() check.

The original code for this fix was suggested by Marek.

Originally-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 71f2018e23fe..28f8c8d93aa3 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -647,6 +647,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (MMU_MAJ_VER(data->version) >= 5) {
+		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
+		if (ret) {
+			dev_err(dev, "Unable to set DMA mask: %d\n", ret);
+			return ret;
+		}
+	}
+
 	/*
 	 * use the first registered sysmmu device for performing
 	 * dma mapping operations on iommu page tables (cpu cache flush)
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
