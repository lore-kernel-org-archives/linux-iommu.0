Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478290;
	b=V8Edjh13a/fUC67j7pLemON3nJFyQkmBR3cTVSroC4BDnIM6V4Ajk3DdlczIhBd8uXRj
	 oladtAegQ3eqqnT2/RQJdezyqRIK0oivHNSRb43TiWG3Aml4q90xOJUdHb4gXUQk5ioTl
	 jSrZBFGL0W0tz7JGRuROTXJ9UOv7wKzwTDDdUNY2LskU+PdDJ3E8hP5uwz+Jm3ZOkEwt+
	 F1h/gU3tEV6phS278oVhUSsAO6/LMD0s6pbJVw+NLbeB/meH5m8y5W1LfNX3S78YgXTWO
	 Hq1DrTZ7RaUGrBVPmyC2Jz/xhr1cJR43i8lbyweZHCnGYzyizTVonRll9KQCK6baAFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UzAZEenc0KxEq0x6RyPzYufxdEkxW9SFi1K+hoFFagM=;
	b=v6S4qoxRB6YVivDMVDRBT6QeP/9r1j/sNoCBlWmbLeFR/RBaRRwX8dhY14fli6Q9rqOQ
	 i1O4jC1a7FA22H1eaAymylxkRXz+6XTZDyaOv/LYoDWOpApSMKcrN6CxcJAxRs3q/QjnT
	 /DfGYKWwUHbzsc1tWPZghYARc9lkc2zIkU60Iqb7N1c3SQwET85BRQYHk4ZL9nPezUH8Y
	 EBT3Prza+xSOBNp3o0iFXbEEJqIpUY0mlL1PKVWkSlejEhy+yWfQk543+9Z94ZcOCpXYm
	 TFOkQKxVB7En1c3mh0R7xwjNCRpGHrpO460w4AmAZHTjR2nmtV54yeKwf8g6rA0SI3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k+XJDQzv;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59A606A31F
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 06:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC59A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k+XJDQzv
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so3450115e9.0
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 23:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792478287; x=1793083087; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UzAZEenc0KxEq0x6RyPzYufxdEkxW9SFi1K+hoFFagM=;
        b=k+XJDQzvgwEivSzXtaXJt2nZaDQwY1f4HIMLCkLGpYDUPRJt/8WfDiNS1x+93cJkOA
         Ve833K9SVzM7r5vC9D2xO6s3JMEzdaITt5jQMMCuKOaYZyE/lnldbQ2IosoxZ7Z5eHpd
         /+jACtleuEnWg0xWTBjVhgV5yJcC4k7Hds8C6348cWSoeVjcIzb+oHoKgrv5c3l/F/M1
         C/q2HoFOLr/bzallXF/xB7vXVrbvp69Lqu/CXbwHs0rvjIcqVzzhAOAygA6QaOWwUasl
         DNp0lbuBiCuTVHkjggiczssusTGkhzz6WvvSIVwfZs8pdgnWLFJkqb45ICsfVk+G6Zs1
         Wy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478287; x=1793083087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UzAZEenc0KxEq0x6RyPzYufxdEkxW9SFi1K+hoFFagM=;
        b=G5H7FI54ussemLsEJLdic+KT+sDQZLkJH0IgoJZa7xR7GGskD91nfAFC4UtsW8Nwiz
         X2glEshWOWMYf169HtDrRbADnmhbHVxiNyWADFVYMCOyyrex1pES2VQ90s2PKe93uMlS
         rTrE75VdGDWVXqAUgTBolFIF6aD/rlNwMpA8Nfg382gY9kUMPT29vfdslcjjuulA3c1M
         7cQykOCl3GJ0mzCrU9CALE10WBnTUfu/Gu7qoOrcx66STcPiHEVahjxyOpowxe1ZNzr0
         i6VzjtM7m5BcmHyIFnhrNPdWmSE2+aAyAykEaz9MdnBOGFZU19Z04M2MK8lI0/yW410U
         426A==
