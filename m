Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23F3F413D
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341090; cv=none; b=c9FRcyru5OYA5T72HLyp02vdMpk7JEE2i++XuQnhhAu19Obfu7hCuGaC1Ed74Z207IOaQByGOFEYzR08u2Ij2d0bBtEz3/+uIuZZ0Z1aTAHaiIfXwC7c7GcOvaE7LH9vuHF3bPaT6FNN5iAnmHvw+IC52yhfJTx3Bu5Z6rrcM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341090; c=relaxed/simple;
	bh=i+3VsxE5RlUTklQWpZlzvtrBu6ehub/Fr5i13MtDCuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL5Wr95monHbH3zjx7TpIjqV/JJK0KNJHL4KNxMWJij6olYDEBfHgzReR8Cc14/gDz1o5lkOGMrN0HdQf/6IPZqimnDzvEWR2ADY1orsgHdbqNQNijCwKDnvsbsSgwSMhO+RdOmY5dWMGaiw8+1YXtS21VgS5U925SeennZW29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jp0N96z3; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jp0N96z3"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e85499ffbso251168185a.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783341087; x=1783945887; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GCAkWMdkF5ipjGr4p830BCh9C6481Wk1fl4Ld4QNg9g=;
        b=jp0N96z3H83Iu4ywj/yTmE5MThClCVDfsHJuebgwNt6nbqF0XHv0RzGYZrBRfEhV3d
         iUHlIur9d91HBesvv7aZn3Y6/CdBA96lvdo8CuoiOveAP+6WKpnFOg7xspLK9BfjkcT2
         cGyxc0FnGBH8Ryhk410GQuklPvGhTAHWHNj7EOpEXzhP3Bb7GREYcqV90RBl3b8KDLNm
         Jc0xlaAbt36JevuGFj0AySSlYN8qaumGPoTxmYY1fOUdwimL53jHKMRen04c3Vj/duSi
         1pwhvbbrtJRE13VSIKfl4K9a23TIZ71Savod7QZZAHVZzKsTAye2Xdv0gQIIezBPEjkZ
         kUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341087; x=1783945887;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCAkWMdkF5ipjGr4p830BCh9C6481Wk1fl4Ld4QNg9g=;
        b=m6iCDcC8qoKzpRlZ1asIV7J3rZSI46w7fg0Z+e0JqEsBHAw6SfrD5QjR3DKQwgsdk2
         M0gkgUwzuZh9RIKrJWdmxBSTeOO9W72MaH0e3iDSjlUDkDjHDMy8W1HwrQnXnGAYCAsd
         dCbelbbh26sDSlFlFLqa/nE5X+f7fOEWxm5esm8zXPPNIl+p4WW1tRTgLNN7BlUOeBqg
         iQSzgX5x5DeKRUXOqRvIlmCtFElU9/R7Nvi+fOD27WRkKVaWL28A9FP9ZYRdEHI1t9st
         8I0FeAuoO0Lish1NDTYfe2mhd7kzg8eE1/1ub9c9r9Ln0+ztLFl3hG78ZKPqjOwDH8iC
         EFPA==
X-Forwarded-Encrypted: i=1; AHgh+RrpoEW6pq2uoHeHjEczoHxGflaOE6HVFohSUUuXaF8//c+c3sS2mHYoqCHQBCtheO15lR9G8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw26AOpfbXgMRVOsmq8PynIrOfQXMyTjMsoP+8Q5YLeoqUopMUA
	FoEItGsPFWBvxqAuAY9ymTuPmNWEfqw3pC5MjU/DrycBmPNgnAVImJPZuBRfCBEa7xc=
X-Gm-Gg: AfdE7ck3Zj5OQ0LJJkE3MpfiNaGh+7fjHSrXmrcPsYYQY/7sHJsj6lenzHndoJY00oL
	xL6ZiAhyOs8aiESy1r46MBqpX1lFGQtJt4VW0QLaRJN1X9oinadSUCeVXTsMzCG1To9CBdPH57F
	2SC/AeRSuR9UCqvgwUQFhvWzWFS7yLYqfUwhngZ2a2Ai0sdQ+CCjwE4WXVumZyO7NFfGpl+v/j3
	Do3ge6Gy7y87EPlYUGbnq4vVIrUUpccOL/Lkj43nqFZLq+58zGyPLkjCo2jlDCDo0yF26nhR5IR
	egwxZTp6EiSuR7jTWkQYhx6kS1SifJjZm/t+8Y0igOCM0WME3KF+K8UuBoplpturcueRnrn415P
	BQJTEY2qGBDlscNSxx84FMeG6Abu7q/7AfDpDcJtzlstRAb0AqRr0lfN+FngC
X-Received: by 2002:a05:620a:618e:b0:916:10f6:780f with SMTP id af79cd13be357-92ebb5665f8mr45100485a.27.1783341087397;
        Mon, 06 Jul 2026 05:31:27 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbe3e2sm918463385a.35.2026.07.06.05.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:31:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wgiTt-00000000Sbw-383D;
	Mon, 06 Jul 2026 09:31:25 -0300
Date: Mon, 6 Jul 2026 09:31:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
Message-ID: <20260706123125.GA107792@ziepe.ca>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
 <20260703162236.GX7525@ziepe.ca>
 <90558ba3-44e6-4d5e-9c72-ed8817d372be@arm.com>
 <20260703203502.GC1978949@ziepe.ca>
 <utb5awup2vypdhtcxk3vlczwrqbl3ypae6ftbwrlrkdqfnk4ft@aurl5kme27ac>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <utb5awup2vypdhtcxk3vlczwrqbl3ypae6ftbwrlrkdqfnk4ft@aurl5kme27ac>

On Mon, Jul 06, 2026 at 07:43:14AM +0000, Krzysztof Karas wrote:

> > I agree we shouldn't overcomplicate iommu_dma_map_sg(), so the
> > simplest fix is to introduce a SG_MAX_LENGTH set to UINT_MAX/2,
> > justified by the logic in iommu_dma_map_sg(). Fixup the core sg_alloc
> > code to respect that. WARN_ON in iommu_dma_map_sg() if a malformed
> > scatterlist entry is presented. Add a WARN_ON under DMA debugging
> > kconfig as well for the physical path.
>
> So instead of addressing this in iommu, we should focus on
> guarding in sg logic to prevent the overflows? 

You should focus on creating valid scatterlists..

> Or would you rather have this as additional, separate fix placed in
> this series?

I think this patch should be changed to check the length and
WARN_ON. It is a kernel bug to pass a malformed scatterlist.

You'll need other patches before this to not create illegal SGs in
whatever mapping path you are using.

Jason
