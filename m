Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08D41B366
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179223; cv=none; b=GdrgT0dWRF2VT45HRXA9P19VHrWbURdhEtqXARZ8DHhaAvs3NXs/SlY5uxUWWdOKHB5bBbOjWxJlBgloVxPvsg+bBS3D1yxmY5Yfip7Uxe+rbT+FhtcGvEYJAK0Fqz7LMTWssBrFp/uQCIvZc5McnZv63eno6/5MxWqelAb4794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179223; c=relaxed/simple;
	bh=ln5AjyNWfzYrFxuevowteUP8a6ELykKUVDzygksz2jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ae2QShXxJZHWngSHnN9SNdgQv5Wae2MeqjqKZbHNwc35+cEOXXmvOjpf0RIoRDIs8Zw6ozxdyVIL6jL5+4pSzEmT+Mlmr+QS4o1mfHCyprtnDJZeaE30biBXGAkFqkOHpD4rpuv4mu/voqJDr02IDvyLiRKcPRWPSqaMpSVPn/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FmUQyAuF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmUQyAuF"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba180a022dso16835ad.1
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778179221; x=1778784021; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NhP+n7DxEFBfq4ANgD7pXobqb+7/slgfnCpBlFNfz/U=;
        b=FmUQyAuFqVBvGu5J/MRaXOvFcHJsb10gurf4OlLrhtWndyVf/9lvNncqjlZSeJE8yo
         p6rVxKyo+stAkhIVj2Ay0jGgYRLPrrmo92lM58/8UmL69khgcXrWDxQ8Yopq3cFNfCXv
         +S0tL1lzGB7CKxDXviclP2WryezbpdGU4aNQQ8PP0Cs2jptZ9gk3nzn21OakMIDuZqV0
         SBOjkwH4/ifqz8lHuNEm2Kj6A/uicbSXBw+vjSLlWhFPPV/V0jgSpQeAivRkqJqSWtjA
         LATy772iUgASK8Mpvdg2Aq79blyfx2X3p2Ypf2Pj56PylhNqZQfXKkRjsJ5ME5A896X2
         zkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179221; x=1778784021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhP+n7DxEFBfq4ANgD7pXobqb+7/slgfnCpBlFNfz/U=;
        b=FpGpH6VjMF37qNIXZVnnvi11a+reWO8aVRLug1QvlmrerLs81jfmtG00Ud/GmpTHlQ
         7QIW9YlQzGxw7F6G2JAlSrLEdWfca0QX2gF3C7VWmUWlsgPqlB2hcVYvXcVt/4pira0E
         ajfYQO2SRb/+LUq2GIJVSS/sR/iN/Kj+eV1OWDw6PFgtGOEzvG1j+xcILtyVGXppxd6x
         MxWI6MYw704dkAJFzS9hX/4hteOeMUrbKAFuYfSNwCASfDV0XOOG7OXOmCJYYuBVrYr2
         0Ru04xUbmNefX8ChUpDaunEb74HfyZE1UqLcYVMyhBlMJaBV+56lbl4Qeio+cZkOYk9x
         kZmQ==
X-Forwarded-Encrypted: i=1; AFNElJ99c7F9g4ZjzcY4MQaehPGCWnJgqeCyrKmJL7JlZnjpvKrIXyB2SVNq7gj9hMbNUXmVXGs3wQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPKQ7nC8dxBoyot3uIwqb+rQZ3Ngbyz+LorXuLCEQz7WLZCksH
	p6AUy4iD0HhVAd/1AZuMECNVMvhm7A96l0mH9z2jIQTk2zeKYz6teVDk9cmuAmLLA1bI5uAPIEh
	TTjU+ZVJN
