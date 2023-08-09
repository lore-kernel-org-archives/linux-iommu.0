Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349317755
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 14:48:26 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-63cffc0f95eso34946026d6.3
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691592505; x=1692197305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4bISbA3t+yh3hAsX3GX16FfloCmjYYwoOgy/YO987g=;
        b=hQyQFawRvch/vrwsE1c4VcH8/I/37cjfRv53xh3z+C3J10ieZX2v/VwO3tZpFABOaM
         v5TOpGidPc7LPAr+vIBVlHx3ii9jMKu97ZCWLbrc4khP5xymRspT9XsE2mP2YndlQnbv
         QGyEAVLApPpT3nFaHk178DUyBaZOudxpbciJOH4XvfE7IwBBp6QCRDzweEX1Ttc1/rus
         Dd9oVW25SC9k5IWoRxW5mQ86wpxFV2ik0O7LwEf3ZhuQL5EIDRZ6HRvE/22u0CHwFf4y
         KB7MRNS7+IOayj1ck8GYw4o6sFaQS+W2oRAAcbzDTU2bbLxP8f7xBSpwnHagMv9hj2al
         UIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691592505; x=1692197305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4bISbA3t+yh3hAsX3GX16FfloCmjYYwoOgy/YO987g=;
        b=Gjqa4zYsg+d+lXW/qHDUTkOhm70JIIVQasEaWKkmGPGAJQ+QyA6lU4n+o5WAFm0hEW
         AYBj4VByY39/OB/ey83ku/rjMClbMoelizwCXhuI2XHldGGl0qZp2wvnbujO3CYJOtd6
         sI5vA5Bbpy//KKYORFwv07/z6yas5hppuvcxaNphxySgWRaroyp52/Si2yJYyjIHo1Km
         JsoLueCQIpSaKs6FGDC23t6RF8f5AKJuAH0VX8hppSxgJ3e3H2mao0Ln7FkJ5D+hcb1k
         1cMlgPV3B0p9NtD9ExcBfLlkXHKeCTrkckZdgFZfaDfnW3yHh0lBc+RgUjWUAa3U+b4r
         cILA==
X-Gm-Message-State: AOJu0YxX2s48/3ujTsYy3dvgAiD8f1OGOz9AJHdngEHCff969K0vuPYr
	8LDwXt+e62Fl3xWewdR/rrL5303K1NG/D5/SFzg=
X-Google-Smtp-Source: AGHT+IFgpbmLdpjQ1gAKEz+zkG6hBf1mGwlCmh/weIzumrbnKNHa8HANKleEhFnF76ZwV/rj6sLhbQ==
X-Received: by 2002:ad4:4047:0:b0:63f:78bc:85de with SMTP id r7-20020ad44047000000b0063f78bc85demr2462304qvp.56.1691592505716;
        Wed, 09 Aug 2023 07:48:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id pc41-20020a05620a842900b0076cc0a6e127sm4019495qkn.116.2023.08.09.07.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:48:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTkU4-0053aa-MQ;
	Wed, 09 Aug 2023 11:48:24 -0300
Date: Wed, 9 Aug 2023 11:48:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"Zhang, Tina" <tina.zhang@intel.com>,
	Michael Shavit <mshavit@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Message-ID: <ZNOnOGTfpXzrrRTz@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c0e94e88-94b8-69de-69c8-ed132ae28951@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0e94e88-94b8-69de-69c8-ed132ae28951@linux.intel.com>

On Wed, Aug 09, 2023 at 06:58:15PM +0800, Baolu Lu wrote:
> On 2023/8/9 17:49, Tian, Kevin wrote:
> > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > Sent: Wednesday, August 9, 2023 8:22 AM
> > > 
> > > On 2023/8/8 15:49, Tina Zhang wrote:
> > > > Use the helper function mm_get_pasid() to get the mm assigned pasid
> > > > value.
> > > 
> > > For internal iommu drivers, perhaps we should use another helper.
> > > Something like sva_domain_get_pasid()?
> > > 
> > > Suppose that the iommu drivers should have no idea about the "mm".
> > > 
> > 
> > Aren't all touched functions accept a struct mm_struct pointer?
> 
> In the end we should remove all mm reference in the individual drivers.
> The drivers only need to know what they need to know. All mm-aware code
> should eventually be moved to the core.
> 
> For now, at least we should avoid using mm in the set/remove_dev_pasid
> code path. Later, once we complete consolidating mm notification in the
> core, drivers will have no need to use "mm" anymore.

I'm not sure how this will play out...

We don't want extra function indirections here so ultimately the
driver needs to hook the arch_invalidate_range() in the mm_notifier
with its own function.

The core could put the mm_notifier in a common iommu_domain_sva struct
and it could stick in the driver's invalidate ops, that would be a
nice simplification (and discourage drivers from doing the crazy
things they are currently doing)

Jason
