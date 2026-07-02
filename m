Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242D30B50D
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005580; cv=none; b=WecmLzcsTX/Jr0qv3Jymx/6Vh96zJyNNs9CCAbLDkTfYWxIhDMfybpfPgR77v724LWMtF66oTRIATy+v3hxNecH6hYjjQWeCtr1/lWpCVLEnqToByDfbQGu9yFXANNBR8Yoo/3EnhjUC60X50/EgiYiWLekNQNjqVp5SDKOUaqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005580; c=relaxed/simple;
	bh=una0b7iSQE3/1X7UfiBFNzSBZGQVECZybRvoQUF1H+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m35COz0KsmTxEk/AbPE/M5NKBbwcEhrUEnhHmAIdaPPw/xGiMVkPcm5XQ5efhIS1kkOO3NWyR2yjxdADtblofrJfwfMnnff3DLD6eOxtrZHAmPtVgwYYaoln2QprtovgHjkJQqnWTYCSXCJt5fNeklbtIk3FSxkOOQEWmtdX/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ndwCFHuK; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ndwCFHuK"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efcef23d21so12569516d6.2
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783005579; x=1783610379; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=una0b7iSQE3/1X7UfiBFNzSBZGQVECZybRvoQUF1H+I=;
        b=ndwCFHuKINeN8wCfTs6+jYDPMQmUa/daKxB176zlXYOdTfSHPbw+c42mmeiUqVg8z7
         8hOP8V3tagcd7dVj8i3Rkw3rT9PY6V2wZhV2rXC/zbRt3PGL2d6U/qRIhJg04g0ph+ba
         FMet/MsZSAfFgoCc3MYP1rOF11zJkRxnaceS/BvhiSv6a5pqCImPzVF89eK6gKIziudc
         +2cn1BLiZIABHt2hY1KyTJ5I3hWjxsIk7HQTVYdqXjWaGpCniL6iO3CfxTJLLSxsZIt0
         JZkMF0ayA4vSfO4mFkK+JAZLDr8t3pZmryT7Mr+1fu584BaUxkW7Iy8iEZOOufGiXzhC
         mcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783005579; x=1783610379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=una0b7iSQE3/1X7UfiBFNzSBZGQVECZybRvoQUF1H+I=;
        b=DevWIJMcyTCMWkOvD90ZFG/CNGHKYvU5m9wYqdMsa74fgEuWK0bi0gEhOsENFsNqIU
         U4DLtNC3KSdus0vF4DR3ojDyQXRMu3vUk11H+fYFPsbDVCNjtK16pcmmJ+G2WI74rSlc
         yy1bJl8Oh4jtfjrH8M34hnkEG6waQOpta0y6oIvhUuYBsN8IKSnlB/+8l4ML64JCpRWq
         Y2I8c0Mqsc6mi9rhw6IPHNhGy1hamNo4/8GdHa1Ur+xcImj0TZyvu6+0QICxGdrbJY6X
         POlgplBA0oaWF14QLGMrhp7vJC4jVZZKpk4eVAVA1Uxpkzq3GvX0b273+h5NHn0TVsWm
         BLAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUiFHVl3YJZ6T+jsuJep6XnnZF3uG7bZ9j1V/oCptHDCSyTJNFWYpjmSDiLEq2PuueZ5Y0xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXPfqxriaH9lhKy4ajo++ig31z5q4k4g6hzh56n8q0anahN7DC
	HAH4mJ3lkmbUIF+hLRHSHQyTq7KBsYNN9N3BhsxnrmSWcA3T4RbY4mwjRh2xycBa1nA=
X-Gm-Gg: AfdE7cmY6WclyC8lXkvhf3CNZ1Dcv8qY7HuEnFn8aMeDiRQPf4BEiY8LyUz0pVYBcrh
	Zhw4Dh6drQUUD2TArGcewCp0jyb8A8ruTWPW2QfKz5Qc/XOQDb4Vz/pN13rv8KfSHRDUMSUsaz+
	Ua7w7alFqUC8jiIN0lJtZ2f28qrJpRGwn2juo+RkGRfUA7INb+zTizEA8/lyvWbIg07i7AluKyy
	RfYGCDjfZESTrzlb684dvhNYyvmTHl6n7mRQRJrxUmC++6OInwXUbMaK+0gvYOjg1iNOswts7SR
	Zq0AvmPmczS2rSlsNcCBr8W7RviGnXJwIgcdZ2wDEzO/KSGi2bwBKmstOTVv8sB2CVAWVFG6HmU
	nirkd/b8PD7bkYjOr3Zqda1dJ5OPr6UtW3xMYEbVlxdDtEUFL8JUJcfWOL27s5qQNNk3BtKaMTC
	FodKQhdr1q3Bo6zsZNrZ9VmoFgvr7plhASz60DHuNbbz/WmfexiL8yuj5W7zoI8hVztWQ=
X-Received: by 2002:a05:6214:4208:b0:8de:16a7:fbe3 with SMTP id 6a1803df08f44-8f3c863d139mr68985636d6.31.1783005578597;
        Thu, 02 Jul 2026 08:19:38 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de93a1sm27985376d6.34.2026.07.02.08.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:19:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfJCR-00000005wsj-2X8o;
	Thu, 02 Jul 2026 12:19:35 -0300
Date: Thu, 2 Jul 2026 12:19:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260702151935.GR7525@ziepe.ca>
References: <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org>
 <20260630174216.GK7525@ziepe.ca>
 <yq5abjcro17x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5abjcro17x.fsf@kernel.org>

On Wed, Jul 01, 2026 at 08:39:06AM +0530, Aneesh Kumar K.V wrote:

> This is the only code path where we need to special-case host memory
> encryption. For this reason, I have avoided renaming
> io_tlb_mem::cc_shared to io_tlb_mem::unencrypted. I can send a v7 with
> the above and we can review the changes based on that?

I'm OK with this

Jason
