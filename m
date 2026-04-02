Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29344396593
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131380; cv=none; b=Z1kB6V3GgznL+aHrRe4H5O0a6syVkq5qlYVXs8YcecbtJ+t9oOKBJN1LgjvvYoKW8Cp31+eTgyoPOv4zrgTagL6u5o1h2/rT3peZfj4A3Nx16xUxooGZDqFm14daGTFMD8K/eMTkebFP19nmCctD9o8vtDxFr05fJj/BCIZBKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131380; c=relaxed/simple;
	bh=+KtTbuhHgiuHy+YXQS2vChspL032vn/9QRxOV9xDd6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV2fP1ErLBoya1Wkw+ZTMKt14a/s30GRS5tOXgFsMop5zzsKM68hEERHT2YvidhO3u5nQkC+5S/lB/POTdElFasrOFgGFB8a5wBu04osKz+3PGz7gxiQN3yIbipwlf5I6mfrmRpTQ3bVTJE2Rn3DpMSfRrhTXVNkuqQ+m0iaTNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JIa++7Gm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JIa++7Gm"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506362ac5f7so6664571cf.1
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775131377; x=1775736177; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KtTbuhHgiuHy+YXQS2vChspL032vn/9QRxOV9xDd6Q=;
        b=JIa++7GmfiklhTjs2HKrsrugwH5kuo2/cqn+iVdVe4wb7QCdQNksOQ5zeB0rw8lc4g
         VS1plqQOWSIplIrDDy7zC4dP1Nq1/l5JakEG5S4h0cxuvrd7Gl57OxYyWHbh7V3FUMpt
         oASzWluuyc1UHak65xgcU/tM6qj72Z5Vrav2ZYPKV3TNuC9WBTvOywGapVMWlffy7Il1
         OH01mpFrjK5khu3/nGWTFLczAOzx+G7X+LQaiTZXspdvUoUleLQkxytc6xpx1q0Jaklc
         iPO4oMVLkQrgAsg2ck0mqqCL3FFB3cNqR2AJjFT4ceHn0dnxpCFWiP0j/isFqVsLCUn2
         CYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775131377; x=1775736177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KtTbuhHgiuHy+YXQS2vChspL032vn/9QRxOV9xDd6Q=;
        b=lg5IkxfUGGfelz9plMUlf41npWrpmVoQxZCq7erBmRuOA38bKbLTrWiW38/7Ew0/1H
         lpRj9XiHdShZB7AkboGQuK2Dc5e5o7Yqz0b65OGRu8ozUUuMJLxWrcTeXJcTkVt9szlH
         qwGIawfN/6+4zuDbw3TTnidtyEo9RHMlj/awHKepjWazcvF1Qes4kwd/ZztZ1n+yXiag
         eSrY/sOsxDdGfqRFIdhHYQcr3oYa5kHny/uNVYPeeWktOWCRwYqJHl2lKpCYqK0jJnRW
         bz/gyOsHlfTZ8obUNPqfVr1VEvU4FdcUXXbcPUBByl5q/FbGMQfazCSnSwadtugMSxNA
         q+vA==
X-Forwarded-Encrypted: i=1; AJvYcCWA7e6XWFENvbuRHlkpEnJW75PEVV4cpz2SKILjm01Yci5tC1DeVUjuQ/RKgxJOrUN3inpNmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsNrf/qkOnGh3sH0BLbNOAX4dZBLDNGuvWBSL/oAaKyE0lfq72
	z2YyaszgxMe3dkH/rEjcZnaTJgbkOr9PqbEYwiHgmRVvHCb0hY1gfQKTlrIFUGotpws=
X-Gm-Gg: ATEYQzx54vLBmAnQK60Hi1/jZDODbpnE73q0cgFzpoP2VTHdyK/tgssaCymTRgTQI2Q
	BxBL1gkk3LZXbUrVDun4wb0jdVpw2lDU2MI7ohRFewvQfjI/nzYve6YRPRiXSlftJWHhpps9dk+
	Oir4LUTW3DoU9wupob4DBTzzgqEGrqTeyLzmIx/P+ah6RoqurTGxknqJHRFmSLlH5ZpwkbNCusi
	OVQmhjP9zOYrrKawnK8Yqj1/6ksSEZw+CJvRWCOxZAD9lCVjBVGV+Ac9VgnfIIbwqSxRLHhyuDs
	oJx3rtYYrzIsneD41N0rO4isg5l8dXc4ottjpbakE1QN2G4OdH7rJjfIlyU9w2ySrOZfbRHGkho
	TvRVneGT8XKm3+7C76v4bXCuppZd7Yur+Ej74wGSUFHgfT10oxzSN0b+DCcidQUHqto89LDfpEL
	cqJJXA66nAz6smY6OgefAfiasufc0glgx2OO/s7/g5DDLzliMgS6w4uhNCiZoT0ftzgUdS+w==
X-Received: by 2002:a05:622a:a18b:b0:50b:538e:93b1 with SMTP id d75a77b69052e-50d3bb64108mr80844141cf.5.1775131376396;
        Thu, 02 Apr 2026 05:02:56 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b8da5cbsm20265321cf.31.2026.04.02.05.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:02:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w8GlC-0000000Bm0s-1xCy;
	Thu, 02 Apr 2026 09:02:54 -0300
Date: Thu, 2 Apr 2026 09:02:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Brian Starkey <brian.starkey@arm.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, jstultz@google.com,
	tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev, nd@arm.com
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly shared/decrypted memory
Message-ID: <20260402120254.GB2551565@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <4s75rtsmdfrze4rscbqzyrjyrko7n6sehe7agrngqag2cna5bz@eflmf4kwjocj>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4s75rtsmdfrze4rscbqzyrjyrko7n6sehe7agrngqag2cna5bz@eflmf4kwjocj>

On Thu, Apr 02, 2026 at 10:52:34AM +0100, Brian Starkey wrote:
> I'm not clear why the heap depends on !CONFIG_HIGHMEM, but I also
> don't know anything about SEV/TDX.

It is because the CC apis, set_memory_decrypted()/etc are slightly
mis-designed. They take in a vaddr to represent the address instead of
a phys_addr_t or a page *

This means the user has to use page_address() and then the whole thing
is incompatible with highmem.

Which is fine, highmem and CC are never turned on together.

Jason
