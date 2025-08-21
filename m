Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91FF2E8B6C
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806835; cv=none; b=B/qrvQSbkc75SWUdCY0afi5tzs757RpAfr4/ubRCThWRabv3r592ahpXec8u5zv7NZTK1r/LVOAxgmPQKNnRijI6O1Rf7/LejmToYdw0iV8Rjzgs0oXtTZm0JYmIzrViC6F1c6yKcz5x6YmEr729/FCzsDrW/6B8AIQICFH7eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806835; c=relaxed/simple;
	bh=6nSseGe+74q2JGOSoz3zO112Eo1zTQLz4H2FdYfsyUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AZ4Qr1kPvcoIHdjnkZ4P3XjuCjW0sPt+gej2bS63re9a+tMw3ruSEku0vnpEYpjh9Edzt6cFvP6ycMO3XhZ2r0qM6aZxbZjFk2a5/SoflkD7KCr6hkmdRXy22DEtN9PLSlceXj1pmDlNnpSHV8uj9X7iZwj+jPmuuxLyeOlDv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6549wKT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6549wKT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmvTcrL5C0dM7rPtm73IEcsYc8PUVzmaMdzwCc2EnvI=;
	b=I6549wKTnM8zsqtSAt9EqBib0pAKlsIve5pXzkcRe9D52AF0sZDHqksZY9TmI/r9GkPjOC
	HnJHEDGwC1GCkp5NhIl/Hv8PnhUbQE3dfBffAoGXTv+D0MkRReq/L5UjeH0uTyO7R5aI38
	6uccE7mvE/M6aNjik0WbTBM6nJH+P/E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-mk5m0s44NqKE32Zybu4v0Q-1; Thu, 21 Aug 2025 16:07:10 -0400
X-MC-Unique: mk5m0s44NqKE32Zybu4v0Q-1
X-Mimecast-MFC-AGG-ID: mk5m0s44NqKE32Zybu4v0Q_1755806830
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0cfbafso7804025e9.2
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806829; x=1756411629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmvTcrL5C0dM7rPtm73IEcsYc8PUVzmaMdzwCc2EnvI=;
        b=fhpHkiAFtCnEEouSDqc2GVYleXR5k0Gs9E7KRhKDRIIbmTA1fhCPSsb4utnIfznPtI
         KQxeaodqOfCUHtI7ow6RGwmeYR2sypsryBNN2H/HYHrXz42xOKJYr9Da86lNz8lBnyWZ
         rNOltIXDLWVKu1p660fsbG9eOAePggIi89mw+Ks7jPff0dRS68gfHVmfkxwX7GPsUpsv
         cQdVgq7oEs7GDfV9phOt7d1wB2iOwJkFvfWmBhPb91X4vqeoSW7N5BTVLOO2FRSDED/Y
         nVWWspzQYS+V3s+cKu1lq8oXsXCk1J3zPq8dKhp6Y169Bv4UTLNh7tWx0xXx4LzLGuIx
         DRSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGc0fWdT+UN4OolT+IDxTBDruqS3bTU0tuGKmgqKreSjHNi9k8/jC/6MFiiRvUcGacHOExzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSlUvlKbatd1s1QIqm+8idD5oJI/Q6WiaTLSRZfpUCgc0iByC+
	GMEiKYmFl4ELEidgkO43UglGnHdsLjfBqxO/WDuvN6BJTATddRmvTpUYJdWiqbGHXNqX/NZ6dmy
	vutJPsnWksnNjUIr2H2rGWurv8fWJUBtd6taiiRbh4L5985bigS8lliuQ
X-Gm-Gg: ASbGncsDVX5iXFLKpfcoMwL8a9eXfWPpiQ9HRop0HUDGm7rp0EZpkGoxfqstoKOkIvl
	zu0zT35S6m1yBMjAWATw3entsVVcFaKMKt/mZZ9TM07gQLjCk2tl8ybmFBH8PLU8u5fU4R9tXR2
	Ocb/wDdUXrSPrSKa6z3ogJgbyB+hB923bR9uGBHbvnpbFoRK1hhOUHVcto/B536aA9Qxz+LeyDy
	x64En2A/3WLTsl5NA8rvYSJlq/RcFNNgOuIYXK/hittR7DdB+tN29dOBoJZ1NXM7ttJ1Bdu0XQU
	5D+QwOZRKs8FVrcf9NzvFVhWbiAgvCBXs+2Evr9l4xGFoeidHt4jgOwdqloBn7W+bjDM6ZoMjHA
	PBpPO18SNmTdNSUF4L0jIjg==
X-Received: by 2002:a05:600c:4506:b0:456:eab:633e with SMTP id 5b1f17b1804b1-45b517c5f34mr3673765e9.17.1755806829506;
        Thu, 21 Aug 2025 13:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvYkVaGxfZdplMxnR9eu9+L8mDJqjqWM2enq3Cze2cE8zEp05huuco+bDpuuERUQ/1xaOAqQ==
X-Received: by 2002:a05:600c:4506:b0:456:eab:633e with SMTP id 5b1f17b1804b1-45b517c5f34mr3673145e9.17.1755806828996;
        Thu, 21 Aug 2025 13:07:08 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e1852asm8722665e9.25.2025.08.21.13.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:08 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
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
Subject: [PATCH RFC 01/35] mm: stop making SPARSEMEM_VMEMMAP user-selectable
Date: Thu, 21 Aug 2025 22:06:27 +0200
Message-ID: <20250821200701.1329277-2-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: sM3nR-7iQ3SLyYP_v71IWVQc4BzjIUV35yTeKQi6kcs_1755806830
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In an ideal world, we wouldn't have to deal with SPARSEMEM without
SPARSEMEM_VMEMMAP, but in particular for 32bit SPARSEMEM_VMEMMAP is
considered too costly and consequently not supported.

However, if an architecture does support SPARSEMEM with
SPARSEMEM_VMEMMAP, let's forbid the user to disable VMEMMAP: just
like we already do for arm64, s390 and x86.

So if SPARSEMEM_VMEMMAP is supported, don't allow to use SPARSEMEM without
SPARSEMEM_VMEMMAP.

This implies that the option to not use SPARSEMEM_VMEMMAP will now be
gone for loongarch, powerpc, riscv and sparc. All architectures only
enable SPARSEMEM_VMEMMAP with 64bit support, so there should not really
be a big downside to using the VMEMMAP (quite the contrary).

This is a preparation for not supporting

(1) folio sizes that exceed a single memory section
(2) CMA allocations of non-contiguous page ranges

in SPARSEMEM without SPARSEMEM_VMEMMAP configs, whereby we
want to limit possible impact as much as possible (e.g., gigantic hugetlb
page allocations suddenly fails).

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 4108bcd967848..330d0e698ef96 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -439,9 +439,8 @@ config SPARSEMEM_VMEMMAP_ENABLE
 	bool
 
 config SPARSEMEM_VMEMMAP
-	bool "Sparse Memory virtual memmap"
+	def_bool y
 	depends on SPARSEMEM && SPARSEMEM_VMEMMAP_ENABLE
-	default y
 	help
 	  SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
 	  pfn_to_page and page_to_pfn operations.  This is the most
-- 
2.50.1

