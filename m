Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA23B6C19
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745116; cv=none; b=CFsqzurab8Nqg15Ks+qWuvknkx154WGY2R08tTHLhh9XetHUWfxJ2KimDqlofDfXcqQcFw4TqIGa+l7onzCclg4W8sQ02bUvv8oV9PdMN47q58naHQAPtHExRRStaDNV7v/rIumWDNQVtj2PQBpPicGxuvwJeH9Jpgf1xNA9lYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745116; c=relaxed/simple;
	bh=4Oj3rF7tXy0ro54utupktMaNJG+oSflFVJG6/TyvjDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffG4MuJhgoC3WixTfq9TaaJMzWdDNzwgtVOSpphFsqbS5VldlMgXt7uqSepaIKn4IjYkb/ZbM23adPkOZIe1RmDPSCFcO/0Xoc334cFXgNe4aoW/nr6aj8BAjOaOrzmlL6HLasKmOMsKGfIyxf3JnyJViU3qByAv6d+zz/ZmzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MgsrgrOQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgsrgrOQ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccdf36f63dso105765ad.0
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 04:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787745114; x=1788349914; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UTrCbBRL6HXb+RuUnBCTW1yY8odSkn59u8nz48f6xs8=;
        b=MgsrgrOQ0C7YBKdCYlJbxhiqlCvnSt3M32l3ln3+ZQIKHYWoHsBP32Ke6HG5hwRiCW
         ZF97Pcuwl2VxscfcPj6sKNeu9N/CL4nJ4+5pgRjI5Q3iq2Z/8mGH1ZtwDOWxmOIQ2Vvh
         UKHHZ5iaBVYEvoD0i3yziPKQrfGeeyEJ91VbEZTo56P3Pb2oM7/HyxOlBc+KpZbmZ8xp
         iQDQlHnwboNV8IPxqNZlwpP3tQL7rNURhjt5zUCuMJREKVzixcVOSuXHY0c7eUNTRszl
         hVIH2K6NUOQEUwJOfbOx4fsbCNWqPdOF+6LuO6iaFJY9xrJZSVz2kf6nx7VdlR81DLiI
         NAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745114; x=1788349914;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UTrCbBRL6HXb+RuUnBCTW1yY8odSkn59u8nz48f6xs8=;
        b=GgE+TLammAYYLKTT4qhVmSFHEDqprUl6tlkTk1rdyCeMR/1K9YU3nwbIzzE7i767DE
         +GdLzK6Ag8nUDo1+MPbbyT37ZffUSctk1QKa+uW765L6KDCajodYlCqhxgKzVpRD5QB+
         VsQOWYsLn8I8GJTsP4eKBbLbrSx7ZDlqfi0yyObl5EG0NJCiZ7ZhVBQd1dh5U7smU6E6
         +/6K4v/qo+NXV2wDs8zEfWvIrgtFe5hDn6P6rNeAHeeOujpKJjYO31KmtZXAaXnQyVwD
         d8dmPvRNzkZGWkzS/ko9wF3Pc/hwVmeCbq8sOceRuKJjmleL92Xa/kdn900dKanmQmXm
         i6MA==
X-Gm-Message-State: AFuF++m6cpYdx0NCfCUfjqPqVbuX0U5yGJKbmrYGCtwpwhV95Twqy1xd
	D8NCmLoAQmGwRdS7sZbP0sDK5ae6rbcvel5ubxWiy+5gz2bfdVWn7uhj3p/A0O1gNPP/w6601i8
	2p8gwvQ==
X-Gm-Gg: AR+sD11ujwhWLLdwMOeyGMPtVZecL6dak0QQ2iYccX0V8EdemQUAP90d4njgDT/wTMP
	g5aI0A5ltcvSXnJP22EYmbcfRidbnXFXAJkmMk8fW54/HXVNMQ2Gl2xPixloBim8Y7MDY4k0QoV
	nNur3AtQFUpYWhoQVpveGn86G9DQZf3oZY749KO1Tfx8RsOEZz7TnM43HfphxaVHO1klW3LGCHw
	Yy0DO3xno+kOWsx6OSFAiQj7eem9fi3xIHTHgUaN3i5cC72cqUdqtk5ptlOofznI20oKR58wcsT
	XFUjx73hyTNt+5K8dxcOWsLs889mpKeOXlGHCqR37oooihnGByd4O681yoSh0rFblYiz6b1qMk/
	H2KR1xfVmUgJ1yDpQLeOMtelDlPFXZ9V0vGOwwa4xatAfqfxmNR5d8t6cZ9g/fMUAQiELKEVdqM
	AR4FFcGmyEZ58udXICtrG6EFjEWXn7U1Rvv7r0rVLCqqvJcluxAFxJRk1CvH3c8HbwliYiBVUqR
	tFEJSHCTN65wvuEE0Oxyr3Xgg==
X-Received: by 2002:a17:903:1106:b0:2d1:1d3d:97c3 with SMTP id d9443c01a7336-2d71052c89dmr3015365ad.13.1787745113926;
        Wed, 26 Aug 2026 04:51:53 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cd86fe3sm790578b3a.39.2026.08.26.04.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 04:51:53 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:51:47 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ao7TU2QSprRbGfEC@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-10-praan@google.com>
 <178767577113.3356902.28128835506777632.b4-review@b4>
 <ao3kxwbwB9GC3EOM@google.com>
 <20260825201701.GG3325090@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825201701.GG3325090@nvidia.com>

On Tue, Aug 25, 2026 at 05:17:01PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2026 at 06:53:59PM +0000, Pranjal Shrivastava wrote:
> 
> > > I agree.. I think there are only two options?
> > >  1) After GBPA=Abort ATS requests are blocked, so you could full
> > >     invalidate all the device ATC's and now it is safe to ignore
> > >     ATC_INV
> > >  2) Just don't perform suspend once ATS is activated
> > 
> > This is a little tricky, I'm leaning towards 1) since edge devices can
> > have ATS enabled
> 
> Oh really? Surprising..
> 
> > However, the EP might've entered it's low power state by the time we 
> > reach smmu's suspend. I'm not sure if we should be waking up the EP for
> > ATC INV All (or if it would even wake up in such a case?)
> 
> Is its power down explicit? Could the PM stuff trigger wiping the ATC
> and blocking DMA for a single device before allowing it to power down?
> 

The power down is explicit, due to devlinks, the PCIe driver's suspend
op (runtime / system) is called before the SMMU's suspend. I'm relying
on PCIe driver's op to clear ATC and everything else before powering down 

Basically, what I mean is it should be the PCIe device's responsibility
to clear ATC in this case because by the time we come to IOMMU's
suspend, the PCIe device would be powered down anyway and I'm not sure
if issuing an ATS INV request TLP would wake up the endpoint.

IIUC, if the link is in L1 / L2 then TLP tranmission is disabled, and to
bring it back to L0 we might have to call into the PCIe subsystem
*somehow*.

One thing we can do is shout in the dmesg with a dev_warn if rpm & ATS
both are enabled saying the PCIe driver is responsible for clearing out
it's ATC during suspend since SMMU's suspend runs after the dev is down.

Thanks,
Praan
