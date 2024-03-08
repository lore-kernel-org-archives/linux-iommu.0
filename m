Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D783FB9E
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918388; cv=none; b=ZGcgrts2B+LGTeBvJpYPo50jxfeRz4OK/qVqkZ+CfunvXuIreApfBpPSX71k7AqDD9h8BZ4pXEIkS98LzXMKy2aVeJNHi/MB+B10wulR6eYpvXWpi//6MlXeMLIRV+WQMu7QACt3AJ7uvxK5OBQUat8vDTrdkG13OIlzvThODS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918388; c=relaxed/simple;
	bh=JzkeDh5AwdfJCEuCQJCZYQvR6O/baYk0o5Ac9VAu/wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei/7FK6OOwfrcCvzN6ypD7B3BJZg95xKTNaDeW1u3rGgrFC3MySh9dF36e5D22WaB24bPqeochG5Y2EQZIZHyqtjmwXJvbfA1iQjbI8+kHVZV+3nCVvOVF1PKFQjTRgVriWmrywzj6By0VRyHhJ/iOHNS27o/k5ksUO/hLywbys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CsCMdvbn; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CsCMdvbn"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a11ed428c5so476418eaf.2
        for <iommu@lists.linux.dev>; Fri, 08 Mar 2024 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709918386; x=1710523186; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QyfvgQ7g3k3inQ55L9jhBCdrQml4NQHWxp+tVzvR3qY=;
        b=CsCMdvbntQKc/tlTPu/Ooud/ybFniQKcsXu1KYnjolLlff/mYOKDDMKVtvjFWkFPwU
         ur2d+W+HD9XzhN/cQpPXLIpGKqLvI9sIRZU7VnUsriXGe76Wf8lHSIQ9jAQ2RmiRTVbL
         CiUSWpZjNMHcqSFbSoT6Sw1vKqqKY96zmIbOKG6MYN9RSzZadtKJbRi2AQeOEVeEnD8b
         3EIBdIQ+ErBOOwgqIokVmRzO+uaCe+8vXCdSSKVmI2Qa5UNukHdzsIC50GQMyj8KGtyC
         LW3YkTVW70142DN+WN8CmXpUhObqJbP9aOBgdl4N9JYkewBaPwLvuwVBTlv0JHjiGN+t
         3ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918386; x=1710523186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyfvgQ7g3k3inQ55L9jhBCdrQml4NQHWxp+tVzvR3qY=;
        b=Z0quBCam8bk3WQzs6uwti04FoTNp0Y9G3ZzOAfxczhdtDE5gF6BQTdNa2z1NGwrPBY
         apYg+LvsBeWujgE8+AWBK+qsCyCMvQErnX1/qIng9GYo8FtYTJNplROLUksMWtOR4XAU
         xup5JntJM9REsobmRDGstQ5V1cnDcjE5BpGaN5ItvdVWQAcZTusUBTvtUd5isKXEspBg
         Lx6C3QQCMWPLGfYFQ1zJalZ7nmS/YrHrOuU3rCBJ9ByIHCG26BUBhBYFsak/XjHn7puF
         cCnurVBtOfa6S9zm+ucagYQ63Dgz/ohKshNP/Y/uBwkCKFb92q5KOnU0qoB8Xv6aGNMD
         NJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDdOu9nEe6EA49WpLe6BDjyAZ4Q8Jdhh2qh2pKTXyFeu9vC1y/0ERTFIZbMwwbDjNH9/BSorb9izd/uw26DXQUHT135XU=
X-Gm-Message-State: AOJu0Yz0laRTVk88ZkXUX4T5dHK3SrA0/DL1T2/ui8hThijosD4dj6T9
	S7keYvBAWP9npWdCYmBsqF6dOipPvlah7YkOkLNPm68dtPmt+OSfwOjDHxhDWyM=
X-Google-Smtp-Source: AGHT+IHGXwED6hQvAWGBvs0kxPiSJ0tL8OBtEwFzgQm9eQ3JplhnsbF7jKSfoG/okjgvLWcpY+GZ4g==
X-Received: by 2002:a05:6820:229b:b0:5a1:c935:2eca with SMTP id ck27-20020a056820229b00b005a1c9352ecamr2575641oob.6.1709918386043;
        Fri, 08 Mar 2024 09:19:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bs18-20020a056820179200b005a12e140fa2sm490330oob.22.2024.03.08.09.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:19:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ridsm-007URd-IT;
	Fri, 08 Mar 2024 13:19:44 -0400
Date: Fri, 8 Mar 2024 13:19:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240308171944.GU9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
 <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>
 <20240306160120.GN9225@ziepe.ca>
 <74d6f11a-9415-48e5-a165-7b9f5b87873d@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d6f11a-9415-48e5-a165-7b9f5b87873d@linux.intel.com>

On Thu, Mar 07, 2024 at 09:54:53AM +0800, Baolu Lu wrote:
> On 2024/3/7 0:01, Jason Gunthorpe wrote:
> > On Wed, Mar 06, 2024 at 11:15:50PM +0800, Zhangfei Gao wrote:
> > > Double checked, this does not send flags, 0 is OK,
> > > Only domain_alloc_user in iommufd_hwpt_paging_alloc requires flags.
> > > 
> > > In my debug, I need this patch, otherwise NULL pointer errors happen
> > > since SVA is not set.
> > This is some driver bug, we need to get rid of these
> > iommu_dev_enable_feature() requirements.
> 
> Yes. Especially iopf should be independent of SVA.
> 
> The problem in the arm smmu v3 driver is that enabling iopf is actually
> done in the enabling SVA path, while the enabling iopf path does nothing
> except for some checks. It doesn't matter if iopf is tied with SVA, but
> when it comes to delivering iopf to user space, we need to decouple it.

Yes. Each driver is going to need to get a to a NOP for the feature
things then we can remove them.

I did half the ARM driver in my part 2, the iopf bit still needs
doing there.

Jason
