Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A5DF5D
	for <iommu@lists.linux.dev>; Wed,  6 Sep 2023 13:36:23 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-26f38171174so2641363a91.3
        for <iommu@lists.linux.dev>; Wed, 06 Sep 2023 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694007382; x=1694612182; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwzQ6/Z2kMD31IVSoE96irLcXCzsjxsenR7GQgWXnQk=;
        b=DzTiEUnGQPxAbo8Eav7xUMrx0ngl0JwPJjV7T+TdDc0sZbsuNeyXqAqaagZ8/SvXtM
         bvk8JBJTLmpRoV0bGBiK4UQ0d9K/I+bxZ3AnLfiMIwemagnmSoBPnuSzhZF2OB/grDub
         AqnlU3WEv5s7+LuZ6CcN2A4EbrGoEK4dRCOg5l2c+qi8ZBLK/YHYpTppJPt4A4wb1044
         2Qx728o0kekPRMKH2upX7n3alOLJMJoro3rWmV1fVBs+xKAXpGOP6nQScDJO5Pcilu1o
         xJsUXap7Or01YmKeQKDXJ6WMOUCz4bTN+n3FwQzizUhN9xbXetuhz9V+kLX4K99d8rLe
         bFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007382; x=1694612182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwzQ6/Z2kMD31IVSoE96irLcXCzsjxsenR7GQgWXnQk=;
        b=jxQPCvPtUpAWQ/z2VuJxdm4ThR9ZfdYKnUIw73Z6jRY2rqx3/Wmsg0u1Xf05FFF26F
         SnaKP7oxT+yhcNPKcSAqVEHlD0H1kF432Ncw/43Ob+sWw5oKpxIqYv/9EpIsqT0PIjZu
         Q62WxD/pJ4dDAZv3cjIxS9Qpqy4HvxjgbhYwriU+A2Dg33Mpe1SllZa4ZUH3hehDKeTK
         8+2LIpAphfmLrizZQazr8NZ0rm621hE0ieL0+Z0DwHl2uG02rq0HdMoWYRsjazYVDjGW
         arTDldYxQBTZ5S58guM0mYxYTdgjOGOLGaRzsS6NWynGpSAYzbZqRo3oUSBxuBlQ7HXt
         yNnA==
X-Gm-Message-State: AOJu0YyKrLNxukQ9rCkVlRvD7GU/xA+CMYSRPFpBMe1lyiy0qc0G7EdH
	KWSZZUEtKyB8v9cU1CmY6MbBbQ==
X-Google-Smtp-Source: AGHT+IGQ4vqLE4lDnmS6Kx79SJrsu1YaEhgU7Y1QgV+88opC+oy++oplaXWLVpq8ZWayNQq4SvaXuA==
X-Received: by 2002:a17:90b:2317:b0:273:441a:dae6 with SMTP id mt23-20020a17090b231700b00273441adae6mr14950231pjb.19.1694007382653;
        Wed, 06 Sep 2023 06:36:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090ad78200b002680dfd368dsm10901898pju.51.2023.09.06.06.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:36:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qdshf-000yIH-QK;
	Wed, 06 Sep 2023 10:36:19 -0300
Date: Wed, 6 Sep 2023 10:36:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Kim Phillips <kim.phillips@amd.com>, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	Michael Roth <michael.roth@amd.com>,
	"Kalra, Ashish" <Ashish.Kalra@amd.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH] iommu/amd: remove amd_iommu_snp_enable
Message-ID: <ZPiAUx9Qysw0AKNq@ziepe.ca>
References: <20230831123107.280998-1-hch@lst.de>
 <d33f6abe-5de1-fdba-6a69-51bcbf568c81@amd.com>
 <20230901055020.GA31908@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901055020.GA31908@lst.de>

On Fri, Sep 01, 2023 at 07:50:20AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 31, 2023 at 01:03:53PM -0500, Kim Phillips wrote:
> > +Mike Roth, Ashish
> >
> > On 8/31/23 7:31 AM, Christoph Hellwig wrote:
> >> amd_iommu_snp_enable is unused and has been since it was added in commit
> >> fb2accadaa94 ("iommu/amd: Introduce function to check and enable SNP").
> >>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >> ---
> >
> > It is used by the forthcoming host SNP support:
> >
> > https://lore.kernel.org/lkml/20230612042559.375660-8-michael.roth@amd.com/
> 
> Then resend it with that support, but don't waste resources and everyones
> time now.

+1

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I've said this many times lately. There are other things in this
driver that have no upstream justification too, like nesting
"support".

Please organize this SNP support into series that makes sense and are
self complete :( I'm not sure a 51 patch series is a productive way to
approach this..

Jason
