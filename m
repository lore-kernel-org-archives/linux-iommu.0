Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64104329371
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765831816; cv=none; b=gTrGGYiahyJc4dGkcyo11wF5dZjCLRpVUc0txxp3z5FAEUe/79HaBYF5nU0kadf4OE55CPBkLDZfS1vaoN3duyUNde+qjTwHqtgfwwSbhc3Hy6vulRVVlX1K1+FptCfBVdEIOGGSRnSl/EUoLzWzoqeL/3oWGPsj8pVhF8uNEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765831816; c=relaxed/simple;
	bh=/zzNdDcCD8CX/w1T9vgXfZ468hLwvM21VMAR6i3yy24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AieyrOJcQ1es+TZENvnJOWg0ZyLbQvnvkEGAFkTHH7/5+xp18c5PDGUxyMunCj9eQiGTRmhGOuMUynI11kRNZP/vZ4G55rVhpOzMfJmnzQ8bPIrH0KB41HFRNABn2Ob30Xg9nIA1lHd8FmwrYKaz5XJPbZqgoCpLjPNnBRb4wFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N5xAuSMH; arc=none smtp.client-ip=87.248.110.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N5xAuSMH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765831807; bh=/zzNdDcCD8CX/w1T9vgXfZ468hLwvM21VMAR6i3yy24=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=N5xAuSMH9fSvxDPvtvkLRKCcm4/FuVnr2e9+UhKa23h/t0iG67Pq71e8O0L1xleHl2XxZyhEzt3NcRGRQwoYwaHzJVMTTgdXNQZJV0lj+Zg+Nxn2GOt37/VgFk+yf3nHzFp+9q/XxQy6vCxraFs6l29j7mocfRAy4DQ5iCdv+zBgVunK9UF5YJ9oQgfWzm/iZBhlqUP3x3UHECr1tbvtc2XFPmM+PWr3uQV89o9TdnTdCOxHgKoEQvWHQ9zUwkdLOsNaD6yDIPEOa6Z9ppKbhdpqOV1/X9wK6EPn0lR6K9ruijdC8mLyOYG2tPNd0E59SfbOXefg1Bv2HNZ64Nof0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765831807; bh=Kp0CtMTLSZxMZwJZq6L4cLK9ZuGYn0BOIN+crKQayiA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HFFAAE05kxLSyXj0Rde+LO46/+VNGzzSEUhdvI7rbbE/g14waNflbBGnDyn/KydaARA0v2CDw2FTN7TrIcO/pNZCOe1HhaX3ZB7qPoK61aFZnTweksoTXy3TN/b6d4hst8Q77q5MY36pXY9Jd4/V/X54Iv13gi4kcjE3sQM3W84L7npbmrYl9XwGZvUMBMUyO1G6RqERyre/H34i6tBdH7E4Vlo5irTHR5A3seCOYWAJV4nzDv29bMWshlEYzeVNmxQkwgOnNPyG+fGyaqxwPbQKhzs+kR8Hg+sRVusNpCUVKOj3OKXP00bgenmC60fudeA0QIQmrpzHX3Ocqe832Q==
