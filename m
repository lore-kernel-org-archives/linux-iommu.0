Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F26ADB
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 12:54:53 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id h11so4937006wrm.5
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678452892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0ospi7hAz+YOXFhrcdrmC0AaEAavOtedBIMfZumahw=;
        b=S/embe4vV/aUjhx0hf78tsuqzg4I9LW1TABo3WKf3Hn0NoAUycBwCqiaehEFyDTrbT
         sz484eR+p5i+W+sk8RE+Vxapu3B4oz9hr90IXE+/fJeCRjSbVDdj3sTf2k9KThyTu7Ma
         idPDGLY17oNRfsmL+0ulcaVgbziP85JUTfY7pbrOzIqtmQ68pbed5oD3KhYdw7I1Trb6
         a3z1KxDONrTwVY8IZKUI9EgPcv5nRyN+gLJet4b6fV9oENCuVXC/t3mYymJeqGmwAZfI
         zJbWsZ4Kw9y43Nm1ikrPXOpUcSL4iaQsRD7pmXRUaiZggPArQJMDWk5H6G7FZKSVIbDE
         vuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678452892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0ospi7hAz+YOXFhrcdrmC0AaEAavOtedBIMfZumahw=;
        b=tXmf2LGSOVv916llnRpzn6lRMywmd2qP+MIO6abVg6XAC+2m44SaZ1KZiTbQOX6V+K
         g+0DaEo8hq+jbDLcZ9Xu9lRbyMrFjUqKxxulkSPX2a03S4ojiXdVe8CRJvpEQAcrTTKD
         0DfDXknmbpoz8uVBRuUHv2BJIYL1DEefGfMei63uJWfWP15eJuUWT4gAL3xFQNf+NsNt
         Fyh9B9ZhcCIKfbOhCivD7j8wmrBfS0g1wOSaeTVzqZnLp7vtl7Qjugyvj7ouCbCUz7Jb
         ltEtAY4oWVldYU8kFoIywDJPmRccjQ4Ul0Ocx7nnbfUE3YVL3uyfsl6iwav+/fhzReu4
         ncng==
X-Gm-Message-State: AO0yUKU8yx/ikrZfu7l2VOxWmicICMsR4hY8ptTHvbHTkZMLdnwPnnDO
	QBj2yCn0AcXNQbVZPLNzzjoYPQ==
X-Google-Smtp-Source: AK7set9QopboGBXW0L86P0Njeyu3ao51+5KPjvl3aAAxvX6GWgngEgPHqEMQjQqR8jTfSWeVmOBXpg==
X-Received: by 2002:a5d:5344:0:b0:2cc:5ee8:fee5 with SMTP id t4-20020a5d5344000000b002cc5ee8fee5mr17048523wrv.71.1678452891891;
        Fri, 10 Mar 2023 04:54:51 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe10f000000b002c5526234d2sm2089144wrz.8.2023.03.10.04.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:54:51 -0800 (PST)
Date: Fri, 10 Mar 2023 12:54:53 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, robin.murphy@arm.com, will@kernel.org,
	eric.auger@redhat.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, joro@8bytes.org,
	shameerali.kolothum.thodi@huawei.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <20230310125453.GB1745536@myrica>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
 <ZAq3LJgbo8ApejvU@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAq3LJgbo8ApejvU@Asurada-Nvidia>

On Thu, Mar 09, 2023 at 08:50:52PM -0800, Nicolin Chen wrote:
> On Thu, Mar 09, 2023 at 10:48:50AM -0400, Jason Gunthorpe wrote:
> 
> > Nicolin, I think we should tweak the uAPI here so that the
> > invalidation opaque data has a format tagged on its own, instead of
> > re-using the HWPT tag. Ie you can have a ARM SMMUv3 invalidate type
> > tag and also a virtio-viommu invalidate type tag.
> 
> The invalidation tage is shared with the hwpt allocation. Does
> it mean that virtio-iommu won't have it's own allocation tag?

I'm not entirely sure what you mean by allocation tag. For example with
SMMU, when attaching page tables (SMMUv2), the guest passes an ASID at
allocation, and when it modifies that address space it passes the same
ASID for invalidation. When attaching PASID tables (SMMUv3), it writes the
ASID/PASID in the PASID table, and passes both in the invalidation.

Note that none of this is set in stone. It copies the Linux API we
originally discussed, but we were waiting for progress on that front
before committing to anything. Now we'll probably align to the new API
where possible, leaving out what doesn't work for virtio-iommu.

Thanks,
Jean

