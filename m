Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D413C9C4
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525250; cv=none; b=di2afKye99DuviLkGi+iyZXYU4T7C4wp4/Q+cyX+DM4iOLPDLKWO9vE3trSbQXDhJykQVBp0EOVTBf14UiTRGeGQhK9F6HI26tFHr5N6c6thU6KA8X5risdu07Bi5yZzeb4SbSPaHF3jTFbqEQeOepcnZM76UsWqRQ3fR6QhX18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525250; c=relaxed/simple;
	bh=BjUSpePkCkB5vmcWx47KtX+UK36OJ3lAzsPDAAvsUs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM3ABymxH9IC0CrzsmbzpJK0SnDne5avNLJXJURWXtmDcq6ZMc5btZZSycf+Fm+gqfykXNs/vdzTU65xw8+OVx76YQdQb+7ylDeJNMymUud/qjfzRDuVAcW+puXg8pqOEDwEPnUli49u12ZdpDb+xdwi6t9fm8yQrqySiuxqUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BxWzFOdw; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BxWzFOdw"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c6f21c2d81so405569185a.2
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 18:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775525248; x=1776130048; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ixi2satCCLM0zP4HwmF9jYvdrFPFAVdMFkG7x9SwdJ0=;
        b=BxWzFOdwY0AOWUfJQkT9U4JW1tQOXnkfmUpAQddopk3zSimxWzHirXxnfZy2gcwJI9
         p8YaG5WV9C/PWND984HGJ4taZgPCTGvwsnJRxBSUkkfvUb6QXsefJ2OYu10Fi+jvE7M4
         0h9znjfShrzL0zz+T3cHSSbdCn93PX36FrlEdggo8/r0369HFoqaeasSXnKhKjNVTrkv
         qJiiANsKfF00VfY0MnNl39Z1NawXosTQBtNVGACXWaUHfAkdn5FC8czyXsM2PZB3pWHp
         i+6XQsKjMP2sF2aD9/BagzIuUMfOB7nu1NxWMDIq6KThlPRwtDAWLNHh0gQbcl/7dq37
         zVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525248; x=1776130048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixi2satCCLM0zP4HwmF9jYvdrFPFAVdMFkG7x9SwdJ0=;
        b=bJfAxlt025HxVlecXfu6FunkQD6QmeiMrpbBrYa2O8IzBAnKUj9CxT91Q/ZrnJB5mL
         KTLhWAzPFZUA+SlvJMXpBBX8KghfJeyWNWxDvwhLJw7lmBUoKTKrTeUjciPimdksncay
         n97Pl72Qhbi+gjRiiHG6vL0Q8zuxq9qObkdPt/s/+yvv1c2oNwKtRWUKhskA5G6CD67o
         SzMsiLpmVpLlOg1ULNLYUjyGv6pDLmInsKZHBOqtqVEwzL2+55XAq+6g3rOmhQl3mLfc
         A6c8/Xl8qVpde0KXu8AE6tenArzzBfS2ky5zP7zOqKLrzWI/FG6ai10qE5datmBLp+xD
         BRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUozosBEtcet3ukkXJgfAhWe+LFJ5mMJBZ5WEmi7dnRznQ9LFlaN7HzEQ2zX5+z7zYvx4O2Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzixnrL0xSAKXUjdjzpIcGCB/svNk5XGWVcC+FT8Z0lsMQPR11
	WCZCiTbAS+VslFjhMTdih9DTqS4abMSwzKtn+NvC5M8NP3Qy590BCI/Ob+a7RKNuFyQ=
X-Gm-Gg: AeBDieuoxZpdbevlqlv4cK/x773BBncBdHVRpxvjCx12sz3kVFp33SLm1FooWM2PiB+
	pPbfPPw66kf6t38GKSQ+2LflUt7ZJsqRY18G4rp1sKZnthoV0h8VbHPk5USRgIGCj2df5uWUxu5
	XQvHlNmwNYqtYaTgciWLRWjYUgUahH1/OugZsKmAlU2SsbRNKT/516mH3HEZ+q7o2a6DY3frY1W
	e29gAkK0G0Jv32xNCqSfmv7YOCzmWw6RxzEyMnk/BlQmzbCTDhRJFH7t04/c+aH+jjVWMaU0V39
	g5oj8WIOuUxrWhYRLejul9qkRFxj7FNY4u2cOnb5XyHV0T3RlHtXIUjPMWld9fzRg7jvZztUVVn
	apCVME+k6dR366cr0spGUP1f40JzIv+rAGI5nhkwV27HJKvobx3L2SFWrSweDZxZ2Zj9Y4YXBiZ
	Y6Mv+0T3khVPEXMpZiFHnjSvIY4WoqSaZChM0G+4TL75KUrFTsIvKHaZLoyfN9FYCS7SEhMHfVv
	WFy3NDK
X-Received: by 2002:a05:620a:28ce:b0:8c7:ad9:d0a2 with SMTP id af79cd13be357-8d41c3b5997mr2097077585a.22.1775525248097;
        Mon, 06 Apr 2026 18:27:28 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d5e69afdb6sm667396385a.40.2026.04.06.18.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 18:27:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9vDy-0000000EAWd-481U;
	Mon, 06 Apr 2026 22:27:26 -0300
Date: Mon, 6 Apr 2026 22:27:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sina Hassani <sina@openai.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aaron Wisner <awiz@openai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
Message-ID: <20260407012726.GN2551565@ziepe.ca>
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca>
 <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>

On Mon, Apr 06, 2026 at 06:17:24PM -0700, Sina Hassani wrote:
> On Mon, Apr 6, 2026 at 6:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
> >
> > > io_pagetable *iopt, unsigned long start,
> > >                 unmapped_bytes += area_last - area_first + 1;
> > >
> > >                 down_write(&iopt->iova_rwsem);
> > > +
> > > +               /* Do not reconsider things already unmapped in case of
> > > +                * concurrent allocation */
> > > +               start = area_last + 1;
> >
> > area_last can be ULONG_MAX so this literally overflows to 0. It is why
> > I formed the suggestion I gave as I did
> >
> Yes, in which case the  if (start < area_last) that follows will catch
> it. Are you suggesting I compare against ULONG_MAX instead?

iommufd does not have any overflows to 0 and rely on it tricks like
this. You should just compare to the existing iteration last

Jason
