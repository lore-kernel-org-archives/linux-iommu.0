Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793747570;
	b=YYlIpjRyWvjxD9DxeUM/rjv8J4yxUU6eCCOTWFxaLUWBkRtMAG9eYAz/ZOomBX4R4rBY
	 iiftbCzL3wJNfYMsPnN4r9fFLdkCQZ2w8OmhX81ggbtUdOVgiUE++P1z2ugC3uqTcLd0/
	 pWBwfN1g0aSxdfEWebOwmaaMCGS6WbDlwDvweJIMruOQE0GVlYYaKX7aUbTOcLSWO5aQ5
	 jTAAjAhXfnLB5REvCWoGsjbxduIBghjEDxkmiNd2loPcVbc23rMr7vONTS5vFICvIC99p
	 eBOYw3Psi304oCtK4mbfccyKv2BU9cMrgFm4rReVtnTBi77rweWw90GG6M78eU7aonA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ryvB2JGWPuZAAGR2GMJJClI5Kf6c0Mg6JzyuuAdWS2w=;
	b=i9VMc6ykQ1MGCKNxgPuUWvQ2lfPv8mzKMaCrrOO1IrgOTW2cPfuc+YW64f2gdueHa9PU
	 7/ndyqTn2dVkCwrqvzxH2tcGvoFLwmBPVzL1L5dyf4gB4ub3jZLlRs8fbF0r4O/M7n2C/
	 GCat5GAC/RO4yhNJxMWOrXoYfapXw+qwOa03ehvJwanDhPydXhkCS7n/uRW2IA7+PESqG
	 VgH1NmuxBaZf3YGE1QbvUOhScsHdom/7JViDI3pi0p9Dn/emc6NtSxGXjKyO+eNzdj1bv
	 RvOLKD1JT3SEvCFMcK8w/0SRsPl2Z1L6T3MAg2luVSGdxkMpyLjsMxSHqMP6rQVz7Iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vh6WmtpO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3112606A324
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 23:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3112606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vh6WmtpO
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c79f306e9so1708556d6.3
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 15:12:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793747564; cv=none;
        d=google.com; s=arc-20260327;
        b=rcwuR+77cg9zRyA8XWtx2v8ZmhzXbwMZW0ZgvDhh6niKlPLudIKvJCIObtVbiMzqkK
         /gPQTdvd9pkuHuM/7Cqv7+XmOXk1oAq9TSKdIsixqCY3ZhL7tQu71Eh8g9ubFOWxi1O/
         9//2HWltamumYJqW1AWc1Ozk+LWV92PBnAlVlgvSWgDA+4KTjCAw3vgspmFe50L2D30d
         jkN339VBZEcCx6UOUJcw7n0SHfgP0TxRX3cWvUONrI7jtScm11ytNdaR2Q0xGSlFUuK/
         Sw3gNT39PW1mqwcwTanxQJ/JvTJSlT0xna283/2xsZf03CSIBL17OahKba7cgQxSo5QI
         jn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ryvB2JGWPuZAAGR2GMJJClI5Kf6c0Mg6JzyuuAdWS2w=;
        fh=KGd1DS9OAuItiekwLsWwTGcYRiKAmW2Cez1rBZ6zsTc=;
        b=BpgXhyLtRPwW7HxXst15z2+OFlAZblEiWh94ugOeD2y7RALM/O/SPdb5iu67+D4Jzi
         oNcsviLSgB84zmNIIN/1Ldwa7o0IjhdA75fUyPr8/6pOc8AD1nSqJ4/VuR/PzZdGt9mO
         iwD1F/LXa6isDd5pIFOIb8gt6xap0ynNE7qDD2vFbqNixCV7k7F9rCAolTn66tRrj4lt
         YgcxrzylOO7fBwLEAc2lsvYmWHvbEMl3zRqlWu+GjZerhFF43bfPm0JEtiJWNVU7IJ+p
         i96lJzO1Wy+z5rpfYzher2T+58T1m7Afgke7mcFI6Uh51mab4bMLh377O2HYXU5XVuSN
         kCnA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793747564; x=1794352364; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryvB2JGWPuZAAGR2GMJJClI5Kf6c0Mg6JzyuuAdWS2w=;
        b=Vh6WmtpO4DFRjhgk2OSHe9dfcoVHHEJ7JDMGmG6L3flBWzxlr2j3LzAkLlFGiUWl4T
         LKZNwvNvdkAIB1vC7EVA44H/ocUACItm9cQJIJoiPEwu/3AwZmrdHw6M8d5cbQrbaYAi
         zqI4ddKdNpEIsKjwu6IH9pB0T5EzTvVpWnrUTA5WzcDxjgmXaGg7KSgC1EyjiBdAnt9n
         1Op3RlmiXsNu04BHVvg7dSGnbBz2D3XbowBOQJV6qfmMQzBncXwnlZdRC+oLc5erVqmg
         nBgJLpuYCtIELgxRVtnMctsbelnQh7hZIMawU3AUy+3Tl3ncF9x9Xt9wumFqBzLS1rYQ
         a7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793747564; x=1794352364;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryvB2JGWPuZAAGR2GMJJClI5Kf6c0Mg6JzyuuAdWS2w=;
        b=jrsypk4TLber6CQ86wRzWSjToYQgm5MSvCS93/WuG2vyuMebtHUVcFV4/+4HFjcrkT
         gEghNuRvqgHins8OKpInSUwFm2l+9B0X2lT+xlB5pLb2/sy9H0AackwwH/0R8hlQLHqK
         1p8uW4xQzJPnDwCJ0wH+8wpb0f+mWJNWRoWNYdi+OcZjQdN2smmNJAFLbTsuMOIYOnjB
         Gf7pfi7lTxkkL9SXcZA0Q8HcqFwMoUPtf3YJDtsHbCNEkX04sSSAQ6Yl7Y6qNp/DG2Gj
         w2+FwCi+ZG+XcctTUDshfRxWGhVIOMyJzYhmGwcjPTK4vMOwb6xcBz+e9qthAdiHEwdm
         EjHA==
