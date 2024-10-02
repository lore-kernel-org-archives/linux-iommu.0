Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1F198837
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877454; cv=none; b=tsKO12lDJKqPO7H0utu/i2wrQ0sezxg9+3MuNdPq9B+itlyHcPWJ0A36Y33nHpRMcmyQPP+JWxbyRfZzVZ3g8gIj2a8c9CN93lUIiv8B2d7FhjO5KGArPXGx4t0iUOGEkseNot4Cyk78S9DD/KQQQAhmBZUJUfnl/Hyx4HBB1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877454; c=relaxed/simple;
	bh=Pooc8jqCoACKDkxjeD3RwI314XFVL75MJkUJoMYSXDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RohTwaolqtuA8zuosVGtU2DO9dlyvtErtulGO6WkvWI38gG8B7S51qtvwDfEAk6X8NKFbdm1u7eH6EWMHFaYbMXgC71jxbQMMA8EXPpNJGNAHzQaW5kCVWSIiMUodNRibDC70524uRS+BgAp2/xI5c6w2Vz8faa5WE33rT+zibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MVVPNEBX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MVVPNEBX"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4582760b79cso32434941cf.2
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727877449; x=1728482249; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2H02r3zTa74iRXCY7A1b58x287tYRqA5POM1FvdSPI=;
        b=MVVPNEBXJ3D+9nuUGxENwNVMrHURarhjRQa6SeSz/nXnZWA0/okNKNR76LpuTueK1y
         o4v9PCfeQw07Oh725xNwt4fAs9jlYBPF3O/FZYSa3cmUNi1vpHO9ByBqaROzHMhCaBUH
         bo+xvUYxP3oQuxUtopJ7NzvLwHAp3yS/XubYODfxUd+Przu/CPBTV/Qz7zuSkmwGDSf6
         wJTcleYsGUqI35lvHPDWYkLboGlyFhHflaLsq+u3cEQ+BV+aIA+kENpHki0jzOzDDm7k
         X68+ELFc69Jyu8NLG7cv1dgVCJ+BUXOhGf//Hmx8aAh+/cZlgbT/hXIorAlX87FxamTc
         c8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877449; x=1728482249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2H02r3zTa74iRXCY7A1b58x287tYRqA5POM1FvdSPI=;
        b=DqTcNJDWJICqySJE+HntboZPeU9cE/8dgnOZswPDL38t1zZFbynmIp7SGkIvWr8dyU
         x4tC8MO2fuY+kKHl3Iz8KAdOeXd3v2PniKNdNiI0LqBnoyIgTb3vfLP1D8tTp4RLYM1g
         6qlSTh3KUGIhwfIiEAbC9E2UDl7D8h2/skev/LiCfyuuFAueT3nFZh+qWVmEKzGBNqvP
         8hScxarkrU9ULg0n0aBIzIUtlADX53zVj94bOArxGTtCGd1ZQT+eT6JA+ySXKi+xbhLD
         MR/CrG2fQ5RE3PvIUk56pPUi4eFEXDkw19XVoLZSCI9mF1VyOoBG0fZW9EJmrvkEHhv9
         lvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIbrhJPwRssSda9nF10+t+gpE3qHNmpSWCcdXC37Etv4NBLcK5z4RK15ttC6UNopfE7hTnBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPC0mHIE+CqSvZ/BIeRTjZtTxuoMU1SdsUwPRnuUI0GJhKJywm
	/2rbY+3LLYhd5/Mt8VuA30tpFH5Fyfll3hCNtj9aGDYrGmJ1ekHKrvUu07LZI50=
X-Google-Smtp-Source: AGHT+IHylODiiqhCOKCIRDJ++oCfMHoTJqcPndrkdpOLzniTCtJewXVeBtuk+WUeVRzPp9ohMo750g==
X-Received: by 2002:a05:6214:3386:b0:6cb:6042:b928 with SMTP id 6a1803df08f44-6cb81a5d03dmr34303506d6.39.1727877449617;
        Wed, 02 Oct 2024 06:57:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b62d520sm60526996d6.67.2024.10.02.06.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:57:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1svzr6-009XEc-HO;
	Wed, 02 Oct 2024 10:57:28 -0300
Date: Wed, 2 Oct 2024 10:57:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <20241002135728.GD1369530@ziepe.ca>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
 <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>

On Mon, Sep 30, 2024 at 12:15:10PM -0700, Nicolin Chen wrote:
> > +static void arm_smmu_get_evt_info(struct arm_smmu_device *smmu, u64 *evt,
> > +                                 struct arm_smmu_event *event)
> > +{
> > +       mutex_lock(&smmu->streams_mutex);
> > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > +       mutex_unlock(&smmu->streams_mutex);
> > +
> > +       if (event->master)
> > +               event->master_name = dev_name(event->master->dev);
> > +       else
> > +               event->master_name = "(unassigned sid)";
> 
> Likely safer for dev_name to be in the mutex too.

The result of arm_smmu_find_master() should not leave the lock, and
dev_name()'s result can't leave the lock either, at least not with out
some refcounting on the struct device.

Jason
