Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423574;
	b=t0y/VCfvxoTlzz0K26jDojYT6ONFhNQcTtSsNvPW5CZOClCLeTcXkbCwXvpTnEdi14jQ
	 wQnRYG/dL8SiRGVX/9nxv63L/2YEU6xelFTwc1Htqsb0ZR9TPeSyVGDGb9WgkdtmpOsma
	 V35FQpT1+gavAlUqragWISJXXUcHb4Z/SlPk48oJe5DdAvCP24W/LxNnl8VbpAdRJ5kTc
	 Xm45fIr0qbt4ssXpfDNrAfIUF7o4Mt4MrVbC9FwvhvSaA40Tp4L7qxpH8Z6ba/uxaWJe2
	 Lc9EdLzbWKdCYuw47Tm70FF1seD+vOhe3z5IOvU8PxBGH+cIeP0V+kDjha7ZNX77bew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vmcUu24AcgALNJbfUMDmq5oQkKkP7zlxfkHJgkON/XE=;
	b=AWhnGu44L7zCkLB1HbWJjFgs0axyxhhWy6WTCdQsdIgDOZD3h34Wt0toWbsdHTMrHDKp
	 XS3usq+WXKWx7UeAQk4+NWy18N8SQ/ajduCF7XhylCEvCtnXTRdOGV999YzMK1K5kPLz7
	 7NHSyo5G2f25yYWJ2ukmx0PTDpGg7+GLMjLiniq9+LhYTyXD1iXn4yl6ToAmWdEXhqGZP
	 7WvoTH47hqRqJHUTbZKBuHeU337FoSsmWfIz+MecM4zhiOhKhBxnZTQUylepaWJ0qAhGL
	 DLlfRvFlwWpXnMbs8gPrtjreleNIW2qVGKFh22/9FCDF21e37ZtmALLq3TMWu+S3rwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wSFo2LiA;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C6606A324
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 18:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F12C6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wSFo2LiA
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so22472145e9.3
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794423572; x=1795028372; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vmcUu24AcgALNJbfUMDmq5oQkKkP7zlxfkHJgkON/XE=;
        b=wSFo2LiAZRvD0GrvsNb0ubFmw+IbtBJ19FZn4lJyArG28Yjxy0QFnebPTwYGCKg0da
         uBA7AQ6SGI6o1nb9MqKzD0zxdBaT17l/OKf5Of5vmASXpZ06rBo3a5VlAnCn/ANJADZl
         7LGKAe6++ZslspeeeFL4/EuDRQcxrk2xdRuFxGvRE4YPFlA+E3SL/aHZ/c9kC6CVw287
         6bAvmQ4aDkDzlj2BY13/poRU2B47/uVGt2CBeBr1dn8Ri/uU08g0L1DYc9B6IAZGkosE
         OE+uuqz8Or5LNT1r36MC/6Ll4ariief7ug67jfz7gl42fDcxsK5vcmbRzgfx2nuv+7MD
         6r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423572; x=1795028372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vmcUu24AcgALNJbfUMDmq5oQkKkP7zlxfkHJgkON/XE=;
        b=2OXYuR6Hb/ZlIuqFAxD13P8THusebqJqfMiIgPzdourxhk/KlYvitf8lzJ4TUVnTrB
         pVqhppuZ64oU7FlG5ZpZjboI6Wsd0aXUPohoCKAdReN9ZweG2cs3HJb1qGUtzfHwiP5C
         WNacncnYTyTu0Cvc/jqWrLayMZwtZ8U2sSxkqyX3go8WozHpPTNcv3HVNeFJiQQ1xYNY
         Z+2LtE9rEkLA2dRmkY8wXVEz3Kz38hUceDgwMCJ+kbAoWWeuoPM5ShUOzd7IJoHHLOls
         YamHM7+xgtge7DSeHrbTQ5tSxxshJtCaHgX5dXNeqOCIcHdt38+og2B/sww86doCjXLl
         dIXA==
X-Forwarded-Encrypted: i=1; AL+hErGicnYGqwrIoRlFE6bB8UYz6N5OVLgkz8I19+vOIkhWpd2EluXiLgX9dwchBV+bpmeK4sHnzQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/P1vy2QqIPZWOcukzt9asCe+AK5+ick7mH/ZWpqAxt+WlY+EeR
	vX/LNDAlpqkVrAf1gXiTgL/3+C/Ji7ZHfJkX6AhQ13Qh8lH8amgMnZCZ
