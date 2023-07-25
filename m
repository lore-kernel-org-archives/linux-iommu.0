Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7EA1F935
	for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 13:42:02 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-63cfd6e3835so13593246d6.3
        for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690292521; x=1690897321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5RfSsjXK4ByZNd7tHTQgk6HXFLb12v4XnTPRHADBsMs=;
        b=dU/0Xlzj1ZXwEvgiKBrYAiIHXkPLbRvJbmgtblGLQUHSq3/0n9Zobl0S9fVn2w6lx3
         HlG4zVW3A0BDLKIYbok//z+6IjCLYmwydmTOtS6zCHXtD1LheaImuevrdL7Y/U4nuQsF
         xcC0lxTWhN0nRt45ESdyVJ7p1Bhh+YY23LyiXodGZf8Uq1wnoEGXPTTxiRDbqUSVP5Jp
         b3MuBIuKgyOWyV9xLM0PKuBVvRxGBdS2svng3bfCa2Gl6iL17isNWjZeIX2VYzDoCWvT
         4TWGdgFxbu9HgTqlOf493afmjYfPIRaLuo+jsHhIIgHo47prFQrDSpDyfOImI2lGUfDU
         VJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292521; x=1690897321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RfSsjXK4ByZNd7tHTQgk6HXFLb12v4XnTPRHADBsMs=;
        b=Ff4gbddz41N9E3K/X+vm7o6b7I0HkoXeL/ViX+v4WP9TpP94ri26rgs42cWz7lgqyn
         GKE5S6/MFi8+MuCgrBxT7Pd5JOAfvBj4Z3w0MPpeeSlLiD8kySk+f02hF9esByy9dL8w
         I/iVaUqHLCHIbVdRvXB1MdPJBx7VdHj9u6k1UMtPOjpd0aVA2BL8v+nsVobzeEQx+u8H
         xo2S/NHe+fFWUCNY//QZXiJAEEhtf0H+NLafy0+r5Ti/TIYJ2NVAUgi/ruo/4cg+X01W
         R/TVhVam8MLsA3UQoqZYrrw1HeOjroyi/M4NPufqGFeiu8fxUbicAJacFraqxO5tsJRh
         UiVg==
X-Gm-Message-State: ABy/qLY5mOdTUtAaH4QqQH2CkLEqanncFL78cnvy8xfbZgxPkYEXv+75
	iDcDXd4uISEaDlpVUjMbuOxDZg==
X-Google-Smtp-Source: APBJJlG8uNdfNlbx0qebAFCgxbApqWAwrST3D3eG8x3M5HnkyY1GsnSGX+ds5MbujsDUIQwmSs76MQ==
X-Received: by 2002:a05:6214:4509:b0:630:1732:7090 with SMTP id oo9-20020a056214450900b0063017327090mr2880389qvb.55.1690292521199;
        Tue, 25 Jul 2023 06:42:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x17-20020a0cb211000000b00635ef3a34ebsm4394045qvd.48.2023.07.25.06.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:42:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qOIIa-000Rca-00;
	Tue, 25 Jul 2023 10:42:00 -0300
Date: Tue, 25 Jul 2023 10:41:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dawei Li <set_pte_at@outlook.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Change vmid alloc strategy from
 bitmap to ida
Message-ID: <ZL/RJwoJkB3muoTC@ziepe.ca>
References: <TYCP286MB2323E0C525FF9F94E3B07C7ACA35A@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323E0C525FF9F94E3B07C7ACA35A@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>

On Sun, Jul 16, 2023 at 12:16:21AM +0800, Dawei Li wrote:
> For current implementation of vmid allocation of arm smmu-v3, a per-smmu
> devide bitmap of 64K bits(8K bytes) is allocated on behalf of possible VMID
> range, which is two pages for some architectures. Besides that, its memory
> consumption is 'static', despite of how many VMIDs are allocated actually.

Is there an actual problem here? Allocating a single 8k page at early
boot doesn't seem like a burden? Are there alot of smmu instances?

> So an IDA based implementation is introduced to address this issue, which
> is capable of self-expanding on the actual need of VMID allocation.

However, I agree IDA is just generally better and generally drivers
shouldn't be open coding it

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
