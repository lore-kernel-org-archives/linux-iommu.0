Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05E325495
	for <iommu@lists.linux.dev>; Sat, 19 Sep 2026 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853736; cv=none; b=BOZlXJJwKX1N8A57VOv3YAzwEVaZ42KbtQQ/UOGwKgc4NnArjNY9wRDsVrXvIlRJ5NlSaZbF2SgMSqcHZj+tu/J9v/xsEWmbPHbH54g2HaIz64hMtu2hKtJQH/gug6s8tkQgnGng+nhKqaNvJghkLHIQ6WHzkc9BXkHn0hHQT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853736; c=relaxed/simple;
	bh=xlefR/akgVIwwabPG2m/iCIg0y04aOCKWgO4pB6evyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kd9QBW5FihPkZhx1+M7JQv0YAuzO5DSxnWLhZ8u2QjeK79ZzV+9Yr0o6Q1093mC+v6JhnWrvf23RZngak1FoqGSRyM9EP6o+k2ksHDYHq2Oi6O3fBKPIrbwgNe/7D8gJNxWj+T9cpXMjukgUHJHx47f+TkwP8K9JMUY8uiier0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PAIIwRAV; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PAIIwRAV"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93a0fb2f9efso99729385a.1
        for <iommu@lists.linux.dev>; Sat, 19 Sep 2026 14:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789853734; x=1790458534; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kmW9yHmD8Dyy4s5qckAMeYd2CA7UfeC/px2jAWNVXJs=;
        b=PAIIwRAVAe/WOVLevVuGYmY8odDwwmClsabEE1TRoPCyBQVTkftWVtryVD6Rq4PB5b
         JuYT0Kbw8Y+F4I5/lknGcqUqWFNKTFOqg6viUlUbqd9NNFpUf3G32ejGnHj2hwYXyI87
         yev3NlHmIFZc6shHVWsGR32tdAfqmB+zZYdq8RFHfAvJZak79eZqw/O6Zf6lL7/ECtJx
         6Upaa3DgBuS6jtsiTb0hXTXsnmH6UmADpQlapn0YE+Y3lZ9SzSQVDph5f8dzTTVSOXz0
         ZEBQqxoFeBLTTmwoGfLEn5wlE1HNv54u23UGsJgJ9HmPD9Owad1jGFGmLwmjQPIUO96Y
         TrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853734; x=1790458534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmW9yHmD8Dyy4s5qckAMeYd2CA7UfeC/px2jAWNVXJs=;
        b=gROJG9vqHRiG/MzV5D+eLkEUdbk8ngSthU6IwUwHKhUffC1V9cK6zs7ItWM93O5GOI
         h11eSb1tX4J4SXH7dKMI/KLSb1Yi8TvBX2xSUqhtUB/+xqa2xEA48slbaFFjia068p9G
         zGzW1exv8nIv0jhtFdFHK15msKwL2hIt6BM31zrABWu+3T9on51GRylCSRs694Hvjsdf
         U0rkqJF+bvrt43WzyduxOJ0iwoslii85CWsit6xNKr/dQU3ZcsH3NXqHi97c4FMIezAB
         ow+Qc/sKkVD09qLcW323izHqHgL33A2+a+s1Tj6bqGWccnDLOSi3njql2fkMWBquqF1z
         m66g==
X-Forwarded-Encrypted: i=1; AKwUvByc8VbJYJXlCWDfRGvasg2Q+drg0RQkye7swU1/QIoTWmk/WQBOg/8BSu727HgheU0witTYOw==@lists.linux.dev
X-Gm-Message-State: AFuF++m8S2NrJdUmX6Srs1CCsTtg6v+tdZXSlqh4jjDy0nNjWu3uIm16
	jnihr6VvOyH4Kpom8lwbg1aSzOnrHJNLTH3i/8zIve5sXwCbKAHhMdqZX/TOS6+QJy8=
X-Gm-Gg: AYBFou3AsWTCLP9CtrWgJNRCsCJM3EKlG4e9+iyq649rhjkV4vX2+t/LQ/3hdjW7XrY
	C9K12a4Ennggm4ZherLfdhkOReMNwmWlQPK0jiMqAz7PugD/5gLbSgz0XDFaI2duj45ETjaedqM
	+mJaSC3jiGGT3q3x03oWmfiT9JUKhcBJucr35W69ivcZWq1Ed1Z1RqYECgea8YoVtaUHJhIOpMd
	90E5fqiyKo/J38izmgAPAh9LHyl3WG8CzCbdEt41sRHv6lKtB4Zn5ePmwC2QjD2NH4i/N0Ov9Oi
	ABvtsXqLn+ie4MLYxQne8pxDBx71+SpTrV5p79oi+29lMGM7Ifg1i+tPZR+XIgDmjO2JXccbHur
	TGGMyYtcZ8r3uB2v67V/Bf9Nl0ws+s79k3ugdGbUydNy37qZzeNa+geOCia7hyFceKRtajgf9I9
	jCH7ybfKAY6EVcL80IdLrOvaLwLksSeObTQMg+Ld13NMEv94AGak7ZpYh/5GbfIkFF+Fztufs0l
	cQimHLexqR0Kotjg8M6IhuRdlTNfdQwjTAjNxAdT0M5e4o3wvUI//m4
X-Received: by 2002:a05:620a:4416:b0:939:fe55:402a with SMTP id af79cd13be357-93bf577e246mr341980385a.31.1789853733973;
        Sat, 19 Sep 2026 14:35:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bed72215fsm275561085a.1.2026.09.19.14.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:35:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x82iZ-00000003aXY-2gnK;
	Sat, 19 Sep 2026 18:35:31 -0300
Date: Sat, 19 Sep 2026 18:35:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	"T.J. Mercier" <tjmercier@google.com>
Subject: Re: [PATCH v6 7/9] dma-buf: system_heap: Enforce shared-granule
 alignment for cc-shared buffers
Message-ID: <20260919213531.GI11599@ziepe.ca>
References: <aq1V3oeDdvXobt8J@arm.com>
 <97c30fce-9bda-4c61-b1b9-10297b89c8d9@amd.com>
 <20260918153642.GD11599@ziepe.ca>
 <yq5atsnl47c6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5atsnl47c6.fsf@kernel.org>

On Sat, Sep 19, 2026 at 08:27:29PM +0530, Aneesh Kumar K.V wrote:
 
> +static struct page *system_heap_alloc_order(unsigned int order, gfp_t flags,
> +					    bool cc_shared)
> +{
> +	struct cc_shared_pages mem;
> +
> +	if (!cc_shared)
> +		return alloc_pages(flags, order);
> +
> +	/* The shared granule can raise the actual allocation order. */
> +	flags |= __GFP_COMP;
> +	if (alloc_cc_shared_pages(flags, PAGE_SIZE << order, &mem))
> +		return NULL;

Oh yeah that's surprisingly easy because of how this loop works with
order

Makes sense to me

> int alloc_cc_shared_pages_node(int nid, gfp_t gfp, size_t requested,
> 			       struct cc_shared_pages *mem)

This argument order is a little weird from mm norms?

Jason
