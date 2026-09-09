Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C6447DF85;
	Wed,  9 Sep 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947557; cv=none; b=hcu692cUE3QclIhz5YPhUpvJoxfzqv9Pza+dHu61mxB1heTGp8SgHWtC+Tm1vSCwwdFHd/4mAryMV4RiazhKhEWLW8ZKkS2OVgO2M9CUObRwTC/0Hjy6jt1llW+1ADuEbcwB2V82/e8Sbx6360GMf6sGEYUyItELVBRWQ0Jha/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947557; c=relaxed/simple;
	bh=/v8FyrdGsbUZw+j3BUzd/Kxabdh1Cx/DyaS/EF65d74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vn55s3mbMwIzCCMUBcwjzt2UGh5tuH2ZmQNlgKGGNgTX80P/+Tu6vzBRsPGny1uVaWoLhk3n0mm9TrkeGW881kqbDv4J0BHHgtrL0tMVhMGkcuSgqUvnPzpRpsCNXL0a+ZNOn5BERgGVlqb1OqeHIfH2mWdQnjl4uy8XHtr7ilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBv3HfYq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBv3HfYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2D81F00A3F;
	Wed,  9 Sep 2026 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788947555;
	bh=A1mH6YXkKjYveaMEEmKxLa8h3j6vD8suFECLiBU+ZF8=;
	h=From:To:Cc:Subject:Date;
	b=EBv3HfYqinuqKoW5fn1TxTz4ApjsNiRStVFwX3lcFVJMpxaRcSERfMH5Qnj/3eIgj
	 Tl4WtM1ZAUbbgW4znyiugv6zJvlP0PtKiQzT/dYmBhf4qGg8vNDnyiq3n9LfwO6EgV
	 QaZqG6mBVr6DQCgefS+dJ98MLveQvBwYyTB2GZKw8HKrK2DjMdnTZvq6KyECkU1ILF
	 0BX3fAtRjg2kk/aOL9U67awk4PU0xlNNrVm0dXwiz5+frLQbokFBOhYLFpk86TkYPw
	 7B5yfEEkN00U1kNRdNwYmHpN6v20tiQa8gzeNMYUNYPObbhBVdoEO6rBxEZUmjOwCA
	 9Gk4rN0Zc4Rog==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4F86F1980050;
	Wed,  9 Sep 2026 05:52:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 05:52:32 -0400
X-ME-Sender: <xms:XiyhastfpMYf09d1ttYArPCf7TJBaJTfLsoEyodPKoLrS6KorUpcfA>
    <xme:XiyhagaJFLDFQglul_8JnD0j5JfMtpnMX5kaOgmY1vz6qiGk7GC2FCTBdtV5fh3m-
    n0Y4aOn2BlD1NkbZ9hluORZSO49RKDdtOWLYogaPOFGv07qTiyos_XD>
X-ME-Received: <xmr:Xiyhas0NUaO0EI_z-v8rH5KEZANLC4mn0RkTj8msTBYbpoxcqGG1S2MvpcA>
X-ME-Proxy-Cause: dmFkZTFdXEAt8Xoifn3HkMvmPrf3pdMTyQIQP6Aj3OujnVUZN6058eZl0xTCRZuAYJ+0HC
    8qc4gz01mjgRj+9r0kfXnzkY1H+KSr3uvCg/aQhbrf2lEreUjRytWz8OvpgHDh1c1a/rwH
    KO5/1ykH2rj8erZ+bSyokXSFrp8mX0/cyxOcNFl8y96joF53k5aRibyS/SShSTu6chBfYJ
    741Ug35JL3m8/wMe3559u2iJNdscI97Ja4MxvUprYMMMEOZ48IQH7BY8BVxwNDzJy8V0C2
    0deKwBYVFl0QBnpADvehmKoeLOgkYECDl8/Ukd5upAlpXGD851ILq+CLZ1ZzJg8SPyD3l5
    EMOg3u7PNME81Ch4t4yaBJHfb4jUZMvWKM6lOtY80loYkRwUAMWiICXCkUBrgNog1fi4ja
    063KZhqOn59ljj65C6vQ7nk/qpSbw+ahWlhYL6QkOP22NkX+6V5LrwCg6epGo8rxeMVKz7
    uuQSKzb8vpX0Ay0nKOT1vvUzzNOeXc0CYQ+f0ZkHaj/FDcWEERf/q27ganz5MBC/6SaP9+
    t9OApQn23jNdRDHbAZZm+3b7mrfJnKyamCQBS8IZPnnMwnKYHEJGVd+wkyak41iz6adQhV
    3hd5uCAH25srvblyvSv41IlZNyJM2UTR965FsoJGKshx3DWWxvzR1/x56cNg
X-ME-Proxy: <xmx:XiyhamVGm__Wd8wgJ3VTxeyP9ikGxJIUkNhU_-W47-CMTel4LJCABQ>
    <xmx:Xiyhanur1uuJPAMztkiXUApBkD1kEUnCERpIgh7l2EnKlSw0Czthig>
    <xmx:XiyhatVcrYRIED6j61FYUUpZeiD0e7GHvWeBJKEHUkAWMeiAgHTGlg>
    <xmx:XiyhajUt4LyHthI4m1uORmxaMOZ0uSYN8r-ChEzUvYoOLr4KBfztlQ>
    <xmx:Xiyhancs8FIZe3ZN_PtgD2z5d1IzGWxBDAjoqnbAnPnGtPJfInT9xpUb>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 05:52:30 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: [PATCH v6 0/2] iommu/arm-smmu-v3: Make the queue depths tunable, and shrink them in a kdump kernel
Date: Wed,  9 Sep 2026 10:52:26 +0100
Message-ID: <20260909095228.2174031-1-kas@kernel.org>
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

Patch 1 adds a cmdq_max_n_shift module parameter, decided in a per-queue
helper and floored at one page. Patch 2 has a kdump kernel default all
three depths to one page through the same helper. An explicit
cmdq_max_n_shift still wins.

Measured per instance under QEMU on -M virt,iommu=smmuv3, through a real
panic and kexec into a capture kernel:

                        4K page          64K page
      cmdq         1 MB -> 4 KB      8 MB -> 64 KB
      evtq         1 MB -> 4 KB     16 MB -> 64 KB

Every clamped queue lands on exactly one page. cmdq_max_n_shift moves the
command queue alone and beats the kdump default; the capture kernel
attached four devices with no CMD_SYNC timeout, GERROR or context fault.
QEMU exposes no PRI queue, which takes the same path. Build-tested across
4K/16K/64K, TEGRA241_CMDQV=n, CRASH_DUMP=n and =m, every commit
warning-free.

v6:
 - Take the parameter as a log2 depth and call it cmdq_max_n_shift (Nicolin).
 - Nicolin's Reviewed-by and Tested-by from v5 are not carried over, as
   the parameter changed shape.

v5: https://lore.kernel.org/all/20260907095835.1233352-1-kas@kernel.org/
v4: https://lore.kernel.org/all/20260902121724.3494954-1-kas@kernel.org/
v3: https://lore.kernel.org/all/20260706084708.8072-1-kas@kernel.org/

Kiryl Shutsemau (Meta) (2):
  iommu/arm-smmu-v3: Add a cmdq_max_n_shift module parameter
  iommu/arm-smmu-v3: Default queue depths to one page in a kdump kernel

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 75 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  2 +-
 3 files changed, 70 insertions(+), 8 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.54.0

