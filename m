Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BAC261568
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838823; cv=none; b=j96ZzKRXe0DtDYnH87K8fJVs4jxmTWuJgOMfkCn9f6/uqQBnAE9mJXgDtbvg3ugHgsI/8RdkeksjQvUaNLpRQZJybfCW4DKIcL8qe8BFkWdRAD0gEcPBxqlvqxLTT8vmwnLvzTW4XylyAdlx5Lx4Czhdqyx/MErw2ZdW3mjY4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838823; c=relaxed/simple;
	bh=rYO7T94qEphbwkaPUxAbh4JbBhDv8Eqs279vpbuniNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLmFHkxoQCcwiSFFFusKXc68WJMhPtrIS/O5KBbKLLF7WfMcfUHuZPDWpNJhtcMFrg9R3PiTT3I+ZX2NDdoOdWOtqJratE8I3O2SJlYVJicmvfRbUGWdnnTCQ8gU5fFa4mt/mNErLKxopJUX1yHlmzdOuzxS7mo9QdFbmXW5778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dBiOcH3W; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dBiOcH3W"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2263428c8baso17755ad.1
        for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742838821; x=1743443621; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3L+o1oFt/rQYeokPKzoxEmUBtOHbHrbdjAOX68Z/8I0=;
        b=dBiOcH3W9CMwuH0oN1zex+bLl2G1wSgdewqoT/3GEza/PZxImrHpuJS6bME/XjArCc
         NGaem6+L/0N1hg4423cCvi3FdExIybAPQrsNtPgxY0TdnsiSsF+jtD9mSWrGZywCmwRO
         /Hsc2VI0c6kD48DdVJG+8R0NtuNkPsnAQ0wXwZQeirqIguQGMq+idssqXs37KT8aQSwB
         rd69sDtwOjHilXiPBZM+0SMTcaHWO7UFUOA3AU7BB3jGzFaeVIx80+CxcL0FQbOTZX4J
         hbYMpoG8pMP+C/7oAQR47lTBY+ZA+gjqvICpz6QxbGRQUKZKQOkRj9U48SiQUfLL4rZK
         tJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838821; x=1743443621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3L+o1oFt/rQYeokPKzoxEmUBtOHbHrbdjAOX68Z/8I0=;
        b=oTh/8MpnhMCxMQ8xFf9c6Rkh3bUTJHpeZZJrEPWFuN4Z8xEi7SAcakiabGI95Mqbbf
         x6h0idPD3f6ZcetRWN4Blv2qTrYdCjTGuzocigLwLSAlxTz+NJ3Zh/OeVAx2169Lnbfd
         97A09sjOPeebDkng4cwIXafL12/WnYLbuwDQh7AgPiB/La4SxgmdCX1NOs6At8FImip7
         332FoevdoeLaR2Z2KCXaKTQc7pyRSQseg8Wx5e8Pqi8GZ55MobeHR6aw1vGFnerEE1Kd
         yvv9aT0OFPTzLCTLpPhBSBA6x1l0CKUfwPd0hl9CV8Tr/HLq1vagU6dLIa0MKgRRViTC
         KpJg==
X-Forwarded-Encrypted: i=1; AJvYcCU8CiGade8IZB6BE2ey8Svt4jOSijCgmLCzATwB+nR137R6f3iqCqlNmosNY6KCd55RWvUB1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyavVOfnePuiIUalzK0QGUjX81sJEfDGcNQpbrosfTJKnt2Gmpv
	jLtMg2ULFAXwqyo7tUD9oD2tKbf2ml4h/L6qI2yr2b5TXlv5On5/IBx2TCb0rg==
X-Gm-Gg: ASbGncskYjyZj1a85u9IBmIKvw6DxLz6SwnkttNbFc2jZUIPD5EFq91D37diBgsYy1/
	NRcqt2I20m6fHtLzwGgVxIEprbNWxPqCN4ZuaTgyyW90cCAG42OYHNPEqHfWlLUcbSNcT29+hkO
	d89ZIXV3ObsM+0oACwPmAlrF7iPDajfkJU1uVaG5qTh88RLDLryRyS1jUeWMCRB0bEpmVSl+77e
	yzk7EPw+mfPRojdw9m1HK8XJg/B/s/fHPlQd2+uNW1XEvNznQw6d/RJN8qZOk+YIXVs0ZPH9exZ
	SwE4/Q50BltYPH4MoLc5DQSZie3cYxbsdibHxPyToQHVyl8n5OxOgjkfm9LnxsQLKe6utAwgzA3
	KTSU=
X-Google-Smtp-Source: AGHT+IFDNCqV6vIgiZiZwNZrLeef0QqhEE6KqNlSnAh+UBAAxruQfkNvPeHPVJykjcXZxKDGyB7VIg==
X-Received: by 2002:a17:903:2408:b0:21d:dd8f:6e01 with SMTP id d9443c01a7336-22799f0e40bmr5614835ad.5.1742838820740;
        Mon, 24 Mar 2025 10:53:40 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f4523sm74192845ad.207.2025.03.24.10.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:53:40 -0700 (PDT)
Date: Mon, 24 Mar 2025 17:53:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z-GcHNeDSX4Ttdae@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
 <Z9yWnBmOfeG-7rno@google.com>
 <20250320230551.GL126678@ziepe.ca>
 <Z917OSsvHBIZfar8@google.com>
 <20250321153034.GN126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321153034.GN126678@ziepe.ca>

On Fri, Mar 21, 2025 at 12:30:34PM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 21, 2025 at 02:44:09PM +0000, Pranjal Shrivastava wrote:
> 
> > However, still there's a worry about the reset value of GBPA.Abort as
> > pointed out by Robin earlier. Since the reset value of GBPA.Abort is 
> > implementation defined.. there's a chance that after a power cycle the
> > SMMU wakes up with GBPA configured to bypass.. in such a case, I don't
> > think the kernel should be responsible to ensure security..
> 
> The kernel should be responsible to operate that HW in a secure
> way. If the spec doesn't guarentee security then you will need a
> ACPI/DT flag to indicate if specific implementations are secure or
> not (ie if the implementation preserves GBPA.Abort).
> 
> Otherwise we'd have to architect around the insecurity somehow and
> prevent the SMMU from unpowering if there is any security sensitive
> attachment..

I see.. and what shall we do based on that ACPI/DT flag? 
Disable pm-runtime for security reasons? That way, the implementations
would get to chose if they *deliberately* want to enable runtime pm
despite the security issues. It can also act as an additional switch for
the pm feature.

> 
> Jason

Thanks,
Praan
