Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB530E0F2
	for <iommu@lists.linux.dev>; Sat, 21 Mar 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090881; cv=none; b=I/MF0+xUBqb7gWb+UB/eRZGoF60LJKk5Pz06zC0aps83nZdV9/ofkxuOccZext0/MJhbMdUfdj5/Qtv/NNsqIZW5Qe4TOt3oq6IAl+UzrGoQ/hNeB4VQK0cvCiq4nHsLx3tdzPCSFiCKRiDFlL8YBhAmJKkFwJV/xmpivcTY6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090881; c=relaxed/simple;
	bh=g+uuVo6YxBuA6i59bjslsdwAEN2VPiFp6C5cEMzJQos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tigdvprlhn1crBbKxVmMd1WlPOGVWqEmTkkEUrRhmylBb+bAuuwi4BSAIiwFCp9Ln/hoI1qJf1RIQAnJ0v7Ku9empuKFA8+k3qIChDi3luUID88t0gFSOAeKZVCGgQk8xO02jxU67GflETBkxplUQMeh9rnYjnnAxS8oKt3wXvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=oQ7cYtyx; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="oQ7cYtyx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090849;
	bh=arcVQdd5qWDE7k3IhE0LZZWperzfs+0HGppYUGehWyQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=oQ7cYtyxIKTZ2aI4CkWAPBOk+8wVnfe9TXpprzP2x3cExqioB1H+M2o4k2mq8FBwf
	 PYZSSq7ZtXSbXlGtCI74Rs97gmQXYGzQxhjH5peX2Ykt6SyLS5g+DnZByXQv3J2si9
	 m3bYI65/XGOFPRYvghAGR+aYk62hwukY7bvbw7Bg=
X-QQ-mid: esmtpgz11t1774090842tbb43ee6a
X-QQ-Originating-IP: mv5myG0ehU1YlIZvh6KahtgfL6eeQwVXKmoi3TDFisc=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 19:00:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4390190608562230099
EX-QQ-RecipientCnt: 11
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] xen/swiotlb: fix stale reference to swiotlb_unmap_page()
Date: Sat, 21 Mar 2026 19:00:39 +0800
Message-Id: <20260321110039.8905-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MQYXLRAkMyaepRQYOQpwixejF+q32fFP8BysH9VnPTG/7rQkVgNs2Dqe
	3DevTitA2Rwupx8sTy8czw5lzItvfbw4EqDnq0zRtdUXRL0cKzmiK/0g7dS5wcyjNbSSJYP
	z7SBKv8t3dIG+DUPiIGZK9uEBaWAEF38d1AE1+NidD4/0zrH2N2cK2JMvnGpq9pTspDkJpP
	AMjY0KLVzt971Lk5hJaJB4bQPgUKZkXayxFKaPdGDT/pskSc77pTEmwg19n3MAjiKdTMAg3
	olmwGKQyrA5sGp3etdnDOFURKcjH673RZROTUyBSgxEYX7f/tBTjsGH/bz6B6FvseFKnUjt
	bueSpjjBby8fm6O9Oaf+QcGxSCbDeQJG+MW1uALy2EhG4f4PmsbM7wv4/2mGxcmKefGAB7l
	JswOts48VFqhmRtR/Iu7603L8TeRJ3b38q1BPE6RHdf17SfGEG58UIih2tCWCLu+JnP98vE
	id+Lapr9GaoAKb1AiFzsplJbL5eoJ/7rX2niQP8WVFjwyR8nfa+Vu0uv3cGeRyr21o3Aj3l
	fsN8jQD7qHYJXObqeiVy5vhQHEEBz3vV6fm1nhqgQSRN/duO4WfImPoRB383/eunT6k3I8G
	djJa+XuVymCrC0UCFnvswCOkntdzeyUHLv09tE/6/a5FTfODvB7hbVdCHwe0HU8+RHGWRJx
	B2fhtixHfYYLrU/sjossO9vYBEuz968aCQ3Q/5QpcWzvZgxEIR7bYrTdtHcOOYWqiYYhH6q
	I6sgNbfrEV1A1cWtgiRXW/grD/DHfnmiP6pHAmPiOR7V8QduT5JkmXLgWq9OjDLywbdLwo2
	tDnmrnY5i0BEs9o266LNVUiaOPX/U7Lkl6lT1rLJFqJfHoenHWOWM0oSQXZpizqmBhuOajy
	Mb7KtT1YJUKCnJw4EdBb6jE4eqT6tMj+Apblzfku/FovJ2z+0r9Ao17psVwtDr6kVtXEJbW
	dUOqiYeKZIejcar80g+Spml8YaRr1rlAJ7xSmSJyqEMgfFqPj05tZj9ghcWWjBi0/xZFun9
	NWU4qEdHfrLG/sRkWDSGyT2zr2efIsEHj+V4no9FpzHwjfIUcBmalr2WbR382ReiWz6EUk7
	t/PSKzpqpvu3+AYdVAtj/wsS53jBubHVQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Commit af85de5a9f00 ("xen: swiotlb: Switch to physical
address mapping callbacks") renamed xen_swiotlb_unmap_page()
to xen_swiotlb_unmap_phys().  The comment in
xen_swiotlb_unmap_sg() had already been missing the xen_
prefix (reading swiotlb_unmap_page()), and the rename only
changed _page to _phys without correcting this, leaving it
as swiotlb_unmap_phys().  Fix the reference to use the
correct function name xen_swiotlb_unmap_phys().

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/xen/swiotlb-xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ccf25027bec1..4a734ee38994 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -340,7 +340,7 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 
 /*
  * Unmap a set of streaming mode DMA translations.  Again, cpu read rules
- * concerning calls here are the same as for swiotlb_unmap_phys() above.
+ * concerning calls here are the same as for xen_swiotlb_unmap_phys() above.
  */
 static void
 xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
-- 
2.25.1

