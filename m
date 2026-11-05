Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880768;
	b=m+9RGPHlwv/HsSZcWMe3icpMgkv09YFY2mINKz1mmu4jr/AtqKETWH+Pu7ENNfbmaDYM
	 NHZSi34d48d6bWfJNcaxXhQaYQM8HcWBJXh9UlgXpirybhQJe9JxnZ+N7MPZFU2YnCA87
	 Gs7Pyg06Vbxqs+qKCb2jiAjtKitVYEj1PZ9RWa97qg9OenX3tFiW5Bf9oA0iynW01iBxG
	 smTsQ9HfTZZQIfjIdkqzt213F9RM2AkYk1IM6TkD1Lehtey9pkb89cA1DPhCEYng63tsV
	 7D+mFXXKs7XgSbOMuriLTdvLag/CCuW4nnUCkCHzP6jTh13pKYcIJqAQNLSOuOXZC+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=r18X1CFEFTjC3NPEYyzvuNY3cZ4/8R2XJOUV0w6HYaY=;
	b=dPpVkfdjK8xCUqryVwpv2CmwQNpEbCA+OaaHzCNYhXkgD9u2/M2X2TQCu5kuMlWEKVBm
	 ssKVFTZsjqZdLR5Y9sGuzivAmuUeptp4WQqzesSb6HAj/qetjdd7uapYSO+3oL/prO5rH
	 ZBDUDT7BMm/gS2AUxJNz45AKRgBesdRn5Enm2mZqNHpzsIduSsRYcB7S75WfQ9xPTO+Mq
	 Zt8zsIdnwck3XGsc+futePoMvWEXfQgSIOeZZeAk1P+zgWRUd0WLeYJzjz80hx2T43upg
	 UXsrMwMEDZi+OzmIhgFUr/hjGMEbkopwPwDo+Q4VjWKhD6bgWYdVBBK6+w/55gHNmKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iXXdVAy3;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4921D606D81C
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 12:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4921D606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iXXdVAy3
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35b2c599f43so1834948eec.0
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 04:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793880767; x=1794485567; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r18X1CFEFTjC3NPEYyzvuNY3cZ4/8R2XJOUV0w6HYaY=;
        b=iXXdVAy36bdHFkTePffhXvlkvAyX6JqnOsfHvUpqDtg65xp3/Xgv3p8Fx4h90z7/n+
         eGAh6uYbLUNgJMOf0Ue6gv74z7od8FyyTaGWDD918cvGrC0IkAb91rup4umvGaz9g3ZU
         7LxA3vphGbxB7xqnfubaQsQ7JmQxyHoyPFXMBq2JZvAWAH6ikcwe1ia2Si8d0FjHkayR
         SApqssaIcBQnLGpXBJuIJrcv07Rf1RPtBQ/FsWCVvzZqZNoYiHLAHq6RxOSFtebodxll
         ppMnDVBtjW9rfyWJ+qvIMZMjTAl2FgT+L5RP7qnX8lcum16a1eRstP1c6a0lx9Hl0I2O
         a0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793880767; x=1794485567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r18X1CFEFTjC3NPEYyzvuNY3cZ4/8R2XJOUV0w6HYaY=;
        b=kzi1fbSkZFrJkoLUtCIuPg5bv3xQz1IwS6sl+sl7QGSQbfSqC28E13A4bi1Vr9tP71
         buOjKmaukhGNfjXocBghK2EoDES7TtrAW5GW9L1nLE2CIiye1uodo0v5QG5OA9Zn1d0H
         c46QJwcaemg6CA1SlvdilQ4+KtImQl8mtew250UenldaPZTb9lx/QxBYKdJyXS203PJ/
         bNtCGf4szwlRfS2rwxQ+PbeUILykjbOrKTj3A9y+y15tmdqNGMyyCO/VOwHCDQ3Ix+YZ
         AcESr0ktfIJpH85n5gZoPgSlpuuUXGdh/aRQGnPa9wHcLp0ioyjv3hUxw7jqcAx8A6Xo
         PsKA==
X-Forwarded-Encrypted: i=1; AKwUvBwSv2mNJ0xNhr3TF6foTo67WrI5faxX33PR58uNCi+fGnIhhGgVGWstL/DLK6dWKQ4yOiV8mQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9sqNPQNyxWj20WzX8JXvVQdGAUQW2WH0t4rKm1E8SkkJcClFtS
	Agl3wQRJjiPC1yl3AmxzvXL2i3U1rVeKZkyXolaYjXQpc7+w6yM4Hox5
