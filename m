Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A662366;
	Tue,  9 Sep 2025 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415736; cv=none; b=CtBY4leemy+IPW2mI9cV/DUvYfDjaY0+AJ+6ZunhGIgVINNysrEZEEaXPCuwFD13TxvPJb8eIRQWxN/XfPpssSumJptnkZWd6o/ffutGh5zDoQ93agMu7oYqgOaDiiWR9+zahGAummAi6nM98u90VWo7dS+09D2LsCeOO3kbsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415736; c=relaxed/simple;
	bh=aIuqF/ZRe6lFkjJdZM9G73p8wj+XZdKXQkFoizqI+N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DK2dIRh/Aa24AMFhQu8ZT/x6kUviBoZ01c09T8C7bk1qsOp6z+Y2ygd9CTydcK2Y8rFZUC4Np8imW3UQbZPU/li1UhMHhPTREPxeJjBzfKQY2fSdMBYu17I5y66tNuYWQVJWHIgyUE4UgafjhPSccqHoOXxIfkwnWAW12uS9pL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=b3WPnegU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D2DejXVH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="b3WPnegU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D2DejXVH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79245140018A;
	Tue,  9 Sep 2025 07:02:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 07:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757415732; x=1757502132; bh=Qg9msnq0rA
	uxNpy3cVSl50zVPz8zshU7qatmHCWOvkA=; b=b3WPnegUHlfDmS1OorMHh11hLn
	xscw0iz8E2B2UT1Vrtqkb6bBjV1PdmilaQG+gt+BQbaGe/TM+ZuF+AB4ADi1vQww
	9C3BCxqlOKmojJ74Za8NfOFkwhHtbRM+ArIf9FJ1Dh6DG+WRij83qJLar9+wIs+O
	Ao14jN4TfeX+0yPebO/cqErjl17WKBRvOkiLjJ6wy8QBy1RDovicWbOfQOM+xbsg
	SN7CqWRQU+3rqyrnK9tuf5JcyTsZfVHsQgg39blKGqYOCeT0rVml/975pKP3cLR6
	f61GL+q8GDYwt2THwFUc9Cu619XuLiZmO5cpVKi2SN5/MIs2lcZaUQKqOnhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757415732; x=1757502132; bh=Qg9msnq0rAuxNpy3cVSl50zVPz8zshU7qat
	mHCWOvkA=; b=D2DejXVHAPpWktesChxfQ0b9wHeMbiH2mwPjwg0KzN8QSddZa04
	z6wKrQVs7htNREjoiS6yMr/ukErFZqP6ei46NBel42m6keOTqeg4qUyYpK0YB/NT
	osHQLSy/Mh5LyporjUbmqJ8gLp4w+AGo2iSMSsk4Y9ElGwNrrYt77qwxu+rAFdaG
	FC9V+n8V1tSq1b4+yyYLFI3h9/xWTUGafyNxNxlYkr6ZGn0whOfk62SQ2YRf6Q07
	i5MijAAR58gK8Ds5XM7qxWUrBZ3bHC8Epb+rsp1BowGNRl/sWDERSqbFKoBUCBtv
	aFFu+XQOFrZo0NaHqBG78sr/jxeZzJcucvA==
X-ME-Sender: <xms:MwnAaLFDrpki7rBrYfvrxiwKMjhi82qBcvs4C5WRrvdqYESqqgUh_A>
    <xme:MwnAaBwOcZIOKU_bYZrWO5hULjEHA9u3cxtBOzpzqhJEGwePyup_JmYNj3-aUQYFx
    0iimyZkYk8_YP1xvBE>
X-ME-Received: <xmr:MwnAaMt3NoX5TKKN6ln0WxVWng6vfkgJDNmFHiyXvsQq7HS_IyJpXOExkH9lWVMDZVkD9OYgS8fIXga_6aNZdFj-dkmrwGdw4m4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvff
    evleegudejfeefheehkeehleehfefgjefffeetudegtefhuedufeehfeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurd
    hnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrg
    hrtggrnhesmhgrrhgtrghnrdhsthdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhl
    ihhnuhigrdguvghvpdhrtghpthhtohepihhomhhmuheslhhishhtshdrlhhinhhugidrug
    gvvh
X-ME-Proxy: <xmx:MwnAaO124KiCQxhk0Ul-f3KSm1AYqoMw7AMEhqdhRdIs69LwXecAgw>
    <xmx:MwnAaH93FNbe5QXDTMnva0IgY4urGc7-fQmShe8v9FTKAxYgtehW1g>
    <xmx:MwnAaPONOXjX9ikpqEcRGCU86GARAJqQczJ5XglxGr-BqbfHAHZHnQ>
    <xmx:MwnAaLfsrgGr4Jedg9wYzYMPSk5a7rkgpy94U4UOSva6XpAWu0kayw>
    <xmx:NAnAaKu52CYD1IaqBPKaZKl8WSUcYGzM9z8mS_63iwB-6UjnyxJTYVJD>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:02:11 -0400 (EDT)
Date: Tue, 9 Sep 2025 13:02:09 +0200
From: Janne Grunau <j@jannau.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hector Martin <marcan@marcan.st>, asahi@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [bug report] iommu/io-pgtable-dart: Add 4-level page table
 support
Message-ID: <20250909110209.GD89417@robin.jannau.net>
References: <aMACFlJjrZHs_Yf-@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMACFlJjrZHs_Yf-@stanley.mountain>

On Tue, Sep 09, 2025 at 01:31:50PM +0300, Dan Carpenter wrote:
> Hello Hector Martin,
> 
> Commit 74a0e72f03ff ("iommu/io-pgtable-dart: Add 4-level page table
> support") from Aug 21, 2025 (linux-next), leads to the following
> (UNPUBLISHED) Smatch static checker warning:
> 
> drivers/iommu/io-pgtable-dart.c:183 dart_get_last() warn: array off by one? 'data->pgd[tbl]'
> drivers/iommu/io-pgtable-dart.c:252 dart_map_pages() warn: array off by one? 'data->pgd[tbl]'
> 
> drivers/iommu/io-pgtable-dart.c
>     174 static dart_iopte *dart_get_last(struct dart_io_pgtable *data, unsigned long iova)
>     175 {
>     176         dart_iopte pte, *ptep;
>     177         int level = data->levels;
>     178         int tbl = dart_get_index(data, iova, level);
>     179 
>     180         if (tbl > (1 << data->tbl_bits))
>                         ^
> It does look like this should be >=.

yes. There is a second occurance of this buggy check in
dart_map_pages().

>     181                 return NULL;
>     182 
> --> 183         ptep = data->pgd[tbl];
> 
> data->pgd[] has BIT(2) elements.  The data->tbl_bits value is set
> in dart_alloc_pgtable() and it has a check if (tbl_bits > max_tbl_bits)
> which ensures that it is not more than 2.
> 
> I don't think dart_get_index() can actually return more than 3 so
> maybe the check can just be removed?

It can't as long as iova is within the iommu's ias. After brief check I
haven't seen anything in iommu/iommu.c or iommu/apple-dart.c which
prevents drivers to call iommu_map() with a random iova resulting in
tbl == 4. So the checks needs to be fixed.

I'll send a patch fixing both occurances.

Thanks for the report

Janne
