Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513437;
	b=gdJYP/aoZEUjXB8GRUmhG/rUXK3AzFx10oa5/mngTZetTpe6Ri3HQR37UmcW4ljMHBbO
	 ddp9tvpx3cQw+xnStRd5Y2pWdkaJ3NpLIo/GoFwY3svb5gAanj5xOm3cgFqdwe02787Ed
	 w3usc4Wk7pWiTr+S5yGJXZ9tPmJ5uUvNOh8QfRAsf9ukfsErA1hZLZcbt9Su7ou21DbIP
	 zQ08PqblvhBT2xlcWRE1i7x3LtiQekJ+qcMAERiI5KsrARTc/e9En+LAKFUDV6VDG/v20
	 YOSiviJik/Ezf+D5k49aKA5LQweEHhiJ9bYiOZGujUduX2O5UbUP+dGQzRTBsVnhNDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CzDxUF6io59AUzkKBaAU66gKnCGGQN9HKIMVkGQr1fQ=;
	b=G7f0QyBXTZ3tqit7VhIyB5tERCwtejGoKZ2lO4xgp+mpDu5mCO4RMZpBWfBeIUdsephn
	 kiHGm3BCjlE34BP05kSHL7wfTaJIoS11Xk2ducQUdm4AEv9bnY/ZoCljTFb6qRQCFDlxP
	 v2gMc0PyGWu+CNRVAtcFTY63NI8z5uO+AgxOoy66jwM1Ely79p0rLP1HhsTpZLcAYpvMH
	 CFPcrn72OnCpDQ1fTGIXM6JtfIMBA9BsZj2p0AoWjUU4zgADP0xN2ltVZe9oryXIzvG+G
	 +SaxU33nAJ4mxRXYqwx0FIXJwqfYg/qAcWw83yfYCTGq95FM1dVGhjyQ5SAARgJ8NAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KObZpNgK;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5380B606A31C
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 19:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5380B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KObZpNgK
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-537548b811aso616791cf.3
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 11:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513435; x=1795118235; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CzDxUF6io59AUzkKBaAU66gKnCGGQN9HKIMVkGQr1fQ=;
        b=KObZpNgKhpSQVihNqqw2AoiOlq1QaQ8nA11GV7cAbmZFL6XNRyjnv9LZFrncLR/GOa
         J6w6NG0WNuItCSFAXEWjxDxqXOxn6mohNUORqmgCe7cXNNiwe0xpnOR1F2nT3q6HE5GW
         Wo2CbDoFprZ4Xe8/YZoM4rj/PHNVRG23SeSolvdXG9ATSRCrFzToG/mQpZiCD9mt/gYR
         QaxpWIMYV/ovxqzJBZxPtI2cnSnDrCqLdyTPgRfN0hFA3TY0RpUsVDDhMXnbeFlwaSa2
         x6KKD3ySz6mW1cT4Yw7+9G6lCwq8nepWT6ZX11mdO/ETXsF/1Nf7hQyGMZ3CUfOTxLjj
         WfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513435; x=1795118235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CzDxUF6io59AUzkKBaAU66gKnCGGQN9HKIMVkGQr1fQ=;
        b=2oeqnzzCncWFolIczQPZdvdH8Dz4hIOEkBvUJKW+ADGnsD/20rv23Z+Tlul/dKyjTr
         UKA/b13P6Yg6m0bZpq1jhrcmbaGaFKbfbSQaK4SRid66g7nfbe66YPjt9VvY9UiBi2HR
         zdyNwlRpiAPOra4QIe9/oWPMQwUO/vENcqcrWr476DqwC3RT1ebCdTh7GNQxIL2nwHkL
         UlU7T/m/+8vtLl/k9284zA+G5NSRnsQGeOTxwfWhmhjdKgdkfDkKuAIRsD+2fBpakf4R
         lPaEFNCLXwsMf2yLfTNV/OYPo5BvG7BHEJEQ8cb/3D/b3dZr56dNC/QU3G3kCg7GdEl3
         jxBw==
