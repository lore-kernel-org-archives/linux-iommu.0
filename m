Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C3441C
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KNWdw8U5"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7811c58ee93so17094585a.0
        for <iommu@lists.linux.dev>; Wed, 20 Dec 2023 19:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703128758; x=1703733558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ghdfdvj5dTvmX90o5EKDMFpbNy/cwlZMLwYqTLMlBw=;
        b=KNWdw8U5oOxMZK8HCahczOWBSJxN/894c9IOdQCei0tckiyqr/K4U+rEAh3Ipujp+/
         /40bNIFh++mSL/x5OOVHzxoaX4RDhgEH4kjO1iA7YEatHdlEZyEjDIo5sq1/e/z5/koi
         V+UqsZ7m7LmXBbHa1HGweZapIPJf1Fzxw7Lp6n4ci9JgPnYVWIy8yaDIORA/ppCe1hux
         sFIffMjgJXxAAclEoBTFZSGU99xleSLJgubP3/ogSrPvUyloEUoC+hNBzRj6vQCEO8GE
         kf9fsDi/8esUAqx4nulFTiPUgp3uEXM+cAWjlww5otxsqC9RtLKWnYp77EJEOcxtjQrb
         YU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128758; x=1703733558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ghdfdvj5dTvmX90o5EKDMFpbNy/cwlZMLwYqTLMlBw=;
        b=c+uvORX5r5tFU7ZJ/Gh0npu4KWDA7+UF7FZHzGtFdl+Mkuu24GZC6JKTC8TruGTUKs
         wfIiqWTcfh45kPA4Xi3yrqgwXLpmaqwKulHW5XjWWcviTW6/51omQMHcbqTi3852WbKI
         jZz9ZdNmnx8KP/O1L2OgfhqwklF2bZRrGmimMRVC53v6airXJXoK4wypdJK47M40c1Hn
         HgBq7CJLj8NsKoJp3PSdkektUkaNYu9iYdTDk4xGXO2HeX4oW+bbdTf/9H1XJHZxCPoa
         966VEuQssVMbpyphwdvbt9kLUNGcGLMLZozMyr+eQqTB9Q/LiluOjWb1B3nBajgWTkTF
         snlg==
X-Gm-Message-State: AOJu0Yxv91PyZYCl+ccvgBbJ1YLnlZUCo+Q6M1F1Ul5wAfF+1cf4/sUT
	dNSx7p4SX1C7CWeiJNB3JBZXfA==
X-Google-Smtp-Source: AGHT+IH265HWEA86myqkwiq6DXT5J8wsiFwkQyNOE8yBUQ22blsKxbZ6TRgp5oa7b51nOFNbspw3wg==
X-Received: by 2002:a05:620a:20c3:b0:781:129e:101 with SMTP id f3-20020a05620a20c300b00781129e0101mr1960327qka.37.1703128758561;
        Wed, 20 Dec 2023 19:19:18 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a221200b0077d85695db4sm371893qkh.99.2023.12.20.19.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:19:18 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	rientjes@google.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev
Subject: [RFC 0/3] iommu/intel: Free empty page tables on unmaps
Date: Thu, 21 Dec 2023 03:19:12 +0000
Message-ID: <20231221031915.619337-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series frees empty page tables on unmaps. It intends to be a
low overhead feature.

The read-writer lock is used to synchronize page table, but most of
time the lock is held is reader. It is held as a writer for short
period of time when unmapping a page that is bigger than the current
iova request. For all other cases this lock is read-only.

page->refcount is used in order to track number of entries at each page
table.

Microbenchmark data using iova_stress[1]:

Base:
yqbtg12:/home# ./iova_stress -s 16
dma_size:       4K iova space: 16T iommu: ~  32783M time:   22.297s

/iova_stress -s 16
dma_size:       4K iova space: 16T iommu: ~      0M time:   23.388s

The test maps/unmaps 4K pages and cycles through the IOVA space.
Base uses 32G of memory, and test completes in 22.3S.
Fix uses 0G of memory, and test completes in 23.4s.

I believe the proposed fix is a good compromize in terms of complexity/
scalability. A more scalable solution would be to spread read/writer
lock per-page table, and user page->private field to store the lock
itself.

However, since iommu already has some protection: i.e. no-one touches
the iova space of the request map/unmap we can avoid the extra complexity
and rely on a single per page table RW lock, and be in a reader mode
most of the time.

[1] https://github.com/soleen/iova_stress

Pasha Tatashin (3):
  iommu/intel: Use page->refcount to count number of entries in IOMMU
  iommu/intel: synchronize page table map and unmap operations
  iommu/intel: free empty page tables on unmaps

 drivers/iommu/intel/iommu.c | 153 ++++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h |  44 +++++++++--
 2 files changed, 158 insertions(+), 39 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog

