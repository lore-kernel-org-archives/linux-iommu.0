Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A891DE3AB
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170489; cv=none; b=MJD5oHvdtqZ3BQa6AL+GYJu2O2CcF1FgBn1Uow2Mimk46B7m8GUtdIt7W8fwXYxz84aq8s1n6tCeL73l3w5vYcdTo0UXOKCtL0nodmrtDhLaRs8dKfDFKazNO9GFSKcqY86gB8OdqhEn5awGmb9cc9/Da3L6gkoVtao9oWYZACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170489; c=relaxed/simple;
	bh=MCRIxE9GhA2NAkXdzXaszALYW7VA4HLq5f6MBrAaTKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfEXgPUQB5kE6LDNimAce+yVCoBTiQY3xm0srfEgjnSRx1Pg+sHPwfaLsG6LKZRgb2PULtz5ZqYcE+hTAwwaIBnlikIjDfFDS0I0ucByMbFWp4B+sRW+c0syHSgEFZUOpMylH1Zgm32O1tnsHCkxUDaZermWAU84uDlQLakSchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EqJ3Z4Ya; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EqJ3Z4Ya"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460a5e943d7so2863931cf.0
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729170487; x=1729775287; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wq3teVnFjCQljMHeJKswAqz9sY5geo+xNzpep4xNz44=;
        b=EqJ3Z4YaGarojm4RNiwVBrJjHF5OCEuCkRLTR4ZIn+7nH1/LvZjBflViNyKbZiY5hr
         /oEc4IeWY/iYdPA+wMyMXXiiJ91OuwHboApM/VmEWBn8s+P+GObSHERmSwAzTTR609Z+
         Z59zCOZJLrNlseadgrWsLvkd8zdzATWHmK+uxtTLVaJV9LU7FPPpXck0NJ7JbyNF3km/
         F1XdXU6hT2xJQR3CXI0Te/cP7hF1fsvTFcRMymupMrsNsAVsjEg8vlWd7T2vFFCnFc/Z
         P7TkAj0IZMIS84FxgSsm28Y8+w+Uod2nMxVnyxMJDphFrSfQmr1C1DH4YwXbZ7fcuf6p
         iR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170487; x=1729775287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq3teVnFjCQljMHeJKswAqz9sY5geo+xNzpep4xNz44=;
        b=J9eGveoMRxhZEC4V9f04l/u+wy3po2S/LdC+AHp2rJiTbGX1X4DnvOsg10y7ppWW4n
         lZFk2sfe7YdOnaFXkuegoBOH4pgSeCVAtLggmM150FB5jOBGegTMzdWDQ+eGbjK32CFP
         l0sZk2ukaZ4r6/9PdhgXa++SDCzuMa7p6U0YipFo0YZDVaHjNpTo9TGckzsIF0TOyHzU
         eBV9zdjYt2HX4R480C1WUP4tCWWlX4jTPiGX0+hnbK9sc/e+NfB6ID1EkUodXCVuxNiE
         zbfvRT46MqLaVkm3t8YlraoQqMffDnDJIZrYZoPR+ldYafsJRbV5jdwwkaHvZ9DiAdBN
         O7/A==
X-Forwarded-Encrypted: i=1; AJvYcCVOnQIxHuHzaopB7ustqL/Lik3anCHS1R1JvbGYQTeQhUvIGQ9Qr92wuYxjeWMoQpleOyVM9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzY9itliYLqeCL1QPVOFfx5UwFk64Z0GYz7PklEjKkTvK/qjZLp
	p3XrnqdVxqQj2YYXJmEDUJbUGAaii6G53JpBztA7WbwiO2SQeUhe349hiOCB2Gs=
X-Google-Smtp-Source: AGHT+IFIWL+tda1Up3Uym74uSu9HXo+USovi7zkNskhvncDpsDguxTD9i3KfGBRjr2fW7WKmWz8dEg==
X-Received: by 2002:a05:6214:460f:b0:6cb:d558:6f00 with SMTP id 6a1803df08f44-6cc2b8dc70emr135440876d6.29.1729170486776;
        Thu, 17 Oct 2024 06:08:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2299043dsm28134646d6.136.2024.10.17.06.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:08:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1QEX-003tKN-T4;
	Thu, 17 Oct 2024 10:08:05 -0300
Date: Thu, 17 Oct 2024 10:08:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241017130805.GA926121@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
 <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>

On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:

> Yes, you are right
>  I am using SRIOV vf and stall feature, so is_virtfn == true
> 
> Our ACC devices are fake pci endpoint devices which supports stall,
> And they also supports sriov
> 
> So I have to ignore the limitation.

I see, so that is more complicated. 

Lu, what do you think about also checking if the PCI function has PRI
? If not PRI assume the fault is special and doesn't follow PRI rules?

Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
fault?

Jason