X-Gm-Gg: AYBFou3ARj5GePfVwMV0/CqdYaMqyOpyjM6t3YTX25fGJVARDYNvW+van8FkYU24MSw
	u3i4u+JhxDo0W5UcLsRxFn3cSl/uUZJH5mPQQoajviQIUjkDKrl9tyTNGXvjkCA/vFk0mpnKr55
	weCecTH1MinFKU22S6sPoDklkjwTN+vNJazASby6moDwc2wgzZaAjWd2j2vhyzznOuWifDvoD9r
	xlekAV0vwCn93dlRQAoLyIj1MMufsOrcB1Ex6Jch0GRWVBPUtsY+b5iXY3PdWX5GE9MGulEpJ1x
	JlRyGcd9E/h40v7l3ZkEsNSFb3rxS5pNi2wjPFsCDM+ka2CaVjoT/iDqes0JXKyxwjeLZC63Egn
	QEPB4qyvZ2PHLmbRy9wIbX2ID76zpW/eRQpWyltqMEm7KsaoS7gVQD+owiyD6jwRfOBLL0E2VJF
	1hOT9tSq8DFVdVgF0fNBN6fEa9xx/Fhj3aTPfLlmiGRotVx1UD1Qive7fK2lgIx3U8jBWw10+S8
	K2gpaeZLcgvLcW6pcJTruGth+R4f+JtST6po2mvS/og/mhIbS9Paqq61Vp0khOPqsm8HPKT72Gn
	kMuAfcWuhW6QzdbCDHpRxIkb71090ncgFUKQVrTAMyVuZR3lcIK+tC1eqCwgzMDkvJ2CicrZeFd
	RWHqz36YUiawDw8bPmWXm9BTqp3Ave5KGKWrN7IAAtA5S4LWvhGiRLS54m7QvKq8x2w==
X-Received: by 2002:a05:600c:c83:b0:4a2:150f:1605 with SMTP id 5b1f17b1804b1-4ba0936f386mr62798215e9.24.1794423572202;
        Wed, 11 Nov 2026 10:59:32 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e265a0csm9161435e9.9.2026.11.11.10.59.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 10:59:31 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	nh-open-source@amazon.com
Subject: [PATCH 0/3] iommupt: Unmap and return the PFNs in one walk
Date: Wed, 11 Nov 2026 18:59:28 +0000
Message-ID: <20261111185931.94882-1-griffoul@gmail.com>
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

From: Fred Griffoul <fgriffo@amazon.co.uk>

When iommufd unmaps an area, it must unpin the user pages, but it keeps
no list of their PFNs. It reads each one back from the IOMMU domain
with iommu_iova_to_phys(), one CPU page at a time, then walks the page
table again in iommu_unmap(). With 4 KiB pages, a 1 GiB IOPTE costs
262144 lookups before the unmap starts.

This series lets the iommupt unmap walk report the physical range of
each IOPTE as it removes it, so iommufd unmaps and collects the PFNs
in one walk. The walk also steps over holes, where iommu_unmap() stops
at the first one.

Patch 1 adds iommu_unmap_sparse(), patch 2 uses it in
iopt_area_unpin_domain(), and patch 3 adds a selftest for the areas
that keep the per-page read-back.

An earlier series [1] proposed iova_to_phys_length() so that iommufd
can read the PFNs back one IOPTE at a time instead of one page at a
time. The unmap is still a second walk there. This series collects
the PFNs in the unmap walk itself.

The series applies to iommu/next. I wrote parts of the code and the
changelogs with Kiro, an AI coding assistant using Claude models, and
used it to run the tests. I reviewed and tested all of it.

[1] https://lore.kernel.org/linux-iommu/20260603151804.1963871-1-guanghuifeng@linux.alibaba.com/

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>

Fred Griffoul (3):
  iommupt: Add iommu_unmap_sparse()
  iommufd: Use iommu_unmap_sparse() to unpin domain pages
  iommufd/selftest: Unmap areas that start inside a CPU page

 drivers/iommu/generic_pt/iommu_pt.h       |  61 ++++++++-
 drivers/iommu/generic_pt/kunit_iommu_pt.h | 144 ++++++++++++++++++++++
 drivers/iommu/iommu-debug-pagealloc.c     |  13 ++
 drivers/iommu/iommu-priv.h                |  24 ++++
 drivers/iommu/iommu.c                     |  76 ++++++++++++
 drivers/iommu/iommufd/pages.c             |  98 ++++++++++++++-
 include/linux/generic_pt/iommu.h          |  24 ++++
 include/linux/iommu.h                     |  22 ++++
 tools/testing/selftests/iommu/iommufd.c   |  30 +++++
 9 files changed, 486 insertions(+), 6 deletions(-)


base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
-- 
2.47.3

