Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF752D8391
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501260; cv=none; b=SImzRMajRJyN2UGCIdNU7AML+ZKBK0Z813YN8dB3diwCYdwu5mibL95rY7t6A4zcLRQKKZ+3voCfJNsfJW2BNMlOTZvJd+3/6xkekpQ9xC/+7gosCxqHvp/m020S/QbMqMRVINCa9k5BX23QEwNKqHHe9EqU+faT4s8LaWR85oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501260; c=relaxed/simple;
	bh=mqXxmLVItLLxTPE7v7NU8HoWE7R1G2xKWlke5C9C/JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPEbxyfj7mNsN0XqquG1oU32KLUVOOCQY1HSQlHZj6TV/hMeBH9Nmb8lWo16xz+nrv/BnbTr1qvuAqfD5dO4TgdigO7LkysxeQVDqZkE3P2O9PnESuysDu/Tk0q0msTRFnMV65J3ZOHZCf82jOPuHYVer7nlhxWuaoGDpfeM9Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbdXK6l9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbdXK6l9"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so43135e9.0
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783501255; x=1784106055; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QiQMvuBEKbz3IC4tovbH4hMkKdurz1w/2IHV/DGw0uw=;
        b=cbdXK6l9XaIv1GTHbtIdzjKM1qu2m+0cx64m4yVeXECP8lN4KXK6pzfRJAa+wnPh6B
         WesM5CoZaKZdxP1wZQz5Pl9V8+Rucs9CGWfTu1HxDzQ/0pA2azuQixi71tkz950LTopV
         Ka8djjzAaqftC00O3G8QeLlbEfVRFcMhOlLugK++bMsK39/RSQOF7NWY/ruoGpwoDGBw
         jiiNY8dItj5g3WBzGouUR6HbttWaSzGiasWgDER9Ro87EpLtim4lxRrRmTYsFxQnd/cZ
         PvAtdxRJA1XZgBIpmKhFE4nK6Gw2bkXpXsSg1TUnOxD52i2Ctpl/zSVrkJMzkzJxsyhA
         7bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783501255; x=1784106055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QiQMvuBEKbz3IC4tovbH4hMkKdurz1w/2IHV/DGw0uw=;
        b=OFo0JMhhtiCbmCI4f2NrJU0LQC0SV4nI05OFUhV2C5W6oGyUrY2zwzmmBxslN0mxyF
         9Q4C7YFm8+qEZTiDtOYjbVj8rqPRI3iMq5ZTWi4nmFGIB0g5VcKnFTRsPhmwtmwiS8tA
         VOhe/xWEOzvfd19XqtHYHiyNXNEwux5ZirBtlgAbgldFhAnFszu4b1hBc9MiUhw9cMz7
         ufGopvmryY46oruuComF9UxQwXwFo1UXcxzts0Dse2hrqguwAUvvzGd27FK/LrppYHoc
         9IzmbkUAD2/uwtib0OgooxcS/ZM4bn5pEGLzuqs3GWMC2bApiGvF6P48jyC/d4Og1lA5
         k6cQ==
X-Gm-Message-State: AOJu0Ywz5iK3AG5jVQUJuhvqF+cJp2B7n4MxdDKj5r0/vPQsGhIIW2S6
	JsO09OoIboGB0tshYpaRyx8P6Eiuv9qgZqcbnwVSfKOqniIEFW/LDI7TwzEXHWvvwA==
X-Gm-Gg: AfdE7cnpzuruOciHIZawRCxLM5JEMBLhWgNwNGW39sNxO8B7E6+lfen4T8KJKZXy5tl
	7a0ceH7IOWIQT5hK2sWBBjY6cSBblKmx5JS36xnbU6J4Jkpf7PdWXtkuApdVyxP7jHovqbzSHgO
	EkUHWQnMgRQgy+QaD7qKpdL9ipy9k26a3roebjHTSw60GZMUYAtLZ6+Nz2ZFamvGg9ol8sW3ZoF
	rkM4kHyJHoYbAl5qDX/jPUYnamH5ouwogr6XafnYt1rkwoTU/gd4Ny44ZiK17fO5MqDIoqtuqS+
	Huxl9db47kX6xgYNUM5lZY8cxEx5Uff+ex2UcqO64gQ1PhwFqkNDJIQZhHpAWXl2ONI/m/SJChB
	GaMNEaYFUZpc/oYtpqUocOegsx4BknzGplbE4aeB1g1+vLB7BtBXopxlirH3m0VGO4n1ex+ij5y
	JLc8ZyOgL1JSO+15SL9+E4cn7g7NiTmUYZdQ6Feug5h5AmvNGx
X-Received: by 2002:a05:600c:591a:b0:493:caa7:4fd2 with SMTP id 5b1f17b1804b1-493e121b946mr1933975e9.6.1783501254766;
        Wed, 08 Jul 2026 02:00:54 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f41014sm120832345e9.6.2026.07.08.02.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:00:53 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:00:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 5/8] iommu/arm-smmu-v3: Precompute the invalidation
 commands
Message-ID: <ak4Rwnr39HuP053s@google.com>
References: <0-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
 <5-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
 <akzoeexW-4W70QdU@google.com>
 <20260707145812.GK220801@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707145812.GK220801@nvidia.com>

On Tue, Jul 07, 2026 at 11:58:12AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2026 at 11:52:25AM +0000, Mostafa Saleh wrote:
> > On Mon, Jul 06, 2026 at 01:26:42PM -0300, Jason Gunthorpe wrote:
> > > Store the required cmd data in the tlbi and just copy it out when
> > > processing each item in the invs list. The cmd form only depends on
> > > if the instance supports RIL or not, otherwise it is always the same.
> > > 
> > > This avoids redundant calculations for each invs entry.
> > 
> > I do not understand how does this avoids redundant calculation?
> > This would be the case if the domain shares multiple SMMUs,
> > otherwise, a range TLB invalidation should be unique and can not be
> > reused.
> 
> Right, if there are multiple SMMUs for the domain then currently it
> recomputes the range for every one.
> 
> At the moment I think we can't have multiple SMMUs per domain but
> Nioclin has a patch series changing that

Yes, it is not possible at the moment, I think it makes sense to have
it in this series, but a comment would be helpful as it is not clear
from just reading the code.

However, as I mentioned I am not sure if that actually helps on a real
system, is that something that you noticed during perf or based on the
code?

Thanks,
Mostafa

> 
> Jason
