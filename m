Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991716;
	b=lm9oXgO4dEF8io1FSBaCreSJWvWV87ywskoI56CNxpTHXOvv1B/GIdhizcrXcfwjYnTe
	 Sicn0AACyX3mG4jD2i7jcv+bCDs8p9QmZ3c8PrYZt6t+mZ9nB8VCN3yRlk1I8DpZtAUrN
	 0kMCv/NKX6uyxyXip3rxbk9bIPYixJp+UXOxMM9dEYLyJDlH26jGyz+bwgG/16sJ6FbvZ
	 A98nGr/eoMNjrSwjjnpxpPUsP5ADLI5h1EVuysJ3GPKyEya6oMc8QIDQI4jBS9UguDUZQ
	 ehrz+8M9kuSWf4PAfJsmxQ/+yAAK6qvrAasQZgOV6KX5Q6xqh3r1gxrJvPiSkPMd3Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991716;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cD9XMWmu28du5sBucKcf/qLLpULli3evL1g2J4Y6yNg=;
	b=vJZfZoVdSVsRrEFmviGlhu3LW281YtSNftuJyMCPcLtE5W12LkG0z+Ok/i4QEskfKJso
	 9nkDESJbZo9Y5ZQQtKxqzvkDMgG1tF+fjYZgU2aSO90Hngo/bZOaqRB2lxJa3D/avNRFh
	 i5dT23NkvB/Z+wkAAxUDzGp67cUKTbGBEDswGugEWUrHQ1salxCd7mDsnyBxgfwDReb22
	 9O5JG5wmXje2m02ZUK/N2UkY3jOA7N/k4r68ySla+h1pWovA4YfxajJp8IOvo5cCshyF0
	 IuNqjy6P8zlirApEf8AcIsxOpbNt9sQ9H/jYWDGgeUfFq2Q7o5NmxYJ6mOnU1z9KYkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=bhKeRa+6;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=TuEq9aiV;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3B606A33B
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 19:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE3B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=bhKeRa+6;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=TuEq9aiV
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6IvLIa3037411
	for <iommu@lists.linux.dev>; Fri, 6 Nov 2026 14:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=cD9X
	MWmu28du5sBucKcf/qLLpULli3evL1g2J4Y6yNg=; b=bhKeRa+6i7ewrN2EwYw6
	m6FjSXWRZR1FVu3pA3AQ1rdy67wwrxRFcYqUMnEo7gPanbSrkhOmEFTI2Q9c7/sN
	eIghty+Ms2oFa8755O4a9AeQByM8yXEsO2oyKLNqUlh4t+xPVYf9JMepthD2JGqG
	UEt2Obah715WVFB3Bauov1bYkl0gnhilPR9Dk1Q+IjIxacLTAvn5DFmzxZWzX5hg
	cWl2/JYodj8zW16deMUtNRvAJ05aAMBJDghVXgGLyxQLLPXsjHCW6m2bYgdsPYOf
	AU3au9sMhRhmYeYDs/MkHZB6M077b8H/Ld8hnCtt7inSSlyJ/JYowoNkW6I7p6GH
	Uw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hskx8rck7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 14:01:49 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91e9a0eae11so19136726d6.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 11:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793991709; x=1794596509; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cD9XMWmu28du5sBucKcf/qLLpULli3evL1g2J4Y6yNg=;
        b=TuEq9aiVqLxcrB4dyxd+F3ldgKwOzwrukwjUH8dDb5qlxsj7rDl+X2EYK8HxG3lNSj
         rE5iBadr6/5fk/uzj6MosJr/QqBg+53ef25dNd35rHF/eGRUJn2+DG6DRZWP5IEDz0mF
         XDogzP1RSh33CoITaIpwe4+6VXTpyDxXVi4FhfAHAWbXBOGthxQTVutOHNsHvzk31nk3
         t0V8+bK9BCWQl9b7GS55DJzxSXxpR+oaaZHPu2zdgUpqXIiTLJHQKmBmVvTYLCRzeO0q
         F0VM3h6VAe7vOgtrZQIpuJJ6Rtm2Hb16LvWkDqnPQkaLKmmTyEAG/BW+0uQbq0QwclrL
         23ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991709; x=1794596509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cD9XMWmu28du5sBucKcf/qLLpULli3evL1g2J4Y6yNg=;
        b=P8OHg1JJ0sjhg12QeVYwrcsSbbq/nQbR+J5zzylWl9kNUsLOxQ93G1wqzNmhGHdW+D
         YRpyiGpOmbBQQoXKTkZpieyzbrn3IpncdyoL+CPq1q3K2wY0xHKOo8UkY7zeddJwObvF
         mNLsBstXTOczDoCLRUm/3qiFGtHP61cLohHPR1/GWfZA9n6rzx7KGx04li6DmYWunxdU
         GI3NyoSqSfkJl6r76SwAAxCOrS9ku1084OxN1ZDyinQ2Td09Nsuy79JjJ/Sq1hQL+769
         U/2QBD9ppWEdGmev1l/yjme0rk/na5hB+lhn4uxnPOmip6mdUOp5t4Jqm/Rl+u43cmf1
         t9aA==
