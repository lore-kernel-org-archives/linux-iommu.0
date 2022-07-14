Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47EE4C64
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 16:55:53 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so3416712wma.2
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YL8SXrf5E+M6fcmsXFxLr3AwzTQU1pkyfX1gPaaxl4g=;
        b=yzTY8/JScLREDVva8u4+YNj6LmYxF9EIVD+XwCtYkLOEVLH1GJrIFioNH+MJj1Vp0I
         +CCLPrrfeS2nVyApdO73U2IbiOwvXlLe7rZb8fiq+8w9NhCIaZ55EpuPiMqJgNsbw/L9
         1A4TLgOQr/+peKJ6FjHVmkrOCjDfRs/ax3QRpnuegbonhyxpTRpf9D3PysQMEQcCYyMV
         w9fTRiJ8fyiptKaY4FS1xvcAaeMc2z25vdEV9G85FN+W3ioM0MnHEkATgMMFzFqx4SUx
         SDwFQ2HM5GOI+0wEvUKGFiNnE4fDFpVYLYnSg4LHZX+2wNDK9ToB1HBfuKpq1nihMv9F
         gRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YL8SXrf5E+M6fcmsXFxLr3AwzTQU1pkyfX1gPaaxl4g=;
        b=gD0KBWjT/qeiW+/b2jRU5T7XJuVBTpGIbh8nhYSqSJwpt1ij+MmtBXREOk6q48j5y9
         aboGMv/nX3yz5b/vZOWIeKuyZZakJIV1Xm/1lwjw38eAyoSa3YOrceiGA/dPSj0CPWDy
         pM6/BbpzWZwN/IuFqZW8yUltYZHqfbKgcvlUM1WmLmJTzrtmIwIDOAFjbh7LMK+PdGnM
         D70coUlAZOmmAJy9kH4mBEBBg5lrzdLWR0DshcMMVOrQzzZKqkVbw7h8skQ7d42/H+Eu
         LQtlsz4zoH4khea2c7NCCy8TF06MmMHqIMRoM5ideI7p7FXRUpNbSt2Lcikg6+pe7d9/
         FJcA==
X-Gm-Message-State: AJIora/O1LgDrfA28BnG0WK8AxFU+7Z1m/XQrkRzuDUIGljke+nDdSMG
	y9kd+oHY2QOOIJL6j2JyHyeKSw==
X-Google-Smtp-Source: AGRyM1vFn4HJAkOQC+XNsUm3xozYDCzxYVg/gZigISkKiP71CoqxZWFE7vGtjgNMufO1WXaz+VH3ew==
X-Received: by 2002:a05:600c:a08:b0:3a1:9319:ab78 with SMTP id z8-20020a05600c0a0800b003a19319ab78mr15875548wmp.158.1657817752131;
        Thu, 14 Jul 2022 09:55:52 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id p17-20020adff211000000b0021d9207e6f1sm1862666wro.34.2022.07.14.09.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:55:51 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	David Virag <virag.david003@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] iommu/exynos: Add basic support for SysMMU v7
Date: Thu, 14 Jul 2022 19:55:44 +0300
Message-Id: <20220714165550.8884-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimal viable support for SysMMU v7.x, which can be found in modern
Exynos chips (like Exynos850 or Google's GS101). SysMMU v7.x may
implement VM register set, and those registers should be initialized
properly if present. Usually 8 translation domains are supported via VM
registers (0..7), but only n=0 (default) is used for now.

Existing exynos-iommu driver only supports SysMMU versions up to v5. But
it's pretty much ready for basic usage with SysMMU v7, only small
changes have to be done. As SysMMU version is tested dynamically (by
reading the corresponding register), there is no need to introduce new
compatible string.

The only major change is that SysMMU v7 can have different register
layouts:
  - with Virtual Machine support
  - without Virtual Machine support

That can be checked by reading the capability registers. In the case if
SysMMU IP-core is VM-capable, the VM registers have to be used, and some
additional initialization is needed. That is the case on E850-96 board,
which non-secure SysMMU (v7.4) implements VM-capable register set.

Another required change to make SysMMU v7 functional (at least the one
that has VM registers), is to enable default VM instance. That should
be added to the code enabling MMU itself. Insights for that change were
taken by comparing the I/O dump (writel() / readl() operations) for the
vendor driver and this upstream driver.

The patch series was tested on E850-96 board. Because at the moment
there are no SysMMU users for that board, the testing was done using so
called "Emulated Translation" registers available on SysMMU v7. That
allows one to initiate the translation from CPU, by writing to those
registers, and then reading the corresponding TLB registers to find out
the translation result. The testing driver can be found in [1] tree.

Thanks to Marek, who did let me know it only takes a slight change of
registers to make this driver work with v7.

[1] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu

Changes in v3:
  - Merged "Check if SysMMU v7 has VM registers" patch into "Add SysMMU
    v7 register set" patch
  - Used variant struct instead of arrays for keeping register offsets
  - Kept common registers out of variant struct
  - See per-patch changes for more details

Changes in v2:
  - Addressed all comments on review
  - Reworked commit messages correspondingly
  - Added new patch: "iommu/exynos: Handle failed registration properly"
  - Added new patch: "iommu/exynos: Add SysMMU v7 register sets"
  - Added new patch: "iommu/exynos: Reuse SysMMU constants for page size
    and order"

Sam Protsenko (6):
  iommu/exynos: Reuse SysMMU constants for page size and order
  iommu/exynos: Handle failed IOMMU device registration properly
  iommu/exynos: Set correct dma mask for SysMMU v5+
  iommu/exynos: Abstract non-common registers on different variants
  iommu/exynos: Add SysMMU v7 register set
  iommu/exynos: Enable default VM instance on SysMMU v7

 drivers/iommu/exynos-iommu.c | 178 ++++++++++++++++++++++++++---------
 1 file changed, 136 insertions(+), 42 deletions(-)

-- 
2.30.2

