Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FE3346BA
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635528; cv=none; b=PSQbm1r9q/ZGqxgxhEGojOqJsAxaCu6ZEU/AFtMSfQaejgsZV+tGymkN2sDmbohkihOyS6IhCUe9/dosTL2TYw5TNotxgZ7tMiAje/jUpJhYYrHcc7WYsMKlOhc7SD754Unewr1eqaOZqbM5jWKs5H6gCVmpyK2lenw1U7dYLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635528; c=relaxed/simple;
	bh=/EEkjyX2e9oSevCPubP9u1AVb3Rr9e/hCPzwvqQK/fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZegIdEtcCJ6eiF172FuJEgMz3ijyHmtdOUlZiX4Orig3xSctG2z4MKneX/559eTARvDyZUq9iWMg0ZAoa2XWuJuy+jYELJc7xdt2cCxZSv6SJ/4+C5c4HAE+tk3doVxhDi1yhWHLGYkH7AUs2sZjucbtb1iK4uVXTcXojeqh3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ln4KqRQF; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ln4KqRQF"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87c1f61ba98so6875666d6.0
        for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760635526; x=1761240326; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/EEkjyX2e9oSevCPubP9u1AVb3Rr9e/hCPzwvqQK/fY=;
        b=ln4KqRQFID4euHrQFmRG83+LsBh/mqGFnpDjhgTYdu6MbI4Dd0DZOVKVxFcxZgOCsI
         uoVTp+RPTGIxmjNwvEo8XxV3cHGbo4r6D8mpmPHza1z6fU2+rCkynWce3FvIsSSZ4mm7
         SAGdFhDn3ivrixoE3aUpbLMNax0fBLezS18dY7j/PNQaTNpeHQneAxFRmdBpoYMUfhMS
         bIo5kdAHGUCu9NeB/yVzxevpX5kuFFOLf7KJrh7iOiamqjWEssEZKDiqFAgyQXjrKvTl
         QHfG2HtXWiYYwaGFlm8H6v+Vz45q8Bgp3USDXhT2hGH5RiiYCcPc/tzDXibARRqEen6d
         JBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635526; x=1761240326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EEkjyX2e9oSevCPubP9u1AVb3Rr9e/hCPzwvqQK/fY=;
        b=ZgD/uVbtGrQ1t58WNQOGCzf9E/eVEWn2oeyDKAVGaAMAodQeEqR+50E7UludiHHpe0
         GNevF7Qscmmm+yxHrcI3Mo6L2kdoR33muOxWN7uobYp8s3M6J1MO02SpqHEiTl3WiG81
         YLgYz903ibsn8FnEBP/Q7gUuAtJEEKPb9esH3rJORrRjQQWHcM69xY0CPAnq9x9xG6D4
         +yHRtJT0zK5hxZw33mMjRHzg/mpuZFSpWQDWXI+KYM4G+cY0UKdVbLT1FP13mpaEpgXS
         wc3jGnZlY5WlYQJcpN2ii/KrZh8syml110vsqjHtCREYQmRTHN8h5jPn+AC2SMQ2qdvK
         6yuA==
X-Forwarded-Encrypted: i=1; AJvYcCUxM8xw5ZjUBYgAqEZVWcOEUnM5+9opdVXRnp0CFU2PkIt6PfdVX5irT6jgVAvCMIC0kvfoxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww5FojIPFY9mrxHvj8uyyGR8lPn0barSDu8qRVypExMUO8FffA
	vBPC3W10LiF+aqGS3i4imbckJud+7JISS28/u2nvdqDIBGY9I6wOK59yHMWm4APMCG0+WXQ0HdT
	OiqoT
X-Gm-Gg: ASbGnct4sQVAqAl6x1OdVhuVJb2cWj1EBqxDm5NXdMVQWqRxzUSFP9SlIC/ZhxcvQGK
	6SNI1lVH92RxkBSKIlLtEH1PBxFpnVxUQRYw2l+0hmdOoeAJXluZNNMs4tWTLZFyBPSrjtWCnhn
	a7mgrPMANFrzPmIgah4NyO71wrWQDVlqqao6GxMvrIDj5uGnb0j+VbNVqvZXB+UANVUmVo7MKAZ
	mvksW+7VjemKj0GdRXPC78XI350/1X48l/V5hfoWH9tG5Vzqtx87SlmWlPPbtqopRG050hnuI3w
	+paoRbeMeTJ+56WwHR/LBuQe8ClMMtm23rL1ZN0i8TgoAJEeg5HqsJ/KlgnHCDzW2nw7zlSCf/j
	5uByhwsH2MyXUM9jR7BNcRkWArmJN0Pf8gyJ5IpznZeIFLBebqGTsnGGNhxoY
X-Google-Smtp-Source: AGHT+IHksrcKVBUhwjEbvljPYvDE0IZujaCH4Ti9W7M9s4IST+pF0PoGvC9Lpt9Kwo2sVKgzxbWPyQ==
X-Received: by 2002:a05:6214:319a:b0:87c:2206:2e3d with SMTP id 6a1803df08f44-87c22062f05mr5415776d6.25.1760635526001;
        Thu, 16 Oct 2025 10:25:26 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0121f891sm44222226d6.24.2025.10.16.10.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:25:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v9RjA-00000000Wrr-3Ipa;
	Thu, 16 Oct 2025 14:25:24 -0300
Date: Thu, 16 Oct 2025 14:25:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <20251016172524.GN3938986@ziepe.ca>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
 <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
 <20251015151002.GH3938986@ziepe.ca>
 <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>

On Thu, Oct 16, 2025 at 06:17:35PM +0100, Robin Murphy wrote:

> In this case AFAICS kunit_device_register() can only fail due to OOM or
> something unexpectedly messed up in the kobject/sysfs hierarchy, all of
> which should already scream (and represent the system being sufficiently
> hosed that any actual test results probably no longer matter anyway) -
> otherwise I would have suggested a kunit_err() message too.

Yes, I think so too. Which is why I think the simple
KUNIT_ASSERT_FALSE is fine - we don't need to over think something
that should never happen.

Basically it is a simple logic for the test writer, any thing in the
test body that doesn't work as expected triggers a
KUNIT_ASSERT. Infrastructure included.

At least that is how I've written all my tests so far, including the
userspace ones..

Jason
