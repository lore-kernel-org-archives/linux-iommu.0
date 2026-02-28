Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130901D88A4
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238849; cv=none; b=aTn/GV00GoVbiJ1FXLFzZqA/Yx1TnfVJXj+BNp3dneRmwGH2KXc8X/vhxZM2+AiOhZ5Xm0iPWY9u9zQLOQDLeioT6Wn6gTjgFKkuIZoowO2kxkdTRTuNDxcgfgJSOMfAMSg5/pmSuw/fUtt4+e0FhDab4f2q37LjY3A4crZQJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238849; c=relaxed/simple;
	bh=ctCaFK5PluFIePk9WmikuyOe4wwIzW/Lngg3w/rdeio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqNGG2eM2Yj5A7AL0B6TERuLC8vWTWS/u6uxHa1WaWZ4gKG07Ve5oSQh8yxsMxirJgOn6lHAdckH4YvOIWROzyE3Y+PVIIs6CjpWf8FNfwbhp75Nb9yJC8OBPliwod0J54Nx9bvOL0V3mh0PjicZI8qjWl3QpwFxpczOr0pQLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZIH9W2n0; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZIH9W2n0"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb40149037so267844385a.2
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 16:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772238847; x=1772843647; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDfvERwFDgR0MxyPk2puS2te0XdJdF7ryQvgQ3Tt3Yw=;
        b=ZIH9W2n0AuefdeqM4fUryvlDG7/rp5expfkp+9xi7SuEUmonjeUyUUJPM6sd+NePNZ
         UW/+KpId+VhDQFkG+InmiZA1U/C6u3QW7H9CKOhDKXNKHMa8WVTmb7KrBto9+Igm4nX/
         X+TsgQipY1jstl69nrpGaiX6UgB68/VXIzjG9Dnfjbhzvk9GkGqIJrypkPIs1HvdaJSY
         EWsT0Y+nBMDYOp4HL68mWLyd5tNjFlbwnzVMtphiXOnV1DJA5HclTUG0+PDof4cDJIaY
         XluBasN8z91bgnGoD+QkhIe/hh4Kni2bHnMXOWofm8RdHoM6dzYhhqU0wZpp0eaPAhOY
         JpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772238847; x=1772843647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDfvERwFDgR0MxyPk2puS2te0XdJdF7ryQvgQ3Tt3Yw=;
        b=uqSi+QZ6b56YM//TMsbYyaaPhqTgpSyW9Pdwf1VOKLvbSXwh96xxRc3NZiJ6Cts4z8
         bmAMXd7AZhukCIo3BxWeYTLpwPNVxAw2pXn+xb0aBMcvXXmMftgubXpAjvIlG/J3cx/o
         cH0ON9Q229GtaYpXeyo/czvTuy8hEJxM7Hb+HLZVi099pAWj6pd1ikXJz/azGElvFQVF
         mitQV8VYMRppvW2QKA1yjPQkD2iJ0kp/EThke2ez0u6DtmCWATovaB6K1alrLMBKwkuN
         YDm8C3RS5ymCj/SD/ERYi3T7qWQtIJiCLd09rBPD9cOooWJmqCM0czgcW1ijvWwGtExh
         x4/g==
X-Gm-Message-State: AOJu0YwtUsAoOfjmGR9qGqUctbebOpn+SZquPlLpvvMLwA2JlIYxTlyn
	zCjtJDXHXXuMcLbYZwsMr9kWbtdvjPCD5z5nc/dCWDbV5vItxZkPcBQk3OUGFOU7htA=
X-Gm-Gg: ATEYQzzHl24qPI+ZwxCPuwFiclCX6DfZcfQ9sh6aUpkLfNVYHnl7B/sSDdCr4JVO0S1
	lGnqMPYALIVyt7ij0k7co0KQh+gV4PxnJ825e6lIOJFlyR6iR0Ku9zub/cT506CYczDhmBTYeto
	x4meLGp4b3XwDhC0dRmahXh0lrKDIUu25zxyABVKL9YqKjudzItRYDCdAhxEyQS/1hOHT7aiBiS
	JRIcAGVJFMXYQyjjkeG2APxrn+uNIq3gtKls1mGVjGIHro4/gixg90JSodhmh1c72RytzBJsDSk
	JS9EfWB/e500qCqrd+PbNDCIUjPaXJCa/TmdHpMPCQuXj5tDNKMNqsfx7+L3iK4RZynE0EUhXOl
	Z4ppPtCqZAAFIl02tU/MulqqTh2+BMlEl+7wffe7QjpsxZdlSyuGukedKIq2Nbnx4BuMyW2o0jM
	NuXNfnRG5sUdkjItjBV5/beeQMvZKxT37H1WMvQeA6tHDu3C0owtxzfN7xrWdhlQCNXLJtKnMDO
	K8dpLqv
X-Received: by 2002:a05:620a:450e:b0:8c6:b14e:6569 with SMTP id af79cd13be357-8cbc8e3099bmr661579785a.79.1772238846942;
        Fri, 27 Feb 2026 16:34:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c739e75dsm52929296d6.46.2026.02.27.16.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:34:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vw8HV-00000001WzZ-3lBv;
	Fri, 27 Feb 2026 20:34:05 -0400
Date: Fri, 27 Feb 2026 20:34:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: UBSAN: shift-out-of-bounds in drivers/iommu/intel/iommu.h:1101:17
Message-ID: <20260228003405.GP44359@ziepe.ca>
References: <11145826.aFP6jjVeTY@jkrzyszt-mobl2.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11145826.aFP6jjVeTY@jkrzyszt-mobl2.ger.corp.intel.com>

On Tue, Feb 24, 2026 at 12:16:32AM +0100, Janusz Krzysztofik wrote:
> Hello,
> 
> Please have a look at 
> https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15478
> 
> For me it looks like an IOMMU issue.  I've added there a comment that 
> summarizes my findings.

If I recall there are some error flows that will push a 0 length
gather to the driver, it is supposed to ignore a gather where
start == end

Do you think that is the issue?

Jason
