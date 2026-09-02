Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3747CA8A;
	Wed,  2 Sep 2026 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351496; cv=none; b=V56Try6EMdYWIWfHEio5JoMI61rPOiwGJAyWV1VzipQ1teYI0eqUBW5dvw+6xU7O2XtQl0ehuLnMIXqngve41vv2OrTS/FnJmf5bP8TaLhBX17iGlPinG6BNRB58gxmqPs8yDoX8WaNTJ6bYQU5QVAfLWMV6clPjm8B1zd39k+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351496; c=relaxed/simple;
	bh=k3ZVD5JMlai5eGRWQPDrQaoaxvWQCjnBRIU2KtGMfxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsA1rexDA9liO30oM/VKEP9lxxbzZC7dWymfqDh+G5YdRI7e4do0FDZnPH4y9ojIug23OHfysQA1BEuOXcofEjpW+IWk3utWFvi3w5+FcJ+Wha7U/ygbtjI16DOF8kPBntUBqWQXX6gmuK3Byypvmmqb6Ly9YBO0QrkVrv1rYQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1ghggei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1ghggei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C82E1F00A3D;
	Wed,  2 Sep 2026 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788351494;
	bh=YhPSIXHdToiGcaqd79fdmw3XU7GLfIRh50kF9qU1jso=;
	h=From:To:Cc:Subject:Date;
	b=Q1ghggeiKqvI9NApI9GNsQFSKe1CI1FmKgSIKkolKnCvtp5+o7lXNGMxBPyWvuI23
	 3D63PZCabagZRyTWYW574OhVJW5P0HEPxKuJW//6Pf0KpPyrieENeSLD+DN+58eJHm
	 7bKt6sc8z8aVDU05mlxY5G86uYBM3yyie7byUHDI9FNEJWP4iQiP2EizaTJ+jYUf3K
	 aaiYNp1x3eyeBq105F3EBffZ0xF4VHA/Oz5RNwAbWstaYoVgoLKdiHDhP3/l857CFY
	 vEO/41LfwQtV9zg2pa1yU9xFhGtbgmKoAWCBOt01YrBJAvPumgNrK7x/fbf6vOFXcB
	 FDz+9sPn3inww==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8A52B1980047;
	Wed,  2 Sep 2026 08:18:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 02 Sep 2026 08:18:12 -0400
X-ME-Sender: <xms:ARSYaiWBKoWrKeZFf-PSFHd57k_mCh3jyrl-I7FRVrO7atAw5Rkacw>
    <xme:ARSYaliYHxySxbd2Ifnm7q2ntVpCFKuUL32v_RaVznfT0IvP_RA4t8XrTnUQaxW0V
    VER6VH3eNUIZ5iqlG7Xj3MhnDWT5Yhxa-CO8sWLEw-sH1B7lextP1Q1>
X-ME-Received: <xmr:ARSYarc_Ys8Dixp7XFnIhB2qCDRA-zErOop1h6Mz8jYYd5l5YIK-1U7epoI>
X-ME-Proxy-Cause: dmFkZTFxcxWBUMmCGUYTzHIBFXChJL048yU1tUCJoUmE055C1DdrJJMKYdvMxSf8ayH7Oc
    WW99ucrNMnMi72vDOcOYanv1/fCOMldtkrN+Nq9epu/39Bs4Z7ovcMCCC5o1Mkvg68ueYu
    Gv4V97g/rvY2ll3V8dMTPAiXaZ17SKE6JVLkqIRrVw9QkMnnw84ktuMpGsQ71VAtkeSdKx
    cs3VUx7NI/0LSdHtPryG8sWhkT5L3NUF1B1iUxGHiy48on7QctR9fZ3yF7JGxYTSgCNs42
    60hHQ8L03nbINRMwYss+QHjZR1hdcKgX/73T0stkq4GpB71mFHJl8+BoWFu3zosA8PkpMi
    CUdoUtbPaVqIz9mjHDjDpYQhJaOVyv3HAsW970BOSljTDTlixU7+NdcXzlFF+ThfegapWr
    r4xIt8x25tAYpDVomeJNgkUUOdcyjOlu1jhC/UtPRJYT/1WvQFL76l8NpvRmB4K1lTDSqL
    7cNiP3ZyKqYEVI/kkpy2CFSbLXNJM7n4dQb6EWwWqq+JG4cI3pmuIK7R+zqvXlLhz6dE59
    evWHprf4PWKmpARnGR97qfr4N7w8KVAoYVpAKCDPwCCR/gIxtDaCWb4yHMqviVe4i5Jpa7
    h2tXcuKhcJ5HzR2oYgVaYbhG5eDIVfekE44IFcLBooYYPkSJePSpo8zVEsXA
