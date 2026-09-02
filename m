Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD64A0914
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356904; cv=pass; b=jIfEdks4kuLWQ/oxPGN8PWWMlWoEbpIo0JxYxenbKgQhPit4eyyVg/YbnVPmW5Bq5uo1sfRCUDorB0K3tfzDqycLVtO4q6ysuTpgfnddBJu6w6PsmAcTzRtFRjNWtnWtYs/SVDsvWFcl+u9xkER++fSoBIhUNRwf/N9rw+tp1fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356904; c=relaxed/simple;
	bh=+42ZwAZfWz6EQJuENr4K5+WECumrM9FQdFwIi3wiFxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwiYWWJyiP8YHku4Q5xxSV/ixwe2qJR8ru4kEjyZIV9xsxqr6psr0dFnRV7d+cNWFqHG2gw8hLZ9pQMa/rz0BOqyUb2PQSrR6FySQ6efGPPAxG06ESW8m8g8pnneDpq1iLZ0YzXhAt3+00i9f3gtDvSJaYZyqJV/kIlDQvGFSxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+HSOjH9; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+HSOjH9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d942c7cc2fso8741905ad.3
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 06:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788356902; cv=none;
        d=google.com; s=arc-20260327;
        b=leM7/72pEztczOXmfNeyisTbsU+KulQ5eqrxs732hXGtmhP//nUiS9uNmw0unLNE9C
         9BKXRX3QsCNYD0Hm+pq+bEIQjdRF3Ica0PFUXSZjcSRjPEuj9qgiF/2chw7wA4Zm4UdO
         p9BmxsE8jNX3yrra83CtEDKgL0Bt3yrTR5BH0dKU2HBAxUDDxsppa8je1l+mH3na12Ml
         EwuCFoRnSs+EJ74z7NM3j4xSgU5W5vb9+aZGR+cpR4u5jw3K6XoIUo5Trku/2UmDJFqR
         jt1Frayk+QthzoNzNXrBFOHpQcQZ8F2uLW9QbaVbPN9d6pEEbEPI2+7BxdNoEjvX7CmA
         G/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QypsYKIskc6MAKJkcpIiHDdNJyIbCg7f80xVvnLCTGA=;
        fh=dT37VVfygpyHHEF5lzg946gSvBePcBYb6/k4r10Nh1I=;
        b=ZMS4UaS60zSrVdQHV6Vru2xKywqqfz8EOiJ/gSZXyKz2O/YlyXcxA5FKusm/bd6vbz
         j7gPlIoA/M54L1yAvxm9GreIV8Yf1GVvnXRxKbMIuMyYKWPekpW7N2DjW3+h98lCGvgp
         My9ThdSbnxMiaLAUCbL4+DD9y3nTNIpFRCgidV/fgFnwCuGxa8FuZY7l7uXQhKVbJHtj
         00aXzCNljInjOaOOCqn52rgubIjc5UH1NIpOiellwvWVB6jvwke+j5LaxrDAmPAwPTNG
         yncfoHaeoDDtb8539LsRapUjcYDrCx8xtydQngdf44kh4NCYSPreM6vYUD4cthZipDw/
         N5KQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356902; x=1788961702; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QypsYKIskc6MAKJkcpIiHDdNJyIbCg7f80xVvnLCTGA=;
        b=L+HSOjH90V/4rAt3MA+WMh6s7BZuttY9rqpB0IOUB6Q9hzUHxHXM+uNh7doXLkz+ax
         lBf+6pRbhxQ/iP7hHufPazN7w7jYC4QuV9Z6TBkiAYM3fT9JEQVPMwRpiav1gVjtIzZV
         1rWVipewwSv30L9n5AKsgpAPEarP7hsCtWHaZc9fiRkmaIjgffuJxAYOl1KOB8E6a8ea
         ob5UFQ3jZHtYYWTV49OjhD8nyS2m2LoYCnSjUfk5nyOEO/Ejtqa/kNg5DQHNjMiRdDfb
         UeyqKDhol5UjuvhP1jpbTLWBUe0qsAzqwp3SwVNcXr9XaSj1HykKKbDBnCgmn7thVFTH
         McbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356902; x=1788961702;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QypsYKIskc6MAKJkcpIiHDdNJyIbCg7f80xVvnLCTGA=;
        b=RJd4FPC8LUO0SRbgJO/uTqh4O8lZS04bqbwpJeZZaFpaUZhVtAJdssauE12XiAXXOR
         sojedSHLNuREFt3X05PnS8jCnK9wGdhWRpRs0S/w4TIAscm1EvOuOgDNZwonSIXyYPmP
         gKt5AdfgkeyL950l+ewXvjK1JSsioR4smuKXYoUcCjuJheRrroHZqWuEo+yiTiaw10F4
         ggsmE/ARCgebHQl6v9q0gCEOJBQ3brc5niuzRhW20hpYe2aE3oyCRyRmMNC6bNcGBG71
         m7sY+Y97372aIPt+vZ/2nc/TsIGdzdcBHenCXvVSQoxlvYc9Hqe770zf9ug8ypYluBp7
         qQLg==
