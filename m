Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336D1D6AA
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707354790; cv=none; b=uOK91hEaf/2oxlQSQPQ9cTjtyip3+k+9BHF+NyxEu7psDgfYcONlNQ3iUadGdD+/544MfE6uODyrKId7zYUxtznfoZoEdDgTv8/f3MEfrXGKNtW2ZV8FHw/7FEGvA7/X49G5uQ8e9NhrDRarFUCOnWKgTVh3yeEhdAQZIcXp9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707354790; c=relaxed/simple;
	bh=yScPOF8WrSenAGTUkyEQRqEcunLC5CJdwIIrDEnpy+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em63SlnIsrXDPlvOzf69MEzn/1OI+itl5KtoIgF22h/3C+/I7g/8BhxJT8uXy1hpNQXKrFlC3G9S3la0sMpsyqk56+evWSZZVVDuqauITruO4yQHku/2AL4KmDtH44WIZPTU2JAd8jQDhwjEUpT2Zrnbw8mK1XVt93XGcDqoWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oZZKCgC7; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oZZKCgC7"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ddca59e336so230174a34.0
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 17:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707354787; x=1707959587; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MLv8CAUfSagrlhodaWKNWgVzAaOQjo0pM5UtQzgUUQ=;
        b=oZZKCgC7mucpmOwrfYkoZ2aXRL8TsZetBlRQMph6N4IiJGOl0Bwi38aQbiHLKSParj
         dPbl7gjGKrRvVLX9Xt3xloHM5TjouLJKme2dkXyAvUurpKwReWuPGfHE/YutxPRt+w5R
         pRsrIj/zc7DAygjSaOUSkhtihMFJfR4NsIOvtENLrpakibddmFd6Q1wdN4RTKmhQ0IAS
         8mDAQ4sEH4sogeqimj3RcdMjLQVQ3Eusex/IISgYnIQw/2rhrSxZyzpF58hNUqfiiKuJ
         noDXhpyNTl3ivfCzKFDEe7plYYYyfyNPxgS5UPIWx6VMiZGA29u1j8W+20Ulkk27C12J
         HqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707354787; x=1707959587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MLv8CAUfSagrlhodaWKNWgVzAaOQjo0pM5UtQzgUUQ=;
        b=ECXmxyRWE/4coKyRJPHgrOzarKgMcGmBFEg0n2kKPf+bjN/DghnGAudAdJ/LNy2qQq
         yhiIvApRRYJT3r0icBvJ+gZQRCXuLGnKsm2oOxIlyDelmvv/IPHz0lQ1FTZqCZQGwoPl
         JYaTlmnlE0BaRzz2v0HAZVrwZl+58A9krLHnjFf3Qm3Dfcv4OOm/OL1oENfZWazUH8xw
         kBi0wtcIj40D9ULB60XFOKF8E+M33QmWXdCWdUGiNfMM7BAeXeuTI8X5bZ7ItyW/7ETR
         E3QCSCxDFvIntx58rc2kkfzyXrK+4eDhfGnCh1TTEY8WfYWuKEt9utjWRVl/oV2BHvZS
         yItg==
X-Gm-Message-State: AOJu0YyMBpBnNrBSVcyBeR/Ks5rsLSoTnGAPi41KfZXgWS0ftD3Ko8KC
	NGiCiO3eJhptmuzxAitcXERon5fZCZ1VEgPc4Mww3AT+/Z/cV7kfSJBfBwWoNoQ=
X-Google-Smtp-Source: AGHT+IHmcvbcyMlsNym9pH4+Y3ZNvq/GkFWDijh2Czdvifds6S6RPwX3FfVNGCZYcZuAG0BmRv+ebg==
X-Received: by 2002:a05:6830:4107:b0:6e2:b00c:8d78 with SMTP id w7-20020a056830410700b006e2b00c8d78mr675168ott.1.1707354787569;
        Wed, 07 Feb 2024 17:13:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5oA7olDzl/Cnv75qmNczwOe9W3QaJ/QKpsDbETKMj7yZ2DK+dXE3LSHpxq2XUcGA4+SAeSGPVU43vzi/aoll+xULrfmtTvE+X0u0WaZV7+GtnUUhJ43vqiwaiFKNCyhqXau+vPyIHT8ArVQJ3/swiv/bb+ooC/S+XfJc22Dd8qE3YJfukMsYb5smlctLZ7omLPHIHZt2MN+qlK/4K38Yg
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d8-20020a9d51c8000000b006e2c026aa59sm99665oth.72.2024.02.07.17.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 17:13:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXsyP-00BpUM-Hs;
	Wed, 07 Feb 2024 21:13:05 -0400
Date: Wed, 7 Feb 2024 21:13:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nikhil V <quic_nprakash@quicinc.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
Message-ID: <20240208011305.GM31743@ziepe.ca>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
 <20240201162317.GI50608@ziepe.ca>
 <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>
 <20240207145656.GJ31743@ziepe.ca>
 <37ab8689-5e0d-4166-bad6-84d3c51446ca@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ab8689-5e0d-4166-bad6-84d3c51446ca@arm.com>

On Thu, Feb 08, 2024 at 12:04:44AM +0000, Robin Murphy wrote:
> > Frankly, I'd suggest just proposing the necessary (and tested)
> > upstream patches to 6.1, however large they are, and see what Greg and
> > Sasha say. This is the usual working model they have, as I understand
> > it.
> 
> To be blunt, hell no. Stable is far enough from its namesake already; the
> ongoing bordering-on-ridiculous brokenness of your mainline changes where

What on earth are you even talking about? POWER?

> That said, I also don't think there would be any harm in applying this to
> mainline as a belt-and-braces thing either,

Really?

Now that you've made me look, this patch breaks the
iommu_group_store_type() flow both on latest and on v6.1 from what I
can see.

On v6.1:

iommu_change_dev_def_domain():
  
        prev_dom = group->default_domain;
        if (!prev_dom) {
                ret = -EINVAL;
                goto out;
        }
[..]
        /* Sets group->default_domain to the newly allocated domain */
        ret = iommu_group_alloc_default_domain(dev->bus, group, type);
        if (ret)
                goto out;

But this patch changes iommu_group_alloc_default_domain() to succeed
always without doing anythiing.

So this patch needs some fixing.

There is a very good reason the stable people don't like boutique patches..

Jason
