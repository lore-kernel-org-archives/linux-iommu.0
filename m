Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FD1D4353
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313303; cv=none; b=Nahlty8V+lU/WEh2MfwKvY7adGKIYie4YgVsCuRHlpLGKXZaBc0EZurFeetAZ5HOzY1YBRoURRIsWPbeTZEb9+ZYaP2Se/BNVnlCjPGQyVI6i6tNUhF4P4X2kFqaL+JeEs0iapH6CzG3ibXgpC7SdJZz4X4Qfn4+JNVDWywudY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313303; c=relaxed/simple;
	bh=rRVuIaOx8RNrteaDGFooPVCgbWZsVHEatmlbzj7fViY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOQzGm90b4ETSBGpeJBTK25Uaj4U4N/QLahaJ0zJ7GT/fh9wpxOouRdER7XC4r0xdLv3IHXSKDDh/6R3vTG3cs9k5KLZBRvv3EPz+X3Ld9/ZDh4CF64Bn06VPKD0LccerW5s/dZCLDkp2Eds44H+BEiv0jdQ6fo8zNCWaNWGKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ADw9yx+G; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ADw9yx+G"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7ae491dacaeso546846585a.0
        for <iommu@lists.linux.dev>; Mon, 07 Oct 2024 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728313300; x=1728918100; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bInHqGw/7pXdDA3IXyTgOVdi79kStxfjp6yDL0daeE=;
        b=ADw9yx+GeLyrO88OjvPSw1MIJjs0beNJLxuw7TqFgyU4slZ5g7fZ+/NoOSqWYhU0ss
         ia50QgIHCa/rggqtBzq6tVafe2p+dcbv5Mnitp78VWaCn7HSpGVU+mwekOlYYTAIwa4D
         MGvi3BvKTYxIJyYmImxES/12GozFNdbo2XWd6M9tKtiikHa6giatIb6SyGITlaMH2BIq
         PingFLGiHg8yzdNCWY+dOxkBV7gW4NT0aJ4+/O4HKHp5IFD4ja6J/Jl5Pguy11w2x3xq
         SHxvrZyDtVBNgQl8sHM1+CxwD0cUMX95N9ji4Vo+f7qUJvK4A8ihT/SedaKCgMfBcBQA
         JlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313300; x=1728918100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bInHqGw/7pXdDA3IXyTgOVdi79kStxfjp6yDL0daeE=;
        b=j7NXxjfu1v3lGHAPloCkI8otSG8RCRcxH+0gw/POlxzv5sADbamNXZzfgn1SrEELiK
         Z8UMOde2wgm24cFuP4JwPLjh7if90wt6hVFNg3GyikuBL3jPa28/5pe109KWh12VUwEk
         ZntoJxxPQ2YNUyuJCzPFo7A8WYFa8OmSnXBQYr6Hw+chzQBMB8GhxT+XMIE+BVI5bBIS
         dmi3AGDIRApK41Y9ynlbICERvRBFtpqHr7ftQ8Def8aqUm9MHTogs4gkmvXvfn9NcnVV
         AtDrrpN0KB4oawhRY6eqfUxSDEzlwOIdSvV7RA7bl3H/OQBQFTkdaIuMOCbXqaf6zvE6
         cqrg==
X-Forwarded-Encrypted: i=1; AJvYcCUUfAHs3ou78De/jrvwfOmHSU99+GVR/qeWNObJJW0I/A2vsI8GmeA5+ZnnePm+QlJ7CJdFvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwED1h8CvmUV4lhbpmHChxZ8JziHCCHFltftKYIQ6wW4+vFW9Bt
	NUwGS49zATsYplFunBfNzL4LzVW69/TKY5drlJQ7fjlEXOyV/aiGsyGhqN1/T5I=
X-Google-Smtp-Source: AGHT+IEC12fI88Gp57MHDcshS4/IkrApM2kBYgZQIiBILAEfDwFMFN//oZi0JmEkR0VcJlcGa+25Vw==
X-Received: by 2002:a05:620a:40cd:b0:7a9:b914:279c with SMTP id af79cd13be357-7ae6f3aecbamr1931318585a.0.1728313300551;
        Mon, 07 Oct 2024 08:01:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7563619fsm264722085a.62.2024.10.07.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:01:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sxpEw-002Wvt-Te;
	Mon, 07 Oct 2024 12:01:38 -0300
Date: Mon, 7 Oct 2024 12:01:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"maz@kernel.org" <maz@kernel.org>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241007150138.GM2456194@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
 <20241002185520.GL1369530@ziepe.ca>
 <d6328467adc9b7512f6dd88a6f8f843b8efdc154.camel@amazon.com>
 <e458d48a797043b7efc853fc65b9c4d043b12ed4.camel@infradead.org>
 <1d331c55a299d414e49ba5eb6f46dccb525bf788.camel@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d331c55a299d414e49ba5eb6f46dccb525bf788.camel@amazon.com>

On Mon, Oct 07, 2024 at 08:57:07AM +0000, Gowans, James wrote:
> With the ARM SMMUv3 for example I think there are break-before-make
> requirement, so is it possible to do an atomic switch of the SMMUv3 page
> table PGD in a hitless way? 

The BBM rules are only about cached translations. If all your IOPTEs
result in the same translation *size* then you are safe. You can
change the radix memory storing the IOPTEs freely, AFAIK.

BBM level 2 capable HW doesn't have those limitations either and
everything is possible.

Jason
