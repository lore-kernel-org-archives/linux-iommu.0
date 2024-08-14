Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25460275
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675250; cv=none; b=FfBsP4uN//VZ/Psq9dI1/9DryjRMDBFZjm+y/DP8GllmkA609KC+J/C39a74hmOudD8VIhhY91QHbwkekibAHk2MjKgwPMKAgqRz+RUfYRNC8PyKshACITz9Nnb3RHUoDsTmgybSQmRpotHr1FIJB87bRwrYg8uWRPdnPJQB3HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675250; c=relaxed/simple;
	bh=T645LNoYJwSO3SM5WuwT5ypfGy+2vrT6JkaBd0uWwUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJNZSIN2sMCEEe2+iNrGLD6zvaC1DqLVnjUfwi1Fdzoh22WUyY1Cq9xlxLsa2w5mqbN9scJV2+8BDoRsKVeYOUIzCDzZ9AV1iCQYIdFfxZQOO9e1mQ9LSmA6lztO584BEsJjKzGdIBT3MDgO5sNcGL/K9fnAbCgiWCSqTzC4uPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=izE1YZoW; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="izE1YZoW"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45007373217so13061591cf.0
        for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 15:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723675247; x=1724280047; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAwNBtNrMTQdGmlgaxoc0pRVgpkyz+qFvmmOMLFDKJE=;
        b=izE1YZoWmup6ANUaHjS1Z2FJ6oMzhAh3w6laNvU81UzGfaBAZ33S71vlk3jqDXvWHQ
         36NDTvg25AVfYGImaFFlMX/37epa4glbeVz8OBLjUdBw/4qtLIyVN1PEsXWf3X/TMT9Y
         URHeBbs+vpVIRUTDzvqSvEuejJsP1rumRbFlNqenHI4Isd9kGpxFUqExRWYRQZFj+nlW
         2qV+Pm0Rf7V0aAkqn2qH5e2SFkuy3ytILzTDE17PgARMmGiSJ7uppx+1VjWani+zwk5q
         gs6+HUxedsGW26QpPEsieuIn3I8fZUuu0spw3DWd7CuPEbqPDM/fsrxurmSQgtwMRwLh
         9iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723675247; x=1724280047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAwNBtNrMTQdGmlgaxoc0pRVgpkyz+qFvmmOMLFDKJE=;
        b=Bwir1ajHjTKN70k3pRCfLXVxO6mH11POFvYKChphHJ8xoxMkoNkb5zSYyIKOgpm3xX
         E2hTP0Jl+xjbvjCbRUi2uysoNFJkGQGha/eA+jgT560Uyn5O7AidMrHRU6+XPoV6XWGc
         sSGviM0+W8XXv9sYGY5TebPDx91T/lsw83SpmKi1VX9GvQWvtBYxhLrWvGwaGuzkczs8
         +QkdVKfAB+pixSlSjiMtDtcMU0Z0DdJUnTcpjzVLn1hofIAVl7rxHQTxKbwsiUnC/ryB
         ATQi3Q9g4ApoZPYp7E/2dk+Rm9ASpOXRz01cr8BCKUBKOrjlUrbxTw0s+n4hMhWtDXyT
         TUWw==
X-Forwarded-Encrypted: i=1; AJvYcCWXyOfElYBq0xi65PqWok8At8B6zupU6pUCcYdesiWa7FKRvVraTwsHFDO55Jml/0PwG6N1Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyx5tldfrSOOmRrF2WVkUdppQDqzRl0Ua9YkulQ8iEBq9/2YCyc
	iJtIxBK8MD0qK7HVrt88Frx1U7A1biSjFBL5hDJQRFSSARHxI2BRx3vOKgIHvT56EroLKFy6XPK
	J7KM=
X-Google-Smtp-Source: AGHT+IH+0yELuvFEo0w41yyjcwMv0M90OwtIEqdoJxw4ADJeq9GV31fyi6kEnkv93lagkHfROWmACg==
X-Received: by 2002:ac8:7c44:0:b0:447:e6f9:f61c with SMTP id d75a77b69052e-453678d7494mr29532391cf.22.1723675247220;
        Wed, 14 Aug 2024 15:40:47 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a07916bsm1000941cf.94.2024.08.14.15.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 15:40:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seMfd-00GgbR-DN;
	Wed, 14 Aug 2024 19:40:45 -0300
Date: Wed, 14 Aug 2024 19:40:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240814224045.GC3468552@ziepe.ca>
References: <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Aug 14, 2024 at 02:38:58AM +0000, Tian, Kevin wrote:

> > Flags = 0 means the domain cannot be attached to a PASID
> > Flags = 0 means the domain cannot be attached to the RID while PASID
> > is in use
> 
> From my understanding there are only two type of formats so far:
> 
>   - a format only working with RID (V1 in AMD, S2 in ARM)
>   - a format working with both RID and PASID (V2 in AMD, S1 in ARM,
>    S1/S2 in Intel)
> 
> With that in mind we only need one bit to indicate whether a domain
> allows PASID attach. The user learns the PASID capability via
> GET_HW_INFO and should set or clear the PASID flag consistently
> for all non-nesting domains attached to a same device (RID, or RID+PASID).
> 
> for AMD/ARM this consistency is mandatory as one device can only be
> configured to a single format. no mix.
> 
> for Intel there's more flexibility but I don't see a reason to mix S1/S2
> between RID and PASID, and now both are fixed to S2 for UNMANAGED.
> 
> > 
> > The core code should enforce this rule always.
> > 
> > Above that we minimally need
> > 
> > Flags = IOMMU_HWPT_ALLOC_PASID allows the domain to be attached to a
> > PASID
> > 
> > And you need to decide if the RID usage is bundled with the above as
> > well.
> 
> A single bit IOMMU_HWPT_ALLOC_PASID is what I meant. Setting it
> means the domain can be attached to both RID and PASID, i.e. RID
> attach is always implied.

OK, lets try it like that then

I also know of no HW that would need it to be different on the RID

Jason
