Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB332D2E4
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 12:26:57 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c336f5b1ffso15535015ad.2
        for <iommu@lists.linux.dev>; Tue, 05 Sep 2023 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693916817; x=1694521617; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6UxPivDqeM2cETY+znupBAyMqEqadb2PPTHoDDpXTA=;
        b=R+zwodWMl9i3MmWa+czzDau/uiMBVD4JnG3hA8ztyzIDRUxQvOIqzWQSQAAp+9wRI4
         s0SGwu6m6ETVVWtQnlt/tVA0ckBA8jZmMOGdtIcdaY/v/Dvn8XrZjoTXJ59+UIk43ojR
         1kSq3NTaOEHoRmOeYDDgTjCGqyPyiKVEx56MndIpRGEAIkpjM73IrUmqmIh+m4YNCWTq
         u+xlAdtD6WP4UQ2sERfJ4q3ZxlzrKTmxBkUh6PiLUhU9H/Ozf896oRlGSIoARYK3MOay
         wCwdScJ8MInNh7KmbojsaoUeA70K/WMty/6y4AqSXwqHa4L+XE+VmmUHxDOx4SCKfCMj
         G1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693916817; x=1694521617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6UxPivDqeM2cETY+znupBAyMqEqadb2PPTHoDDpXTA=;
        b=OmCPY8hyYl/9qIOfzY5HjqsNyYH/rLggaJ8XrMK6AsO2upP6X5rRxMXH6+yKQr3wmK
         MiT0fAnPKWmNZPpHgJdDGiZXu6zG2IyZ7vqp/qEmJQYo3xVhH8S9C2ihNiMzMlsXCBgB
         0vnRQVfKbSdMt6foLW4awcP252Tgp3qdZYRZntKOMu8fLpICDreP4Mho5WZhQfsAMmu7
         sQiS3uL0ruyF1IfSpt2Gwhnio69TU9u6cUE0pFrYu8uQHT6J3xe84yKULOB3FqN5jj9b
         D3XAuzASFSkcxC9RkhS+4afH7LkZLjm4y9z8oNGj59afwr1kuYlRXLiDH8lbTDYXHk+T
         9wTA==
X-Gm-Message-State: AOJu0Yyz0DDrfNb+k44nBYBVxb7ZQXeH8A9ChnI20Uu5wXVlMmNjmSUs
	igN/c5vMVn7rbOVelJpRu6AX1g==
X-Google-Smtp-Source: AGHT+IEIjPGMHP1m3AULppPvYt4Pkuezn8w/stWrM2UVKtoJo8sl5fg/TdnUyT/D3Qa0J48XEprM2A==
X-Received: by 2002:a17:902:ce90:b0:1bc:9bb3:1d83 with SMTP id f16-20020a170902ce9000b001bc9bb31d83mr14835760plg.33.1693916816998;
        Tue, 05 Sep 2023 05:26:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902fe1800b001b0358848b0sm9277920plj.161.2023.09.05.05.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 05:26:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qdV8w-000q1k-D2;
	Tue, 05 Sep 2023 09:26:54 -0300
Date: Tue, 5 Sep 2023 09:26:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 03/10] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <ZPcejmNW153rcRFA@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-4-vasant.hegde@amd.com>
 <ZOYXoMPBQZ5KK9IJ@ziepe.ca>
 <fc17e0fb-e712-824f-93f9-f9edf5707395@amd.com>
 <ZO93WJnhxl+sC9zA@ziepe.ca>
 <d64d8066-7cee-46c6-2403-76eaa969fe53@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d64d8066-7cee-46c6-2403-76eaa969fe53@amd.com>

On Tue, Sep 05, 2023 at 11:48:31AM +0530, Vasant Hegde wrote:

> Reading through the discussion so far again and the other series, my
> understanding is :
>   - set_dev_pasid() will check the compatibility and bind device/pasid only if
> its compatibility. In AMD case we will check against protection domain. Ex:
>  If we have two devices (devA and devB) in two different protection domain then:
>    set_dev_pasid(sva_domain, devA, pasidX) - SUCCESS
>    set_dev_pasid(sva_domain, devB, pasidX) - Compatibility check fail
>    Core will allocate new SVA domain (sva_domain_new)
>    set_dev_pasid(sva_domain_new, devB, pasidX) - SUCCESS

I don't expect a compatability check to ever fail on an AMD driver -
what condition do you imagine where re-allocating a SVA domain will
make it work with a device?

>   - We will track mmu notifier and other data required for invalidation in SVA
> protection domain.

Yes
 
>   - During invalidation, we will retrieve SVA protection domain using mmu
> notifier. Use device protection domain which was tracked in this SVA domain for
> invalidation.

The iommu_domain/protection_domain must NOT be 1:1 with a device. The
driver must maintain a list of devices attached to the domain, and the
per-device-attachment parameters like PASID/cache tags/etc.

This is very important.

> > It is not the same, you have this weird sva_pasid thing in here. PASID
> > is NOT part of the SVA layer.
> > 
> > The API expects UNMANAGED domains will support PASID attach as well,
> > that is a significant use case.
> 
> Can you elaborate the use cases you are referring here?
> 
> We do have use cases for PASID and PASID+PRI. But I am not aware of any use case
> for UNMANAGED domain.

The iommu API is evolving so there are only a few domain types:
BLOCKED, IDENTITY, PAGING, SVA, OPAQUE

PAGING is what we today call UNMANAGED/DMA/DMA_FQ

PAGING domains need to support PASID+PRI, in today's language that
means UNMANAGED domains.

We have many use cases for PRI support with generic PAGING domains.

SVA is a special case of a PAGING domain where there is no map/unmap/invalidate
API and the IO page table comes from a mm_struct.

Start by making UNMANAGED (aka PAGING) domains work with PASID + PRI
and then SVA is a very small incremental step.

Jason
