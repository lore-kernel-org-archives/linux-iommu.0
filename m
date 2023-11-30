Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A179584D2
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZE08++0W"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-589d4033e84so667408eaf.1
        for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 09:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701366925; x=1701971725; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4T+UMQ/zDu4KZLZhkTF3XTxdLoEyT/jwf6yurHN4fvY=;
        b=ZE08++0WLS9kHLgmOFXWN/kd5EU12Ycqa3pa+aFF1qQRSjD+HBrW0VINagig5EI8x5
         znverwB2/inh37mKtq65Skiv5OHYKl3eYMKfr1VhQLxro9lpjArNvbr78FVnEWU0BWd+
         cR/YHpu0JC0QAzLYegJl6P8sW+6g76QqNWiggsq3tKFPAvZ4kaOM72AQlGqw2k5ju1J4
         EvNeq7TLmpc7yF1jEUZD59XaoPXX27WHgo/CCH41zeb+QdZwmMw31Y8cnnmd94g9BLVh
         BQ23COAxgol5sm0cOzCqoJp/mpd/iI+ankxiHmUMFnmC1Wgh5qwtda+m8cuB2r9M1G7I
         rwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366925; x=1701971725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T+UMQ/zDu4KZLZhkTF3XTxdLoEyT/jwf6yurHN4fvY=;
        b=W89Mi3u4NcuUU4Wj4yFrAt/cMfiLiktpuN3922xV/IPBOG1wxZdZzfSuNNywJg/Usk
         AWN7aQ8fTjSWG7ha8QYkxpfIp+PyLXUqjjb1h8hUX9un/XgFRb25R0/6dJhqB1PQNsGB
         oyQ78ykti/uVhfPTkCVUGiOin985iHG6cbh+k+rhBDU9hpj1sIK4S1xnpEnZEqgTprJM
         3z///4VqKzvRzNDnmSal7PXmEZdRCXyAaW2VP6et9IBgKpjpxEqcCh4rO1YhUyPqJz8t
         IKPjnu5a8rf6yD8Y63deI+iK6N/OMEVQ88YQBC+cCuIN/EJSvihq75B5i7dmyZDHOlR1
         RPSg==
X-Gm-Message-State: AOJu0YwbBLbe4+S1zyd8p52/9XijjsYtp38pwy0zN0eskmMi5XehJB6d
	si0FtiH4Zw56hh1JIC+8kGVZxw==
X-Google-Smtp-Source: AGHT+IE/H/WY02bixJ48iuRbyawvipfwxMMRmtKjib3zQ+I29pjFGR2nT9fU/jb7bOg7EWcBo+uJHQ==
X-Received: by 2002:a05:6820:1623:b0:58a:128:8ff0 with SMTP id bb35-20020a056820162300b0058a01288ff0mr370258oob.5.1701366925305;
        Thu, 30 Nov 2023 09:55:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id z9-20020a4ade49000000b0058d8b0c4bbdsm247267oot.32.2023.11.30.09.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:55:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8lFz-0069pT-VM;
	Thu, 30 Nov 2023 13:55:23 -0400
Date: Thu, 30 Nov 2023 13:55:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 10/13] iommu/amd: Refactor helper function for
 attaching / detaching device
Message-ID: <20231130175523.GH1394392@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-11-vasant.hegde@amd.com>
 <20231106172931.GM4634@ziepe.ca>
 <f23aaa41-b22e-b274-5774-6317ba643e8a@amd.com>
 <20231107132827.GY4634@ziepe.ca>
 <d99a1d56-6b29-53e8-1d2b-564a56548009@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d99a1d56-6b29-53e8-1d2b-564a56548009@amd.com>

On Thu, Nov 23, 2023 at 11:09:20PM +0530, Vasant Hegde wrote:
> 
> 
> On 11/7/2023 6:58 PM, Jason Gunthorpe wrote:
> > On Tue, Nov 07, 2023 at 11:25:49AM +0530, Vasant Hegde wrote:
> > 
> >>>  RID domain=BLOCKED & PASID - ?? [V=1, TV=0, GV=1, GIOV=1 with GCR3 entry 0 being non-valid] 
> >>
> >> I haven't thought this scenario. Why do we even need this case?
> > 
> > It is triggerable by iommufd, it has to be supported.
> 
> You mean PASID support with BLOCKED domain?

Yes, that is API possible.

> I have seen those part of code and it makes sense to have BLOCKED domain
> implemented. Its in our TODO list. I intended to look into domain allocation
> path more closely once we finish SVA series.

Great!
 
> > The page table type determines if the GCR3 table is loaded, the domain
> > ID is needed if the GCR3 table is loaded.
> 
> For now I'd prefer to keep it in do_attach/detach path. I want to rework
> per-device-domain-ID after SVA series (i.e. allocate per-device-domain-ID only
> when its needed).

Yeah, that sounds OK

Jason
