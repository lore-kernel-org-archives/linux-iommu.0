Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDD26E71E
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448357; cv=none; b=nH0+Jpn1CAzxMser3S9tJfL2ifUkLydWaVXh/+DKnQKhyWdLt2PAyuZrx3soLZAdrOSWZ9B/mcDC8YDn9WH6rRHjrzYOxIPKdgB8+De0AFtS8O6GakfzrHagZuGJsZ3If8wwBLxwBBNpdADuOoj9lVFiil9/S8PqtyHekKARCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448357; c=relaxed/simple;
	bh=LHu0GHEmte9bNVYdHYkwG9CA4CfbBZuMIjXj0kPY41Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgMYRnuzRcOcDeL8TJb8N38aOpVBtGpQXJ5EgOQEZ55n8urwiVmvqrquNFqDKHx0hH7cyA/L3CeDmtAljuNUW/i2TQhTKH5FCE833B86HwEXBGx8juXJlLscbIN9PKd79XgFbww9NF77zBkBmRAA2lvdEoUTkmVGW6Z9vkYoOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QmGsXHQ2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QmGsXHQ2"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ccf18ef922so53718946d6.3
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 17:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780448355; x=1781053155; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHu0GHEmte9bNVYdHYkwG9CA4CfbBZuMIjXj0kPY41Q=;
        b=QmGsXHQ2RiWdh5XprMb+RJFVANJdGd9g/byA3Q2sJ3BILpu4lan9qWbpborabtTAsg
         aqSpQu0m8QAkl0buIYHIXgnuDOQXdEFk0+QaqUeIGvQG/MV21VKBz+Y22fr/AajlQG6u
         4vnlqy+PiBfV8bWHL/nfuwd4WAZQsoMtfEkBuWpgwod4WhsvatB7GUbF/u5+q6kj0+Ek
         SzS8EXm7sGZOZolUpX2R88ffTepKZwzRNbllAU7O59+qgs9Q9zfbhmQmwOmbp644qNIV
         cCeg8qzKVaNG39uLqXqX8YfiQzojJhr8BDETFWlwIuBbraiAs/OoOd0f0FafSdjNSRC3
         IDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448355; x=1781053155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHu0GHEmte9bNVYdHYkwG9CA4CfbBZuMIjXj0kPY41Q=;
        b=BVyiC9vCfIjoNVh+X47X13qGIC1kZqXwr+9oPPN59NfCsS34J1MeeZeIa6NP9f9li0
         4I+bnUQNoGnSb/tSq7yKJ57MzTK9Yj5qHbPhz43UndIB+giUKNfDAe2u7JbJJ/kVk+DZ
         E8ZARd79VWvPdEcf9+W4XDSXfBkxHkg9fF01PNa9Vnta6irvbs5QnMlVnRbZ+3h3YUoe
         /zYuc1b6tIAtAa9Mf1J52e5PQmlJiLHBD3vZg04MUCxQIyv48969Bnh9A0uQEgy6PS4I
         ggfy3ZZfb8QbDaqJU2l55lcGhQCDHa2tb+AvC6fPikYP9VRzKuR0rhg9KQUPLsOkUJP8
         Ir3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/9NkTzZ/r8MfgNrq+YyxYFIKpy2FnJwfn4aU8D1pHzLdb3ga0tIUvp2f5MQOec/IWQRTP1lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKswbuWssqPXOU5+RdpoXU3Z+B271M6eKSuFEBGe2MTjDbPBJu
	xF5G+fjTOtP8ALnpsVlzdmOjYLysly6rL0MrHquILoI06KUA+38fPymKix91iLD4ZQg=
X-Gm-Gg: Acq92OH3HPXFoWz5MbtY4hxCIg/iHu3e8h6agdcXE5aU605BflkS0SeFaQcqjLPOwbF
	kj0qAjet8DprE1RidjJcU4i7dVdpzif0LQZYqR1JRXNvQ8l1cH5HNpiISzIE8EqJFh2FwaA8Ko+
	LygL+R1ibu0SZeXI/RA1XfjEy7TqZLK6vf5HGJWfxA7YfvYUBJBTrMjtyaBVeGvlJzOMCQz8OUc
	Wzvx/2/uMWywMrxUssUAOJifhjDGVClla8pgQfnnczK4Uh4rhX04m9VSk8wJAlTUDZ1f7vKJBNn
	5Eg3xgpw8HXgz+sBdte8f6IDWr9D1lcRG6/jx2UVbm2NLl78Kvy7Hh6y3k0SSRXlpNeAKHOE808
	m/J/8CxWN68blZaDw1DiCVdYarsPM2DBeTJcSK2942c5xgOjc/2VbWCE3bzlhdOl8ywqH1rx1xx
	/NJwgowm8rBT2iyabbIJeGNCa1dbe9xzUK3+wqcmQSC/gmEL5nMDdL+JkHPCFNF8r11sAlVsQji
	sbm5wR83ta/5Cyb
X-Received: by 2002:ad4:5d42:0:b0:8ce:cad9:479a with SMTP id 6a1803df08f44-8cecde9cef5mr16020226d6.15.1780448355181;
        Tue, 02 Jun 2026 17:59:15 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd0535b0sm6677916d6.28.2026.06.02.17.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:59:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUZwv-00000004xMg-3Yl1;
	Tue, 02 Jun 2026 21:59:13 -0300
Date: Tue, 2 Jun 2026 21:59:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Ashish Mhetre <amhetre@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, nicolinc@nvidia.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on
 Tegra264
Message-ID: <20260603005913.GN2487554@ziepe.ca>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-4-amhetre@nvidia.com>
 <ah87dzHOOTNGBBmt@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah87dzHOOTNGBBmt@willie-the-truck>

On Tue, Jun 02, 2026 at 09:22:15PM +0100, Will Deacon wrote:
> be inspecting the command array in that case. Generally, it's a pity
> that we can't handle this all a bit further up in the stack when we know
> exactly what operationg we're trying to perform, but I suppose with all
> the different users of the invalidation commands that's hard to catch in
> one place?

There was an earlier version trying to do this and it was pretty ugly,
there are alot of places because this errata touches the CD/STE
invalidation flows too.

If it was just invalidation it could have been solved by manipulating
the invs list and be almost free on the fast path..

Jason
