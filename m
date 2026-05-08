Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8443E5EFA
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248849; cv=none; b=StcFTyxk2kqjHgcK3QeVy+eRfhcM/NQ826ii/fEmt15ZEE/L4r8DruShd5WXiQWUSBLaMxSaCRPiZkG5R0GBBc+Bx2+JkBRrS9VFhajaXiI5aq06e4y1gUrpWkgLA3zfaxV8yk7vN9LP51j+ccATEAuZZk9VXBFBz2agWuLAPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248849; c=relaxed/simple;
	bh=iqJu+r0ruvrFT+na7AA+zYV2nNkMq2VB8UiCghLRSWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwqambwkkKtd/SpIdie8BgTykbHR1Y1E8EI1RZxMpf7S/583pVhIs6L/XTwIif00Sf0QR2UCEAEGDYmKn9oZJPgE2FSfhTDe4B6m8p4Zn5GhsJ4qvbaEZrxP48Ov1pIyJN8VEU5upIvlMvKaX1swFsawaNznBfCBoqOBSJQQxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUl3dC0N; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUl3dC0N"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba180a022dso87985ad.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778248847; x=1778853647; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg6wbnYU6IxqikudtR5uG+CUKtmNxQwde8y0MusXhEI=;
        b=NUl3dC0NrzXhCqMYOWMpQ20XXKhigrOKtBAJHhoulN8jOLrwh+PDaUYHbytV0y1356
         WF5/DtZ8dV4cAqZaDOqdldqkJ7XqbWBt2GBwHc45TIwsEr4XPriAJj94yJJYSr2CJDpI
         68nk2Ax++fzTMtT6/SFhHPIS9LBCUP9VkdRVmCiBidDKXNYRRP0uGCzdorvOUXC9dXsU
         uPXURY6G2xXdvOSSxDB9CMbIgniDQ2BpmmQLyAE2lCK3wFesVgGTfj1pV3UDSIMsr0WU
         29mUh9TFDw1i6t+F5aF38HO/FUV+yyMe57cbXhC/rZd026uDF86n+dAvLOsiLwyEh/uV
         V99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778248847; x=1778853647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rg6wbnYU6IxqikudtR5uG+CUKtmNxQwde8y0MusXhEI=;
        b=fdePSVCCXzDj9DrCP7f7+opKF//D2TrHfrjdaUvvl4VaudLqk+5fEzH51BxKIJSG4v
         aRizKph5D5GTyKXr88hoFuEKKo4yeREySTlZBN5g/dVy1/95MzQo1d4ztTORzR3hLbfl
         +gj0hHPGoDFnpkF8kR+gvYJH9xrhpgdNfCK/TPchumPvD7UnK5f/u+5xPCjz21vWgigl
         X1O/wDfA/efnCyGbad1KLYjGSD4pfuZT/DIwqUgwX33qy4hVTB8wphkUOTWyIlmsfoY1
         +9g+GLPt904Jp7soXuaUZcVY6Ruzm5+e6IOuCI4p4fHT3DDx4dgMeID1HvX5jpj2p5AP
         +W6g==
X-Gm-Message-State: AOJu0YyjhBgjJyrAyu7bmFlBuQaTgl2Gn7QyUKsQLOxiyaMkYfdiFYit
	ToyADhjXyLKxCudO9gA1TmyCdHwMOhF2XmoqlW0Y9J9eGyL92HPhvoknKrAfpjyhOw==
X-Gm-Gg: Acq92OH9lgO6O3cvyCdKnbhvjGrfVTUcCJotQV0H4GCeAKOXRb5bKmzv4i2Ky/MDCla
	FScpvnFelpC66XM3lWMr/ExhEw8VEyMLDpuT/j4kOcejL5jys04PdhxBkp6kogIcUSY+HVtTI5H
	vGeogWa+YP6I+e9kYiODPB0w5cYiL21Av0tpNPqTWdMZziXdUxyzK6yaoEcgcACHkUSGFjMBYDR
	OTPWbXON0r5ne2zmfQS+a+sS8FFOB+hK1hsPcM6rKpKnhIMQ9mdKPNOzUmzI0A7KQ53abNbZbzF
	p2zTA2YBsGazU1htQf5q1R07W7PB0TxjHUW4dXTQXbnnSTtKD17ncGCzbefEDtJJBh7TRAMXamt
	4f0zFkP43cqq+dKoeEQZfNnKm01AUow5xL/eUAHwnOnHA6C5iSuOSxq4TZ3HVy5i7Kqsvm+3dO8
	eowpIT1wmieukyQMwzMPa+drQTQfuDbj+rOFS4jHh1WpWkkKFviHvQlpy3vWOoUNXOqhC2
X-Received: by 2002:a17:902:fc87:b0:2b0:5c88:51e1 with SMTP id d9443c01a7336-2bae9e67750mr3727515ad.14.1778248845874;
        Fri, 08 May 2026 07:00:45 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d405adsm24217865ad.28.2026.05.08.07.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:00:45 -0700 (PDT)
Date: Fri, 8 May 2026 14:00:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 9/9] iommu/arm-smmu-v3: Directly encode TLBI commands
Message-ID: <af3shx9ETdSzwPhq@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <9-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>

On Fri, May 01, 2026 at 11:29:18AM -0300, Jason Gunthorpe wrote:
> TLBI is more complicated than all the other commands because the
> invalidation loop builds a template command from the struct
> arm_smmu_inv which is then expanded into many TLBI commands for the
> invalidation.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
