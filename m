Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEBB567D
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195347; cv=none; b=foBFx4CrEY5AwuPswUTVP38ESsX3as7197oRqCXXrsFrRiuZ7UNm+4uPZivuwpMq+RKp9zSLvYilTlbDFasjcZr9zpJdUGoSkeyDELW5fMyFad0z56n28xg2G5wY+mrSGkEGLMAO7RgjtSZW7P2FQyDqR1D0s9l/xZ+gY1U3o1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195347; c=relaxed/simple;
	bh=EJF56/ISeByhv3eQoUmgdSH1qz0eL3urzM/CwsD4n+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1UGKdvby7Gidi7D7JsJvqBV1n6J0+m1kfRO/UqcG8FI6892zpOqnJ9YBvJ+p5ZYjRY/TJFIoYyuo828jKYYTT0Bo+WGC9JNwh94vBjwaZmFV6xndQfZn2Xvi2qkfPEzTBKGyCuBB7x2E7u8de+9vFlytILDVrVq4jo1qqepsNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aF8JOMY+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aF8JOMY+"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e89959f631so55375226d6.3
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 09:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741195341; x=1741800141; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJF56/ISeByhv3eQoUmgdSH1qz0eL3urzM/CwsD4n+w=;
        b=aF8JOMY+XRYyvTEYlQ7QW1vXySHus4lWkqCCIE5bWyxiTPx+wTSEuPdPJIKKSmofwD
         L64I5aw78qHbkYdEsyLVzT2AwC+jaoZ8vc3AAfyZh0k3Un3EAl/S0nFiCQ47N+ggS9mL
         CNFuHEqtLuiEbmWzBXc0qSd6+/LImkIvBbqFFW8cBnBrN3G1BwhfYIOYfjKaXeUpeldA
         t/jrklVNRf1TMyqG0yx7pLIkwJIYbnDDT4rQ4DxrPbDA2/G/mO1uzz0AsaoHS4d576V+
         es163Pu5kd5ejYqRQVlO+Fg77FKE9fycxi+PyNU0YRB+GMdDWSl9ZbSCauQKaKskq6Bk
         czDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195341; x=1741800141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJF56/ISeByhv3eQoUmgdSH1qz0eL3urzM/CwsD4n+w=;
        b=RgBsco4o37AVt72SuuT8+8aiYul+a0Sbl6/41hGmYt4xfpMh2wPkLh6be8gOgZVrNr
         YPAAApu7VSyEoYJKurssCCRxj2DvhpaoRoQYtg2O0W9YK3k21uIom7HwJGB8BX10K7u8
         EgIRfoXg/XH4R8TtN2U/zpVhqmEp+mHfxslI4tBAIzg/gtRPgtz/lOfCe70nBDLsXfdZ
         XwwGFjLUxZTOQxW2N9yVf/2VwevRqVp+CDDuHkiJ+vv/5z3C91TTu/a96uLgF/RxH961
         FE4HpRrWRr1g1uEFBacA83BjptZFgSdDPe+NOMzxKLv2mIwavLhBPR1r/C0iXtzsWcp2
         KdZw==
X-Forwarded-Encrypted: i=1; AJvYcCX1OimNwdHwZB2FgT/IvwqVwOYy3ODrNKlJsPp7KSFfzrWmj1obP6Hh4QhWgB82NuAwQK/pLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdrZ6/eOeVU9TIj2lI4+QH9jkatxMdjRmS9Md9NPQJIjJIiRne
	gfZL0TLMkAUSXDrrsaxSwTOhYTIV51+3fAnN4yWHs41LWKyeFRObMjo3D35QmGw=
X-Gm-Gg: ASbGncsQsXiLkjdoDIsqw2VU4Wkt6jj7rf4Dr5tbhvHYoVNQSMHxDrG8Mduv+blBAI4
	239x96GwNB1+96YrA/ytAFFR4sPIccaC+URez+bR9+TNiPtbwLLaPO+V0Ngnrl0l2Yb/pPMrawj
	kT44GfqjQSrLBdQ96gx44dRQlkJeZJ+o4DsnJOjillHEgsoEAukxqy3I0Z5neFE5yEix/+cqo1g
	5vNGwpOcKlE4y2Wb0w8959sFMCmRnVN8RYVBGd1/weQ7tmiPQX1Rg//6FmLhREwAmY4AivFJVvN
	z77ZouMpeK4n5b/BSjA=
X-Google-Smtp-Source: AGHT+IFfmyk/kAeiUI1mC6yszgQXNi2xEnOtqQE+yyb3TZN+rIbWYNGbgphdyvlYK33T7Qn3QP8Eyw==
X-Received: by 2002:a05:6214:21cc:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e8e6dd876emr70457746d6.38.1741195341033;
        Wed, 05 Mar 2025 09:22:21 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634a77sm81344856d6.16.2025.03.05.09.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:22:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpsRn-00000001TCX-0nZL;
	Wed, 05 Mar 2025 13:22:19 -0400
Date: Wed, 5 Mar 2025 13:22:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250305172219.GF5011@ziepe.ca>
References: <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <2c9ef073-fee5-43c6-8932-a8cae677970e@intel.com>
 <20250304142030.GA5011@ziepe.ca>
 <BN9PR11MB52769EFA077B3E552DA4235A8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769EFA077B3E552DA4235A8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Mar 05, 2025 at 02:50:38AM +0000, Tian, Kevin wrote:

> Probably we may also need separate policy between unmanaged and
> dma types. In some scenarios the user may care more about potential
> ATS attacks from userspace drivers but not kernel drivers. In that case
> disabling secure ats for kernel drivers would avoid unnecessary cost
> of address audit.

That would be some specific iommufd/vfio policy IMHO

But really, if the device is being used by iommufd or not is well
known by the admin, they could set the general ATS to secure prior to
binding vfio and just be done with it. No need for more automation?

Jason
