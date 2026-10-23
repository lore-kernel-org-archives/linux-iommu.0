Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792796350;
	b=QJxexWiqwRKiDZcYy2qOIQWp8AzlecDq9qj+u5ylUn5rNcALDLcjvkA04B2Pu4W8obwC
	 DyJG8x5ig7iGABh0rGemquc1DWvpyPh1rBvt1gck+eDE7r/iOrTa2NZ6Dgtjt29VBdx4J
	 L9FdFSlXqHhAvG5mz6V0Sm64Dybt6jvhTQ1BNwKatRx2s5e7V3Mw8jFtOwopB7/ReiGhf
	 n0Cd6P8/vyVILC4Xu6bhIjXCcpMElK+4s4UYeAj3EZx1fKb/bz0iqviK04sZF8oTBiGJL
	 hJMmbydzkak0nvwSJalMK7fuvRE2UF0yuac/nfp6StT8YAsoICEy11qSNuSwx53ID6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rrOsYLZJDf0TzEPP307WDbeBhrlf1yktibJyBkuCquY=;
	b=4yTfG8rWiTLjg6ahip1taTrDqREeSS/Jqx3FMlcQl5poWyJ29jYdEThq22lcTeFIH34M
	 KXp/4duFEy2y6UzL06X366z8/isrkmb9BTHFIj2ZFbzR9ZWHN9mazxc3iepcsaNTNf6hd
	 If7YoWp1sWTtdga4IhFCU20UvvQr1xNIzikW5DX4hCBfxWkfcBGIfigqYaTTX1Ipy4u7i
	 N8lCjwHxMvZQiCekEqlxlGkPpFVHmbjYGVb4u60YHSOnH5MRfi/H2g3A6jCER0tzeUDrH
	 5/0/b2V+ihe1VWlXNSFDuWavhCQdOSPBudVefm/xyAqxU56G9CJb6wvbuPsMCkQY+NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RP5eoq90;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E8606A31B
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 22:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E29E8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RP5eoq90
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2db33db4de9so20925ad.0
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 15:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792796349; x=1793401149; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rrOsYLZJDf0TzEPP307WDbeBhrlf1yktibJyBkuCquY=;
        b=RP5eoq905hII1Ex73VeKp5Oa4mYYP9fQGQ0XT+7NdKNn8r5ngiUPHHYlSEIMrWdN8V
         k9gNBvSA66CtI3Rfl7z2elwRBTKGqesWphhvhupQ5F5OHFHO59vkAcExTA7tWqTFOCe1
         kCGeBHCpGHJTf9cBvvngiRm//R/I9xKn/mVluJX+1lSzcomqhYd++7ZY52vYSzWGUlu+
         tp30zAoBbKZ6wGIE8bThaPWs+b4wqctVbGXfHnhgQjYJ8D60++wyGH9eoezaHzi5JDAa
         DCOB0UG335o8jWjTZYnZeWFt8J5ABCky9FqbaYHKCj7eitEe0xkh/hcb1Oazm0gw3WCD
         cw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792796349; x=1793401149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rrOsYLZJDf0TzEPP307WDbeBhrlf1yktibJyBkuCquY=;
        b=J9iYmcfWW2vZoZFJuwJ0m+W8W10KIA9hvJVB2dzu5mOkjNOtX8c9sLKQitJYp2hCxM
         xsVJ1phVcXOXkJquI93vzaele02wibKJJGroEXsDjIikTxrQgtsQPhkucgvRYBRzA0wE
         jOZWlXh40+y7RQUCksezWsRNrYhwmJ+ddz/kpmjXss//ksuUZ6Our4C98/m3BKDysbHL
         CpEtJg/XtfGbl3SH+H4eOrmbj5JV2MQe+0HuJuWwArmPZMZE/LlHV7u82rLuCUhsUurB
         qseqV4sHWfMnMtfWch4Io9Ph31zIOj+ElVw1+KylmgdvnEHWwBtKLAvbwGr7YLLxPpCp
         h6+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwBtrQz5ggU+XV0iFZhsFmUcEqQGFJWHPa0JLvEG0Vq3gvO7NXvKQHMRGLzW40dQH7cpJ8hrQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJIWj7OLineeaqlMq2+5YRRr8OCAq96VY2GDJomQ4gHA5ZDhqnT
	ceHWoPh9D/X9DE0SgTFYqSxPP3fWTYBb5Ala84vhGxB9iUgk35lmf9XtVaNEVI9/2w==
