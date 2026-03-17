Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD7221264
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781403; cv=none; b=b1MhrBcR0eEqaRt20Zjj4mUb6PRn89P+LPHw848T5+wx1PDjyYnVOzIkVruoCfVMPwErA2X1u7PofzbO514ri32vTJvsHTCJKlzXTdz00RaQkbf29GMVaaIfJ8geunCMGRlKAQpY8x6B1FAcptEFj6I8/9yzqyamYrzJzQs243o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781403; c=relaxed/simple;
	bh=X6DzbCuOaFwTTskyaHV4XXzuegXjEYxk2EYaNcAZZuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0tt6jRbPSaB575qj9oo9GwBBelEv2r2L0D7jRIKm7s3JEh7EZzjavaBI0Zs+NxzM/yApkHP2TmEmQvBpGTuxgpRYK2Rj5gO0IEhsYJx4oTRdFzsZ5rWLcG1ghC70dIrkdcsxIyiP4vc41/hVbaWiefdiAfbP3dSvaEBW2efz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9AaIebO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9AaIebO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so27125ad.0
        for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773781402; x=1774386202; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsZAeIDJS5lxqfyPMoioJYSBuFBQGFp/OuiwRZmjHkE=;
        b=G9AaIebOlU2Y1fTuM13BYXE57Ypen2DyM69Yk6CDjgA1z0w6EiUAkrbNt5orgQxSF7
         FLQagtNFnBQkkMnukRbRE0/CStoqhOzbWpIYq3Xc+UVsvuZm8R3lNUAx44SzWLHXU8pr
         xbO9B4qj7AXLZZnIyTEa3qOu0I/yf0w3BmrOKLxvAbGT4Ws2bObvb8tZ0rR/XUTjiLjK
         6hiYR1/08iIPdk1vHcz+LYXzvDW77yue9GDQeUsSu4zYP83/Hru7W8CTNEcAgHoYk0QD
         mcYmbPUo5hGayg+MkaPejabbP4OKZrL/g/xYZDeTcK6uBaNjmTj/5CDjJdLOjndzYaaY
         uGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773781402; x=1774386202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsZAeIDJS5lxqfyPMoioJYSBuFBQGFp/OuiwRZmjHkE=;
        b=CFVTDXj/kVpA54DkwvdBSKP4AJl7UyFBjn6frSvvCN7MRdN+2AKLf0nbK6hmmOb/sw
         H3Zxpkbd2sTQW44hCnFA4VzRGx5pn7mFNcUp9JmByE14n0Txz1hplP4u+KxcT8Qw1Pqg
         bPtZ12hRRZIoJx+/wqf8os2D8iR2z023+fpUIucm+fElTmKWWYC1FymdtMLNZyGqzZ72
         DE2VRQarBvVtefkt8kyFoHxG+dvlJ0Yb492hPEoh3sHEKqWZXbBqt7B85Y5C80QzhiRl
         AkPTo3DFeC88S81JPTWwEiN9BTxdbDVaCkXWiZkbvqRmnpKxjCvh7m2tSEhwKb6zseBf
         /0WA==
X-Forwarded-Encrypted: i=1; AJvYcCXu5e5kRU+BO4PnlPzkPLmRnrMZxG4zdHM+W2Ljadf5L1LAemTm7HWO3IWkta69qOIhhqUanA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6GQqSOSrX0iXk+ojFkfEz1UUJ6rbDtwPMaKiMY85ERWzHcU0n
	UQVzOkWzuR9/9FuIhgvish9z2Tyy+7QJ5qFnZan8vDI08c/FEdV0XYnoc1nLSy8b3w==
X-Gm-Gg: ATEYQzzFYOaF+qBC2AcVralgku3biddWw6EcooD7wAJVwMfa5GtWom0t6nDvBubdkdH
	iYiRULFSoDtZdiHr8DlVYvQuel20/hZehSjeOsF5DiVTdQVRRMnIlFxpIdKY0i5d8QrBnHjhdjF
	CZ9ePwED2IC++HDeil69Oyl+tgNBKbVOjeGOszgRrAsuPCQI1pwo9B2Sa2+3w77XBSVKuydCUzG
	EhDCe4W5znziilO2R9Fh9UiDEAgk6NErbRiAGFpcYocM2doesleAc9fO9XaDKvJiEMME4NOjR0E
	Bo7YfhrHat2ADk1it+h6o5VY6f9jrfXnWAka93aAaSO5dd9XLhhfImcqMVBkzueWzJ+6ptQ6Rej
	n3oVqypPnxFFUQF672gVgPCVz0gyS1JFSYgUrSqCK1bi1T8/1jAf0Ln+dGXDuMB1thMwMFIWTcO
	G5Slncbj2tYq5n4Bgz4nTEtJ+Rolx79YyeO55BtmBIogC+aHe6lsVNCRQMEw==
X-Received: by 2002:a17:902:e947:b0:2b0:5cc5:9405 with SMTP id d9443c01a7336-2b06f7ba317mr353015ad.1.1773781401248;
        Tue, 17 Mar 2026 14:03:21 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bba04c12asm145181a91.1.2026.03.17.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:03:20 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:03:16 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <20260317210209.GC2582517.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <abNH7LAj9thuGOoG@google.com>
 <abROLLfSUK8pXM5J@google.com>
 <abm09vCaAMtiQPVs@google.com>
 <abm1esL1dzN7NTC7@google.com>
 <abm4ShqPTxIujDlt@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abm4ShqPTxIujDlt@google.com>

On Tue, Mar 17, 2026 at 08:23:38PM +0000, Pranjal Shrivastava wrote:
> On Tue, Mar 17, 2026 at 08:13:47PM +0000, Samiullah Khawaja wrote:
> > On Tue, Mar 17, 2026 at 08:09:26PM +0000, Pranjal Shrivastava wrote:
> > > On Fri, Mar 13, 2026 at 06:42:05PM +0000, Samiullah Khawaja wrote:
> > > > On Thu, Mar 12, 2026 at 11:10:36PM +0000, Pranjal Shrivastava wrote:
> > > > > On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
> > > > > > +EXPORT_SYMBOL(iommu_get_preserved_data);
> > > > > > +
> > > 
> > > Also, I don't see these helpers being used anywhere in this series yet?
> > > Should we add them with the phase-2 series? When we actually "Restore"
> > > the domain?
> > 
> > Phase 1 does restore the iommu and domains during boot. But the
> > iommufd/hwpt state is not restored or re-associated with the restored
> > domains.
> > 
> > These helpers are used to fetch the preserved state during boot.
> > 
> > Thanks,
> > Sami
> 
> I see these are used in PATCH 8, should we introduce these helpers in
> PATCH 8 where we actually use them? As we introduce iommu_restore_domain
> in PATCH 8?
> 
> Thanks,
> Praan
> 

Please trim your responses.