X-Gm-Message-State: APuU4Z/RdY5zmyv7fV9OrRuoAb9Va/+cdkgCy7yCiEGVyzt6BJKp59A1
	UhGGpQYPiz4I0ByuFoE0oiRzAPeca55guypy7UlHi7sl/4clwyVqyO3weiNg3/2d7TP4FfEAWIn
	WLSgDkg2o6bRkzFNlZTvJcouZmgasppt6zD+OKN+0+8GTWRXeKpyfMSkYNhMB
X-Gm-Gg: AYBFou2C9tEEd6k4nbB0yd8ZvVttPXRhKurfDN2pVijMwtOYut4LICS0I9o2tNX5G7U
	aqwyr+GULwW8RhOlk1F97NIOsmJaMZB2K7UGGkhafYle1wDB/j7Ky5X/7lJVhfSv9mvOGv9OX1o
	HBfd5txWKnD/I5GN7Cho68Ol0170kp6YYtQvJi5LkfZWmrcV/FvPH9n71YV5XUPsBvddT1p9Wrg
	IyFdPVGUBn3yiry6ulhOB6v8gpWjIwRcAuyX7QOmA+Nv/Rw6tmjeDAQEfpURPkZ/WyDl85wcw0L
	A1nImldX+eAahi5fzf/PdoCwBMq3EMfDq6HJ3ZJ3v7X5TI/x9xMQNNC5C8yPz0HXhunICeostMZ
	ZtR4VzgYhxKApGIRMYBvJIULrFLIV6qruSRcUJv1NAKJ/qLm3nUYP2jo2lE6uAKQgXscS6/kZ2Q
	pxvk5BVyeby4/yPvwYUEhQ
X-Received: by 2002:a05:6214:601c:b0:91e:b360:1b11 with SMTP id 6a1803df08f44-91eb3601b31mr25814386d6.13.1793991708836;
        Fri, 06 Nov 2026 11:01:48 -0800 (PST)
X-Received: by 2002:a05:6214:601c:b0:91e:b360:1b11 with SMTP id 6a1803df08f44-91eb3601b31mr25813896d6.13.1793991708178;
        Fri, 06 Nov 2026 11:01:48 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-224.net.columbia.edu. [128.59.176.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a71bfesm27276376d6.25.2026.11.06.11.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:01:46 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 06 Nov 2026 14:01:20 -0500
Subject: [PATCH v2 2/2] iommufd: copy to and from folios in batch_rw()
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-iommufd-folio-dirty-v2-2-3f0b0be58c4b@columbia.edu>
References: <20261106-iommufd-folio-dirty-v2-0-3f0b0be58c4b@columbia.edu>
In-Reply-To: <20261106-iommufd-folio-dirty-v2-0-3f0b0be58c4b@columbia.edu>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jpb@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793991701; l=3624;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=qbvxJiYzVqagil7h9OhUxgENwgVjM7SJdugGohzXnoo=;
 b=SBKMHMaKAf5mPu7DoUiRlKc+BykU8uhp95eLQlmBJPM20Y9evsgRnhfvmuXp0JlJhfFInNa9D
 jNjbRtV4xZJDchCg54KqTBX8an8XJnAY25mARlJb/ypiOP79AyuWfSm
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX/6qslgjAQLLh
 CagMi96ndBHRara6bROzoYJViFEVKdcZBP9hddAcBcRCguQMIyP4Dgi3g6GtsX5tP+okIhzVp3B
 PjEXVEMA0UPMeZOQJrP+eHtaLVRkYW2DxVxFMw/ChpEolwtTY5c6
X-Proofpoint-ORIG-GUID: 0NMKxPqpbiycL6rdU1Oq_9tn0P_6aitC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfXxAHnKDSleEoC
 2JrCslM1jfUjgH52Ua5Iz/mbPQ3rXAre40D/BRm8d4BjU4d1wFpTamjaxk73TpcR7zONJB1s1CD
 tGBTi1oTfreBleZiF6Im5SoBm5Bcr0w9QPnjZCNDU24bIH9IYttHeDWg7+wVDCRKZBZ0MNLAOOv
 avDpcFiiCFevp+e71/k1iO6Y7jIku9srCoi31ksBNq+wGU9abTl2GJ19fkbZXg6Lr/Vh/hiVqRb
 dlxN1Czq3rumxKuRjsDZ0xPyuJCtGZDvLC85I03WaiYDqfVHgQUtg2jwq8VcmjKZTjC90FAJ87P
 i2PfCuP11mho6Z+6LIsJYJcozaZh6Wnu2ePPAeGkSqI7w/nl6DiOx7eFegHxyqCa+ulIayH401K
 CVAF9+M7e+ocJwK/nyNAJggsL4bHEg0slnIvGxWP7kMO1C8hENfJJg8zvJ2OPce8jrxvl7bWYiy
 7AR7O0CeJubGjpYY7Wg==
X-Proofpoint-GUID: 0NMKxPqpbiycL6rdU1Oq_9tn0P_6aitC
X-Authority-Analysis: v=2.4 cv=Vsa2kO2n c=1 sm=1 tr=0 ts=6aee241d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=bIa82ERlpw6mw/X9g1H6cQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=Ikd4Dj_1AAAA:8 a=RNgnFTfOqsg4LCEnESsA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11958
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=10 bulkscore=10 suspectscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=10 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060075

batch_rw() copies one page at a time and, for writes, dirties each page
with set_page_dirty_lock(). Walk the pfn batch a folio at a time
instead, copying with memcpy_to_folio() and memcpy_from_folio() and
marking each folio dirty once. Convert the single-page copy in
iopt_pages_rw_page() to the same helper.

iopt_pages_rw_access() rejects dmabuf pages, so only pinned user memory
and memfd pages can reach batch_rw(), and those are always folios.

memcpy_to_folio() also flushes the dcache after the write, which the
open-coded memcpy() didn't.

This removes the last use of set_page_dirty_lock() in iommufd.

With ftrace timing iopt_pages_rw_slow() through the mock driver on a
non-debug kernel, slow-path writes to THP-backed pages drop from ~1310 to
~930 ns/page (now the same cost as a read), and writes to 4K folios drop
~9%.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 drivers/iommu/iommufd/pages.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 2f6153108add..133fed4495dd 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -721,19 +721,15 @@ static void batch_unpin(struct pfn_batch *batch, struct iopt_pages *pages,
 	}
 }
 
