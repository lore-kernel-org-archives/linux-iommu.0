Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E814D430
	for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563654; cv=none; b=DQipSLgzSgii4LE6SrGogmndcldhC9qS4FzEXBe48ZCYZETi2MSfz1cIq3od0jKrYa+w2OirQ6aLr8c710xjnEi8EKtMTqX//1k1IcDkL2ytOFb3E3FTir/Nh5pC2cZ/+///sUfmrXTO7CpM4wBF75LdtrAZVvMX34hWLjHZisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563654; c=relaxed/simple;
	bh=OPBDvQItJX4Hsvo8moNWtE2pEEwwXpr13o6Pqef6OaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbiyrthzE7iXQ9vFGNG0EyTBbscA42YGpGCQw9ZSHgBLN53xThfJk2UMzyrt0yYf/CwBecoxfPfy7NQznI+35ImOVo9ZyhNTICbPYHBBg5jjCiL82Cmci59AGLg+UmAhFCVDK4W39MmDuDc4kSinTBlfdwOaZMroqeGzov2wcoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kZAvjoDC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kZAvjoDC"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e6e37d33c5so62381a34.2
        for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711563651; x=1712168451; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1XPHV72zhMXJ02AuGc5L64s8C1sqQEkTen4d+KPBBI=;
        b=kZAvjoDCHGDDyyyCFvdwc28AQD5NTE9C37UTdl1lzv1MsE1dyBc7Z8ZVkQSS/IxEBj
         HhT002ISoe3VWzrrJmzL4n9lC9n4EXlr4JZME2679Kf3DcAOCotK58YGUaP0mQuD50wo
         ZC1gYMC2Ctt1LDBUYXurRJxUz14xyXx+GQmUO7S4eQTIbi94iKZPN+UrBZ/wA8Ts02f2
         1PetUimy+GxEu2kDnMPzDa8IHLxEnHh3PTDTCYkZ5HpeIXydqprY9001RZ/KksbowYRP
         tNQjEpGOgCSQOu9Dd1Ruq77Ziun7vKbRWZeGASqwbPJLKl+1mbBOT6UM32gMl9r9bGH9
         Mr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563651; x=1712168451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1XPHV72zhMXJ02AuGc5L64s8C1sqQEkTen4d+KPBBI=;
        b=Bwmc1VLxf0fpWzjMSrSS3Z+IdzrLQhvplQl9KcH5v9ncybnjaPLTfR/nz+HcvH7/09
         aSrHnQxiSmMviHmFcfnDudU6p7y0Qf1IlWekh2OmAFxuYnUC7iHZ1a5jky3mppGK0gyp
         JnZr+SPTeHAGYzRV/WqLpMy7UmrU1QzLwLygK5OVSDgsDdQSzl0go7tPBXesWDcVVvdm
         7+NG12fmnjzUYH3naIP+RXRIR+EDWKMmSatIcT+DSZcAwiStR4bWyNLI6OYQmeXHsPlb
         jNshnv7aQf+XyyKhscwaoe9YqslZNUUaKqtUk3EqR2jPSpBVZytk0Wr/vZX0eJxGQdSE
         Ehag==
X-Forwarded-Encrypted: i=1; AJvYcCXRReNye3+nBzSiSO7lbm3aaVbcQv+7ouuu4gxPb3RLQbrnoQmlNGXccUOKyBF1rL4NooaPmeksm8aY0UdVm78o8zOqOKk=
X-Gm-Message-State: AOJu0YxhAX/ccAwzZCjndIqHnGjbDVQQq9q/WgmmZpBDhopLjVK3njsD
	X1FPFR1T37zGSJUGo6EtBb4yXXmKBvLy4CwbGV2WEc/sqqoIwxkvy6+w7ye5rGM=
X-Google-Smtp-Source: AGHT+IGlQgJN+JO9e8sS/bsKvnN/YrOMwN05dTpPaEA23DiNm5LU+yVmVBI9B2EsLHVZQZQjT85IeQ==
X-Received: by 2002:a05:6871:4199:b0:220:be34:7ee2 with SMTP id lc25-20020a056871419900b00220be347ee2mr593358oab.26.1711563651410;
        Wed, 27 Mar 2024 11:20:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bs8-20020ac86f08000000b004317485a4e9sm1682338qtb.66.2024.03.27.11.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:20:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rpXtK-005ior-EV;
	Wed, 27 Mar 2024 15:20:50 -0300
Date: Wed, 27 Mar 2024 15:20:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Nicolin Chen <nicolinc@nvidia.com>, kernel@collabora.com,
	iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240327182050.GA1363414@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
 <20240327114958.GG8419@ziepe.ca>
 <51f493a9-08e7-44d8-ae4a-58b2994ea276@oracle.com>
 <f78b685d-a147-4b59-beb2-cde9d34ce22a@collabora.com>
 <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>

On Wed, Mar 27, 2024 at 06:09:37PM +0000, Joao Martins wrote:
> On 27/03/2024 17:49, Muhammad Usama Anjum wrote:
> > On 3/27/24 7:59 PM, Joao Martins wrote:
> >> On 27/03/2024 11:49, Jason Gunthorpe wrote:
> >>> On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
> >>>> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
> >>>>> On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
> >>>>>> Even after applying this config patch and following snippet (which doesn't
> >>>>>> terminate the program if mmap doesn't allocate exactly as the hint), I'm
> >>>>>> finding failed tests.
> >>>>>>
> >>>>>> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
> >>>>>>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
> >>>>>>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
> >>>>>>                    mmap_flags, -1, 0);
> >>>>>> -       assert(vrc == self->buffer);
> >>>>>> +       assert(vrc == self->buffer);// ???
> >>>>>>
> >>>>>> On x86:
> >>>>>> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
> >>>>>> On ARM64:
> >>>>>> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
> >>>>>>
> >>>>>> The log files are attached.
> >>>>>
> >>>>> You probably don't have enough transparent huge pages available to the process
> >>>>>
> >>>>>       echo 1024 > /proc/sys/vm/nr_hugepages
> >>>> After making huge pages available, the iommufd test always passed on x86.
> >>>> But there are still failures on arm64. I'm looking into the failures.
> >>>
> >>> Oh that is really strange. Joao? Nicolin?
> >>>
> >> Definitely strange, I'll have a look.
> >>
> >> So it set the expected number of dirty bits as that assert doesn't fail, but it
> >> is failing when we check that even bits are set but not odd ones. Like it's
> >> hasn't set those bits.
> >>
> >> For mock tests there should be no difference between x86 and ARM assuming the
> >> typical 4K page-size. Maybe this is 64k base pages in ARM? That's the only thing
> >> that I can think of that affected mock domain.
> > The config is attached. The defaults are being used i.e., 4k page.
> 
> Looks like CONFIG_IOMMUFD_DRIVER is not defined :(
> 
> Thus no bits are being set.

Oh! 

--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -37,6 +37,7 @@ config IOMMUFD_TEST
        depends on DEBUG_KERNEL
        depends on FAULT_INJECTION
        depends on RUNTIME_TESTING_MENU
+       select IOMMUFD_DRIVER
        default n
        help
          This is dangerous, do not enable unless running


???

Jason
