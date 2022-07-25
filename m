Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD262D
	for <iommu@lists.linux.dev>; Mon, 25 Jul 2022 08:47:50 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id ez10so19166490ejc.13
        for <iommu@lists.linux.dev>; Mon, 25 Jul 2022 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LMteYojnWBtoBZUgjFuGYDtFnOFLH6JXb9UumNXhn2E=;
        b=uToNS5kKkiuzs3gCE1rAKXdBoFmN0lpjA5ZkeB4459FtfHbC9+wY5AOtOHYoEUTE9N
         c0imgAa1Mc/tiaOerXohnyta47hUVxft0Z23bMLD8bWnwKb92hEnK8xjE5xH0G+EgxDt
         KYyblAehv0WKufr76QTyeVn2e/U+elwAIjeDYRistamWUiJNLyn6aM/I7ot+YL4SRO+q
         EvjIAeu6U9mb5FE4F+QaHbv6gLhA9zqMHgIrv6/eFu3ebN36y5sbStpoB918gYmMgOi1
         HTvtMWkEHW5ev+OwZu1+pBe68MjW89sxQFch6LzhUK7ioHBtgnylNr1sBH5kUDPTfZM3
         WVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMteYojnWBtoBZUgjFuGYDtFnOFLH6JXb9UumNXhn2E=;
        b=DEveXus1pfnTx+MqgOaVlZht2gYV64Y+5thURhOKlxhJjIh8xdDnuY+Enad2MmaNsu
         qp1ajdPLMjOZWKTZ6JTtCBIseUUvGsAGbGf9NsoruP/RIRhlYR0FKAHmwKFzeoTL6uwm
         +dNWk3f74iXFPsw3DFdcJdJo1tuqTg4hvs+sVORc5J2ZxjFUxUrgWUEVqdMEP34tPpa/
         fK98Gw4pcvHcQ+vZz0quVeHYNp2TDJ+XeXGs6Kehs7T8hZMYnbyTsfifemrACCQ3I0eO
         IYIe9dhI6wBc/IBa8R+43RNjTzeHMcA6DzU6DTsAqWcR7O2wVCe9PfSBiVfPsavHFzkR
         hSsw==
X-Gm-Message-State: AJIora/zeONOMQSZFy+8GDKFyQSRKTtIfUSz0BduyjG7fnCXWh4mILdq
	1ESztlsKGMoFNW5b/+Rik+yYqQ==
X-Google-Smtp-Source: AGRyM1vk81vhSt+pOYi8QJg6zOOGb6DFzGSak5oaJCagQUdhnuL9SB2HvWOyu2eMNsT6e66zXtlaKQ==
X-Received: by 2002:a17:906:844f:b0:72b:549e:a654 with SMTP id e15-20020a170906844f00b0072b549ea654mr8879155ejy.535.1658738869244;
        Mon, 25 Jul 2022 01:47:49 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id la10-20020a170907780a00b0072b13a10477sm5090474ejc.108.2022.07.25.01.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 01:47:48 -0700 (PDT)
Date: Mon, 25 Jul 2022 09:47:22 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	"Zhu, Tony" <tony.zhu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yt5YmquF3vf/swBi@myrica>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
 <Yt5IqyZw/Sa6Ck5t@myrica>
 <BN9PR11MB52769B02DE62A229CCB4F2E38C959@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769B02DE62A229CCB4F2E38C959@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, Jul 25, 2022 at 08:02:05AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Monday, July 25, 2022 3:39 PM
> > 
> > On Sun, Jul 24, 2022 at 09:48:15PM +0800, Baolu Lu wrote:
> > > /*
> > >  * iommu_detach_device_pasid() - Detach the domain from pasid of device
> > >  * @domain: the iommu domain.
> > >  * @dev: the attached device.
> > >  * @pasid: the pasid of the device.
> > >  *
> > >  * The @domain must have been attached to @pasid of the @dev with
> > >  * iommu_detach_device_pasid().
> > >  */
> > > void iommu_detach_device_pasid(struct iommu_domain *domain, struct
> > device
> > > *dev,
> > > 			       ioasid_t pasid)
> > > {
> > > 	struct iommu_group *group = iommu_group_get(dev);
> > > 	struct group_pasid *param;
> > >
> > > 	mutex_lock(&group->mutex);
> > > 	domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);
> > 
> > Please also pass the old domain to this detach() function, so that the
> > IOMMU driver doesn't have to keep track of them internally.
> 
> The old domain is already tracked in group->pasid_xarray and can
> be retrieved using [dev, pasid].

Ah yes, I can use that. Something explicit would help avoid breaking the
driver next time the core changes

> 
> > 
> > In addition to clearing contexts, detach() also needs to invalidate TLBs,
> > and for that the SMMU driver needs to know the old ASID (!= PASID) that
> > was used by the context descriptor.
> > 
> 
> Presumably both ASID and context descriptor are SMMU internal
> knowledge. What exact information is required from the core API
> and how is it done today?

Today the SMMU driver keeps track of bonds, but the goal of this series is
to move that to the core.

Thanks,
Jean

