Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8C1A08A3
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858258; cv=none; b=nMrdc29Gp6E4Yvq35rxVSgvErIrMZ8oBJUxSLHGd+vceMRos06yL8n2vpd2xC+j4i+05/bfwBAHWOg7uNCYkN0c42prngK84Une8vh4I4ndgQR+hLyKQLAgzf4rXP4p2DPJKivJ1ihRndZHKErkjR0jDcCcZuJYYpGKfIs0ER/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858258; c=relaxed/simple;
	bh=bZtWKwLDbngnLAn6XByjP83NWV81UQWIY1BVsWGO/bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgeEgExA8KwtaQvIMpM/TYPSxNr8pkJ1uqSU1ZQCbZVUBGZqvI7tj5bPH6JywVBkanq7TFhZZKwhzqzI8JQJb00tvgHI+FmMdoGpyD6HOG6t6LGSEGb+HRtegmtcMQJ9jyUY2AM0CKA/9YflJQygdUHfSUG+vIfHvPOdETw3LQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P+1cCaQe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+1cCaQe"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7cee045187so1421946166b.0
        for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 09:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766858255; x=1767463055; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7r2fLIF0HCe/nVgOOFJviub+x7aTMTINmxGMZSrb88=;
        b=P+1cCaQeamAd0dA0FiEt1m4XX+dlDl+FL60Gyq7vzPjmLgC33UW0lqYJvmJtqdX5CS
         6wJoR1A5OZZ91zifyQfN+p+eHFIfrf1ApmUaPdPr8O0u1pcQIN0ZEq1aTXYuxI9gecwz
         PQXKzSLCyxTTY1uN8moOU1DkJaw3Wa7DcXdvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766858255; x=1767463055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7r2fLIF0HCe/nVgOOFJviub+x7aTMTINmxGMZSrb88=;
        b=BWS69zeM78UU1ohTk+9W9Isd8NwXRRXTi3ifhfR5Y9YgdfJfpgugv678lREAPVzmsD
         0/05cLDy/PtmzOhZf70NKFr2p8jjGwECsYi0sWlLfmMwfvxRrgqilajm9i4e0pjpKFIG
         xx1TmXZSN01BK0OakeOQc0oNO/fYf1MlNoOVlZWSWSBPyz4S39uzYa7u+i41VCiKilk9
         oUYAf3ohz+idiJj1qNpCd+93Mo4pJafcPuaqC5daN8wLn2z+YQMeV0PGZLCW0zzOtgDj
         owOnNWzjOSfc32+o+tohO/MAeIdXkhF8s5tp5S9kjf3j3nRJU4h5gKENnHpLsz5h/Jjh
         N5XA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/ymNyYhj9D24lr4gOH6BtJEXssooedEWWrc/rFTlr3P6fsyJUqGzCPB4QDY/kyWOMu63aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgXEPsC77VCT2LyoipraNvas8K7RilVEc0IX6mOWMZRLYm/6GE
	1MIHtJ3Wz8z0u3XusaTFtqPm6s0cwy9ewMf29wY0aWvAz2wT8M4pWLN76ZzaLItWUA==
X-Gm-Gg: AY/fxX5SwGTROMAMdJWKWlGUIOCNlg8fmvahg3RpbvcFRiLFRYymido+O6yARQ7BGGF
	Ppw/IuxgG/YZhmqPwkPEw8wRAQ+VSnjSkKaRAfAnxiYPtBzGtMh5u/ZNgMkRGGGSvRuJXx4+BWZ
	gcv6o8eavjQ1LrE8UVNv68bWhiOSYx0+Qe3325TEP9PGaHphDNqPQ9Kv69gSbbFXs6e2q9DUHUE
	7jXFaSQZL8cNqXtHCnvJuUQrJ3ulRx2p9UcQV8wqzOQ/y844qBXQabRcNKwp5V/YHN+A5rSX4+S
	ayaXGYTHfV2HEUcCxX5yhdTByGLTJ8JLgPlkPf/EdPiRavvjkxoFPhiyVaAJKpWi6zSojow3/mO
	CIsDnGbDQA6woSRPWUNTeeSmNCMMrkqHiZWoT0oMbrvTq028OPWd8iBdMP0/GjRLhDEuLc17tYB
	ANnDx6UptXHdcJRzQ8wUuzdlDy9HQGfg==
X-Google-Smtp-Source: AGHT+IEFnSAWdzn6c9e2dhwjYE1Eq9ZSrGL85HPa4rSvAXcU5RqWWuA2E/9imV3gE1NhyLeHRJXc6Q==
X-Received: by 2002:a17:907:7f01:b0:b79:eba9:83b4 with SMTP id a640c23a62f3a-b80355b2539mr3336282966b.6.1766858255471;
        Sat, 27 Dec 2025 09:57:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:3d12:d2ea:4ee0:347a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de1421sm2793889166b.41.2025.12.27.09.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:57:34 -0800 (PST)
From: Dmytro Maluka <dmaluka@chromium.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context & root entry updates
Date: Sat, 27 Dec 2025 18:57:23 +0100
Message-ID: <20251227175728.4358-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1], we don't currently prevent the compiler from
reordering memory writes when updating context entries, which is
potentially dangerous, as it may cause setting the present bit (i.e.
enabling DMA translation for the given device) before finishing setting
up other bits in the context entry (and thus creating a time window when
a DMA from the device may result in an unpredicted behavior).

Fix this in the same way as how this is already addressed for PASID
entries, i.e. by using READ_ONCE/WRITE_ONCE in the helpers used for
setting individual bits in context entries, so that memory writes done
by those helpers are ordered in relation to each other (plus, prevent
load/store tearing and so on).

While at it, similarly paranoidally fix updating root entries as well:
use WRITE_ONCE to make sure that the present bit is set atomically
together with the context table address bits, not before them.

[1] https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/

v1 -> v2:
- Sanitize bits to not exceed the mask (suggested by Baolu)
- Reuse pasid_set_bits() for context entries as well (rename it to
  entry_set_bits())
- Add extra barrier in *_set_present() (suggested by Baolu)

Dmytro Maluka (5):
  iommu/vt-d: Sanitize set bits in pasid_set_bits()
  iommu/vt-d: Generalize pasid_set_bits()
  iommu/vt-d: Ensure memory ordering in context entry updates
  iommu/vt-d: Use smp_wmb() before setting context/pasid present bit
  iommu/vt-d: Use WRITE_ONCE for setting root table entries

 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/intel/iommu.h | 49 +++++++++++++++++++++++++------------
 drivers/iommu/intel/pasid.c |  3 ++-
 drivers/iommu/intel/pasid.h | 46 +++++++++++++++++-----------------
 4 files changed, 59 insertions(+), 41 deletions(-)

-- 
2.47.3

