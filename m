Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF373DA7CA
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383209; cv=none; b=j74IdF3lwyIrpwntz6y+22DvtHBJ575Ks1teMJSc2cu+tfpoK8UyWuGaSbYyel3GsnGIAAfl1epsSpFfHLBEwzUPjr4+uQ7QgIwH1KOZ+5+8E5lZCl391qa4lZFM2BIeIww5IV+skFpYMrmGgNbASL/RUsOVwYzFoMSkl6kNw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383209; c=relaxed/simple;
	bh=1IqsjiAX0vwjSWriiKDOdVjW11E6rCLofzR5yUGyvCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdETRXCGHt5D8fmRZ89ppntozY3YraI32BKQ7f0G7aIQsVMVDij+vnRXqUVCwjjuXX9Lrvd9UnFKFqA84J0dGPZx1vHABwtm+ekW11Y2SGEeQR6S/fxK8WqoPzvwzjhFGGnyQ94wWLxL2g73+FYKZPIxAtyCe1OIxLHxbGRevRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ku898luc; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ku898luc"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94ac7f22d23so2659926241.3
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383207; x=1777988007; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OngaHwDgRXU8aplL5gx6iXCqNmM7ax8JTAiWS4ELs6M=;
        b=Ku898luc+Ds5rsh6UzYx8u8rOLGg6swkS/BHV3Aer+a8TCsqQ58DFi0zRZOnsw/003
         /nfEPFWNOjQHTmC1TBwo9d//Mnni0PVpUBXKkSqPlJBAFThV2rP58omn9ARGhPPM59yq
         7cTXVis3VTHflKXABcC8w9jFqckeXoII4iL9ACdvwgAH4rbOb1IYQavRWCk1VLN9nrta
         D0Ewho6R2FRrV5Ej3yRXr6/Ryww74hnar3/OyEph3DKMKSmYPXeuyksGvUkewIFnsPuG
         bkNqtSqnHy9dtgA6AdP0lHd7/NhgKTDT1TI+HSJ1YfbR4blryKLeD2Awvr7ajuMCeXoZ
         PJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383207; x=1777988007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OngaHwDgRXU8aplL5gx6iXCqNmM7ax8JTAiWS4ELs6M=;
        b=VFz0IKeYxMJ2pLvPlPrGDFPcTgx8dq8gHUw74rwO/qm8FwkmEipTfZEzQ/MEa+46X6
         McJ4G9rYn0aqgiuFMEPb4nfnWOBa7URxLkVU1f1LVneUXps0U45B1TThXwrW2QZHPW0E
         p6/JZNNkdwMkh1b6p5h9bQCLH2e8pBtcYV37bfzg23BRFMVrOWsbIt8+9Jtieyl3mPDY
         KDYCP1uG1FKF6mw8ojYcSeBv2uOLDIbVSTa/rpiN7oGpDnOsowVQ3L6pTYOtFD4ctaAb
         +iw2Lw1GzOpER+TT6frydUte7IytPiQoLGWEXAvlaPQiYjUtYyYJWJyT6E0quEN+tGJM
         56JA==
X-Forwarded-Encrypted: i=1; AFNElJ99GfiH5GvfApUf8OZVR1vZ4NHKx/6IJxNuQSgIYzvnjFluzjBt6Xs5IHGelM9HsCzyQkxGGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC3NGqm7Mbto5ajbkoBF8acY7M7Z2jkFeyKy6qAiMKarMRVmVA
	HxdPniOrkPONOxHArPLarRrcZmzw1tKGO3jfAi2uWwtKhg6wl+wNf2GAQKFU7Km33ag=
X-Gm-Gg: AeBDiesKvcUGVcBjLBwjN30T76ZDGci4egpwgO+A5s1TVT810aJRfAjQhYoTE/DtWfz
	hcRmVucsKwXSKttav1oBsaBM9vXr40UylJZuzaoE4Bf7oYg8kLtjy3KTIUqNDzktY4hIB2RtNrb
	UJhHdFVUxJl7Jl3TbpXtZwQYeofZhkSH4CXMZvSsRxHbbhYBn5v4/zN+9zjrA57izF4aLenCSEj
	PW2TKkvA3/pLp8zXOIyJHRY2+ja5Y2022H7ghYLnH+msb42jMXLdwwOWFoz0SDqjlKqeq/wtN5O
	fOEkm1TxMoS9PifdN4arILt3iCnnwn8zR8g4til8AtggfqZMXeNFOy15Rs/gsaJYAVahvqVd5a+
	OBrjdwURxpFmMuWbf6n9lj4KPO5FAlQbr93jf7Fq31msFFtaDBNxfmfyae94fEb7kDaNWhxNB4a
	YmdHHMKmU2FP73bZK34W4HQXda7o0prT7NFVLo5hIvIN6tafb/W0Mz1C7aNHGnfbI5lnb+qLYMc
	TCGM4ggIsU8B4w+
X-Received: by 2002:a05:6102:f09:b0:607:4fe2:a647 with SMTP id ada2fe7eead31-6280afc7cc0mr1065240137.21.1777383206848;
        Tue, 28 Apr 2026 06:33:26 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e2842bbbsm19645216d6.11.2026.04.28.06.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:33:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHiZ2-0000000AhmN-3Msg;
	Tue, 28 Apr 2026 10:33:24 -0300
Date: Tue, 28 Apr 2026 10:33:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] iommu/riscv: report iommu capabilities
Message-ID: <20260428133324.GD849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-3-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-3-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:50PM +0800, fangyu.yu@linux.alibaba.com wrote:

> +static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +	case IOMMU_CAP_DEFERRED_FLUSH:

IOMMU_CAP_DEFERRED_FLUSH is not needed in v7.1

Jason
