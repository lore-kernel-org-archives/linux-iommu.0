Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212319B5A7
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242739; cv=none; b=H7T1rFdca2W+2fiEy/HFrbCZY9T99lY3AAlJNUqhUsWFYh/7aHGFveYgGjSLVGfRFeXlnEGvn2p6/3Bi89tovMSzcBd9KQ2cqfhhHnw3uTPrcSvBK8AfQivWHr/1KiEcn0LTjPVtpV5OdhiwTnCD/nX7iNxjc2z+ELy4ByxiBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242739; c=relaxed/simple;
	bh=uzdHiH3wJkVzFR4Qaz4tfIhboPJvQbpjf2wwWh/W2hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS3mzEpcLYEmyZhHCV+rsbLGTrrY5pWGUDdK1Rnnv7IS8jeyYq70KIkUfTdw8jj8rjYVs7xsQ0CcmD93irmaaqYC1ea+Y5QXFbMkaZvctVw/0/E7789pFsdirTo8BBXQnLxXoMBA2mMzydLyWJhlW9uc40oMUZ32snta5I1zyls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Wd9imp6a; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Wd9imp6a"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7965d034cedso283477585a.3
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719242736; x=1719847536; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzdHiH3wJkVzFR4Qaz4tfIhboPJvQbpjf2wwWh/W2hU=;
        b=Wd9imp6a/Fzn+HxuEhlrVBkC+QdJ5bDEysXqw5GbF0jVyJPY2xjsA8e2zF3wdoF/sW
         QJW9eCBdlZvUH1ll2X8fpn7Dwz3T6uwDnpwPWjvGX8MhEfBLv7GG39GVdY0B2wjs6H00
         rdBSZE46ZGi73DA7evGWyI/eWMmq9c7/ExJYxegWPQz1eM6B9QoZ36F3CVaNCCxow8yt
         0HBaLUSHw6s/p8sVKblR/YXbDspFOm70I83PLjvDK4yjOmfhu6vY+/FxxV9pGNTig1He
         NQPPq5z6a4PN5/NJ/LyQH9mkoJuZsOGsKl26paDfq0862q2qGj7kQtw+6s50LXwyyFT0
         YRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242736; x=1719847536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzdHiH3wJkVzFR4Qaz4tfIhboPJvQbpjf2wwWh/W2hU=;
        b=DSZo/xscv+v+u6ucb2Ul7nfzzqRdgxlkywib/LPjvxGlmFMS15X2shamxYp1ggABZX
         kaiHlrsMlRZwJh7AnNIfj6xcwiilb2xz1URua7+Hu04ZsLaN9Zn7Wfdd9WM1Vc2eeoOz
         RxXA4FvCUG92LO2MiVdjC+ebBH/M0RFA1ikr//4Unc8wrOY5Aj5BhJzko21Ghy4WyRQ8
         jX/RbRUziVBpX3yNl/gbe/NRPZ6GMh/FP6t5NLWZYh4mcoE85jJIY8QUeurOWgNr3rTO
         8JNmXCqgxNL5Yftk/4Ow/jUiAUWwvY8DJO6jIYVPT4Slb3o1Xk4OsviwIbYf5G2nhW88
         YhUA==
X-Forwarded-Encrypted: i=1; AJvYcCWPq7+XsL05R3FkzJjRRDjfpE+F2pUqwuUH56sgA5U3SGfcrY4iHNE/1jl/uk9mTkPJmv7TPMyfVVhnsvxlP5wZ0w9UCf8=
X-Gm-Message-State: AOJu0YxWqSMWQEWLUeyjwCUefPYtvgaNN/jwTZx2T8vB6gKvWwlbCOnn
	PK+Ji7GEhC4dKrPYb5Sj4qvnLNfW7IcaB3rtv2wVZ+kb+BH2mO04lnBaVAyFboU=
X-Google-Smtp-Source: AGHT+IFsf+bohILZwZmdM4lOb2KhKfxQ8HdybpNZdym5AOTeXYBBOlOEn9LGVBeqfzHlr0GrIyxCCw==
X-Received: by 2002:a05:620a:408d:b0:794:9968:6b16 with SMTP id af79cd13be357-79be6f23a36mr672560185a.59.1719242736250;
        Mon, 24 Jun 2024 08:25:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8c4736sm322830685a.61.2024.06.24.08.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:25:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sLlZW-0069AY-Ub;
	Mon, 24 Jun 2024 12:25:34 -0300
Date: Mon, 24 Jun 2024 12:25:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH 1/2] iommu: Take group lock before attaching device in
 iommu_deferred_attach()
Message-ID: <20240624152534.GR791043@ziepe.ca>
References: <20240528163940.48789-1-vasant.hegde@amd.com>
 <aaf7b619-1826-4db2-aaa6-235a25f46299@arm.com>
 <029a1733-4e7e-4deb-92d2-874040679bd2@amd.com>
 <20240610174407.GL791043@ziepe.ca>
 <1bd088e9-8cb3-476a-b397-4257d3ec1b46@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd088e9-8cb3-476a-b397-4257d3ec1b46@amd.com>

On Mon, Jun 24, 2024 at 07:50:46PM +0530, Vasant Hegde wrote:

> It may be good thing to add mutex here.. But if any of the caller of these
> deferred functions hold spin lock again we will hit the similar issue that I hit
> with AMD driver.

My point was that Intel doesn't support non-sleeping attach, it uses
GFP_KERNEL, that support seems to be a uniquely AMD thing of the major
drivers.

So, I don't see an issue with formalizing the lowest common
denominator in the core code - the context must be sleepable.

Presumably things work because the kdump kernels only run drivers that
reliably trigger first dma from sleepable contexts. Unless there is
something AMD only that relies on this special behavior??

Jason
