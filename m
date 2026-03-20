Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C23451B5
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774049689; cv=none; b=eHESgKo38QTN5cALmEafWbn+1jkLPnKUxASSQ1atPBuqG0Nz8OuVWSiEoI/0zmpK1SChQh8dMtpAxrBQw9u3Ddu5CjRaabwGHe7qqmoNGAHhGZuRAg1yaimCdeD3NmytDK9W1GrUnNtCF1tBHOuZNj0m10mJe3G52EK8xJJWSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774049689; c=relaxed/simple;
	bh=eGjR1Vr7sZJkjuTItiI4aUSbYLNlDKVsWSLdbGJh5Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ6/HXyV12946sfkMRUa/aEWlTejeCdcGtIHJ3zSPX5vlxqs7F9E7Bj730iWym/ojB87RehLlx/ktpWdfdd0RUIKa4iIAFm3qlj6Ntgi6fAixwC1OI0iyRz3L01Q28mXlnOd8YVxgF7fquR9vfOkB8Pt7cQPcEINYIjcrueBUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNlr6RAK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNlr6RAK"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aeab6ff148so20745ad.1
        for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 16:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774049687; x=1774654487; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3DUb8XK/BNGAY47qp0W+ue0rjJS+iXyrE96peyM214=;
        b=SNlr6RAKE0TNJUbkcFvQ4TAEODV/J1ivhSrJ9zeYDn4DnQ8Dy0p7KNwa1qMiHZL5Og
         4JxVm3fiOQtwTvXnJls4WAvu+gaXTc1sPrrPYuUaEoUU8xTOjBcU5zmXDARQt2UiZY73
         sLOEyCIsJJ7mayq6HYrd/a42HnSG0to79Wtj4rJ0cEzebU2vNhx1wWtZTZawWcFHM//X
         gvAk3eIdxw+Zq+rlWYJRpimeaHaKT1DM4Ra7VNM4K0uqGlEiLU0cHzyzSiuTB9rkFFF9
         VRCYatSoluChv6GXhnxUZVivIp2cLBIPAGJ46NYj5/klVWQSTMjr+h8td+NdKRqNq2hP
         2UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774049687; x=1774654487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3DUb8XK/BNGAY47qp0W+ue0rjJS+iXyrE96peyM214=;
        b=R1r13j/5d1hdLG9JUJJJCESSBgNz5I5d4wKv9HdQOZhRLX32D2MxcYIVRoDixzpFzo
         sGo63xTaKZNMCabqdj02XcSI+qmJ7ZtDCDNf/Xk1P5uQlCZADiciGI060HDgrOGyr13r
         OL8l2/cOaw2xryA77Ok9PU+CfZvxpYSNusQAYJAFufUCnQWTR/PdulAa/G7VjBaORhW6
         o2oje3vXiA+qy7OvI10oBYuIj/BzkjxUu8dms7AoAh62TmA0awIq5zFcCDY4P9ZYuOST
         yWLEBqNTXMu+gUBYLCmhkfiTpgqahf29oOKVbbCLPc6vtpYUpgP2eamE5Oc8WMi1w7a7
         7Auw==
X-Forwarded-Encrypted: i=1; AJvYcCU0qnPZdJlHp5DOJrt5BwlbK2Pg7HJ10NQwb0NvfSLJF9QazhQal28kpl2bC641bytxfc2Bqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOYLfPdPtaDjChZV6eKU/BCS/9XuKFLdvs1W10SBMNoxUwx9a1
	Mbdb7voa/W6UD+ls21+/tjj4+EMZjeXXjGdGyRu2xrEhFj4c2QFFKl28VbitYD5oqQ==
X-Gm-Gg: ATEYQzwXDGrWJ1drfm7Hq2/FB9PPQ6iNBQoDCqxnEgzSRpIfe3eFw1ybit+ZA2wx1w8
	6m4J5ZVeDFTWuqakFp7YqLmMiScVG8XQ30AzuEoIH+j49oCGydFnR9UygNocPxcTT2FJLPQp6Sh
	nLCUrSM4AAXVXRnhgAIito5EBBJfYCuKklhfc7r5ZuBxcD2MBD+FdIrSRGdMLSyHY+oJ2XFX08J
	chKobuiWQ/y2bWR6DMVlaoWiedSfriVp+ZYKW6UIhy2sKC5FxZUMSRtOVPSPMLX8R19JDLv3By2
	RA4VCbIdQ1Pzoh6NWo/FiL4uoZ2CdLlh4WmbCcRHNAbFlBHAn1w5HWb86hN3FilbziUXIosLa0w
	WJzK3AoATqj7jTOUMhU+lMkv//oOgAKkJkNx8748oBsUfTJ+kHwqXWX1os0UL9m7G791XAGdi/+
	NTRozgl5uw24ULrxADSowqOH5mXOwCIUqo3iM1q7S1loskBpdqvIza0pmhedKZbakbhdW1Mks=
X-Received: by 2002:a17:902:e84c:b0:2ae:4453:3674 with SMTP id d9443c01a7336-2b08b29f391mr1276665ad.4.1774049687124;
        Fri, 20 Mar 2026 16:34:47 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443ccbe4sm2570680a12.22.2026.03.20.16.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:34:46 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:34:41 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH 10/14] iommufd-lu: Implement ioctl to let userspace mark
 an HWPT to be preserved
Message-ID: <20260320232634.GC659132.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
 <20260319231331.GB3983821.vipinsh@google.com>
 <abyU3g-ta6Gg6kEx@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abyU3g-ta6Gg6kEx@google.com>

On Fri, Mar 20, 2026 at 12:40:44AM +0000, Samiullah Khawaja wrote:
> On Thu, Mar 19, 2026 at 04:35:32PM -0700, Vipin Sharma wrote:
> > On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
> > > From: YiFei Zhu <zhuyifei@google.com>
> > > @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
> > >  	bool auto_domain : 1;
> > >  	bool enforce_cache_coherency : 1;
> > >  	bool nest_parent : 1;
> > > +#ifdef CONFIG_IOMMU_LIVEUPDATE
> > > +	bool lu_preserve : 1;
> > > +	u32 lu_token;
> > 
> > Should we use full name i.e. liveupdate here and other places in this
> > series?
> 
> I think using full name liveupdate would be too long in other places in
> this series. And also there are other examples of "luo" being used as a
> short form. Please see:
> 
> https://lore.kernel.org/all/20251125165850.3389713-15-pasha.tatashin@soleen.com/

That patch is using "luo" short, which I think is also wrong in saying
memfd_luo, as there is nothing related to orchestrator (O of LUO) in
that patch. It is saving memfd state for liveupdate. But that ship has
sailed.

In the current patch, I don't think it will be too long, and it also
easier to read code without someone to know what "lu" is. We have worked
on it so we know what "lu" stands for and kind of accepted it but I
agree what Greg k-h was also suggesting.

https://lore.kernel.org/all/2025093023-frantic-sediment-9849@gregkh/
 - "You have more letters, please use them.  "lu" is too short."

Not a hard no from me, just a suggestion.