X-Forwarded-Encrypted: i=1; AKwUvBw+eUXE/O75XAtudU0OtcxaONDPnzBgFSyDwmOA3koKDtKdVsgwLfRVDC5YJIcGIBMBVYwSog==@lists.linux.dev
X-Gm-Message-State: AFq9FYLzmD9yZ7lV8LTsyahrIsG26j1/0edKYliDoeTXFOE9O5nNMCtg
	2n7mAPD5z7Gu8Rcos/SjQArQ6BOSh3Im6od3eVlCc9rctmfPCD5UfVq2
X-Gm-Gg: AYBFou0B7t8lP55ZnprOit5xf7VXqKKPaSUen2FG5ZmMz2kV30kq9vNKcr3H45QsrTm
	K7/NxYvtf3XVR/zWkV6O96DrZ9FR2yekX2LgrKrTp8M6wY2K7cOFaGh/enP+BY2PsZpJS9KrHra
	SuUN8sixLgLIEiMvwthQmTxOir3XFMsxBCdwrBSbbEmbJOAkYkSoTWS65qxQDt8mCQXafvci0sN
	MmEKv58XNQOqdTI7nvo7/qgoeliR8uCd9rdP4925XJTIvj9qVLg0aOGcMJ3n+OnktPdg/7PKlGp
	XOuES0oTnbY6UmYFX2zSCMi6M47fAnzZlwoOK8vmjtBkoK2PjJ+OziOxU8KtbHdDzusJYs/xgA+
	ZFgQp5eI7Kyzr3KTOFoc4coDWXU84vQJG40d6fioO03zCFFwfH8TsKOWd8PMEvCiUEB+r5EKBEg
	2yJMfCcOUbNO9D3dZWqNn045X/PXRAvHT6QrNBAjNrA1Jw4X/HU/dp+60b9qFS0kD6hrWbhJOwz
	Fz7IsHkCrAI0tjW79ZzexL/7sC79dE9qEsAsdgbHoU2VgOdw2V53rhi6fnq3Yhfz51UfcJhSeEu
	DRoEMuxDa/AguXS/dvZf5ZLDwFspcCJGVg6tikcKkRyVjVevORvaUomCy09IecFWZxwGYRi/hag
	pqIfP62MrzqXU
X-Received: by 2002:a05:600c:3114:b0:4a1:ac66:604b with SMTP id 5b1f17b1804b1-4a1f4c70117mr24583145e9.1.1792478286893;
        Mon, 19 Oct 2026 23:38:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de. [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 23:38:06 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH 0/6] iommufd: harden DMA-BUF PAL setup and release
