Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739B37BE62
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478170; cv=none; b=GG1nVvLCLy5R6BuE7pZbbGaqQhjFkFnujpw9ACu+0C/+y0mfuSagKMBzUCsSao4wW248RcUZPC24QNbZmhFkOQAKt29AMkiUj7fban8c7Z+tqVF+gMJcIj/Rvy51BunfceLVoccT7uRZhLaz5uf9p6SOqAg3/5KYBc7PkPq6ZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478170; c=relaxed/simple;
	bh=ffzvcdohYfK2Nhcc6YKxgUldy2MbL1zw2CegD7bxo5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svf6wxCDPjYvuWjqaSvgLuZ24N02wxnPtHAiC3vfo7P1KsV0X5NsXv8S4GRCgu34y9XaENn98VbhNrFbLP0YN5pD8Kr7C/C1/Sc4qvq/ImQZI095JwmCLQ9QL57vi7LaGF+U4dUMG2+b1qbUgK6JiuY/kw63WGF/Qa5vrkcrAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSdDhL4u; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSdDhL4u"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba180a022dso785ad.1
        for <iommu@lists.linux.dev>; Fri, 22 May 2026 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779478168; x=1780082968; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rXutVjEtLFCH+2KhZxwAs98V/nz+fnBuy6pdFon3Xw=;
        b=SSdDhL4ulRbaSuCGGNRevOaJtyl5DfYDH8mta1ffRNYt27VpyqQ+9IYZcbICUanyex
         wbiN0EKB+p5Qhn+YoqnUxHZE7uPLj+1Q4CVDJoSOcI0kgcMP4swcx1pcuBj4vJutb3Gg
         prGyCG7NmePzo3tuXlz6vZM85s/1qj3YaVZpUbM+P3ceHF/CEzORVHRQa0uFUfTfLyHV
         eNgA4+PTpw7QQFQ621vbAMwwYfBAYw1XKQ4Gb21Od5MeLZaI0/JODoQ7DYiRUgPl3Dga
         PKNvjX7auXlRD3bEAutOi4GMeIOFlN2dUTYfEDalhs88SqAOMsk2IpcXtOSdQgWpXVsw
         Zmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779478168; x=1780082968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rXutVjEtLFCH+2KhZxwAs98V/nz+fnBuy6pdFon3Xw=;
        b=cjfQldubEkN7XFhMlL7KTqxVvCNjq4+HzZrnBlLC/f8m3W6m0kZoDxxbYWRGX62hDK
         KsVcSuBV/xcchjL3GGS+363aUog+B5hBS9gnVCIN6lxN5JWjnjAL6YL7pIUa4+az0Al0
         py9chINZ80dypNRWPembuduB1P0SmYYxAXRjB8i3m5v3gPL4Kl6TlrPzXpm8kv0MubfR
         AN/Oo8MT+BTylCGo4NozB52iHoAahOG02rwbDLUbF5/kLURR/VDS9IviKM6M9OK9CShw
         Dhl9JgU79xvIq0p+pOUex3eY21IlGMwxq8otdSn8xWJQ71MAQkyxwOny/1azHEs2dILb
         pMYA==
X-Forwarded-Encrypted: i=1; AFNElJ92IoaM8Lxr7yXwFGnq3+/TEtvNAdfjNXe1oJaI1NKy6frB6UliFv7UoVzhO9u+JZlfL3a+8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxwlsm+iDByeysYt1oOdi4TzXHKjIs4abpBmma0j26/+C7DsxTb
	BQIR3Xsn5pYoYJora68WGHxNx9Q2q5/z0eeWLJjd0V/B7jDnkPS/YuqALau3WctqGQ==
X-Gm-Gg: Acq92OG8Wmry+nq1+3immEAI1QmC8/YZgqyh97ndI2JYSiEDa8/qEQ1c27FtqN34dRc
	fY7FXIbTM9sAyZBBkG7ihncKjiMs0WDCLG5/i74vJGTzv0htw7QgKaKUglnkLPPcAVG8T4qH3+P
	kPiDpMnyOd9J0Dj2CYCI8qElo34dvGAEsTPuU+TDHd7a5S1ti8XgEMWC39if/9C9IqYpJD70o4j
	sWarNlNL/nR1APHcHGNQzUfFkuTOUiKObks35nSkk35f6K3sRK7lVIjIAM6LGitENJCvhlrRKtX
	YVrGU8BuilX2uos5Dg7B25BJmfBluQnljgYJxCYpNo5Q0/kspXMY0viMbNbTESmnEVgTq0N+mby
	TtaQua5aElPRAQhCvx2dPLa9JZTrLJtwavNIfXgzmeQgCTpvdB43kgMmI663iKqKL86n5SbNRX7
	yNamMG83PpR30C4rhGt1Kzd8hFgkTSnBn32F/wBmlgGlOG2D7yCJOrZ+VLPC3Cibe01RE5
