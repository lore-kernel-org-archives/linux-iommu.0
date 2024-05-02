Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7715E20E
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667044; cv=none; b=jVSRO5nPZIq9EharpAFLFOZLLf6GADZVB6xJiyEoCWDX/XCDPqSxAoLRovZM2n6S+0gN/33T+YAkZrv/qoADDMVeTNMv1WfJQhXV9/XC3is0VyQn+59HSxGBi1OEBURxFRKtXn8CYnI/EBOaZ/7NERfRn+7Age6BpXQ1OjW9QCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667044; c=relaxed/simple;
	bh=NGVwFjaFO10XPYZmmBrdVpFxIB4XnJUxAtDA0jJnZbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3pQNNzPV0taQaOq8x8ifPXseT8X1dZ+tc/0tltta6tknzlf5t1bRI0/n0zPBs+cYALlRBkqvF/AgDsx4hRMDU35Tim0Ojxswh0/zU+SBAEi2pKvwdj66X7lAacRzVgAxIbz2acNT87RXmJP78/+oDSOdmXcqDeMZOwspkIIMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=amas3A2t; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="amas3A2t"
Received: from fedor-21d0.intra.ispras.ru (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id C5A4F407850A;
	Thu,  2 May 2024 16:18:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C5A4F407850A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714666728;
	bh=DtReRsjlUyViWf7paqbZpI8KlMsBY9+Wd3lvivUXAhA=;
	h=From:To:Cc:Subject:Date:From;
	b=amas3A2tnskmQQ7zLqotmvrmOBDD3MRUJlwBBG8YFpuph8RhJxqsDwcB8JUP/n6Gq
	 JHlh8jVe7rGijb/Rhz6JgOAYoCko/ITGKQUV3VzsKkbZekqAALGD2IRWyH6GSvcfFf
	 yGRl0bQMK/ttw1GJ0NRIh3Ls4ldyzNFwovCvyXYs=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Xiang Chen <chenxiang66@hisilicon.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Barry Song <song.bao.hua@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 0/2] dma-mapping: benchmark: adjust some error handling in do_map_benchmark
Date: Thu,  2 May 2024 19:18:24 +0300
Message-ID: <20240502161827.403338-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the error paths inside do_map_benchmark() do not behave correctly.
Adjust them with the following patches.

Fedor Pchelkin (2):
  dma-mapping: benchmark: fix up kthread creation error handling
  dma-mapping: benchmark: prevent potential kthread hang

 kernel/dma/map_benchmark.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.45.0

