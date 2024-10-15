Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144211C07DF
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996864; cv=none; b=Le8TP1NUizcNItrxsDEIxgQLZBMN7NlqpMOHCEqSCAiJDNnaUEhjfot8DQ57x9+79lvKSKH0soYV0lEOo5yd5nPgF4gRTpQIK4+oJ6lvyBX2QFoMVAPZT+lo+y0LhUR4PHi1CPJkaUkNA1NimtSNXiozIZZvQL4OJ0wmrc1y++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996864; c=relaxed/simple;
	bh=i4IXolkJjiswk2VvQqrP3XoASrWnqInKJYEPGAho1LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4Ec899wsf4xceRQHaK8gFskIia1zNICf+LniXLJhGN3NTSE4YAgZDB0AaK5gntSbj2QChH5sI9JA9iQwGbUsvMR+ZDKjuIus97sMR1P0YTskzg0BC4D3xwOUvnMJyhnlzI3eG+qSKVn4O+RwYqbYdjH/PO8wL8r/55NCA4X1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OVD+yM3h; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OVD+yM3h"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b1363c7977so60525385a.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728996862; x=1729601662; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXrdlSFMUk7+CH9DKGI8Zx5IfrY4LnBclgt58OvS+5w=;
        b=OVD+yM3hHNgJjwjiAdUa8jRS+gSp82cZe5cFkFwDp0mQvFxNRCmYmKFn1EDfKUl2jS
         PRzh74oEih3lvENO5MmYJfCtsGmTL7a9Sz7lrrM4F8iMruDCEv3w4oq+Ct4GN0eOf5Rz
         UaqXCxt1hYKncscjbTdqeREgrUrJE7AzpNZbzRraVhtO+McwvltJ1dfSaX+xqevKR1yM
         Hfb64wI5+NIwPTof1ki675xDFZ80w1vUJ/Lcg2XFYC2hG/7SXZvLKvLQRpajL3OiaP5j
         qq77aIAQGQqbh1P8Cl40rr6yaW7UjnW8jasQZTX3UGrVRtt4zkCyNdQzZTmTEDTlIj0l
         K+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996862; x=1729601662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXrdlSFMUk7+CH9DKGI8Zx5IfrY4LnBclgt58OvS+5w=;
        b=E15+zvqwRWErwtooYjZ+NhmPssRenwnSSt1jRIqlIs8dFLi+Y9C08NlL8BEFCmMyWy
         VW8kr5ZDLKTAjCdznmYB2pD9XUXdk5CJjM8U9v47+qTBd+4ajsj+h2ru8an3kARw+zgE
         JZ7WIGioNYQT1hX76gWeikgwG54kxVIW6k2sKCuuoJf+cygT0MSH6WK1mLdFNWeUZtTP
         MkA2ppdc/JRcGmGGrFMnaqHY72pxIoJXGZS0Y6TJT52fN6ilV6Y1KUv+TRyXvgRChM0i
         G6Wy70D9XfnepJjoclU/mxAH8UiMpOPXpnDDDALcANB5BWl/FD6V1T/Ez4YOAsATWW1t
         1JdA==
X-Forwarded-Encrypted: i=1; AJvYcCXS7J+ggOqq9/xW/BduAq1FUG+97U/u1kNqSj1J96tUrjvr+vbi1mhFU1/Crcou9iSXalzn3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyY42fRWHFlSAzlR9g3CSOEkrrI58gj/3J3tb0LejBzhvByVs59
	uliPYkDque4OxM6ewzYGNvmijIpVOBTEruWS5YKOkLBFVd2Jg0WpI48V0lLKaUQ=
X-Google-Smtp-Source: AGHT+IEY7UaOsHtqws8kw4oYjkjQT/STsmKzQC1Y7WlXbDI4yfdqKavj7rrCgoa2GhsXIWLphKj2jg==
X-Received: by 2002:a05:620a:1a03:b0:7a9:bf33:c174 with SMTP id af79cd13be357-7b1417cac1amr47266685a.16.1728996861913;
        Tue, 15 Oct 2024 05:54:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136167139sm68208785a.26.2024.10.15.05.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:54:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0h48-00D49x-If;
	Tue, 15 Oct 2024 09:54:20 -0300
Date: Tue, 15 Oct 2024 09:54:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241015125420.GK1825128@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>

On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > +{
> > +       struct device *dev = idev->dev;
> > +       int ret;
> > +
> > +       /*
> > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > +        * should not be forwarded to the hardware due to PRI being a shared
> > +        * resource between PF and VFs. There is no coordination for this
> > +        * shared capability. This waits for a vPRI reset to recover.
> > +        */
> > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > +               return -EINVAL;
> 
> I am using the SMMUv3 stall feature, and need to forward this to hardware,
> And now I am hacking to comment this check.
> Any suggestions?

Are you using PCI SRIOV and stall together?

> > +       mutex_lock(&idev->iopf_lock);
> > +       /* Device iopf has already been on. */
> > +       if (++idev->iopf_enabled > 1) {
> > +               mutex_unlock(&idev->iopf_lock);
> > +               return 0;
> > +       }
> > +
> > +       ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
> > +       if (ret)
> > +               --idev->iopf_enabled;
> > +       mutex_unlock(&idev->iopf_lock);
> 
> Also iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA); is required
> In thinking how to add it properly.

FEAT_SVA needs to be deleted, not added too.

smmu-v3 needs some more fixing to move that
arm_smmu_master_enable_sva() logic into domain attachment.

Jason
