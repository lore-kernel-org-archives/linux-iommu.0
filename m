Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BBB36CE0B
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806849; cv=none; b=L4rvzZUQVs4EvbqMWwiGKq9mC78nnjldjoUk1ZMJ/wkStBP7RNxONc1D0qygm2HF8d2NbGb9Jj7BWyrqlYQefis7e02fSTzvyanhQ7Ga2YZORRhq7JJbynHjqRY9lJnOwrxTutmQ8toUU9Bt19VFTZ8U+sR3KNQ6mBF33Z8VBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806849; c=relaxed/simple;
	bh=Cw7Tggvlta2Xmlg9ZVygUv1C92bk8NKTD0n9SH6aeIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QkwPDuHHxXYIXP0mGb9EO7hhjY1+sDbcbqr2PcDuqcZd6PZyIQbD6NRS9wE5m83lNgY5t0FOvF6gkcixDmqCWRRKrz8cK7e37ywlv8XqfTairjHaL2F4q5InGnxGrYGSaZ1JrvTi4t1Bjt+OgTJsSLoTx/ejE/x/oIKnLqO7Bk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTcIRXGK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTcIRXGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU84NUWejaBSUFBs/T0/O04YrYLlq1RcxZMywEFGjU0=;
	b=fTcIRXGKCYuxu6n2Xe2skScmBC/GrTEMsHMSgu9irGxqyhg4Qm2Qu9KIiJwVaG/6Zb0fkH
	woxlAPe/eXZX3hNH9GRU2fY1UlrV/QOsvlxPb9j2Ypn2iDR2c5eJsZwFvpouqu/7Le1c/h
	3jpWxlLYMeDCBzUv7QD3HBrucGLFUkk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-CT-apWwQNUWKBxn9TYRs0Q-1; Thu, 21 Aug 2025 16:07:20 -0400
X-MC-Unique: CT-apWwQNUWKBxn9TYRs0Q-1
X-Mimecast-MFC-AGG-ID: CT-apWwQNUWKBxn9TYRs0Q_1755806839
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0cb0aaso10734095e9.3
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806839; x=1756411639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU84NUWejaBSUFBs/T0/O04YrYLlq1RcxZMywEFGjU0=;
        b=qnCzipgH694xK5/yCNBRGNeGsegH53rvb6xn1nsIAOOvVd8ieIJZXGGTXcjRsdgf/Y
         k2GlogNII0+lhTRjaDOLR+mvhoqsFSKB98DPUDlpEGlTqDOQRkPz/fZt//uBX+FZXj+8
         GnAgAqugfr2sTdT9896YrIyqTNr5nf6Rt+sNTDqjLrMQw7f/gzfmY4H828RKJEDH+uz1
         wtYaLoq02cOPjCklWweudoLGY6xj0k6CA3MKL+Ri/BcK59c2q0OQWYrh3vOBjWU23pr1
         wyis9lS4s/eNxs/yu/H46WMNRTBl5t+KaeqSRSCewlCgQ4yYf7rUrD0iTPjRIoVZcBND
         v3fg==
X-Forwarded-Encrypted: i=1; AJvYcCW5TdmrTmiIduhPfHAJhfvVZBu217sWvNKGq55bCU1sl98871PIlwOc8NvseJT8HGqkw1/crw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3GzUYW5s01R1Xa6uoxFtTSH654BTo0w1Lb4uStVwTaJW3CVV4
	wzCNAVM4Zp41h5ma+wdNWDK1zvT0kElDe/xEBAeiPsqO60ime65k+2xCU8QUhh3m6XIqJHTSX3r
	ccz/j1x+iBS8d7bRT4VhXJ/BJe4u1y8PLGO4xsi/nkG4zN8HHWrRwp8qP
X-Gm-Gg: ASbGncvdidPZp/I/uwwnSOVu+8x1Ui/lmQucHYa1u54a1CLGmKxK9Txm58KnBqEyhB0
	1x6Rso+4Do7DVohfQ2FkaToLlBsEnYiQKc3cFlSmuhyftb2gsKFwoWiD8ZhaP40rfeFMFD37OA/
	+isBG/cAyaPfaDQHPJWxAiJeU7MDPoh9f/FT+IMg/W/voqo1jCqVy9iaZkiyQgZASTel31OB0xB
	G01Wsw0C824vWWQUEttiIda/ZC097qna7WAEA9lAXDaD0DVZ7kSnI0FooYZRvjNR/j3/P4saw0a
	cmEuGoHxXabHHODZf1X1eHxnYpOD8utTaj3+ztgxCwGq/3q2Uu67ynMZoqcegQ3kglm9aWu+Dod
	Fz3EvA2xKgpRK8j6MmIwByQ==
X-Received: by 2002:a05:600c:1f95:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45b51799428mr2845595e9.7.1755806838964;
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMhnqxttMNkrL8PAxIX9Mfq64uKkvY2MjzJ39LtAH2Yg7PxwVl8kOZ6CXLaaMF5rYTxrWwyA==
X-Received: by 2002:a05:600c:1f95:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45b51799428mr2845125e9.7.1755806838506;
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dea2b9sm8988005e9.15.2025.08.21.13.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: [PATCH RFC 04/35] x86/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:30 +0200
Message-ID: <20250821200701.1329277-5-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: nm3uaJJXykyTXuQA2KZog2tu9gSNxaCWQO9rFwhlwcg_1755806839
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100e..e431d1c06fecd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1552,7 +1552,6 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
-	select SPARSEMEM_VMEMMAP if X86_64
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool X86_64 || (NUMA && X86_32)
-- 
2.50.1

