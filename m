Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51400745E5
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R3HvzG9b"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67a9cba087aso40966746d6.3
        for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 06:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702393154; x=1702997954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wLe0ZiG4Tl3iP/WQ9Clp4BD9+PC5GK98SJRvo4oo3Vs=;
        b=R3HvzG9b71IICPcxpjplo2AHqW1+bIh/nMv7wCJLuWI7N97LulzmWeVwgvzjz6Ygrs
         stDEZ3NuT1i0K+4ZJY/vzlOZ7wMhR8VZ8cwwrKYTZbjV5VTcQh/mm478sZ+068GsuDA9
         zrsWhkbsgSEm5rfFar6K25O/+nxk1L1vvEfYGZgif5jxg9TsgrnQsz0vUomL8LLhZ4bD
         Gkv0AlVsztMDJhK3OXEKx9WUEbQCxzsk4znHQ4mTCHxkuM6hrRg7HUP0mRmBPtaBYIYw
         yfW4+HjpXdRfZBYZ/I6sjII1IMp8zB+C+7UACfNfRIApMVSjt7gQk74eQ+VWxDf4NOzz
         UD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393154; x=1702997954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLe0ZiG4Tl3iP/WQ9Clp4BD9+PC5GK98SJRvo4oo3Vs=;
        b=JyBSGccOPkiKNd5/72IKf4L9qCJikjXqta4TssZoqmHSz2nWUSren6PrIUy60dEtzv
         kdEgZsO36PyzbUQrm6KiqolrQFzljbZoF8IKW+9oVpHQlQm9s9JtARsMSeAJJzwj4/x+
         JO4nfbXE8/O4e7Sfs+UjfrLZbC3VM6j1TZG6/tREupy0VSxPLqEIGLxTlqHuJcCQDUR8
         lWSSiuJjz7PtiqYRrUwChStB/jeoJkwKa1Wh/cqzxUiJ+0F+e5yl0yqPKvJx9MzqdTat
         vnUDnP9s++oIzM2xXkq/v1UOQSis/iIMFAtL0c6R01vl6SvPL8vP8nmOROKNr7f8YmPv
         VvZw==
X-Gm-Message-State: AOJu0YwjV6ScZg8cHsQhiftQ3LfN7I7CP95GgelL/Uz6hjhPktxzlSHR
	18UeJS6wbYE7Dm+n4vM9O8/eZg==
X-Google-Smtp-Source: AGHT+IG1ayCRUoeGobuJvgpq1aHvhY54UbAtzlfwts58DKI4xm+qxm47zT26XmYZyl+RjT936peWMQ==
X-Received: by 2002:a05:6214:5616:b0:67a:bf66:622e with SMTP id mg22-20020a056214561600b0067abf66622emr7445084qvb.40.1702393154178;
        Tue, 12 Dec 2023 06:59:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id eb14-20020ad44e4e000000b0066cfbe4e0f4sm4218492qvb.26.2023.12.12.06.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:59:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rD4E4-00Cjrv-RO;
	Tue, 12 Dec 2023 10:59:12 -0400
Date: Tue, 12 Dec 2023 10:59:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 10/13] iommu/amd: Refactor helper function for
 attaching / detaching device
Message-ID: <20231212145912.GB3013885@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-11-vasant.hegde@amd.com>
 <20231106172931.GM4634@ziepe.ca>
 <f23aaa41-b22e-b274-5774-6317ba643e8a@amd.com>
 <20231107132827.GY4634@ziepe.ca>
 <d99a1d56-6b29-53e8-1d2b-564a56548009@amd.com>
 <20231130175523.GH1394392@ziepe.ca>
 <246e909b-e020-f1f5-deb0-f48d68cad537@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <246e909b-e020-f1f5-deb0-f48d68cad537@amd.com>

On Tue, Dec 12, 2023 at 11:11:24AM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 11/30/2023 11:25 PM, Jason Gunthorpe wrote:
> > On Thu, Nov 23, 2023 at 11:09:20PM +0530, Vasant Hegde wrote:
> >>
> >>
> >> On 11/7/2023 6:58 PM, Jason Gunthorpe wrote:
> >>> On Tue, Nov 07, 2023 at 11:25:49AM +0530, Vasant Hegde wrote:
> >>>
> >>>>>  RID domain=BLOCKED & PASID - ?? [V=1, TV=0, GV=1, GIOV=1 with GCR3 entry 0 being non-valid] 
> >>>>
> >>>> I haven't thought this scenario. Why do we even need this case?
> >>>
> >>> It is triggerable by iommufd, it has to be supported.
> >>
> >> You mean PASID support with BLOCKED domain?
> > 
> > Yes, that is API possible.
> 
> This will be tricky as we set DTE flags per device, not per PASID. This needs
> more investigation. We will implement BLOCKING domain first then we can look
> into PASID with BLOCKED domain support.

You can look at how the smmu stuff ended up for some inspiration, it
is quite similar.

It is what I keep saying about properly structuring things so the DTE
content is decided high up and then flowed down to programming
logic. Then you don't get stuck with "we set DTE flags based on the
device" which is not actually workable.

Jason
