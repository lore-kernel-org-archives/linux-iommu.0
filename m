Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7212E736C
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780004226; cv=none; b=J/pLDtS3CAKGIDxoqxDYuDftj04pEqhcBqUunK50OomHOPXuFtthJiyD+StltAwmOOdc5Jaee3T/SmVF/rb63S/tcvdEI4DTBG+LQWZ92EeanOIyFh+HsSbVHFfZWwxb6xqCLdGFygBXXH5r2jVdwKJK5peZnU0MmNMhbFzMUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780004226; c=relaxed/simple;
	bh=BN49+LlyFsQi8exlRaWLfnYdKhga1MQrNNs5T4Qx9o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXDcCBtmrzSiY6eQ0/TJA8b9SXE8EDgWYQBqOawPpHsRr900V1ID85JtBy75HJXLLxjtq0UdzmZLMfi8HoLvCd+pNmtGQuwp2VvzbmcxgTiGHDhoSUulgKGGhE6efOEQzqqnJoYgpnx0ak11U/sTIUgznlDe5mbtLlvcnpjAH7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLey0SzV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLey0SzV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b46da8c48eso1065ad.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780004225; x=1780609025; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNxwchrCVk662oSbzWaO9dPKaw5cPiYbeEGKTdYgRqw=;
        b=wLey0SzVi4JMOIUhvLK19h3/SI7K0JG26pfn/zWI5rpbSe+73GOmdPpA8OBQcm02QJ
         yV/5py+eGN6St0/puvipDSmLVLsCkBc0KSo5al1vKGCpAI0rlQ29bzdrkaBrNkgBaJON
         xATxOoKGmTJ01fGTcABlaHiKbFEHEZNaEdH1k4y/m6EA0UGufrwGkeEIHd7sruzujbOl
         KU7Qi6sVtgZF9BDrWAfN4F2SeADIQ+VNZihe7Nr9fJYBBwL886qD95pOrAQt4ZHEaSaF
         Gz4Cm8Re1VLXJLA7AaBllXZgqaiT6aKZHpuxKkL+p3ihbgxzk28uJzt9xs0fCpjIhOM9
         btOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780004225; x=1780609025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNxwchrCVk662oSbzWaO9dPKaw5cPiYbeEGKTdYgRqw=;
        b=KHAvC/WurL+/iyESWJyYmOluI+rjn9+nqKEHssJkANqexCWf+B9wCHSwKeqd72eKcO
         lyHdsEG8Vh+NhA0wa+P71SeG/D8syvXCE6lIyfHhSoF9yTpsoZRJojTKbfohD0UDYPp5
         lskA2lgCNyiGYOew7wCB752xB2a9CIWlHlBcuRpKjevNsPj06vx5HzQf9N+30ffAU1eW
         mzuU/i/VpojNrJAffbErNc3/m6Cu6SViVMtcc2cTUubQqkDxFmx30MFMr280lsjQyadD
         u+smSHsTirgA5FHuZ6J+sLovtrz9sNu136akod94a+My06fYIGXwzanRn0MsetT0agSn
         gzag==
X-Gm-Message-State: AOJu0YxpzgnJQJ2MjfUIBENzbwrtp5H88/qW2likbbS42tznEMuKdDPa
	kx835nTp6kB3MFz0ti6ZTBT/VlU/B//94BCuTL2KpcxMOCRYqH9b1ZTu91jPPc7YEg==
X-Gm-Gg: Acq92OFJ+05jG5JdEdgeKCzOXdY3q0tXb0LFsHi9/RTRH0K7tEIqx0ofxYpZHQAfYjO
	YylHIrEGFxdAj03kDBOqzIo0a9O/NSFsK4TMOTkZ6F6kg6gkFHA8BqgmDZZCe7oimVApIrc2InV
	i/+wRsd4NWEpoOgmG0VO+q8G2RtW4+hxSjJpCw2qQe6XZUJ5VQUzQhQkdYAVd6+TcsgMgeZpqdN
	NK8jDh4rgUq9yBQ/w/3KT8FQcFYyRNCI10peAGpkDo7q6/14yvjfV0Vie1PgN1mkB7hfX4e6x94
	vafP1GIKJr02d52m9kgYS0WfyjLePiFsgVePZzofWimi2Q6QZJbFFbGyC9nIuwjA6BFthnG3kBp
	VoGNDM933muACgEhsJRqHg/4baaiUPD+AyE3koDpDW9T/kQIhMioHKn9r/Z0VXxrnEMtSbWUUte
	Xpp895yQntsg8qScIsa6Xe2qBQD9b8CYBNrpplgmoVUeQzj9vQcLfyaECafeMMTEZEklL3
X-Received: by 2002:a17:902:ccc7:b0:2bf:193b:a195 with SMTP id d9443c01a7336-2bf20d9490bmr96165ad.11.1780004224411;
        Thu, 28 May 2026 14:37:04 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841ef4e9ec7sm2669092b3a.24.2026.05.28.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:37:03 -0700 (PDT)
Date: Thu, 28 May 2026 21:36:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 09/11] iommu/arm-smmu-v3: Enable pm_runtime and setup
 devlinks
Message-ID: <ahi1er90buWo0mWk@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-10-praan@google.com>
 <ahih9IQ9jPS34mZX@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahih9IQ9jPS34mZX@Asurada-Nvidia>

On Thu, May 28, 2026 at 01:13:40PM -0700, Nicolin Chen wrote:
> On Wed, May 27, 2026 at 10:14:05PM +0000, Pranjal Shrivastava wrote:
> > @@ -5592,11 +5595,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto err_disable;
> >  
> > +	if (dev->pm_domain) {
> > +		pm_runtime_set_active(dev);
> > +		pm_runtime_use_autosuspend(dev);
> > +		pm_runtime_set_autosuspend_delay(dev, RPM_AUTOSUSPEND_DELAY_MS);
> > +		pm_runtime_enable(dev);
> > +	}
> > +
> >  	/* And we're up. Go go go! */
> >  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
> >  				     "smmu3.%pa", &ioaddr);
> >  	if (ret)
> > -		goto err_disable;
> > +		goto err_rpm_disable;
> >  
> >  	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
> >  	if (ret) {
> 
> Can we move the entire pm_runtime_* piece at the end of this probe
> function, like arm-smmu v2 driver does?
> 
> It is no-fail, so we wouldn't need to add the revert path.

Hmm.. I kept it earlier since I thought iommu_device_register starts the
whole chain of probing masters, def_domain attach etc. but I guess it
could work, the client devices can attach during the initial probe
as pm_runtime remains disabled until registration is complete. 

I'll just check if there are some weird edge cases here, just to be sure

> 
> Otherwise,
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
Praan
