Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE64227B94
	for <iommu@lists.linux.dev>; Fri,  3 Oct 2025 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475243; cv=none; b=SnxQT0QF2gJzDb48j66TFuZv8fXgLu5izZuIq9QVFejS8cYBxk4W7xpxSMjMrY/cMlsVHN/+kSRXaanm04JKmWpY3CfMINU2jc1Qp+Gmg1iuuBRTs1NlJvVWw8nAyuQHK7jToh0porNsgb4oSn7B7K12WXXl2zBInYXWToGiq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475243; c=relaxed/simple;
	bh=NmBarXdprph0Ea9BqhLbnDit9HvUdKIbTKXdxSGKLqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo9wx43q+qmQRr8GKENEI1KnnK1eRIxxZjr5tiQaRdW2tB6YG7ZhTjJIsAGnNdYU8SN7VSSxPxJ6xiwrybHGLKbGYAmw50R7oL5KC7FBr7u1b5RWFgjXjdO20EXbfCm1vbxp8q3cACg6IfsZL2V0TNagM4uYYTgdsu9u1OKJwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BB2k2tm+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BB2k2tm+"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b1eac8460so34676166b.2
        for <iommu@lists.linux.dev>; Fri, 03 Oct 2025 00:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759475238; x=1760080038; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oJsClXNUdjNS3IHTnmCIDO3oNqk4uGp8NgO3dHySVY=;
        b=BB2k2tm+nIu5idzT9/PygohKLgi0WGWU9Hgi7v/FG+Z5N6u10PcmgJN/CQt9WTfpk3
         Frpw9qggm3uAWIHbuVYL6RwYPxytCTuDYvjjJN+NQae2pfAhjw4cMkL2CnLPnALfbH7S
         4IUw/XpNif0oMjOvfwjlHftDCtYvT3TkvwqwdZcf4DXDJ4kUn7fstgkOSvd51YX9gRX0
         oPjiQkHHERDMXzxjohIsjKu6FGDRyVYKgtLzPvTPUxyApiU67ZzlK2GJrhWkUpcExPAJ
         cveFSt9yLtAvWDqlkI/DK1KAYJAqSaqqvFCu7a7Z6sjbrpJglgrfre9oHVqYWI07sAhs
         PHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759475238; x=1760080038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oJsClXNUdjNS3IHTnmCIDO3oNqk4uGp8NgO3dHySVY=;
        b=MZCYOm//5TBc10dN3eA2fC1cG2RWoeZtW6MBaYBgR6GvSl77QdR+/ng9W0JoAcJYE2
         I9TjNdn4jrgrr9eo7vV5HTyKSheTVN1yEM3WYFh+azuoZDfTKto+jAmXugHjcnWquemy
         s2fhIcguJhFGa3S58BQW0A/y9kKxDUjd5Dk3nm8E8AxVzSppBUF7j2xxDvO9yVDtpUJA
         9AK8CrBznxqewVBZbtYKlWgGwfTd8DyIk5MJ6xYli4xHYmdM6fw3xu5xM4FoL/+XvNwi
         aIxFWGlqWbBnc+X3u5ixRyLO1LRGfxBlOYS8Uc/e2mHBn8x5nxTtYCsx3Xi2JQ31wOJU
         c5OA==
X-Forwarded-Encrypted: i=1; AJvYcCUbTGcaCZXBf7f4oFE2ADRHPlwQtoFCaaTU6KjigK0WTAwAvSL1Fz7lNA3PPzojwegaR2VI0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJpQeQ9Z7V6CeOLD9sqwhBt97FFO7wmIuQPs6cjxM62OjtAe1c
	Nle1Yt/x73YE2BUAKjjlqxARGFzxzXl1w/zgRzKxkk6uCXNjQEeFqEtXO6HhtmByVzI=
X-Gm-Gg: ASbGncvFD7Bw8+vO327BcPVH9msTp8d1rGjMbr7pElBZraObG5VLrBFMjIvh6vZXpPR
	C6rOE7eGW457kpxhp20fdnOEwtzpkSyLXtU264c8F/hx+ziKcn97aRkTqgQNQgeNcLo3kswLW7u
	z8Ywk5S/I1jBmIbRAy2mt/tLzsolQ4Y9j9jcdHsorDxMupQWtOVsaIF2FwAf4iewRq1+m7jGfWP
	Cvaz0TpH7dwqMRcNYF9FGsjrY/X6Tx0Kx1G49i9EJoY/90aqKGez7aRfUTvCVP9EBkmFmx7sbn7
	n4J2jT1XC4zN3bJ0QkGoL8IRPyL2jecNss+sQn1aOWPDcjGVJj3owdsi/rugsy0rv3rbYMtWpVA
	fC9zJwnuZDRMt3ldBVlrp2HkHkgsByPPu10Dd1ZL/XEB4/uN6RFzenKq/6zkzSkMh2VjEyYhgWh
	llfqXKJSRHZg86V3sH024hkfutyyjvhrY5fUK90VXYq2UD/BNfYxMq
X-Google-Smtp-Source: AGHT+IFHgcgAxKrBEwL/rl1KkiwB5iUsa34TbQ1eqD87gj7Bd+hJwtRTUeDPma+saazo3hj9xNIPCw==
X-Received: by 2002:a17:907:94c8:b0:b3d:6ec6:9e88 with SMTP id a640c23a62f3a-b49c295f869mr130567666b.7.1759475238345;
        Fri, 03 Oct 2025 00:07:18 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4d9f5sm375183666b.66.2025.10.03.00.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:07:18 -0700 (PDT)
Date: Fri, 3 Oct 2025 09:07:08 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Anderson <sean.anderson@linux.dev>, Robin Murphy
 <robin.murphy@arm.com>, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix direction in dma_alloc direction
 traces
Message-ID: <20251003090708.7951d755@mordecai.tesarici.cz>
In-Reply-To: <9505e149-29e3-4fc2-ac71-898e88492667@samsung.com>
References: <CGME20251001061047eucas1p1f96a848ff2643b48179dd3e55959da7e@eucas1p1.samsung.com>
	<20251001061028.412258-1-ptesarik@suse.com>
	<9505e149-29e3-4fc2-ac71-898e88492667@samsung.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Oct 2025 09:00:13 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> On 01.10.2025 08:10, Petr Tesarik wrote:
> > Set __entry->dir to the actual "dir" parameter of all trace events
> > in dma_alloc_class. This struct member was left uninitialized by
> > mistake.
> >
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")  
> 
> Applied to dma-mapping-for-next (for v6.18-rc1) branch. Thanks!

Thank you for maintaining the code!

Petr T
