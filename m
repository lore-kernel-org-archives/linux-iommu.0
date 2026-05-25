Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A730C34A
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727639; cv=none; b=rgRTSU6Wd64pB01cc+CVLsyjouWiwYMXYnAwefJrIQ16bzDAMEeAKRnY5QAzI/SGvGzd1T361xcfJgM8BDSPHS1clBdwLmjb1i875fKiqRCbac2gmZfFozL1IJlbuHc2VvydFN7dl+lwxN/dOtCUDwxxktwZrfyB3aGDHedFKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727639; c=relaxed/simple;
	bh=ICS7Dz29jLrJ1wTqVXTj0KDShL8/FYLDELZ9YhttbOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLQRIAVv15l82pqQZrAIJXpiKUq7yACu+1wY7Hw4/TSozdVThQFjr6vVRtL4gbvlsNzwkpzaAobJjK530TaF87ge8o54a0fqRrVYBMFLNlcEAXHb/G2R+XRp3ntESydJIimjNOA+qI4pYeFy/wiwlElamtV43C9cyOXFG/BwpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=m15TvQYb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m15TvQYb"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-90d042fa745so1754212585a.1
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779727637; x=1780332437; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICS7Dz29jLrJ1wTqVXTj0KDShL8/FYLDELZ9YhttbOo=;
        b=m15TvQYbYBk6DkY2ffDtXvxE2tTwVGmWbhLmesCBy+3dHW63BF249soitJ+oiDDemO
         69SULYUxj5KB6h3Zu9DxfQdEiI25didMVfvs/jC98kPpVtk/mb58kgSh6FnAr8U6zRgd
         p8k0nUvaVCua1XCskT6GNrGa6nW7PTt0GdZ7rWcxjwD56/62OJpZ6c2Q2MVveeDJgNwd
         lseCCwSDswvuxhZZEQtv4bapvxk6gCJDRXwTUdI6+aq6tU88KspgWtUp4PJTiceu6nzX
         sDbk8KqPfvECjeOhOEqQR7tx557lf7TbCgKZS68ImCXNxeIpeJ9oxt6OmhzLw2pRDZwP
         LXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779727637; x=1780332437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICS7Dz29jLrJ1wTqVXTj0KDShL8/FYLDELZ9YhttbOo=;
        b=C1r1rotmEmlT7TTw7+ZH+sEhU/xrKhwlB39JvnhpgzOewdAbnRiECwLlz5BfHbsuDx
         2Eav6yF0qiwxsf2TSnE/rylXt6OSRwPbMGnQ+bLC4pL+/yLXCfEDfg9gmqPncw6K8wZo
         AsfapwbTtvPTo0CIJ71HbdHx2+FUuwuseSzPFgLX0OVG896koZXuOxLFRy2q4mTNRWF1
         8NT6tUqLAYPbtoSLoirjDEHYy0eU0aRwqYYGPHAjyZ4evhEgVJktHXg8dX1rr4YXAVKm
         DUD0KYY1SxAQoK66Y6x9kORcdK26X/HUeddXeUBggQFIiJ5UDN4QXr/q7SI98xMClM1Z
         0GAA==
X-Forwarded-Encrypted: i=1; AFNElJ8t/7T73/JY9Sc1zP1cML0Lcnm68QJPuh3jYRvpccLoRSQssh9p5ItBYmPFUxyt6XC2H0P7dA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxJE4dTB/8IREdXbO4YZfEOiH5THp4fXiimNN3ipIY0JkzpasJ
	sWaE6WdvSmpPqfxZ6O+2FoCvsespPKUHPjryYDROB8KGL0by0+d2+gIZehtCOC53hlI=
X-Gm-Gg: Acq92OEk0n0MISvnVgmfLlEzoWGH7DFhtwrl3UeY8MN1G6I+kY1vOIB5sRXFPnmbfAL
	8PaZu8ZvlW5EDOPsgvfEY93VHIC/WR9ek7/chcxLvzTC1djxdA+gMYjGrfYQZhIiex2pqYNwfCo
	CZ2WclQd3OxzYqpCqs332gs7rXpJzNpaaqzb31UYfDjbouYVD9ei4TIrTKI3CA6hAvvo0vkf4bw
	zrgtDEDb1e8WBDiCs7mdCRjizbQwzIWST4gvL1EbcsOJtkqnSgN3cjtdxcLys1TechJdovtdk0Y
	yMrAQaaYIWKdJn5TqwRG1ssYMZQNKkP6VxubI43SdpLFgatQPS+ZLyuhhmlZyWZJRBQxQjeYIxP
	NiOPu1hGUQA31J6PQ5F1qJkSNi7Njsflt3Cz4lCe9Okm2r5jUGqKCpFUpjIgcGcklGnmcq3z2GB
	tzwBk8Mtzpo4aNls9Vx2MzxuG7V3bWNwxws0CiRShzGp8YnOiBzBxC7GWQD36oltweLkOEClh2h
	U8ohGmP7kVPG9xy
X-Received: by 2002:a05:620a:690f:b0:914:cad9:fa2b with SMTP id af79cd13be357-914cad9fac8mr1258537585a.55.1779727636838;
        Mon, 25 May 2026 09:47:16 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9d6b1dsm1068052185a.26.2026.05.25.09.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:47:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wRYSR-0000000AbRY-2eeV;
	Mon, 25 May 2026 13:47:15 -0300
Date: Mon, 25 May 2026 13:47:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joonwon Kang <joonwonkang@google.com>
Cc: kevin.tian@intel.com, Alexander.Grest@microsoft.com,
	alexander.shishkin@linux.intel.com, amhetre@nvidia.com,
	baolu.lu@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
	easwar.hariharan@linux.microsoft.com, hpa@zytor.com,
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com,
	joro@8bytes.org, jpb@kernel.org, kas@kernel.org, kees@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mingo@redhat.com, nicolinc@nvidia.com, peterz@infradead.org,
	praan@google.com, robin.murphy@arm.com, ryasuoka@redhat.com,
	smostafa@google.com, sohil.mehta@intel.com, tglx@kernel.org,
	will@kernel.org, x86@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2] iommu: Allow device driver to use its own PASID space
 for SVA
Message-ID: <20260525164715.GA2487554@ziepe.ca>
References: <BL1PR11MB52710D3CCFA2F75F6B540A468C0A2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260525152924.524721-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525152924.524721-1-joonwonkang@google.com>

On Mon, May 25, 2026 at 03:29:24PM +0000, Joonwon Kang wrote:

> Currently, the only known expected user of the new kAPI is our team. Since
> I test if the patch resolves our problem before sending it, I believe it
> should be good enough. Do you mean more than our team by "accompanied
> users"?

He means you cannot send patches like this that only serve OOT drivers
to the mainline kernel.

Jason
