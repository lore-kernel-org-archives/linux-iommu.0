Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B8639FCAD
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517926; cv=none; b=e9w3+HjEK98yHRMHf7HoHxxzVov8kVCrdN+tGGyuFCiibQrt2Dznc8MBnFVfg40w6fF95aF0C+lEGqkVWaFM4qCQUcRo0sbY9JmwRYN60Y352PX6bDY5ov6Zf4xwfIIQ1rdaCFcga7a58hLwGOlcCjIrfF94M3u2U1GBZoevt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517926; c=relaxed/simple;
	bh=a3r3KrEuJLHBWtXp3+zPQs9X4rkDOMQXRKluXAK5krI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FS3t6AgsDlJVHgb7oKagaYrpr+zg5/UDideLnu3uO7y8oRlwfXO84qq9VaLImawzSLLbyZ5kkmYoZYn0Rbcbz43pgxKNrL0KSNkZXj+/nZRZx961jKTZhg1jadIl2Mb+HkSgNdjGkTOYmbANgEB3BZJ1TEsDbYa849GVETUAI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WKjkkJB2; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WKjkkJB2"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ce102afb0aso2630009eec.1
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775517923; x=1776122723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+LsTmUaKDUP6TtbtpmsofePBR8TWMvjJHv9+/xi4nY=;
        b=WKjkkJB2yO17oadY+eSyJr6ZMlssWkezIuNfP7uWe9wy/w/UK1qM+VsaZ7Tv6wDCEJ
         8eVkfqLtfU01WLHfQjd4SuZUttf7dBbNZ8ItlMvzjqDFlBkwPy+lwbW2wrMbmkmC/E+W
         7WlPc0+/VSFsdE0AkPi0Fet2kTHVUg6sb8F9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517923; x=1776122723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+LsTmUaKDUP6TtbtpmsofePBR8TWMvjJHv9+/xi4nY=;
        b=DGq51URW9VmgAYPq4h9lsQhcrPaOoIu62Cyo/njm8VdTeIgRItY/vnTnZ2YjYAfUng
         qfyNXBrvueKhBI8xG86MXI4t4x/y3vJQZqNtqfXruIm0OdSH9X6hn3U/aSH22fz7M+Vq
         PEbxgAYNFYNRqrRqfKcqRv4syHls5t2DYs8P17l2xH+zQKL/87CewlEdSZU3KsY48GaX
         lVR9aSyeHNdUgOEmpL9DusUs128oPINdFdRbfzEiS5v6l29QGU3z/DYURjMEjqQBT4Pk
         Z2Cb2pwr/mACjCXdURbYt9v6FC9JOGEneJ7xZlLO+2tUH4BBV7KlopDpIvGtvQPgJTbL
         RDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW35qtrRkx3MrISN+jJBzHEYIRmHvIn2bmhwx1LREF79ClvijOXzLLiala1FmYN4MXWBtFuVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB/jwQ1M3xTJ4lkoVyhLNZryAwb+JT0IENKW32+vDG7HBlIiAS
	LGNdUHEjPMAtP40vPBZc7FZeGkzkTM2brT9Qj8ohqsGT7p0MRIHVjwG3wskoOVMTmg==
X-Gm-Gg: AeBDieup9kY3LEetwHVXFUEd5OEbvXrLumSh7tdTwwoa+z3swGFWt+QdcLQzspINzB4
	2ljXlNSUEQClzwAxbA4lbpBQUJt/HaGirB+P6PaiybonExVNzsIXWDTmqLt8UXiaMeHKw6QiHz6
	fi//OtKVJLlus4SG64Cjw3+TeUz/22LzqSVUlztMs/GvLk5VENVHQzQzd/1DNkPcXOHOP7RKLk7
	Mr7Fg1AzYt8tF3WZTDTC0WoChchEq3BxLRCDpHFaS4kY34x1NU2zn0Q7xFCauiKgKcG4N9R5Czk
	GMsWVBWtqRxCZj6xVA/YydTnRQBbGRGVmCRDoGEwmHFC83y3eq61gEzUumKZOcyRx3JjF1ndKSV
	TN2HPsVifmyk/Uicv1hEZbFyp8FPSTfY4ESQUenJcuHD/yblpLP/93tUM7wNO4279r5urfbu6xH
	jXxoSNZ0CI0tP14qpO7fAq5iHzI7aCVRzFQXWQFGoh2jcL4yAaqtRwK33lJeQagYlqyEafcHbO5
	6jAldBuxssWvPI/yP3h
