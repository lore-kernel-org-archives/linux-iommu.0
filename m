Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541C1DA60F
	for <iommu@lists.linux.dev>; Thu,  5 Jun 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140304; cv=none; b=FKAqT6J9hz7NroOVceds/K08hF/ym/S8nnjJNZM5or6kBpQkHHmw8jihyOmaaCiDoxtNHsCKAuEa67stAM5aafnSIM7h+Rd97AdWpZ8Ko5Td16X76pE6JQ/LjD7KTBVUPzxB63VOvr4yj65aw6gpwcO6mn6PjTncqmcAkrmTqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140304; c=relaxed/simple;
	bh=ogJrCoaVvTIzKL2yYFVyuhLVOAltgJOAUH2d+aTx534=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/GvoQzBbE19w0+WW1nixNcntPHO4Lok6VaO98yYMzfByiM70lCsJP2Xb8jQ341rmM6/gpMauKi9sstGTE+I5ycfJ1BPNHDgHrQSQlbcPd7Z3lbyCtYd9YFPWD101SfStfpQVULvL93mxKL/ZjlZcsWKu69QUYEb9//GLm+hbhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWbWxUvz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWbWxUvz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ecf99dd567so16020866d6.0
        for <iommu@lists.linux.dev>; Thu, 05 Jun 2025 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749140302; x=1749745102; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbY5hbizTKJKsW/+qsNX0eM08Ews+JJzRarPvAx+lGg=;
        b=YWbWxUvzggKFbJWa3PdKaHzgGOhEbk70EkdIYPw+s1iFzm6VcR1FBpjwmX4Qz5/HwG
         EczC+JP3v5liPFZBIsIg2kHOrFmQujTFy7WfbTGODYHsi34+fuPlR86GpH8RRfe90+Q5
         nrGGfLKBG4j+ftWhnzInztm0DuRsszveBjwn6NcynwBvv4iPJp8uhmSlLbIzzPISNKWm
         6N4roDVx0rBLmNaHw0SzTjllsZ1NttEAlbTaUOXFS06v4O2WkubMGv9NAtSzWhUr8XQ/
         ktbSxZBMxBgwJZBd6gvOhGPd7IOA0qjnx/Wf6tXFVkUJuRv2ZsrkslhWZvBM+yRKf6Oo
         xvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140302; x=1749745102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbY5hbizTKJKsW/+qsNX0eM08Ews+JJzRarPvAx+lGg=;
        b=c/f9T64CAlXrxFOT3YhCTEpYNbmQjz60zgob00QZfH0mOeBLZvmv5xBpL+WJnOuHEK
         njlAeNeoCHp8unQl4IOYWbs5Ej2IlxdPLa8uwi1DRpg8DSASXM8ivN1Q8xK4PnMHks5x
         F85oBpA8y04btoPRSnpi7zBlnmLuZvvjaRvsCfyvl5XSN4afZRZP4acz334M63F/zkD6
         kek+/KKReHqMe+dRfpdWh9Mvwby5EXLKenU8xOSTBPgavnkEZ4MjGxZXYPPN/NrZBrbF
         knbLa2414UbmsDOTVQH0UUFfvz8KE05m74Y9MzB7npmRQN9qUW6s0YGqbveUc7/UaImN
         l7IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZkVxlb2oOifyFEH2FCAVsFpRodvY7Cysqi8icFCilZlRgYf/PdQ0Tf2xWLekVRQi5gwEcnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR6O9/Gt+IylV0EeLc7WIAcsehI07S/XSE7IcGTh73lWTK0iJ2
	7PZ5P7EJ+IPjkJ/hYXeT66Avq61FszLYZOeIzgCsahCN0wvBJbvfQRjr
X-Gm-Gg: ASbGnctA4GEF6A4Jbaql38mxCPY4BhWB5OtMhk7LIKDBLgPUSSNapAJWu+vo9TektfD
	jAFjifuBhVa9tlfeCyfheFKNPBfb70E8d1K5T2ZLG8oFj+Hy67PmLma/lEEK7kA2Ie924vaH41h
	WGcX9QOZl2un3jNXqcXX9UEqx/PKF3jMLcBnilVF3WcO7iD3KW/p4OUKpXmhifxsa1hXNxqwvG3
	n2dWN7TwwJVwZBQTFFKVoOC8DNdM7SX8+ax0pjbn46+SdLUAH0ZUInIf3NTj+GcghEa2V2bRAgF
	hhgmH0h8unsLeAra6t0lfVuwMkdpcFa455oppQtWyw09r0N3Yh6dF4cFZDqt7+VWg0AY2cJ1VeF
	+00HwZzQCiHwl0mfSoNg94CFweVzzhLB3nsVTRrfLBcDTP4CzmrfT