X-Gm-Gg: AYBFou1yuKu2d1LI2RxNMXEcRgvvx6qDs079bp0/5VpYiINNLrfSu376KnED7IZWLR0
	0XLxRgkdGUEXimwddJBAhMIUWQ6kfLXdJG9T8F6n9IlR81VyxqLiY4AvL0abqPuPALchXp0OGq/
	m9rqAzUBRpPczlEC99Enb8Mk81mG4sjO9SBfsxhLzQCLmQUkphFMqW2Vus5jZwtLUM7IuUC335b
	02kFuSKefYmgmoo3IBik5jTddFtGmBlusHkZuCQ7Z0sX7bpfwu6uQWNM2air2rtDiH75C1PdFEK
	Zjd9WqPpt316fnzltF47DF0rkzDQPHBeTveIhsMJOv3YVO+yqheXUi1xabjIy4fk+Ttvh9fcu97
	6Wt2d89Jh65ty8PjEg8dH/TvHsRw9k+xRUSFl5PHS0IG8Bg1stB7kXXCPxYGsZJzJGZHbnNBr+6
	poHdZQeZARqAyJQeHAlIvFxxEvnpXdkEGtf8xO+UljoXtjCGG32Y4l/HIaTmg8vL6Z+fcOdGhyL
	+7mYomXcTf+ArUUMyIw6vtUuy31p9SjsYrKdjfzLXYQYsN3mjNj0Bz9kJhdohTRn/zrspVhYgGz
	wqDPqal2nj+FIWmpV7+ud91Z6+AiJ9WwEM6QeTzPYIpk5ct1
X-Received: by 2002:a17:903:2c0d:b0:2dd:8958:f8d5 with SMTP id d9443c01a7336-2ea9d109b4bmr841245ad.6.1792796348553;
        Fri, 23 Oct 2026 15:59:08 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f09csm649587a91.7.2026.10.23.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:59:07 -0700 (PDT)
Date: Fri, 23 Oct 2026 22:59:04 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH 0/3] iommu/arm-smmu-v3: Add support for hitless
 replace of CD entries
Message-ID: <atvmOnAEhVG3Vevk@google.com>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <40a2e1a2-138b-42bf-94ea-a42fda128c22@arm.com>
 <20261023134630.GA3977851@ziepe.ca>
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
In-Reply-To: <20261023134630.GA3977851@ziepe.ca>

On Fri, Oct 23, 2026 at 10:46:30AM -0300, Jason Gunthorpe wrote:
>On Fri, Oct 23, 2026 at 01:10:56PM +0100, Robin Murphy wrote:
>> On 25/09/2026 2:13 am, Samiullah Khawaja wrote:
>> > This patch series adds support for replacing IOMMU domains with S1 page
>> > tables hitlessly, that is without disrupting the ongoing DMAs. This is
>> > one of the dependencies of the Liveupdate IOMMU support for Arm SMMUv3.
>> >
>> > S1 domains are programmed by CD entries in the CD table. During a new
>> > domain attach these are updated using arm_smmu_write_cd_entry(). Since
>> > ASID and TTB0 are in different 64-bit words, arm_smmu_write_cd_entry()
>> > considers it a non-hitless update and sets V=0. This means such an
>> > update is disruptive and would generate translation faults if there are
>> > ongoing DMAs.
>> >
>> > Replace the CD entries by using an unused temporary ASID in the
>> > following sequence to allow hitless replacement of CD entry,
>> >
>> > - Update the CD entry with temporary ASID.
>> > - Update the CD entry with the target TTB0.
>> > - Invalidate the temporary ASID.
>> > - Update the CD entry with target ASID.
>> > - Invalidate and release the temporary ASID.
>>
>> Why bother transitioning through a 3rd ASID? The old and new pagetables must
>> contain the same translations anyway, so why not just: switch ASID, switch
>> TTB, invalidate old ASID?
>
>The target ASID may be in use by another CD someplace else. Doing it
>without the temporary could contaminate it with wrong translations
>from the original TTB0.

+1
>
>From a driver perspective we don't know why the domain replace
>operation was triggered. iommufd can trigger it for domains that are
>not identical. Corrupting the target ASID when we don't know for sure
>what is happening is not safe.
>
>Obviously Samiullah's use case is hitless between the same translation
>so it doesn't need the extra ASID, but the driver can't know this.
>
>Samiullah please include this explanation in a comment..

I will add this in the next version.

Thanks,
Sami
>
>Jason
