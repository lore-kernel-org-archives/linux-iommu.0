Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673B344DAD
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860422; cv=none; b=OR5ggdxL8lQfqjm1ExeauVjeU3yA3yAlKArxTy9Sjmu2Ml791evS1gG5ylkLQv6fOFbFmDUMWI3YVaoSSsUZUDyQRV/mZWnFMy5JywH8vJ7bSh3nvC5MiquGMhFJHcyaJw6phwIeoU79jZYRCzbJ3T5khTyhyX3w97xWtwDJdJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860422; c=relaxed/simple;
	bh=JztHpj3xrPPcXAFvjgRUWT6/c6wbftyk1S6xAEpG1b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGkQdAs+rGCrd2/4eSvU8Y+Ck4Arp997gyNnqESLIAbBMgfzaHS0Lnrmny+kZUVRvwwPkymnUBwhjNFyywtzEIMCLSOdeUWZA9G/RtvkoIpQAaWE3WWqB89Xr6dlMDd2CbqAHM2ucOhGbgKqnhUiSWMkoWbO53xMsHRkvalje+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oIoPApHk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIoPApHk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2591757fbso394075ad.0
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776860421; x=1777465221; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gaQT/1l0e+bH/yWc/HRTLfyO6XrvfCklZm2VLp5ziQU=;
        b=oIoPApHkdpgjLZbhltzeE36v+BLKlghCVX/GUDbibUKBWIO+DblxJIaMQFmTKqu3L0
         vOprSO8M/5Kf1mwHBmxF/MwLZf9W5GuEobHd/yDIKpsI+HVdTUoLuEQXICHPnXcW6tGS
         uxY/ascEeGBuoxTnS7aF8OvJarlKivD9ehvhrHMnLbZLVGcB0w2IHjOyXo9Y0teJCryi
         PZY4bGs7S8wWe0Yp1TVvNyCXF9JOf7r/zREIr8mV7qcudtbwnc2E8xFmfpdYRy/IlfQb
         70MupNwwjDaTIC29RjuFy5rzlJD+TFuNSl/LjQ8AC/OxssEwMb8+EsaYrR9llTRMRgxR
         SOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776860421; x=1777465221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaQT/1l0e+bH/yWc/HRTLfyO6XrvfCklZm2VLp5ziQU=;
        b=lskn7ViLOk1SPz/vPj7Whd2ipvJNVO+tZ8/OfjCuY5bgMhpeRBkASohueSY9JeB/Sj
         ecimoGOT8BedMMYnJVFvodUhpHuAtQ1SYFrJ0v6aUXQyopdKNnLL6ZtR1DpeHClHJ6Vq
         bqUD5cQO5b/1ib03yZcvT3Lj6lggGy44rJJjOdWVBNdtaLb33xcR3Hl9kfDHR+xwqOAM
         zrkMepA4f3Q7LWG+GYlitYm3HGds2Sz2w0x0/0LA3/PK2CiHCT06+RCNWvUv30xkoEp6
         0C42PxOBbt+9dLPjHpPQNkyx3RQ6t/BMudR9S2YNW0UAQ7i12s301v4nisvoPKgM8pFj
         5jXg==
X-Gm-Message-State: AOJu0YwsmphT9x4UYoeTOUrCzFm0da76ht1EVkOTVTx323HUJcYQdyoP
	Ex4CQMXyiX0JUT9TrZM+4ds8g0bPYyM5k//spfsR0Xw05odqzAe7bwQXSvxYjP0g+w==
X-Gm-Gg: AeBDievXtLUsNi3TpZTz2QI24L+YkShCXMjaQCeJK/1V405OrksS991QSpzQjzEppMj
	JxcJUEl7YHbDSadk6pIGMkPsrp+uyUrhRVX2wAI3NkW7E0gDSLWXl3TFqDKRJaf/VXonMdvVvaK
	FvdFqy3Go0Hw2RLnrwVv480x0zFaeKWEGrWx0lJ0Fx1VA8ptjrSkVIYTPGJopjv6SrBSntufN73
	qk3LBVfQDCYF3G7ww6B1PBDGShnZWFQOKRh39rvPkTgJdBet7HdYrFeWroujiE1XI0ef8jLjdJJ
	9Fqwtb6/au7BxBGaiboz9lqUYR6TrMU6RqKZCZnC/10ySZt52JyOZ9FNjbJkLyW2UpMPo9N8M23
	i78zVHWxEMT4Z1jHZo0aiRQRkXMCFN1BC9OogY8AuzQ0EC7t2Cg1nVvH6uw7vknoxALpaByiQj5
	6miHw/wx9lXanLuJ0wpU1A9c/rUTRqZ8gta/HiBg2OeQ+j0/T4sOsCY509RaG/fjEHOW9pZe/pY
	Q6ooyTQF4GFHN3uMg==
X-Received: by 2002:a17:903:3847:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2b603f68900mr1906405ad.13.1776860420143;
        Wed, 22 Apr 2026 05:20:20 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2f129sm152713895ad.29.2026.04.22.05.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:20:19 -0700 (PDT)
Date: Wed, 22 Apr 2026 12:20:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <aei8_U-YLNHcocf2@google.com>
References: <20260414194702.1229094-1-praan@google.com>
 <20260414194702.1229094-8-praan@google.com>
 <CAE2F3rAAaxP7a3v_K2n3WWQHeA8jfMkhB9DWz3j1Ggu74EXftg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rAAaxP7a3v_K2n3WWQHeA8jfMkhB9DWz3j1Ggu74EXftg@mail.gmail.com>

On Mon, Apr 20, 2026 at 09:47:36PM -0700, Daniel Mentz wrote:
> On Tue, Apr 14, 2026 at 12:47 PM Pranjal Shrivastava <praan@google.com> wrote:
> > +       /* Mark the CMDQ to stop */
> > +       llq.val = READ_ONCE(cmdq->q.llq.val);
> > +       do {
> > +               head = llq;
> > +               head.prod |= CMDQ_PROD_STOP_FLAG;
> > +
> > +               old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
> > +               if (old == llq.val)
> > +                       break;
> > +
> > +               llq.val = old;
> > +       } while (1);
> 
> Can the equivalent be achieved with the following?
> 
> atomic_or(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);

Ack, I'll update it to use atomic_fetch_or_relaxed() in the next version

Thanks,
Praan