X-Forwarded-Encrypted: i=1; AKwUvBxC0HiiRXW5XznA+FozxsANLYyCbvAmi61FAioHC7I0rWZx/Yw/bJiTaIsc2s7pUQxUTYwqCw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+SEsE6h4VPvbvuub4XSn2ouAVaL9DPf8DcTs/EsA6FJzkMnvDP
	fjGO/yrNymPejyMcEi1PUzJ5glwVuwIq9OBlX/y4jhuA11/ptte2nkkvtgUr6afA1yQSHhgAyrH
	1Gm8T6gf54qhqC6XDD/Kz7YZdyDvCNZxeEeMeYow9
X-Gm-Gg: AYBFou2fP/EJButJHCZRAQQvdiWXT+Efnl1MWrhEDOM0ozd7fBI166FTKTKAsM8xxXW
	C9FiAnWQiK8oW4tfV79ba2BkynDsP3n0jog9R6/KVf6/0qV7pY9TzoH5bswEw9zb1zzR/WQrk66
	fndr30LkPq8/kCgM3i69HbxqXDNOaTZoVhuszvSC7PQtItfaPwPoA2mwnsUWbyS/TN62LoXOPuy
	jYit1/VuRTGTTtxLgxt7VJbtyXwWHK5Lrvbg3isFOhtJbC5o+eEZ/M7YSpyOFOTSI6bCRbAZ57e
	xEgk/RcGxKAA7fNMhZ0x4/BKsixM3CwC/YYJ3dMZWjXAxXwGIAJP/Z6bZeFw7c+8f/FIeqG1TLW
	pZ9G7Y9bxZZ7U+lOHqai6MWuYj+jwW7Zb6wOV2XS7pWSi4FyfNpQBtQgDRfSL7BE0PZpQXXzpgr
	z6tgQL+jrOzwzyLJe0FcNyCUI=
X-Received: by 2002:a05:6214:570d:b0:91b:832d:ce5a with SMTP id
 6a1803df08f44-91ca4b833acmr247908926d6.48.1793747563253; Tue, 03 Nov 2026
 15:12:43 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 15:12:42 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261101071928.2462549-7-aneesh.kumar@kernel.org>
References: <20261101071928.2462549-1-aneesh.kumar@kernel.org> <20261101071928.2462549-7-aneesh.kumar@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Tue, 3 Nov 2026 15:12:42 -0800
X-Gm-Features: AclHuK-a6U90XRQ86I28YCLgetKuFVa0CnGLyQ5k0MglUtI4Y2OMEO9n6VKxkJo
Message-ID: <CAEvNRgEL5SuPBwGqwrUzD3Gb1iUonhvM488-3khHpQk8OkWr+A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/13] KVM: guest_memfd: Support device-backed PFN providers
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> Device resources such as PCI BARs supply PFNs directly and cannot use
> the folio allocation path. Store the mapping owner and device ID in the
> core context during attach(), and use them when preparing device
> memslots. Keep device memory separate from ordinary PFN-backed RAM.
>

I'm really hoping that device providers are just another kind of PFN
providers and not special in some way.

Please give me some time to prototype so I can see what can't be
achieved.

> Require device providers to use PFN_MODE and INIT_SHARED with
> architecture support for protected device mappings. Device providers
> require get_pfn(), but not the lookup_pfn_range() callback.
>
> Mark device memslots as guest_memfd-only and pass their device binding
> to the architecture. Resolve guest PFN lookup through get_pfn() for
> either shared or private attributes; the architecture decides how to
> establish mappings. Include both mapping types in generic invalidation,
> using the memslot binding to select the architecture unmap path. Host
> userspace access still requires shared attributes.
>
> Skip RAM population and PFN reclamation for device MMIO, which has no
> RAM pages to initialize or reclaim.
>
> Keep mmap, fallocate and attribute changes on device-backed guest_memfd
> files disabled until device mapping and conversion support is added.
>
>
> [...snip...]
>
