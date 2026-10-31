Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478819;
	b=yJJTRb/4+x//Y7IpqW+IhOdb4vVqALAT8mewC+A3yPH1BB9S40lu/mVUpcbtRuogFU0q
	 8NOFZFBXV3KK6V6S9SbPowodmXR/PsW66bsACX6RbV5qcogUzXWBE4Q9RphgaY/vnS9V9
	 JqVg6yVJogook0Vk6DDdnNv0lNd2V5NpMDz2nE+BeaqJZvv9BbXLXNopmF88x+hVZ492o
	 WpHRGAYSauWTPGVvHGOg9OklGyjNlmE2WqJOBusDzcKYfSqH7nIu94NRXdJeywJ4VCY9v
	 GtwdK2oUlXOQ5hSqeTZqVagmWSG/CEvGV7nzSQQoWKznisT+Du237Jbvf3RBCiIeEow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478819;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YdHCoVT+NqpiNuPsfeDYsMwfap+yTxFuYoqh9DBLi+M=;
	b=A5fOywd1X72fwz5iN1QRyTVHytB+tFuXvUL0BnCEAUe+PecAQniUgv6ZZ0m74xN6TlYt
	 kgtVhwzHN2ivcAz/fPItNRVBz7hw9UGg39RTQ0ZqWMA7NHDEx37LcyjY/IwsTNX47KuKI
	 pJ+VMUiGEGeV3sn5o109n8cdT7jbkiVbK4UW+Ge8xgzT79AkwpMUXRpYcjCtiA5Mh/sA+
	 dPFFjvjcEIzIXuEuKe4NIvgxcwwrdaxZN0+Vh2QDgKKqv8+qGjQQnfe2VSGD9O80qDFK/
	 FJGzr0hkYtdARqGdWCWPmdVm+u4A/+uLjrUs629SSojDBwuqOhOVhN5WCz2kDxv3QKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=eMFsCs9i;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=n2CR+wKq;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B9606A322
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 20:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 046B9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=eMFsCs9i;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=n2CR+wKq
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDmY0R061873
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 16:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=YdHC
	oVT+NqpiNuPsfeDYsMwfap+yTxFuYoqh9DBLi+M=; b=eMFsCs9ilbbCUTQV6/EZ
	uaHBoegtH2kYXlsN2YHINUYFs1Bscdosku34Ot28VIAmqhXK6Y75qxszCOP3B022
	mqgYVBlcgx4MEcw9qNdsnnGHf7/CjCHSaSJQfGXTEtOZh4eQGIMyesi2lRXvOCO8
	F3ZnzkXEhWZ89w8Wetl3D3poZ3lm245DiivfS3ULACIJYMVm15OARh6g0j62tfhr
	8lrys0A+KbRoNsoe903zFoawVtZCpIJzi3i5KrwCPsrPp4Fx9569kIqJLbi8ySmH
	TMPju7RgkXyrJX19noQdZGPI5DnMFV3FnPEzclrN8DXEegG+Wbsud2qEdj+rV7rN
	9w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hnccxu72m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 16:33:38 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-945b0154705so8194285a.3
        for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793478817; x=1794083617; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YdHCoVT+NqpiNuPsfeDYsMwfap+yTxFuYoqh9DBLi+M=;
        b=n2CR+wKqsfYQDmXZE9g5DUGNIm10KgYJZEwdFdC8SW7fQZquFQfASVAHZtL08wX771
         QtMBnnMK0pWwIZp4KdictQ2LH/oigwyWQnxO6XGhPtx5Dm6KOulbJE62II0bgqrrA9Sl
         ZIHqOP2C6ZyWD/kceWkNuBzvBhMFKAG+STIm+a7QNBspLcocE7IOdaqhQG3B63DwjrwG
         opCpYIGIxHeZrGVhwpShqC2Xf47gSeaOMhFjWE12aBrq8GqnpNGEkoLDTTJ9IZCLcrax
         PQPXg2lGw0W3IkdWf8gfPoZBXx7E938g0NKnyy4VTYe9ZO+6K4W1Z55xJpLEt7IL/dzT
         +mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793478817; x=1794083617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdHCoVT+NqpiNuPsfeDYsMwfap+yTxFuYoqh9DBLi+M=;
        b=FqKIw1vpuPZyxNKZGz7PoIzQNZNxhqwbS+FRJV5vaxkqnPHhV1aeoae+fJgIh6WAzY
         Wph/WUSPnli3HU780slfruVXfxjqLe/oE38nv8W8gM4cMMuuEWXB/U1iUS4u0eUgA5Up
         aHAhAFAVPGE0eACMBrjbK4zz84S9CCXaThY8z0Ul4sw4wptmFw6Lp8lk7rec3YB7/b5K
         +kvn7Hy+c11YybQoFJmRgcBFY1yNMSGFzXxFpiqwP/EYEyHOkfY4K363vksDWMTjcw7k
         9suEF/3dMYUwDCDZs0F3JGc09sk8WRxWbXh/P1uVeUwsyr8yN4/no9x9hVjqZacIoKy6
         UlZA==
