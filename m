Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712C7A
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 09:44:35 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so6379504wmp.3
        for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wi1R/bUTiY7+3hGQ5VIW8xv0nt+HW5ohTHS2cOsUuxA=;
        b=eCCsODKyUzUbN1l+lGklBxP8DoyEl8UmwdVrUn6DZyD9ii78730U+Cbd30f/zxSYeI
         yCiAHujMhO733mZ5V6alMA8quWRk1Pf5nh1HVEohYgs3Gja59ggRrPil6gz/kA+3tXX1
         A4lhouHwDfP9cSkOeBmKou4+fC1/rLn0QJhxTThQtXEV/LHO564Di3ht8/rwb+q0l4f/
         LAwjukId2/g9qceJansG1tgOOMtQ+w8le1lsc3ODF9mnJaMHi60ySGLEEN5+Ge3AKlba
         LaWoebxIcMycIJgzd5O+WwYc7juwHC+e6SmYoZgOgMU7SArd7RwqeY+9M7IamZd5NPKg
         Rtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wi1R/bUTiY7+3hGQ5VIW8xv0nt+HW5ohTHS2cOsUuxA=;
        b=hlftpsT2s3jSTzSlSeIBdBUNH6d8mVG32O83W+bKueTlwSnGA6km2zPHemWQcdJXxh
         n7XjvrUwaUSfp/ffB8BcG6kEMpAihQBH0rIctGyLEC3XTlMt6m2DgV2tV448JDxSP07u
         qBBDRBumtm1s5f15fn+yYUqBMbt9ZoLfu6Kn00CYzFaOdsnS2nN3IKvLrM7cydlnkstU
         EqqF2sqt2ho3IMHHNYxw1Aq77R2gAD0HkReCRWHJlsX/MVKHGB18RxrRyOgLz6x8NY6Q
         5RDHKfnKgQdmzOLBb+GZLkXLxUu3JX0ZHLCqBO/VqGqGWmI/DIaeYdwAfL7eVmP8CIpN
         R9OA==
X-Gm-Message-State: AJIora+apGLpilE72PJgzB+HJTfCND8SEAqeDUUigwU99WEky7BCR2HJ
	UeCwbgO9OX/zurNd/Tz3jb4Rrg==
X-Google-Smtp-Source: AGRyM1uc+0wZLX7veWfVUWspRrMtzkpH+FPfFbZjdcbIISE//UQJ0kznPtVc7bKy9D8Gn6FVxMQfGQ==
X-Received: by 2002:a05:600c:1d0e:b0:3a0:50bb:55e0 with SMTP id l14-20020a05600c1d0e00b003a050bb55e0mr4035158wms.89.1656409474286;
        Tue, 28 Jun 2022 02:44:34 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c1c0900b0039c7f790f6asm22093111wms.30.2022.06.28.02.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:44:33 -0700 (PDT)
Date: Tue, 28 Jun 2022 10:44:10 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Message-ID: <YrrNarTWvMydIDwQ@myrica>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <BN9PR11MB52768181B0EB29DBCB11AEA68CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768181B0EB29DBCB11AEA68CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Message-ID: <20220628094410.g4X0nL9WWDw9wWwYsLimqipOPoD3A0Ue3riQwQ5LISE@z>

On Tue, Jun 28, 2022 at 08:39:36AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Tuesday, June 21, 2022 10:44 PM
> > 
> > Tweak the I/O page fault handling framework to route the page faults to
> > the domain and call the page fault handler retrieved from the domain.
> > This makes the I/O page fault handling framework possible to serve more
> > usage scenarios as long as they have an IOMMU domain and install a page
> > fault handler in it. Some unused functions are also removed to avoid
> > dead code.
> > 
> > The iommu_get_domain_for_dev_pasid() which retrieves attached domain
> > for a {device, PASID} pair is used. It will be used by the page fault
> > handling framework which knows {device, PASID} reported from the iommu
> > driver. We have a guarantee that the SVA domain doesn't go away during
> > IOPF handling, because unbind() waits for pending faults with
> > iopf_queue_flush_dev() before freeing the domain. Hence, there's no need
> > to synchronize life cycle of the iommu domains between the unbind() and
> > the interrupt threads.
> 
> I found iopf_queue_flush_dev() is only called in intel-iommu driver. Did
> I overlook anything?

The SMMU driver will need it as well when we upstream PRI support.
Currently it only supports stall, and that requires the device driver to
flush all DMA including stalled transactions *before* calling unbind(), so
ne need for iopf_queue_flush_dev() in this case.

Thanks,
Jean

> 
> >  static void iopf_handle_group(struct work_struct *work)
> >  {
> >  	struct iopf_group *group;
> > +	struct iommu_domain *domain;
> >  	struct iopf_fault *iopf, *next;
> >  	enum iommu_page_response_code status =
> > IOMMU_PAGE_RESP_SUCCESS;
> > 
> >  	group = container_of(work, struct iopf_group, work);
> > +	domain = iommu_get_domain_for_dev_pasid(group->dev,
> > +				group->last_fault.fault.prm.pasid);
> > +	if (!domain || !domain->iopf_handler)
> > +		status = IOMMU_PAGE_RESP_INVALID;
> 
> Miss a comment on why no refcnt is required on domain as explained
> in the commit msg.
