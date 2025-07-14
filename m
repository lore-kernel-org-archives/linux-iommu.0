Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760331D6DA9
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505023; cv=none; b=XXkWPPqT0NSxxE1+4257v8l07Z6I3PV3uWsHKEkTO/+SyYSiwk6OmdAoS64DKBgN/hze5aBHZLoKCbMFSGXPnQgNh/lrR8tUhO2OYc+SIOGy7+NvglhV+JkQwoM7jaq+H8CqPhcudS3+liJ5ThUq1o9syNJ7P8vEHNwHJtbFKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505023; c=relaxed/simple;
	bh=3IIlCMfJ4U7NeBKqCR3g3o2v6EKvqqaNr0/XybAbX4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyF65Sk/3qTHeDMCnYrjSgkKiOZiR9Y+1rf79ENyhb5rxn9asBr1wRA3iXiSVFittYlFFO/3z0aCcFwASdxy81viulRjqZUt43ZpalmKLkUuTJGfx2yrathVAGSjNQzzPpQfmZOoQdDOr+6sGHqPbXo5jguCozK0R40/pGbws+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zwc17kTH; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zwc17kTH"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7dfd667e539so318851685a.2
        for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752505020; x=1753109820; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IIlCMfJ4U7NeBKqCR3g3o2v6EKvqqaNr0/XybAbX4E=;
        b=Zwc17kTHUbXU251/2hwgjopsHVtZLEkS45+Ca3vbXK/VvNPoWutXp5YASwoRUi26AJ
         EgVSKRt4uv8LW21UInhUP1rScYxznJ8N9cCYhsqSmFVxJk/W7EIonilgLPhNM9AhhOYh
         Lei0rbxuROeRO5Lcl8MJUzbHxyWYUXZxedB5BuV/kHncyhiTaQV3uaeBWu1Huw3mFuHP
         9hf0k3aZq7HGf3S2JkR4sN3QOa8/xmY4tE1PiERcPhonCAOt4O50cuqiIH2GWKhYt6Ej
         kbIdL92CFjNaw6ZXv4W00hJu0JHNfqqMwf/lGvM/chQGDrskccmRTr4S0UToIxIEnIAk
         8xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505020; x=1753109820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IIlCMfJ4U7NeBKqCR3g3o2v6EKvqqaNr0/XybAbX4E=;
        b=K+kV2hlIDS4eOuug9rfb+Q5e9tADdmM2m2HEcEuAbwQJkKMUUmlhfIDWFYW/1Of2O8
         FlfgIrvpv62dm970EVUebFVG1uN9DtPurf/A9Ir7aO/hTUD5L04mApfqzeCTFGH89MzV
         fLLe8Qwb6hqPOn/+IsldTmbqfJ9XHujnHPf7CnXAm56+SH77YEk3TewQwRxOQ40XTueu
         1p4UapFyol32q7C+LbWAkWJLMG8nb/EPDEMJkPejJNs6Ry90xRpmSsI6GMXCZeliOMbA
         CGb+mYYfYKvJ8u3xPOmxeVwttbTZZejrHOSYDUOHRF7WQXe9lUmmaRDG9lCTHtOz4Xur
         i+Sg==
X-Gm-Message-State: AOJu0YydE+5kD/C61JGJJalq4SfqkpIAWjLUEkht6LeXzNF/N5qj804r
	gNfkrPxM9gYrapwLOlgmFDk36d9kOIM68XhpgObWIPWkqv1fSq8Iutw/peaFHqlFLkk=
X-Gm-Gg: ASbGncsDPXV3pSScjT7S+EmpLqN6BfmARYUfzZLyQXiSi7e1IjBVfUjGsLmumGrZ4oR
	4ZDVMSGO2ZZHREgVwRcCLpgmt40DNj1EMMZLUCVNHs01aizjpc3qaARvLEP7oQbTAVX/qvrR5Nf
	dM7miqrH4kxDFu0semwikLMH80r/wokzyBFAZoqD7M7fb0bV0Era3cVHxaTlkBMRzvNgvG5yKpS
	aO+8J4QBrMTvt11FB7UwML5Ya4ynj73mSGgOUtMm5nux6P3lGwBWLOn1wTXCQU3GHaERfpfO+N0
	pF4LGSUnD503MIeTRJrmWAucWC+/aMwI9AAVU83BuiHyTdC9MODjk9nM9EIDpfxa+XxyUqPlRCU
	e1uFzT8ChpIiek0iRZ2YSlfzU7UyW77Od/mi7n0GLGkceCSy+5l2YI8H3Ty/kYQxML+ZFKL2M7A
	==
X-Google-Smtp-Source: AGHT+IHSuqVDpU+T+A+aN5LmCFefpJXF5cyYnF3sh/w5kcfs3RhbyD9HgdX/Ma1LQ0vovQtXH7B3NQ==
X-Received: by 2002:a05:620a:56f:b0:7e0:8503:f948 with SMTP id af79cd13be357-7e08503fc13mr1214233485a.36.1752505020201;
        Mon, 14 Jul 2025 07:57:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdbb0ceb9sm519215885a.18.2025.07.14.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:56:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ubKby-00000008g2a-1Kml;
	Mon, 14 Jul 2025 11:56:58 -0300
Date: Mon, 14 Jul 2025 11:56:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 0/4] Implement IOMMU SVA page fault processing error
 notifiers
Message-ID: <20250714145658.GH1870174@ziepe.ca>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710134215.97840-1-sergey.temerkhanov@intel.com>

On Thu, Jul 10, 2025 at 01:42:11PM +0000, Sergey Temerkhanov wrote:
> These series contain changes that provide endpoint device drivers
> with the ability to retrieve information about page fault processing
> errors (the most relevant being PASID and IOVA PFN).

You need to come with a driver using this as well.

Jason
