Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714431B83B
	for <iommu@lists.linux.dev>; Sat,  8 Aug 2026 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156282; cv=none; b=cpk3+9pZMwKGnsD/X4Ge+v5bqQUaW6XtqopX7ZBBcmNUC61lcBMdRWjZ0gbZYYcDX+csIXhbcQ5dc9boCkyl1YQCVbrKiZ+XR44skwpx5PC+AVPmqnRD2vxnPA44fOBSpZ8E912pPRk9m0q26rDGavKAU3tUdvzflmTPhOJg1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156282; c=relaxed/simple;
	bh=yy9KYO3WfAu42aqR4kwhL9S1z10fN8BxMXNkSzlVq0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoZafdZiIGPQAhBvvHTmvM7XnueTnKDA5LGu+skcDagEwBujwQ7BW7CK45DdBcP5aqoJRt1yC/dsMVnfpTgrVvYhhcKtlrlVMpGEwXs7vix1fBH0vBtooPCGOgkta4KH00jILmWt2m16voaVHSk+P823LmgQHNYR67NT3DfwM6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iH/gLPJk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iH/gLPJk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab97c86bdso28065ad.1
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156280; x=1786761080; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c7tczrAN0Z+XQOnKNy/6C+IzTrIYOyRvANTeANoTkDc=;
        b=iH/gLPJke+bSX/aMVO0UyNekeUt/EyJCgktqBr7ZQ5nonG3XG/LJR6rojdMR4oEZAC
         JzS7zcEta/XG4NEmI5sY4RQJw7giJCW+KMvNBpdyIi6GbDdCxXlRSaK+K+fKJ0ZuNWTH
         RO/1kVVzviCDZrpewmi/AmD/rLgZiWe61qNyAivMG6sqpFaS1kXim6yEkF1GkoujPVi4
         GOsr4mTaNCepgD4XBzSIuMc3zi6m+WnydmMOEpNPuDBgN9IRgnSRPwuCwc221KA/pSfg
         s3hJDe+kLw4SbFf8UYlhAlMI0zsdawFboN/VXPzeZess0b/ngU7uK3sb3bVAt99byjVM
         Zotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156280; x=1786761080;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7tczrAN0Z+XQOnKNy/6C+IzTrIYOyRvANTeANoTkDc=;
        b=sHRHFAIDR5xV+p22dUJvfZ4tOhIEFGabFiC3Vy+UBybz4IMb+4bzoL5FsSE7GLsh52
         s5xB1xMxY6qVDQTBM296WDUW2sn0abCFSWXLqq30t8psB/5XxxT471nddJ0tdwGsAhq6
         oBCO+MvZkCtqDSZdntODZlI95Rn+agglC0F1v4t2XCS/L4HQv7E3mcF7yfZPGwl9s9Wh
         BrCFdD808ZekTADqCHNnsbzaY+vI2Oq1Mymnf43JLQ1eXbi0TIJE3bmuRAXqM6E1IIKH
         iXsHXlQ4L1TMUtHEOte9dWeOu5fORsA/2lY32ixnDwq7Ahzg8+DlFdBcy6EOvvRyHMFj
         p4Ag==
X-Forwarded-Encrypted: i=1; AHgh+RqQRRiPCtoPD00mP9+sb4AJYt1EUci3Bjqot7M3qbQwsaTxHHz6tq5BxTYchhT09FBZWlI+QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YztrecwFGHNKyjx0/GVLXRoMj4qy0bPe0upzJuglzMkVkMpLEA8
	GzJ907fYxJ9TVLNdJegkiZ/usQbvTjKa4Lbhm1ebEEkaC/06MaQdMzISOiT2emJgIA==
X-Gm-Gg: AR+sD11LlMhvLalKqCWdh/frfKEkoy/FhXKvvo3tcRXR8CMQNRMD9/jJpmcrDr5aEx9
	hGgcq45houW6KIokwHih11AotOlG1T/vTCNspAKfCKb3zYynJLbtsTH2xJaNAeinMNRHR8UoNKM
	sTO+8MCQRptYkRjHqSfIT06sbjiygccDew5yTv/uDpzh937GkhgagX7Lh0hFGFtSZQuXNro38ZS
	4bU2bB4nhSsJXHuqUWpvQ/+QY6is6ViANKlKmv786psv1nADoBjEdKEOgY6ghkw1Aw9i/bAx3DF
	bCFouUvBFuPmJCNTvYBnHNMxJobA5jUjAi0xLpT0BpeTfXGahMhveG8FQ/MpCvWrehej939F1W8
	nKCyB2EpLyV3LoK2DkiNbkeIBSEkzISsxwGCto9SROkvAcuE0/dcTEMRstXiiyhaeG3CIkTLZZW
	xeyENrozL4xv7WoMsltZ+QwNJ/AtIFryl+xJBxFMkf/PzKoegmxlEzECoWY6vUgYRDSBMwVySnG
	Tyt3EIR/y10vu4CX5g+Czbawb4wj4Jzi4oTss/gn7Z7vfuFv1qIy1jsm5Y=
X-Received: by 2002:a17:902:c994:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2d2b30c1498mr2941465ad.2.1786156279321;
        Fri, 07 Aug 2026 19:31:19 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b30d465csm2252994a91.2.2026.08.07.19.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 19:31:18 -0700 (PDT)
Date: Sat, 8 Aug 2026 02:31:14 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 02/18] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <anaUhv1pcnMoTEip@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-3-skhawaja@google.com>
 <fjma5ub62ia4pbcvs4yek52r6jlhut4fidutow3g5uhf6iel3o@iqx3a6bm4q2e>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fjma5ub62ia4pbcvs4yek52r6jlhut4fidutow3g5uhf6iel3o@iqx3a6bm4q2e>

On Fri, Jul 31, 2026 at 05:58:20AM +0000, Ankit Soni wrote:
>On Sun, Jun 14, 2026 at 11:37:12PM +0000, Samiullah Khawaja wrote:
>> Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
>> alloc/free helper functions to allocate memory for the IOMMU Live update
>> FLB object and the serialization structs for device, domain and iommu.
>>
>> During retrieve, walk through the preserved obj array headers and
>> restore each folio. Also recreate the FLB obj.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  MAINTAINERS                      |   9 ++
>>  drivers/iommu/Kconfig            |  12 ++
>>  drivers/iommu/Makefile           |   1 +
>>  drivers/iommu/liveupdate.c       | 212 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  18 +++
>>  include/linux/kho/abi/iommu.h    | 207 ++++++++++++++++++++++++++++++
>>  6 files changed, 459 insertions(+)
>>  create mode 100644 drivers/iommu/liveupdate.c
>>  create mode 100644 include/linux/iommu-liveupdate.h
>>  create mode 100644 include/linux/kho/abi/iommu.h
>>
>
>../..
>

[snip]

>
>Hi,
>
>nit, The v3 changelog has "Replace bitfields with u32 flags", but sign_extend:1
>looks like it was missed. this is 37 bytes, the only arrayed record in this
>header that isn't a multiple of 8 (iommu_device_ser is 56, iommu_hw_ser 112).
>The arrays are strided with pointer arithmetic, so the skew accumulates: from
>objects[1] onwards none of the u64s are naturally aligned.
>
>Looks like a leftover from the bitfield cleanup.

Yes, missed this one in v3. Just sent out v4, it should be cleaned up now.

Thanks,
Sami
>
>-Ankit
>

