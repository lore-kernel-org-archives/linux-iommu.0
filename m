Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425057;
	b=SEdE4f+TdL8XiARExInuYnO27cI5cXn82OFVSbwopeKuv1x+fIsBmhp6sqGLm7sZ1WNT
	 tNHqk1xayl4p+GBLXYRb42lQ6stqpftJ9lSmMFKZSpHs3n59f1y1sElncHfrXJeHHuWcJ
	 GbEG0GP/ZGvOyXtce67GqZxunUROCw1xu7eSsC6YKbmZUIAt0YTqCdZagUz5S3sJ6xi/P
	 h5tSwNdAG1LbNUeRWM95f2WTicWck+x6XU2sXaXTBavarTsV4Wu6vzK2LCHRGyYj5keHQ
	 R1cvANQJv6r42EJmAa7Mtv415zFv2vhwyPXuXgEwRqTHuUoqLgN0FsUt1lJ7/hwyZoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=J+uUyLbFsNGSkOGPD0jT6rigmy2Vf3Zbwe9gzT+xN/I=;
	b=RMqmjSM5AQdWL0V0lGQx1Iwc3FrsCP6RTN43PjuCP0JFC1nGkxO0ok8edOE32sHbletB
	 5r2yd2v4CQGRLwoiu7BqfOKc5f40oHwV/+kuzw3NeMylL+CycEu02wbR/PXZ1sZWKgNrd
	 Cwtuuph+p+70K5rpXIe1uZgK7t2suumYstQ5AmFT+23Kx1Wp6wZG+rS/oa6ZmhrSO5oMG
	 6pPus4ykhGltSYXBW1TSXLJpN3QVp9XAy8nhWR7MFn02KVpzb7/DulQGvQNL0PAYH0Urj
	 q4EDYJkx6tVnVloMVte5oOtks4tx7S/OtrIpvRRjXdcCMYaEvg8KOJHL9IhVNONcnIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DLL9CVr3;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4A606A32D
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 19:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA4A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DLL9CVr3
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-54dbbf252cdso4001986b6e.2
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425055; x=1795029855; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J+uUyLbFsNGSkOGPD0jT6rigmy2Vf3Zbwe9gzT+xN/I=;
        b=DLL9CVr3RLgx5kWZp1heu3019yhUAQKlFUqRz/RNxVR+HLVsXYQLbIbkIb3T7rrUyW
         8a9w6jdeVhFCV7gRgQyzMXsP1NNHjdpTd94CB6yS8yL2Rc9Jf5dlQoXkEATff8lZYLSC
         ZiQrfH++gAvg7t2KIjf4lziTSI1XVrfhuaWmfKN+gzmd6/vPMH2IKWjJDbY9i2NcsBT0
         1EGP4z8BRX1FkG/nLQ+MoQWZyQLtGCAA0BFpAusJQcMb5tLpqcy1MTl+TzzxnodNYMwC
         OCeV5AXTaQ7RRDxYMHGQfljXDauHxFuHAKNvKbUZO67VhGppgTJOtaBgAPwv5t5qXDC7
         WieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425055; x=1795029855;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+uUyLbFsNGSkOGPD0jT6rigmy2Vf3Zbwe9gzT+xN/I=;
        b=kHz/ooYu1zAKuF3lvAGG/a70yR/VWqNQeqIqLlTvWpuB40lDTYMh7kdwFGfnkurM+N
         jXRTrtK0ZPg2GbRZiPdCr18EqJYGZOfSnzqghShaI03qZblpbeAAnJOQp+CffzmEgHMZ
         SwlsjYsSEu5cwCo1i98jCKcsmAzc20h1oo7alFzlQiJe7TrW+81tTUMojX4nfdZmspf0
         bnCHmga6geV2DPcEzek9MGRdhZqnfuenGtMEHGKN2LBvaHdbte3xSU41JbXEWLcjZxSc
         vJiBdbsCoPiZ3yJocIYRzQHf+wIxAPYQ1NXyUImsg2SdMRm5+arLZr5JiyXwcXhFosji
         GihA==
