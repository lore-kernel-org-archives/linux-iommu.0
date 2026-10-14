Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D32D47F1
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012580; cv=none; b=L12ecWi4ZM6lgcIIWuBulaZy0MyQ/zwu3EYfADqerdR8SRfcRiEdDkJWRZnz2eTi2/FcPIpHkbjizbj1L+XbeWoWdjbbPLKTI5SGiv409NsEmiwUnd600Qn4fnKTPTs0kHfI+6YSaUtHMhfQ7tfB3uY3WslN5Hsn8royTZmJv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012580; c=relaxed/simple;
	bh=xFG6x/caOplP2tyXgSPYkFagvy3LI/93+6sftU7tLJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVb7M6G3syaUJ8hr6YMsFUeq8TKnDMsMrel+x/lI0/xtVhJfz57xM5fIJSGXnZSujFzzvQMVnw6mADAlc3/BS+6ShEa5P0V8BuWUriOr+RA/kEwYmqb3VH8btnHdK3PKHeRma8Ex0G8DRhZRPHzfHZUSj5G/q3oAjCHLouwRUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oqpdJX25; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqpdJX25"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48de6a62a4cso1713859f8f.2
        for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792012577; x=1792617377; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mbxQS/IGQfFShnzjZAFBRrockgDU/h/fKnsW13Xq4Es=;
        b=oqpdJX25KM8NL/LDn42iDQuxZ4lqyurMt9UR7DuBvTkEKRiFsRjTmU1Jem3QljleyB
         yqce6TnS+aOQEQE1lbnqiJ4bqPixo6ebRm1mckX8fFtbKA8rOoHlQ9u0uTncCYz9zgYS
         zUxWz5hqkycmWQ4mVfm4umf4L2p/pu67D87PXQmaxRRMjC0dQMqTYDoTQQDGBADdbErb
         vBEGkfO9bK5NSJQ4JqnkYf/0a6YPEWjQUcw8uJQeQGrQNWLeUgKvaYVubrHveWNAri8Z
         8PVJfa7F1xlzOom25192K2VZ6AJUh9e/8ZHO438HvqRHM2zQjsTaOHq3F0RynDH2tfrT
         732w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792012577; x=1792617377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mbxQS/IGQfFShnzjZAFBRrockgDU/h/fKnsW13Xq4Es=;
        b=2BfAelI0mVMrHDZbFq0IdBmjOstpQJ41f2zBLdmGGM9R3mo4l+m95+wdqqiOeNH36s
         764V+5yqYBXCsyVsBL3FSCQu6cT8OUcCiMUhP3ar8yutRM69ZJtCzNetA24iYVcOAkyA
         5q+x8xXqLAzhFWN9orpaTYMZX0MAw+K5ASUS8GzmZlfLVkiRCPwjIpgKg0sD9eIB4TB0
         D41YPOkHULYhtxRL4b7SOJ6NxG2MVQxD/vdVcPtX20lls36ISmpJMbu3Ytx1gwKKO20T
         96/Iw++HwZGQT3ALK1GjPa/Rcr/kHgO6PFSctQnaREq/p6rO4rz3sZJ+6qwAKtOmbYbk
         RLGQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3sAr+jhzy5aGjv1NDkH65hwmosaQq+JvFTKpBEkfHed2ZMluVELiYNLlDn+trpv/zo+degg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIT5arQmdvOLcw+FTFwwZiVYwNESM21a7R9GjxqUnvOysT4ot7l
	hv7LnzBXVXSD/GJ4rQvB4S0mJTk7tcGJKSwE9syQoJegkuYG+gfSsXC5
X-Gm-Gg: AYBFou1OqJcHobPogCe88NAJyx/tM7aURCAfO9XFaAXzGQrlNjmKYsi1uPSCNwJJoPO
	h5o4HXERTXGawO+mydJtfsrN2UZITQjYssJUeZ7zg1Z6XhhzLgCjiwoSk9PI0/V6AmnezXAnC83
	KvN2A6lDHJX27gyw5N3GIu0rzHNiwr5YSs0CBjaIXRti49RJeDmGDiKhCxeo5FMv80Ll1vQj1cI
	spRvyPCKqiJzj48dVjyVsybZYNyHie2E9FfLyXIGmlUW5nhPhzH740yqTk8dsoqMTQdS1gAGhk/
	sUZEmGAnJwPgrSTuXRORcofarqSkB3q9ymOI8J/7Lf94zp0ry23zmGtUkTqr4RtCmUp/GAWDgI5
	1l/WyOuylv5TFsv2JN/Dmc+jB7Jb5DUhbpPyQ6ptDRZt7APdJfUlgxiPoBSAabRx188qQ1MpHOp
	rrDbMPJkgvAocinUBFwusNds+tFHTVFk1wSAsjKJYN2Gqrp3HVKYM3K0c4L7gCfiRnI6JOKa3iC
	wDVax6W65wYhY0463BPLk3QH9+ROeW7yzyw8NVkh6IBOQ==
X-Received: by 2002:a05:6000:4683:b0:48d:df82:26ec with SMTP id ffacd0b85a97d-48ddf8227c2mr11468268f8f.11.1792012576642;
        Wed, 14 Oct 2026 14:16:16 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6ddcsm13832288f8f.52.2026.10.14.14.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:16:16 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommufd/selftest: Check dmabuf MMIO mappings filled from another domain
Date: Wed, 14 Oct 2026 23:16:07 +0200
Message-ID: <20261014211608.291608-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179200036595.15213.9864724554843977359.b4-review@b4>
References: 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 02:52:45PM -0300, Jason Gunthorpe wrote:
> > The mock page table has no memory type bits, so a mapping made with
> > IOMMU_MMIO cannot be told apart from one made with IOMMU_CACHE. Wrap the
> > mock's generic_pt map_range and unmap_range ops to record, per domain,
> > the pages mapped with IOMMU_MMIO, and add IOMMU_TEST_OP_MD_CHECK_MMIO to
> > check that a range is recorded. The check rejects ranges that wrap or
> > do not fit in unsigned long.
>
> I'm not keen on this, the special mock amd domain is just for mock
> usage, we should probably just add a mmio bit if we want to do this
> test.

Makes sense, thanks.  For v3 I have:

- AMDV1PT_FMT_MOCK_MMIO (bit 52) in amdv1.h under AMDV1_IOMMUFD_SELFTEST,
  set by amdv1pt_iommu_set_prot() for IOMMU_MMIO and kept by
  amdv1pt_attr_from_entry();

- pt_iommu_amdv1_mock_iova_is_mmio() in fmt/iommu_mock.c, a walk like
  iova_to_phys() that returns the bit, exported in GENERIC_PT_IOMMU for
  IOMMU_TEST_OP_MD_CHECK_MMIO to use.

The op wrappers and the xarray in mock_iommu_domain are gone.  Is the
extra export from iommu_mock.c OK with you, or would you rather the
selftest read the PTE some other way?

Patch 1 is unchanged; if it looks right to you, it could go in ahead of
the test.

Thanks,
  Andrea