X-Gm-Gg: Acq92OE8OVuk+0AomfajcCO8XrS2JT6gvZ+JhZz5BTti0prAtVKOMjMjXGv6r7+MTQW
	oQ/m2cExC+eiHe+re4iKWJjVfv33eeaowV4b3HO71xrYZd4BEiZJWHun2aMp0B8AQzqV3FUDju1
	EX9aYIhfz/yc9g6TIclGTyrUTmd1c0qOo84LRw4pZsXLmVOfFDO+jGE0scIFiqWwRqKZ3E+lm+H
	2+u/iJqLG3nTazW/Iz/oKLQXCZ2Uq2pSiDVryFfK6qv/sMXpCYNIcUNbxuPRS/YDt/FsoECa5AX
	gR+1lsUJHDfLKhOEUo+GC/iXFnFKC3A1EewS7FqhCjDQ6Gsmn7HK46b7ElnBfi811HvIj97QDJU
	fkhgjeITYhLUWhJ6PAdf04GYlv+z5t6bClxqa6T4+1VA+E53+J04zvY/6u6+UsoamJodPpgO2dH
	WoxcOd9px+rc6dN7H0bYyGnhXw8kjTMZV/UYPtj2S4ZirE9EF9EE5eYhvbOLh/ulZv2C6ZNQ==
X-Received: by 2002:a17:902:fc87:b0:2b0:5c88:51e1 with SMTP id d9443c01a7336-2bae9e67750mr620315ad.14.1778179220958;
        Thu, 07 May 2026 11:40:20 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d314f7sm10033887b3a.23.2026.05.07.11.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:40:20 -0700 (PDT)
Date: Thu, 7 May 2026 18:40:17 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <afzXJtIW6vUYplev@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
 <39a010b4-7099-434a-b8de-5d03a75f2a9f@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <39a010b4-7099-434a-b8de-5d03a75f2a9f@linux.intel.com>

On Thu, May 07, 2026 at 10:55:42AM +0800, Baolu Lu wrote:
>On 4/28/26 01:56, Samiullah Khawaja wrote:
>>Implement the iommu domain ops for presevation, unpresevation and
>>restoration of iommu domains for liveupdate. Use the existing page
>>walker to preserve the ioptdesc of the top_table and the lower tables.
>>
>>Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
>>the next kernel. On restore the domain has only the preserved features
>>enabled and all the other features are zeroed. This is ok since the
>>restored domain is made immutable and can only be freed. A kunit test is
>>added to verify that the IOMMU domain free can be done with trimmed
>>features.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>@@ -251,6 +252,12 @@ struct pt_iommu_cfg {
>>  #define IOMMU_PROTOTYPES(fmt)                                                  \
>>  	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
>>  						  dma_addr_t iova);            \
>>+	int pt_iommu_##fmt##_preserve(struct iommu_domain *domain,             \
>>+				      struct iommu_domain_ser *ser);           \
>>+	void pt_iommu_##fmt##_unpreserve(struct iommu_domain *domain,          \
>>+					 struct iommu_domain_ser *ser);        \
>>+	int pt_iommu_##fmt##_restore(struct iommu_domain *domain,              \
>>+				     struct iommu_domain_ser *ser);            \
>>  	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
>>  		struct iommu_domain *domain, unsigned long iova, size_t size,  \
>>  		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
>>@@ -266,12 +273,22 @@ struct pt_iommu_cfg {
>>  	};                              \
>>  	IOMMU_PROTOTYPES(fmt)
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
>>+	, .preserve = &pt_iommu_##fmt##_preserve,	\
>>+	.unpreserve = &pt_iommu_##fmt##_unpreserve,	\
>>+	.restore = &pt_iommu_##fmt##_restore
>
>Nit: would it look better if we put it like this?
>
>#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
>	, .preserve = &pt_iommu_##fmt##_preserve	\
>	, .unpreserve = &pt_iommu_##fmt##_unpreserve	\
>	, .restore = &pt_iommu_##fmt##_restore

Agreed. I will change this.
>
>>+#else
>>+#define IOMMU_PT_LIVEUPDATE_OPS(fmt)
>>+#endif
>
>Thanks,
>baolu
>
