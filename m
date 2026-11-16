Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853503;
	b=UHVgUXbKQIr+NIgBvRxLDvd1ulYCMAn8fQpxi5YJmpw3s4Li/EyYd2u4euA88j/kCGX7
	 QIWFh3hcxNg73GZCtWi4GPcpyhHLXfEXsYcoiHDb73OxnBXqyWzmcHCroKljhQQu7DufJ
	 jqvWwgqikoEHmmCwCf3GRAlweHhjbG29UW/FfobGUYC/DQ8MSvnLHaWQQpUcXu+Lw5ZZG
	 TG0Fm7sSiX6CSuzNSzyCSZ60/UEj4isZAsWNrhTQGOHKXQT19EyYeoLMKCJBakGEBiwVv
	 2LRuX0xOwWpO6oiQ99bU3X/32q5EOXl96HNSP2QtA5MoFISAr3p1+akvBERA4sEuGCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
	b=T3ThXmaw4nKW8WTJby5w8SoGr08fsNUhOJREcapuIWciBK0l/UE1+mlFsL2fqtWoBMJ+
	 jdUi/SRTYPh4bOSV7PyxN0J4DyBZBiYY8DyORDY8j3LnCsnbW5KTnjekrcfNxkJogrVOF
	 0LSs6ybqffgg/Q3mr9fmMWNYhy8PkMdJ2tm8nCzh5WwHLt8x8k0mlVqB+NhWer9T8go4u
	 h92egxXolZOy0TvSXmdZCpp59o2L3OslFsO4mEhLNPQD5bbkbjTkrngjjK3IznGQQ0JDw
	 W1IL6wjCZ3F9I3VwX2G2cydR/u8IHgMphcTtPqqCnmYo2jFUUP39qU/ve1KsIYHEynA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P5yel93w;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA0606A32F
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 18:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ACA0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P5yel93w
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ee254f6eefso6735ad.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794853502; x=1795458302; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
        b=P5yel93wKx81zTadqarndtp3tgnpLaCcMLAmwJbNURvD1O8OfTH6DXTeXB7dBsjOxS
         IiJzByl9jjIYewJysvkrPhUO218+jNUlTjx3AvUFEem/3KHA+i+yFAqAdxn2+Da/cdY/
         9XhxulW+g27I3BtmjLqMuFI1on7ZeHHfHvgdGb9hMqLGWJZC7HG8vrKT0Qe/n4a56o51
         G9cFjy11VI8IMGhQjqw+stHrT56vvVyETiVsAYt482xf+QGeYSrl+N6I62BLtPWyZkD1
         EMbhL9Z26Z8bHZukKZODVyQAAbJ6UC8qhXKfeT+Zsq7eVd+n5j6RQINhQWzILsTM1SOs
         bldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853502; x=1795458302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
        b=DpDgXKHuwjuMjNNAybeJ0BqdPOD/VECXaIU0hNqNCXxGwsETQxlNWkEYFxHrbtRivE
         BgWkCuQeMLLY5TXJJTBScErgsAWKQVqsR6jtbkbNrwy/hjZwsSkUsn/tcbRI877WTlrn
         fziqs4p6xKfJCnllBciNK2Z+Zvq9y9N7VaHLpgSGqpuefn7ySmtnUlmZt2IdGEJUPGL3
         SwEjxCFVeDwUHwDNn46joiqPj85+GUNX2HeYpiWc7B9ZSMnIaEtyHzz6V9JM3DcAWEuV
         JEG2mRVT/BqcG+AOfQA2zt9wCGuDhqyMMV7WEwkmbMTTA4B/6Wkoa6A5KUyW1UMnbQ/I
         u0MQ==
X-Forwarded-Encrypted: i=1; AL+hErH4UeDtAha2zfm2NPreNCZcT3xtl/l0yIaWyylwzWJX+4kEUl12RMcoKUc2oGg+yMFc2HYGug==@lists.linux.dev
X-Gm-Message-State: APuU4Z+vtHwyceWTO3soLUA9g0eKMO6G38b2kUlej5njYCiiQy6iwB57
	dfWX/LAdr40sWfTWO4UZPLDCBZYiSo9GGAZgglWaw0Dt+3FiFGrjAd/u4+gQjNhkag==
X-Gm-Gg: AZFdTZcCPG66p480G4O9H1jbsHGp6zFulr63z48M+YTOjLUbptMfK+YWbPVqn9jbrac
	b3CE3RzpxQxhJkNJuT4QycbGg3XerXMXnVPCvKENHh5V8nGjdVQXOS6imjHseed0/vCqIpUOf+d
	thMo3+RFNOOUS2lxuOtAqIAWDcg+almoiyBiyEzOrnlQGxeedHUVk6EwJIfpKkYOI3OCoSvG5yf
	k9wKfS/Xg98KhXrphLTN1+WG+OK0abCoK/LqkkNGHCQafzvSfbfRi98LXx3Ey58Y6LywstmsGOW
	HKDf41XQri/Eoqmb95cFi1Gzpx2DwUeiukgG5wyvxOCE9EqOFODXrqFeXa/0+5lINAc2cuKClHM
	ZVCQVqRVNRCCPMvFWhDN4dCfDuBkDZdMyzrB6Z2eqyjdO0xbiVPvmzLw9SJ/BLpIGyLMpwtdlL4
	E4h0BAIHbVaDz4m+1ZG8jfJ2IPUq0S6RxBzbwvYK7z3J0YbLp8z5DFjGw0hDdeIwyDIdUfcxQ4L
	ET+CKG2inMzZqaaDFuYfRscCVLbCxOpsjTX+ripRUzffY8uUgt5SIeEcTFNXQkhvqqp8twmvo5S
	szmVBawuF/2ccTnCGMSbuik3557jLUXC2c9dRtoEY47KqfaVhSJB9hr2l5QDlKmBR7nTBHrLsSN
	4iamCWpVReJ8zwqIDm/fCDw==
X-Received: by 2002:a17:902:f68e:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2ee2b19e019mr7765275ad.17.1794853502041;
        Mon, 16 Nov 2026 10:25:02 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac70ea45sm296668a91.17.2026.11.16.10.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:25:01 -0800 (PST)
Date: Mon, 16 Nov 2026 18:24:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, 
	Matt Evans <mattev@meta.com>, Matt Evans <matt@ozlabs.org>, 
	Mina Almasry <almasrymina@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
Message-ID: <avtI--OIZu5E5sma@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
 <20261115231946.GB1239159@nvidia.com>
 <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>

On Mon, Nov 16, 2026 at 10:02:56AM -0800, David Matlack wrote:
>On Sun, Nov 15, 2026 at 3:19 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Thu, Nov 12, 2026 at 01:47:03PM -0800, David Matlack wrote:
>> > On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
>> > > Hey David,
>> > >
>> > > On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
>> > >
>> > >>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
>> > >>     uAPI behavior?
>>
>> Yes. Even if we wanted to the locking is doesn't allow trying to do it
>> automatically.
>>
>> > The way I designed the P2P selftest support requires 2 things:
>> >
>> >  (A) initiator: A device that has a VFIO selftests driver.
>> >  (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_bar()).
>> >
>> > So far I haven't found a single device that can do both. But you are
>> > right that theoretically a single device could satisfy both
>> > requirements.
>>
>> mlx5 can do both
>
>Looks like GPUs and NVMe can do both as well.

AFAIU the memory BARs for GPUs would need initialization. The internal
VRAM needs to be exposed (mapped) to the BARs.

Do you think we should have a P2P device "setup" step that can be
implemented for various types of devices?

Thanks,
Sami