X-Received: by 2002:a05:7300:818c:b0:2c7:3a7:c7b1 with SMTP id 5a478bee46e88-2cbf9503916mr7679632eec.1.1775517923360;
        Mon, 06 Apr 2026 16:25:23 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:c071:3b78:5a5:824a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm14730975eec.0.2026.04.06.16.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:25:22 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	maz@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
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
Subject: [PATCH v5 0/9] driver core: Fix some race conditions
Date: Mon,  6 Apr 2026 16:22:53 -0700
Message-ID: <20260406232444.3117516-1-dianders@chromium.org>
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
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = true/dev_set_${caps}(\&\\1)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = false/clear_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = false/dev_clear_${caps}(\&\\1)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = \([^;]*\)/assign_bit(DEV_FLAG_${caps}, \&\\1->flags, \\2)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = \([^;]*\)/dev_assign_${caps}(\&\\1, \\2)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var}\([^1-9_a-zA-Z\[]\)/test_bit(DEV_FLAG_${caps}, \&\\1->flags)\\2/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var}\([^1-9_a-zA-Z\[]\)/dev_${caps}(\&\\1)\\2/" "$f"
done

From v3 to v4, I transitioned to accessor functions with another ugly
sed script. I had git format the old patches, then transformed them
with:

for f in *.patch; do
  echo $f
  sed -i~ -e "s/test_and_set_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_test_and_set_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/test_and_set_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_test_and_set_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/test_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/test_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/set_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_set_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/set_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_set_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/clear_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_clear_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/clear_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_clear_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/assign_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags, \(.*\))/dev_assign_\\L\\1(\\2, \\3)/" "$f"
  sed -i~ -e "s/assign_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags, \(.*\))/dev_assign_\\L\\1(\\2, \\3)/" "$f"
done

...and then did a few manual touchups for spacing.

I only marked the first patch as a "Fix" since it is the only one
fixing observed problems. Other patches could be considered fixes too
if folks want.

I tested the first patch in the series backported to kernel 6.6 on the
Pixel phone that was experiencing the race. I added extra printouts to
make sure that the problem was hitting / addressed. The rest of the
patches are tested with allmodconfig with arm32, arm64, ppc, and
x86. I boot tested on an arm64 Chromebook running mainline.

Changes in v5:
- ready_to_prove => ready_to_probe typo
- device_lock() while calling dev_set_ready_to_probe()
- Add comment before "can_match = true" from Danilo.
- undef __create_dev_flag_accessors

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- Use a new "flags" bitfield
- Add missing \n in probe error message

Changes in v2:
- Instead of adjusting the ordering, use "ready_to_probe" flag

Douglas Anderson (9):
  driver core: Don't let a device probe until it's ready
  driver core: Replace dev->can_match with dev_can_match()
  driver core: Replace dev->dma_iommu with dev_dma_iommu()
  driver core: Replace dev->dma_skip_sync with dev_dma_skip_sync()
  driver core: Replace dev->dma_ops_bypass with dev_dma_ops_bypass()
  driver core: Replace dev->state_synced with dev_state_synced()
  driver core: Replace dev->dma_coherent with dev_dma_coherent()
  driver core: Replace dev->of_node_reused with dev_of_node_reused()
  driver core: Replace dev->offline + ->offline_disabled with accessors

 arch/arc/mm/dma.c                             |   4 +-
 arch/arm/mach-highbank/highbank.c             |   2 +-
 arch/arm/mach-mvebu/coherency.c               |   2 +-
 arch/arm/mm/dma-mapping-nommu.c               |   4 +-
 arch/arm/mm/dma-mapping.c                     |  28 ++--
 arch/arm64/kernel/cpufeature.c                |   2 +-
 arch/arm64/mm/dma-mapping.c                   |   2 +-
 arch/mips/mm/dma-noncoherent.c                |   2 +-
 arch/powerpc/kernel/dma-iommu.c               |   8 +-
 .../platforms/pseries/hotplug-memory.c        |   4 +-
 arch/riscv/mm/dma-noncoherent.c               |   2 +-
 drivers/acpi/scan.c                           |   2 +-
 drivers/base/core.c                           |  55 +++++---
 drivers/base/cpu.c                            |   4 +-
 drivers/base/dd.c                             |  36 ++++--
 drivers/base/memory.c                         |   2 +-
 drivers/base/pinctrl.c                        |   2 +-
 drivers/base/platform.c                       |   2 +-
 drivers/dma/ti/k3-udma-glue.c                 |   6 +-
 drivers/dma/ti/k3-udma.c                      |   6 +-
 drivers/iommu/dma-iommu.c                     |   9 +-
 drivers/iommu/iommu.c                         |   5 +-
 drivers/net/pcs/pcs-xpcs-plat.c               |   2 +-
 drivers/of/device.c                           |   6 +-
 drivers/pci/of.c                              |   2 +-
 drivers/pci/pwrctrl/core.c                    |   2 +-
 drivers/regulator/bq257xx-regulator.c         |   2 +-
 drivers/regulator/rk808-regulator.c           |   2 +-
 drivers/tty/serial/serial_base_bus.c          |   2 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c      |   2 +-
 include/linux/device.h                        | 122 ++++++++++++------
 include/linux/dma-map-ops.h                   |   6 +-
 include/linux/dma-mapping.h                   |   2 +-
 include/linux/iommu-dma.h                     |   3 +-
 kernel/cpu.c                                  |   4 +-
 kernel/dma/mapping.c                          |  12 +-
 mm/hmm.c                                      |   2 +-
 37 files changed, 218 insertions(+), 142 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

