Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CF16419
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889057; cv=none; b=VDgGt00ncnzImLgj9e1U+o07rk3rLDF0AZepi9J/e66fhVluYXWM7qnsMg0mO9YMSIDWvgoQfkVC5Aj1NmywvlG1BfM8eSg4XmBd+9hYsW9O9FXyFhonrI61P3dmXNmVvTENRyPuh3AckAkmymlDY/C4MzMvfACiH+kEI28SRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889057; c=relaxed/simple;
	bh=7JGl7TePWKhTpRU50yMWqewn6JJD15MBrbzn0elUEjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5xqDrrkYxj6MAbNxc8ZuPL5wWvHLHMXvExSLI0Mm2LvD3MpDJxnPDEie+wstLEMXU+aMA3pmE1hLv08USzNEfRTjZ8rJBBdXpp8cjAqkkksDtCcdvPWqovShfCPEinhZ00Mm/a458no1EGxZXc6liwqp2oFaj+xqbIMeI8Uc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aHX/hTg5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aHX/hTg5"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a9acc6f22dso5444085a.0
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727889054; x=1728493854; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4EiKYYe1CJQvog/BX4Ah/NS2vQW9eWuxcyQNBZYWNE=;
        b=aHX/hTg5fyqRWa7w4ie+usFz+J0+Eao9K8NJ++Yyw7Pu+acSMpDvOS7oq0wbhferAn
         JvT9zEm7lz84wY8w/tylo9L8cI+FMvUfPAhTY0DfkbmsYMoH6y61+UShsY1/Rdg/Ua48
         AmUdE+xM+3CxDkjk37VsknLDvj7fSDq6QvogM794fVana4uLybAd746jPPDyMPh4zXW6
         kx+ZN6mSvzyzf0u8N1iRnl6Nj4SlZe+37hVObUX6feL0+JbZZmCD4HpHR30hLqS8zQWq
         kQSr6xAQE7jLKY/AajF9W1fQM5gmStDFP+C7GkYapRG2TBg1p9MejE4SCUUHo7tslKna
         eghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727889054; x=1728493854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4EiKYYe1CJQvog/BX4Ah/NS2vQW9eWuxcyQNBZYWNE=;
        b=JZAKMUqnKBauEPGuQoUTCQVbXnlauseNkkY4efWdxFGSmlr5SpVGyp/r++6ZDITC0x
         gbdbB51X90lwbpJqxreAUPv/F4hzpNxC1t7Cy/LVGQTb3zHyoVsGQszoKHc30Bs+qrNT
         SZfdTTPw1eOOTIzdeqtMzQtJNhReZoB/3nb9i0QYzgkcDauCfYy/IB++AK9h0wA2pJ00
         Yk98fTPcFowFmG8TQoWvIlL7QMel1kHmueaceByjaI9NBpT4KFBlUfcYABVXqkmb14oN
         18XiLzHgG0qL9g20dFtoi5el8eMnvbkuikr78xCfj0CiwllI2Wl9OOqtCVDLjkR1ZpJ4
         sUuA==
X-Forwarded-Encrypted: i=1; AJvYcCVTxBaKoyLTjjc6vF5MSYSQrvkhelJt7cSv1BGYWZ2BU9JLZdng9eap727bNYvKheQZIJuPxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxL2VTW0b4j58newutf3JcWBmeviTbvOB7hXYAeuOZhinj607Ns
	CfgiFuCR/1KxC/OLyCKn2V79/AuVfquSq08u9RR0aERqH5QdkvwDcgsajlvdAvI=
X-Google-Smtp-Source: AGHT+IEgfpI7hs5izfDn8bbQxtzb+yBFcK0/AlanIcG3GBjnxQXlRbkYmkxBhEwt2aoTYZycqlKjUg==
X-Received: by 2002:a05:620a:24c5:b0:7a9:be2f:651a with SMTP id af79cd13be357-7ae626b38f1mr589614085a.2.1727889054056;
        Wed, 02 Oct 2024 10:10:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377e8a9bsm627451285a.57.2024.10.02.10.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 10:10:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw2sG-00A0mc-PQ;
	Wed, 02 Oct 2024 14:10:52 -0300
Date: Wed, 2 Oct 2024 14:10:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <20241002171052.GJ1369530@ziepe.ca>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
 <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
 <20241002135728.GD1369530@ziepe.ca>
 <Zv168jJMZpxGLFmR@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv168jJMZpxGLFmR@Asurada-Nvidia>

On Wed, Oct 02, 2024 at 09:55:14AM -0700, Nicolin Chen wrote:
> > dev_name()'s result can't leave the lock either, at least not with out
> > some refcounting on the struct device.
> 
> I found dev_name returns "const char *" so the string source is
> likely in the data section? If so, could the result of a locked
> "master_name = dev_name()" get away from the lock?

The name is allocated memory freed when the struct device is freed.

Jason