Date: Tue, 20 Oct 2026 08:37:39 +0200
Message-Id: <cover.1792477872.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a narrow companion to Jason's unmerged DMA-BUF mapping-type RFC. It
fixes setup and release problems in the IOMMUFD PAL consumer and adds fault-
injection selftests. It is not standalone and requires this exact base:

  c37cf2824740d ("cover-letter: Add DMA-buf mapping types and convert
                  vfio/iommufd to use them")

I used LLM assistance while inspecting, testing and drafting this series.

I also tested DMA-BUF paths on a Raspberry Pi 400 and Pi 500+, using their
stock Raspberry Pi kernels (6.18.39+rpt-rpi-v8 and 6.18.34+rpt-rpi-2712).
Both passed offscreen CPU/V3D byte checks. The Pi 400 also passed five raw-MJPG
payload-prefix comparisons through V3D; this was not direct or zero-copy camera
DMA. Neither board ran this RFC or IOMMUFD PAL. The Pi 500+ connector state and
mode remained unchanged; the tested buffers were not scanned out.

RFC:
https://lore.kernel.org/r/0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com/

Jason's branch:
https://github.com/jgunthorpe/linux/commits/dmabuf_map_type

This series:
https://github.com/kmehltretter82/linux/commits/dmabuf-pal-lifecycle-rfc-v1

Diederik's RK3588 testing produced a useful trace through
rockchip_gem_iommu_map() and iommu_map_sg():

https://lore.kernel.org/r/DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com/

Jason noted that this showed the same private-IOMMU-domain mapping need as
IOMMUFD:

https://lore.kernel.org/r/20261009125338.GB13920@nvidia.com/

That trace is motivation only. This series neither revives my warn-only
mechanism nor converts Rockchip. Jason's feedback on that mechanism is here:

https://lore.kernel.org/r/20261009124259.GA13920@nvidia.com/

Compared with Jason's branch, this series:

  - preserves dma_buf_pin() errors;
  - publishes the attachment and successful PAL list together under resv;
  - unmaps and clears the published PAL pointer under resv before unlocking;
  - keeps callback state alive until dma_buf_detach() returns;
  - calls dma_buf_unpin() while holding resv; and
  - tests pin/map failures, cleanup counters and retry on the same DMA-BUF.

Patch 3 follows an earlier forced-window arm64 QEMU/KASAN double-free report:

https://lore.kernel.org/r/20261016194022.62065-1-kmehltretter@gmail.com/

The proposed release order is:

  resv lock -> unmap and clear PAL -> unpin -> unlock -> detach -> put ->
  destroy the pages mutex

Questions:

1. Is that publication and lifetime rule correct?

2. Is c37cf2824740d still the right base for this companion series? If not,
   which tree should I use?

3. Can these lifecycle fixes stand independently of moving final mapping
   selection closer to map time?

   https://lore.kernel.org/r/20261016202653.97339-1-kmehltretter@gmail.com/
   https://lore.kernel.org/r/20261019184123.GR13920@nvidia.com/

4. Is the per-buffer selftest control acceptable, or would deterministic
   setup/release race hooks be more useful?

Testing:

  - arm64 QEMU virt: two boots, 24 selected cases per boot, zero skips;
  - x86-64 KVM q35: two 24-case candidate boots plus one focused four-case
    pin-failure boot;
  - a one-defect x86 control failed all four pin-failure variants on the
    expected erroneous successful ioctl return;
  - x86-64 GCC 13.3 built the exact head, headers and IOMMUFD selftests; this
    build was not booted; and
  - KASAN and lockdep initialized with no diagnostics in candidate runs.

The QEMU/KVM campaigns use mock IOMMU domains and the selftest exporter. They
do not cover a non-selftest PAL exporter, physical DMA/IOMMU, forced
invalidation races, or the complete IOMMUFD selftest suite. The x86 negative
control validates patch 1 only; the earlier patch-3 report is separate.

Testing with a non-selftest PAL exporter would be welcome, especially failure
followed by retry, invalidation during setup/release, repeated revoke, and
multi-range buffers. Please include the base, config, architecture,
exporter/device and full dmesg. A full IOMMUFD selftest run on another
configuration would also help.

Thanks,
Karl

Karl Mehltretter (6):
  iommufd: Preserve DMA-buf pin errors
  iommufd: Publish successful PAL mappings under resv
  iommufd: Clear the PAL list before dropping resv
  iommufd: Keep the pages mutex alive until DMA-buf detach
  iommufd: Unpin the DMA-buf while holding resv
  iommufd/selftest: Check DMA-buf pin and map failure cleanup

 drivers/iommu/iommufd/iommufd_test.h          |  24 ++++
 drivers/iommu/iommufd/pages.c                 |  24 ++--
 drivers/iommu/iommufd/selftest.c              | 111 ++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 121 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  30 +++++
 5 files changed, 298 insertions(+), 12 deletions(-)


base-commit: c37cf2824740d833b21eb816e21f94836100291f
-- 
2.39.5 (Apple Git-154)

