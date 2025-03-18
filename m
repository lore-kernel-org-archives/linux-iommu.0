Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF91720F077
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318296; cv=none; b=XFVI6iGfszzrX9uUNrSM2H8EjsJ0baG3orX9kpyujixQQq2el2E2qJl75sVcitV9yr8bmHxjqDdL/+BzKT79WKogkdJnCHc1uoKVGiAACo1reIW6V2X2oQt52pbFFYOtUn20WdAN0bl5T4UFm87REfYzZB2Avvu/dRKJ/TtOmlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318296; c=relaxed/simple;
	bh=QEWLM3try8BFOfb0hCqCyn4r6xpFo/2iqPmnsc43e1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEO6Wg/6EmsBZC9f2p6UZSWOIUsW/f6LekyFy3SoLOwA/gKyjZONLbVjCsGNzZxDL0qCqTyFamYpyRV+MFB9dTGjnX+sbrt+kOEpxjYa7OircYeOy0mM0Q9b+qOnufm7HXCAh01tl8jgNtFBgHWAC/HveYsugoZbE2L/KRNLfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TEpuqKIZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TEpuqKIZ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso46769036d6.2
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742318292; x=1742923092; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xV86r/eZWjKW7XqjYV07ukmPGBQZRx/NYw7V51LYBuk=;
        b=TEpuqKIZfNpcdiYSUKce0HdvNyvDp7DtXpw98KoQlkmY0hEKL8dNR2gGSGgXfjMXmF
         sRIxkeT3gN5Pe0P9Br2K2wcwjmt4eu46UHeMH7+z8R3Z3GbBMdHuGf1jN9FFnzpKYgVu
         A57hrW2JPo/amGWj13ec1kIjC0n9jJgAaqGkDgquqTc5J550IfGXcpi+5NiYUw1rGYeM
         FKLQ1rXoqXsIkrTMF4iken9nsaLSekqSjD0zivua1XCiWK7gNj42M+8wyzfMOWkv78U2
         F2R2PE7C/hzH7yemgkMiu/XEnD5XMSGD9jz9lYxkHmIAlTZPubNHELz9OHrmlUcotHD8
         Phxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742318292; x=1742923092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV86r/eZWjKW7XqjYV07ukmPGBQZRx/NYw7V51LYBuk=;
        b=GWwNWEJ1dkOuDfBWWSEhQlJ+i8dPhSePsWh6dZdgOsPoxugQsd5BGpyI23NwETRgcp
         iefIsfiDSsAcjUuKMQoH59Me2Fq/x8UBB+q4zGkKXfLWnahJUOqs4PzOMaGcMO0BC92g
         mglxdMQ8HJb7jTmTWz5gu5sp/J13OH3Sj9j81YikEKQZS4HoFVNLkf7dTGhWveV7tKgV
         frveqzzTv5xycK92SIspnxhtDJxeq7wt4RUgYPiDHZ9zpbN09EMGPZ7cs22I/RzcYZUB
         I7wOGyNQPpmuHJcUSfXDLNgMaAdwLlpxWa+TA8x/YvH7zKCXmmsvnKMT8Uvw6R8uQZMC
         FZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCXVrVv+W+K2SbO1JO6m+tFu6owkBuPXDERkhVLG9mRFdHZ+0Dp12IejERfwnG46pjAYAu7G1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxAqn9A46Czg6GL0H6vd74BEf4+gBmfBcUaFWs5lwCpsEuQzH8
	tyrzpceieiUT3Hx7Xhigb9bFsJ1wtbrbMboAF3pr4MJJeBleI9AsMv0m8XB+138=
X-Gm-Gg: ASbGncthNWjtD871WVfDGWEcaHxFW/2oGVOzP9TzIbESU0a+6PgjSCpKd1KqR6ePotr
	T2FigRMpYdyB/OmmhygzjXC3wykEhZtUEEf9MKWeGf0EF122NxjlVb1FQWxA2xszFB7EkBSUhJV
	ygT7G9BwMWJx+S415YupAdy+BTNIUXq/D7xy93bd1Y3TcRgdw7sZydMtOSJv9BJ8RHRuZAztRpl
	agAA50qtmU6Jw698pDcI62ZSJMDLE4IswNS61KGx+rIvr5+Ixo2h+/NYDo0S6MRZhjrKp60PTnI
	CZXlXFauf/M2dEIODu6PXKw+GdnL9WqqCOVRfpzQHIWu4Wrs3XddJedsW8C8YqGBB2EEN8TUg1E
	zNpmebYKyMFOhpsQDrQ==
X-Google-Smtp-Source: AGHT+IFU/ddYVAuMMenO7VlAxPQQ9dcNFAQmMEDqLtugFL1HEP8Vt/lqWihixaJ7+pL+zIsYy+bfcw==
X-Received: by 2002:a05:6214:623:b0:6ea:d046:bcc9 with SMTP id 6a1803df08f44-6eb1b93f807mr49795816d6.40.1742318292591;
        Tue, 18 Mar 2025 10:18:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209beesm69900566d6.10.2025.03.18.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 10:18:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuaZv-00000000O4o-1xAe;
	Tue, 18 Mar 2025 14:18:11 -0300
Date: Tue, 18 Mar 2025 14:18:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH] iommufd: Fix vEVENTQ kdoc
Message-ID: <20250318171811.GB10600@ziepe.ca>
References: <20250318163022.709490-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318163022.709490-1-nicolinc@nvidia.com>

On Tue, Mar 18, 2025 at 09:30:22AM -0700, Nicolin Chen wrote:
> Fix the following warnings in veventq kdoc:
> 
> include/uapi/linux/iommufd.h:1024: warning: Enum value 'IOMMU_VEVENTQ_FLAG_LOST_EVENTS' not described in enum 'iommu_veventq_flag'
> include/uapi/linux/iommufd.h:1024: warning: Excess enum value 'IOMMU_VEVENTQ_FLAG_OVERFLOW' description in 'iommu_veventq_flag'
> include/uapi/linux/iommufd.h:1120: warning: Function parameter or struct member 'viommu_id' not described in 'iommu_veventq_alloc'
> include/uapi/linux/iommufd.h:1120: warning: Excess struct member 'viommu' description in 'iommu_veventq_alloc'
> 
> Fixes: 50c842dd6cd3 ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20250318214534.5476f9ed@canb.auug.org.au/
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I just squashed it in

Jason
