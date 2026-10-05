Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD125393E
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211071; cv=none; b=YSXwljoZkFyAY+vERyqzN8nBp6ILzb4xgpBMyJqHfxJ/Aky3ncNdE/QapGP1bEwoj5hxdEN8NsZMiTf4gEvAgoIECaaQf60YwtjXoxSJcVgwmnFZxu4TrAnsuy9lmrkmlGAu9rYZbnjTCAYtMHexvJJL8NVFpPnAHP2Q61hAu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211071; c=relaxed/simple;
	bh=XMLrGbedguO2MBiVSIISwnSja9N+qK6r3eVRTxmWl6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4pQm67bbumleKqkjMQuESQ3SfPbo1eREZ7iH2zm2M+vfchx70soRlumSrREOGa6LGGS1iuN/V/+XuKk72CLdAgHhZvFAK3yjQGVlTKMMx8zPSMr8WIzTWZeM68uZLHr1oggv9ZfyXMaWpFStMwO/BsJPW+bcUyxtpqQ40EpmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEESLVxC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEESLVxC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1728d8dfcso9497845e9.1
        for <iommu@lists.linux.dev>; Mon, 05 Oct 2026 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791211062; x=1791815862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uiX4TTvsWBCxTAoZ5BYlS69N5ifB0LlN73jBhn7IiHk=;
        b=TEESLVxCh3cW5ErJgsC1wBp72NV+PMa4E2AkUhiPPzhgqZTxOqnv6kSr1Mfc3oBBi5
         wPORxLhnh3lvJL75N3KqpBDkrJYXB15AcvukhXL0OdKq+I1GArzGYDAt/ZogEAEzwun7
         m08PHL+B/22oiei3D+4qiYpGnYER6rfjVoi4UpxW7Sezrb9DW9/4GJGP6sy9sNN3vKOt
         zjJYprwT+BNuj3afSp6GkEp5mmexiM0F1dOFMhP2oLV6w1CdBujEthmDmLNk/Z1MXgIW
         lnupRa7BPhXXj/76zmN7xS5rBJn3ZPa/gN+9fIKxnpNVnkPGCwnb7ovwU1XbtxWxKfwD
         PSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211062; x=1791815862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uiX4TTvsWBCxTAoZ5BYlS69N5ifB0LlN73jBhn7IiHk=;
        b=pTKMu3wKldZrDIC6w6NVP1Q5gN6PxBUegwUTA/MCKUwKWnGFN+O7CENbki9nJIyF5N
         hemfSqSqE4kQt1JE1sIUPNitGMvZ/cJVqgYBk3tNL3OmF2/RAS7MH5iWxv1BqwlNeYPU
         CVxNs6ta91Gou+uLqZrbP3iZo4i2Ix2ewlGFn/iGXPJbbZLLAJJCc2tQEgytPTZZey9T
         BMhDRMfvdpB6iNOqjQVV1g3F0b7nlbZsFQGFzHzBh63dImQWHcN0fCr2bithBRq1YGYX
         EGdacrEb2eW3+m+YvMdqXVl4BFl6y/mqF75D/rCbRXucy1KSRL2ehy3lJu1HnfA9gkCa
         jCVg==
X-Forwarded-Encrypted: i=1; AKwUvBwPhPg4z/tRk+wbpUW5McyBq2nbnZpuxmvM49wTxgg2jAU5AdWQKRBd35PIJKer9F41wmUSNQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ni9qPURLrkY/OvRQhm6qhUIWdLSXMaDAWfZHVwDnE4WsTVVEBo
	ItvZWZqhbuszYqjvAXLdNEt7+CWfhCAv/LS33qyQPgIhhNBpr1UMt6N+