X-Forwarded-Encrypted: i=1; AL+hErFsC4D8JU1QvWPRFdpZZTORNs6DnzFas5T0c+o+XgGyOdG0lYmyUB3K9kCbPumvvuiRSmcnHg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+o3iZW0v9GbODosGQXZACHUR28SUdWKT9W3xGU9TLFBVyiCrJC
	/OYVWIceJZa7GM8Kw6Rac7lGRzuDT7/q7LgoWBDGByeQ1KTVzPeR9Q5nelJmNfSDxH+umn9/rMv
	j4BJZzyf0ADTq3g==
X-Received: from iouw14.prod.google.com ([2002:a05:6602:34e:b0:9e0:ee3f:c3a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c1b2:b0:4d6:90f4:48ab with SMTP id 5614622812f47-56b97c18413mr3157501b6e.45.1794425055330;
 Wed, 11 Nov 2026 11:24:15 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:04 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-1-dmatlack@google.com>
Subject: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/vfio/selftests/p2pdma/rfc/v1

This series adds a peer-to-peer (P2P) DMA selftest to the VFIO
selftests. The test pairs an initiator device supported by the VFIO
selftests driver framework (dsa, igb, ioat, mlx5, or nv_falcon) with a
target device that exposes a memory BAR, maps the target's BAR into the
IOMMU, and uses the initiator to perform DMA reads and writes targeting
the BAR.

No changes to struct vfio_pci_driver_ops are needed. Because
vfio_pci_driver_memcpy() already takes source and destination IOVAs, any
existing selftests driver can drive P2P DMA once a peer's BAR is mapped
into its IOMMU address space.

There are two motivations for adding P2P DMA support to VFIO selftests:

  1. Exercise the P2P DMA paths in VFIO and iommufd end-to-end,
     including mapping BAR mmaps via VFIO_IOMMU_MAP_DMA in legacy
     type1/type1v2 modes and exporting BARs via
     VFIO_DEVICE_FEATURE_DMA_BUF + IOMMU_IOAS_MAP_FILE (and dma-buf
     revocation) in native iommufd.

  2. Lay the groundwork for testing uninterrupted P2P DMA across a Live
     Update in the future, building on VFIO PCI Live Update support [1]
     and the PCI core changes to keep preserved devices accessible
     across kexec [2].

Patch 1 comes from v3 of Mina's huge_fault series [3] and is included
here for convenience. It adds vfio_pci_find_mem_bar() to locate a BAR
range that behaves like ordinary memory, starting with QEMU's
pci-testdev.

This series applies on top of vfio/next (vfio-v7.4-rc1).

[1] https://lore.kernel.org/kvm/20261102153656.1431701-1-vipinsh@google.com/
[2] https://lore.kernel.org/linux-pci/20261019213054.3157159-1-dmatlack@google.com/
[3] https://lore.kernel.org/kvm/20261102230445.3993629-3-almasrymina@google.com/

Series Overview
---------------

This series implements the following:

  1. Add vfio_pci_find_mem_bar() to locate a BAR range that can be
     safely read and written like memory, starting with QEMU's
     pci-testdev, and verify that writes stick before returning it so
     that unbacked pci-testdev BARs are skipped (patches 1-2).

  2. Allow VFIO_SELFTESTS_BDF to contain multiple whitespace-separated
     BDFs so multi-device tests can run via run_kselftest.sh while
     single-device tests continue to use the first BDF (patch 3).

  3. Add vfio_pci_dmabuf_create() and iommu_map_file() helpers to export
     a VFIO PCI region range via VFIO_DEVICE_FEATURE_DMA_BUF and map it
     into an iommufd IOAS via IOMMU_IOAS_MAP_FILE (patches 4-5).

  4. Add vfio_pci_find_p2p_pair() to find a compatible (initiator,
     target) pair from an array of VFIO PCI devices, providing a central
     place to check P2P topology reachability in the future (patch 6).

  5. Add vfio_pci_p2pdma_test, covering RAM-to-BAR, BAR-to-RAM,
     BAR-to-BAR, and RAM-BAR-RAM roundtrip copies across all supported
     IOMMU modes, plus iommufd dma-buf revocation when
     PCI_COMMAND_MEMORY is cleared on the target (patch 7).

Open Questions
--------------

  - Re-mapping after dma-buf revocation: Clearing PCI_COMMAND_MEMORY on
    the target device calls vfio_pci_dma_buf_move(vdev, true), which
    notifies iommufd via iopt_revoke_notify() and unmaps the BAR from
    the IOMMU domain. Re-enabling PCI_COMMAND_MEMORY calls
    vfio_pci_dma_buf_move(vdev, false), allowing the dma-buf to be
    mapped again, but dma-buf has no callback to re-populate iommufd, so
    the existing IOAS mapping stays unmapped until userspace calls
    IOMMU_IOAS_UNMAP and IOMMU_IOAS_MAP_FILE again.

    Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
    uAPI behavior? VFIO_DEVICE_RESET (and runtime PM transitions) on the
    target device also bracket the reset with
    vfio_pci_dma_buf_move(vdev, true) and vfio_pci_dma_buf_move(vdev,
    false), tearing down any active IOMMU_IOAS_MAP_FILE mapping of that
    device's BAR even though PCI_COMMAND_MEMORY remains enabled when
    VFIO_DEVICE_RESET returns.

  - Physical target devices and P2P topology checks: mem_bar_descs[]
    currently only matches QEMU's pci-testdev, and
    vfio_pci_has_p2p_path() does not yet check PCI topology or ACS to
    verify that P2P traffic can flow between two physical endpoints.

    Suggestions on physical target BARs to add to mem_bar_descs[] and on
    checking P2P reachability from userspace are welcome.

Testing
-------

All patches were build-tested individually. The series was tested on
x86_64 in QEMU 11.1 (membar-backed=on requires QEMU 10.1+) using an
emulated Intel 82576 NIC (igb) and a pci-testdev with a 1G RAM-backed
BAR2 behind an emulated Intel IOMMU:

  qemu-system-x86_64 \
    -M q35,accel=kvm,kernel-irqchip=split \
    -device intel-iommu,intremap=on,caching-mode=on,device-iotlb=on \
    -netdev user,id=net0 \
    -device pcie-root-port,id=rp0,slot=2 \
    -device igb,bus=rp0,addr=0.0,netdev=net0 \
    -device pci-testdev,membar=1G,membar-backed=on \
    ...

Inside the guest, bind both devices to vfio-pci and run the test (BDF
order does not matter):

  # tools/testing/selftests/vfio/scripts/setup.sh 0000:01:00.0 0000:00:0d.0
  # tools/testing/selftests/vfio/scripts/run.sh \
      tools/testing/selftests/vfio/vfio_pci_p2pdma_test

Or via run_kselftest.sh:

  # VFIO_SELFTESTS_BDF="0000:01:00.0 0000:00:0d.0" \
      ./run_kselftest.sh -t vfio:vfio_pci_p2pdma_test


David Matlack (6):
  vfio: selftests: Verify memory behavior in vfio_pci_find_mem_bar()
  vfio: selftests: Allow multiple BDFs in VFIO_SELFTESTS_BDF
  vfio: selftests: Add vfio_pci_dmabuf_create() helper
  vfio: selftests: Add iommu_map_file() helper
  vfio: selftests: Add vfio_pci_find_p2p_pair() helper
  vfio: selftests: Add P2P DMA selftest

Mina Almasry (1):
  vfio: selftests: Add vfio_pci_find_mem_bar() helper

 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/lib/include/libvfio/iommu.h          |   9 +
 .../lib/include/libvfio/vfio_pci_device.h     |  23 +
 tools/testing/selftests/vfio/lib/iommu.c      |  29 ++
 tools/testing/selftests/vfio/lib/libvfio.c    |  53 ++-
 .../selftests/vfio/lib/vfio_pci_device.c      | 181 ++++++++
 .../selftests/vfio/vfio_pci_p2pdma_test.c     | 435 ++++++++++++++++++
 7 files changed, 717 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_p2pdma_test.c


base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b
-- 
2.56.0.567.gdb80ae8cd5-goog

