Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987879;
	b=nRNYF+0KaaHs4xihY7/Gj0Hjfur0epUkWDJcc/4DylPcByctclsrV4h4XFpgm7oF7OeN
	 agNyd3zj3o+237nvgv/dZ42OpDikRHae8QWQSBLHJh7LIMoIshhDZ4Us/+0OuZoUlJsim
	 zG66MigDPtPfWQXhd9rtypshPAaVRU9NPTzq+t1AwnDzCj3iN/OzEPV1Qdqfl+8JtRsZF
	 SJhfZ2hKVSHgrvWZglEGXVILuvn9f4XTfXEDqAZHEML/kmF4jOdSTVQzoudQ3X5RA2Ulx
	 5tb81nMWAoFabv0fQ+TBS2JB/1xcu5S0ZJB7K9y8QhSqnh8NqhE31bl1M8ORePjNkVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=voDoMNlhMmskvRoNZqg2fTx8P1tixWjDbm8HuJ9K4dA=;
	b=ru3WzBA/g2RRWipgRoNoBmTlP5rPeebR5zFiSB6Ni4vVUYJsC1pIZz9akSXXXn8jL2o9
	 QSvWRH4mD08Qxb8Yo4cZ6bCXBh1x9hzzF3IzHcSssdY4eYDhF0tpTpeyrvq+kqnxnJlan
	 CupikfQ3HCowZH6U0H75VOkYAyR/J8FJc06At4e1WjdEmZaOuI5sDSqBNorNkiJ4nhzCf
	 ZnjNRU1jTck/2IODJiLnKglltK2QWYbqA5zc1AjQJLWVemnrWOBpsDNiwAR/4mmgWNmGz
	 6BVkA+60O+ywanJY0wO28FwMdCo+cfLKV9w5pCURfLox/Opevd0hJSFUO+XZhmcOY0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mDQaub+n;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF49606A329
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 17:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF49606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mDQaub+n
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b1a705b88aso634631b3a.2
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 09:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793987877; x=1794592677; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=voDoMNlhMmskvRoNZqg2fTx8P1tixWjDbm8HuJ9K4dA=;
        b=mDQaub+ntSMP9GL6a3m3MULrOABsY4KWk53U4Z56fM2mzKYE+k+49onU2XmlzaCtTC
         03y5BLcPotsPQ4hzBH+/mcUZVgRcBLCXQsu1gV+x5I/Mz68saYf4RrUkrUs4oGndCB7u
         KWW+ySDtrBhoHpK0GShkrg6CKxf+Bx8+/mHnmJdHvF3BVRxFfKfEfcibRKv0eXgh2Sr6
         XKMKtID2MrVOoLzKqrmt3eEyquTEXp2f2apYOvJgwyF6rHe2v8rIuxBt+WtXxRFZWm+y
         Cl+kYpgNBXpWcc7N4IeyjO9FRNkx0Jx9nC+6IcEtrZrPQvoEJIpR8b3FlfFcs47ZhzIw
         a8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987877; x=1794592677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=voDoMNlhMmskvRoNZqg2fTx8P1tixWjDbm8HuJ9K4dA=;
        b=oUGmNSXs0yKLtVbDpqurGp6NXSaqOua+NQ8s8CxPLN6TlOddtwWkQd6IlkOXNHgQsj
         DEnwGWLAp0NHAolz66QdGr+j/LuhshjS6yTe8FWklyDJTcBmyDzJRNhpORnGK7HWVPNL
         9ZjjVoAaZySqp23/1fIgBkUiLJoKfSlgmYwhrx+AD7xNJRzZ7yYwkJR2VxXDxq7R5Wzu
         9bJYjmfp3oqIbPcQKV0M3hIrCjh1sRZ/E/nwyVDNT526gr+Fi2ECtuNI2oX5YSLgY/FB
         eWQdh/NW7h6QoLnrpfAPZBoV4itAIyyTEyWQ0xw8/74jw/krisFvlQ1+za276zkWlvKW
         4M5Q==
X-Forwarded-Encrypted: i=1; AKwUvByhopMKvAWnnDdTwdTKJzVdHpfaQikSb1+Fds8bYjv5D0hNYzLAHfwaG9NML/yAIjUyIFc/8g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9d9CzPbrsJPy2GWsbfxzmuC6VpDB3l292lAnzQwFljNQc2W/qf
	Y2NWvyPGAMnu9nsjwLvKnpLw0/b7EGXZyE5aJHdRE6KXAzI62Y6+alFyx8bcccccaUJtacvTbaj
	CuDIm