X-Gm-Gg: AYBFou2nyH0domXUKR0KEGA9UjTy4QszlLl4JgWxgwOZvxT98KYq9vnjKJtQS1aO57D
	mmEgh09DnvABRQGjJ99/ssVge8yVvTwlUDNUotCoyTNlQObBezYKtGm3WR8e+Xv22XQg6Ax4wfs
	VcM11sb/rQNwEvCaK5YVS+cblNk7nd8u/htFTHiYblHnCwejuqoB3mPtR/GcMSDeBv/NVCIcwcA
	r6TwxRY1gzzHIAmWbncbgxLhYgkGka4W+TaBFy40YEqXC+BQbeuTOvC03ezVaFSXpDh+8FgH0U9
	oORPrjFTv3exWft0WH/7uN3Hl4ZMNrBVX94GGUOGYEKfJg3e89aQ/HNd7NadkpVk4XHbeD/HRhy
	kfrS/IrMYBFud6/jSPn362FNSRbXj9+kApYX1ENk1eP+yUSFBlSeJ/D5c/9qKQWYchceXG95owK
	d7UD89mdFG8GEElLmd6hB1mc8h1QYqcQy091c+5K3wNO7kUzh5klE59zydHYJGunsBmLA4XBLMa
	0l/uAdV+/b4Q96iDU8DWVE/FiSsW+LlSvYJVd4XTBQ2cPG4hJbM6wJUZgH/rcI1qQU67yCI+2BS
	R4cPSTENj5mre0IWpeAaa7/YVYZWyW77
X-Received: by 2002:a05:7301:1a10:b0:36e:5789:7b1d with SMTP id 5a478bee46e88-36e5789a206mr2143462eec.38.1793880767013;
        Thu, 05 Nov 2026 04:12:47 -0800 (PST)
Received: from Yee-680G4.lan ([46.16.129.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36db94376b1sm10519159eec.10.2026.11.05.04.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:12:46 -0800 (PST)
From: YeeLi <seven.yi.lee@gmail.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	jgg@ziepe.ca,
	iommu@lists.linux.dev
Subject: [PATCH 1/2] iommupt: fix full IOTLB flush from a zero length unmap
Date: Thu,  5 Nov 2026 20:12:26 +0800
Message-Id: <20261105121227.622631-2-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105121227.622631-1-seven.yi.lee@gmail.com>
References: <20261105121227.622631-1-seven.yi.lee@gmail.com>
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

unmap_range() hands gather_range_pending() the number of bytes it
actually unmapped, not the requested length. That count is 0 whenever
the range holds no mappings, so an unmap that removes nothing reaches
the gather code with len == 0.

The gather helpers assume a real range: both
iommu_iotlb_gather_add_range() and iommu_iotlb_gather_is_disjoint()
compute end = iova + len - 1. For len == 0 this wraps to iova - 1.

The problem can be reproduced by attaching an empty paging domain to an
Intel VT-d device and unmapping IOVA 0:

	domain = iommu_paging_domain_alloc(dev);
	iommu_attach_device(domain, dev);
	iommu_unmap(domain, 0, PAGE_SIZE);	/* nothing is mapped */

The unmap returns 0, but the gather becomes [0, ULONG_MAX] and the
iotlb_sync() that follows asks the driver to invalidate everything.
Captured with the cache_tag_flush_range and qi_submit tracepoints
enabled:

  cache_tag_flush_range: dmar0 dmar0[0] type iotlb did 12 [0x0-0xffffffffffffffff] addr 0x0 mask 0x34
  qi_submit: p_iotlb_inv dmar0: 0xc0026 0x0 0x0 0x0

With a non-zero IOVA the wrapped end widens whatever range has already
been gathered instead.

Skip the gather bookkeeping when nothing was unmapped. An untouched
gather keeps start == ULONG_MAX and end == 0, which iommu_iotlb_sync()
already ignores.

Fixes: 7c53f4238aa8 ("iommupt: Add unmap_pages op")
Signed-off-by: yeeli <seven.yi.lee@gmail.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 837d835e4fad..566cae4bc217 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -83,8 +83,13 @@ static void gather_range_pending(struct iommupt_pending_gather *pending,
 	 * For NO_GAPS the user gets to pick if flushing all or doing micro
 	 * flushes is better for their work load by choosing DMA vs DMA-FQ
 	 * operation. Drivers should also see shadow_on_flush.
+	 *
+	 * A zero length unmap (len == 0) means nothing was unmapped and must
+	 * not create a gather range: iova + len - 1 wraps around, and at IOVA 0
+	 * the resulting degenerate range [0, ULONG_MAX] would turn into a full
+	 * IOTLB flush.
 	 */
-	if (!iommu_iotlb_gather_queued(iotlb_gather)) {
+	if (len && !iommu_iotlb_gather_queued(iotlb_gather)) {
 		if (pt_feature(common, PT_FEAT_FLUSH_RANGE_NO_GAPS) &&
 		    iommu_iotlb_gather_is_disjoint(iotlb_gather, iova, len)) {
 			iommu_iotlb_sync(&iommu_table->domain, iotlb_gather);
-- 
2.34.1

