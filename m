Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5626281
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030039; cv=none; b=dH6D74ROobzmUdgf4LrssmspficcBlJcym9QT/4inQL/xTcEm+y3wXCyBFuu5SGI0+v6G9p52VKp3uGGVh2xFep+ZRZZ+s5V5bJTOin/4z2bMcwCq+s3lMxqAI9eK61atLQUDIwzLTUoN6xkKQcmMT3I0SG89iwyAn8fuyfq7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030039; c=relaxed/simple;
	bh=CZxWnHerUwknQInwDf3MAXdREsTwGqmmI6An0t2uETg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1kTtH9EB2gwrANKoDurv+1NXWu4v3zG+gxlP379bHFFe2wgBFLRShCfoDD/wo7T0AEjGS+wKgaSRPiYi9G035CHD0n1vv+ku8pPczx1Z7r8ckdOUc4dDhWRWwxfzOZPMt4i1cHAQKi5Gva+3XjyvWohGBnjvmZG0eHSVfgF9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G2fBmbz7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G2fBmbz7"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4567f2cbdb9so10838371cf.2
        for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725030035; x=1725634835; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZxWnHerUwknQInwDf3MAXdREsTwGqmmI6An0t2uETg=;
        b=G2fBmbz7uWbDE/VuFS1kQH9BrXiWxOhzoM/81+nCJdZA1/onrGg3h9d3ktoAhHMgR4
         zDzZTuD+P6/JlvyZkzMVVyEmJuglLaHr2Rj9Shf2NOhUX7eDjZdlAqqDoTBwwX1Qlc89
         1ujN+1eF9t7b2oqcCwYB+9N1bv7H06o10eleOuo3UVPfXIg0cAZU+flany69mIio2xOC
         n2M4lb7DkQEpAJiKOlko6k3pajWKKXB2Top1tiD1MA8Opl0wtRNGh3sl5pBBOXF5FRCg
         4bVoAKKLAu5IJPQOEy3HSZW2WdbTMcQJXYhYBLNZc81pzfkfeywTrhKZ+Ivf1NWPylWb
         uZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725030035; x=1725634835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZxWnHerUwknQInwDf3MAXdREsTwGqmmI6An0t2uETg=;
        b=VV+SQSfjGZeqgVZUIQ6wvFeo/BdfXfcvsxU3Vfc4IpOaSdve9ds+fbro1sUwhvxyvL
         Ynj2IG/M8r/w6WtEU0qiIht+zOcpDYZvnCIBxfZSUKEDorfGR7FRK3a46hdB4wBP8ZoK
         tPhnsw5EWv5cnZKealRFlqqAJ6y/1828A9hnBPZHCjR4Z4raRkcJ+TfmVQ1zTYLpntp2
         FkuHKRi/fC7Gbm/KxSO9xEcBwHJrfEmpXcMmDbTXQcEiceXkhWRqFypwOFi1DCZgAZmQ
         WTfA9lritw1D4YoCcWan4bW9tmNpIEr6kW79ZAWFQpsSK+7n/sUd/jGkRDiJ2H9kr0C/
         lD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmWDic5Phu5cjjHgnMdvS0ANQF80Nkld4IOezmyiruh9puDwW83zqTxBmDjU6hgjsSBs27pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBVhlYxW8q/aK3hhWgGrXVsvuPWQvKC5oqz52a6/pAYHjPYwax
	aC6WV8YI1W1hnQ58FEhzoCXsR7YPDfUrjKhQVzCRrQUovHGmP0XQKvmpDslQHtw=
X-Google-Smtp-Source: AGHT+IElIUqrt5sS7F4ypb9DraPgPEV2K4gWAVFF0YKZjiQa6YPStGdN6kelSB4X0H8dc5LaKheAyw==
X-Received: by 2002:a05:6214:4a8c:b0:6b5:ea0e:98f with SMTP id 6a1803df08f44-6c33e4f00eamr82628556d6.0.1725030034716;
        Fri, 30 Aug 2024 08:00:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bfa7b4sm15144086d6.28.2024.08.30.08.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:00:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sk372-00Ebsx-DP;
	Fri, 30 Aug 2024 12:00:32 -0300
Date: Fri, 30 Aug 2024 12:00:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240830150032.GZ3468552@ziepe.ca>
References: <20240821163147.GZ3468552@ziepe.ca>
 <67436cba-3d05-4528-9519-231b8396ed51@intel.com>
 <20240822124433.GD3468552@ziepe.ca>
 <0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
 <8215e4d4-2077-4fca-a002-27ddbfc0ddf2@amd.com>
 <20240828145224.2e949806@DESKTOP-0403QTC.>
 <6741bdcc-d9ca-4090-805b-3a7f4a4d650a@amd.com>
 <20240829121002.GV3468552@ziepe.ca>
 <b57b8846-9d13-4ede-98ba-2d09268c15ce@amd.com>
 <66d0b2a1.630a0220.1dd301.daceSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d0b2a1.630a0220.1dd301.daceSMTPIN_ADDED_BROKEN@mx.google.com>

On Thu, Aug 29, 2024 at 10:40:47AM -0700, Jacob Pan wrote:

> I don't know where the guest can get the host page table root pointer,
> perhaps just ignored?

The vDTE created by the guest will have host translation disabled, and
no host page table pointer. The vDTE will only point to a GCR3
table. Same as ARM.

> On Intel, guest can just do S1 only, S2 pointer can be ignored
> architectually based on PGTT (PASID Granular Translation Type).

Yes, same idea.

AMD is just lacking a bit to tell the guest that the HW doesn't
support host translation :( :( :(

Jason
