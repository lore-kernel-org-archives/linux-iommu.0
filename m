Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751E226D1E
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015045; cv=none; b=Xz28ATcPPe4GVacRBR6sXb42pwqSyEN8fyG30RBgieF6x+IZnLpKBZ2IcAXmnZ+y0S4Ybkzx4tHnEmvxZQXemITr/gfgLTV3bsodE5LzUJ/xbSvUq5Jj8f+hEXFc76KhWDW7wqQLzfAhOO21eLU3f8rbhNfmKC1H8Y76+IDl/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015045; c=relaxed/simple;
	bh=r9MKe/SVH5Cpaz/tNBI5uI7KSiWB2m0t/5DQuFADqN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smarIw3I3pwqy9I7JuuRM9snFTGbyMLH1Ngl6ThGdCAdPt9KPbNJzwdD21UX6R8+nQKM/ve+aTxeFXarAQldNlwWw2W+EKzSngjNmI3hf01umIHDffBF02Gj5r2RccUToWFpp0kIVpzRAVkuFZmKKeVeoXfvtyi3Yhe/aiTkTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VL1jGH8S; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VL1jGH8S"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2263428c8baso323915ad.1
        for <iommu@lists.linux.dev>; Mon, 07 Apr 2025 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744015043; x=1744619843; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PM1xp6gzVd/l23ioaAQhkaBubnLpRRJNpYojAABDe0E=;
        b=VL1jGH8SorVG3hKtjTIeDBgwzbTcGy0ffB+ShCB/CB54AH2ZbfHMV6cbt2M08lp+7C
         UdA2ykH2KZ6Z52iogjqNcR+9McfdzLWmHOqzwBx0fA3l+x/R9lSbVfzZktVuYMXzOZ6z
         u1cY+10/BHfPTP8WbzUUt/I+KnmIFBF+HHix/HfQLHRgmaeBypWXdDufP/cIHxpbSmPS
         LWMUSDgOlhppDihf/vEwyJZ5zAvP5BPTjGeunpkZ+iJCmU2WcOmWRiYzh5yoZ197bC//
         gBqXl8cBRY5rcuHMP2BjnkCrGj7IX1EBgXmRjDUF8i9j2wAY7znwEAlv5z6NZ3PVQee8
         zU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015043; x=1744619843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM1xp6gzVd/l23ioaAQhkaBubnLpRRJNpYojAABDe0E=;
        b=tElKwszk6LK8ISSK8BiV+GvB/AshxFcrDK6ohWliI+0Kb/ADB9uqjIIMQtaOriMbzQ
         rl+Y50PaOkylyPBc6O0Q+3GBA/nyWdV+1VRrPY4pio/fhk2tWmIDu0m0ushhu/vRtJzM
         PA5l08yDcGZ0PHHMAERvcRgJHtOqySEWhmpO/gESFl1DVv+54hwWfmt4Sj8DjA6fMQAk
         9tNCT9x1cj5p7yP6CIXbBFZlpn3l9ibUAPrWq3/2WfYTPUNHlClO0jmpWLFHU4AVdl2Q
         KzZfPAU9LIr/Hd2kifkFtg8pBICu32m30y1PXjfvmhZyB9WX33W+us7nmNKLLhhyNMgT
         oCng==
X-Forwarded-Encrypted: i=1; AJvYcCUYVmku8gb3tjSTyssvAQbu4HaU/QjUc0WdZcQK1DBCQ6cLPdJROM3ElKHf48faMw1SjS2YCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFymPSx+hPuIjG8004yCy+H2xfgwLLSgAL/RhUGS7DN3Ivmp0c
	Q0XhjFqFWTvH5aaHxWLBIcHaO0LUY5XR1WMpT5qWo4WfGeDBSMD3uDNwxdWljg==
X-Gm-Gg: ASbGncuPEboHYMFAxyuIgeR6AFYAQORKbsQBNOq+9H3RDBRQSTlVIGRef4GcN3n9/QI
	fZySB/pJNtug29ccu4VTiiteXFZTReiyHdjV9v4QPM7RyPMrIdoQKdDOKKH5YRhJ5LSB8vmuDQt
	GZDcvoZPaZCWLTw9toUhgZIlol4acy/Bk89QKjp5Ejl+xOxGcfLUh9rC7Q/m92X6es5L/BbmHmq
	GQfkpXoJ4Lt5JUbg2N2Vl5Hn5oATvOW1QY85WGKDTVzrt9zQltXgFk1THJa2/HZu5iH3o7dgdc3
	VCPkp7WgYgdwV6YJnCPR9tbDWtR/xwDQ/oSMVxMQBKtocuaWdIFIfjoleNlEvjccQcgwXYXpt4p
	8TUc=
X-Google-Smtp-Source: AGHT+IFEcecwODNx4wiqbqJKpBlZrrA4mcqLS8OyyMt6tYMj4vc7ksfjibFdVhVKjFGu4nMmJA0OlA==
X-Received: by 2002:a17:903:2308:b0:215:8232:5596 with SMTP id d9443c01a7336-22a95e638e2mr3367595ad.16.1744015042625;
        Mon, 07 Apr 2025 01:37:22 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d19c5sm7904646b3a.20.2025.04.07.01.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:37:22 -0700 (PDT)
Date: Mon, 7 Apr 2025 08:37:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] iommu/arm-smmu-v3: Pass in vmid to
 arm_smmu_make_s2_domain_ste()
Message-ID: <Z_OOukRG0foehmV6@google.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <214b10db02f1046efdc70e2c4803111357f60070.1741150594.git.nicolinc@nvidia.com>
 <a95b39a55c324907a7001d3a2cdf076b@huawei.com>
 <Z8iNfnZ9N5Lczxmq@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iNfnZ9N5Lczxmq@Asurada-Nvidia>

On Wed, Mar 05, 2025 at 09:44:30AM -0800, Nicolin Chen wrote:
> On Wed, Mar 05, 2025 at 08:50:17AM +0000, Shameerali Kolothum Thodi wrote:
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > index bd9d7c85576a..e08c4ede4b2d 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > @@ -887,7 +887,7 @@ struct arm_smmu_entry_writer_ops {
> > >  void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
> > >  void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> > >  				 struct arm_smmu_master *master,
> > > -				 struct arm_smmu_domain *smmu_domain,
> > > +				 struct arm_smmu_domain *smmu_domain,
> > > u16 vmid,
> > >  				 bool ats_enabled);
> > 
> > Now that vmid is an input, do we need some kind of validation here as
> > at least vmid = 0 is reserved I guess for bypass STEs.
> 
> Perhaps it should do a WARN_ON_ONCE(!vmid), as it doesn't make
> sense for a caller to make an S2-bypass STE with this function.
> 

+1, a warning should suffice as the caller isn't expected to call this
with vmid = 0. For the s2 bypass case, we already set vmid field to 0 in
make_cdtable_ste for clients who *really* want the vmid = 0.

> Thanks
> Nicolin
> 

Thanks
Praan
