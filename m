Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B441A683C
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941005; cv=none; b=Q0wv4S5kPKBq6yAgfOdZ05BekZGKMgk9u9obwTmUJsXoHN9epiDmusQSFeppMmw29KUzMIEKSKfCv0OQ+wofFJuqiyLBhMFnVXoX+PYoNMGM73ECG+AqhH7KayhhRCASwSINjoNiOOlfZ9f9QqK/xviyhKtm36Rx77kVRLitAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941005; c=relaxed/simple;
	bh=mJ2Sv+3oMbNngKzUZrpFVSbPEqlLqAid/lINt850Zv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al3/1elir1MhybUAkxSWU1zNWbucIfc2Q5lHU0z6HWQuMyx4oJ8EXtM52utu4IMA9M/RvJ/N5zuoTNGBpAJq2MWDLz5UVkSQifWLp/U2P+KRIB96OjtuVR1m4LeIJ+gboz8/WxsFUU00uWKAYgavtKrShRpEwh/6bR/j6lB+hCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXHiWjCv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXHiWjCv"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso23475ad.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777941004; x=1778545804; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ2Sv+3oMbNngKzUZrpFVSbPEqlLqAid/lINt850Zv4=;
        b=PXHiWjCvUUwqj672Gv9lOaSgwGgzUE250lVvPWCRVMVWlXW2VR/2FWagX/j6uUj73F
         7zvChiZ7V5+I8DjkOrmzNlKFQNx4S6ab0PJle/GXpDzi3uDSUYwL4NFOfqPtmkjY4V1z
         xLo1Xo860yFDDSB/tjS3WQhzIKHqc7AmhsfRVkGy4ZcLL7IZ8nd1VDXb+eY0cmfUjPA2
         HWO/THutyf7PlLeloKUeOr2vvBg1TIDAt35SZA1TfNMaZEKtnHHV1ZYywe8yEA7+d4D8
         FVYMguVfS6aL+TPqjkrdljumOqn60QNUqHorikhhgJQZvUFShs+WMDDgX0oqBqF0ufJT
         tf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777941004; x=1778545804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ2Sv+3oMbNngKzUZrpFVSbPEqlLqAid/lINt850Zv4=;
        b=rASD9Cj2AagnQSfaK2nkHUErX274DTjqpxZVYuNoJjHbJQnTRJthUxxrxkb19Bn0JO
         jzPR8eQQe6t3g6dm+EjiLciBJm/OBvnkqEPgmUAF4Mn+YyYN1ni50T9uCrq1oCLvvvYy
         GVIsbVuO5Sez4w/M//qfeH+5J6D8RxFdsCx4VRFHxD/Bh/tCH81fLR++NhTH81dniDIB
         0NM+1gYulpAESGWnObPVmzKujyQN9H7w6i2qt18A1lrKx5gKP75Jf62rrG/NWYZCfMvK
         ark1lZf7clecjRb5JbI98C7W+PvsrkBScuB5voj5pb075P2IihbJWBHS5Z+n1jT7k+dD
         J43w==
X-Forwarded-Encrypted: i=1; AFNElJ8EyMICq4sYUWkJIIRyw/0p3ZgeHbUODltepmZqnq06ypJ0eQTPR0qPoH7qVy+vWq1BoWJ4DQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQezkGJyixKcDIM5R5gDWw2O5tjF95SyT5/dbB6fr+MqMOH4fT
	7+HGVqXpJlcBUVHc2qvoZTU6x8YD0FfWMH7PmEDbf7InCjJHs4h5a1e0ASqEN63UXw==
X-Gm-Gg: AeBDiev76PCPYKgItTMgDhV4zWzQgvb5tMTHBxzaMT2PgjTe+FZzfwTCBZ8/hH8z+01
	l2/fpPtulHINY70lm7r6xLDlP8oX+Q6WO89d50K1EjbNisji+PD/LFrq2gmS4MisBfEns2c3vE1
	jaruRUHMe8HoEy4LRIBp5SP7l1wV77CeQlsPe1r5gty2slZ5Y68imm8n6wBnrfA8CdQN39Z5mc+
	q0Pd7vCH7m1bNfeVp9TBaVEAE2q0SKcl+p3Mvfu9RSKGHSVjsSG1cvA7LC9AjW497AxuN+YHu9J
	xAs7gba/64mEhSMVEOdIDG1B5qbB6bPH88ag+N9u4/ULMjt0FIig4rCFiw7Jt2o22Z25G01GJeS
	V5ItAELblGh/tHRSC0ctC/WtzixBnEK/jOHA86iv9hWYDjPMdF+3jvQi8DjslcMkxku+xNQN53U
	7Zsj5dGnvjR3JE2TtY3nqEBkduz1+hg7Su3tbDfDx4Z0z45Hb7H6+UTgDDfKU4ePbBlC041pRM7
	RB8t2vjXFPTVHFIQexuwA==
X-Received: by 2002:a17:903:46c5:b0:2b7:b03d:9dce with SMTP id d9443c01a7336-2ba4f9cf2d3mr1830885ad.18.1777941003113;
        Mon, 04 May 2026 17:30:03 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae110acsm107750285ad.42.2026.05.04.17.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:30:02 -0700 (PDT)
Date: Tue, 5 May 2026 00:29:58 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/4] dma-mapping: Add preservation of direct
 allocations
Message-ID: <afk5m8xwYqNstzPw@google.com>
References: <20260505002320.2210067-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260505002320.2210067-1-skhawaja@google.com>

On Tue, May 05, 2026 at 12:23:16AM +0000, Samiullah Khawaja wrote:
>This is an RFC to discuss the preservation of DMA allocations for
>devices that are using direct allocation mode. Note preservation here
>means preservation of physical memory only using KHO. IOVAs and IOMMU
>mappings are out of scope.
>

Sorry, please ignore this separate cover letter email. It was sent by
mistake and has wrong prerequisite-patch-id.
