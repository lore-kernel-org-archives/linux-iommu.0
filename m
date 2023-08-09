Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB316426
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 12:35:05 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6bd0a0a675dso1282944a34.2
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691584505; x=1692189305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1vlk426yx9I7RvL78AONvP5VHRKVeaBopr8pvsM2ew=;
        b=kZqvQo7QPz15n/1fXXXDdFKSI0e4A/DXzZVaQfaTr7UjANpLuMN3SzY5NxH7MwzQou
         FsNvDyhGFtnBkr34Jr3/ehvKXZ7FKv+3efLEWkVBKZqVsxsZwHLk9+NuV9pYNSDQAttt
         FVreMUaoInrkupaNoigWXu7tLt8LU4K8IL8ZsX9HSuR2iM7+Wwmu1hfOsdVBFPpNh4m0
         asP6tXW7QTlzIOErn16fFZ8FrcUBTYRzMThlg9BT3rb4h51TIXX98ai9eaS7lKWzJkKj
         eEZ7S8/BOrUG55+UoAVm1UcV993ktA0o6xFys38oDvqmcNiRisb4+X9vvSlkuobUELjn
         Um1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691584505; x=1692189305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1vlk426yx9I7RvL78AONvP5VHRKVeaBopr8pvsM2ew=;
        b=j0LIB48ZEvDJsa48f2/tm8kt1voCF7scoEpiKMd4m4rtSjl0Mx+44/avrTsRnkAKCX
         MD/IJYhtjfZIhIQbwlplwkiv3Pv3KzVlkpBJdFu8hVoowxmwOnzj+ILuPjONoeQlv6vd
         WxK/0O6ftp+fo6v1AKfZdShVa/n4hB+RyP9VRgQ2hn0TTVeK3n7jKsihQU5hQOkZv2p2
         PuemzXKuT6IIvveyKUAXmkdssPmLGfeIE6pyz0LXvgMPFN11D+NPFlkGRMtf1FfCoWXf
         Hu0p4xsREg4cNz8Lu62hF7tpYijemYoHs2FA4tQcv5xdSAoODVHwTxnjsSVO8/iRYYec
         KpGQ==
X-Gm-Message-State: AOJu0YwewqxL6Z1C116pJJaM3kS4Tnw4WSfwE6qGXtVo+CYv5lu71wZr
	UXkaCBpGRg8wMiR/ZhLKsaiGRA==
X-Google-Smtp-Source: AGHT+IFXJv4SSKywPDvp9X/J5cU2mrSKT+Vbk1TAqRv+ipibzkD6pTEls1NDEePZUTv1nQ0uFw/t3g==
X-Received: by 2002:a05:6358:428c:b0:135:b4c:a490 with SMTP id s12-20020a056358428c00b001350b4ca490mr2799558rwc.10.1691584503427;
        Wed, 09 Aug 2023 05:35:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id b17-20020ac86bd1000000b0040ff25d8712sm4030373qtt.18.2023.08.09.05.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:35:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTiP0-0051O0-Ef;
	Wed, 09 Aug 2023 09:35:02 -0300
Date: Wed, 9 Aug 2023 09:35:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Zhang, Tina" <tina.zhang@intel.com>,
	Michael Shavit <mshavit@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Message-ID: <ZNOH9lPdTnltb9JZ@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Aug 09, 2023 at 09:49:16AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, August 9, 2023 8:22 AM
> > 
> > On 2023/8/8 15:49, Tina Zhang wrote:
> > > Use the helper function mm_get_pasid() to get the mm assigned pasid
> > > value.
> > 
> > For internal iommu drivers, perhaps we should use another helper.
> > Something like sva_domain_get_pasid()?
> > 
> > Suppose that the iommu drivers should have no idea about the "mm".
> > 
> 
> Aren't all touched functions accept a struct mm_struct pointer?

It is wrong for the driver to even ask this question.

Domains, regardless of what they are, get attached to PASIDs. Maybe
many PASIDs, driver doesn't get to care. SVA isn't special. Stop
making it special.

The driver should rely on there being exactly one iommu_domain for SVA
per mm so it can hang the mm_notifier off the iommu_domain

But otherwise invalidation for a SVA domain should be *exactly the
same flow* as invalidation for a paging domain. It iterates over the
attachments and generates the correct list of PASIDs and ATCs.

Jason
