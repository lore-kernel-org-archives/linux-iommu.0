Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D04645C
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PgEdcuoo"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1f0f160e293so3253372fac.0
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 06:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701183369; x=1701788169; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8g+e5uKh1QlVf3RdM68AyRGdG7AIgZT4PZpe3XzaAo=;
        b=PgEdcuoo6SOfS1Zt36qz7FuOzmsG58vhAXxuTTozpC837yR1pvZuQzRTE7BReKIil6
         2G5kQcP+e2poKK4/XzpVAvW17wFd+k4sr0y1MSF18YiymQ1w5zigPex6lgaqGFq77PQb
         L4B7rlw6QhexmiI78PP7DDzwY7Q4HCm8yMHo952tMSpD2aQs2ni5VLNCAj0//CWiuHKU
         pggaD7len3OoBzktx7eSs8A02H+PrFWBcnMKoMsmlLmKIJBdr2sVxwKMKdBJGhpMCuNP
         R3eELxzIzMetfgwxb9+yvlkCCtsSXYfhtAInF4nsCFRZDxlnN9XnyYi/1hdGIkIknGCq
         qShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183369; x=1701788169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8g+e5uKh1QlVf3RdM68AyRGdG7AIgZT4PZpe3XzaAo=;
        b=jjPX8Vqku5D+YoikuRnfXg2IoGQVRcz6+jSUTz4gwI+6R2LZm0khJJUMZNbjYrFZN7
         xDfN3GJ1BArCnLMKOZWoyboJdIiiK8mLtSxjV05jQ5OvGSAI+TDcCruw62FSsmoHmeJr
         W0xWE4GNto3nnQh0/atLi3ojfNxpeFawRSFVPpn5kFK/I6Zgq7w0B0nW76os6lIciEJa
         rmlPa6ptrRRa7I7v+apjeFXpZmc3ClmynIqoy6U4z0qEhlPhKKPvrxhMPHeBmQxpbhjd
         rWAnlIqcVqy7LRx7ohJYIhpFYHUsS8niBJl0uJYh5BxzLBdfRu3laDJcjI+UYMr7fP5U
         7QcQ==
X-Gm-Message-State: AOJu0Yzn3bHOnL9H5X47gD+1+qQnjYU8wQJ3P6v5ZnQKgpxrc+WGAZZU
	Na3phyU2V04gFZxkZIo7Z2pkNA==
X-Google-Smtp-Source: AGHT+IFw0ivBF8qAq++MP+hGfozxXMvilmwyBK70bhJoAMuG4+AHbtB5wUTCGVpIEXUm2qt59N+Zqg==
X-Received: by 2002:a05:6870:f626:b0:1f5:cd12:260f with SMTP id ek38-20020a056870f62600b001f5cd12260fmr18094295oab.26.1701183369637;
        Tue, 28 Nov 2023 06:56:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id so7-20020a056871818700b001fa8b2d3212sm175886oab.1.2023.11.28.06.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:56:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r7zVQ-0050HI-C9;
	Tue, 28 Nov 2023 10:56:08 -0400
Date: Tue, 28 Nov 2023 10:56:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Message-ID: <20231128145608.GH432016@ziepe.ca>
References: <cover.1701165201.git.robin.murphy@arm.com>
 <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
 <20231128143508.GG432016@ziepe.ca>
 <3a8d7ea4-c5f9-421e-84fa-2e4934cd6c92@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8d7ea4-c5f9-421e-84fa-2e4934cd6c92@arm.com>

On Tue, Nov 28, 2023 at 02:53:03PM +0000, Robin Murphy wrote:

> Dynamic bus registration in general would be a neat thing to explore at some
> point, since the static iommu_buses array isn't my most favourite part of
> the whole business, but I guess we leave this as-is for now.

I have an idea for that :) For later!

Jason