X-Gm-Gg: AYBFou1DKA4ZvvyXBW2eU5DtOplDK+kqxv1ojeJ03wEeDyGWyjx/vbwPuUCdifUKN2F
	fbsw4YhyITMMEAsQuzOMBNg9+ncRgMTonbaPdj3KXZuSj70B4cGHi8A8M7MZ+bHAZUAuKvBYyAF
	N738PFdR5vDRvOD5gyzhD3iVFzMCuh/qy1S1P4bAbJlbVeQnBSVp62mGrqQ7zGHgG+gYBUZjuwD
	bZYQv3Fz/rpv+gjtjGXOnAox113xP9KsSVXKyijnBJ/rrU0XF8cQpl9KlqHbEatBQ2oUnDu0dNH
	1N1neKCvUf5Pg3LsQtlmAvjmAPpqZKcl4El13fiSrZKGmlvz1ql1hbAkhdCRFdfO1V/mYcluYHu
	Yn7v+RQNDmYYEp2hB97gjCjdhUMq5Hf87vjY42DPTJBmkErJ6ZyrW2Xd5rHcucblC8YSV02loHa
	eRxfWlGkuywOJ0xfEbk/TKDABcLfdF/4tMidoF/BCMHp+k9Ze60z4vr5tl5s7bYgstTOeQeyBOJ
	59Uj+FzY/XwqJyH6Lq3eqj/DbetryK/l5MKOUfXH6O7UgoVL2URnrjFs5zveytsb352Hb8Qn1f4
	QT0cH/7G27f3kqrKBn6XDVlDzGDUCmMQC8FcL3GTJ7I=
X-Received: by 2002:a05:6a00:8c0f:b0:89d:faf6:c69d with SMTP id d2e1a72fcca58-8b37c9250b9mr3510452b3a.58.1793987877466;
        Fri, 06 Nov 2026 09:57:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597f0539sm881137b3a.31.2026.11.06.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:57:55 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: 
Cc: Joe Damato <joe@dama.to>,
	iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] iommu/dma: Skip iova_to_phys() on unmap for coherent devices
Date: Fri,  6 Nov 2026 09:57:41 -0800
Message-ID: <20261106175745.3362057-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
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

Greetings:

iommu_dma_unmap_phys() calls iommu_iova_to_phys() on every unmap, which
walks the IOMMU page table. The physical address it returns is only used
for devices that are non-coherent or use a swiotlb.

For a coherent device that does not use swiotlb, the lookup is not
needed. iommu_dma_sync_single_for_cpu() and
iommu_dma_sync_single_for_device() already skip it for these devices, as
does __iommu_dma_iova_unlink() for the dma_iova_link() API.

Patch 1 factors the check out into a helper. Patch 2 uses the helper to
skip the lookup in iommu_dma_unmap_phys().

I split this into two patches because I thought it would make review and
bisect easier, but I can make them a single patch if needed.

One behavior change: for these devices the WARN_ON(!phys) in
iommu_dma_unmap_phys() is no longer reached, so unmapping an IOVA that
is not mapped no longer warns there. CONFIG_DMA_API_DEBUG still catches
this class of driver bug.

I tested on prod hosts serving TX heavy network traffic, which unmaps TX
buffers on completion.

Intel Xeon Gold 6138 (Skylake), VT-d:

  - iova_to_phys() on unmap: 119-143 ns per TX packet (~0.5% of busy
    CPU) before, 0 after

AMD EPYC 9334 (Genoa), AMD IOMMU:

  - iova_to_phys() on unmap: ~10 ns per TX packet (~0.1% of busy CPU)
    before, 0 after

So, the performance improvement is small, but measureable. The proposed
change removes redundant work in the unmap, though, making it match the map
path.

Thanks,
Joe

Joe Damato (2):
  iommu/dma: Add helper for coherent devs without swiotlb
  iommu/dma: Skip iova_to_phys() on unmap when unneeded

 drivers/iommu/dma-iommu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)


base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
-- 
2.53.0-Meta

