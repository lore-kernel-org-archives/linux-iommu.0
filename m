Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E7372663
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346229; cv=none; b=B2OyRw7pxCFBxm4AlhMpl3pqALbvbG9gTki4RAXNN8pQIS9IcYV/NFO4CS8s8w/WH3SJcElJ+AuLAtkYvnV611+BmSOYoa+nlP8+ug/Fuxpyyp3NcdGqXa9lBVCkXPp9C+rZ3akYfnbS6QTC2qvAiul2clIUO6jHHdGA0E59pM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346229; c=relaxed/simple;
	bh=XoQ5W2g/isa3ls7lIv2Ywc4hldYr7+Cn5pVaiQ2MZE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn+6JArnQUOojnKds92Xi61iR/pjYJ0oewjLnK4MMO0D5kQag/9M5yUoVW/Nuac+RT1S3E9lUZPw6VcEkhndzABcJTdKh28jQomxNOZm5sr1E6jXgbAJTcTdJEZ16Gb9I4r5T1F7/jqAwzsgbLYCS6AC0hpTuBM4MBF40Zr9msY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WTqtAnMe; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WTqtAnMe"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b5232009a6so30190876d6.1
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778346227; x=1778951027; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8mn2kjAcaeBMh+gpou1r3QDxvcT8ZpaHOK5AzbQbeQ=;
        b=WTqtAnMeEv/YlVzIsC9iUdmMYhVwts/hx6PLGL2ORrqx0NmAup3vIhBnUtifYTqNxg
         OT4e/T7CMDwp2nO79/rxST17Nmnrohf4TUO5kyM2J7Bcckyx5IVnwOr32Ve97Ay1j3jF
         qnFwa9wmZu+F4p4Ol/Odk4T2iu7O1Tsgb0KJFxnLU574VEN8Q5fW55Tz/GUyW1LMO5BQ
         +LuncxUhrefBbIOT34PH7ccaYZdn+vlBu+qp1dRgI8ulfvN07z/j7cZGDwF4QoewO7jb
         mqwLtitYGIazyS+wQlPBpWQAs9TtdfF8MihW1MyLmlkZPrEndn3KlKQPfVK/mHFxydrF
         LU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346227; x=1778951027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8mn2kjAcaeBMh+gpou1r3QDxvcT8ZpaHOK5AzbQbeQ=;
        b=sQLe1E3oqKlCospXondtoPwOLRtenQEd4sYJB2M39Q5eX2UR9IfdEL9MvvXYuptx1U
         +10N9M/VHfoAU6XBf/p7iBXoP1CD4DAQnl5rdfdEtzcItw+5Coxd/sq/L3DLIAFTN/lK
         pfD5w8es3zoObIAcoeXUXjyyMzAC0iTK2YnUS/BTzIG3m+8PmfKkfYuzytIahaw0O4pe
         mZZWhzSp4FoK2XCIR0cQknRpCjnSaXTduSzN+JZvmFSu7ghVMZaeTc17ZFJwg8p5a99z
         jHuoOUGN9mw25ldoAkGYkaPmGTqSzajne0OFppPcMJDRiwmbjHCEUntDzVvrfD2Hor7A
         A51A==
X-Forwarded-Encrypted: i=1; AFNElJ+MGNCqbm/RsvC25Dx8Zn++bMW8tM+q6MJcvMTEFl5dP42TZaQF/O/npaKGixUKxqVKnCe9/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw73ZAPon+5aScYOXSi/7MH4XE4tU4JkZdjJptPG8FF7SMX6VbP
	/LZk37nKVhHxmyIjK0ZfbFtZUjCarjEgulQG85ze3rSFjieBUgASc8pk3iLBNdbS2gI=
X-Gm-Gg: Acq92OFprdsXP+fox8LnCSeAXFYc41gXZFPKNYgP+yX8knMn4/YRYck+zSTX/U8WHtH
	ymHtT3X5B6W186QssqqcbpJ+N8lsvQeFxI8ae66BY3GxosG4ZI2VAP8VMNNplUKy4WF+NTiLOTx
	vigj837PtUUn34UNbHZw3jM+mGsYUxtx7wfsg+9auyCuLxXwvaruXZt2BY5JKxSk0qSHWh3f8rx
	WMIFBy5PD/fwMbk9fkEYfGGeldtOIKdCS6DIcenDbx5Mx+Yz2Q3cFfuDURb+pIMeTAWecL2T/iP
	qWJS7IsiE1lbCd040z9XdJkXWB0wJGA10+CsYbnqh0U5pKiEkfOFkJJjPoK3o5nd7BmdWbBXoVa
	aE1xAp6K9Js7KHvxfrd3H45gbqKmMS+t6Sr58k94fWmUw50i2eOiX+yTRKyGXsV5nZAEMPQacBj
	5ATutYgIekyDo7txWWGmZILCoNmJ+0cAPLC3DjNY32x/eUUrgij8uJiCbMlRGoJ/4YuQWMKyski
	iuzUA==
X-Received: by 2002:a05:6214:3986:b0:8bc:81:c1db with SMTP id 6a1803df08f44-8bc45e1e978mr276779406d6.43.1778346227366;
        Sat, 09 May 2026 10:03:47 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8123sm262540686d6.35.2026.05.09.10.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:03:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLl5d-00000001qDf-32X3;
	Sat, 09 May 2026 14:03:45 -0300
Date: Sat, 9 May 2026 14:03:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Joonwon Kang <joonwonkang@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"jpb@kernel.org" <jpb@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"praan@google.com" <praan@google.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"amhetre@nvidia.com" <amhetre@nvidia.com>,
	"Alexander.Grest@microsoft.com" <Alexander.Grest@microsoft.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
Message-ID: <20260509170345.GE9285@ziepe.ca>
References: <20260424085339.3503582-1-joonwonkang@google.com>
 <20260424133953.GY3611611@ziepe.ca>
 <BN9PR11MB5276E9D968D3738CCE7125248C3C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E9D968D3738CCE7125248C3C2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, May 07, 2026 at 08:15:21AM +0000, Tian, Kevin wrote:
> if both arch and device support enqcmd-like insn...
> 
> I recalled this was discussed years ago. For devices like this, just
> let driver manage its own pasid space then have a new interface
> e.g. iommu_sva_bind_device_pasid(dev, mm, pasid) to use the
> specified pasid.

Yeah, that makes sense. If the driver knows it doesn't use an ENQCMD
like programming model at all then it can use this API and it should
also avoid programming the MSRs/etc.

Jason
