Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F6934F49B
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806839; cv=none; b=eX/QWtmWPHJUYw6vYVCnQZKn9BDpMXboq3oCjbPZCPXnbPxNbyjhgG4/hWiz8iQ/QtmDiIw86c+FfpUy1PJElA2b86lnSsLFmc7e+bOTs35p7o+AoOw+1kzNUbdPogrv584R94lhuJ7Okg42WrRALYRcSDUlaFi1PDvhd7GWQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806839; c=relaxed/simple;
	bh=3FOM28sJXvbUF2Tn/5jLCVekviR1dLu1+OtM4m//AQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=aUl3gokNF0bVFUXNbkPLUR1r5YeVXuKmitcTskefhhymEDy4yn/4oLaGhojW81n4NZehQB3B5awIELwME0XTvBf2FvTgbviOubfsO3P5AW9+dZW7qDrWnyU0fG2iewsO6JO9ekw0Sj/oS3gKdsQB5fmF1jL5+98sdBTCiWMrVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgJ7eRIi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgJ7eRIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
	b=HgJ7eRIiRnHUwprw8uD+r1ajPbmAARMgTrShQtGg1sioMAt8EgUgFef4vrY+ot4FQmuFbk
	0Ii31kXOjJrOklrts4rPKdqCnpL3OwIhKWoYf1d76pOXYRfVgQeRDIgAAGOPPypiYEq77G
	Yxj9qQkyxewoHCwOAyMLSjVhWqngJBU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-4icCpCdxNx6AhDDmxEeAtg-1; Thu, 21 Aug 2025 16:07:14 -0400
X-MC-Unique: 4icCpCdxNx6AhDDmxEeAtg-1
X-Mimecast-MFC-AGG-ID: 4icCpCdxNx6AhDDmxEeAtg_1755806833
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1ba17bbcso7089355e9.0
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806833; x=1756411633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
        b=jA2U1/ncuDG6CmIez6/tEbeuXjzhArCjHtEojPQQt++4k6N13i60iM28AVsNOYEeIw
         QCO77vnFiHY9bKbErZQt8YI7dgXBvVDqMDcZ/37CrilyrspOTuvoRNg1hjQXvlyT5N34
         sxRxVxf0VMp311WBRqMAxFQi3pMQhOiHDCEEQrOArI2FnIfIF+9iTp3D8fFsfoF4xblT
         uvJXaPNIItOaXqYjnFnKtKRFz4FjPA7b2QeivLZuhRFhSUhIddYkj99bjChUGYTnDZzs
         LpP61pE/ZyUwYpWg7IoTkFPNgpsvCfzBmh/CvFqG+3CYiB44z/ciKHqJt4EzJNCYNBVH
         UWQw==
X-Forwarded-Encrypted: i=1; AJvYcCX30n5ABVl9ZDJCjimxwxwCzPzfwMCPJuaoER0s9c7b7PhwUrLEGv0ZS/nA5BrWgWUpuC41vg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5W3KnxS4V6AvqaSdn7mKjsmYysOInc8JCwDRy3JKmSvozWrxl
	ZMkkZuPX2SZ+2bhzziUsTyXz/qwozAaP/h9d+uV3DQK2v646ETPAiIrDT1AT1oc3vKuTYeeV+CS
	i9AJUVsaMwCoBy49rp7+cIRgWSb4GJELGfEazdj2qOBoidMhHjlzv2EHb
X-Gm-Gg: ASbGnctXHTyGe9L81HRUm8BozcFFLl4tU3l7hqUxczBgA9v5bgovX03khl7zmgM+dBj
	P4j/Vs/PvT6OJZT9Gbz1q7AeEe1ZMRm8KZNo19WxhdmsELCpvBI41hGyZJoqHQjzkMzprwW/ny4
	yvDD6xMzRwJMWDeWSHL4et/4prErtIKxHuwE7X3WUuLSVzKmVZTB28sxyBpqwHshuZC3So0OPcg
	SB4ufNdwRO9qxi6l0L1+kahzQaqKs/RGigW5WOc7lhAz80OHRkufn7XV6yOPcGIaQcVqBn+FiVs
	RClEVrbW6rf21ouLDyir+31XK5ufDTUyODLztmx6xZkAV4bJHQnF7W7WTTyvNxe4CUjyQ2OBBmM
	yf6EqBi1o9BeG1LDBfiGoow==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2598655e9.14.1755806833374;
        Thu, 21 Aug 2025 13:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSutx6qbatKffMJ28UfT2ZDXFlSv+vNq81oYks3KAGI73zxxTWKo8ClwQ/mmPq6W0wDfVQow==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2597955e9.14.1755806832889;
        Thu, 21 Aug 2025 13:07:12 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c166bsm12916801f8f.33.2025.08.21.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
Subject: [PATCH RFC 02/35] arm64: Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:28 +0200
Message-ID: <20250821200701.1329277-3-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: dxGtvDEgHif4pe_d_lgfPHGVR8ilm5tZYq0hiuzSWkI_1755806833
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a64..b1d1f2ff2493b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1570,7 +1570,6 @@ source "kernel/Kconfig.hz"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config HW_PERF_EVENTS
 	def_bool y
-- 
2.50.1

