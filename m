Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302884A3E
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027085; cv=none; b=qDum2DVWQNIvMdGzdQE7zWBn6eLf0TWuTeR3c6sOHTj0Z9amDsv0nX9OoOVh+fLynLsO71hdiXL8XLXvDEG1707mT1lPpaoZPbz2SqM2/l1IsEYeeqeKJQnl00kpCDNElJlZiPId5hMurFN0CpmXbInnASsXy1HsDaNN5c2IiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027085; c=relaxed/simple;
	bh=z9hqp3bZzUK4Y7/LzTQkgGop/aNojhtRTd+vGhvodmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcyY/lYw/8EIKh/jb+682YXx7E5N8L8ql/w6GGKNuJuCBZ/l/cf4qih1vE1CbykpqVsNEhFWshtYG6fncvDkeeB1nP6sRTCorKm9c6pShS8F1HWkwRTlwRM70fxecTkeUyTWwHiYkl43stRRZ14WvDQHHBih3zUEzxv+LEsPol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PAzmiD+l; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PAzmiD+l"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e88f3159e3so38935276d6.2
        for <iommu@lists.linux.dev>; Mon, 03 Mar 2025 10:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741027082; x=1741631882; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9hqp3bZzUK4Y7/LzTQkgGop/aNojhtRTd+vGhvodmQ=;
        b=PAzmiD+lVPOXJOlpQYSXTbLZSIihnl6W9HOiieO/2v+uIjEBy3ck1p0mVFJ0LK/4+w
         bckYubqSmKUVjQALTm692x157sD61rgIvhDJLVb13UlkPYb35WB8L1i0qjyYYO5YE6kX
         SmPoqTUE3aGxZyBS53aqrIOdSHBS/kKBwmU63Venj1D1ui6IjnEPgE9Hn8vKST9ytltX
         4ktpD0PIf5RFD/Heiq8+0JGcgktr3zpVMTZyEumfi7k/jwYXJRhJaOWKbzll6AxlkG/4
         IF6YztOKLVWs5setJpyZUHnql4EVjtxqE8MJORQS/J0Zven/soFOM+i3qJic6OmL9S7u
         EPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027082; x=1741631882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9hqp3bZzUK4Y7/LzTQkgGop/aNojhtRTd+vGhvodmQ=;
        b=WyqFkQlfy6JlQf1ITa2UsOHaqSttusJXZ6bcT4F7ZMRvnMULSwqElErY6gm0g4TNjg
         k90i9ndjLzg9AbkeVEmCW+qs1qqquQZZOJSm9lxlPHLCgNG9voH7bJ4KH5k/6dFbGw8m
         dWM/6AQFN+hl9yl6JcRUnCZ340L+5TyLNzYyeKCDXmGrpXlffUwY0u3LAJaFpCZlX406
         GzLuHv4TD+OiSUJL30EvZ/M0SMz+6GJnAm8ejH5lL4LavcGsbqTKcKHgXJ84V1cL8mwF
         gwasf1jYW1RfdMbZUuPd6j37uGltPsSIkIGAQv2jqajsuB8RPIRc/edrGKvFxQqI6G6O
         gbgA==
X-Forwarded-Encrypted: i=1; AJvYcCVrQRJ5HBPUM9kUirwmMf6+OoLu9qWdZ/H43f+jwqHQn+d/QJd8C9xlclMhJwFrQy2RdQ15zA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+EiqASD/42wg/ym/zk6C7S+MMFNqeSBRMqDaC0XHFsTOdDjFM
	221e7gGDKuuNqoSo8ThzHYucMgAe5JlgDnfoi0/4dtyfUHg4iPcUL+AOg08M/9Q=
X-Gm-Gg: ASbGncvBWCvZykESpLzSWDaZZqjGtge2XIH32tQkebYDo6aZKyIUVAB16Ehundo7s37
	Af91kYOgHM/5N23OCAZia/1/xfNpDhsKZ++daMbSk1H6dUPB8R8flZJCgZVXxIMxS/klvGqrXxG
	25hOuIzcIaGoYffZ5otzHOwKtZyRjrq6buAyMb0hUqrDAWfalpu4CfmzCRNIYV5f16S76F5g0RQ
	XHddrFYm7TO577yBB2XVd/zGfrbI/k072KNzc+r20nmqS8noOgKGV+ZBwUOf9LC2gSlDaSV3CBz
	kAt2RHq683wuF9FHWlQKvyLNMYP7kaqKIuqbIlzgRDTwxILUQ7uRpplfusWKlaZmZeHBbVBcmeF
	mfr/L22kEwieEXnafwA==
X-Google-Smtp-Source: AGHT+IE8JJ+gcM70jjwLChCedk4Bo1iE+LZVH5Kmi/kj3lACsdGl+sYBMVg8z2JZoGmvHUzrMuViow==
X-Received: by 2002:a05:6214:d85:b0:6e4:2f90:a9ca with SMTP id 6a1803df08f44-6e8a0cd3eeamr184492746d6.3.1741027082475;
        Mon, 03 Mar 2025 10:38:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897633e5dsm56046656d6.12.2025.03.03.10.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:38:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpAfx-00000000uGv-1xlm;
	Mon, 03 Mar 2025 14:38:01 -0400
Date: Mon, 3 Mar 2025 14:38:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250303183801.GW5011@ziepe.ca>
References: <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>

On Sun, Mar 02, 2025 at 04:10:46PM +0800, Yi Liu wrote:
> I'm also thinking about the impact of such a knob. How should we define
> this knob. Should we allow it to disable/enable ATS? Especially in runtime.
> e.g. if the device is identified to be ATS untrusted by the admin, while
> the hw does not support SATS, it seems reasonable to disable ATS for
> such device. This might change the driver behavior on ATS enabling. Intel
> iommu driver enables ATS as long as it's available in the probe_device()
> op. What about AMD and ARM?

ARM enables ATS when a PAGING translation is set on the RID or any
PASID is used. Otherwise it is off, eg for RID = IDENTITY

This seems like a reasonable thing to do to me..

> On the other hand, we may just define the knob as sats required or not.
> This is just a knob to let kernel know if the iommu driver needs to enable
> sats or not. While leave the ATS enabling policy unchanged. This means
> we need to probe the sats capability of iommu hw before creating the knob
> in sysfs.

If we add some ATS control knob then maybe it should be able to
disable/enable normal ATS as well?

 never
 always
 paging-only
 secure-always
 secure-paging-only

?

Jason
