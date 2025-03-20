Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B11B422A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509732; cv=none; b=meEmNwqDvLM/On/GfaNgluZVpZvvMw8MOb+8P/9VZVIs6nOyteTPgjYKCLDnL3STDWzAmhqCWyTDHdX6xg4skisc1DNtXG0mpdDjnafMfzHYF7ZMkGkxn+h8Gp3K34+6Hrr64eyfMqJYtChu9peI4EAauuQlhfk06BHibe/646U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509732; c=relaxed/simple;
	bh=+nWSMvYE2wpodLQpFrScJjARUUW9fBq4gkQeQD699PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KidXRXWBcuW73cHjskY+dyFM6UklRAkygbmPBZvubdnE+PHsEHkVHgsUdAXz2sIPqVamohX8F+pVrzSXHFHpB2MpWqsYlpBaoo76OIHManv5JRA7BvVGidS3DOf0UzBJnKLpg/5UwEKV13iP3lKz6SR7NxUH0oGwrjLD046n5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zxnLGfKy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zxnLGfKy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso24115e9.0
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 15:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742509729; x=1743114529; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XjkfpQmBtS8cWtPyNFX6dwhcnEAHJkCWFNbOaNTENZk=;
        b=zxnLGfKya/rwa/wSXDJRyZVyY4IPR78SqIA44bEgxq2BtjMIQWGFszjKgtQN92h2XK
         bPH1i+MG3T0BxOezO9xFv3wdrjrElb6WZTBsec9c0ELoigQBPCB7fazQbhQl2lbaSsMb
         8bkZy2h7STJWCQHap05bK2Kxp+58YTsvAA675Qa5WzYhSH9k96h5xiEAos1MNUj2edgn
         oEGDV1/wygmsrpPCbX7fl7sSjIhot7FcTpFv29Ks70BJfD6+QhRDSNXjF3cbqWZj5aJO
         uKfhRifO11GkIGWLcOOxXse9QyYT1DNStFVSEaSKnzu/SfzoAez0ARIuLqR6Dd37+eg0
         SViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742509729; x=1743114529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjkfpQmBtS8cWtPyNFX6dwhcnEAHJkCWFNbOaNTENZk=;
        b=W5EknDsoyP4mxJocCZsw1CuNkLtmxNObgfm7aQb5cIpQXLl70oiSyCcPZX+Q7+IWRd
         gG/ddeWBAL/dvscHH/mLdP9gnDEVNwUZtW1eew6/bcGJFX1WXDKGvoKCD/LM8PNiaeAV
         wH971ieN2XSoMuc1eUlughGu1EJmB1l+jfTRqvPeo9mrpk8mpAa0UFopm7S5Kl53xaJa
         mhVPSBvP9eUyMrJ5DFNJyPMuD4IABSrxodSmAAlQEwyVppmZuD1Kx3C08Try/nfnDFsF
         qfIogv8W1vjxprbm2x5oX0YD9Q+UHc31zmggk6Cqxn3On/B3kBGNPo/IO6pLf6Xnx3S0
         jkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYZdZ089HAJ+nYZG14axKFFu2er+/PMgpF08YveyemW/qpzOaFmnK66ODZgI31PoFfXTXYpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzE37PIY95TE/nj4KTtg4Sn5BT0pI98DDh2nr05fWLkO1OKwi9c
	k8zhTw3g7r8yReq92AvY7VG3bHAyTX6CtkzOUpE4TqaDlhC5+zay7c09bRU85A==
X-Gm-Gg: ASbGncvoTd5IGRDNOy9i8h5Yas2F48JS0qzG2jZAzz3cuW5CIrzNxD8s90hbAx9sgBL
	QfslZKsRLqeEH2lCFpd3LdPTKrZMFbhbdmsyhr7UOWB1sqkyfSSU8xcSIaQG3wUDNSXdvGA/CWh
	O7n6pAzQ4e9BZx4KIRDetQ2iqTIjVyaHj/dm+nw3KLIq4Iwdvs8mTQ/HEnITCykQF9gbGyWRCRc
	jedtKMdClLzE7itWoiPlxJPID8hKa0gJVboPwuHKlMVFE98Cc2RoUzHTZo4PBie7nXwtUo/CXEi
	yMeVJTYlW+shvtEp2RjsJIF6QPvbuXYfomQkh0sd0S6qX7E/czs9dRaEeA+aFCeAcwXUW94QASj
	ZyfWE
X-Google-Smtp-Source: AGHT+IFnFy4rSuaC1XYydPHiCcu+D5UL/rEmdmfBoCKnCyt7j6f8mygvecDmgA7tZpbnzYgm8CDYrA==
X-Received: by 2002:a05:600c:54e7:b0:43b:b106:bb1c with SMTP id 5b1f17b1804b1-43d507f6cfemr327905e9.0.1742509729316;
        Thu, 20 Mar 2025 15:28:49 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb06b9sm9241735e9.36.2025.03.20.15.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:28:48 -0700 (PDT)
Date: Thu, 20 Mar 2025 22:28:44 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z9yWnBmOfeG-7rno@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319194609.GA126678@ziepe.ca>

On Wed, Mar 19, 2025 at 04:46:09PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 19, 2025 at 06:22:30PM +0000, Robin Murphy wrote:
> > I don't see SVA and VFIO needing any special considerations, so it might
> > just be the new vIOMMU stuff which may need to hold PM enabled for the
> > lifetime of things exposed to userspace.
> 
> Are you expecting that the VFIO driver, and whatever driver is
> managing the SVA will keep the power turned on as necessary then?
> 
> VFIO is not going to work if the SMMU power goes off unexpectedly
> while the VFIO FD is open.
> 
> I suppose VFIO also can power off on-demand via userspace asking
> it. In that case the VM would be co-operating.

I guess VFIO is tricky as there is a security boundary. In case the
SMMUv3 wakes up with caches not clean, there is a window of time where
the device is accessible from userspace with old (or garbage) TLBs.
I see VFIO-platform always take a PM reference for the device at
open(), but I am not sure how that works with VFIO-pci.

Thanks,
Mostafa

> 
> vcmdq probably needs some suspend resume logic like the normal
> commandq.
> 
> viommu I think will only uses STE fields so it should be OK?
> 
> SVA.. Is similar to VFIO, if the power goes off while the SVA is
> working that is bad. The SVA requesting driver would have to manage
> this. HW with userspace command submission probably can't allow the
> power to go off while command submission is possible.
> 
> Jason
