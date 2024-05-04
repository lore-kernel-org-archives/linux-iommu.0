Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4661CFB9
	for <iommu@lists.linux.dev>; Sat,  4 May 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823317; cv=none; b=Yn1zzacRb9Zx9NVD2ce9j9zexU9rR3hKiwDTn4opsaENHY7CFE7STn+Z5XADilLUR/zhDXyQLiqN6Ygu/fS5akZin00z/Mnen8DmDoz2YLsjMTEqQ8hE543ujTXVieAg9fjrVdZLyhOiSvpncKTC7KO0UbADspF2C0jjLDRemsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823317; c=relaxed/simple;
	bh=fPq6/+9ia0iO90JlhZ9KJBgh1cJ1I7wEf7WY1evowZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtUDHnPServM2kNjW+JIZhPi+4A8RxEI4xjYDVZkkT0HS3WDKe4RDl+eJjgwBpDxuFvyZK7OBN+/SGemmDhvvL0x7zuRMgdgljLKWBskNZ9SqkNPefPy2rPPVQJgGaSHD8I7laJda+I3UmCEAeGvuDDXxS0zERG9T2JYgEEpLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=co6PozTW; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="co6PozTW"
Received: from localhost.localdomain (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 4DEDD4078539;
	Sat,  4 May 2024 11:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4DEDD4078539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714823313;
	bh=epd4DMs36vx3k89bFNW7QgexA26iuS1BkPzE4xfNr8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=co6PozTWA52C1QDPaPlf+PV9N3EXqFu/i0LWcterYxQNvZ+z2BfRD15EyEjdUnJ3h
	 6WRCRybwnA4deRTtqSf2khGiquIf8PkKhl0u7iHuL4pRpF/H/8hz4IKXwjFLuCQgYW
	 2PY7720RgojzvAPUlSnGNY5diHmcIYGxknlBEDYg=
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
Subject: [PATCH v2 2/4] dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails
Date: Sat,  4 May 2024 14:47:02 +0300
Message-ID: <20240504114713.567164-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240504114713.567164-1-pchelkin@ispras.ru>
References: <20240504114713.567164-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If do_map_benchmark() has failed, there is nothing useful to copy back
to userspace.

Suggested-by: Barry Song <21cnbao@gmail.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 kernel/dma/map_benchmark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 2478957cf9f8..a6edb1ef98c8 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -256,6 +256,9 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 		 * dma_mask changed by benchmark
 		 */
 		dma_set_mask(map->dev, old_dma_mask);
+
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
-- 
2.45.0

