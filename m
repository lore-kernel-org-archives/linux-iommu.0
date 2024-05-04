Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD81CF8D
	for <iommu@lists.linux.dev>; Sat,  4 May 2024 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823316; cv=none; b=gSYt85xKZZT6mTfUIjKy6tlSgiCnIMYrJe822IafyHM7rQ+DfgerPgaBlLV0uJnhRXeOm1lWTz0hdA84uWQx02lZD6SZ8Zz4nbFsq6XeqSSONOU3WlKr+dIr7PQW0YsH4xkqPEqtzOcAxs0OOcJHHWPu8o+xCrFHZybLxrL86/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823316; c=relaxed/simple;
	bh=ZVhAMwTqsnOgrOxlKIXUEUseHsv7RukAzuPthcq0kjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oi1o4/60VJiGmwcm0XQ7fMyYbpigYvQWlQsfAz9JBHqnl8C7YeCoi1hy3LKnv7tvOZv2PpJIMOwoRInRSMp0YtppZpOhwaKsBt4yIekhqUYJ7uajs4glUNTUCVIdE27Tkwfp5gzwqUxPaHyZLRcNe225nLW8Aoq5rNZ6c4Mley0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=JXBxVbdl; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="JXBxVbdl"
Received: from localhost.localdomain (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8ACD64078516;
	Sat,  4 May 2024 11:48:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8ACD64078516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714823310;
	bh=fJAdS2oTmNJFXoSsqn0VZmRufTgd0FjPnnmSH7kQj5s=;
	h=From:To:Cc:Subject:Date:From;
	b=JXBxVbdl8C+23BYcwE8qSLmMKrwrP6t7jNKgc2kVWDpv6X+ydymVwIO6Hv78Jd/h4
	 NJlpaqYTqQ3734HHalDdfSTm953p833OJ/jzp1ZON12+axIZV5Ded+tEC3yP5YwQoe
	 yutaRr98lDAJIlp17gYRyNepucWpqJ5o1qCU8pCQ=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Xiang Chen <chenxiang66@hisilicon.com>,
	Barry Song <21cnbao@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 0/4] dma-mapping: benchmark: fixes and error handling improvements
Date: Sat,  4 May 2024 14:47:00 +0300
Message-ID: <20240504114713.567164-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the error paths inside do_map_benchmark() do not behave well.
There is also an insufficient node id validation and an out-of-bounds
access in NUMA_NO_NODE case.

Adjust these issues with the following patches.

Changelog
v2:
 * Rework kthread-related error handling patch (thanks to Robin Murphy) and
   merge patches 1/2 and 2/2 from v1 into a single patch - 1/4 in v2.
 * Three additional patches:
 * * Avoid needless copy_to_user if benchmark fails (suggested by Barry Song).
 * * Fix node id validation (found while testing the previous ones).
 * * Handle NUMA_NO_NODE correctly.
v1:
 * https://lore.kernel.org/linux-iommu/20240502161827.403338-1-pchelkin@ispras.ru/

Fedor Pchelkin (4):
  dma-mapping: benchmark: fix up kthread-related error handling
  dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails
  dma-mapping: benchmark: fix node id validation
  dma-mapping: benchmark: handle NUMA_NO_NODE correctly

 kernel/dma/map_benchmark.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
2.45.0

