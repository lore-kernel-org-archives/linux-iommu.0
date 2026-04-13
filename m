Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619F3A0E85
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119602; cv=none; b=Phm1xJr2N7rgSxHAnVV3Xwl2111HzYUifvT1gJfTQcisJyRfXZPGl9433zwdJQF28CdXSo1Uss+Iu3pRFEdLSkZ4/RI15Cu2FwiAujNfeR6MFEKsWRIDi/LaTMCmUVqIQQ6NnuKmO9xG4Ixy78avnhXgq1xNmz3eKJZA3srIMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119602; c=relaxed/simple;
	bh=UwW/1XbIw/u2ktOpP85VLCvfvyEmOP4GLErArAy8gGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgkNIfTmwJ66XRWGpiFYwQPWzvM1umXfBHHGtonZ95gm8MPVLA+zrZn6TlEG7+kSxJDfX4tEWfGUD4I4p0LDXNNtqo2rtngrcArzjmBkhHI7MyWvhD+Xy0xBo6pbPeszMUKWfEPvreQUiPnB/QqIYt2eHM1Rc4EAaG6xpsHhhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iZZjY6fM; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iZZjY6fM"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d424af6282so537032785a.0
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776119600; x=1776724400; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UwW/1XbIw/u2ktOpP85VLCvfvyEmOP4GLErArAy8gGw=;
        b=iZZjY6fMiCm3tPNaJng2TMmVWA9DBfpnMYS3i2/10QPM90yZl0JNH9RDGzIEdRjbpD
         KzZWwb3Bl79dqdkZWttx1pU4dwXekPceP9S40a6GcGm4RFbCGXzJ5lUTjrskaBntRua4
         NErp4I8KgedzXzF/QFBHTerd5rbRyvxvmaOGuNu1iOfQj0OboNqXOOegvQKwVfl4um/r
         /dwr+573boIrhQMlGAS0q66D4KsKUaxA6v8ye91FAiYNw+wQ9i6lck3dm/swUCYW82zO
         Lhe9iiEGMlxKc+kYueJB/hggflupodh4lf/Zt8IY8wJquEDgKL/4Yn2LMPr0JBHLsDmV
         kAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776119600; x=1776724400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwW/1XbIw/u2ktOpP85VLCvfvyEmOP4GLErArAy8gGw=;
        b=k8lzouHiGg3eRGjIFRSKjpQKpsTemEVqAGg8agztsslN3DXks8j/N12wWoF0/UDXBF
         4wmSHEqDTKmyA8F7pZ/oM+mgQRAQ+Bk3+GFGTK963uQc+2GDDQp+GdBHgglABbIP0iQD
         3HufqhOFjwSPmXUqoHZkSlpCWSHQdmtkYMp6sPDavEnuVpCbcYsXfNy9uxhoyeZ+9jeN
         tZ+TphfJ9YmSPwh764eaMGzXP3vIqPFAWC49wErZFnOpzHys/0jhxCyGd4cNYKh0zMNH
         jTy/9f75yTps1h/Zopi9M4dUsfyAxudenmjtHJj5v6bzx7y6q6ypJdhuLje0mCcapC7x
         e6LA==
X-Forwarded-Encrypted: i=1; AFNElJ+C6O5QQ+Kq+uOYYM18WGVVuQQmdqZsIEOKjGIzRG5yDK4myW4FlQr/UkPS8scbuFXhqrPRBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj2kQpYN3Gm/JE6YvlqZOkqO03t+XKPYuNJjwmzFP6bU1VimCe
	aNrrsOw0eYktTfnrX/Udtj42IJXM/9nranYtK8T7lwXyqIF1SLGsswE5wYVru48Xa3A=
X-Gm-Gg: AeBDietsfBW2L+49rKxshhcc7zAer8KvVOPdXGeCxhyaS9kVu760auCZaWO2jvdxltf
	Bs07SvufZHKU1UTe78fkFLtUbGtKgTfB0BN56BG5ZBP/zqAV4aKgIYIQroWvSVQD6dlaoYeX8MZ
	M9ZNDpdx3Fi/ZV79/XJUsy4+ehIr6qTD1kh/6ucDVzVErgmFretUkSOT3ileJkohk2Tzc0msEfp
	mv2Gd/CrOFMYeA7AGocMahd+GoCqrgbT+pwpS9hu3qVmjDVV5Jy1RnWRpiRVeIjrCU3Gq75mM18
	hdogh/aA+pQ+LRdpkaoAqypnk5+6Z/eBbmJIgFJGWLen/Jz5Wq7Ozmc4nfkNs+KAVFyAgBds3Jo
	xJtHziquM5OeYc+RrVPAtv/ipRB5Sxx8UVO7EopR4krvEwmdvNcXRXGhTLNiQXvln5o3ZYhR51O
	Yv6zneDRWRRmG1QCLoiKq4xc58aEeMqIy+I+rI4iB8mkDTyC0A/gOjQkhLKUNSKUoVz7pbysLAR
	kSO+w==
X-Received: by 2002:a05:6214:e88:b0:8ac:8cbb:49bd with SMTP id 6a1803df08f44-8ac8cbb4d73mr219764146d6.38.1776119599895;
        Mon, 13 Apr 2026 15:33:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a45552sm105040816d6.20.2026.04.13.15.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 15:33:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCPqI-000000075qq-3S8b;
	Mon, 13 Apr 2026 19:33:18 -0300
Date: Mon, 13 Apr 2026 19:33:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <20260413223318.GR3694781@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
 <adl2QX6gra99bkOV@google.com>
 <20260410231650.GD3694781@ziepe.ca>
 <ad0b-5aRU172-Od8@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0b-5aRU172-Od8@google.com>

On Mon, Apr 13, 2026 at 07:31:22PM +0000, Samiullah Khawaja wrote:
> Yes, we use the collect walker during KHO restore of the preserved pages
> and also during free. But if I understand correctly, the collect walker
> behaviour changes based on some FEAT_ flags (like SIGN_EXTEND). So we
> have to be careful if the previous kernel was using different FEAT flags
> that affect the collect walker. To handle this, we can just preserve the
> u32 features from struct pt_common and deduce everything using that.

It is agressively not stable, and even new kernels might not support
the features old ones were using, so this is a bit dicy.

You probably need some, but I think I'd be very choosey about which
some I preserve and which come from the new driver.

> Thinking about it more, we do preserve the top_level, so that could
> potentially be used to walk over the page tables of these free-only
> domains if we just set up the pts->index and pts->end_index properly by
> initializing the range based on the top_level. Are you thinking of a
> similar approach to walk these free-only domains?

Hmm, even the free walker requires computing the end_index, and that
requires at least vasz. eg ARM will compute the number of items in the
top level based on vasz to support concatenated pages.

I don't think sign_extend is used in the free path though.

So if that is the only purpose then yes you can probably get away with
nothing, but you have to be very careful to contain the restored
domain to only execute free and nothing else by removing the
map/unmap/etc ops.

And add some dedicated self tests (zero pt features and test free) to
simulate it.

Jason
