Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9D12CDBE
	for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726407457; cv=none; b=TxqsmUfWPuya3WyhPTvDB9QTgZ4sr0dS7xPGdvzF1lvoi2lm8G5QP3FEetxZzbdJqp1/ya+y6kx9LIqiA5V0ymOp0+KmKasRlOBPRcOkWvfGFyHDqu93ahUd6mOF/5tMLUiC/q7eZfQl6C7/1r6w3PYan1fjwvTUrVNvTMyR0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726407457; c=relaxed/simple;
	bh=L6cmcVSm6s6ur33vGGXDnTAV40rwRA5m3muhdQu0Uw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzFZblFDSFqendDGHuaj9kUXlN03gGi4DoQuQy1vySaszvXVr6yPCcXVERVSIbR0nsTOlZCi7NtMPG4VheV+8IT6KYVZJoVEO1ybrUZfOtvpXoxrYiC/C9AJJoTL1rpMBlUhsiXm0ewDGyTXOqBxypzfbQNOXIfvKWhgitccab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G9URSDN5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G9URSDN5"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4584a719ff5so31220991cf.0
        for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726407455; x=1727012255; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJtqx75Y9mJu+/ng9YWrbJuiU7tTID0jo0U01oAXREw=;
        b=G9URSDN5DRAiFrU39p+w9o8VpA28YEcAdSQvFAu0Hwc5mufFfQiumYwqZv/rrMiDU9
         8bva+YmALO3F1KFP3QneS0QS4pCy637V1CjBSw0CrST+Q9/VwcMnheWYrp2iem44Uc5E
         Un3lbzBjoFJ22P+vJ66CG2Cf55TfJ1Ob80/cAUiq0ZWnnccxBEw5/4ZPq23NGg0ZVlFi
         l82YZmR90sMvYOnKvkqx1oMmsLzpbpkPU+Alk1EUjbOoDZgUdzbueuKd+9wYL1esedoE
         sYPjhR6et3To8S1Rwc7J2cjQXFu+euO/YmQ4Ka1H0ikQsYDdQab4iZ/T5SZpEDLk7M0H
         0Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726407455; x=1727012255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJtqx75Y9mJu+/ng9YWrbJuiU7tTID0jo0U01oAXREw=;
        b=YG0iBLCWcb6oDfbvR4qswG7YNLI69ByYjPNssgYxvo+ztLEOOv6zj+kDtQymsTgvDX
         2e/jCbEz/iy8K0mqlZ2gcHUR9f8p2UYf4gTRSQa1FvyWky1Ak208wN8sksWtggxFLX8x
         GClK0b+bAv21OjJuyrm7GbFsVrOZDeogCaVRfoAalYpPJxcMk/WZvYy1x5o4XUakaJdC
         7SotE72qGFM/YyvU32c8JPKZXo9t5KEhg74kemnOCuTydwv18usK6xhkfd+8P4MgApmQ
         wOGQkWhxMR51RVLy2CCkfLG8tdyULAwzk1rv58l/TdfoYHWTrS61UzgZEyec5ZYfqkwm
         ZC8w==
X-Forwarded-Encrypted: i=1; AJvYcCVJDdUOL61RCI1ADAQsX0YMCUbREGceK3o/swQd5bMoBZyKAQZ/B846E7WHZ1N1KNttsLUa1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzimKYvztP+uamFV19dFv1S88loOIsTSN2ny70bcXHhSmlRP4yl
	H/AWkoeob4BcY5NvtZN49FBMU8THdfpk03ESZ9097+zM38RlmzxnX2xyYRTK7rk=
X-Google-Smtp-Source: AGHT+IGJ/mUpSv0/GcRtAcb5ZNYaDe4lIMtDnDN+AsOyPpi1SYCFy++nuLWw+hu9AtRRNLvbm439UA==
X-Received: by 2002:a05:622a:51:b0:458:3207:4a13 with SMTP id d75a77b69052e-4586041ef4emr225680191cf.50.1726407455216;
        Sun, 15 Sep 2024 06:37:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aaca4a3dsm17953531cf.52.2024.09.15.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 06:37:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sppRW-007bBz-8u;
	Sun, 15 Sep 2024 10:37:34 -0300
Date: Sun, 15 Sep 2024 10:37:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 3/6] iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
Message-ID: <20240915133734.GC869260@ziepe.ca>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
 <20240904-jag-iopfv8-v1-3-e3549920adf3@samsung.com>
 <CGME20240907122025eucas1p26776e1be9713e21ecd4ee612e470d5ba@eucas1p2.samsung.com>
 <ZtxFAxM6QQBYVSJp@ziepe.ca>
 <20240911074059.f3i22vso6g6payrj@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911074059.f3i22vso6g6payrj@joelS2.panther.com>

On Wed, Sep 11, 2024 at 09:40:59AM +0200, Joel Granados wrote:
> On Sat, Sep 07, 2024 at 09:20:19AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 04, 2024 at 03:17:14PM +0200, Joel Granados via B4 Relay wrote:
> > > @@ -51,7 +52,6 @@ config INTEL_IOMMU_SVM
> > >  	depends on X86_64
> > >  	select MMU_NOTIFIER
> > >  	select IOMMU_SVA
> > > -	select IOMMU_IOPF
> > 
> > Does patch 1 still compile if INTEL_IOMMU_SVM=n?
> It does for me. With and without INTEL_IOMMU_SVM. Is there a config that
> is not compiling for you? You can send that you to me and I can give it
> a try, to see if I get the same issue.

Okay, it compiles, but it is broken right? This hunk just can't be
correct, SVM needs IOPF to work

Jason
