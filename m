Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281F35335D
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806843; cv=none; b=FVuLWpQji8G2UN62OQV2nJzsE8onL3uNbUUacmyWU2f4BvddtDui2WQB5lYcqjl59YA4qmhABybo34LkJFBhNI5mV841wvbLSp3M+tPsGNDWt4rB8V6xudzuucCVKuHpb7nl977IOnIJJmeNIUHDvo59w9tEoOr400yBAnYYico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806843; c=relaxed/simple;
	bh=rCgYuDQcQ3nJcWNFmOxD+pxeBEJSNoep86nFob2zhE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=d0Csahx1KdYRm4/Q/lbY6qhzgOuE/CBaNBCUIWZt0Q0m/GWMqTrCN2JdAIT6n0h6hsy2IVtwP8d2bfHt3rscbFuZNE4Z4/Shjw/q7PTimscChBqyyqsTHhze5syh7POfJN9C5BuMlsyPbukYLIJwYGtyGcP/WNuZ2GkD+Kxk6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/x7g2Gm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/x7g2Gm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zfh98TqNQqR9uCNr2hB5bEgIJ/15ql7Yv0zNbj5EC/8=;
	b=N/x7g2GmM2Y+GNvXIudCJPlMxW6wb2pOQh0itTOdPgmVpr5bIiD/10Qgs0sEFtIJJ/Ionq
	y/oJ9m8uW5OgJVJRFYL6x90zADPzDhOnW5Cff8ALZ7yi2udqSNDaMe4Teseknt/jEeYZd2
	MR1bj7HBKjwsCepEt9I9fJIsGt9bgYw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Sr6cN5lxOo2qg07_B8xffg-1; Thu, 21 Aug 2025 16:07:17 -0400
X-MC-Unique: Sr6cN5lxOo2qg07_B8xffg-1
X-Mimecast-MFC-AGG-ID: Sr6cN5lxOo2qg07_B8xffg_1755806836
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e4157303so922317f8f.2
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806836; x=1756411636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfh98TqNQqR9uCNr2hB5bEgIJ/15ql7Yv0zNbj5EC/8=;
        b=fVfLxM8/SbHLNbCIcnDIlRNVqJDbAIiRM/mwMcpf+LLcPIVewD/b909qA/51QTrvFj
         ojndTsJGbCufkFLeCYl5Ztr5nFky7DAuPPxq8OpqBevBKfKYLxzkRsQyR0qXAgr8F5hl
         qZrGBm1NSk9Jz+DKgIKvyeKJmS3oDEywV+JAFqORcBSiW1WkFgf1NYg4BaS5WpIcPb9D
         AVwFtqoq4JnyMiWkVx4ahygsSCsCkwcxvyTPXwgvKkURB33D5IygVTTquxr9WyK1KxfW
         JAW1b4vaT/YNTKF57qLdS3jFiKkIwCVBpGJs6M8HpwnxD46rInVbKbFdbHO4KsQKAzXe
         KmUw==
X-Forwarded-Encrypted: i=1; AJvYcCWBTFXCAIltD53J/PPf9T+F/3H27dVKnonmQ2iQKVF4EwhIKLXWNN4/gXgwIZzWwZJ0/lCEZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc0kcYVR0S/QgyWJY4vFPSEbQaBwlOQ68ELpfFgTX+TGM+h+O9
	AfF5cOMmTIYYv5+sIgjW1i+0vb9cimxJs0Qrwa7+vau0mUw1oXpAVC4M7Ut0LJQxqciIQGE5pRl
	x65sGJeXxvRICaWo4jqqykv/Ug8VuZrAUbeCO3aOVB0nQa2xLOP1S+KV6
X-Gm-Gg: ASbGnctlXCbf92vR0qdydcEo2sYsNExHy9CEXoB83Bppijm2/ngymWnaL32fXF404HU
	Xw/cpOpHCz5Nn4FnBrDdw6N54/VPIyx3VOWoykA8ptZ8ZIaOYrXpeiU15byrVmiF6ZNOAWCzu0g
	7ZJhmCacvkgj/P/YJUeoyb4OUuiMGiPWobR5P6UBFisKhDjlMAlPeZrNJcEF2b0s8GZLlc7BU6M
	mgYZORhQkbyB+JyqSkFlYhSd1agVuOjE8aJKJ4rWff1Ua5SpAMf46OUV+KeaB7BpMc3crPAcbcG
	t2TSAVgjnkYBixM86Ffmf5NZifS3+O+34Gsh3ufAE7yDo3O9lvYm9uGaXrOxI1ywtTCwBwR/qgR
	KrKobT28cWsFqLBCD0JCzsw==
X-Received: by 2002:a05:6000:1445:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3c5dcc0da36mr162969f8f.48.1755806836124;
        Thu, 21 Aug 2025 13:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpC+bUbLbCjHqucY3RiMYJPd72Xl9UYU3JmJwOiC1ZPXsKWXLLEiwWSHifO8HwGgrBWSbiEw==
X-Received: by 2002:a05:6000:1445:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3c5dcc0da36mr162946f8f.48.1755806835650;
        Thu, 21 Aug 2025 13:07:15 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10958175e9.1.2025.08.21.13.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:15 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
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
Subject: [PATCH RFC 03/35] s390/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:29 +0200
Message-ID: <20250821200701.1329277-4-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: XE0D1ZKRxmWhotpP_tdlp-I58oHOoiEbvmcZ6jBlGCw_1755806836
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf680c26a33cf..145ca23c2fff6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -710,7 +710,6 @@ menu "Memory setup"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-- 
2.50.1

