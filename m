Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880763;
	b=FcSREwdAUlFVFJ+Xb6lOeYThFqceA3iL1iEOcv05I5NDvIvDdnTE+FIoBmLRdxuFSu5d
	 RAgTqNrL5eoKehIIm7g+/MsoQga2/k2BCmv0gk0u3nwJjgYwdh3zL+7tkyy91RxC/0cVN
	 WVS23BkgpyP9hWWCm+rn5KXVDNYMwbztJPcjjBLPnDmyIOLNtqqtNw7hJ/WPrThRduVZK
	 j6N2qIF628OEBgwaRKYg5TXI+rfnNIyK+hlsVfFTR3IZhOerPTAs/RGRXL5dBSEdu4oM/
	 nSgwTmDyRG9gqjvLb9c5rQkxCoOE6+USeWkuZiqXldMrHeOudWtlSFYIdisu2pR8DiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=06+O1iBGIEDN93PJkroZO+wKLKjd+mKRK91xo6ni+oU=;
	b=5jVq7TJgRyLCD9CqWklhA5QfbaCpbkooRjtfsMHIZc2ZxsFEiWkwDO9pXLD03YEy5wrR
	 lpzesDwMoe9co7X1XQsTxPvUaRlyy8FZzvDBXX3W3zs2NGtWUN5VyMXohaQS6028J70gH
	 Rjo0h7g657UONSfswc4fSBIs79mE3v+QJBzwJun9GXzs/94ZIxt+J44Y+EMyzfIU9GzDc
	 iJ9dBOxXjcoJLgxtxL8WqI225Ol67ZRMGtgJyjyKyEprROMaqyjrBFYOky0grlBtk+aGZ
	 bTIlu2Ti6YjUr89mSQ94CIupht+0hJ/G6fWbeGsu2W9023na/zF3SXGnd3IfCkTPo6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhkFTHhW;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C1606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 12:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C7C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhkFTHhW
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535a54bed9so2343324eec.1
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 04:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793880762; x=1794485562; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=06+O1iBGIEDN93PJkroZO+wKLKjd+mKRK91xo6ni+oU=;
        b=OhkFTHhWO/ok8s8MFQMNQ6Mu4Dq/ODNwBUTmBR4kjPAxzF33DiNnu+xinDOHqLUFD2
         81MbHsPXBD0OEPBIfKyw+2v7Pj/D8qew8JPgHalY2tZzYQeGP77WNpVKnNHtq8972T7Z
         J5GvyUkAKHYPV5XFViJNVko26wpFQiAWoipJRrCkkpfDfBP6m8pF+6bsheUCYaTtpoQ8
         N1LaeQeUSRKxyp7Jlds7u9n+Hg8/SJyEuv10d3ZINNy2K9ZXv+QU7LxgvVEmMbdVKkaz
         liYZXYs40bHvJf1DHxyEKpKH51HSkZxfipSDG0e4oMvi7RxyeHR0UJTgUIj9324k7tiz
         vXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793880762; x=1794485562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06+O1iBGIEDN93PJkroZO+wKLKjd+mKRK91xo6ni+oU=;
        b=Ivt5UEBMMJf2yRTakP5im/GBB3V6cjfjLJry/HBJYy3maj6x9bUrv6kFpS937nkeN5
         79JlhMyFuyySNmi3KZiYYnhgn1juzqI8G3B1jDPIVKFmMrJybFq7pkmC7LHrwv82a9r6
         C9bogEWvALWCoKZIhKchLIHjnUQFJaWuXb/UgoMn8DSla57hWxg8EI+gwnus/AlKzmmj
         nV95mRXFRTf+jHDODXzle0VzpOcjbSnH05U0+MRyKf2LLAj5eAPcGlgG3fL4wIJz8wyD
         rsUHuZM04eypz+wdtLryWP6amoJtHlfI/VEzmQhSITER71DoMhdiIoRK0lDTXTXyuCvk
         DT5g==
