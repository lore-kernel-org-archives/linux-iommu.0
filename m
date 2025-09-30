Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33494225A5B
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256561; cv=none; b=I9fThkERyj0vsfiAkt7sH3BLL5HaHCZuAmKLraLX9xOpUs9jEMGvmIakGdzB7Z5AkuFoBrj0qHDJ0CgtHf+jRl8PS+cu0wltfsDEASFrrtrGzq/l5H11P0NzdlIUyxgi8vxb68OTGHUZksnuh2m78pH2P7HoZlukyLfCavrHMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256561; c=relaxed/simple;
	bh=im1LjyWmm7IGGRLU39cMjP8TMhteoUNMVyPehrlCbQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa7jY8WSzBRpm4Dk0mGrn0n3PCSkir6AXoicfinneeSvhXcek/gkJskbsDQgvIquO6fOb4ZBLj/gNmKlFWIh6Ql5RG0MLT1X3gJUXxbGebwIsyNO99p5Tx/DLRqQXUy68I2yVvcTTd71/wIYfhtdrk772hLe9fiandGSfNNVO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=di582GFE; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="di582GFE"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-79a7d439efbso51293686d6.0
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759256559; x=1759861359; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=otN24sD9ba0651HU7vyiOrWLd6JoFW5Z7voVaID++QE=;
        b=di582GFE3dHMQSAsHpqnbtS3JM+aBX8gO7nYw49j/WW1k9GD3R2ky/XxKs7rKGJY/k
         uJ8nQvT6QHjs/XQ7Y6Wcr6Nv1E3KD8zQNj1L2T12L5EwERlMljvZ6hVg+xRotR+xY7HT
         gnG+cZsmnCBf8W0wXuSNVzR/pm6qhfxZ+iMWE2G1Jdoo0Eo/EShbWnfg5HHoTdxPWz4k
         puBRRU7uP9TycYGITBFWKTPgIpLSoGUDcepPt193rtZoQ9JKqiiTLK4yej6gSl7sQkTW
         43d4HRbHatLtYYnKR1eQQyZZgdwv5gbAkYaWG4l8+4oXA1M8nctxl8RenpifojmZeFkt
         g1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759256559; x=1759861359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otN24sD9ba0651HU7vyiOrWLd6JoFW5Z7voVaID++QE=;
        b=rOAqXc55gU8EspIesyXjNmV8vWynFUledsFe7JWnyNRUDGoSXHRaq48reLbKwQuKi+
         YHOXeCwF3r1Ht48sCiD1QtFFMKQCWyW+s4WFNjRRZ7N1xHzwI5j3L6JqBNviDES2PeBp
         6+emgfxPEtf5eNqoS0KpDiiAnWgnd0HGIGuBPGQhqoHu8mj4ZfeEStF8U+DCSdwqDTAD
         97fEq4y5tyQWDAQIxbm9tJOgE78t5ZUPqP+qqU416Mur2WgubFawr6W7MLDRO+v+nZUd
         LfGGJn4fnqkqVbHKzViPL5ZtN6RM52mPbQ96yhnZxRi/SCEz89RnLoZl+y3RdY9G1adx
         +4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA4m1HXU4mxz7ZKsWPHuIyfUfHESHKS+7u4BgAlCb0jh9SwJce/JBIqU+bSMOEu6vEAxB8CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YysHB40waMRG2BItqYOWTNFK7APOf4QSfIb7beoTceB4hW2vddJ
	AvoQmxif3tQySgJBSF4t2Znmqd8Pv219azWoud6cGI9NM+o2xHXxXIWnqZct4LUXKN4=
X-Gm-Gg: ASbGncvjmZGakhpSU3p/PjABqpEad403lcHIuSdaKAB4Yzl5jARm5s/QxL4YDDJK05E
	uRfXD1NAQzqGk9fFiuvcdisf3699MvHO1+3tv4hKZ1TvFEFHh/DSwyY+QX6AkX04U1KzMxhh+ke
	qtftIOYQ7yxL8Vpp1FQYQDboyZjYfH0ZFy0urzmUCiiW+PZDU8s4M8RdKFJEFrfiB/BhtCgsA0k
	r5ldnIW5AX2AgrNZeR/naXf/F+NSf5v+XO57fgX2gaAq8lQfp5McODjkMdllwotcxgejQ9UIBJk
	v0Fs262u28GYS4FYWyanL0JXbtFiKUzYGBgRpH3gLwPcR39M+MlntuCN56XiQLhKhJP4SgACohL
	/4cAPjeGbKaLVspbi6vwPYN+BFT12wXw=
X-Google-Smtp-Source: AGHT+IFdQ6HxqFf/rsGHSqMtw+RYaDUIz92vgbk3h3uGCuph8KkCY84Ws9PRWpUgzYwvFtXBvKPANA==
X-Received: by 2002:ad4:4eeb:0:b0:766:769e:8c8b with SMTP id 6a1803df08f44-873a78f2c46mr9259176d6.46.1759256558992;
        Tue, 30 Sep 2025 11:22:38 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8016e952d26sm98259256d6.59.2025.09.30.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 11:22:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3ezl-0000000CgRf-33ag;
	Tue, 30 Sep 2025 15:22:37 -0300
Date: Tue, 30 Sep 2025 15:22:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Johan Hovold <johan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] amba/iommu: tegra: enable compile testing
Message-ID: <20250930182237.GT2695987@ziepe.ca>
References: <20250925153120.7129-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925153120.7129-1-johan@kernel.org>

On Thu, Sep 25, 2025 at 05:31:18PM +0200, Johan Hovold wrote:
> There seems to be nothing preventing us from enabling compile testing of
> the Tegra AHB and IOMMU drivers so enable that to increase build
> coverage.
> 
> Note that these could go in through separate trees, but compile testing
> of the IOMMU driver does depend on the AHB driver being enabled.

Nice!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
