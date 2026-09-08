Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CE3ABD82
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898616; cv=none; b=ODucmrJG3brDKJmKMgVrjAtvxPq+hMaPHOqf4/gqPKJ+qUSE/8dAqvTiY0eYNg0IBk384EcgWfILvnHB2Avn90Cocb+dOD8Akl65QKtlDPhBs9buhU7ydUsnxvKf2osKKzxMHqZkFY++M1Hjoofb1AAt/OUiAv5MoTDkU2kUpBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898616; c=relaxed/simple;
	bh=PiVFDYmKertMElRCqrCPSg2TbK8dG/IhUemfZpgpssM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFIIpRxYHDMV70L6TuqBEqAzVH5hJqOOHZPwCw9IaacB4RPPJWlWzyzf4T58V0ziqdhfC0T44jtpba5CHRM+0jZwZBjmU4eED+3IErv+jrvHDeIGDjAbTo3zbcVKRNNyWhK40mAbDotqsnTFPXi49dpZpVyh/4zayX0fxT21yAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7oVPURP; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7oVPURP"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so755ad.1
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788898614; x=1789503414; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=31GHQPHWBGAHGW9onfV/wzjD16/j2GZDSuzniH4Q/3E=;
        b=n7oVPURPpqLso2HMxjf+cJfH8+j8KrbHxt3Dq2NFJuz+xRQuRe8vXpY2rUVmk9c9Gb
         +Vg1yxoHPZNOk1AclomED+jAVvf8UVoIy4EBhgsq5tAzM9jqKaPhXliwEYSC757+v0Zq
         YB1DBtuaXW5VIpqCqWrARgmRjIksDfgMcNu5x1pnFAKGWuNITbuRpI9mW6iT+JVQrnfv
         IeAzwjkzy3hRi7W/783Mvg8V4b3bffRB6UUAdt5y93dzdUza6r1/5visv9FWKLx+wQre
         BbgYRiSTiH7gi0q+UBUCUrK9NlkTsR/v6KcXe4qNiWEuZ/isrtO5MwFZp7lZXfV3kBdR
         9ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788898614; x=1789503414;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31GHQPHWBGAHGW9onfV/wzjD16/j2GZDSuzniH4Q/3E=;
        b=TsQj4JpvEvGHII0AF87fZbyUc8o/1O+OuRxoUV7S0mKwvE9g94Fv52Bd6IDSaYZ6lr
         xoALnrGiZQ59TUksPrMuUNgN/P4XW23lBh9DKHICbCmqWxbqp2FXlNgTj0MEVK0DoHCe
         mF8KZowdNgezXX28FjoH8OilJh1NJo/2NHmwkZlok/XwpPPS9U31PwmAnmfRKt5YZ7ZD
         YZAUW44H3cky6NO059ijU9GlpqztiR+hXcgB3wMdtge9c2i9F8SzHi6bZUbU3PL0OKpy
         jGVLAebKfamQJ0sRRmVHJAfqc4cdqii16CO8btiCxW/QxhSDRDoILzDs/i4EIUZV5oEO
         hZ9A==
X-Gm-Message-State: AFuF++loZ8CIp/yKf/M53w7xN7hsd66x1xPQ5yAEt79tN+73MZmzkdJT
	Eucb0FS8KlEzGMm62LQLiG8qOjeVurvsQzuQhMO5HCUEeGA583WJ5/3pQnCcs2CE0A==
X-Gm-Gg: AYBFou0A1bnKM3H7Qej2qygBBytkUG3HLnjHet7fL47HcjCvsWgVpX97l6QWbbLW4CH
	Re09Tz3lnM6W4TegMRnAFkanLSfpj3nABRzkxTi36RgqFsG8aGjICi8glzELAzR8k0EseJnECzi
	hF14VaB79UWgC4MSVGZxc6hALQtnF61hGXLjJ4DWc+Leyy/QfDK3CksWBBxiSFf6KDioFtItTg9
	/7qs/H2RuakAPh6LIJISVkzV/miMl/cqn/YnxTPqrn5R5nPXfm7XE0WTMOf/aEJVhdwJVnLFMWg
	AJX5fF8r1Yl924eQYojElr8URkCJLV78AiUBOuSGF/nEhN04OKP01z9v0dMzzjshYI1AdezmXFX
	xppwLqFrT7NO4DSRKXau0JOhCWzZpwb7n+9EQmhX7dkkSw0VTAM60Qa0rDQpjur3uVb7oOBNmAW
	SRPZcZXZ6XsyusLLJ3rH0aKcFDwwUD4DQ6Vy/15Pk0B05/dfJve39RWFEef3vpyrp7CbiGuJJoU
	7ktNYoDWPE0RPXUuCGbb4yr1w==
X-Received: by 2002:a17:902:f641:b0:2d5:c090:3810 with SMTP id d9443c01a7336-2dbddb1e7eemr1343925ad.2.1788898613709;
        Tue, 08 Sep 2026 13:16:53 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm35571770c88.11.2026.09.08.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:16:52 -0700 (PDT)
Date: Tue, 8 Sep 2026 20:16:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v10 07/15] platform-msi: Introduce
 platform_device_msi_rewrite()
Message-ID: <aqBtLerHaWUduIxW@google.com>
References: <20260908171712.356645-1-praan@google.com>
 <20260908171712.356645-8-praan@google.com>
 <87se3j1qgu.ffs@fw13>
 <aqBs1Rzz_i1N7756@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqBs1Rzz_i1N7756@google.com>

On Tue, Sep 08, 2026 at 08:15:17PM +0000, Pranjal Shrivastava wrote:
> On Tue, Sep 08, 2026 at 09:40:49PM +0200, Thomas Gleixner wrote:
> > On Tue, Sep 08 2026 at 17:17, Pranjal Shrivastava wrote:
> > 
> > ...
> > > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Jason. You really should know better by now :(
> > 
> 
> Apologies for the confusion, Jason just directed me to avoid open coding
> this in the iommu driver and have the irq core handle it instead. [1]
> Jason had nothing to do with the specific implementation / design here,
> that misintepretation / mess is mine :( 
> 

Missed this link. (Sorry!)

[1] https://lore.kernel.org/all/178767577112.3356902.7778967514008843854.b4-review@b4/

Thanks,
Praan
