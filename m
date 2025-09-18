Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03F23B605
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206214; cv=none; b=WLoPUQ9n7fMLSO++rgi06g0u9b1iS5oZyMDnzqi6yrqdeIY/+5MSTF+lTdihnbTnhzzfDZCgVh0B+zI7M7PWysTHToVs/OXVn7ZMSCg90yRfbJyH6SAiR3K75su8aaHRaLagEHqV20WHlpaEV8/INuM6Vdl/Jw4BJ7Fnm9zsIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206214; c=relaxed/simple;
	bh=5IK6dxmlUx1MjIUb26gztFgKXFnJCShruWZFcwG3LWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoPSkv1xKLdCGEdWeeg/M/X8sCu2z6Z5GHE3KJV97H25I1fMUgmOZSp9S5rcCxm2QlkUEIso7e0qRSSJbv4hftTXy9hxjorPkDOxtrQ603tJuuyCQRJWMFz+P7TIk5SnxZBL5p9dkyyuvQPhcOlYC5cjE24qHq+8Z3Sqvjh2QhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gc78rDcm; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gc78rDcm"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8287fedae95so141409685a.3
        for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758206211; x=1758811011; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrVmh9WioYbmEoq4Y4G7QBMqeKPDVKPWX4R50WAG25o=;
        b=gc78rDcmJIGB+MYZaJ7KnZCx0BdBdjPO2ooqp5eTNpmnhju+FifJKWGB0oZisvcEYj
         xBEc82Qpa+aSPrnBWFIWSfB4Z6h+OFq23YTbhBGKT3KNthwk/o0Jy9E7RHasb25pt0cC
         2BUBcO70nxrU0bH2LzUltYUC6D+WnH9QUifW5Roc9113yv3CGehmAy3CzEhUp4cxtSX+
         AoebSMq3Ye69TQ9gykK3Ti1QAg+umNf6wE2pugGsrX0jSHWSGW5dx3VW4WrtP+Ool0SF
         Rxn6zmaceJhzEFa+mEH9f3l4rXhjt0D//NNcNx66Pr2iQXO6T6/Ch0rKoFa3YZUz7ejL
         LFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206211; x=1758811011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrVmh9WioYbmEoq4Y4G7QBMqeKPDVKPWX4R50WAG25o=;
        b=J1dk0H17DgrWC0yPFeqvnjf2S94xdWYnWAdfTfe4uoeM6aNHc4HojfHHG0fAooflhs
         B4UhqmTfD8a81nI5HAm9UYBn+3S1x0tAvRUk6MAGeiZhYLLSlKcdZDZvj7eldugAJQsR
         dumWF4IbN29bReBs7qu7LrPNjT93uKqU0T/G5G6K7Z7d+8bK0wflB5wxJBmxvt9Tcx7W
         Cn7Jd1m4WuwpQaDZ4FrWnVkU25XQaP8ZcSHuAK+PWww2ZCOwMzvYkvyCGB/qjIjBpUb3
         3FkL393Bk/JDvLwla246Iem6n/mvp5vwqVTXupFJbAkNwvvF8AUeb3JQgQOD1GTA/lHC
         /ACA==
X-Forwarded-Encrypted: i=1; AJvYcCURHYhLpsSvOz7iQ/WqGdX/uGGlleTxhMpVoZ+p5/ud8Zy1N4BT9xACJk58eK4N8N/dnJ8K2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmoyLYcC8vCrkeIQy3aZQfGAOyNn6QmDeO1MVnY+mOD1nh7uQ+
	KZ+/GreCNZdqPBQaGJBoN2VQbh7HiujvBtESYV4Y241g0t09PXdrXcKiUQlvQB4+2co=
X-Gm-Gg: ASbGnct69cgskoTqv4mytp4z7G6yonYtMLc0140DoSHI47chEMtP9l/v/BdW1EmGdW/
	hkyPPKHKfeCYVYmEK8Bz9Mxz2NUg1/1Dg2+K8DeGaufCmkAXrukHJYvKEINYMeDk8dgIIuGnWGk
	ZAvnXKLV9Y1f+qZhpj/2iJwH6UfRgpUF6hcHIdeZDTnbWjnzbBMFT+NFaZcGPKzk2RUxEPgH7XV
	WuSr8K0/sIk/zR5i3tUZJO1zxIF47qq8OH1S5DKBCvHms+wBWH8FAjIAHXgHLoHoWPPQ0a1X3CJ
	IieutOP8IlnsrEH53QU/nRd1cOrm5ETg99k2WXR2WJFnmFgoZgIlp6wMkw+ooXYLjAmCv8M/lLh
	QTC6xK+6yyN9isJ3prO8LSV3O2Fk1EkJ16tYYlULcBscmTdBEJSiHFUkBmDvFqTCKBLJiOUZBva
	inPDBFzfQtFbA=
X-Google-Smtp-Source: AGHT+IE8/5Ud/i8k8I1bre3zwyW5lDIdJBqEnB52NPRTieNqwTGZ6V2Ab0vPLtj2VgmwLHtb5fpg9w==
X-Received: by 2002:a05:620a:4152:b0:806:a07:9fc5 with SMTP id af79cd13be357-831085ab77fmr631920785a.24.1758206211361;
        Thu, 18 Sep 2025 07:36:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83633b04dadsm168450785a.64.2025.09.18.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:36:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzFkg-00000008wHU-1PaB;
	Thu, 18 Sep 2025 11:36:50 -0300
Date: Thu, 18 Sep 2025 11:36:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <20250918143650.GQ1326709@ziepe.ca>
References: <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
 <20250915163858.GK882933@ziepe.ca>
 <aMl_5j8G3IGulAC6@google.com>
 <20250917123601.GA1326709@ziepe.ca>
 <aMrNTny9jgZJd_Ef@willie-the-truck>
 <20250917151612.GH1326709@ziepe.ca>
 <aMrS71vQ_MaVonzi@willie-the-truck>
 <20250917155931.GI1326709@ziepe.ca>
 <aMveas3QWXUk6xpm@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMveas3QWXUk6xpm@willie-the-truck>

On Thu, Sep 18, 2025 at 11:26:50AM +0100, Will Deacon wrote:
> On Wed, Sep 17, 2025 at 12:59:31PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 17, 2025 at 04:25:35PM +0100, Will Deacon wrote:
> > 
> > > Ah right, so the driver would unnecessarily issue CMOs for the structures
> > > that are just shared with the hypervisor. At least it's _functional_ that
> > > way, but I'm sure people will complain!
> > 
> > Yes, functional, why would anyone complain? STE and CD manipulation is
> > not fast path for anything?
> 
> Won't it also apply to cmdq insertion?

Oh, changing CMDQ wasn't on my mind..

Yeah, OK I don't know what the performance delta would be like there.

However, to get peak performance out of pkvm we really do want the
SMMU driver to write CMDQ as cachable, pkvm to read it as cachable and
then copy it to a non-cachable HW queue.

Otherwise pkvm will be issuing CMOs on fast paths :\

If we convert the slow speed stuff, STE, CD, Fault to do CMOs then we
could make a fairly small change for pkvm mode to force the guest CMDQ
to be cachable without CMO. Some special feature triggered by pkvm
detection during probe.

Jason
