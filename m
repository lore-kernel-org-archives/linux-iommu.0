Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775537CC87
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806921; cv=none; b=Xd8dvmyIHEpxA1sFUiOvkUjSHNwvPw0S9mvPfkP9gch1C5S0Y9xmFgLBMJedGu+CEDfvOeQXS2CkxumKozbnw18Re8hDjdxsLYxDb7L5jZ8K/8DZrEteDdIJ99jbx82xZhPhtmOPcCG6eGG+3uM0RJKlTm35UK2+cjfnzPPNk/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806921; c=relaxed/simple;
	bh=nQnlX0DDaNxbga/DhB7JLie8Amiy5HfSv4XT65Hn/xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UyVfABtB4eTUQp8JefL7TEcgvvmH9/ZUixONi8llhuHL4ei8PItL8TBNGgXwvsSQHTy0EfxCDF0+OEn0zkHHMjPqlOrng4r0lItVtQ4VCOhuV4i0SvgQ4k6bSdZ8g7Yp4fYUmCir+5WS4FlDoFEamMdAcAmIDhZ5q3c7/oLyX3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ym6Nf6oU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym6Nf6oU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kuJ+10C4pYxyWPcGDJkWqMBAcRGmXje5KFYns7NWu0=;
	b=Ym6Nf6oUgfwl5XHpidZRmZsMMngCIRPvHQz2HPSb2k6xACkO0zPGIWni96caHL09Rv2UIW
	1p/IqEqcaQLHLr51EpCeaeW6RWml/cyjEO1uy9vtavoFtG7QDnQu5gZaKBytx5riY7OZLP
	c7q9VF+3UtLq8m4zoal+B3YCZtAOA30=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-xs32mjJuPLqDhVMv5xKRXw-1; Thu, 21 Aug 2025 16:08:30 -0400
X-MC-Unique: xs32mjJuPLqDhVMv5xKRXw-1
X-Mimecast-MFC-AGG-ID: xs32mjJuPLqDhVMv5xKRXw_1755806909
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9edf34ad0so613407f8f.3
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806909; x=1756411709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kuJ+10C4pYxyWPcGDJkWqMBAcRGmXje5KFYns7NWu0=;
        b=j+37kF33F2GlwLeV96amu9gPd+28uNHLpryEgv1dcz5PrPcDbtp5oZRl+BRsr1/rsQ
         mmB+UXg+JgLOlLvNNclMPeGp8xgld7CTOyT6eVr0RO4mG7J2B1PzsJJ8dwGlm7fU1ghv
         t7CpxD6NitYXBs/Pb6PMCsKhV6j3bvQzY7XKUIX6KMpLrolH7Zq1vqcb8pRMe75TtL/2
         VWrQHRpMSvLoiCstwV92TLxTR3QVAYS23gh2SMiEVLJ/hszU3NTvCVZzOxEefzXTyw5k
         2jnvi2vw+X5BBeXr4qGsAIAQ5v1su9uf3uMlMVmRS9yhRpOdbcXJMjorr2R2jZA8FIwq
         IDNg==
X-Forwarded-Encrypted: i=1; AJvYcCU8hzO/Vm4LCuRwxhkSyp3qVdf8BhYUNGBNwQ8ZDAhkfY9BMxRTF4rmz5y9S3XMoViS0hVnnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGH49qAHDaEb8Fd2vf8wEZT4TDYXTK19J3bCzeUL+xwuf1jxJ7
	WtRO7U/wtCsF7XEc1ri9lecc2lxKkJpZCyht3i7yveZsQ4r5/hnd4O2fHGeP9tSpu5tD7E3ckRd
	n6zUXEVZvEyIHgoXhx8eym5bkZHXhDp7ddB3FgEhpgrwZ4j2B7MyL4/U9
X-Gm-Gg: ASbGncvNBxPyThAy090Zy0lnvNZ0VX67eo1QmxrtBMhO4F19kYjRXA+A72j+dZ9uKvv
	6YfdtE4XKmsTqifkihbc+SNkcKNV5DfW5Gcvp2DvUCJkMvjXDh5EAs4O0FdEt28Wj+4gLrbao82
	AV4HkNGf4AxkBuDI6kk8voHsvwgsHtFtkN/0DcUgjnk1Co/GWZvplDTK1TH+jmfLa0hITAE2v8r
	nZid/LYzwsLLCOZNoAiCnEIXPLi8wmrZS717iRzBthHBNcSarxz9X+prMGgmtdJFC6rbwjvy4VW
	NQVnmNPjdddJQRNBi4JSzTnoz8evKIrguYtq+Nv1XJzDvESULUgmRBtCAnKw1cxKTebcf7mDZY/
	p2iGw5O0bRaXGiNxt/clAxg==
X-Received: by 2002:a05:6000:18a6:b0:3b9:48f:4967 with SMTP id ffacd0b85a97d-3c5dd6bbb33mr155506f8f.56.1755806909402;
        Thu, 21 Aug 2025 13:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRykwWh31JVJGBkobbD9YNZEskJV981iF0h0FASAg1XfgxaqZA4MQnDyPntA4/emfIOpWurA==
X-Received: by 2002:a05:6000:18a6:b0:3b9:48f:4967 with SMTP id ffacd0b85a97d-3c5dd6bbb33mr155476f8f.56.1755806908930;
        Thu, 21 Aug 2025 13:08:28 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c5317abe83sm2432791f8f.40.2025.08.21.13.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:28 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 29/35] scsi: core: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:55 +0200
Message-ID: <20250821200701.1329277-30-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 53vcIqZQIm07kov8eOKk5i7LXiQxN-6oLwkZJkkGKGA_1755806909
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/scsi/scsi_lib.c | 3 +--
 drivers/scsi/sg.c       | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0c65ecfedfbd6..f523f85828b89 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3148,8 +3148,7 @@ void *scsi_kmap_atomic_sg(struct scatterlist *sgl, int sg_count,
 	/* Offset starting from the beginning of first page in this sg-entry */
 	*offset = *offset - len_complete + sg->offset;
 
-	/* Assumption: contiguous pages can be accessed as "page + i" */
-	page = nth_page(sg_page(sg), (*offset >> PAGE_SHIFT));
+	page = sg_page(sg) + *offset / PAGE_SIZE;
 	*offset &= ~PAGE_MASK;
 
 	/* Bytes in this sg-entry from *offset to the end of the page */
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 3c02a5f7b5f39..2c653f2b21133 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1235,8 +1235,7 @@ sg_vma_fault(struct vm_fault *vmf)
 		len = vma->vm_end - sa;
 		len = (len < length) ? len : length;
 		if (offset < len) {
-			struct page *page = nth_page(rsv_schp->pages[k],
-						     offset >> PAGE_SHIFT);
+			struct page *page = rsv_schp->pages[k] + offset / PAGE_SIZE;
 			get_page(page);	/* increment page count */
 			vmf->page = page;
 			return 0; /* success */
-- 
2.50.1

