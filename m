Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=121.254.168.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943743;
	b=JND2CaVzy4MWNEHNXca82DSMFguksUmkup7pREJMvD7AZ/7z/tKVB9qqRqvlGwwdP1NP
	 WN4+/Brm4wj1cE74jQ37840X5InH/VRVl+DMGI8lC4XxWEvQrQgAnygjKWkwJO9v5WxMz
	 oJhFXY5z4+B8QEHcB3NpKl9e8qyYoe4w722fcmM2IFCmLmwd2+p7ytEZnGJO21t7fMftG
	 mZ0N+tWyhd3BbsooT1CBcK3XuF4WYEA+s0sRF45/FOTCwaQKFC5nzyLg3qswmzWLt/231
	 T2ZKc1XGg6H1Ci148Y4VO7I2SzTJKzCHzEx1JKG0FUNmWmnzMFWVuLKiyBFZHivr+hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943743;
	h=DMARC-Filter:Received:Received:Received:X-Authinfo:
	 X-Hiworks-Remote-IP:X-Hiworks-User:X-MailFrom-INFO:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7dLO/fRvE4k7/pK3hVg6YTkI/u7wKTkCu9vr+nYP9Aw=;
	b=vsE0zMYX2R6HPGBNv4LB+Rt/1sbWpNFRcoekYZ6bkHWYTZChxDiv2/gdH2H2ezwEbLIu
	 9yhzTbFO+WL8QICzfZuORTfSnMRc3eg18KFjM6QMdYN2IyCrHILKY6UPzPMAbNSrwAayg
	 Ye2jOEeBEp1sBh2NrmEYU0UVLTTVDpR90BEyVrk90yRpcOQff02RkL7sFF2eVQVYC4P9U
	 Hgffsfc0F+qAldx/02R+NLQWrgfKtG+owUeCCtfjGb3J/iVzweu1KA9ttMEYVejBI/KKJ
	 W3nJgPeEUN4h1j0Svw1CAWYR7s2HLYDUqvVBU1ry8DUWF4C3AgB5DOhLS2rjGZiQQCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nirvanahyj.com;
	spf=pass smtp.mailfrom=nirvanahyj.com;
	arc=none smtp.remote-ip=121.254.168.205
Received: from smtp3.hiworks.co.kr (smtp3.hiworks.co.kr [121.254.168.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8F606A32D
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 05:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C8F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nirvanahyj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nirvanahyj.com
Received: from hi-smtp-node2 (unknown [172.18.0.2])
	by smtp3.hiworks.co.kr (Postfix) with ESMTPS id 4jLSjw6vBgzYmkDs
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 14:42:12 +0900 (KST)
Received: from hi-smtp-node2 (unknown [192.168.71.87])
	by hi-smtp-node2 (Postfix) with ESMTP id 4jLSjw6TtbzQLN79
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 14:42:12 +0900 (KST)
Received: from hi-total-node5 (amphora-3294b420-308a-4b9e-8a1d-bf25580dae1f.openstack.gabia.io)
 	by hi-smtp-node2 with ESMTP id 7wrhactg2ztea5vp;
 	Fri, 06 Nov 2026 14:42:12 +0900 (KST)
X-Authinfo: HIWORKS SMTP authenticated <nirvanah@nirvanahyj.com|114.203.237.180|nirvanah@nirvanahyj.com|261106144212_6581351674>
X-Hiworks-Remote-IP: 114.203.237.180
X-Hiworks-User: (SASL_USER) nirvanah@nirvanahyj.com
X-MailFrom-INFO: <country_code:KR|rbl_level:0>
Received: from localhost.localdomain (unknown [114.203.237.180])
	(Authenticated sender: nirvanah@nirvanahyj.com)
	by hi-total-node5 (Postfix) with ESMTPSA id 4jLSjt5KQTzSqYc4;
	Fri,  6 Nov 2026 14:42:10 +0900 (KST)
From: Young-Jun Hong <nirvanah@nirvanahyj.com>
To: 
Cc: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Alexey Sheplyakov <asheplyakov@basealt.ru>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Simona Vetter <simona@ffwll.ch>,
	Stephen Boyd <sboyd@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"Vadim V. Vlasov" <vadim.vlasov@elpitech.ru>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/4] Exynos 5422: Mali-T628 GPU compute fixes
Date: Fri,  6 Nov 2026 14:41:47 +0900
Message-ID: <20261106054210.2893230-1-nirvanah@nirvanahyj.com>
X-Mailer: git-send-email 2.47.3
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

These patches make the Mali-T628 MP6 GPU of the Exynos 5422 (Samsung
ARTIK 10, also Odroid-XU3/XU4) usable for OpenCL compute with panfrost
and Mesa Rusticl. They touch three subsystems and can be taken
independently:

  1/4 iommu: the GPU is not cache coherent on this SoC; its LPAE page
      tables must use inner shareable, or the first large GPU buffer
      after boot hangs the SoC.
  2/4 clk: VPLL rates for GPU operating points above 600 MHz. The
      ARTIK 10 device tree is not in mainline, and the mainline 5422
      boards stop at 600 MHz; they can use these rates once higher
      OPPs are added.
  3/4 drm/panfrost: the job affinity names only the shader cores that
      are powered.
  4/4 drm/panfrost (RFC): power both core groups and let a job opt in
      to all of them; the L2 caches of the two groups are not coherent,
      so the default stays on the first group.

1-3 were tested on the board (Linux 6.12.55 based) and cross-compiled
on 7.4-rc1. 4 is compile-tested on 7.4-rc1; the same logic, ported to the
board's 6.12-based panfrost module, was tested with the matching Mesa
change: jobs without the flag stay on the first group, jobs that opt in
use all six cores, and global atomics stay correct.
Background, test programs and results:
https://github.com/nirvanahyj-com/mali-t628-opencl/tree/v1

The analysis, the code and the changelogs were produced with Claude Code
(Anthropic), a coding assistant.

Young-Jun Hong (4):
  iommu/io-pgtable-arm: use inner shareable for Mali LPAE on a
    non-coherent GPU
  clk: samsung: exynos5420: add VPLL rates for 650, 700 and 750 MHz
  drm/panfrost: only put powered shader cores in the job affinity
  drm/panfrost: let jobs opt in to all core groups

 drivers/clk/samsung/clk-exynos5420.c    |  3 +++
 drivers/gpu/drm/panfrost/panfrost_drv.c |  7 ++++++-
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 25 +++++++++++++++----------
 drivers/gpu/drm/panfrost/panfrost_gpu.h |  2 ++
 drivers/gpu/drm/panfrost/panfrost_job.c | 10 ++++++----
 drivers/iommu/io-pgtable-arm.c          |  7 +++++++
 include/uapi/drm/panfrost_drm.h         | 10 ++++++++++
 7 files changed, 49 insertions(+), 15 deletions(-)

-- 
2.47.3

