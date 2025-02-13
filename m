Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF124291D
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470139; cv=none; b=nqehag12f+oqJUylrOTUdoXmM00JoIpgxkJwuIqkdbt+/7A7Rlx78/OK24/D+gQMCSWlhhLz40B2b6dlB7/VyzRm00EpoIdNQ0HZW1mvX9p7D/ezPel7QIGfAF7VOAdwudrhS4fpeW263n4oA0vZ6H5XkiGVrAfPgNNzAUfJBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470139; c=relaxed/simple;
	bh=d0kEcihBGsGD5nDyvWyTxRr8mW/Cnur/oqUPU7wQLd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctK+LWetxtyQQ3MmJx3h2h3argShesybT1UR7RG2q1emFzygSRBeaKO7gPUgjrKLRSoi8HxTuk7M1qVUPORPbsiDeRSpvycOa/92ccn+2jh7g+ycQbebL09jNHuoU2uhrVobRv7yXR3mdnHgEX9/vPBo3iGmYeUaBL/lxua9TpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MkN61CqB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkN61CqB"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so29381f8f.2
        for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739470135; x=1740074935; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjhyPWW7IENWta5YWXnWXfdvibFoyaw+P8ehIpKlekY=;
        b=MkN61CqBaMFCT7atWsBuuWNfk8XVPrALwhO5MmUq4Pw2Zn4zexfCmErTKMQtwFnRcn
         5mfL45mrgtspniq6i2f0AwXGXhIKxA4wDyc869qtX1F9WWF/W0Vo3A+/w6Nb7Jdz1foZ
         BeWuNzOh/g8rGSSLi5rUdEe+p19FvZOZcfidnszKg6LkiAgpDmn6pxNnl1CfXlgVJ1ad
         mGtHupVOrkrPvr9+npTrV3HOZETLHFfEVE32AkJqTHuBbFyoN2OVnaigVN5ozcbOl+bC
         5khZVB1VotpAj4rSkwWWBL4knraUGeMnarDVOSXiUE3/SDt2hSN2vt/O1Oi6sdGFErPt
         db6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470135; x=1740074935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjhyPWW7IENWta5YWXnWXfdvibFoyaw+P8ehIpKlekY=;
        b=lFzPuK4NLiRwn7fpAfna0gioZDwo19vGS8kJGxXueVI8JFKVaOR6oj4+OeeCbdn4mW
         m//tEANxPDtBfJ18QVuPAaHiRFSe5qnO8NKlkEVZXRy/wfdNk0h/Z9EqDk2POWfBz9fu
         pNjScV+OxB/kATYiUFpDIBWRAiRg2CleFljTSTG8GttAVue+0Zb90osXGZf2M81VvtEj
         E/07SkXB2FPVSRHf07F5rkZbQSh72E9LmkAzfnf+3TwWunE9W67RTZezdzNy1rnHWiyR
         MKY18QsHMQ9VM7UxayBgSkmS2XRyJsW356ByGe6TsuQYxmfD/CbRnOQoh45vQXsyvDR/
         2KTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBiK/7kG4nnsY4bCn1vE27SqFoN4yVlxE8minTEmEfz/cUmaXHyzdcT5EMIbZUKP9t2EwLxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLgJTLLV9ToDDYFuXrtYhTs2wjAI1JXdCJp8od1x/f520GOy40
	B5eXV43QoJj4AxF9symBGW0Jl+oqkTrqxM8iqNeZxq4t4Tb6c2NcnOeViPZqoLk=
X-Gm-Gg: ASbGncs8Yl7ink+7lbDJpWBbVkljI82I2+afZPfS9B5eF3+vRYCU4KDJ5z5q3XaJGBw
	JB1QlPdXfk/aR7zdgEivR1Xsm/h0TsGn4OErtrrBcx9e6y4crYWoQRM3eES4fvrUkCS1XiAmR1J
	t7RfYozgla9Th+bWgBW+9p8M4tvf7W2vkI8C6ZTxVTuzhHnte9icpmf10sM+q7fzllQbBy6vg6Y
	TmnGEicCoO23ECzHlQ4fPMge+ls6x22qGeR/VP/4JQbwzD/mGg+FWzx49edl9uvaL0w0eK4IrjS
	xLU7NeU6j+jrnQ==
X-Google-Smtp-Source: AGHT+IHBorq/0LkWz12FFQh6I+j1iy+1Q+ZmebH36eKHS+Am0JM2CGK6dnXP/JraGzsTpnKadO9LAw==
X-Received: by 2002:a05:6000:2cc:b0:38f:2a53:1d78 with SMTP id ffacd0b85a97d-38f2a531dbbmr2040183f8f.10.1739470135465;
        Thu, 13 Feb 2025 10:08:55 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618a9970sm23843215e9.33.2025.02.13.10.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:08:54 -0800 (PST)
Date: Thu, 13 Feb 2025 18:09:19 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	"zhangyu1@microsoft.com" <zhangyu1@microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, patches@lists.linux.dev,
	tina.zhang@intel.com
Subject: Re: [PATCH 3/5] iommu/virtio: Move to domain_alloc_paging()
Message-ID: <20250213180919.GC243081@myrica>
References: <0-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <3-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <20250212112235.714b0a14@DESKTOP-0403QTC.>
 <20250212233053.GV3754072@nvidia.com>
 <67ad876d.170a0220.3c21dc.85ceSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250213094601.GA243081@myrica>
 <5irmuy6xwrjsrdjy7tmfzlnotxqdoqagjdsdtqjrrit673zaka@r43nyvc5gcyf>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5irmuy6xwrjsrdjy7tmfzlnotxqdoqagjdsdtqjrrit673zaka@r43nyvc5gcyf>

On Fri, Feb 14, 2025 at 01:03:43AM +0800, Yu Zhang wrote:
> On Thu, Feb 13, 2025 at 09:46:01AM +0000, Jean-Philippe Brucker wrote:
> > Hi Jacob,
> > 
> > On Wed, Feb 12, 2025 at 09:47:23PM -0800, Jacob Pan wrote:
> > > Our code and backend support are still in the early stages, that is why
> > > I am attempting to convert virtio-iommu driver to iommu_pt. Not sure if
> > > anyone has done the QEMU part to support VIRTIO_IOMMU_F_ATTACH_TABLE?
> > > @Jean @Eric Do you know?
> > 
> > As far as I know Tina worked on this most recently:
> > https://github.com/TinaZhangZW/qemu/commits/virtio-iommu/vt-d-pgtable/
> > https://lore.kernel.org/all/20231106071226.9656-1-tina.zhang@intel.com/
> 
> Thanks a lot for this information, Jean.
> IIUC, these patches were trying to add VT-d IO page table support in
> virtio-iommu, but it is not based on Jason's generic PT [1]. Just wondering,
> does anyone have plan to do the incorporation? 

I'm not aware of anyone working on this at the moment. Something you will
need for a portable pviommu is a library that manages PASID tables rather
than page tables [1], because the Arm SMMUv3 arch only support assigning
PASID tables to the guest. Alternatively you could implement opaque PASID
table allocation via host calls, letting the guest allocate GPA space and
the host manage the PASID table, but that idea didn't seem very popular at
the time.

Thanks,
Jean

[1] https://lore.kernel.org/all/20210115121342.15093-1-vivek.gautam@arm.com/
