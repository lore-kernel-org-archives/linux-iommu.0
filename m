Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC415A864
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167928; cv=none; b=cwpo3mMsGpbw6sTHbJCdE3pdkbX0tBqAxoZPFoPbKyuvXZoHYiC2sB7Cv7oOz8i0+SWJBHX7dA3KJ7KDMC/geoZ4eRPrMZBYHVAqJ8UFtdPHJt9f62oM4P3yt3lm3lI72fY2Mc0Kpvo8VEdswAME4Xf6Fz0nLcaUmdsamj7ITIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167928; c=relaxed/simple;
	bh=AHCeV9guWR+fsMjaNPBNTSdtvm3ttKmuomAoyyWFbPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB9YPWmrVtaQmYLJDkO0SvWNjt5MSMyacvPTJTVis/a71x4La9S1IlZL+i+mulNc6RxdifmEjW7pjSjIGLubuRRmuPNVhDkKctA/TaDRu0ZORIYtH5evhtwLwALtUx7c1tMpw0RUrySIDDhmzbf0LkSsbv/bqcqRIflBzdzlr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PQUyMdlE; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PQUyMdlE"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c56321b22cso206679085a.1
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743167925; x=1743772725; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mjkOX0/Ux/hY2ZzHtQFbyLpaKq6bhVhO6gqmvdpQb8w=;
        b=PQUyMdlETsmDwcMjk5WPUp6LNYB/uVt78FzQCP72YK+jECsObjTkw/bz5FbwzfwzWw
         cYOAFWAiM0g2XRAwf8YYiCR4IZcAXgWGv6owz02XOfiZKGNqrAuOUArcbAHQfn/1MYx3
         KTaMX5i7RD97QxPZzEgg3h5QDdnIvMvpdfx39ZURm2x9oUKUtvG6BKnz/sftloo0FZdR
         AVCEwVOH7ChNZez+Jn3e13wpYJP4KNto1iTs2/fEhmR5ur8S8RPVu+JgyUiXQNziT4Tz
         mUk+0WL2FiAXr9SJhJ45TNpcljl1ZV6aOzRw9/nzcO/FsoCrswhMh/s5TvWzSksQuo4w
         qfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743167925; x=1743772725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjkOX0/Ux/hY2ZzHtQFbyLpaKq6bhVhO6gqmvdpQb8w=;
        b=WMmDhJfJQL32MGzaLbtVT1fcdZz/7srxG6lJXg8DYukSHCWzsXNM1hNRMrtkoJ442G
         f6g7NbUJ0Jp7FAr7P8HSBKoaRnVN7fypdZvVjaV/WFMSlB1yUIFfABXX0nrrql0OxfA4
         3Xq6p9rrNaFkZL8rq9OwPOXNPYl5/6Ft8w7KEJj641PuiEEbL0vE4P+/h51SIuOtRUQG
         dAPr930KVNhlZXowHkF9NDpHhwr5cwHxu+AoYfbQSOuDMm9dxRPGpt5Jtxb8OwIqjLs8
         4alk7ENkY9vDzLLxvwey1k5Lu+m9y4F1tKVsnJu/GkQd8gwW4T3cGcgIlUmj8bOHlBlJ
         gc7A==
X-Forwarded-Encrypted: i=1; AJvYcCXSkKV0GXYzbSEpWCcFuEKessWugFGQ/pnd6m3j1fn9wSSX7s2zq1aexIaqeyONy1jHbVrfPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/93a1h1VT0TL17kujuva24PC4gD5p8oo3BqKBjjgYXhJobTUt
	4zX6hQq3hakbwYajc5Xu3udcUIOWXdY6NbkkxYZww/Jl03ReL51wzbXPTTzWU4DuN88WCwGi9B+
	j
X-Gm-Gg: ASbGncsWCDTI9Xyyry02RL/VxVP4QIvL6TUEQZAmUQndGafWO4wTPkthvWxCZruW0rh
	+GD75PFwdXdMqhMjb05YF5QWaVVNkYW5ThLNy2uuRYyGGb4RQSEJa4nbihNrKz1uSqzHEqHVpmL
	ECf7pRdBYK3rTSuK0gvdsoz/ToXzdT7p5ieXe6fkiRdyB/Yg4FHrNE1K4ftBQudVdLlULE91asC
	r0hVfcrhrTVkmTM08FU4zcW5p7kdMiP0XuXsv0UUVbsfuAaxrjt5bFPU1oJKnhB/PuZ23+d30C1
	jV8HIXLGgMtbGpKPG2bwF6Bzy/sIjSWOaD6R303O5LHOnV48fJEMuQfa0WtyRv7Pex4NPmgiDc5
	zcR4GJFlx3ouxpQAyZYvFy88=
X-Google-Smtp-Source: AGHT+IEaXqsaxUvtEQPoeggmKPX4fQa/4tiBRgG1w+A9bQTVfdTx5fuPCz92hxRmL3lIh2MNrAWyhg==
X-Received: by 2002:a05:620a:4513:b0:7c2:3f1f:1a15 with SMTP id af79cd13be357-7c5f9b83de8mr417075085a.8.1743167925481;
        Fri, 28 Mar 2025 06:18:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f777e00asm116446885a.90.2025.03.28.06.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:18:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ty9bg-000000005U3-1vKI;
	Fri, 28 Mar 2025 10:18:44 -0300
Date: Fri, 28 Mar 2025 10:18:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20250328131844.GC20836@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319115730.GC10600@ziepe.ca>
 <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>
 <Z9yV8KsdXnZg1Ppo@google.com>
 <Z911UT59UnDzRymF@google.com>
 <63806834-a0a1-41e0-9cca-60087b460f78@arm.com>
 <Z-GYKyBi78tHw8Lx@google.com>
 <Z-WKlZMBDTJDSfd4@google.com>
 <Z-ZoHdfgyaZoqJkm@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-ZoHdfgyaZoqJkm@google.com>

On Fri, Mar 28, 2025 at 09:13:01AM +0000, Pranjal Shrivastava wrote:

> Other than that, the MMU-700 implementation spec[1] mentions that 
> certain revisions might access config and translation structures while
> SMMUEN=0 (through an impl defined prefetch), and one of the provided SW
> workarounds is to issue invalidate all with SMMUEN=0 after the SW has
> finished all modifications to config/translation structures, which seems
> to be happening anyway with arm_smmu_device_reset.

That starts to become another security problem though, if the SMMU is
not in forced abort and it somehow loads invalid data into the cache
because it hasn't been fully setup yet.. That can't be allowed with
insecure attachments :\

Jason
