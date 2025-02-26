Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317C21B9C5
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574909; cv=none; b=iJVP4Jk+np1j1Z8icqgfKxy1T8RPz1uWXFxNYb6CJVUqs/0AAt081fitL2F+gYbWSVoyCaHo9kKvcwWSBDGi61+4Aj8+VU+m0WDAFPDNbVM7UvJ6n3pHcUh16pLAPxH05B9DiEqlL+PouWbfd3d+K5vU5G/NL5Z8rk9OfUQlD04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574909; c=relaxed/simple;
	bh=92Z9v+FLz3iTFKqi11NEu/EOAuseUTOKMZtf4ib2DU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADNUlZryYeWoJ7strhBoWska5XFmuh9DIn0prDLltmOYopJwaYcfwsSkFX9RdvurZdJHT5apB0zOYoTriXzchOnzVyPiS0K8/jLIvhq+eng73ZqIYcyoiU6eR3Cm7Ru4F/aBtV/AL4ftMQiV3jkKCkliuspS5lvDtniETYnrHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cKY/UUat; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cKY/UUat"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e67bc04a3bso73721656d6.3
        for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 05:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740574906; x=1741179706; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1OJEsJ85iudSEMsKBGGptZhNT773gneYq2Cu5+D0SI=;
        b=cKY/UUatCYWaUhLhKXMLk+5RPof4kDMNWm16CEhMl623R0mMiYxRIcX+vKgoU15Rrr
         ysWwZ3vIlC4IF8AI7nof23ssCF2OPUrgo4DMz8oUD8egV67SiANPdup3C9Gg7gjrlWon
         eNumI++Ucf3w2OxJKaPMMYjkBXBqRFlrDRdi6bcTkoQgo7YatU11cTrd2CfK8PCmo4eF
         K+1g5SiHWGA6AcrRZ8kopaewj47/RpEcMHKOWgAz6pQyWxErgRcUi6/cxryhRfYs8fIK
         GLYIekzO4XtJln5UESR4B3rWHYQ1G+SW/BsVncB+4rRPXCw/GLXvt/VZ25P1g1eEzwks
         1fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740574906; x=1741179706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1OJEsJ85iudSEMsKBGGptZhNT773gneYq2Cu5+D0SI=;
        b=GX7TWW95oiyiEYLLJ+6VkW/Ay3+nysS3ISW/t5gMeMdpeeRwHHRUY4gGBctrAEeMLV
         6lkCIFMz1QYjtmsOmcH1vXj94pOCkMRzU7jphsLAn3yc1arBSCNxJcGQxSphvd/nIOZM
         FNRTb/cg9tXFm4cB2ya+s8GHVdsJg9gQHgPCZhX+QJG/P+FvEp1v3K2vyxiR1y2fU6uB
         4Q5wnFo8PhiWcj90Hm/CntCiA687Bp7ReXCzL1qnRkDoPUEF2M80FBCW/6ZtnYSaxv64
         gN92Vpl4krjOYoU9HNCMvn3ci37Z9+WRHYppjxo3KH+bKSwhEq9u0EwJHEfyqxn2eEa2
         Y6mA==
X-Forwarded-Encrypted: i=1; AJvYcCWWSHYRpa5gzAoYy2Ua39N0Wvjfi/+XUoMbyzvoQQN2Ij4I2OJ4ikx+zHhc+X+q5z8Zd2monw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIVJU4Pr8d8eOTQKN7lY1XP59CF3WweFRkT9y5/nPyGLDOiTKQ
	6zwlzwx6KEloB1gflhngVD0ClhnOvC4fyRbaAy2O2a4TmwNuO25RxX4+qEEZpSrMmTX1MIK5i7C
	4
X-Gm-Gg: ASbGncvlSXMV3M5WEIv7UJDMiqFToT5ODR6dxcdy8MI574yu7qOlvQwPqtzhwgWtsb7
	1j+pEfmOXJIM9ObLBKkhJQ64fAm2xGRwTOty9QvAvHf9SI4YdZAs2/l5loFwqnMcdajJ3XZVaRx
	f20sds/jP6+Bf+/RT/X4Oj8Lvwe07uZLobgxwo6eoPJlwMkSxNsUDDvygGTygNhX+hJvlG+TNlE
	G+O/aridivrItUxkwKdrnFQa0lV6/LbE+5mQ0+lJvQs0CR4Zx+XClMv+8NiO938WkEeNspyqQO8
	rTc2lR1dFA/mrnm8MOtnBmtCT9V1iB/qNJtw4gosiInv7b7SE3X2sGEa1PXahyfckoIXUZ2b0Zg
	=
X-Google-Smtp-Source: AGHT+IFnshQ9Jnhe/llR3pmflQNhFNl8LePUT0anoKEPfTifcA6wwmexPymMhLKL82jbf5C91V8iDw==
X-Received: by 2002:a05:6214:2264:b0:6e4:42c2:dd91 with SMTP id 6a1803df08f44-6e87abafb11mr91215506d6.37.1740574906076;
        Wed, 26 Feb 2025 05:01:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b086e18sm21713286d6.44.2025.02.26.05.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:01:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tnH2m-000000007Hf-3lRD;
	Wed, 26 Feb 2025 09:01:44 -0400
Date: Wed, 26 Feb 2025 09:01:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250226130144.GE5011@ziepe.ca>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Feb 26, 2025 at 07:10:20AM +0000, Tian, Kevin wrote:
> > From: Vasant Hegde <vasant.hegde@amd.com>
> > Sent: Wednesday, February 26, 2025 12:47 PM
> >
> > >
> > >  3) TA is an IOVA and the IOMMU runs it through the full translation
> > >     to validate it. ATS is just used to signal non-present
> > 
> > Yes. AMD does this when Host page table is configured.
> 
> Here 'signal non-present' implies to support PRI.
> 
> But...
> 
> > We need to consider various scenarios. For AMD:
> >   - Currently on baremetal, we cannot enable SVA and Secure ATS
> 
> ... here it says SVA/SATS are incompatible. Any more background?

Yeah, +1. I don't know of use cases for #2/#3 without PRI. Why do you
want it?

Jason
