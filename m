Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29B77111
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124775; cv=none; b=Ow7TtoY51UhVzzK3kT/DDEBG8zWrxhtLrOS+sDmcO3BXTaxSFJ7OKdoirN6SC0L/GHl6iHioNoyMpktCBD21ZGSErWBHtLmCqg9Aquyo5Jykhy7Brti6495Vx1h1NhOf0pfm/GLGEQ8oUVwIFVGSD0j3+3QQ3M4XgIxXOvha1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124775; c=relaxed/simple;
	bh=bwd2hym8tNSAdXkGE4hZ3iw7DYGozn+untN0aXZ6tZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poqIvpWWa4oQgkc38Z8mskz4Gw3KTs9/qE5C/XGlXV6BUEAJfD8KURNK9sRqq5NqZ9yiSYIMsAe3RrWroiXcTeUnuwNiK4o/tuRYRydqn3avPdaAGlib2SfRyAe0ti+r18tpvUVA7ze7Q0tdvA0OsZ0tx4FmW/KNJxsYTnmgv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PJ+yP9iG; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PJ+yP9iG"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-621132816c8so1908eaf.2
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758124773; x=1758729573; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwd2hym8tNSAdXkGE4hZ3iw7DYGozn+untN0aXZ6tZA=;
        b=PJ+yP9iGdRUQ/bf2mGJDNDpfNO7s9BHMvtF3wzwPudl8K3MFwpXrSF1xHZuru1kjvG
         Fb4NMDGCLveQFCHp5EQxJkO+n72KNh/Af4LwZlR4V+1qgrAxsB+j6OFTbD7DIFEejUmo
         MPb3Lr+/TyNI4TRi58mzrYjbzssF7ANWtJugL6B4lnBPeZKwTEFmAfdUMqoOYsoaTI0l
         gIQvej553sOi82pBfKFG8Cwp004mMUhIUDQ0chSlIxMKdsgXCZovkDNIxoTcYG/z1reD
         scRthJ+LCcX14CCVtsXTlpoM5suDZHRybSSRKTj1Pj0wfZEu1doui0PCAYykBiZM+lze
         NanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758124773; x=1758729573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwd2hym8tNSAdXkGE4hZ3iw7DYGozn+untN0aXZ6tZA=;
        b=LOINZR8M63+zBTLDmcPuYewKLCDSYi8dgEKKZ2btPQUvcfyOMxJo5YkGPmv/SEu7gA
         PnGtrmJozvB1nPCOMd+JrQokIOZDHu+4Nr2wmW4pGKxFPuwOAUeMkAhyFHtL8wcjwTcJ
         5YE/aZEcoDq11U2iRu4HhM/XD7tnjtatv9MbrEfmqggLgdSsrc4ZFUH8jbt7+ORS8vhM
         I3ZNiphSimhGTItSDCfUq/ALlY0eSTfPm43Xo5WRgV5CW16h2AqDGhK8XY8HnRYUQ9c3
         HtzVDwF0DnOP6Qu7/7S90UTZwyXiPWyL5AeYfV0cKrNmw0ClW2ebsDtz65DYzoB/4MGI
         5unw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Rf6m0bm+MOsCqPyvytdcPwoHSZcYJl/E6iyttStCOI+G77Rdbwr5mQTrx3yjZKIl0xbbJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9z3/giwQ07fM79h/O/ATyTs3gJJhfBjq0tmlnIZPkelw6qpCc
	w+Mm1rZRrgZoeREiinkPsgvOKqc4dL3BV6m3iHlTdIudYV1DPSDRmndCUM0sX/KDz8c=
X-Gm-Gg: ASbGncvOgp//TSiuzd0OjCvUgyzbJ05pNtVac/fWoEuUtKB8RdBQ+ZQZiVwps39i2Pp
	EmeXgFZ4DNVYwo99zhWfCvy5zNrYUIMUeMCsWQCbTyrE/sEjE57gQuu7KPn9BYdgZm1EFIT5dEK
	iKJj+oFzR1ex6ihTNW6ZyT6AnaRVi2mx8V+F1+0/19Ov6Wn6JEjoqSNtm+u/VesEci8BkC3x+GB
	k0V3z1OqJKRO7OP36UXI0QC/ygdQsQ5R6Z54KrjpKTgJzwT/Bdbo8cKtoTuiaZVbXz/A82l+/cx
	+UA5P166wpHEsApN7I0wwiXHa4pEcWuljI9fdecZbTchWH2PYPFvyn3dtEmvDo3udE8NR45d
X-Google-Smtp-Source: AGHT+IFPi2deeD5xpECHK4kizIqpzvjT3NpSt1j+SxaGfjDrfDGe9/bYIqtD0y9cjE6AL0d46S51pw==
X-Received: by 2002:a05:6808:4f4b:b0:43b:2829:e642 with SMTP id 5614622812f47-43d50c63332mr1037591b6e.24.1758124772981;
        Wed, 17 Sep 2025 08:59:32 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b828d6909sm4320090b6e.7.2025.09.17.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:59:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyuZ9-00000008UmV-28J5;
	Wed, 17 Sep 2025 12:59:31 -0300
Date: Wed, 17 Sep 2025 12:59:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <20250917155931.GI1326709@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
 <20250915163858.GK882933@ziepe.ca>
 <aMl_5j8G3IGulAC6@google.com>
 <20250917123601.GA1326709@ziepe.ca>
 <aMrNTny9jgZJd_Ef@willie-the-truck>
 <20250917151612.GH1326709@ziepe.ca>
 <aMrS71vQ_MaVonzi@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMrS71vQ_MaVonzi@willie-the-truck>

On Wed, Sep 17, 2025 at 04:25:35PM +0100, Will Deacon wrote:

> Ah right, so the driver would unnecessarily issue CMOs for the structures
> that are just shared with the hypervisor. At least it's _functional_ that
> way, but I'm sure people will complain!

Yes, functional, why would anyone complain? STE and CD manipulation is
not fast path for anything?

Jason
