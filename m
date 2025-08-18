Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42D261B77
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526538; cv=none; b=dyVIaBa+H+Jey3/7F3B+SUdskdpgfGoEohE3ibVYgu9lTBw0NA4g5o9rSqkfiLj6gZDzu1FnJ9L7pXPXMgFyd+ExA8PegG5UGzircwb5pLP0Kki/BrMQwzsQCquMbyffTHz+pM/lbCiDlRAy7qA1z660nmTNKIkPi8CgXjsqwlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526538; c=relaxed/simple;
	bh=rUDEqLaGKm6ZQUUXN90WHjd/zoe+fc5cuVujd6LddVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZop1Z76blu/e+UpVEzyWKx0K+v79oE+5fQToeGiKhrkFEs3vxO9afoRDznUe9G73ECj23u4f8DUH6ZufpStWSBnDstDtsGrSNWQZ8nGQW0W9Zlf/4degVkrpDdsbDpkDiqMo/ygmlDSMZk0lo1/wQZKAJfaHG2JPlutaDrrxQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IXGwn8oR; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IXGwn8oR"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74381efd643so914249a34.1
        for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755526535; x=1756131335; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvgGnTzuqm5EUCC8liL9F7L/fpNCxBXVLfxe21l/PJw=;
        b=IXGwn8oRiB+a3q1JtRKILsZElqJ7OV8ycHJkG+mMXMclXG7OKS/jqqM+e9QD/dbAlj
         uazKimZZ1JRtM53vCU5SrQ/1o1+BmvQY0x5HR5wL+j2h/52dxJT2xN4IP998gBqadork
         2BegkAm+oGFm5IjBGxZqueD3pWm6lZFxfVejVbOh0cIeiUxT2L8Z86nE1csahpmN7tEs
         Qcn1bAKEpza/OZ2AwSlY4sAzazuYcINp9ZBKf4H9FMqmZNKowwfV/Ju+NGe72RTOcu3I
         s/gTDIBqsfMEFx8y9RQAe6V30ZPc/EMc1UTyLK3vLWZ6LHnquVqGYf8s5Juj23SPqxV4
         Sa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755526535; x=1756131335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvgGnTzuqm5EUCC8liL9F7L/fpNCxBXVLfxe21l/PJw=;
        b=pCjtl4Q7oU/DhdG//vJehaQfzyFrzuefE9gG6WU5Ji8S6Vqxa22PUza3tdHLcERHVl
         5755GINy8l8EaE02K9uCN/lnSOd8B3pzmctkYQHLzfyZX1Ojs1ngrNcpGwSx2wvobcPz
         TCfRKbyPxUx38A180iQki/8pPjrmyjYhegFIHsysZyrPmX6vqQA70lLus4GTEPtpxSJL
         tNjdp16DiAbj4vygh8QmCuIqVFnPHA9DfKzW9i0KMjYRNSqeKwoGf6nR+6j/ZaJ74LdO
         8UHJIK58UvO1S9lxiC/mTvI+xryw5defYD7YdtXe9dwss/lov4Wi+EwR2BFT2PKIgOwh
         fo2g==
X-Forwarded-Encrypted: i=1; AJvYcCU8vz99iktz03S4DGtXkwzXlKCvsSo0blBfpjMBvgugnWI8XGObc6uG3uomDWomvBgXCSmz1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWLToB3RBcyKKfwy7kwLyi/Fgm6LCjpaqR5wYhLeeRuunb7ToU
	60iXho/HMRdeJ6SSLWD3dbAkq3yCS2ZvXsLdmpkZwiR96CuISRGTtYnYwwqJN7YiZYk=
X-Gm-Gg: ASbGncuOOrZaPSjPuEq5dA81BxzXVGNYfYVsDwUdsUTStxKJAZ6lzQR/VQ8PqBNK78h
	EriF8XsKa6SFnnr+PD7p57GEyKv57V7jbN0B3Jn+1Yrew8K4IaSKsPBsBfuLHLOV43gNthfjqHn
	bqTMYN2vWeh7xBYGeVgCwX1H8ofGTfZawubBL/x4JJDvZKBEcGsSBgsrR3AAL38KKbSWIMLtdOf
	itC/JRT0PrEoxFMqFNRsE43cZ8Hnl/3S9nPLlHagTVa41hOmH2mGsmrAJZPO39kPLNGoqGQ12oQ
	XzhdaLMNfPcxZsdcLZKlCLsqU/PGzbVGazI4J7M4KLrCihTp8FKwa8PC5kppawU6q3dWymbN
X-Google-Smtp-Source: AGHT+IHvo7ZOM5rHAk24hmKZc+hkAikSEtRWDKvfOcli7KYViAuT56UrJGkQ79fMBBVlt+XNlS5WsQ==
X-Received: by 2002:a05:6808:5147:b0:435:7231:74f1 with SMTP id 5614622812f47-435f5e9c626mr5304208b6e.23.1755526534821;
        Mon, 18 Aug 2025 07:15:34 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1e96adsm1821089b6e.26.2025.08.18.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:15:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uo0e5-00000004NAz-0Sve;
	Mon, 18 Aug 2025 11:15:33 -0300
Date: Mon, 18 Aug 2025 11:15:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: kevin.tian@intel.com, corbet@lwn.net, skhan@linuxfoundation.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	alessandro.ratti@gmail.com
Subject: Re: [PATCH] Documentation: fix spelling errors in iommufd.rst
Message-ID: <20250818141533.GF599331@ziepe.ca>
References: <20250815153840.188213-1-alessandro@0x65c.net>
 <20250815153840.188213-2-alessandro@0x65c.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815153840.188213-2-alessandro@0x65c.net>

On Fri, Aug 15, 2025 at 05:37:26PM +0200, Alessandro Ratti wrote:
> This patch corrects two minor spelling issues found in
> Documentation/userspace-api/iommufd.rst:
> 
> - "primarly" -> "primarily"
> - "sharable" -> "shareable"
> 
> Found using codespell(1).
> 
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---
>  Documentation/userspace-api/iommufd.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'll pick this up to for-rc, thanks

Jason
