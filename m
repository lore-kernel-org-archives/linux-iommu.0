Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B6933D6EE
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109474; cv=none; b=NUf8cA5GpH/pmVF1QBf1TzOt6kbFUL6O8MPALoT6Y65mh2E6D4Cc5zlYibSukuw+kGnJOwGUTprgBkGqZyFpNRRqvSlC5pIR+hw2heAzx9dzS3hpq+SSBNOH/haje5QnghnUGYCsF4+cYgZP3ngLHL2tgVTF6ZfQN8WNBFw7x68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109474; c=relaxed/simple;
	bh=ETUY4qwRGcpk7zuC4smh2HXgcfeYT29cBZRhCkov9iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kg6OZnHpeQ97YNVSfsSBhAqoZayNwNnnxi1HRSbqH7kDTj7jxqmKVtFpoESKbUv28BOVs0/0XuO16Bkqfl7Vuna2PVD2j0AStuHmz7LFv5xVAPgRPAFhUWXVrtBbLkBRGuRr0Ajk3fNDtBn77rRDqLO9aZ9BvyM2/WwgVVNaGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TksMJ7oe; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TksMJ7oe"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-915bf8800a2so489020885a.0
        for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781109472; x=1781714272; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUgz7K4XsF7x64fY0xkZv2cjrDr/QVedQTqwT5jvCKY=;
        b=TksMJ7oe49eFEGD0oBOWQVHkJioArKAcnWtSHuPSbgjq/gt1NnXR3a9NI8K85OeCjP
         uCxZYgv8N80AkTTFoHhYvnbzmK2FrGj5z/xs5h2jn0PCZ4qp6we1/lgowzZiTfq3ru61
         FLu2Ossc18StHpHQxg6G0Tqj8snXv976YH5Q4qiLp5WQJaQYunoYBsR8goV18A/ZUfNe
         /wS1SEYEN5xNVenhkWdSHO7Rd0ipRIh0HqDD7gDWvOVeUAT5hiMQkidD/GLDhdJOv0x+
         LA4JzgaoI5M18Ol4tUCOi6vfX0+HcQAlQHEucKygRXgM+6fG2o8HA1oVChl3tSNVRw45
         Yxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781109472; x=1781714272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUgz7K4XsF7x64fY0xkZv2cjrDr/QVedQTqwT5jvCKY=;
        b=edD0jf/NowJ2L9tr6XXebo/kRSQSEKLV8QXVl4Fv1iLI2UBZX8i/CjGzcX+cAn3OV0
         p01hslNCu5O1qwmu0Tr5Xfi6xP9yxaN9T95ggl7YM0BT9eab1tl0d5vd9pDB8PlnAyr8
         kFpDXdbGEz95ciQAAAPyr44z92IarcGYKEgE/GrUTpWTFcOoxbxW4xUEE9Pcv0RY1RJ+
         MD1PhBldwx9RO59h2RX4PAPwEJvini0L5fzVU7Hq7bhtBwvGWgIwsR8vDT26gQ6zqWOl
         6F4OWqjtjjIf3uALU5zKEUiK25iH+bZqv/lUp+Lc+erEXV0US1s0BBhyVVd4XvVwaRqa
         w3hQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ln1yYw0d1iq7WlrL5qNcwlYJ3MrcCOLstERU7clXVY215hKHiBFRDFMdpFGPeZU05qHkTUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnblXhmdorwaAZn+u/2G7Mzx6jl+7dsSV5EU7hXqERjG5XgpV3
	VfFWYVXRJNcB/5FDcq73itLyVz9k/dlXxwFJS/gW23fFuYhefliW9YVDClrlYn9fW3s=
X-Gm-Gg: Acq92OE0cY6fN5tDew8Dj6LqJlM1IgR4WWhlzaDFVXy8lIgfLd4U+qipUCxmIMMYJtl
	iCTwL73Hw3NeNx+5e+P+GKe9wzqzGuqX6a3WgVMO/VVuVD5m7eFWM/NMSFivjp9V0xJvK2hGSoL
	gACxiFSeYPgMCX1OIdI3at8MPeLC83nR+sqoRRVyhGx9scFXARYIVnZBhowTFTIck3dlXzi4auT
	sqDJ2rsf8DabCaLlVSLDNx23GUszlzf/DmogJySFsKNZIrlSolWkhbjKAWMb0nyONpcX7WrwdZo
	Q0lAUjGCPirQxmkc9gAJgU8Wg/J7yBVTB/cVtWJCY/RpxkFuwAm26S3fgeg1sg0LK6OfvhQonUh
	eKAsq+H9Lr0U0UlrS4JTNpWhTEa5BPCMOH5fTG0ZuNQa4QM8sK0zvfK49jW53HIzM01X4tzDMjU
	p42BiKNR6ry5iHvUgIaHA/Qji7nKn4/kAymw3uOQnciurIZHrKvuWfQ1oklDSfrI4mKx+91vM0a
	ysewYYJI101kNMB
X-Received: by 2002:a05:620a:701b:b0:915:96e4:e49a with SMTP id af79cd13be357-915a9c373a4mr4004813885a.1.1781109472207;
        Wed, 10 Jun 2026 09:37:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91589ea0bcfsm2492548385a.0.2026.06.10.09.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:37:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXLw6-000000048Ns-2Eex;
	Wed, 10 Jun 2026 13:37:50 -0300
Date: Wed, 10 Jun 2026 13:37:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"open list:IOMMUFD" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/iommufd: avoid selftest dirty bitmap size wrap
Message-ID: <20260610163750.GP2764304@ziepe.ca>
References: <20260610002351.1672863.5f5d62d5e4be.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610002351.1672863.5f5d62d5e4be.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>

On Wed, Jun 10, 2026 at 12:23:52AM +0000, Samuel Moelius wrote:

> @@ -1705,6 +1707,13 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
>  		goto out_put;
>  	}
>  
> +	if (check_mul_overflow((unsigned long)SZ_16M, page_size, &max_length))
> +		max_length = ULONG_MAX;

You should never have a cast in a check_.._overflow like this.

Also just fail, something is really wrong if page size is so large
this doesn't succeed.

Jason