X-Gm-Gg: AYBFou2dqZinnVSqT068oe6yY5SOh71VjCOM4aqsXKs3A7xhiVUxPv/a7oMivUIhdUh
	0cPPNr/r/m0TuS8/0Ky2onmbThGohLSUJJU4VHGwuvTMQdKiTPwb175tgSMVxIvoYw+G2H1nZSW
	8FsQ02LG05gc8c57mOnwPfmY5VpL/r0T1xfCAhifcuaNOgMF3FNBkz9JWO4+h7JrtdGZ86eAKyi
	SM9E+KgaZAbUfoIOxi8Cv/k9Nk5x4FSS03jY8iBiTAkbJdsLrGKcEqnTaP1+fXUyFfoAMBIRO3T
	FaOSqJcCwezTSrU8+LxI+dPAx5k9+3XpwDvvnpxoa+FaiT8BFXXAtFITccKCPVqRiu1UzB8uj7r
	Y3XiU2OLl1jfIFB043QIXvEphccpamq8VJUcqr6Z9EJugsEk4dQTQLZUVkPtg7LqADsiy5SrNU4
	iDNHlSpp4Sy4IngaF3OjzYmRSztfZdwEYJIWyLmha6dtCMJa616dfG/0XSQVwEQHJvDOA+okLBP
	JU1B7UywT7vGr2PtSAsiRmqwT//OO4KtHkEqGEZcfuVVnOR
X-Received: by 2002:a05:600c:37c9:b0:4a0:159b:d2a2 with SMTP id 5b1f17b1804b1-4a1680f4309mr117560825e9.29.1791211062322;
        Mon, 05 Oct 2026 07:37:42 -0700 (PDT)
Received: from andreayoga.localdomain ([80.188.242.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0276fa954sm348555785e9.3.2026.10.05.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:37:41 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommufd: Keep dmabuf MMIO attributes in domains added later
Date: Mon,  5 Oct 2026 16:37:34 +0200
Message-ID: <20261005143737.2915-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A VFIO PCI dmabuf mapped into an IOAS gets IOMMU_MMIO only in the domains
that exist when it is mapped. A domain attached afterwards, or an
IOMMU_IOAS_COPY of the area, reads the PFNs back from the existing
domain and maps the BAR as cacheable CPU memory. Patch 1 always takes
dmabuf PFNs from the recorded phys range instead.

Sashiko first reported this on patch 6 of David Woodhouse's RFC "KVM:
Allow alternative providers of guest_memfd backed by PFNMAP memory",
which picks the batch kind in pfn_reader_fill_dmabuf() from the
exporter's memory type. This fix does not depend on that series and
combines with it: with both, a domain added later gets the kind the
exporter reports.

The mock page table has no memory type bits, so the existing selftests
cannot see the difference. Patch 2 makes the mock record, per domain,
the pages mapped with IOMMU_MMIO, adds IOMMU_TEST_OP_MD_CHECK_MMIO, and
checks the domain filled later in two new tests, dmabuf_mmio_new_domain
and dmabuf_mmio_copy.

Tested on x86-64 under virtme-ng with CONFIG_IOMMUFD_TEST=y. Without
patch 1 both new tests fail on the second domain in all three mock
domain variants; in dmabuf_mmio_new_domain, a temporary print in
batch_to_domain() showed that domain mapped with IOMMU_READ |
IOMMU_WRITE | IOMMU_CACHE, where the first got IOMMU_READ | IOMMU_WRITE |
IOMMU_MMIO. With patch 1 the dmabuf tests pass.

Not tested on hardware that uses the memory type bits (ARM SMMUv3, AMD
with SME, RISC-V).

Andrea Parri (2):
  iommufd: Keep dmabuf PFNs MMIO when filling another domain
  iommufd/selftest: Check dmabuf MMIO mappings filled from another domain

 drivers/iommu/iommufd/iommufd_test.h          |  5 ++
 drivers/iommu/iommufd/pages.c                 | 13 ++-
 drivers/iommu/iommufd/selftest.c              | 90 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 51 +++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 13 +++
 5 files changed, 168 insertions(+), 4 deletions(-)

-- 
2.53.0

