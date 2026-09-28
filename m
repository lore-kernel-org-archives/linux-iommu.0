Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DAF4BA1DB
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597318; cv=none; b=D3aNgTCTasloEqpkeiHwlzmEKgW6E0paYB36MCu2VnYD4F47Mwa4cixoEEMMTJb4vi/BnhmFUHDu+DsPOGiNji7qwayHDOWkrowStrM09JDVXoEmA6Udyn6RMRS7iqyjCGzq8eCV/1UXNnx5j42h+9CHyU/EaL2rvRmftcMCc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597318; c=relaxed/simple;
	bh=f7jp6Rd5cNtolWOd25Ynwaem1dHWSPU3ugzQvbAy/B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkfYZfVKY5vBltj+x+kFmDlsuQNGl56RnHnhcLIFE/SzqVYArRrnLzPZe2mxa4eyismxhq+r3jCqFCgsd8vYDnnE5m3fqvFCT1dV9pbqzSIbpq6/Gad2ReTjrpnSF3AiCDcRLvNulXWDg3HzeiJSz5z9vPi1YwfQf0XuXttEKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NLXdrHFe; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NLXdrHFe"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-81ad35a4608so999696a34.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790597315; x=1791202115; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XwKmdtQOuxKsyeiO9lNp8K96cGh02KL4kBovEXTexcM=;
        b=NLXdrHFe0xTMPwC6rKLEojBgQgk6Prc5tEh6W5Be+X4KFQRYNtDkYLjAvz4j3sKLA8
         u9mOVk8SF+Tppsfd+qDyVr/yWuyRt7H3ad0T6ws2mAGO+dRwAWDpg8lKOWoDniUQQihp
         Ryiyui1MuGDOlnGALNQph75Ap2uhBH5ITrZsdu1mtEVjssmYrp1JtNsZTQUSf7Gy0DgH
         wJPWG4gdWzzhfRwndddkYGGQziLhR6zK4Kv1EFSo0PZ2vhbkbP//s0TFXKQvVFaw7QWk
         Tj3A9Anifb+saRuY4okERByfMa06zezbkYvGcRM1bKLPuzo6kzOPLgIgQnuPZaxWjv/t
         QNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597315; x=1791202115;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XwKmdtQOuxKsyeiO9lNp8K96cGh02KL4kBovEXTexcM=;
        b=dkOWObaCE6PUgSayAOHovIsgL/afzz2nuMxo7QUS9tkuxcKL4ZwZDLxoHkjTzh6uYk
         r5u2dcyY0Rsc5SGqKS7/XdLAlqx1uh+DAabSsz6zBeYq6Rn6FkE1oBNJIQq7MCMRfvDI
         MYTH4BFfqo9W2Lj2iYZR8DOg95oI/BZk4PUdmey5tzXudxl3nibfbADAnupOjJBlq5t+
         d26Se9vx9HWHED0XR2QDx905AG72SLlOT1exfgy9X88k7rgHcjiNAdUHNRmj2ODfZWuV
         kJVzsV2XY5b+IeZThmn8vkI5VpL3qxvoSKDaea7ecnlRmnP78sU/bV3rkkJaaaEDynmy
         xohg==
X-Forwarded-Encrypted: i=1; AKwUvBx1bOzdK5iagQPxCccwpvg95jC32XAXeuPH9saOmCZ1IAkoC2/AGFJ1fnSP9YayjSiIGBs3DA==@lists.linux.dev
X-Gm-Message-State: AFuF++nqQmu4vrPoVBGhmbc3K6TBQ7G27Bt0pFB4ab8NDwdYp28Y2Alq
	fq8pzUDS5Qi0slqeRlFQLGYHeiy4L3UflpLZOPon3y6U8Rk2DBbA9MX7E2JzgVmlGm0=