X-Forwarded-Encrypted: i=1; AKwUvBxbSNo0zX0GuK3jnDKaN1XXmxCyrwxotFuOVDF5jw2zKfR8ImYF7y0sUDa+cqrlJ59NLbnlsg==@lists.linux.dev
X-Gm-Message-State: AFuF++ng2PovzxPUbkCr/hlhjjJ23nM16EuobTIWVF2lWzVYDWUUZQmt
	OXfLZOGLNlzkUFi1jPZvp/jevFvH/pTJ2WrTLxLKnm0C/CLZKu/SoeFCMvcoqKwYSAS4D3coJBO
	rNafnDehh4+9+kdfGsR5GmqHk/v4rGRQ=
X-Gm-Gg: AYBFou0FVFU/Fhyx63wdOV+E0UEs7cARnF15o1up0dDDjsmh3KBSQQmMInxJWXrUqAT
	wtrAPICMlfDg9QwzL5EDhXoi9u5QezzOl3lb0TQ4n0meZ4ZhTHQjy5xMAGl2DJI9vn95Tgi0XKa
	iNV5+S3hx15X1sllwMrfwSte1VNsRlzTc1XfMcXoGXtLkFty2EurAG4m0Mxb06K/gyJDhJ4wsbo
	5gMOavyOClooXzP+eUl56Tker1fpiNeYyPV4Jdb4CposVcMI/ZfJkPpwpAU+UBBxaI2YVGiV1dS
	DnNRJ6DcRPjC3OMDadcaGTRhtuPI4vYTKuFPdfT/XzzJTHKneMpHY1tbWT1r
X-Received: by 2002:a17:903:19ec:b0:2d6:e4ff:9cad with SMTP id
 d9443c01a7336-2daec5ab9c5mr78487095ad.3.1788356902265; Wed, 02 Sep 2026
 06:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260902085414.549830-1-qinyuntan@linux.alibaba.com>
In-Reply-To: <20260902085414.549830-1-qinyuntan@linux.alibaba.com>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Wed, 2 Sep 2026 21:47:44 +0800
X-Gm-Features: AcwNN1UhpA6oUFXyIwwyE7i3ckphOc8Hf2zTXfKohJhd0MCGqD6y-NygI40bV2I
Message-ID: <CALX8JfSMTECqP4FY5T3WPBwF-+RPfdAnN9pZWO0s2E8OVOQMGw@mail.gmail.com>
Subject: Re: [PATCH] iommufd/selftest: Return dmabuf fd from
 IOMMU_TEST_OP_DMABUF_GET again
To: Qinyun Tan <qinyuntan@linux.alibaba.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Xunlei Pang <xlpang@linux.alibaba.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> failure, but the applied version also changed the success path to
> return 0, so userspace no longer receives the fd.  Note the patch as
> posted on the list returned rc here; the change to return 0 appeared
> when it was applied:

Thanks for catching it.
