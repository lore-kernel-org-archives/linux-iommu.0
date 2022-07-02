Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC4441B
	for <iommu@lists.linux.dev>; Sat,  2 Jul 2022 21:37:27 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id z41so7013977ede.1
        for <iommu@lists.linux.dev>; Sat, 02 Jul 2022 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WV81TTrUzfnxlK8f1IHJz4xXjnSjuTWSu4GCpZi6HEY=;
        b=N6w5oPvPqSon53fXnJZtzHnqdoTIeYCV6XuIzoHbJZvZSPSWEzPKieCj19s19eJcwL
         RcIaTUHdUUNr9nkU6I8AoMl8MYOb93MYMUeA0voFGALhae/V7epsJgesAM52ZRW0dX2Y
         4yxMLoOi6DW/mQkOXwh0GbnbaVTBgbdxWiAiCbpqEsBEKg6pEaxcBiNh8KoKto2CQ+5k
         VSW2p4QdgRIqPwEEj8mBNKB9BzfGyNCD8VAk1JR6fgYaS+Xp/nbzdZvzdg3/YaSn/Kpz
         IQD+4eisIUTicjTxgNLfA7Ka4wWJVD1nwiy7AQb07DRuKpbj8Tux5G3x0Zq9odNjaYHP
         u+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WV81TTrUzfnxlK8f1IHJz4xXjnSjuTWSu4GCpZi6HEY=;
        b=VMf6wMws8nWQI/wqxBV87Kfp64uRVi9IJkDBkOlMU6RBhvQ+QokZp9so/5CFqFo3/Z
         T6mVK16TqNEUfLw02dvNBTrMFLfNWMyskiHF9cOOHqmjh3Dg0ZlqTuZdbvAtmw2K8o7l
         wMiLgxk0p9jK+ui87AHAOKSmXW/kJrnTT6plc1dO1pep6Iydg/b8rYLjMPn4tuv9secr
         qTMF1mFaDUy+tSi7eBmsAW13ajmcSm/XjVcz2C5ROgB/43F5Nt7FZIkmtPrqA8TQETXS
         43Z42+V9/tbAChYW9DauJ6Mr1gV46Pn0u8Sj+I7gDy9JQfstMBepQZDlmnaU3hu4y333
         0DZg==
X-Gm-Message-State: AJIora+SDlNDQUZ09L8cOccF1uBRFaIFJRHr4ZKjlKjlJTZRUTaKQhXC
	DmJECvDBGfVP/+LaYhfeyh4XuQ==
X-Google-Smtp-Source: AGRyM1tKUcbvm7Pv5J7R8O4WaT3he1b97HxgOQBsVTrAmlhI7zbpEK0Cj+SrJSn0blV18Pjxg6AVHA==
X-Received: by 2002:aa7:cd91:0:b0:438:33a1:d5aa with SMTP id x17-20020aa7cd91000000b0043833a1d5aamr22690535edv.157.1656797845428;
        Sat, 02 Jul 2022 14:37:25 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m7-20020a056402050700b004356c0d7436sm17483107edv.42.2022.07.02.14.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:37:25 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
Date: Sun,  3 Jul 2022 00:37:20 +0300
Message-ID: <20220702213724.3949-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220702213720.-TJvwn9D8Q-WUthRVaIR0hfLBF8I5DZr3V6MTvf_Qeo@z>

Existing exynos-iommu driver only supports SysMMU versions up to v5. But
it's pretty much ready for basic usage with SysMMU v7, only small
changes have to be done. As SysMMU version is tested dynamically (by
reading the corresponding register), there is no need to introduce new
compatible string.

One major change is that SysMMU v7 can have different register layouts:
  - with Virtual Machine support
  - without Virtual Machine support

That can be checked by reading the capability registers. In case the
SysMMU IP-core is VM-capable, the VM registers have to be used, and some
additional initialization is needed. That is the case on E850-96 board,
which non-secure SysMMU (v7.4) implements VM-capable register set.

The patch series was tested on E850-96 board. Because at the moment
there are no SysMMU users for that board, the testing was done using so
called "Emulated Translation" registers available on SysMMU v7. That
allows one to initiate the translation from CPU, by writing to those
registers, and then reading the corresponding TLB registers to find out
the translation result. The testing driver can be found in [1] tree.

[1] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu

Sam Protsenko (4):
  iommu/exynos: Set correct dma mask for SysMMU v5+
  iommu/exynos: Check if SysMMU v7 has VM registers
  iommu/exynos: Use lookup based approach to access v7 registers
  iommu/exynos: Add minimal support for SysMMU v7 with VM registers

 drivers/iommu/exynos-iommu.c | 112 ++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 8 deletions(-)

-- 
2.30.2

