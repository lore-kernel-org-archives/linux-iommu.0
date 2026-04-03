Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8E23D7F4
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177496; cv=none; b=CUuhI+n1OBgMotCMIsL+rMAmlYrSqJj/O31uyXn9/P6P6QTmJTY44SnTCk1v95BjcsXN2ut8IafDUvzkqsePdLteIh+ztzsqwvDg4/5w2Dxc4ipHb4OJbJtaVKXAm/wdpfEwloiB4hcQIrl58jpBfsNTVhX69GrBv5/Rcs5xZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177496; c=relaxed/simple;
	bh=MLU3H0vT5l7RkyqJ4axMsnZCk3EEo/xxuxHDjIkeDXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPmBqcVZbIDNE1tDs9+t/YPyq1IxccsXL6CaA3KtrlDa9c7HfdpBeR4Q2uhmelSy6maesXBCUB9Jy/Uq+vTOYso0TBGBgEaV5APFyLLhzmryryJEp4e9vpHaaenq2+BMzFHg8iTnwH1ZN3fOfTx1n0q06N2+iiN9z1gs758DBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XNhaRc5u; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNhaRc5u"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2cc1534e026so206288eec.1
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 17:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775177493; x=1775782293; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb2HYWEQxB/om4yhyjxjNip9666HK8Fi8TGkiu9j7VQ=;
        b=XNhaRc5uArQw3DLWupQkMrB9ZQS2wjwnaj9g4fgrXMVd0PmfNOur3o8EPu509+y2Wp
         z6JzISPEm4NeQ9XxjcyXZzuZwo4rUT3SswuaNiZnX6f9eET3N/s/RTz1/WfkCGZBOm38
         LtvptzuU/vZkIvTV6crIHrvuA4uhIUz0GbOk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177493; x=1775782293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb2HYWEQxB/om4yhyjxjNip9666HK8Fi8TGkiu9j7VQ=;
        b=knatNSe1sg/xhq6niNFq8q/76eauuJqo7gYLkLU7xxAiiwZBW+s1wLfnC0xT7NBzBO
         9S6is2O/zxp7my+aSHuhcgab52aF9mWcNEfFjaZNcwkMUs2i25YBSYOcwY7ZD6xKkb00
         zVZuRdX/xBxLEZa8CV/ja9C9/YvCNDRmH4Hn+yck9Br75a0+NJizzBqdu6ttmwuwO/sd
         O7GPEQuy5MSLYo/UxdGWo+yr8m58ezysQvqgJ7bpl8HTbd/z86yLiGAHR0eTOQLfu+TB
         yREUM/ypyYh9PlPFILZX4ZF9lwlr3o2evn50gFcVI7O3SmZk8T/lagwpTofOYifDiFhY
         U0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeoqifBNUJd2duqXznfyMU+M0Bx0d6IfhdtLl4xFHcB/l2MsuT99izScJqGGqVHudL6JPlYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuyeZEfWb1U48eeL6CLL9xEexnh/TVG/sZftNFTJhOxQ5wfr8Y
	KcQ4YUM2GNsIq8FetPAiqakBikzDZzqR0RWKVg1s7exyadhVUUfQGbDS2RhkNH3g1g==
X-Gm-Gg: AeBDieuZ+59LCEcjDC9fbxtx8WapfJzhMJC69T5o7RJ2UIxVEYKkG5+uQkFQDZRUMKK
	D1C9SR7BFo5NGaaCMuTv2KcV17FFBnjcr+UArEDLYa70ldUwW/7SIfg5ufbOi+Ai+9HS76DdFJ9
	QN4QsJdiwLmg/nzJsm0zo9pxRCqJk6LiIlGiLH9/8BReOaHut7uP1ywWqoOS9gYp0UGhJdEtpA8
	pkaKJyM3DUzQjo5rnwe5ywmEUZJ9TjiTRgXGCY2iseq2bgRHSqbyqulu4pTTdn1Jo4upW5eNWFL
	iuCPD/76Q7w1q6h18ZBBlZydTQzbQvCSyBWuV3Ir4bjOyioslRjzO5qRZ/DqDloEjezoKXY8L4U
	hm08mEGyGgU65XH56ZLneoEKNzPAsZ7MxpmD/4qD1Kjnf4g/c91XqttWmpdbk5hnN6GXIQWHsn1
	2iYE2kZ+fa6D3kejCmyDrJkf41CPcN5VUudSZXSKlBtl+Rlv/w2lgB26C4jv3LlRORHHYVWuvSG
	eKmzULxhTL7/eqohKx70A==