X-Gm-Gg: AYBFou1w+4U6MnxIN9FeOxQPFMxj6qw6JW79b57gvbMBAqppJ8m7XjpbHvpNz6rbJ20
	WjvZ8i7RXYs4T8/u22ikXrzrhokBieMX50twvjWIWkZ8uwyXF3HItCrL2M7RwQztUWu2PAwMG5v
	WEAT10urLTp4kUEANMJw6dG2Bqk+7XCARKT284v/8DxVwQCr7rCoGcklrtjR5fuMRI4iytZbsuH
	K4/1vvgcUt+5k7aDZjDrpEMJelN59+QXjUkJI49IlJu23NnAgEYt3IjmhK+tb7KfDtklIxFFQ9Y
	f6EJyeJXg8C3iRf8N7s+M6zrlmIGSQQ6OWH3bNfG/9TCHJwY4WD/IMzgzTKcO2jKOi0XWmIEXrv
	Ie9yaM8daAlgBVmhqurDW1RHEmOcRCuLp2DSnacEoeVIJEnQDjJ5VffepJa9uXUiab+p0QaL1tV
	g1Qldm6pNtPN/rWY6LZLo++juuJK5C7EZ/PsbEl4Tmz02myw==
X-Received: by 2002:a05:6830:8312:b0:81a:a8dc:3103 with SMTP id 46e09a7af769-81aa8dc3643mr3416653a34.37.1790597315104;
        Mon, 28 Sep 2026 05:08:35 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d57ef0155sm1271472a34.9.2026.09.28.05.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:08:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xBA9n-00000006hK3-2U74;
	Mon, 28 Sep 2026 09:08:31 -0300
Date: Mon, 28 Sep 2026 09:08:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <superm1@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	Jatin Kataria <jkataria@netflix.com>,
	Boqun Feng <boqunf@netflix.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260928120831.GF163130@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
 <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
 <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
 <20260925223928.GE163130@ziepe.ca>
 <ab1cdd64-3390-480a-8d41-a942e8b2e120@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1cdd64-3390-480a-8d41-a942e8b2e120@gmail.com>

On Fri, Sep 25, 2026 at 07:33:08PM -0500, Mario Limonciello wrote:
> 
> 
> On 9/25/26 5:39 PM, Jason Gunthorpe wrote:
> > On Fri, Sep 25, 2026 at 08:11:41AM -0500, Mario Limonciello wrote:
> > > 
> > > 
> > > On 9/25/26 07:28, Jason Gunthorpe wrote:
> > > > On Fri, Sep 25, 2026 at 09:20:02AM +0200, Joerg Roedel wrote:
> > > > > On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
> > > > > > Why does the GPU driver have to request this? Why can't the iommu
> > > > > > driver know that this is a special device that can use this magic fast
> > > > > > path and then auto set it when identity is asked for?
> > > > > 
> > > > > This is a layering violation either way. Either the IOMMU driver needs to poke
> > > > > into device details and their relations or the device driver needs to poke into
> > > > > IOMMU details.
> > > > 
> > > > There are no device details, this is just a module option in the gpu
> > > > driver.
> > > 
> > > Well the GPU driver has knowledge whether it's a GPU inside of an APU to
> > > decide if it's valid.  That information is part of the discovery table
> > > setup.
> > 
> > Where was that in patch 2?
> 
> amdgpu_device_use_perfopt()

Ah, sneaky, that looks like it just decodes from a a giant list of PCI IDs
 
> > The right way for this to work is to quirk it through the iommu driver
> > so it can choose the fast mode, and not involve the GPU driver at
> > all. Like we've done for every other GPU weirdness. And AMD should be
> > making this work better by providing ACPI support so the iommu driver
> > can understand how it should work without inspecting PCI IDs.
> 
> There is a heuristic that Vasant added recently that we detect APU from the
> IOMMU driver.  We might be able to use that for now.
> 
> I'll take a look at what an incremental patch looks like on top of
> iommu/next that I think reworks all these paths the way you want.  I should
> be able to post something next week.

ACPI is the right answer to these kinds of problems.

Jason
