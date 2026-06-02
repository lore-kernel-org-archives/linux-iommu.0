Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC12E7F39
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381315; cv=none; b=Nx/joFpAQTZaY3hNiXQXIOCFRexoN1UDHfNI/ZzIhLyW8frUm5vjqrkrogrdtkIp5naYhlf7L3h0AD0XyvwWOIdw9SGpMAf2cWzt3Ue2grEYW2RpdNeGseWvsudwOT7rkVPhI/Q3FOrbf7A9n+5B2DDEZCPSI6CuCYzEPaWAElg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381315; c=relaxed/simple;
	bh=nFwdP6FG3H9vidU3eJpv2t5nglumplndU/PxXifeTSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTqda7DWVTB9+ZSmfnPMmRDWpoa+kLnUdfQMa8C6ZuG1LU/g6ADwPXQNF0jaj40QZeo9zeXnbp9bURXmRIOIgcJSvJaDIkmDMzs9ENi/VMFDuGXNm/1O3iCNUkb/SaGIs6szGWegON2mdDmnAjsUKmSk5N0hSu0cHqtZWZeSE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAIlr88g; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAIlr88g"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2911f93cso1255ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 23:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381313; x=1780986113; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYd3amg0E6+q9+HAfqzMshV6/sBvgCSxshzNIgfKNSA=;
        b=KAIlr88gg8Hu3Re9fzMDL5fa6oRQNIkUtxOk813GHuNY9jIMprxf9QcwLpm1m0ziVz
         F7UBwEh5pYmCOMrWgpfayqNuue7RZOFndXalqYExAB/vgfCMkbXgubJMUyUJR3/FJI7y
         iDPl6DOcTbu8RHR1b5BcVJiKjODVgQgn3F8kS+nJuf0lFj1ngMFwBkWt7rG8hXJqyCSi
         oube6QBMJUXGJeknUVw/Kq1pUGj7C2OC7JhohY85Pn1kmV93BRqj9YDGP3bw8qfGCkSP
         ZiaAaDpRes+z2xLipFSWz5ShBKO2t9i3ThBNWym3JBqUajtqzqOBrEky+2ngEsOfP2MD
         Mq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381313; x=1780986113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYd3amg0E6+q9+HAfqzMshV6/sBvgCSxshzNIgfKNSA=;
        b=c8uyJ01NOnsXztzJbhwkeNsHH7h7iHsvsI0qITeaXBQ2aACq72mNUyGqUq0duVgiZI
         9kRBoRKaU3BaWDfpCIK0Krjsb0tshgdAhIu930WaxXwdRKIUoCq1j6ZEo2bMHumUEcsX
         Z69DeQkxeoCDcTaA007oT/FYYDIm5EI8JhADyDBZ6WQ0cORhHZrWLXHFqrlwIYud/38p
         KthpVLS6BQURtEiR95zQgnDvzg3dnF9e3dKN+scA66NToLNUO8leXSVNH3Wlzkx5LHv5
         O18m/Sf+AAEujhb9sbxBFizdpnUTcuh+9ItjtN7SRmmRQT/8i6CXXEXem4bvA51E699J
         O8wA==
X-Gm-Message-State: AOJu0Yx2MQjaIjl/UVQIEfOdVEywqTMLVTVkD0pxOyazmZTMtXK6ZUxX
	bjGvk0r6J60uSmfThdMtQFBeMnqXBM3Vw8hyuH2ugiTRGGRRM9AHQBCvGXf8j9zlPg==
X-Gm-Gg: Acq92OFfF859a6+vbdz0Sr5s4ISUHepeSICf6wCLqS3oWSbTsNI2edn/4TFMj00Y+os
	MrYMfmKJo9eXN8VMKyZO/+5gdxbnxuKUh883Rr0vnfcsqWKpv+1dJHuvxP8ByRinILYCINspoeu
	LiRn2tGkQEEjYZssL4esl8hhViQQcP0iE7GmpT+rOn/HJm5Fs9DuBhyoCvtIwZUJukFcZjWniSN
	xoXz84oPNQr6F1zJ9DrXEF45Mdl9/OhYORygLrGpb+EtggUOL+2OTy+K/ehlDB+cWFnvbOrwDg6
	cb4Qo5KecwbsV44ff1tNisGvNoZ8YN0MtsAz3RUZCMu1PT238Yz8wmP9PmHODitbQcZsXuNJ6A6
	AEdfhP4swN9hQzAheGRL7V7TiK1ynqN509hvqeAIA28oRM65SkKm7Gzyi0r9dhB0n7HeEXpisq9
	0vf9hBPxmJpsCUrHAoWAmrGQkVAz+dcCKjqv+iF+NdFeoO4yIe8hQSxgcZnKFxfxgEU2E+y3yLQ
	p6sxOl84Q==
X-Received: by 2002:a17:903:3846:b0:2bf:3741:5b76 with SMTP id d9443c01a7336-2c1129aa450mr1509075ad.3.1780381312701;
        Mon, 01 Jun 2026 23:21:52 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842498819e3sm6575263b3a.34.2026.06.01.23.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:21:51 -0700 (PDT)
Date: Tue, 2 Jun 2026 06:21:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 08/12] iommu/tegra241-cmdqv: Add a helper to quiesce
 VCMDQs
Message-ID: <ah52eZh0DJ8LFL0x@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-9-praan@google.com>
 <ah4gYCgSO1bBOUTj@Asurada-Nvidia>
 <ah5QB0Hfpi9wZMLY@google.com>
 <ah5xRRn0IjdWiF8F@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah5xRRn0IjdWiF8F@Asurada-Nvidia>

On Mon, Jun 01, 2026 at 10:59:33PM -0700, Nicolin Chen wrote:
> On Tue, Jun 02, 2026 at 03:37:43AM +0000, Pranjal Shrivastava wrote:
> > On Mon, Jun 01, 2026 at 05:14:24PM -0700, Nicolin Chen wrote:
> > > On Mon, Jun 01, 2026 at 09:59:05PM +0000, Pranjal Shrivastava wrote:
> > > > @@ -887,7 +887,7 @@ struct arm_smmu_impl_ops {
> > > >  	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
> > > >  	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
> > > >  			  const struct iommu_user_data *user_data);
> > > > -	int (*drain_queues)(struct arm_smmu_device *smmu);
> > > > +	int (*quiesce_and_drain_queues)(struct arm_smmu_device *smmu);
> > > 
> > > Hmm? What's the point in PATCH-3 adding drain_queues then?
> > 
> > Well, you suggested in the previous version that STOP_FLAG needs to be
> > set for the secondary CMDQs too
> > 
> > All we're doing here is renaming this function as it also sets the
> > STOP_FLAG on impl-specific CMDQs now. We can still call it drain_queues
> > if you prefer not renaming this.
> > 
> > On the other hand, we can add a dedicated queisce_queues() op too that's
> > called before draining queues. I found that to be unnecessary as I'd rather
> > have one impl-specific op handle everything for impl-specific queues.
> 
> The renaming is very confusing... I'd leave it as drain_queues.

Ack.

> 
> Arguably,
> 	atomic_or(CMDQ_PROD_STOP_FLAG, &vcmdq->cmdq.q.llq.atomic.prod);
> could be even stuffed into tegra241_cmdqv_drain_vintf0_lvcmdqs(),
> where there is a for loop already.

That would be slow IMO, because we'd set the the STOP_FLAG on ONE queue,
then wait for it to drain and repeat this pattern for all vCMDQs.
Ideally, we should set the STOP_FLAG on all vCMDQs first and then wait
for them to drain.

Thanks,
Praan
