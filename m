Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2B314A9B
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900944; cv=none; b=KQWq992xwfNehc87qCXX7NMq+9imWo89VU8Q+pl43cVaSCDsy/lKHroQDAKIDN66L5/1QFnYKVnIXgehY5m1uULKVyctZlnq3v6kaoJV1qhKASTxvRbPCpLU+yxfHxmQZZ0r3Js3fhbyMseDSlppO9JJogZOXYp8FqFLvrmJcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900944; c=relaxed/simple;
	bh=OOzh7bxmQsAIOtnX1e9VNZVKWMQ/Xqzul1ueVTyt1c8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g2sJGUeMqIDcmBIf/RVMPdOhoAe1ACF/+as82rTmMSjz/kOblpNWUtb9lowuyVm/TZXAF39E2aKPbfIA4WlxiWyjRmnV6skLck4J+44amZmgFiKYArYBYIsAyZrteyH57HUAD7vveifa90r+bwjvCO+mUrE9TguL/fRl6PsJglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7HG+RYd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7HG+RYd"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82989744ee0so733388b3a.2
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 23:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773900942; x=1774505742; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7f7WqiVyVqTOxh8ghq9ArjCrLpIG+9mgtrGPDNjc48=;
        b=k7HG+RYdMiSrQemnWKepm40its0VyUEXbk9wNDUFSCR1/96J0sFm8zNXSHs3Iv6gvy
         iXYRc4gowYHHCZKL5Prn26RObOLBSj8L3RvoXK7gU/KI7QeWq1C9xAwWDVMFGy1NQNsC
         eUARvMsCuPzD5KBlIVBHSctZ2ZdHVfYbBpOpcadYtiQRIfZpPA01SNl7Hx55Dzwi3LfY
         brUMMUe7wRSS0kTJQ/Xom/K/vtgrZDgv4RdiGZ70Kd4Ia/2ZPeynt8aawOSbsxB74h8w
         URnKJzi/9zbLULGLu1a5qPan91zXVNrSI9hxQ8v14Meff7KOcCJbE8v7Lp616L28Ocn2
         5SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773900942; x=1774505742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7f7WqiVyVqTOxh8ghq9ArjCrLpIG+9mgtrGPDNjc48=;
        b=d04Tq3FADkurD//bwmPh09gXrBF/OoyPGLkleAdZqOf/OjVw/nirz03EeDdikZSooC
         K5zSTqOEpLrjTjiXhPdUvkrY+LC5SWfx7tdsmcfXf4MewStFolCB9MGVUR61gUMHgSRR
         CNuRgCy6KRE4iEGlSWgkCdfCiln+qnK+fJlasGPiZbAQpsEy65OU9Kvu8CgRMYCAR/80
         uH2mN9PT09OVdWmuTVJ760d9DCoF+yAUeApbrLX0eo/YzUHNRmxWgGkQhO+fY07RfpBG
         ffkrbnnWygngPBHdc/JbqS1Q+RZfQXBK40ImUMEmr1+VQjHdX5Xh74GMl7Qax5I1m23X
         STCA==
X-Forwarded-Encrypted: i=1; AJvYcCVb/ywHuudG+n/15ioKoRkj0OySLE9CgnPPO4vtKcRT0fIMxIvCA7OEPVsygn+I7JYGccyHyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0BWT8DBsENitZWzQ+OIdemNvqWvpUdpxCi7Cm19X5MiWN+xXi
	dto0AqiSvPzcJ6anCpwVySkayycNZS0qVZ9Gj5UW47hjBm1nPbDWYbEv
X-Gm-Gg: ATEYQzzNwi7Jpufo8pYZpo94Qm/wXCnhHSNSwqYVKO8wV4V8bpEn2iDmCjk2a44W5Nl
	D7I0GoeZvSiH+RKQb5XWIwgcLw7FHLNsHjmsB6/jJ8qXzgr3mz6vU5q//lpPYKXeSVGjFDE47Bc
	QK2JvQlwFUOyFoDSybN20+5f3f1kBnzHO+AfixmVmniXT1gju7mzh4OQwdY4cVmNJn6uRg2CSOW
	T3HzQ80C0iYNtgmSux8oP0zxyy1/4j30vgwvKxaC+1vPfd8i6N2G09+aXaJpMQLlYnt/SX2NN8l
	SxIuozaK1IcXv8rlZFb9mKzX2350FkPpG4V57WnrXaYujU8hoMlHoCNK/4Evsz2Iv42yFRib5Vh
	RdLWB+Vbrt10svHPLJZJuR04MgUcrm7NDwdELOQcD3v1iJ8P9CCYniBLhlpGQuW78ou8Yfkpw+f
	Ix9xeWlgym5HaJQWgn5p2B85SyhBkCnwC838IVKUjG1e1Xcv9LdasS2spBhVdIqmT9UxAn17INH
	Y82la01ztTlVw==
X-Received: by 2002:a05:6a00:889:b0:82a:7aa3:a2fb with SMTP id d2e1a72fcca58-82a7aa3a618mr2119918b3a.37.1773900942286;
        Wed, 18 Mar 2026 23:15:42 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (61-221-208-111.hinet-ip.hinet.net. [61.221.208.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bef5ed8sm5660824b3a.57.2026.03.18.23.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 23:15:41 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 0/2] iommu/amd: Preserve x2APIC and MSI support when amd_iommu=off
Date: Thu, 19 Mar 2026 14:15:05 +0800
Message-Id: <20260319061507.541-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Overview]
This patch series modifies the behavior of the amd_iommu=off kernel
parameter to ensure that x2APIC and MSI domain allocation remain
functional, even when DMA translation is disabled.

Currently, on AMD systems, specifying amd_iommu=off completely shuts
down the IOMMU subsystem. This causes the system to disable x2APIC and
fall back to physical flat mode, which limits the system to 255 APIC
IDs. On high-core-count systems (e.g., 448 cores), this results in a
significant number of CPUs failing to bring up. Furthermore, dynamically
added PCI devices (such as SR-IOV VFs) fail to associate with the
correct MSI domain, leading to IOMMU fault events and kernel warnings.

[Motivation]
On Intel platforms, intel_iommu=off only disables DMA translation while
keeping the necessary interrupt remapping infrastructure active to
support x2APIC and high CPU counts. This series brings the AMD IOMMU
driver in line with this behavior, ensuring stability on modern,
large-scale hardware.

[Patch Summary]
Patch 1: Adjusts the amd_iommu=off semantics to keep x2APIC enabled. It
ensures that the kernel can bring up all available CPUs on large systems
by maintaining x2APIC ops instead of falling back to physical flat mode.

Patch 2: With applying "Patch 1", patch 2 ensures the PCI bus notifier
is registered even when amd_iommu=off is used. This allows hotplugged
devices or SR-IOV VFs to be correctly assigned to the IOMMU interrupt
remapping domain, preventing INVALID_DEVICE_REQUEST faults and MSI
activation failures.

[Verification]
Testing was performed on a 448-core Lenovo ThinkSystem server. All 448
CPUs are successfully initialized; SR-IOV VFs are created and assigned
interrupts without faults.

Adrian Huang (Lenovo) (2):
  iommu/amd: Keep x2apic enabled when appending amd_iommu=off
  iommu/amd: Register PCI bus notifier when appending amd_iommu=off

 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/init.c      | 81 ++++++++++++++++++++++++++++++-----
 drivers/iommu/amd/iommu.c     | 14 ++++++
 3 files changed, 86 insertions(+), 10 deletions(-)

-- 
2.47.3