X-Gm-Message-State: AFq9FYKPlyo41yhmQ+h6+PtvTPODK1eoEnNbolD6KfxAr2RUvDsZqZ35
	vUcu+femCkdG6193B/yFTMgBWkjdjVj4Uciq9BrkghZEQEAgewSY01BF+xTU7B0n8Z4iUkU1YN7
	G0UtXPuLnLPMCbqimXqngCR/vnJLzlFRfvXp7q6FoljpNdHJWX76d
X-Gm-Gg: AYBFou3PTUzXDwBILL9r1wirkg3eF1jWRRhVxY2QPUkfDGaABW/SgvRlt5Gc6fp0iaC
	i604N66ZMvu4SJB80LcW/7FHpV4elPOKE5QzbFeOyksZc8Wm1XoeNLzgjkmL6U+edh2Q5slxMBg
	F7ptdrRUB5fvoqm4s53s5dN4UsdyqQkzwSdoayypXTcUZA7H+YB6wvRNXzoDxaWSYyQdTD9Z7/Y
	KOPkHBoLOG832w3ibXson/bBKz6G0SYz23lij80a10lc7DiDSsiUMFLgNkntl+XnYlUcoFIYqyy
	NjGRJbJsqQsgFPMzy4edbkj+ruypAbaUL1cZkuHOw9thZt2pyiPwHJDeRrqLxkBIjvZvnWLDI+Q
	vtmF4y4K81n/1uZBSyDGhKVM2FQ6uMS8w96NJuT0szRPM4ulyiIgIKJY2XTA=
X-Received: by 2002:a05:620a:6f0c:b0:93b:d7a0:d9db with SMTP id af79cd13be357-944217a1aecmr938522185a.53.1793478817376;
        Sat, 31 Oct 2026 13:33:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6f0c:b0:93b:d7a0:d9db with SMTP id af79cd13be357-944217a1aecmr938520085a.53.1793478816934;
        Sat, 31 Oct 2026 13:33:36 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.155.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b81c74sm10019650f8f.36.2026.10.31.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:33:36 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 31 Oct 2026 16:33:19 -0400
Subject: [PATCH 2/2] iommufd: copy to and from folios in batch_rw()
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
Message-Id: <20261031-iommufd-folio-dirty-v1-2-2cef66d2d6d1@columbia.edu>
References: <20261031-iommufd-folio-dirty-v1-0-2cef66d2d6d1@columbia.edu>
In-Reply-To: <20261031-iommufd-folio-dirty-v1-0-2cef66d2d6d1@columbia.edu>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jpb@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793478807; l=3577;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=iw6sHSriIxgAcaLxW3uDjPc2y6fpYYLm8qSwuAG4T/I=;
 b=OmZ77Y4NMdK2qjjtHjqrcx2sgxaYkW/IFd+fE7xFUxsivp+O52UclOiWycSSDQGWGjwmuSjC3
 ClA2BCEz/CJD22jyeoJbcUB+EdzY5JIbcq7VMA4PwkDVwOFG3ejYBc1
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX7HZ55qxxC4u+
 +EYHmyMj+FxzzPs+0s3CPvkTDMfgnMYMDK0VDxAVrR9DqHs3i101U5f/T3lVAuhWSieaE2Ttw9a
 YB9lAlUQaR8xl3Iqwg6uIUvZ8v4ip7GpjBNaD3FZXPKvGVozcGUuF3ff3OhY7Gksx1VyAAebjgk
 jGnoKqTqn6HJZtAMjsNdJ+iEV6Mo6ZbaMktXGYXy7us4ChpdoTPYPFtAtglJrL9UrG1nEaVRK/z
 wVH2UJFzAylZX7Mcuso5cEGCFR2lzqfPrwnggmRpQNcWO5bXRrtkIh62DpcntmehL0WTyX/ckjT
 bOSkLHMkXxiRBVV+l3eLpvO89WX2hsNoUXzTK51a4SuIFHCKvljuccrVGoYx2NS2YbHD7eXZgF2
 x6vlFPKd2+uwTLiPZ9CmAnLb1KpT7Q/Uq6F1D/wt3F+l2HiW7tQ1KWxVQQXzYa5+PMJGkTw4Lrz
 Q9iEoonX+tL+cWDLeVw==
X-Authority-Analysis: v=2.4 cv=XKSl2ghE c=1 sm=1 tr=0 ts=6ae650a2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=OyQKmhT2Qqi7aVZxTY5mBQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=RNgnFTfOqsg4LCEnESsA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: uoPs59SyGY1OcrvOMzzpjuHrqRiqE6gp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfXxsTXuQDzAajW
 C/uwD5gZLn9ETGOHu87jgTxUojUne/HP476x2/iVkdTAZo4rervKZGFyQAS41QzaJCUk259M3uz
 VH0Lc6l5UbTKOAoc6a1iYrrCK01mg3bcXBgq5nLpkJIHixXmDhDm
X-Proofpoint-GUID: uoPs59SyGY1OcrvOMzzpjuHrqRiqE6gp
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 malwarescore=0 lowpriorityscore=10
 clxscore=1011 bulkscore=10 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310081

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

