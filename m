Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6C612D
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 14:05:10 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-40ffa784eaeso23660201cf.0
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691589909; x=1692194709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Os5sLDeFoJgDXLzdefgu9SaTWkLJ6QLGY9rFMdBUmEE=;
        b=Xu6bR3LQqWohb3H3pLYSmoX1OTdMouJycfbvXiceZMoEJm13T4C5o9HrtpwtJuUsak
         9jd8egMjXygRZvye5u9t8lF+ZjmvY3VTDV5EbbMo1A0WhFH9IX96K8EL0xR+YYfMqA4D
         VjrKUANVKJIrwz0iYUycCoRbqLZbAbMJpictaxGWvBpxMH0l7WjnMzgQFecDJwrDjdGl
         ODuZAyPidZ4iphNfjMkoy31dJQvHQKQlxB7q9DEIY1okH95rZQHIQS9JW7erjHLkAcbQ
         PxJy29aNSrntCqvmLc+xvwGrrgzzKcBTAFFDIto0PD3jTBN6qfZiQRLI7113zkOuJ4UG
         uehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589909; x=1692194709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os5sLDeFoJgDXLzdefgu9SaTWkLJ6QLGY9rFMdBUmEE=;
        b=lkuwJ4ns0KJEt+aMg9KZeRpE3EgOtSmRlhMf1irE8VXNwz5zV5vmGIJX0L1s/rmt1Z
         J6AKo3ZyZbQSro7P7K/ZLw6WgNQu/sVTiDHKnWGC7VxhySAMOdNSyqEPQGwVz+wfkWUZ
         dvmXabQ5Hq+qcOtMYPXmw3SaQbdJKL0pGs4EIoiy8c9ZV7SmR4+2s9G3gpbvFWoWMG2C
         OEEuEB5oFdUyOnRcgMB0wNkvmBDnr15umZlrUwyEyJnjhwe0IAFooDHWTfL+iv4BN7UP
         2aufKbpdQNwD0iTJk7soECrhVEpBpZMV1y+4b5d0Ey8dk6vT1aK/ZObjEsKk7B7Qgzvk
         i9OA==
X-Gm-Message-State: AOJu0Yz/6h5DGI8sKRUgiZq3worCUuZmjDhetZ2E3Jclo/fywCQ1yaat
	fT0Viml671xdyAjmGXLC1KJ5GA==
X-Google-Smtp-Source: AGHT+IGvZOcp4bb27HKnCKu89Ds+xRbiF6jalvoHqbvWWI2i+kDh/U0gDO/IhAxknKds9cNT60ju6g==
X-Received: by 2002:ac8:7f81:0:b0:400:a2b8:1c97 with SMTP id z1-20020ac87f81000000b00400a2b81c97mr3666633qtj.17.1691589909295;
        Wed, 09 Aug 2023 07:05:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id e7-20020ac84147000000b00403c82c609asm4136670qtm.14.2023.08.09.07.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:05:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTjoA-0052Z0-Ku;
	Wed, 09 Aug 2023 11:05:06 -0300
Date: Wed, 9 Aug 2023 11:05:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/12] iommu: Remove unrecoverable fault data
Message-ID: <ZNOdEtbMaHg9Vmmq@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52767976314CC61A0F8BEFD08C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <faad1948-5096-c9d3-616a-cd0f0a4b5876@linux.intel.com>
 <BN9PR11MB527614E61BC257FE113EFE358C09A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNKL6hGRZT9qfV1K@ziepe.ca>
 <BN9PR11MB5276DA9E6474567FAFE9424B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DA9E6474567FAFE9424B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Aug 09, 2023 at 12:01:52AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Wednesday, August 9, 2023 2:40 AM
> > 
> > On Fri, Aug 04, 2023 at 03:51:30AM +0000, Tian, Kevin wrote:
> > > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > > Sent: Friday, August 4, 2023 10:59 AM
> > > >
> > > > On 2023/8/3 15:54, Tian, Kevin wrote:
> > > > >> From: Lu Baolu<baolu.lu@linux.intel.com>
> > > > >> Sent: Thursday, July 27, 2023 1:48 PM
> > > > >>
> > > > >>   struct iommu_fault {
> > > > >>   	__u32	type;
> > > > >> -	__u32	padding;
> > > > > this padding should be kept.
> > > > >
> > > >
> > > > To keep above 64-bit aligned, right?
> > > >
> > >
> > > yes
> > 
> > If it is not uapi we should not explicitly document padding (and __u32
> > should be u32). The compiler will add it if it is necessary.
> > 
> > If the compiler isn't right for some reason then something else has
> > gone wrong.
> > 
> 
> I thought this will be used as uAPI later. I'm fine to leave it be and
> add the padding when the uAPI is introduced.

Yes

Jason