X-Google-Smtp-Source: AGHT+IF3xXyEOhomjTTmsFQhhFbW4GVFEZynW/c9+WcQa51NB6yyngSKbSP2WOCE39LfAtPOvQsvPg==
X-Received: by 2002:a05:6214:1bc8:b0:6fa:bd17:338 with SMTP id 6a1803df08f44-6faf703078cmr99881616d6.41.1749140302102;
        Thu, 05 Jun 2025 09:18:22 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d5b3dcsm122932266d6.52.2025.06.05.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:18:21 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id EF2051200068;
	Thu,  5 Jun 2025 12:18:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 05 Jun 2025 12:18:21 -0400
X-ME-Sender: <xms:TMNBaI7v_Otl4sbqaGoHEsbHW6ImxnW-YV09QFGKGIAwJPgtWzrGbQ>
    <xme:TMNBaJ6vyfzlZC2W4rvAH8C6TpMwtwW293eUr9wvXYK1lQbM2008opkhCPamyLjsc
    QcdjyE7qrkPPs7mZw>
X-ME-Received: <xmr:TMNBaHcSsLYsfmnX-au8Z5xLB-HXtVeuZP3TSayrtnokUyUUHikOaWE0Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjghhgseiiihgvphgvrdgtrgdprhgtphhtth
    hopegrtghouhhrsghothesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprggsughivghl
    rdhjrghnuhhlghhuvgesghhmrghilhdrtghomhdprhgtphhtthhopegurghkrheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrg
    ihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:TMNBaNIyJnZdJIo7S4w6fKCWQ7F2a0z7ohxA0hG5wFmGfnxl8Vsggw>
    <xmx:TMNBaMITyNGw87097O3SfTgdd7raNlzKJdWMDAaxJw2K5skhMKCkig>
    <xmx:TMNBaOxRrweMUIBmqaOKZghtDNuAMhihd_r0gzvFHv_JvU3qRGJ5Qg>
    <xmx:TMNBaAJ7bWlavrp6D2fn02tDLPAmUdabe56ET6GnNQpYedKcZ1Ovlw>
    <xmx:TMNBaLb4qWpIHS3nGfjptuPG5XOofezbGHMoSnJPtc6bkiW2RxnCex_t>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 12:18:20 -0400 (EDT)
Date: Thu, 5 Jun 2025 09:18:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
	lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <aEHDS0YPmkB4Uto_@Mac.home>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca>
 <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <aEG5X7FduqFvgXxH@Mac.home>
 <20250605160204.GC44681@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605160204.GC44681@ziepe.ca>

On Thu, Jun 05, 2025 at 01:02:04PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 05, 2025 at 08:35:59AM -0700, Boqun Feng wrote:
> > Late to the party, but seems to me the main problem here is that we
> > cannot pass a reference to .set_page(), note that there is some work
> > that would change the Rust struct Page from a `*mut page` to a
> > `page`[0], and then we can impl Ownable[1] and AlwaysRefCounted for
> > `Page`, if that's done, then I believe the correct parameter for
> > set_page() would be an ARef<Page>.
> 
> There are alot of things that want to go into scatterlists that don't
> have struct pages that are refcountable (eg frozen pages used by
> kmalloc).
> 

I see.

> So I don't think you want to go in the direction of forcing
> struct page refcounting in scatter table. That is not how the C API
> works for good reason.
> 

Ok, that's fair.

> I also don't think it is a good idea to push more struct page stuff
> into Rust as we are trying to eliminate struct page from the

Well, that's why I suggested Owned<Page> and ARef<Folio>, but let's not
get too deep into that direction unless necessary ;-)

> kernel. It is better for rust to stick to KVAs and convert to struct
> page in core code only where absolutely necessary for someon reason.
> 

Sounds reasonable to me for now.

Regards,
Boqun

> Which is another part of why I suggested set_page should not be part
> of the driver facing rust API for scatterlist.
> 
> Jason
