Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B371A0AE0
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591007; cv=none; b=TYhqprr+lcXhhzwfp0uVRNSXeWWjWYGkcmz5zra066AnBqzS5o3ySid5aQAx48au+jmlEmQu+wq/IIQlpnUMo7WHO5FtywU/TooGJyE0osrLCTyvy1o+jrkGnz8qzyItqBiNM/IQuJy7z0RkmoTRWqiiBdTDTmUn6uh/ZWMf920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591007; c=relaxed/simple;
	bh=52yg3c8Z+sROtWrD7KOvWboHFKaZJVMGxS4XIgnp2mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSapWgNR3AkeSELRfMFxlReE9PgZilZfSpnHIIfxKBIcTuGXL84GJtaoMLM1xT5z5oZ4QFuL6DcZJCtkphHC59WHq8JkvLnzk/wI4ac4w+tHpnOAFaFK/ZfsK7mzzhgQKnUexZNF4h/S+bw002FMQRH7weQUx+uGSglLdIwsVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oxFon79v; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oxFon79v"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-825eaedfef3so1785953241.0
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 16:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723591004; x=1724195804; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9bxAIpVX1riLRh+ADxS60pDEc8y/s/U7SNAzk7+y9E=;
        b=oxFon79vOv9OHOJRdesTao+K1K4ZezBm+n6TAAyAOcEVBUlCag2KQneNuYNNlr8HxX
         n0LABjAuin/++exdDljL+uesJ0vrMOXGPskTjZGCK6GTOl5n/kl1n7CLQDeV0S079AdC
         89nUQMCT+TsqhUQtinhduNIJyJu8ItG/78O4MIrSZgtEviFzkKibCeIJKYs/ORyQa6gs
         WfXECSB06ZElpAXApAWPrcSvmbeHQ49moxnHpr8jI7nwTP5QOQYmGSgZ6xAYTT1pUVFC
         zwGvFC8MAjt1J4m62Xtcc7Mqx32yC4CDdxhveA+mIsJmffyIc0I2glsjtFCoT54np+ZQ
         zYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723591004; x=1724195804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9bxAIpVX1riLRh+ADxS60pDEc8y/s/U7SNAzk7+y9E=;
        b=RYqRBLJzQVHC4Q9x2ouhxqhitPj+8UzXeSmhmuYzlyCBv/IKApmhJDWKXxa347sP88
         qwqCSYQ6YcxX+D/ZGHYZAoU2oH/t5LEwpVtxL3vVfUAvBPXGNw7nNA90bortYdCN1mZL
         Ixdg7W8LTc9LzXafKmg9FypKv7hpRA9BFkKV0Avt21Y8Lr1T7bCGMvlkogz7rkptBk9Z
         eWz0ThQq+EnNP8a8iHqsEbAk1Mkei8y+D/Yw+Napik+/JyMiusXSfq+0NlvjpNwsSyd1
         A7VeV41y9DcT1UuVoIgkSo3Fm4Z3LqafjZQ9yG4qnf2sVJZQx46SBfXuti6wI37BN7cs
         Mxhg==
X-Forwarded-Encrypted: i=1; AJvYcCXny8U5k4a17Oc5//uyP6XTU95ujd3HfAoKpjJVbOUwAvviMM0Er7DNA/QJBImDUSLEtHBN43myUfrPkiaMPVTzRpgb9sM=
X-Gm-Message-State: AOJu0Yx/xTa64R+PzbYw4efAOKVf5Vqmn9gbqMMqrOF/wElOqOkzrfD2
	2DneOU98FiIzZrFgKlCJSVoLr4VYeGQ4PSFIf1fsunjwMchNOh8UDa3pxMQdcTk=
X-Google-Smtp-Source: AGHT+IGoFDoTtoRoD3WRlWY/s4rTnkFYy3lRwr/J9OksbksRZd84IshvgLRkB13t/Qhd5u1Rki87Bw==
X-Received: by 2002:a05:6102:c4c:b0:491:f22:3a8 with SMTP id ada2fe7eead31-497599bc0efmr1522313137.29.1723591004199;
        Tue, 13 Aug 2024 16:16:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e0ddfasm379556485a.126.2024.08.13.16.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 16:16:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1se0ks-00AITY-S3;
	Tue, 13 Aug 2024 20:16:42 -0300
Date: Tue, 13 Aug 2024 20:16:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20240813231642.GR1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
 <20240813163053.GK1985367@ziepe.ca>
 <20240813151401.789c578f.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813151401.789c578f.alex.williamson@redhat.com>

On Tue, Aug 13, 2024 at 03:14:01PM -0600, Alex Williamson wrote:

> > Personally, I very much dislike this. Encouraging such hacky driver
> > use of the interrupt subsystem is not a good direction. Enabling this
> > in VMs will further complicate fixing the IRQ usages in these drivers
> > over the long run.
> 
> Clearly these _guest_ drivers are doing this regardless of the
> interfaces provided by vfio, so I don't see how we're encouraging hacky
> driver behavior, especially when it comes to Windows guest drivers.

Because people will then say the Linux driver can't be fixed to
properly use an irq_domain/etc as the only option that works in VMs
will be the hacky copy from MSI-X approach :\

> > Thomas Gleixner has done alot of great work recently to clean this up.
> > 
> > So if you imagine the driver is fixed, then this is not necessary.
> 
> How so? 

Because if the driver is properly using the new irq_domain/etc
infrastructure to model its additional interrupt source then this
patch won't make it work in the VM anyhow, so it is not necessary..

Your other patch would be the only short term answer.

Jason
