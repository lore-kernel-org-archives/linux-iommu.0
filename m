Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705385388
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 09:07:41 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id q5so4059424wmo.4
        for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681204059; x=1683796059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYI9Zq6eTHiCpiII3rmn8bX2XJ3UVLEAX1yejf9YQWU=;
        b=LmOUzduy+Kctn47PPBlggBOzDtIH8pKkG8r9ChNJvastIHuXQj0GuYo/n1QSZJOZuD
         VaObkLCi9jSef+wf124/d4UD26tJN/uzV+auT6ZxfSI4bQha63jgJFTVQRRwjBRNwu4r
         Ysnl/6CCQ+mLe+loXJN2onnHRNFPgvMNrXehBQ7UVM+G2f3He0z9EJUyOdgKf4pQZC1L
         +XiSztstdAWlBVgdwKHkTeIHLls7CruxPrZsNhi3wZgnLDg47hqVsR+630PE+9i0nOPU
         vG/46A7gp1GSU/kw64TtU66HVwpseCnYJHlqOYZEtQWwxj18cW4oFE7ARyb88wFuD41f
         zqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681204059; x=1683796059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYI9Zq6eTHiCpiII3rmn8bX2XJ3UVLEAX1yejf9YQWU=;
        b=e+aFIKhYrscM5/bet/edcmqX+SiuAc4C4LYyI1Nvm97rtOtFrDWqVS0XWYf1IlY3lS
         h1taxuvt+ODEfFXH8fMpWEPNi2qzUgHJiRPD2MYPGXXAJ69cQ0Uws6t8DaKC5XJMd9F7
         PiFy3YWqM09UfKUovDgNSp7vvzp2iIET9NoAy1R9eHxrbNTCTZgqasBLNb49AdeM8Opv
         JSkVeD1JQYvKnf/Ny/iDlpaOSad32ymxb0XADGxfbfzKZXeHWfuAwCK2CTY3tMsKCYGy
         adiCBh/pbthKlmsPsDtGcWbtMVDJgz6AjR6EFwB8fsAEZo/HM2ZuYebEIRNOxOQk5Py7
         PP1Q==
X-Gm-Message-State: AAQBX9euI8FuJD+EMy03viFlTDNskBa0nA1lqEhyBGkUCD2bXjIo0Pgh
	F93e0304Be9UNo6kjOXTHJGDwg==
X-Google-Smtp-Source: AKy350aAXsucwvImGm5Ggg9tAmK8IGxd7xbmHlUwyry2cgmUFBeY7fNC8CCNhSQ5xCigXw7SlYN4yw==
X-Received: by 2002:a05:600c:214:b0:3ea:ecc2:daab with SMTP id 20-20020a05600c021400b003eaecc2daabmr10107686wmi.3.1681204059530;
        Tue, 11 Apr 2023 02:07:39 -0700 (PDT)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id p15-20020a1c740f000000b003edc11c2ecbsm16423137wmc.4.2023.04.11.02.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 02:07:39 -0700 (PDT)
Date: Tue, 11 Apr 2023 10:07:40 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	qianweili <qianweili@huawei.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <20230411090740.GC2040385@myrica>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
 <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
 <ZC6vlI7onlUgBidX@nvidia.com>
 <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>

On Sun, Apr 09, 2023 at 06:08:25PM -0700, Nicolin Chen wrote:
> On Thu, Apr 06, 2023 at 08:40:04AM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 06, 2023 at 02:23:17PM +0800, Zhangfei Gao wrote:
> > 
> > > We are using ioctl method now.
> > > From the testing, the TLB miss impacts performance a lot, so we use
> > > huge page method.
> > > After using huge page method, guest can achieve comparable performance
> > > with host.
> > 
> > Looks like these tests are not stressing the MM, just measuring pure
> > BW of the DMA, so they don't get into the invalidation regime..
> > 
> > You need to measure a more real application that is actually using the
> > MM (eg alloc/free memory, fork, etc) while it operates and turn on SVA.
> 
> Would an iommu map/unmap benchmark test be useful here?

You can reuse and improve dma_map_benchmark, already upstream. It supports
multi-threads and reports stddev. For some comparisons the report
resolution (.1 us) is insufficient and needs to be increased, but for
comparing guest performance it might be alright.

https://lore.kernel.org/linux-iommu/20201102080646.2180-2-song.bao.hua@hisilicon.com/

Thanks,
Jean

