Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFFF224D7
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298707; cv=none; b=CemN3q06AyOQJ55B9uvIy2/rEBL3hUCC1L6sz11IdQwGzXsuByL5XjkIjMpGZSWqMo9ScJHw83cap5LowAivP++gdxMyLwpLOLexbMfFR1tbXv6SFgj7qC/b3WR62lnghVlZUP6sjn0P9OkvoKWWab1ZJkRWmEYGP+qy+hZ2SX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298707; c=relaxed/simple;
	bh=UM9NHqrhFW/qXab9JXefHaDvEQZR/UkcaOA0AKHOLys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHXf75zY7TCytj91oanZ9dlCBfLtYChLwmyC2ofQtWU8ApWXpQedkbKB/SJLnL234DurwK1jMXGxjjRTEURFo369B4I37ewIjJ/j4vPflaYjD59H4ys6EEvlAt20O9Rbu1bZdqkW6Wi4xnrlndHbXZOTIBl9b8ia3fCYd/wurcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e+GRm1sd; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e+GRm1sd"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e11283948eso242336a34.3
        for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706298704; x=1706903504; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7t/Jfk6r6ijlM1clfxfASnElihaegtuTeqvVJDZ0W4=;
        b=e+GRm1sdzUloPM4SzuV5AcSHmXHb21SxPCz95vZaYjr2oaUsaoTAYatC9YK5MTBCUi
         +rqPhzKHe7ue6HBYC29C4hriuzRNeG7IDvE8g4bQbndfZRmKCX+kwjrZsTlUDl9VbOKr
         1sD02kYym851wBSbo4qSVUal4zU5kRqb7ug4qBX/ZlQf5i3Cp6R9Vv6tWLAG8rIA/qRj
         JO0Bfg7X8NVskG+TVWhpdDBI1oUo5z04Kcc6rqKba73t7JIp2NJQxDnMsdzm4N0PcdA4
         L0tQ06pJl1+fDXtTODxHZ7arRYLXMOGJuIOBpiQs4qD6nSjrp3H5P60k2lg7xm64+rFB
         OSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706298704; x=1706903504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7t/Jfk6r6ijlM1clfxfASnElihaegtuTeqvVJDZ0W4=;
        b=NvuJJd1bwXBWvAGfp5XpzPp0+lRPGY/3No1yPV/KahtoCl0wPq1alJEPoxcgvSMyeB
         fcfStK8qkqOD638dFIgtfdqeI7vJp+AokebLujd2AwYEpSCUob/ygwPYc9t9YAo+sUh4
         ZuGd4qtoK2Yc2qlYzPutHfOHRpBMvT2jEHYRWZnaRv437fGp6is49IERcgBYqyzTnr4N
         GgZCcIIVu3zC+a6E3Eyfd/QJS9IXkFvqkV9k254gVPKg1yCRXVhmUjMI+A9Bdh1J7tvw
         cT/gtM6NAhHRISWu+6ArdlG6IZwKLirpl7t+m0VFGpXxYo6ya0shU85JlSL9r4vWu5xR
         j89A==
X-Gm-Message-State: AOJu0YyFMzXRQ15Hy9DmdSjaE4Z6DxlDWKnWK0qnqjfywGVIxyVAr1iL
	fLZR3U+HnaDzD5Z92nTTV13AidiVPc3OM4wlmAslIrsmkymHeFZJSvfODePoPII=
X-Google-Smtp-Source: AGHT+IG8No9TGeuDaqJJWT31lKXoJHAtaVdjCbPNccV/GnexH2LwAmZYe5309O0/wi7ytsY7bDXiFQ==
X-Received: by 2002:a9d:61cd:0:b0:6dd:e6d3:d393 with SMTP id h13-20020a9d61cd000000b006dde6d3d393mr233513otk.55.1706298704640;
        Fri, 26 Jan 2024 11:51:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p26-20020a9d695a000000b006dc87c016e4sm386606oto.60.2024.01.26.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 11:51:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rTSEo-009eo3-TV;
	Fri, 26 Jan 2024 15:51:42 -0400
Date: Fri, 26 Jan 2024 15:51:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com,
	baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de,
	linux-tegra@vger.kernel.org, iommu@lists.linux.dev,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Message-ID: <20240126195142.GC50608@ziepe.ca>
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <1754c86c-704e-4c80-93c3-1b75a9a247df@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1754c86c-704e-4c80-93c3-1b75a9a247df@tecnico.ulisboa.pt>

On Tue, Jan 23, 2024 at 06:44:42PM +0000, Diogo Ivo wrote:

> Yes, this does fix the issue!

Thanks, just trying to pin down how the fix should be..

What kind of kernel are you running, 

Is this 32 bit?

Is CONFIG_ARM_DMA_USE_IOMMU set?

Is CONFIG_IOMMU_DMA set?

I'm guessing yes/yes/no?

Jason
