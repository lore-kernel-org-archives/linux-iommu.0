Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3928168AA
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 12:41:32 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-770ef334b4fso116325185a.1
        for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695386491; x=1695991291; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9+4wg+HvQjn8Tza5j/+95ICGHkpfpV9B3BnmaDCax4=;
        b=IdFbvYqRSgeypGR4se8UPwQnB0JdmBvZxQGY5mozFn6aes+9G7owUkY4yohYsxB47Y
         IfTkL89b3+MV8RqEflTS/77p6lfyp3hF9NwhXaJ98WRsY1VgreQdz2Gar8hr5CwnmjYc
         Kf2dATfrBL87YbFJpSQYTVgnAk6gS+jj4lU+G3ib3usgv4kD+8dvp/6y0X4iaaPTpHGX
         MZKn4rYziWnIoUZ1zXdIL0n8GOCCDhUMWTF/2kMcz0xuLKn2uHYnI8pHbC6MVshDoI1G
         lsfvp19OjaAY2TJtq3xXW9SpOjWEr79ty8DMNNqpcYMATRWIBsRc0qRjwFy0dgcdATNC
         2Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695386491; x=1695991291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9+4wg+HvQjn8Tza5j/+95ICGHkpfpV9B3BnmaDCax4=;
        b=mEjF1zkeAixHa0k+j20BYi6NsUV0uKp9IU4iRG+jvau4Qw56MaUx/x417kSM05JNjn
         810NgnFjpWHbwlYd54zv19che2QgrgNjGaHGTo97BdVOqMML5BsbsIbV+PfcrhIwrG1T
         0EIlkZh4JuYMP2s3BQJIvRYuOtbHfEqroVoZLt3hUOIx/IhwZexblx8ujf8BcsCsXwU9
         jkPGySP14DTm8PrZVZ/usUwOJRo2Y5UiPZ6tEEoD6SuiXy/XHdc4QzL/1lqYZ2tCVPz2
         7CyePK05UG4IHf2d9nfuTgH6o9SkpObXHbgfdnjlXKoJM/JJ7BZsrxNhT9L6l8kdygY0
         oI7w==
X-Gm-Message-State: AOJu0YzRSno5M8pKU/vwZPNje1Xh47cnfdEyBiwt5syFq18EEtvRQSr/
	6Y9kf7L9EYbxbl6qydOjw4CIFA==
X-Google-Smtp-Source: AGHT+IHZUGi7eIWQUvwurrjhwZAXvsjOtNC1C38Z7pyQadDkGDO1CCUf1Jp9zTCAUl/T8vTtva0wOQ==
X-Received: by 2002:a05:620a:371e:b0:767:e994:ff03 with SMTP id de30-20020a05620a371e00b00767e994ff03mr2794453qkb.15.1695386491706;
        Fri, 22 Sep 2023 05:41:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id p13-20020a05620a056d00b007740c0e52edsm1209968qkp.89.2023.09.22.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:41:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qjfTO-000Y4I-9h;
	Fri, 22 Sep 2023 09:41:30 -0300
Date: Fri, 22 Sep 2023 09:41:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922124130.GD13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922075719.GB1361815@myrica>

On Fri, Sep 22, 2023 at 08:57:19AM +0100, Jean-Philippe Brucker wrote:
> > > They're not strictly equivalent: this check works around a temporary issue
> > > with the IOMMU core, which calls map/unmap before the domain is
> > > finalized.
> > 
> > Where? The above points to iommu_create_device_direct_mappings() but
> > it doesn't because the pgsize_bitmap == 0:
> 
> __iommu_domain_alloc() sets pgsize_bitmap in this case:
> 
>         /*
>          * If not already set, assume all sizes by default; the driver
>          * may override this later
>          */
>         if (!domain->pgsize_bitmap)
>                 domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;

Dirver's shouldn't do that.

The core code was fixed to try again with mapping reserved regions to
support these kinds of drivers.

Jason
