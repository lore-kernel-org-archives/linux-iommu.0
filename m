Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F001DEFFC
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466433; cv=none; b=VFQBI6aPwW7JDZJf9oXa/78pjQX/Qi0KnJ3FTOs7iy1obrr2tbDZsfFpLenBb1qY+i+ZiObo55d4q2EkJ9FkGRouyl//U+SuBwOhSAFEoZENd3pl4IeRznhZ7/ms17Mmsaaabzk9K4uthHO9jBKujbePvY/0Ur2Cj65rRZCemXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466433; c=relaxed/simple;
	bh=F0tflm8lUJEDxwwzpsOtmN1YD0WLfapvq+ZP3t3dN8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mborfEd2JAbFbL+lRSaw3RIJ4CwgopxN26OeSrtgZWrE+I6J0bSwTeTEMy8rXR0f7QXWJVG4AW4YPrpuCWBYhvJk/wEAp+x8Nl2Qw0t7kM82F9/4lUJTycMGnwMMgTZyzLKarLKDfiqZWoFUMJqrmMkl+p38TRAUXtjZqWnNPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=csKVzkw1; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="csKVzkw1"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5dca990cf58so4254233eaf.1
        for <iommu@lists.linux.dev>; Wed, 04 Sep 2024 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725466431; x=1726071231; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj5mk/fNbVZIeIPVjyNKDlVGZrLoOf8EX02mwukEb/M=;
        b=csKVzkw1X9m7lT7eLvATwX3M/LrbV7P14ZDY3FlA1k/CGPMvbHPoubjsYlCZTSKmuU
         WGdCFsDCWgEyh3ys54yJ/hPS2wcqvdiNTWQPg6ewCuGrEVhyZ1+6FohTBl0N6Er+wXmj
         bFPu8Z1UkaSjJyxfDwqJlzzyPsVJFlY9JRatRVCWMeDNgkyLQZcTQuGico13Q2l/WjZm
         /XXLyyMZHoe11KnPlirxYvk22QLX4poQaL1Owtx2EhC4bMZafq01wrLQdLK7OZLdQFpY
         QDWMx8TCcV0qUdMgRmWzsZ1d4NrfRqk/cOe0xNRA4q5d7rhZ9aoumwM4LAu2se0LLks9
         +GAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466431; x=1726071231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj5mk/fNbVZIeIPVjyNKDlVGZrLoOf8EX02mwukEb/M=;
        b=B98h7yBjP5PAcq4uyPhL2b6X2JSUbDXhdw54ry0/I7HJBSg8+AInqLoAuePESGzoox
         +DdGigfL+ys4raRCX9A6kEUxzJ0IaHvhj4y/EBsMN+5QyxP6q01aOQIV+wBuFraks9YZ
         YiO89QI3ow5Y/0UoKcyjorzv/gzFaI5Q0ePcTO5Au8TTvn27s8iKA//0IEZdV0o2Jntm
         mMjt3xupqT1Hgfrf6sj8O+6Fs2wW4KIJHBrq4HbdteXn8lrupm7UlAlcrvbNA5/hIg92
         0fxkXRvOBxH/Gdp7LSlBWArIQ2ytGOqqEFhDzJ1KCGBYaETyj49LUzsCCtmurg5Yak5I
         Nskw==
X-Forwarded-Encrypted: i=1; AJvYcCVH9408aTeNDg9wJIkxRrQCXkv7ofQ+e/uViVpDXaD2mvCrbihwcEU29PePmr2igbWQSOsCLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgtjPVKBzsPFRazDXuUYuE1gXjZQahARSczHZi0jcxiW9ck0KA
	r7Dy+WD8vJ9Qu+IMBfKgTjsxLpwA4RWEbevEHO+539EZDBM3Q5oX43ki1sFzRJQ=
X-Google-Smtp-Source: AGHT+IG23YM435yb5+zdC+sOzZ47eKaCiwa4MpP1Qb9C9YZpsqWk7EV1Amt4nLH9b/uRuS3girT99g==
X-Received: by 2002:a05:6870:f10c:b0:261:211:9d14 with SMTP id 586e51a60fabf-27800506b56mr11670281fac.37.1725466431302;
        Wed, 04 Sep 2024 09:13:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d88943sm626411585a.133.2024.09.04.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:13:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1slsdi-004lkN-4t;
	Wed, 04 Sep 2024 13:13:50 -0300
Date: Wed, 4 Sep 2024 13:13:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: Klaus Jensen <its@irrelevant.dk>, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 0/6] iommu: enable user space iopfs in
 non-nested and non-svm cases
Message-ID: <20240904161350.GE1909087@ziepe.ca>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
 <CGME20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97@eucas1p2.samsung.com>
 <20240826135955.GI3468552@ziepe.ca>
 <20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>

On Mon, Sep 02, 2024 at 12:48:19PM +0200, Joel Granados wrote:
> > >   Supplementary repositories supporting this patchset:
> > >     1. A user space library libvfn [1] which is used for testing and
> > >        verification (see examples/iopf.c), and
> > 
> > That's pretty neat, I've been wanting to see some kind of IOMMU test
> > suite based around a capable widely available device. This is the
> > closest I've seen..
>
> Yes! This is an obvious application of libvfn. Do you see it as a
> something that can be included in tools/selftests/iommu?

Maybe? What would it look like in-kernel?

I've been thinking the same thing with mlx5

Maybe some kind of test runner with a plugin driver that has some kind
of 'do dma', 'generate interrupt', etc sort of operations, IDK.

Jason