X-Received: by 2002:a17:903:17c4:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2bebe9eff1amr388115ad.12.1779478167409;
        Fri, 22 May 2026 12:29:27 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm2981586b3a.2.2026.05.22.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 12:29:26 -0700 (PDT)
Date: Fri, 22 May 2026 19:29:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 13/16] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <ahCujtmNUzE9XDa1@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-14-skhawaja@google.com>
 <agz5rFcl27H8yzTY@google.com>
 <ag4DzYZ4ToDcyfn3@google.com>
 <ahB957SICkiVzZBv@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahB957SICkiVzZBv@google.com>

On Fri, May 22, 2026 at 04:01:43PM +0000, Pranjal Shrivastava wrote:
> On Wed, May 20, 2026 at 07:40:05PM +0000, Samiullah Khawaja wrote:
> > On Wed, May 20, 2026 at 12:00:44AM +0000, Pranjal Shrivastava wrote:
> > > On Mon, Apr 27, 2026 at 05:56:30PM +0000, Samiullah Khawaja wrote:
> [...]
> 
> > > >  #include "double_span.h"
> > > > @@ -1421,6 +1422,7 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
> > > > 
> > > >  {
> > > >  	struct iopt_pages *pages;
> > > > +	int seals;
> > > > 
> > > >  	pages = iopt_alloc_pages(start_byte, length, writable);
> > > >  	if (IS_ERR(pages))
> > > > @@ -1428,6 +1430,11 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
> > > >  	pages->file = get_file(file);
> > > >  	pages->start = start - start_byte;
> > > >  	pages->type = IOPT_ADDRESS_FILE;
> > > > +
> > > > +	seals = memfd_get_seals(file);
> > > > +	if (seals > 0)
> > > > +		pages->seals = seals;
> > > > +
> > > 
> > > Can caching memfd seals create a TOCTOU issue?
> > > IIUC, iopt_alloc_file_pages happens at map time, However, the userspace
> > > is allowed to map a memfd and then apply the F_ADD_SEALS via fcntl()
> > > later in its setup sequence? For example a sequence like:
> > > 
> > > 1. VMM creates a memfd. It has 0 seals.
> > > 2. VMM calls IOMMU_IOAS_MAP_FILE. IOMMUFD caches pages->seals = 0.
> > > 3. VMM finishes its setup and calls:
> > >   fcntl(fd, F_ADD_SEALS, F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL).
> > > 
> > > 4.VMM initiates Live Update.
> > > 5.check_iopt_pages_preserved looks at the cached pages->seals
> > >  (which is still 0), sees the seals are missing, & kills the LiveUpdate
> > >  with -EINVAL, even though the file is properly sealed..
> > 
> > This is true and it is intentionally this way to make sure that the seal
> > is applied during mapping otherwise user can apply the seal after
> > resizing the memfd and preserve IOMMU mappings that are pointing to
> > unpreserved pages. Consider following:
> > 
> > 1. VMM creates a memfd and seals is zero.
> > 2. VMM maps memfd into ioas/hwpt.
> > 3. VMM resizes the memfd.
> > 4. VMM seals memfd
> > 5. VMM preserves the memfd (it only preseves the current size).
> > 6. VMM preserves iommufd and it succeeds as memfd is sealed.
> > 
> > But the pages being referred by the iommu mappings are refcounted in
> > current kernel, but not preserved.
> > 
> > Check the comment in check_iopt_pages_preserved() also. I will add a
> > comment here also.
> > > 
> 
> I understand the intent to enforce a policy to Seal-at-Map to ensure
> consistency. I am wondering if this policy is a little too restrictive. 
> Should we consider performing a dynamic i_size check during preservation
> instead? I can't think of a good use-case as of now.. (maybe let it be?)

On another thought, I guess we should go ahead with the current policy,
to ensure we preserve the right pages. If an unsealed file is shrunk and
then grown back to its original size before preservation we might have a
problem. We can ignore this comment.

Thanks,
Praan