X-YMail-OSG: _H.x0RAVM1k1QcTh0u.I3IFNnIvu7LUIO2SxGBw1OWSMBCrTz8FKGZHCAv9gyjj
 9QRPgHiMs8U.AhIPREP3NVkkDnuQHwtM6OImvnTS_kV5VnTxnN_DKTPZMq3yZHvqnXOCLlAXUMEG
 ItyF0OltgfwmCvQejlA_Cch0Scvu.ffi.fCqBL6mm9aVprC37n4S3BdUcsIvHZCp6ZnPuR4L74VI
 XMQDIiLMeD6vMEEd8ICn6RUj4pj6PTd1CyJAAuHknJu7d0aOLZDN_FVGhC6qHBK_o8fGxYG05grc
 ezGHYHuJ_D60xN0hgZ3LLSKcqL1UG6ygtaunDbtSEp.y8PYWlBX6hMzuTt0UGVKqJ2pOgycoxQFm
 icEP3umxG7KuscoNWom.quqY6CF2esLX4s4JEjBoRZimwYYbCckDRUU4tzc1tLZihp6aHO_tTmJR
 RDJfeJcd0CpC1vfVEtAiBdrfyUr4FcSz5hZprX0v9EYpvhUy0ZV3XAtg18B92webqf6536Bo7kj9
 ERqLBM90dyVOsdd_rWdukNCwRmMtgYSt924xpC1NUOwQdVjugqdQdUGFjTbNFN6Iw.4I8q60i1dS
 TCDqRtskCNpjQcgxYZs2T7BpvoijiyUHVpqwQntGq3U9.ver_lyEmXZinrmaXetXXmTp9RGC5jYl
 3irynwd3dZCIBCsl5KIROuOsa1kISb7RQalmVINC4TgToPza0bcFJ1.4Aqj45BrD.A7KpaGDuuJ4
 mehc_eZ3Kp1NOqoyTwHdyWq4v0Awr7SSH2ixm1FoMimM.Hru16XIMVjnJzmAYiqghB41lCn4RVEG
 BhAJkr0N5YLXb707A6Amenn1wA7UDprMJqpoqM4W_FB1d2DYSu8bLU_N6wkKrArcLsdY4eCNCKUD
 RYMkfq1cbkIPh1U01wVY6irJWZ4ozYAkU2Wi4v3gVMgGMRouyATT5PBUIkJYZMwcAwvF3xiYfO.3
 rDZVyB62RwYTwOV3pnDbp6jZZLk7NEVK.y13jsOPuNm64p1kx_DP_fDQWf83dK0_8NRnaFi9XTfR
 h_X1aVdEW.v8tTtvIJY8U7C1IYfCWKWATh4e8PyUJsaeHavuFqzu21UwTUnMOLIXAvd_LfGXPLv6
 bLXyGmu7AuA6oPxTvgmvaykeILyqsCnI9owAKi9FuH1_sBWl4GJ5XhIEaIXjyM9rxMeFnbLDs07u
 zSCWrZHWCzo3jFKXe_qQlpTW0.8HKR2lDZ_mbNywmmfjhpb5r72Pqu9WLjQcWwasd0M1SCH4LmlV
 tU46nKYlujyK3BQH5cDQLxRc2AIw3_ZEW62ARuwKb143CxDCsAZmAEr8cTeFCO769rwM5lmJ1kFr
 bQFdrCENuzjqRXJHTFPzhZ2i8N5.SN1YmSinmAvKTF_Zvqq5dVqkV4bx599Q0piuumJvCQvSlwje
 s5nWRWooAFH7qjWFiIxb4acTy2IX1yK4X6tirHuD.BP__WSLZu4Is3edHkOsaziM8jWlNuF5CuFk
 gmpkKYGFdZk6f88UhDF6TH4uDq_8xF9XcUgCoXajt1xbrWYyNN5gXXSwe3r68OHoIfmk9c47dkHT
 zojyGaA3eQtLbBt0CvxoUf.hDGan0wkPxyLPYz4l7nR2bZ66t5.3p4vGgPD1uSNBNlZ2oFrc5QK6
 TNY7QaESAIafIvn2f_9Az5b_i8OpSzVFq6OgKUzUuUDl_A3i0MinIJ2WKc_o3yIXG.bvKdKJx87a
 x3KihSwJr0gEpl_4NXft1RXrSsj15OPuGVn.mNzlUjKGtUYujQsUi3YJzKsaVmFWpxWWRngB4l.v
 sjPX2UVttd01LTKrxMPatdGwSMHWRfd.gCPkitGFUoFcSwsfalktkbMWcpQk3E2g4qTmo_zud7kz
 N.L7OaGk2KwcLSpvgSoUphSWvk5Mfst9jkqyI_LPa9.uLQTFDKEEqaarl44VQTqkqNT.bhuuPpjD
 f8vylTiqvIIQ.sxVL7yxs1EKZWBQe_4BkhxLi6A6ZTsKYt_xVHQxsKJsSRMOuo4j3BY4PUZ3GVxl
 W082rdHJFuwXA8GA0A8dZHzUPpjz5Oozcyx5IOUXzpdivrRVvFShUuLwm4dRSJJVGEhroHwH_E8t
 xfOExLGG3qq2IM1Y_UaAqO6gQVBLgQ4RKj1Fk07pPSGSQeqZByapHExmw_AvVsahdgNrmzyJOyjF
 5_ebQxPzsx_qctxtPWK4wWXWIcNVijo7_haGuLeZluBMfAbI6jGeKYJq1QtyFbuw1MOHp98hFgvm
 XVK6w1ezZ9BPanKxs1rLB7Yr5ZPX_VsD0z0scuEyNt.RdsXyxa_FhuiZ8NN7JwJ4-
X-Sonic-MF: <andrei.popa105@yahoo.com>
X-Sonic-ID: 88724180-5b9a-4700-9339-d055ab400d06
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 Dec 2025 20:50:07 +0000
Received: by hermes--production-ir2-7679c5bc-pdjpz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e1d66fb77c6e6fa7c9b4de4032fbb07e;
          Mon, 15 Dec 2025 20:50:04 +0000 (UTC)
From: Andrei-Edward Popa <andrei.popa105@yahoo.com>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com,
	hch@infradead.org
Cc: andrei.popa105@yahoo.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-remap: fix dma_common_find_pages() page lookup for offsets
Date: Mon, 15 Dec 2025 22:49:55 +0200
Message-ID: <20251215204956.20659-1-andrei.popa105@yahoo.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: 1d552f40-74b3-4c6d-874d-508ecb0e75d2@arm.com
References: <1d552f40-74b3-4c6d-874d-508ecb0e75d2@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph, Marek, Robin,

Thanks for the detailed explanations, that clarified things a lot.

I now understand that dma_mmap_attrs() expects cpu_addr to be the exact
pointer returned by dma_alloc_attrs(), and that subdividing an allocation
(e.g. via gen_pool) requires the driver to keep track of offsets and
adjust the mmap parameters accordingly before calling into the DMA API.

My patch was effectively trying to make dma_common_find_pages() accept
offset cpu_addr values implicitly, which would change the DMA API
semantics and mask driver bugs rather than fixing them in the driver
itself.

Given this, I agree that the correct fix is in the driver using the API,
not in dma-remap, and I’ll drop this patch.

Thanks again for taking the time to explain the intended usage and
constraints of the DMA mmap helpers.

Best regards,
Andrei