X-Forwarded-Encrypted: i=1; AL+hErFftLqXprpjznX1zZpOYx4OsRsWJycCCxI0NgyOjK8oqvY5Ol3LI+KAYLECjlPtRgKdl8sWPQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/EPhTBkURFUrfIKH4CbWGy1S2mhOqwN5arbQ7pRqNrGvn8AKPn
	osQfOMI67fYyOPazjDQRkR7Z0sphf8jnCCv+YS9IylhJsBZLDn6TDe35
X-Gm-Gg: AYBFou3zFM8xcnakhN7aENvkWXL/nBrr+OcmADqA/5yE2heGvh6E44+9eL3np0xVx1S
	5RH9xD1YDP9mfd3zT1xr0WgMK7FJJJyx66YKn/ISV/4CFObqbWcb2TrEU5bDKGrDFmpvU6OL3u2
	nW6ioKYxDCncYTzt9sdB6WGMDRse4xrACAm5kyCBuuiNac0E8mbrXQSRF6sxx1KLAN6mU37HT6X
	f0AD8NYNHDPAh4Ii5ege9Hb1kdF04mWx80UmZdmiH7EGewMZEPZ0ftzr8xGQt8oQDx+57bNMVIC
	DnY8UgSSYj7WMdfNdqCcccHhrOFDEjjDCvR1LExzal2rq67dwt7nwf3jqt4xvfKtdc3V9QfvGxp
	EOOWKGv20LQw9kvLQNwgLZfoUnZwbkpl5xArj5pAoW2GowqAuyXIQY2AZLHMFFu9hH3IZvRv6IQ
	lTFddi3JYc9ECZBbEgQbEwhHjHOihA75oArP9ofAs5x+1HL+87If/hvV0GrCrXygbdkSVG+NBG3
	YEwvWoD7Oc2qENoiIXqVYnhO4AI3iOz8tY1765Tz1TqVlgwVY3ehq/P12nnoFxNxUe8jodzryat
	SgaJRm1e7AHBoNv0fwy+eqHGMsnqoGq8udr+0DoJ76FwPA42M17n
X-Received: by 2002:a05:622a:8586:b0:55a:e65b:d959 with SMTP id d75a77b69052e-55ae65be1eamr2000351cf.8.1794513435248;
        Thu, 12 Nov 2026 11:57:15 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad034918fsm2504851cf.4.2026.11.12.11.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:57:14 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Wei Liu <wei.liu@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2 0/2] iommu/hyperv: Don't free a paging domain the hypervisor did not delete
Date: Thu, 12 Nov 2026 14:56:58 -0500
Message-ID: <20261112195710.1417744-4-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The Hyper-V IOMMU driver frees a paging domain's page tables even when
HVCALL_DELETE_DEVICE_DOMAIN fails and the hypervisor still has the
domain. Patch 1 fixes this when a domain is freed, and patch 2 when the
allocation of a new domain fails after the domain has been created.

Changes since v1:
- Patch 1: WARN when HVCALL_DELETE_DEVICE_DOMAIN fails (Jason). Kept
  the Reviewed-by tags from Easwar and Jason. Rebased on current
  mainline (067c5c24cef2).
- Patch 2: new. Handle the same failure in the error path of
  hv_iommu_domain_alloc_paging() (Jacob).

Both are compile-tested only (x86_64 with HYPERV and HYPERV_PVIOMMU,
W=1). I have no Hyper-V guest with the para-virtualized IOMMU to test
them on.

v1: https://lore.kernel.org/all/20261105192738.70664-2-oss.patchbox@gmail.com/

Yuho Choi (2):
  iommu/hyperv: Don't free a paging domain the hypervisor did not delete
  iommu/hyperv: Keep a new domain's page tables if it cannot be deleted

 drivers/iommu/hyperv/hv-iommu-guest.c | 29 +++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)


base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.43.0

