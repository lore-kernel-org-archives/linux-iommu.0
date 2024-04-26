Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5274E3D
	for <iommu@lists.linux.dev>; Fri, 26 Apr 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103009; cv=none; b=s+sZhrDx/NZtqgjaHO3i/sNGsz6gt6vMbO9bEHyiVZNzBmk/pCRVM7pRJtmoadQ2TXS7ozYw+3lLOYr1CCeayGL8n/Fnq9lKke0J7PCOIceY6zTKCtFnrCD+L9lZLdzEbbPUf06N1OKgxtIyVxd3lsh5Ug56mzgPADUF860XFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103009; c=relaxed/simple;
	bh=tDWeS9EyfVzdb9+b53fsi52JTEQiv3F8/xYZ8HRdDKQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KqaG7p343Mh8OCOn/NYmut3m9vXEB7FlIe0dHzvGqktCvoT9yWBhZgleIq+GW7XPZAFFnpK4cq4bL5f55mhB/xakeiK9qYRPK+SyEB+/lQHkCz9K5E7zUF9nmue+gSMq/nf0wtqvAlqt6o9GQ1nDk7/YD9Ai+TkgW6LqKPHYly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lhlShoc+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lhlShoc+"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-434d0f63c31so10601661cf.1
        for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 20:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1714103006; x=1714707806; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjep24xOYUjfKLkGIt5Xg15kGd3msBByaQ3pAIEh0mM=;
        b=lhlShoc+gacyHc4ujkP0Mz9Vp4ymlCapWU5JxqjhHs28V1f0AwiRs3hbFwyXRTT9YO
         zUrmSOWpEZlsYYpm6r8XTdzRSjZD9ITZ323bBF1laUa7RqelMxklx+wmEKOs1rCfD/P6
         vTLu9UxEoVgCC18m6XzhMDhzzyoe4NJIyWPKgO9HKtDwpAQAintHTsjCrSNKNzYmKBJ8
         nb9K3rzEXwmRVk6k7rAokrjh664dlAULx53dz68fz/gRg2yXlAnJD7tCv8b405hQfxZH
         QEHU5EWSPXrkLfBCwZBTtRrhyWX+YCODz2mAKrSKwVQEezbZaYqfErBjC//rKPIFWJz7
         GIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103006; x=1714707806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjep24xOYUjfKLkGIt5Xg15kGd3msBByaQ3pAIEh0mM=;
        b=VG3TUQpKRSH1bvYaEt7m70NuftqrGdf3+iklUX5aIex3zxAz4w3e7xzHKqr229asHq
         1xvF3w5l2E5OV+0oI1Eiv8/sCiJc8txdd7MDd82hdxgluXDynYF/6oeISmQGNrIg0OQd
         PNGt+S5DMOxQx23Hbwk+mtFQiRqwL8Kavv9HwVk7P8MOqqmyJ4yMQPd0TNJtwubj6Vhd
         IwWPe/pKy6WjCj4K2+Q7pbXxMPxD0f5fFIZHWJQJQ02R2a2ZVVAjNEufl1gVoaFX5oYh
         EWyeFL9JxT9UO+nDIUJZbMCb8G/konzrYV8p9/k6h2JEiRfgFDhIX3ibVuosoy+RCbZH
         5D8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxOgr7YWKtDaSDnqhfsWyOUaz1zy+3CkBQ6Zb6kih3+Dssqqzrf1ENoMeXrm55O/z6PNj7CyhksCbXo4ngq2nI0/icevo=
X-Gm-Message-State: AOJu0YzW/S8TC5qQxqTnis5SWkD8H6AVyRaOOTkMdO6JpzePGnzh1bpR
	xQ0DMhlWcQeNCSNPqrwyRogTb1oP523Co8JlbfZN4uJ9rKvLdaYgISK9ShbYWBE=
X-Google-Smtp-Source: AGHT+IFuoNJDhVkOL87F6xMutiaC8xqNWrWB8I1N4j8YVN/IGWVNHKOf3F9BvXbF9SFqhbkbEzFqrA==
X-Received: by 2002:ac8:7dc1:0:b0:437:9877:333 with SMTP id c1-20020ac87dc1000000b0043798770333mr1787129qte.35.1714103006289;
        Thu, 25 Apr 2024 20:43:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id c6-20020ac80546000000b00436bb57faddsm7540815qth.25.2024.04.25.20.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:43:26 -0700 (PDT)
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
Subject: [RFC v2 0/3] iommu/intel: Free empty page tables on unmaps
Date: Fri, 26 Apr 2024 03:43:20 +0000
Message-ID: <20240426034323.417219-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog
================================================================
v2: Use mapcount instead of refcount
    Synchronized with IOMMU Observability changes.
================================================================

This series frees empty page tables on unmaps. It intends to be a
low overhead feature.

The read-writer lock is used to synchronize page table, but most of
time the lock is held is reader. It is held as a writer for short
period of time when unmapping a page that is bigger than the current
iova request. For all other cases this lock is read-only.

page->mapcount is used in order to track number of entries at each page
table.

Microbenchmark data using iova_stress[1]:

Base:
$ ./iova_stress -s 16
dma_size:       4K iova space: 16T iommu: ~  32847M time:   36.074s

Fix:
$ ./iova_stress -s 16
dma_size:       4K iova space: 16T iommu: ~     27M time:   38.870s

The test maps/unmaps 4K pages and cycles through the IOVA space in a tight loop.
Base uses 32G of memory, and test completes in 36.074s
Fix uses 0G of memory, and test completes in 38.870s.

I believe the proposed fix is a good compromise in terms of complexity/
scalability. A more scalable solution would be to spread read/writer
lock per-page table, and user page->private field to store the lock
itself.

However, since iommu already has some protection: i.e. no-one touches
the iova space of the request map/unmap we can avoid the extra complexity
and rely on a single per page table RW lock, and be in a reader mode
most of the time.

[1] https://github.com/soleen/iova_stress

Pasha Tatashin (3):
  iommu/intel: Use page->_mapcount to count number of entries in IOMMU
  iommu/intel: synchronize page table map and unmap operations
  iommu/intel: free empty page tables on unmaps

 drivers/iommu/intel/iommu.c | 154 ++++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h |  42 ++++++++--
 drivers/iommu/iommu-pages.h |  30 +++++--
 3 files changed, 180 insertions(+), 46 deletions(-)

-- 
2.44.0.769.g3c40516874-goog

