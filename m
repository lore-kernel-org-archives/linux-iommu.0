Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9261EF0B7
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202262; cv=none; b=S2+kvIiCYq74EHXd46zHxblkYVzeJXgYFZujlMLFq8yseuC176Q1MfkH43qv96wuHHscXItzf1RlZooS8vLwsFWdBqIoyoMRfa6divOZRiIRNB0OKImT/qpN2URokYfsa57Vz9+mTiuGEN9xTGLqgF+I4b/D5r60gPEvomOltr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202262; c=relaxed/simple;
	bh=D2/P0Y5pKp6me/ZpctTDSyEjiEpbZuPe2WgAwaVpQEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNbL5bGKYo6iIzrLAGJf2XzHMSVGOqgIfbMD+LUhzPHpvoD/BE618htNIv0NBE4cKBzXPF9K0nwcwnXMRQKLxvid2cNpJL7POQ1XiJjlCvr4cS24/Vfn/7c1S37QHEfrap9La3EZVcZTgqS8C/IG/CXYhijAZOAiI9fq5p5NEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EY4qzyXs; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EY4qzyXs"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e3c3da5bcdso51721247b3.2
        for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730202260; x=1730807060; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdu3IELipu3p/D74A0pX5WWwRqpoNt+qbtWxqKF5oIg=;
        b=EY4qzyXsmPTmb3Bo+CEpIlnWglnykhW6Itg/kH6JJ29Q+1G6O5ycXcgIfjkWKEEPK9
         OTZOP/jdeCG9761FTcqBYfbtyYwzC1T8fbWUaZYiv2BzGNnfpzyl5V0q8CndR4CCUitZ
         WSizUs53TJlikWboInI9lgOt695FNsnQtRC9e03cgEEUmysooMUBBudf0TBgkMU2ipQS
         /+gsmToeBccaKCiO6wkIJy+/4xGDp/yZiCsFlOpYMSeXo05a0CnUfvKj2vAbCa9FflQt
         8NuAVZunK910SFcgBr1tvtb99kTrnVf0DMBf9gQEBiZXmDMclFIi2YjYwFZEAv2L1ZgA
         5TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202260; x=1730807060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tdu3IELipu3p/D74A0pX5WWwRqpoNt+qbtWxqKF5oIg=;
        b=KdALVyKcaRggSPhWiVoZygZWkiRmJTI9wvQaesfwsudq+HnBJbE2gI3v8jbQBzAHiw
         9JMN/VwP6zzUs3pwVEw1wqYFfxHUUYF5ivSEnoXj0PPU9SMASNz/v2YgASKuD8VY7t0n
         uGd2Kqdg46RQYIBKZ9gJwsDhr64XDEw/Nq+aVjrHnCoSS6j7tCx9YMEzQqZQIQGvI3h2
         D+GTaKnyAhtbmG7ubFS7aj8myc0vBXdLmI3NNWlXIJEfkQFRLlo4sq908CVK2kWc1My/
         RuGJCh27X7VYt8C0m/iLCJqbu6105g4VO9xegzruAFCe4Pn4oTuG6D29QAOWTmK7tVGk
         MmtA==
X-Forwarded-Encrypted: i=1; AJvYcCW7jWfLIp3eWmC9ldC0DAqUx12stItF2Z80zPEmUNwl8r4ODC4z+u6hZVGcwMXiYF02RG2LoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxk4S8WJcKvlMrW5qBgkaLyjwBBsg2qMflaGYV7vX+k6TjusrTV
	b8LSNMCZ2Rkn4m8oAFwqMA/4wF/Wu8o7yfHkmiSIsCvalNbr6btzlVKF43IAT34=
X-Google-Smtp-Source: AGHT+IEhHhMgHBibsj89vlo3FpSboBqZgX525xqCBVrHcZEXwemaWsTbNPtOJsKqaWZCs5pZavMFZQ==
X-Received: by 2002:a05:690c:f12:b0:6e6:1018:64ab with SMTP id 00721157ae682-6e9d897fad1mr107281457b3.5.1730202258436;
        Tue, 29 Oct 2024 04:44:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2ce60sm41001036d6.108.2024.10.29.04.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:44:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5ke1-00000000nYV-1mP0;
	Tue, 29 Oct 2024 08:44:17 -0300
Date: Tue, 29 Oct 2024 08:44:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 12/12] iommu: Create __iommu_alloc_identity_domain()
Message-ID: <20241029114417.GJ20281@ziepe.ca>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
 <20241028093810.5901-13-vasant.hegde@amd.com>
 <ZyCtLXeZxhNHTPbX@8bytes.org>
 <ad8bc41e-e6cc-4a91-8cef-6aaf06703cdd@amd.com>
 <ZyC05ycHuceILlye@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyC05ycHuceILlye@8bytes.org>

On Tue, Oct 29, 2024 at 11:11:51AM +0100, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Tue, Oct 29, 2024 at 03:36:41PM +0530, Vasant Hegde wrote:
> > In my base (v6.12-rc3) + this series, iommu_domain_alloc() calls above function.
> > 
> > Looks like you pull Baolu's series which removed iommu_domain_alloc() [1] as
> > well. So now there is no user for above function and hit compilation error.
> > 
> > [1] https://lore.kernel.org/linux-iommu/ZyClPkzekxXKqTFV@8bytes.org/T/#t
> 
> I see, that makes sense. Yes, I pulled in Baolus series as well before
> this one.
> 
> So I added the removal of the function to this patch as well.

Great, thanks, that was the plan!

Jason
