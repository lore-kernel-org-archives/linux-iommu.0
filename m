Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E33BED24
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324374; cv=none; b=pcYjh+Umqy4FjvuWEXRG9UVvNuOGLgk6egyypHRaAHIQAXxpuLLZQfDEtG1ArA3XGALOXnfOQYiZveW9nlT4qblkB3/5hXxUAG4k320OKljQ9QHrp6OTlG4v83Mh8ZSB43aTRuvX2rsi7hxid0CmJiHScybPofOu+my7QivcIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324374; c=relaxed/simple;
	bh=GWT9f5g5xTs3pgj7dYhq926onG7epK/eJHZ5TO13AI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRasoLw0Xu1HqrFsvP3ICk29g6dH5IEUMVSzt0lwAG/Xf8sXb0EB7HB2KbjdKru7WCG4gRhlRiYfhg1AYZc5AB5fMUbGQcEvJ8KOxzCO3fqbsNk6hc2KaT890WrU28Ul0lepl03nvbL1rLr9ovRn0JCfZQo17WnDN4VEaXZwIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lGjNZt5v; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lGjNZt5v"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9156b74006aso44570385a.0
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780324373; x=1780929173; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mi2AxBnDBuiwVVwwXIXlKf9rcXdvhFLnG5wAFAlVNdc=;
        b=lGjNZt5vjvSDJe+BiFhSYnrRzDHQsS446rKbPVAXSJYH+9EjTKigrFdsezMdlxCgI+
         lC5l5XSbK2n+g0/JJhnr2x5KkVGMneLkGmuDzYCw0Ghwhd3JF2306J4UQCInBiAa+xrZ
         fbIZHmcQZ/kI8omWW9n+i4YstpUCrNM8zULmlMLd8qXuTo39nlwHHErFFQEgWYdchnyW
         o1KifxYsABOfqHzzTpvWz4YtDs2GPqycIG5/lv10zKRTMxwbmKFZ7R8Wpid0G3/piUDG
         ABANZhSLc9FNkZ+/5iEFDnPbTWxXOFAsg2sOUauj2zEF9LW8+Cy0FYUaFJUUJ/E8Iq8y
         7GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324373; x=1780929173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi2AxBnDBuiwVVwwXIXlKf9rcXdvhFLnG5wAFAlVNdc=;
        b=a+NQTpt7Q8fM6fXKA+VcAXJoqaHyPK6VoVBsfOJiZzKeCfyL5FwNZm84+KRbXmnebA
         FOBhBe+GRpJCmnxU7KfFirGMo7jNPIcszA+P/0TD0We4nNDs+97/XQ+4fMntGn2Hdn0T
         FkK8iy01J+FUNYmUROg5wRcuc/gGCuzvSRnrUampjRwJ5FT9sXUUXCoI/vMUNwg2w1Gd
         7LkayGW4sADZGIoG5HEmUBR376Lj3U+kAhKnW7MnnLYoC7Ve3FqsZnsCyLDztNDe1tvy
         VjjBv3PyawwP1/CA43xmsWSJXbx0SVTFDDNUwWqjmgNvWs2zIIVkISdyouijMLmTTlKu
         gqew==
X-Forwarded-Encrypted: i=1; AFNElJ99oqmPLQQIlAyRVjvHH0FceuNGt0s/vhi52KUFrFs8TxFxguSCV9A0RYd/gENEUmGxRGZ0tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZHjiogc6TWCmyRgRPMaqt4JEaNGdjPkZ9A8+51NtPGxMyUh1H
	8s1b02tmF4xCNQa2D2dG5DsPPOfm6KIejTX4VbnpGvja1pGJ5tZT/pE/rWz92RuAdCw=
X-Gm-Gg: Acq92OH9l9lHbu3wQF2AZ3q0LMQIVxCgp1RVYaTzVisfwZ5VTv0USQIzHpK8IA453Tw
	BDF1D9ZQekL6jp+1fMIx7twS4FXaQGbNvo/O155vTUx19FgWq8/sFKKUFqJYcb3mOaFKJC2HXir
	XBBQpCn8Zv0HHDXSfl5pqBAjgnHKLd4bZNFUcA8Zm05rd4Q+32hzm8cMGAcE4maevSOwH4CyVr/
	0S1xe/ZmjcUOok9beL2G+LKDbHX/SWR5D9dZvr6hzEV/XaktmWcS4gbRJvEY5b5OkSxPLSefG7/
	RTl793XWReSWNueUND4MN/2BPMQwI9Gxy0WgPwqFOWkSLPzvQaosSWwsbqrf97v1HDA4a4QXtqv
	SFTJAak9wgiTMT/yq+cfQ6XJqaF+5+uG98XuBS/Fn00ymsAWqBr8J+0mVTB6WoHliSNiCy2b3zA
	ScQ8Jd5PdgudLgyBDj+dGjAWr8pel+pjLWSNprJkPZbe+Edy4vFEa1roAegbcpEyFEsbwwMWKcq
	NJk1rOB8iq2r3jY
X-Received: by 2002:a05:620a:701b:b0:915:4213:eb98 with SMTP id af79cd13be357-91542140a21mr1632452385a.56.1780324372641;
        Mon, 01 Jun 2026 07:32:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91570271853sm113463685a.24.2026.06.01.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:32:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU3hC-00000001n2t-2ubv;
	Mon, 01 Jun 2026 11:32:50 -0300
Date: Mon, 1 Jun 2026 11:32:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com,
	alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260601143250.GA2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
 <20260531235421.GW2487554@ziepe.ca>
 <fa924b86-1ca9-4819-8330-0d5f6ede8923@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa924b86-1ca9-4819-8330-0d5f6ede8923@linux.alibaba.com>

On Mon, Jun 01, 2026 at 10:24:14PM +0800, guanghuifeng@linux.alibaba.com wrote:
 
>    Therefore, currently only the PTE mapping size of the iova is returned.
>    The current commit has a large number of changes; this issue will be
>    fixed  in a subsequent series patch.

No, do not introduce the wrong API to start. The iommupt version
should be easy enough to do this.

Jason