X-Forwarded-Encrypted: i=1; AKwUvBzwKG3V/xyG9npSblInTH7HN+0P+8iyeuH6p8w2qTClbfrPf0LOktCzqJHKEZJrGSRIEG1k2w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8NhbGBS0wUCkWmh/OzewYoSOJ9ou5DQFbKoAqMClmcD3RdONZW
	fDR3HZWIcWgRvDj0I2IoRpPcmro9vLmWQjsDzE+UqsaKJHaQ9Qmbj+IKyVoTwznO26g=
X-Gm-Gg: AYBFou33RA2jxxwglOahL+QaR7ZzOaF6IiLAKTijaMX1bG7DXGpjV9aE6Z+Z/a/2KSO
	4OxkSnloDFXpQ4gfvw8uHpd+F87RGUyWtrsLlYY0ByoEOEgOG1+GvraPLuDb/5UC3LBGwm8nVG3
	f/snJiPCeSwKFu7P+YNGQ8ueresXu8VHnFnXp8v1j/pT/tDMAHLkIARX8gvSVQ6EVGrLX+NKTPU
	FwlUnLsWjI+VfzD2oyPjNyIq2jMsIGfj3VecXDS5T8FWP/cQ2RkhgrDuSBURiZ+Evh83D3ICmxO
	Krdtbeg0Zq6upJodvyUCmrbTUxEFlDAnH+wGUItF2mqeTNk35SAERQcaUBC0ezE58rTC3u+5xVu
	kAwhnHDogPgo2GY/f3Ymioy7wwlbUFY2A8OLlMAVPPwVT+Rsx7sxS3xAju2SiH55dn/bGvDI/BX
	X0aiHQ1vB4MTelORgfxq/iEwxQd+buXnniFR88j31kfaJrFvTEUQsPuYzAyhyU0lMNNSlFNpSfK
	PoLXQc/+It98/kpOgNJq2TzzhMkBL9YDl2O2mb1ip3K60vS7xxh6NOqpigKqIPu8cEnV/AmicvQ
	O1ZqUmtjMX3P8KM4PuS7cxlftoJkEL8I
X-Received: by 2002:a05:7301:fd89:b0:36e:371:8255 with SMTP id 5a478bee46e88-36e0380c5e2mr2691739eec.0.1793880761386;
        Thu, 05 Nov 2026 04:12:41 -0800 (PST)
Received: from Yee-680G4.lan ([46.16.129.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36db94376b1sm10519159eec.10.2026.11.05.04.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:12:40 -0800 (PST)
From: YeeLi <seven.yi.lee@gmail.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	jgg@ziepe.ca,
	iommu@lists.linux.dev
Subject: [PATCH 0/2] iommupt: fix zero-length unmap causing a full IOTLB flush
Date: Thu,  5 Nov 2026 20:12:25 +0800
Message-Id: <20261105121227.622631-1-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: yeeli <seven.yi.lee@gmail.com>

This series fixes an unmap that removes nothing from being turned into a
full-domain IOTLB flush, and adds a KUnit test for it.

Disclosure of tool use: the bug analysis and the initial drafts of both
patches were produced with the help of an AI coding assistant
(DeepSeek-V4.1-Flash, running in OpenCode). The prompts were a review of
the Intel IOMMU generic_pt integration, followed by requests to
reproduce, fix and test the empty unmap behaviour found there. The
assistant reviewed the iommupt unmap path and proposed the len guard in
gather_range_pending() plus the KUnit test; the code, commit messages
and test were then reviewed by the submitter. The submitter also
verified the behaviour independently: KUnit on the vtdss format, where
the new test fails without the fix and passes with it (full
vtdss_iommu_test: 63 tests, 60 passed, 3 skipped, 0 failed), and an
out-of-tree module on an Intel VT-d system observed with the
cache_tag_flush_range and qi_submit tracepoints. Everything that was
attempted could be built and tested. The submitter takes responsibility
for the submission.


yeeli (2):
  iommupt: fix full IOTLB flush from a zero length unmap
  iommupt: add a KUnit test for unmapping an empty range

 drivers/iommu/generic_pt/iommu_pt.h       |  7 ++++-
 drivers/iommu/generic_pt/kunit_iommu_pt.h | 31 +++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.34.1

