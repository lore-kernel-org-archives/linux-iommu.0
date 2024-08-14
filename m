Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F02381D4
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626138; cv=none; b=XwrlrrPjrd2zR15/RzAMeDl8S/pF8OdMpQ3gtuBGBWC6VqdkWM8p5QrXhlpyL49AXjr/GPvM5GX1ILoBX1pL+uPq1Nv4BIh2q9fAxCSX+0HhP1nlieneTahbbenq2q/uaxsxIhugx+8YGcOngt2Mee09BEBDZmpt+W+og5SOQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626138; c=relaxed/simple;
	bh=dsKV+wqMisbH03QAF7wEuOvOjTFUb6hi739fdjsgYAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbNqRGQDIyiUucYKWqjAydxn1vXlqnrHX5WfRAerKVFdwTFa6GJrSzZwMPaMRyo3kH9OqQp2lEhSRZ6CecIR2my/4DXmGRB1h6oaAzuRXz4wYlPHuvV51/YIals7wbIAeF6QM6Icc2mVvS9u2aDIBZWiJ6ldJSad6i0dT3pHTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axHv3zIf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axHv3zIf"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201e4cf371eso3485ad.0
        for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 02:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723626136; x=1724230936; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BeIv8tpPW4wd1BzSToPaTcquF6WJ68vuiwIAiNwYEo=;
        b=axHv3zIfRIJKKZuWKEiX/NZ5XwndDsB1EKeFdQ+Vfv5Nh0PI9viwHFRJD+WruWCj9E
         X/fIZxZfhI75FbPgUxdZqxcRIzGJlkzmhwvXneDyLzrTFe3PQR6f6o/s5rM7OIElETmJ
         xaaOLCEiAvpMT/+hxjmLLl6+jM3YMN+Qgbv0iNko9IrIk0j/P+v/TLtl090niq0TFY3C
         gwWSizAUo53BZVvfTALu8cHzTBVK1Z0DhNPsKb0YF7zNRThlZWLd8Zl4GwRWaTMdpSji
         C29EeCg7GJ2cmbpbENPa4B4asiMK1z4ic0SELdJg+1E4qY8MvI7CzBiXT9Pllca1K+zA
         sHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626136; x=1724230936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BeIv8tpPW4wd1BzSToPaTcquF6WJ68vuiwIAiNwYEo=;
        b=FwWgDv3fp3zxUddxJuW1h9aJT0NgqYOmi4J/eB9c6/sk5ER3OEdZUAgVkkS55LgY26
         UhMlJM4G736pbJNcD4GLHro8pzA/BE1ZIygaE1uySEcVXifmk9063TN2tfwOFgPPSTDX
         5i7NL2UDUCH89J4O+kjzsi1UgTwV4IzqMGBuq36m875zBrlPG6iS/DvrmpTGM+UvbxVI
         rnEI7MaVHCLCOJOzHNV7fI8kO5caJ2cAVlO5T6O/X9TvAvwLcwIKe3R9X73zSBamsRpT
         lt3yXiQSjEkN8ObdsD1Sudng+PmAiceyOzKvN9uWQpsbgE7d4evtY/uHFIKnPhLDMPAw
         HZxw==
X-Forwarded-Encrypted: i=1; AJvYcCURVT68+VkhYlbCYepXLvtxz1Uk1IfU4j+4VuKgzNSfHKBRD9QMeVedKSJf/XSIZnk3AJnE9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyV7qAIZE+o9c+2c1R9ImtiWaaPu3PB8gmTwOsSxhhNV2JHm9Tt
	eKKRxt1DGNHJjY+Vf6bps1l/0RaWuEK3WI6YzidGDBvDZNJjENbig+BxidLdGQ==
X-Google-Smtp-Source: AGHT+IG7OdlbAYBH+rSxfLKvmXWaZU+mzyHJgiWriDP/OYhsl145DYw3VYr0B7PXkF9ajxWoJVYutw==
X-Received: by 2002:a17:903:2284:b0:1fc:548f:6533 with SMTP id d9443c01a7336-201d8fd876dmr844895ad.3.1723626135784;
        Wed, 14 Aug 2024 02:02:15 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a9373sm25374055ad.144.2024.08.14.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:02:15 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:02:06 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <ZrxyjgNGps1PuIVZ@google.com>
References: <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck>
 <ZrDwolC6oXN44coq@google.com>
 <20240806124943.GF676757@ziepe.ca>
 <ZrJIM8-pS31grIVR@google.com>
 <315e95d4-064d-4322-a9d3-97e96c013b4d@linux.intel.com>
 <ZrTNGepJXbmfuKBK@google.com>
 <20240813175658.GO1985367@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813175658.GO1985367@ziepe.ca>

On Tue, Aug 13, 2024 at 02:56:58PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 08, 2024 at 01:50:17PM +0000, Pranjal Shrivastava wrote:
> > 
> > Kunkun -- Please try this diff and check if it fixes the problem?
> 
> This looks OK to me, you should send it as a proper patch..
> 
> >  	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> > -		report_partial_fault(iopf_param, fault);
> > +		ret = report_partial_fault(iopf_param, fault);
> >  		iopf_put_dev_fault_param(iopf_param);
> >  		/* A request that is not the last does not need to be ack'd */
> > +
> > +		if (ret)
> > +			goto err_bad_iopf;
> >  	}
> 
> rebase it on -rc3 and there will be a return line added here
> too.. Maybe you don't want the goto in that cast

Sure, I'll quickly rebase & send it out as a patch. Please let me know
if should add any tag by you?

> 
> Jason

Thanks,
Pranjal