-static void copy_data_page(struct page *page, void *data, unsigned long offset,
-			   size_t length, unsigned int flags)
+static void copy_data_folio(struct folio *folio, size_t offset, void *data,
+			    size_t length, unsigned int flags)
 {
-	void *mem;
-
-	mem = kmap_local_page(page);
 	if (flags & IOMMUFD_ACCESS_RW_WRITE) {
-		memcpy(mem + offset, data, length);
-		set_page_dirty_lock(page);
+		memcpy_to_folio(folio, offset, data, length);
+		folio_mark_dirty_lock(folio);
 	} else {
-		memcpy(data, mem + offset, length);
+		memcpy_from_folio(data, folio, offset, length);
 	}
-	kunmap_local(mem);
 }
 
 static unsigned long batch_rw(struct pfn_batch *batch, void *data,
@@ -745,15 +741,21 @@ static unsigned long batch_rw(struct pfn_batch *batch, void *data,
 	unsigned int cur = 0;
 
 	while (cur < batch->end) {
-		unsigned long bytes = min(length, PAGE_SIZE - offset);
-
-		copy_data_page(pfn_to_page(batch->pfns[cur] + npage), data,
-			       offset, bytes, flags);
+		unsigned long pfn = batch->pfns[cur] + npage;
+		struct folio *folio = pfn_folio(pfn);
+		unsigned long idx = pfn - folio_pfn(folio);
+		unsigned long nr = min_t(unsigned long,
+					 folio_nr_pages(folio) - idx,
+					 batch->npfns[cur] - npage);
+		unsigned long bytes = min(length, nr * PAGE_SIZE - offset);
+
+		copy_data_folio(folio, idx * PAGE_SIZE + offset, data, bytes,
+				flags);
 		offset = 0;
 		length -= bytes;
 		data += bytes;
 		copied += bytes;
-		npage++;
+		npage += nr;
 		if (npage == batch->npfns[cur]) {
 			npage = 0;
 			cur++;
@@ -2306,6 +2308,7 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
 			      unsigned long length, unsigned int flags)
 {
 	struct page *page = NULL;
+	struct folio *folio;
 	int rc;
 
 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
@@ -2332,7 +2335,9 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
 			rc = -EINVAL;
 		goto out_mmput;
 	}
-	copy_data_page(page, data, offset, length, flags);
+	folio = page_folio(page);
+	copy_data_folio(folio, folio_page_idx(folio, page) * PAGE_SIZE + offset,
+			data, length, flags);
 	unpin_user_page(page);
 	rc = 0;
 

-- 
2.39.5

