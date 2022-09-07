Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAC33C1
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 09:55:00 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id bq9so6593046wrb.4
        for <iommu@lists.linux.dev>; Wed, 07 Sep 2022 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=D70XsnuK+JjOjhOUycDcv6x9oYap675Tz1NyjMuJJeQ=;
        b=ArTVxjzl4jjkeDcDAykSqOnbsnE4RyYaNvtRv5H01nXkzeOrKwxou3NLe+9X5voQB9
         k8vBvRNWJaoymUSrtwuowm9dD864p86/5v8QwkvKzkadebkZ6/ShoNbrlzL+l5SAiCCx
         HQTor9/YFxw7z2jW2AaREh15/yMAIiW1zXxlnWXxMpFdE3L/pygM619gxQjyHSzp+hnE
         2Qq1zVJxvO9Q2qCIF1/Remeygb1jzO3uN4hRTkbUa8jrz0U3QaC9bj0c9m7GHOJDX0jA
         1nVB3DZ9RNPuUhyDOTG7FiAg6Ue4QvJ7H5bcqUQaTVKkpzkm902atXG64V9WZC6AEILx
         8nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=D70XsnuK+JjOjhOUycDcv6x9oYap675Tz1NyjMuJJeQ=;
        b=q0JReTCiwLTvXkllnfb0sPaXPgTowKu1bdO761QP36jsLE4LtR5DsDHTRkySoqgL7l
         /RKgmMCvOde4EB7j9ZTTm8GaWu+kGtUoXPqjABxERQCMDnLPO9m936g6A6Fyo01A/EET
         fJehVuXECwl9Ib9h3zxjn1ar1EELOObWTnoDeMNwL5KUUSEnuRKZSV2ef1SjIm+D5VI+
         a1Do+G/OA88z0JDj93U2p8409OrAHje2Zn16gUn5k45OQB3Gtp3lo6nAzHauoVmMHNqi
         QJmNlXgVUWe0Eb6j1gAmXFmZo2R3c5OrfVugaqDBozAcOtWMPLjHK8fY9HjFP1fSO4Sv
         OIUg==
X-Gm-Message-State: ACgBeo2AwpPWrydzr+BFtXYywO/EkMyu0pPrjT0l0rGSDx72OBNILnqX
	CTZGs1Fp9dsVpvE0pwnuYg6TYw==
X-Google-Smtp-Source: AA6agR46d9IuqClGYsNh6ebHPg5a5F86IxP86Hlmd2vLbW53hk6vAwFPjS5L1FNJqf7fkT07+fz2rA==
X-Received: by 2002:a5d:588d:0:b0:225:9818:668d with SMTP id n13-20020a5d588d000000b002259818668dmr1504825wrf.100.1662544498769;
        Wed, 07 Sep 2022 02:54:58 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600005c500b0021ee65426a2sm16037248wrb.65.2022.09.07.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 02:54:58 -0700 (PDT)
Date: Wed, 7 Sep 2022 10:54:54 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <YxhqbhMmWLeFS512@myrica>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com>
 <Yxd2+d/VOjdOgrR2@myrica>
 <682d8922-200d-8c89-7142-83e7b3754b8d@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682d8922-200d-8c89-7142-83e7b3754b8d@linux.intel.com>

Hi Baolu,

On Wed, Sep 07, 2022 at 09:27:30AM +0800, Baolu Lu wrote:
> Hi Jean,
> 
> On 2022/9/7 0:36, Jean-Philippe Brucker wrote:
> > On Tue, Sep 06, 2022 at 08:44:54PM +0800, Lu Baolu wrote:
> > > +/**
> > > + * iommu_sva_bind_device() - Bind a process address space to a device
> > > + * @dev: the device
> > > + * @mm: the mm to bind, caller must hold a reference to mm_users
> > > + *
> > > + * Create a bond between device and address space, allowing the device to access
> > > + * the mm using the returned PASID. If a bond already exists between @device and
> > > + * @mm, it is returned and an additional reference is taken. Caller must call
> > > + * iommu_sva_unbind_device() to release each reference.
> > This isn't true anymore. How about storing handle in the domain?
> 
> Yes, agreed. How about making the comments like this:
> 
> /**
>  * iommu_sva_bind_device() - Bind a process address space to a device
>  * @dev: the device
>  * @mm: the mm to bind, caller must hold a reference to mm_users
>  *
>  * Create a bond between device and address space, allowing the device to
>  * access the mm using the pasid returned by iommu_sva_get_pasid(). If a
>  * bond already exists between @device and @mm, an additional internal
>  * reference is taken. The reference will be released when the caller calls
>  * iommu_sva_unbind_device().

Sure, that works. I'd keep "Caller must call iommu_sva_unbind_device()
to release each reference"

> 
> Storing the handle in the domain looks odd. Conceptually an iommu domain
> represents a hardware page table and the SVA handle represents a
> relationship between device and the page table for a consumer. It's
> better to make them separated.

Right

> 
> In a separated series, probably we can discuss the possibility of
> removing handle from the driver APIs. Just simply return the sva domain
> instead.
> 
> struct iommu_domain *iommu_sva_bind_device(struct device *dev,
>                                            struct mm_struct *mm);
> void iommu_sva_unbind_device(struct device *dev,
>                              struct iommu_domain *domain);
> u32 iommu_sva_get_pasid(struct iommu_domain *domain);
> 
> If you think it's appropriate, I can send out the code for discussion.

Yes, I don't see a reason to keep struct iommu_sva at the moment.
I believe we needed to keep track of bonds themselves for sva_ops and
driver data but those are gone now.

Is iommu_domain still going to represent both a device context (whole
PASID table) and individual address spaces, or are you planning to move
away from that?  What happens when a driver does:

  d1 = iommu_domain_alloc()
  iommu_attach_device(d1)
  d2 = iommu_sva_bind_device()
  iommu_detach_device(d1)

Does detach
(a) only disable the non-PASID address space?
(b) disable everything?
(c) fail because the driver didn't unbind first?

I'm asking because the SMMU driver is still using smmu_domain to represent
all address spaces + the non-PASID one, and using the same type
"iommu_domain" for the new object makes things unreadable. I think
internally we'll want to use distinct variable names, something like
"domain" and "address_space". If (a) is not the direction you're going,
then it may be worth renaming the API as well.

I'm also not sure why set_dev_pasid() is a domain_ops of the SVA domain,
but acts on the parent domain which contains the PASID table. Shouldn't it
be an IOMMU op like remove_dev_pasid(), or on the parent domain?

Thanks,
Jean

> 
> > 
> > (Maybe also drop my Reviewed-by tags since this has changed significantly,
> > I tend to ignore patches that have them)
> 
> I am sorry that after your review, the SVA domain and attach/detach
> device pasid interfaces have undergone some changes. They mainly exist
> in the following patches. Can you please help to take a look.
> 
> iommu/sva: Refactoring iommu_sva_bind/unbind_device()
> arm-smmu-v3/sva: Add SVA domain support
> iommu: Add IOMMU SVA domain support
> iommu: Add attach/detach_dev_pasid iommu interfaces
> 
> Best regards,
> baolu