X-Received: by 2002:a05:693c:3009:b0:2c1:558c:16f7 with SMTP id 5a478bee46e88-2cbf950392cmr655589eec.6.1775177492780;
        Thu, 02 Apr 2026 17:51:32 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5db3:7542:a530:f43a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm3630074eec.5.2026.04.02.17.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:51:31 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frank.Li@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	alex@ghiti.fr,
	alexander.stein@ew.tq-group.com,
	andre.przywara@arm.com,
	andrew@codeconstruct.com.au,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	astewart@tektelic.com,
	bhelgaas@google.com,
	brgl@kernel.org,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	chleroy@kernel.org,
	davem@davemloft.net,
	david@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	driver-core@lists.linux.dev,
	gbatra@linux.ibm.com,
	gregory.clement@bootlin.com,
	hkallweit1@gmail.com,
	iommu@lists.linux.dev,
	jirislaby@kernel.org,
	joel@jms.id.au,
	joro@8bytes.org,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	kuba@kernel.org,
	lenb@kernel.org,
	lgirdwood@gmail.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org,
	m.szyprowski@samsung.com,
	maddy@linux.ibm.com,
	mani@kernel.org,
	maz@kernel.org,
	miko.lenczewski@arm.com,
	mpe@ellerman.id.au,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	oupton@kernel.org,
	pabeni@redhat.com,
	palmer@dabbelt.com,
	peter.ujfalusi@gmail.com,
	peterz@infradead.org,
	pjw@kernel.org,
	robh@kernel.org,
	sebastian.hesselbarth@gmail.com,
	tglx@kernel.org,
	tsbogend@alpha.franken.de,
	vgupta@kernel.org,
	vkoul@kernel.org,
	will@kernel.org,
	willy@infradead.org,
	yangyicong@hisilicon.com,
	yeoreum.yun@arm.com