X-ME-Proxy: <xmx:AhSYagfDfSUc66x6h2oPERZxttSZ_hdr2o00tR5sBUaMoWADzYyR2Q>
    <xmx:AhSYanVIl-qoAaNOi1UVRy1CHU6Bqar3jkOdLECXumHP3AcyXDpQ9g>
    <xmx:AhSYakfPMIzb9BCoifNYOaP9coHX1s5SFO8-UW2u3nVZBWWm2R8W4A>
    <xmx:AhSYar9TwmVgcUEYRD0LlZto_xA3-tQMI88pKIz4Q_cvKki7SbvdIA>
    <xmx:AhSYajmREp2ekNjshg3WYPuG0GZpHck0pnHNzq3edDWYNdTPAOM_Bmex>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 08:18:09 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v4 0/2] iommu/arm-smmu-v3: Make the queue depths tunable, and shrink them in a kdump kernel
Date: Wed,  2 Sep 2026 13:17:22 +0100
Message-ID: <20260902121724.3494954-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The queues are sized from the IDR1 maxima and allocated at probe, costing
megabytes per queue per SMMU instance. A kdump capture kernel pays that out
of a small crashkernel reservation, for queues it barely uses and two of
which it switches off anyway.

v3 clamped every queue to a page under is_kdump_kernel(). Review wanted a
general mechanism instead, so patch 1 adds a cmdq_entries module parameter
at the max_n_shift initialisation in arm_smmu_device_hw_probe() (Robin),
command queue only (Will), floored at one page (Jason). Patch 2 then has a
kdump kernel default all three depths to one page through the same helper,
with no command line needed (Jason). An explicit cmdq_entries still wins.

The v3 Reviewed-by from Breno, Pranjal, Jason and Nicolin, and Nicolin's
Tested-by, are dropped: this is not the patch they were given to.

Measured per instance under QEMU on -M virt,iommu=smmuv3, through a real
panic and kexec into a capture kernel:

                        4K page          64K page
      cmdq         1 MB -> 4 KB      8 MB -> 64 KB
      evtq         1 MB -> 4 KB     16 MB -> 64 KB

Every clamped queue lands on exactly one page. cmdq_entries moves the
command queue alone and beats the kdump default; the capture kernel
attached four devices with no CMD_SYNC timeout, GERROR or context fault, so
batching survives the floor. QEMU exposes no PRI queue, which takes the
same path. Also build-tested across 4K/16K/64K, TEGRA241_CMDQV=n,
CRASH_DUMP=n and =m, every commit warning-free.

The kdump stream table adoption series drops the event and PRI allocations
outright as of its v10. This sits on the same base, applies on top with no
conflict, and sizes the command queue that series leaves alone.

v3: https://lore.kernel.org/all/20260706084708.8072-1-kas@kernel.org/

Kiryl Shutsemau (Meta) (2):
  iommu/arm-smmu-v3: Add a cmdq_entries module parameter
  iommu/arm-smmu-v3: Default queue depths to one page in a kdump kernel

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 61 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  5 +-
 3 files changed, 59 insertions(+), 8 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.54.0

