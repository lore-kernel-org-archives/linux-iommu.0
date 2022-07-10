Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC047B
	for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 23:06:06 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id l68so2124365wml.3
        for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 16:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nPSylhn+MlXQwMJ3vmZOIwjj2PtaM6NrgjfZcN53+0=;
        b=CWRIoXAEBDxrC9bGiRj/zi0DuboIft9UCUJ6qcWP0RVbGkX7Y5SwMT2aY+dZ0UhR1Y
         go5ObEyQjNAMrvff2gfgj2ZrVRsxpO61Oylg+EjuHaGeyqyFBPeU2Lds0h4LE/5WyJKW
         +V1MNAq/XY3lzTsRSTUlschbddDtj5ImuWtiEtVYeupQr1Kg3CLGQzmu8X/b/xv70QQo
         9nQg5wr8aAkt14BvuWmEN2REp9cu8yfBTrbFu7E0VqD1eANxZ1+lZENpsSNvRkxh7WCY
         82MTXJZ5r/hf3LK4YWCo4gfxegYLDmauOwxHlD5MWzc9Mpbs7byI3GBIYgj48vFWLH0q
         bzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nPSylhn+MlXQwMJ3vmZOIwjj2PtaM6NrgjfZcN53+0=;
        b=o84R3GP+1aEIe8+a11vOsWNYI2ApycJ083QznYkn0ckZQCWLUM6j4+t7g93qAuitN0
         VPliGR5xp5WQBtQSexBd3Y4mUWjZyu/srWTX3Xc1PZE85ltCZDSL71VOhi5Ol3QJIZEt
         srZxSpiTThs0qKE54tJ+zQTBxVjCbS0WebU+soP+HljQ/PMwgr1HRVYlrt4dMPLGMOI8
         29Tcqk6VTZ1EA/dM7wF4qHJKd4oo0aazYMyhOEt1VSCYnbvvSqvfwhiT8gf0tnfYmdPl
         gchcNAeYhvX2OLKmQ+BGpU5bPBIxGEX68+WLvVN/Q02qbOKOueTC8I7j/WWVXiAbOHJc
         oAhw==
X-Gm-Message-State: AJIora8GBv6nD9F1vhwuylrV1ePN7VrKC4NuxsLpe3AzcOML75Pgs2X8
	WvQisd86qu5rBnP6dAUj0BVLAQ==
X-Google-Smtp-Source: AGRyM1srekra2VL2j8jif81CwmQn3XpY1r37W6j6+iJVlQaoKvaJeqI5+ah5MAAvaw+ScSAyLOyKdw==
X-Received: by 2002:a05:600c:190b:b0:3a0:ac8a:7c2d with SMTP id j11-20020a05600c190b00b003a0ac8a7c2dmr12650759wmq.205.1657494364733;
        Sun, 10 Jul 2022 16:06:04 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id i15-20020adfefcf000000b0021d82a6095bsm4423810wrp.95.2022.07.10.16.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:04 -0700 (PDT)
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
Subject: [PATCH v2 0/7] iommu/exynos: Add basic support for SysMMU v7
Date: Mon, 11 Jul 2022 02:05:56 +0300
Message-Id: <20220710230603.13526-1-semen.protsenko@linaro.org>
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
that have VM registers), is to enable default VM instance. That should
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

Changes in v2:
  - Addressed all comments on review
  - Reworked commit messages correspondingly
  - Added new patch: "iommu/exynos: Handle failed registration properly"
  - Added new patch: "iommu/exynos: Add SysMMU v7 register sets"
  - Added new patch: "iommu/exynos: Reuse SysMMU constants for page size
    and order"

Sam Protsenko (7):
  iommu/exynos: Reuse SysMMU constants for page size and order
  iommu/exynos: Handle failed IOMMU device registration properly
  iommu/exynos: Set correct dma mask for SysMMU v5+
  iommu/exynos: Use lookup based approach to access registers
  iommu/exynos: Check if SysMMU v7 has VM registers
  iommu/exynos: Add SysMMU v7 register sets
  iommu/exynos: Enable default VM instance on SysMMU v7

 drivers/iommu/exynos-iommu.c | 219 ++++++++++++++++++++++++++---------
 1 file changed, 166 insertions(+), 53 deletions(-)

-- 
2.30.2

