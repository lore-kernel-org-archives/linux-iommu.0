Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEB0C43217
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 19:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30F71401F5;
	Thu, 12 May 2022 19:01:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bAsGi7gkuwmf; Thu, 12 May 2022 19:01:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D164E409C3;
	Thu, 12 May 2022 19:01:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3AA9C0032;
	Thu, 12 May 2022 19:01:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80978C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63FEE409C3
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wOOXxZ2Efx0 for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 19:01:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74DC94016E
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:01 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id u23so10740945lfc.1
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T4lJ4Enq2o11SalNDto2ZU8PP4FnbpR5XNyoETsj0ZA=;
 b=WTtxEI5pHAJIaSw9ce+AVY1FP/v6kLnMrbDLka8DUuZdZB71BEEil19Arum8Evaapw
 AsuqjDqJsuT88SLViuC1TbTFrsQw4pCVCEdejKXfezx8t+DZ80+dDMK3vO2hYcUa94jr
 Ej1d5EBftqmb8WRSAKCFSbUPTJnYwD8Ohs0N3+icPvXIEYwdy1nCVGNZb2w2MKHXugR1
 J8s2Yga9M27yh/184k1aPrCXH2CiR6T/f20kJwlAVuqPJD/rbqIpgRSNAa1tdJ2404XD
 L3OD2KGps0ESYJyLQ1h0AuDVvxbOXxq8C0h+onHA+BJotyWa2rayU56Vfsq3gLC/ku8y
 dl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T4lJ4Enq2o11SalNDto2ZU8PP4FnbpR5XNyoETsj0ZA=;
 b=o8RedD6bfhbwJS+mqOGMbYdYT0t5TVc10ljC5j+lzC59ekKNS1iPtWRbggKpp1BY9g
 n8voVCehDBA2oxNrFgCox9jY5Ip3yey+Asdz/+XajH9mTdkvJC9c4ZfZm0cO2jKT/1aW
 NCxm+un0IFFSQhJ5tBzrcAKEnjdDstuJtqIGXCuTd6kyInAugerPLz4y7pzEPWxDEuBd
 6aSljkvDvY6GuTQOP5ZXWnBkQEHJ69jylW+md87eFAfIKUn+ADVp0Zp6T6LESz2VkcfR
 s9KhilnZTMysnRmvNOOFtNtjnTrY8WQrYFf2ZJRfgMx0RoVEN4AiXv/yNBkH6eWQ34Gu
 1SJQ==
X-Gm-Message-State: AOAM531+eGVPTOfZpbIfL+pijEqpoNpNuAbynLbSmx6YVpTbrPPliBDi
 HC1i0lX/yxEDdJM9kxyns34=
X-Google-Smtp-Source: ABdhPJzMOhYHWrMZLXqZqjLrz/V48QTirRHrsfKrKHYw6Ozwd0JwtVFvqRgJazngSdLiKb47BP3V+w==
X-Received: by 2002:a05:6512:3042:b0:473:b1e0:5667 with SMTP id
 b2-20020a056512304200b00473b1e05667mr837783lfb.516.1652382059160; 
 Thu, 12 May 2022 12:00:59 -0700 (PDT)
Received: from localhost ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 18-20020a2e0d12000000b0024f3d1daebesm43552ljn.70.2022.05.12.12.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 12:00:57 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 0/5] iommu: Support mappings/reservations in
 reserved-memory regions
Date: Thu, 12 May 2022 21:00:47 +0200
Message-Id: <20220512190052.1152377-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Sameer Pujar <spujar@nvidia.com>, iommu@lists.linux-foundation.org,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Janne Grunau <j@jannau.net>, Robin Murphy <robin.murphy@arm.com>
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

From: Thierry Reding <treding@nvidia.com>

Hi,

this is another attempt at solving the problem of passing IOMMU
configuration via device tree. It has significantly evolved since the
last attempt, based on the discussion that followed. The discussion can
be found here:

  https://lore.kernel.org/all/20210423163234.3651547-1-thierry.reding@gmail.com/

Rather than using a memory-region specifier, this new version introduces
a new "iommu-addresses" property for the reserved-memory regions
themselves. These are used to describe either a static mapping or
reservation that should be created for a given device. If both "reg" and
"iommu-addresses" properties are given, a mapping will be created
(typically this would be an identity mapping) whereas if only an
"iommu-addresses" property is specified, a reservation for the specified
range will be installed.

An example is included in the DT bindings, but here is an extract of
what I've used to test this:

	reserved-memory {
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;

		/*
		 * Creates an identity mapping for the framebuffer that
		 * the firmware has setup to scan out a bootsplash from.
		 */
		fb: framebuffer@92cb2000 {
			reg = <0x0 0x92cb2000 0x0 0x00800000>;
			iommu-addresses = <&dc0 0x0 0x92cb2000 0x0 0x00800000>;
		};

		/*
		 * Creates a reservation in the IOVA space to prevent
		 * any buffers from being mapped to that region. Note
		 * that on Tegra the range is actually quite different
		 * from this, but it would conflict with the display
		 * driver that I tested this against, so this is just
		 * a dummy region for testing.
		 */
		adsp: reservation-adsp {
			iommu-addresses = <&dc0 0x0 0x90000000 0x0 0x00010000>;
		};
	};

	host1x@50000000 {
		dc@54200000 {
			memory-region = <&fb>, <&adsp>;
		};
	};

This is abbreviated a little to focus on the essentials. Note also that
the ADSP reservation is not actually used on this device and the driver
for this doesn't exist yet, but I wanted to include this variant for
testing, because we'll want to use these bindings for the reservation
use-case as well at some point.

Adding Alyssa and Janne who have in the past tried to make these
bindings work on Apple M1. Also adding Sameer from the Tegra audio team
to look at the ADSP reservation and double-check that this is suitable
for our needs.

Thierry

Navneet Kumar (1):
  iommu/tegra-smmu: Support managed domains

Thierry Reding (4):
  dt-bindings: reserved-memory: Document iommu-addresses
  iommu: Implement of_iommu_get_resv_regions()
  iommu: dma: Use of_iommu_get_resv_regions()
  iommu/tegra-smmu: Add support for reserved regions

 .../reserved-memory/reserved-memory.txt       |  1 -
 .../reserved-memory/reserved-memory.yaml      | 62 +++++++++++++
 drivers/iommu/dma-iommu.c                     |  3 +
 drivers/iommu/of_iommu.c                      | 90 +++++++++++++++++++
 drivers/iommu/tegra-smmu.c                    | 82 +++++++++++++----
 include/dt-bindings/reserved-memory.h         |  8 ++
 include/linux/of_iommu.h                      |  8 ++
 7 files changed, 235 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
 create mode 100644 include/dt-bindings/reserved-memory.h

-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
