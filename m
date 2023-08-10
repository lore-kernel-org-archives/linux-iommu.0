Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80261E1DA
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 16:36:38 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-565403bda57so755415a12.3
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691685398; x=1692290198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAmLYynJNs/JRcQ7yD4Mxp1X2smKrNsOj/BixVS0HCg=;
        b=EwzA123zqRuBCUp3mBzJZO/MCbDuhKtsKqOmqiiUSIPF7GW4sIzA1kmam5Sv9EbhcS
         sujDPRcIz2RJpmGrkkH41TanVkT4nF3kNCZC5LEj7uB+aqXFFzMX3lS3dXxmR5NtirD5
         i7/iErfrBWWOuvMuPIvvjBEe6UsaQgkB483TPaJBcCWdehU6xkcI96tyODjzX2kZHt3Y
         RBgqE4idU6N1zrS1q/QCqELnR4jSLrrUCXBsPiixpRfgS7zDR7LGo1bKpnfUN/pwS8ve
         XFHtPPLxsjGxol0TuAREGFDa2+V5moEylhvLtnBs055TnHHCED8pKxZBwg3NOw4sqYzb
         Q9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685398; x=1692290198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAmLYynJNs/JRcQ7yD4Mxp1X2smKrNsOj/BixVS0HCg=;
        b=L7/GyAAARWGheXLuecruYplF0+/wDOJZWA3hncCj+3wGHvrEVY5mLOT0+foMwbx3FA
         Qc47T4dr7NAFqn/27UG81+MsUn0X/+F2/b+RO6LmZgJAEdTde+VvM64gob9+mUy6rMO4
         XixXjKAjHNGFyk4Yrg+EU29kublYKCRjd3ZFFfM715zjEV/3+svtQmfU7QBUzOHybsJ6
         LcIMkYQ52na6f2BvLuGcDTFBC3XSyQoCxMzjrFBPDJ6lefbWj7boLUtuo0Td3Gq4dlMd
         87bRWC7pMz6iirm9YEGup8jnfL4gJ/qFUeXQ1akO5cce7SHO/Aex96pvbNPHKMCqNpnl
         FFbg==
X-Gm-Message-State: AOJu0Yw5YbhYk0xoTEDx+4ri4kbplklHDQopA/Y7Aj+DogTxVIsx8HFV
	zlAmS9Y3XBE8QZd7h6ZBOcZxOQ==
X-Google-Smtp-Source: AGHT+IFqbDsbenFQiKdalqSq7WrY8AerqUj0j1LAUzLPJBk15OoizZx4GyWgXgpjeCFbG5P0N/3hNg==
X-Received: by 2002:a17:90a:a50a:b0:268:5fd8:d8ff with SMTP id a10-20020a17090aa50a00b002685fd8d8ffmr2324584pjq.0.1691685398017;
        Thu, 10 Aug 2023 09:36:38 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a190900b00268032f6a64sm3828826pjg.25.2023.08.10.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:36:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qU8eI-005H23-NJ;
	Thu, 10 Aug 2023 13:36:34 -0300
Date: Thu, 10 Aug 2023 13:36:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Zhang, Tina" <tina.zhang@intel.com>,
	Michael Shavit <mshavit@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Message-ID: <ZNUSEiXTYbV7ML6x@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNOH9lPdTnltb9JZ@ziepe.ca>
 <BN9PR11MB5276A5E619DF6638677DFFA58C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A5E619DF6638677DFFA58C13A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Aug 10, 2023 at 07:52:52AM +0000, Tian, Kevin wrote:

> > The driver should rely on there being exactly one iommu_domain for SVA
> > per mm so it can hang the mm_notifier off the iommu_domain
> 
> I'm confused. Isn't this series trying to allow multiple domains per mm?

It is doing both.

The main objective is to allow de-duplicating the SVA domains in the
core code. The driver should be able to assume one SVA domain per
instance, or even one SVA domain per compatible instance. The driver
should not do any de-duplication.

But we can't just store a single iommu_domain in the mm_struct - we
have the same problem as iommufd and we need to create more domains if
the domains we already have are incompatible with the device.

Arguably this should not happen, and in any sane configuration we
should have only 1 type of IOMMU driver that needs only 1 SVA domain.

But right now things like SMMUv3 have problems crossing domains across
instances, so we could have one SVA domain per IOMMU instance until
that is fixed.

Jason
