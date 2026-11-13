Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533495;
	b=5F+0Cl5okAxR6xxmr60mfl+43I2Q6k7cK6A167B6P7VQZUVPQ7zWzS4e8pRm14PKf3Ph
	 3G0zxAzOewqvzxxE1WOZi33UNxwAysUp+DO9VQ0WuXdzsWlaTNR2w4jhsaJDTvDSZveRf
	 XLh2ZbXXEh/GHWEvAhe3T8s66klR66Z5lkxZ4y0mJ++pjBLiHnCmqfWsl9ZVFxvSXM6NK
	 IhtZ+J1yTfxVlUvLtH2d8z6ZjAqCGbaWTaT1GbI2YgmgGJM/Fd+8moPFnBpJzkv39Inl4
	 8OT11MxU4CRwA3Zkrgd5vjNv4rWHxIGDlUcXzbMTe8YSRarD/2M1/lBIGbbz42EwNBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rycHbTOJK2it38YspaXZxnOqkvIv8pjnp4MzdUIJoBg=;
	b=hxYDQewSnV+BTZ6II9kD0LbzGPFRNlvJcjt+wUO25fHnSViIb/UzT6yGu3O+8XtNem4x
	 CnLK4Ps0JVxcMgLc2nStLDLs5Rf/Qp6Hp43t3OsQl4AjTK6MEnG0Uqpvh8dILo5fqnKlC
	 KKNcYChnfkDZVG5bG4kzc+vhl6i93nYIcZCov7qYKyfytH8CpE35mEmBV8lAoyefEyGGY
	 qJvBZYBfFfS11659lrNn8JtW/XbuO2pOrE2crorD1pOWUvFBc2lFfn4Oqq+J7d9etWiHR
	 Xu4E/O4YwBCVm/8gxNUmLDfvg0cSEWrrMKsWgqhHYN/HSNwIrwX15wttP433hVHNjSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OMQLCs3X;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C663606A335
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 01:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C663606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OMQLCs3X
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ed3f563739so29475ad.0
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 17:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794533493; x=1795138293; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rycHbTOJK2it38YspaXZxnOqkvIv8pjnp4MzdUIJoBg=;
        b=OMQLCs3X00XZ9pOrj1nop3MTMZsmJ0dzfb4ruM17D9uA0nL7iI7R5nVNVqfzjvP8nM
         ySlWeTGkpR4DzsqjTyLgEXIPikTNVAS7vc1rquVuDUOpnqQXRDXfj2l224HAq4uk6S0A
         hWoXqM/08AUADvuPRnfxRZ58pmwTEuSb8BqgFM/saagyioN1yfDOIKdSo8Axt8q1xuoL
         SGBm4zz0T5Me1HHHEGorB1Zt0jZN+eVRNWj4Lz43Xc7AWuJePItqb/mJDblJzelNPROb
         nMvcYwbNaiu5U4HwXt+CP5ei5M0FC8hp2MSS56qrGzngfHfgGvu6ewvDAN08M6+JXpdL
         ujiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794533493; x=1795138293;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rycHbTOJK2it38YspaXZxnOqkvIv8pjnp4MzdUIJoBg=;
        b=Q+R3D4qHn4Z35ld800wymPAfHHrXb7YvEO21zkYnZ8m2rA+Rcv1Qb+a/FarQYU4xQ3
         sZyN5W9Jz3OfhQcy3fftWukTdTYyVRQPGARwtakB11f0pEE6jflOlzXryQ2L4vIaebJT
         fDcdwvz6BRis/L6nPqydSkC8Isfzy09h/pNW8it6WDv2x0QPcIkFNzG0qFc6C49fdThs
         w9hEAlBMNxFYtALEE+IFmjfyqRCeLV6kxELEMpvQn/OxaTBh+FoJep/ASZAWBjBjc7Ik
         q8hx1Ej7S6NacQZPqoH99j9YALXpsri0bGwr4FgDQtvxbOi8wLsI4Jw0fu2VVcjE59++
         PYeg==
X-Forwarded-Encrypted: i=1; AL+hErGayGG+W+SiKkJE4hbrflkI/PYSu1fvSep9yVvKOKmhAKPmtj7SmF3MTZl5qD52V6fbALgy6w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Snmz8BGXBdY0JoGNxMqb8tikJ4YYppmgkR9gK7Crbey3NIJJM
	a4Q3ipBgPX1M2E7KZYUhs+dzydxXdbF/ZQn0hJYJsmKdij47Iii9viH6uUVaeG3hIg==
X-Gm-Gg: AYBFou1JyQY7bPN6THGY0d4IF1b95dS7nbd73Wli1yJJRA5i85l+RuuyLXzkgeoBhMP
	k/+7RWTDuIKi6wKci2KBRKayIMIVpXhTuTmF2riTO3zlNnud4fBytN9FC+/xqQgWlLcZxmm4NBP
	A6iF9yxMt33nB1nZNh2zL1RVKL57REENjQz2nEAQ1gXr/Ieon5nqrAmau1dRySkbANAW59QcY0t
	S02SulH/6ji80spB/IEcdJDu8D9JGWzHKkAvMHWTwClEvEH0e2rPwbmeuYzV6tW/XZHvP7B2Gwf
	sYiDTfGN3KY7xkGPkQcOGooKUdyhBk3l7wn0/v/RaxZB0we8itdrThUB3QdZc2cHneE8prFTSuw
	CPCCGrOP9TBnQJR7B3gRS5+IwssO6O9yZS++rYklN0knOI9GQqwesbkKdfbjkFwafB84CqeESWD
	e1306f4xZvoIX48LDYHPYR2NirHrcRm8Pbdt9dNhkJRHXbwENR5MbkLaTN21PrwOCbf5vVd/WWh
	0avToWEdkK8Wg18L7MOmuTVINTVJO9nVHzpTWMTylDE+jUHZj8xFTlzb5L0tzQZrz0L9JA7w6rg
	414nn3I6DGUfNom9r+6+K2D/YAlMPGQ0RAhzblXCqqYj5Hy7AKey6i3ZKorodcIIyr8U2RFVj2m
	N7Edjm0yxLKlpU8o/PzRpRA==
X-Received: by 2002:a17:902:f607:b0:2e9:7ba2:a8bb with SMTP id d9443c01a7336-2ee0f274d9fmr3031435ad.3.1794533492904;
        Thu, 12 Nov 2026 17:31:32 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2b190cfsm291532b3a.51.2026.11.12.17.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:31:31 -0800 (PST)
Date: Fri, 13 Nov 2026 01:31:29 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v7 02/18] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <avZoWubpbulF3UUa@google.com>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-3-skhawaja@google.com>
 <wirs4vcszlt6wkw2wfauhjnxve4n5ivnnpkg35fqid34htepet@fn4opgt3lt2x>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <wirs4vcszlt6wkw2wfauhjnxve4n5ivnnpkg35fqid34htepet@fn4opgt3lt2x>

On Thu, Nov 12, 2026 at 04:31:27PM +0000, Ankit Soni wrote:
>On Tue, Nov 10, 2026 at 04:08:08AM +0000, Samiullah Khawaja wrote:
>> IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
>> the proper preservation and restoration of ioptdesc add helper
>> functions.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
>

Thanks,
Sami
