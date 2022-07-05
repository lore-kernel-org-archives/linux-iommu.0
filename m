Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68986C43334
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 12:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05E8482C21;
	Tue,  5 Jul 2022 12:58:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05E8482C21
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=d1HUG8b7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gtu_OXMQzEID; Tue,  5 Jul 2022 12:58:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C0B5D82422;
	Tue,  5 Jul 2022 12:58:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0B5D82422
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FDE0C0032;
	Tue,  5 Jul 2022 12:58:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 539EEC002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 12:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E0E140877
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 12:58:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E0E140877
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=d1HUG8b7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yE1xq7ag2VOf for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 12:58:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC79940869
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC79940869
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 12:58:41 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id z41so15200803ede.1
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ThRFRFG6dG3lyoRkGG2bLT7jC0J7ce9MxZGKEc+OGhY=;
 b=d1HUG8b79zydnFytdZoLA6Fg2PL77XJOEn42q0DWcc/QO7tprXWkJ9NIMNHr0CUCjJ
 r5/ce5Ar6MdbAz5VcH7McUweQgk6zYMTDJVNiMsacEVTwI1HXGPoklPCkctasJgKe+yY
 EIazCPHMcc2mNNuEETADN6hupB3/9wPtw778kO4Wdf/07xLVGhWg581czgMfSeGot0WK
 oT1pTQLXJvb/cklMhFDitswQ+BAekd1nyhENGHBH6ok0DxXLQ1eXE8Ad/TrmHNLVBvQr
 kHvm2Rqzmgka7nirKvwEIx626ost0xLE+4NfUhSGiYmRrcdiNrzMgZ0hjptzk4TyWtVo
 cPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ThRFRFG6dG3lyoRkGG2bLT7jC0J7ce9MxZGKEc+OGhY=;
 b=WYIRY6wsgi9Zo+LzXDHK2L0vt/uzDNvu+xaRhabLZOgRanbrRgqhlp1rVTk6o6NftB
 T6+MJJwW146XcEyVXfP6+GeQt2kWs9OIh68iomL1Q65uG73as6a+CsNps4FBjAhFO3LL
 mYd2JciR/JuvuMPyR++PDjBk2NL45BTWeN9lxM8XGrf0l0NHo+ywrL3iXHxfMy14QF4i
 dtU6lU25xvZTOzQ7GGBZVIYJ6YHYMraNO2IhxziGGpy/PisAy4AFp+xDCuhE2gX/Sumn
 u8xMXnSRMxoPnDkzDe/mZMOPe5YCv07U4YU5Q8T6SCF6dZPZKZOyUqwThnRPFs9B+Np2
 pRYA==
X-Gm-Message-State: AJIora/aok7CR5MYbRN4LculBn6yK1uRAyxXhsE/U+3PIHg7WHVhWEvO
 lDtyg3fLXHz2/yGKASi7T2txAxSCMkQ=
X-Google-Smtp-Source: AGRyM1uCPRUNy3Pz9Rug5PKlHut5lD1SCgKIZXG+KjGfjNf8Occi/0aEXuBzQyuExMRc1OA8B9eImg==
X-Received: by 2002:a05:6402:b26:b0:43a:6c93:f4e3 with SMTP id
 bo6-20020a0564020b2600b0043a6c93f4e3mr11031442edb.327.1657025919660; 
 Tue, 05 Jul 2022 05:58:39 -0700 (PDT)
Received: from localhost
 (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 p26-20020a17090635da00b007105a157706sm15809586ejb.82.2022.07.05.05.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 05:58:38 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v6 0/5] iommu: Support mappings/reservations in
 reserved-memory regions
Date: Tue,  5 Jul 2022 14:58:29 +0200
Message-Id: <20220705125834.431711-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Sameer Pujar <spujar@nvidia.com>, iommu@lists.linux-foundation.org,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Janne Grunau <j@jannau.net>, Robin Murphy <robin.murphy@arm.com>,
 asahi@lists.linux.dev
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

This version has several fixes over the previous v5, which can be found
here:

  https://lore.kernel.org/all/20220512190052.1152377-1-thierry.reding@gmail.com/

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
 drivers/iommu/of_iommu.c                      | 88 +++++++++++++++++++
 drivers/iommu/tegra-smmu.c                    | 82 +++++++++++++----
 include/linux/of_iommu.h                      |  8 ++
 6 files changed, 225 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