Subject: [PATCH v3 0/9] driver core: Fix some race conditions
Date: Thu,  2 Apr 2026 17:49:46 -0700
Message-ID: <20260403005005.30424-1-dianders@chromium.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal of this series is to fix the observed bug talked about
in the first patch ("driver core: Don't let a device probe until it's
ready"). That patch fixes a problem that has been observed in the real
world and could land even if the rest of the patches are found
unacceptable or need to be spun.

That said, during patch review Danilo correctly pointed out that many
of the bitfield accesses in "struct device" are unsafe. I added a
bunch of patches in the series to address each one.

Danilo said he's most worried about "can_match", so I put that one
first. After that, I tried to transition bitfields to flags in reverse
order to when the bitfield was added.

Even if transitioning from bitfields to flags isn't truly needed for
correctness, it seems silly (and wasteful of space in struct device)
to have some in bitfields and some as flags. Thus I didn't spend time
for each bitfield showing that it's truly needed for correctness.

Transition was done semi manually. Presumably someone skilled at
coccinelle could do a better job, but I just used sed in a heavy-
handed manner and then reviewed/fixed the results, undoing anything my
script got wrong. My terrible/ugly script was:

var=can_match
caps="${var^^}"
for f in $(git grep -l "[>\.]${var}[^1-9_a-zA-Z\[]"); do
  echo $f
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = true/set_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = true/set_bit(DEV_FLAG_${caps}, \&\\1.flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = false/clear_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = false/clear_bit(DEV_FLAG_${caps}, \&\\1.flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = \([^;]*\)/assign_bit(DEV_FLAG_${caps}, \&\\1->flags, \\2)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = \([^;]*\)/assign_bit(DEV_FLAG_${caps}, \&\\1.flags, \\2)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var}\([^1-9_a-zA-Z\[]\)/test_bit(DEV_FLAG_${caps}, \&\\1->flags)\\2/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var}\([^1-9_a-zA-Z\[]\)/test_bit(DEV_FLAG_${caps}, \&\\1.flags)\\2/" "$f"
done

NOTE: one potentially "controversial" choice I made in some patches
was to always reserve a flag ID even if a flag is only used under
certain CONFIG_ settings. This is a change from how things were
before. Keeping the numbering consistent and allowing easy
compile-testing of both CONFIG settings seemed worth it, especially
since it won't take up any extra space until we've added a lot more
flags.

I only marked the first patch as a "Fix" since it is the only one
fixing observed problems. Other patches could be considered fixes too
if folks want.

I tested the first patch in the series backported to kernel 6.6 on the
Pixel phone that was experiencing the race. I added extra printouts to
make sure that the problem was hitting / addressed. The rest of the
patches are tested with allmodconfig with arm32, arm64, ppc, and
x86. I boot tested on an arm64 Chromebook running mainline.

Changes in v3:
- Use a new "flags" bitfield
- Add missing \n in probe error message

Changes in v2:
- Instead of adjusting the ordering, use "ready_to_probe" flag

Douglas Anderson (9):
  driver core: Don't let a device probe until it's ready
  driver core: Replace dev->can_match with DEV_FLAG_CAN_MATCH
  driver core: Replace dev->dma_iommu with DEV_FLAG_DMA_IOMMU
  driver core: Replace dev->dma_skip_sync with DEV_FLAG_DMA_SKIP_SYNC
  driver core: Replace dev->dma_ops_bypass with DEV_FLAG_DMA_OPS_BYPASS
  driver core: Replace dev->state_synced with DEV_FLAG_STATE_SYNCED
  driver core: Replace dev->dma_coherent with DEV_FLAG_DMA_COHERENT
  driver core: Replace dev->of_node_reused with DEV_FLAG_OF_NODE_REUSED
  driver core: Replace dev->offline + ->offline_disabled with DEV_FLAGs

 arch/arc/mm/dma.c                             |  4 +-
 arch/arm/mach-highbank/highbank.c             |  2 +-
 arch/arm/mach-mvebu/coherency.c               |  2 +-
 arch/arm/mm/dma-mapping-nommu.c               |  4 +-
 arch/arm/mm/dma-mapping.c                     | 30 +++----
 arch/arm64/kernel/cpufeature.c                |  2 +-
 arch/arm64/mm/dma-mapping.c                   |  2 +-
 arch/mips/mm/dma-noncoherent.c                |  2 +-
 arch/powerpc/kernel/dma-iommu.c               |  8 +-
 .../platforms/pseries/hotplug-memory.c        |  4 +-
 arch/riscv/mm/dma-noncoherent.c               |  2 +-
 drivers/acpi/scan.c                           |  3 +-
 drivers/base/core.c                           | 55 +++++++-----
 drivers/base/cpu.c                            |  4 +-
 drivers/base/dd.c                             | 28 +++++--
 drivers/base/memory.c                         |  2 +-
 drivers/base/pinctrl.c                        |  2 +-
 drivers/base/platform.c                       |  2 +-
 drivers/dma/ti/k3-udma-glue.c                 |  6 +-
 drivers/dma/ti/k3-udma.c                      |  6 +-
 drivers/iommu/dma-iommu.c                     |  9 +-
 drivers/iommu/iommu.c                         |  5 +-
 drivers/net/pcs/pcs-xpcs-plat.c               |  2 +-
 drivers/of/device.c                           |  6 +-
 drivers/pci/of.c                              |  2 +-
 drivers/pci/pwrctrl/core.c                    |  2 +-
 drivers/regulator/bq257xx-regulator.c         |  2 +-
 drivers/regulator/rk808-regulator.c           |  2 +-
 drivers/tty/serial/serial_base_bus.c          |  2 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c      |  2 +-
 include/linux/device.h                        | 83 ++++++++++---------
 include/linux/dma-map-ops.h                   |  6 +-
 include/linux/dma-mapping.h                   |  2 +-
 include/linux/iommu-dma.h                     |  4 +-
 kernel/cpu.c                                  |  4 +-
 kernel/dma/mapping.c                          | 16 ++--
 mm/hmm.c                                      |  2 +-
 37 files changed, 178 insertions(+), 143 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

