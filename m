Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0492D251780
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953064; cv=none; b=jqn7vA9c0ERzOj4H2ShcPiBAg17rB58afXvl45y4VBb06JL2dIwSGMR5lWEclguBR5L16ya0cth1G4aTUAu7E8tmMpxqL0rtnKMM3OIx/RBEs94SkVYTaNC6e2b67yCLfiPVYuV6XQL3oYtGcvXzGEssBmAzzP0MUGH9bBMF9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953064; c=relaxed/simple;
	bh=neW8JICaEEWUIk+9rBwbn5iIXjtiSl0sUhd8RTSSX8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEnG5OTA3XjZQyPYxKD0A9xR44bTdNlZxFaVc0Nd9v9xaFmFiRVEqOp/lh/0mjUPhfgfT7H/1OsktcZXUa4hGLgyq580cVAeJweBfNrCb0S8OI2Cx2h21xjT8LiNq/caWE+HogV6n2c2iyQlBhNgs4fWPkPJm/Vlh5kDI5KUxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCoYvwXF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCoYvwXF"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2242ac37caeso53715ad.1
        for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745953062; x=1746557862; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdXV/8C/yQUJ8I+wtd2Z/G5iaXapJqIY6nj11Km1s7M=;
        b=TCoYvwXFmxXPT+ficSgwU2vV3w7Lqfopg4u9YDmQ7zoDdcKaRfrlqZ5bZgqxf4lxTl
         +QfgV6R8uryU1lR8KpqmM2tlK14sEpxbsjKKA1kf2UnzyZQxgrJIGkg8y1vsiTrHwWiS
         uJlzKPT8PFePNRxL8Q2RSi1XhMfXuJrlrbNW8lVBoejgCdnqJ9JDSXbgiLbhbj4lg5Js
         5/Xwr9fpCMdcW+NRcvDH3oiu0elZoMNw7CwhiVly6r2vXyVwlLmtfTkybIWd/TCht4e0
         OSLCJPlPvEO1nNcnn8AsHpppIowHAIf+zlP4iCWTVgnBpOupURaMlL8rHjN5PVRaPJ9T
         iXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745953062; x=1746557862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdXV/8C/yQUJ8I+wtd2Z/G5iaXapJqIY6nj11Km1s7M=;
        b=iUmtMa0XZPmpE1xu8of5ALsWJlPrqb84SUWiX8xkmn/hWwSAScJ+GZwRMjmAIoZENX
         iy8hrgV2Ei9akutUZVtGVvpz/NGxEhfteoL7QkSvNPdhg9DW7ldG0lO3d6cQHQqWSg7Y
         1qQLbX7Z1SY9lHMGN5Npw1v3jP1LDzQgSMHHzR7wX6EEMZT9GYTstsQ1HigPXDkDUXcQ
         AD8nHXHgMabbFbO2/0xYSDKBNqkZrS4hW/M1QMebj10no8bYtc6F4M/25Y4iAUNry2FD
         em/HnoKc/EPT9m6rmZau6nKSSNLjtus3YkiZPB5Wy7roGqzznlW631vrvp6Xb0vMc0Ma
         OH2g==
X-Forwarded-Encrypted: i=1; AJvYcCUWkNJO8vj2s0SB//Pz7rhiP6mfeeOL4a5ESgX6TLSlYaWQCiidvw/Yv5L/PKPcLgHtcJogiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw17qOlF0o4QA3umk4SB6qPdhNAweWqwfyiV/VYpIPhBJqJidel
	uhgGxRoyTFkLhYBoo9C5DFLyVnU8eNBhmpF4VS+W5A9uc++FbUk86U/1I6Y0UQ==
X-Gm-Gg: ASbGnct8LaaVqlMSFo/F+u/gVxTMd78hLswTBX6ZHhUc1mm2Wry+Mi8RSrpdiwKRNVp
	AkmY23qEVmUUyuyLFQ8kspuCvBZjrkO7qFv1864JMpFJCxDS27K+FHnbCIKbjJh6eyq4f11o21v
	wEERutuQnsqGtV4XU8pIAGi4T6nw4xl9Zt6Sqz5MSYRmnJchePqurUYJxSukXSKV11RaR6SCxJ5
	BQnyszJ3E31ExRHZxHZp/rYMYtzbYc4+Bg0vUslsM/JdiFb9g10iwWOBTaU6CoLh0JGswD289qJ
	R38bsiEsQbsGv8dLvhzF2FXCXX55OSGk1ZKLmapSmAsjl4NsZlXROVK2RZBNG+0ZDiIkOwXg
X-Google-Smtp-Source: AGHT+IGgXGpqrHCfuif7QcKDzCUp9vTefuXFD3aLx4LdLjCaDTVmYgt+1uOwojrpCvF02XNkiYlVaw==
X-Received: by 2002:a17:903:248:b0:215:7ced:9d66 with SMTP id d9443c01a7336-22df3f77b8cmr333515ad.10.1745953061819;
        Tue, 29 Apr 2025 11:57:41 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097e0csm11594174a91.25.2025.04.29.11.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 11:57:41 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:57:30 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <aBEhGmoh0E865PxF@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <aA_0TV0RkVOHk7Qj@google.com>
 <aBAEuP9962XweHPc@Asurada-Nvidia>
 <aBCNkcLp6XZpjYYT@google.com>
 <aBEWFw2wq40SHjTn@google.com>
 <aBEXJFnLalIh788i@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBEXJFnLalIh788i@Asurada-Nvidia>

On Tue, Apr 29, 2025 at 11:15:00AM -0700, Nicolin Chen wrote:
> On Tue, Apr 29, 2025 at 06:10:31PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Apr 29, 2025 at 08:28:01AM +0000, Pranjal Shrivastava wrote:
> > > On Mon, Apr 28, 2025 at 03:44:08PM -0700, Nicolin Chen wrote:
> > > > On Mon, Apr 28, 2025 at 09:34:05PM +0000, Pranjal Shrivastava wrote:
> > > > > On Fri, Apr 25, 2025 at 10:58:05PM -0700, Nicolin Chen wrote:
> > > [...] 
> > > > > IIUC, one vintf can have multiple lvcmdqs and looking at the series
> > > > > it looks like the vcmdq_alloc allocates a single lvcmdq. Is the plan to
> > > > > dedicate one lvcmdq to per VM? Which means VMs can share a vintf?
> > > > 
> > > > VINTF is a vSMMU instance per SMMU. Each VINTF can have multiple
> > > > LVCMDQs. Each vCMDQ is allocated per IOMMUFD_CMD_VCMDQ_ALLOC. In
> > > > other word, VM can issue multiple IOMMUFD_CMD_VCMDQ_ALLOC calls
> > > > for each VTINF/vSMMU.
> > > > 
> > > 
> > > Ack. I'm just wondering why would a single VM want more than one vCMDQ
> > > per vSMMU?
> > > [...]
> > 
> > I guess the only thing on this patch from me was to understand why
> > would a single VM want more than one vCMDQ per vSMMU? (Just curious to
> > know :) )
> 
> It gives some perf gain since it has two portals to fill commands.

Ohh! I'm imagining concurrent invalidations / commands! Interesting!

> 
> Nicolin

Thanks!
Praan
