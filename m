Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950E329417
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lZv8I1C4"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-66d12b3b479so30144766d6.1
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 09:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699293091; x=1699897891; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcMl4nThk23Ft1wxN3r5AUoKT+bf+rbyDkO97w6GxaE=;
        b=lZv8I1C4u/5lSA5iItMHyU1WvJTVonbHXN5MTO1+mhhPxHOzdwXHDsBTL/WDh2Ynhf
         OSTEIud/Pp7zKm3sTr2pcLhmjRNzdvqjkrkD0Se+zo4zjA02cxX4dQeeajYj9nRBe1WX
         l/8RMkbj0LKsVe4K3uCO9XDkTOGwxjqSKhGsFBtBxCE7Hd9V8EioPvs5N1irX63kXDdQ
         2xhDYhAelqwDjp5Ni1iHGelOlf9oTn0L6kIFPos7Wwg9NuF6am5voqpxgWWE+RpKhvqK
         aeDam6UU1tSMXD+M98HeXOz/vMTWr41dfuR4Kf0+RwcF4rBMour+UrgbZ6SXGqkdUBjc
         TkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293091; x=1699897891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcMl4nThk23Ft1wxN3r5AUoKT+bf+rbyDkO97w6GxaE=;
        b=oC+7uWB2gGmwaEYEYHj/AOfc6WPPJPLo7ct/5vInrFufxMv4VflrN4MwC8r5Hvh4UH
         4KgP59lv1xRkm6rRpj9C8e+TccWmEHqP3NH6NTRvJMxDqwgw4aVGxRZKU49zKfU0qNn1
         vGyIrJ5jEal/ZLX9h6+UbyeK5gE7Vc2RHNWsYSisGkEnVJvhN0Mnhz4r6x8xHsD7jaEP
         NDK7KOBAy30PjoqWRR/tn1dCqdrnSPKs/FXuUoGyCoKLZf7XUYi2us6jrLDLCFtVrl+T
         QYH2XTZaZdLxbGumEOKmrCDhrYL1b/aof3L7CRl3U5EsnR7BLDIOMBnOscHqbwe0IWty
         4qAQ==
X-Gm-Message-State: AOJu0Ywmw+oerO4sExbylHtAiYzva6kcKtvD2RAM1eeZMXM9riNjMPjZ
	haIEHzfzqGfcfqbfAfhs8DhAd3D2auhvUzs9FVg=
X-Google-Smtp-Source: AGHT+IEA30ecNLjLR4wBME3iDRYQc2Ld3q3/+WdPkf5BxkE6dnvJhOP5NhpzvJXqLucrcjVCDPUHDg==
X-Received: by 2002:ad4:594b:0:b0:66d:3474:a93b with SMTP id eo11-20020ad4594b000000b0066d3474a93bmr32044160qvb.59.1699293091423;
        Mon, 06 Nov 2023 09:51:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id x3-20020ae9e643000000b00767d8e12ce3sm3473642qkl.49.2023.11.06.09.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:51:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r03l4-001PKU-4H;
	Mon, 06 Nov 2023 13:51:30 -0400
Date: Mon, 6 Nov 2023 13:51:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 02/12] iommu/amd: Do not override PASID entry in GCR3
 table
Message-ID: <20231106175130.GR4634@ziepe.ca>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016104351.5749-3-vasant.hegde@amd.com>

On Mon, Oct 16, 2023 at 10:43:41AM +0000, Vasant Hegde wrote:
> Return error if PASID is already exists.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Why is this an error?

ops->set_dev_pasid() should replace any current translation at any
PASID with the requested new translation. It is not an error to call
it while the PASID already has a translation.

Jason
