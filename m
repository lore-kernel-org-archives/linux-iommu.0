Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056421C07CD
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996447; cv=none; b=rrn+8nuw28Nw+mWhDBv5uy3p9KkP1ulpo6UHHpJNs4NV+cKuTf4kkIdbi2IhEafJL1pOy45zXL36r9KTXe+fmtO2IjGXi42gGXwx5HQLmQtuS7662ghm3nfO/pGvpx2wy8PrxqJIKp2T3VxZX/9gfxrKR6mnunVPviwGgMgbHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996447; c=relaxed/simple;
	bh=9S1snqy0sUlcGrxSkmAISPY4bKaFGc5qSCVtFcrN4RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biLx6exSKirejWuxpCCWecrJVz5LWDdmxmx+BCuVQqM4LF84F8ru2iUn7F0l5GOVeFLzLI3WEge6Q7Lmrk8SZ60rzT8T+TuOOKqbdTHIbrdqFSPPaXe4JzfawUqDDmRZiX8yyEd6HcyengX/GUdvqdDc+0Y4ZRelanUbkQE+Bk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=arbZz8Pc; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="arbZz8Pc"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fccf51df1so1544704241.2
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728996445; x=1729601245; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9S1snqy0sUlcGrxSkmAISPY4bKaFGc5qSCVtFcrN4RE=;
        b=arbZz8PcrYYw04M0NOivOWcCJZ309TudK+TnqSjaodgD5G7+YxSw3RPnLSienKqmPs
         ZKt97iinm58EEbt6znQkXgSC8LMuUv3SHfXXmzITLGl5xC0bk/1940baJXhyEvf5Eadj
         IRgehZa+geexnafKl/Zzb3Vfc2B1ajqyfbuPEhoYtJErrzYLVOJ9xzjzGBn+3TZxxEjN
         knWh8k7acDaTwa32sKd15sH3CbmNZwoE4jgziGLWQMK5WGXzfOodbBVDvCL/YL6UZ9uV
         pZxYaoRQQcu8GcFfsJ5DDbdHcwIudk4ADb8iPe2ywVthcQjtzMq37TqCqOvwZGl+vT5h
         M3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996445; x=1729601245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S1snqy0sUlcGrxSkmAISPY4bKaFGc5qSCVtFcrN4RE=;
        b=JT07OJFH0wDabyXxBr5/uxmox5BYIbJbpuNx3voKWZPnYjO+ItY0yfCUFPk2Javvqw
         4AUJ8An3ChWmt9fzV/B/NumTv3zRYdlW1NGpRoFpLnc2sJisKFJ3teKkGLZstpWCGszj
         Th45bmlztTdGhs2mVif6BnPcLO8I60kMcG0aZlKdcP9SkpHWAXO0VlyPAI9DkLNRZubX
         3YZwhAJzU7Vjsj5+mHjbfytblzigK4lZB9GNntxzW9f7GGmfbjnraOF/F+agESpE5BhT
         yKQQluvIqX6vlF9GHA+z1OA4PNmzBZjeBLkPSLNLsOp3e1tAmY+Zf5MC4Q5sngGjyFwI
         zyaA==
X-Forwarded-Encrypted: i=1; AJvYcCW6CnAgsutOovmutbaTcxFKa0Srs4wRpAgjrRjAMiQDoTns3oNgbyh3aMkTiTt0vEyGmyR92g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzH7cGIsEODQEcjjuNNbzJx5KuE1d6Jfkur+6OwkMqtthlCvw0i
	OE99sglKZFLajzYKLISbmL632+Q52THhf/s3eXOXvmBjEr4bsUgUcysMWzAomus=
X-Google-Smtp-Source: AGHT+IHIRxePA9J/5yRqXfxDEQAMQhA+JMP40CVAOrPRfL5HhzVbrqqZKc4spR4QAm7PXjUlxeCV1g==
X-Received: by 2002:a05:6102:3752:b0:4a4:9416:6a18 with SMTP id ada2fe7eead31-4a5b579b8e7mr231229137.0.1728996444983;
        Tue, 15 Oct 2024 05:47:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13616611csm67089085a.14.2024.10.15.05.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:47:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0gxP-00D2Mx-UU;
	Tue, 15 Oct 2024 09:47:23 -0300
Date: Tue, 15 Oct 2024 09:47:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Message-ID: <20241015124723.GI1825128@ziepe.ca>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
 <Zw4kKDFOcXEC78mb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw4kKDFOcXEC78mb@google.com>

On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:

> Umm.. this was specific for rmr not a generic thing. I'd suggest to
> avoid meddling with the STEs directly for acheiving bypass. Playing
> with the iommu domain type could be neater. Perhaps, modify the
> ops->def_domain_type to return an appropriate domain?

Yeah, that is the expected way, to force the def_domain_type to
IDENTITY and refuse to attach a PAGING/BLOCKED domain.

If this is a common thing we could have the core code take on more of
the job.

Jason
