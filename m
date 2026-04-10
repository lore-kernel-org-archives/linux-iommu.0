Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F813A7842
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829098; cv=none; b=KE3Xg/xvsZ/TSBolTsjqxXJ1ww9hmHZtGHLbt+qULuFdes7ygm5ieN9p2bUSWownwZGwDWgfW6twcrRYHEpp/g0QYz8LsDulZ8jb1Hi4jFIdFkLufLdUr8PK5ZtZpY9z0rIOtRbG23YB7h9pVPqMv4qsXqvDd46oRnv4orHnQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829098; c=relaxed/simple;
	bh=O1/1iGPeFxkiNwtNKXgPqUazZGcSIykQmiesHZQPz8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTu92Aoz0EImGY3CixM9DoqfTEGZTsunYtzNDSIEJiPOyKyepXeLNtRjOzyNkjhClZaT3e7kt1xAmuBoKJV85657bnLfR605Z08WIskkhsTE9+FLMGnJTkVogybWkGL8IQgByantrlpZ+35A/nBVLamUum6wxx8fVCdh+fE6oBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QbOeiCAe; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QbOeiCAe"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a093c784b0so26735116d6.3
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775829096; x=1776433896; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rjHMd7udH2co2NdrO+T+4XZB1IgcQV0KCt3Z2nuK+g=;
        b=QbOeiCAeNL/hy0B11aG3jENV7eWOtU9mDiSCIST7aC+7ebhnGFVRUhQcCjv984Y6P0
         lXKbfF6UJRj1oAVBXdil4zHSWnoFDj6In18osoXbNtLJZioxDHKqjiuTj8ku9ekjHW3f
         9PhCLiFIOIiRuVI0+t2WrxwzxbgFj0ibSJljhrwmCutVOiQHdERuU3yloYQuxfXT37zl
         paGrrgkm2bSbKXLKTIjqRHi+ejdSKoytD95Jl9ZGzJ4scp2/urDlZtnK/jC8V2pITh3V
         GiShmcO2Vkpf9SZ0k2CYE1W9R6hyMHL8g3oass6KgSMVelcUtvwVWjcd6Y82da4lSyAe
         yeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775829096; x=1776433896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rjHMd7udH2co2NdrO+T+4XZB1IgcQV0KCt3Z2nuK+g=;
        b=N1nH39liayJqEHyh+cAyMoUvMYTWH9Fp2nme/hVQIaMdxHcZ14rFGEKJeem93myxXy
         TH9Eiv03+y4c4gOCtNJBPgD+w9Js6aKiJ1cDm+iCL0gtJGoATm7Lgy3oh74IlxN3Kc+U
         lfP+ecRz+HUGa6DHOUIxvPHz2kNW1/TmDyhjF/5qOEp1DiY06F87bx8dw693kk7DZ0Lj
         4fhHOQ7s28a8f6BtDMMN3VxAv4mfI8porgRf1S8Dyrz56pGbo2aEuMrNvdvJDqzvY3p9
         revCpT7zS65vxyQrS+ryei/rHOY497wO/BjSpLte96eEnE/vazioeS6mCLtq4OwM+eEf
         mdHw==
X-Forwarded-Encrypted: i=1; AJvYcCXJWzfwAFOZ1TJvJrxhszAk6iXJH/JbI/DqscsZYPqneOd7cTfalU04pSqSBsRKqfMQB/Pl9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDIf6RFIM06ZStNwhVSpG6CHPbHppygA/Yt7dwte8+/WCmCcnU
	w4a3qcFSFnaourzh2jYqOcYDLaqqWOuokmS8V5AOz9fMaybfBAuqMwBS5zifr7xCkuk=
X-Gm-Gg: AeBDievs3Rtx+KxpYMMA4334WyN+dtnQg7Z+gOo6jP6RajUpBI+6PsHI+GVxtKSvKsL
	U+NEeYbDNUYuvk6frt/lT+qDqaRCmAcAVrt3W0ZYFU7Mp9t7glRJvLDylFVvgUvCU1FyIWnSeUr
	mwUT6W/+Wm4D7sUrZ0DzW/zRYhO0rkH9lU3JqCf9bux89R6iySwtajHglhrGAkSHowLhBlofJ6R
	nGUF8R1tb806RD9yfVWosl5kqDBusigJM+vwjomS6K8dLcp76MezrKlgrhVyWIVTPEg4SiiYgmY
	dhKxFa478UESNpWaDgKbhKrmwacfjrNVEsBSp8h48NRhO9Dqk6MXar3exzvyAwginNP0ESOJVLw
	a0tU0YOJNfvRT8F8qvyx4UhJS2u89B7234oIx5+Yaih6PCIkepfimeMvI80FtTWX+HcxssgDD1i
	AICLiTM9JtWX5uTKPZ+KEqpwNre9aIdk5fzJg5vwVLiuLIfaUHj8bPREEXgLNLFDJGlza9LQ==
X-Received: by 2002:a05:6214:20a1:b0:895:498e:e9dd with SMTP id 6a1803df08f44-8ac86155e92mr44076496d6.2.1775829095763;
        Fri, 10 Apr 2026 06:51:35 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84cc9b8esm22948046d6.41.2026.04.10.06.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:51:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBCGj-0000000EEOS-49Ri;
	Fri, 10 Apr 2026 10:51:33 -0300
Date: Fri, 10 Apr 2026 10:51:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <20260410135133.GT2551565@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
 <abHZdOKyLmmmHADz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abHZdOKyLmmmHADz@google.com>

On Wed, Mar 11, 2026 at 09:07:00PM +0000, Pranjal Shrivastava wrote:
> > +	if (!obj)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&obj->lock);
> > +	BUG_ON(!kho_restore_folio(argp->data));
> 
> The use of BUG_ON in new code is heavily discouraged [1].
> If KHO can't restore the folio for whatever reason, we can be treat it
> as a corruption of the handover data. I believe crashing the kernel for
> it would be an overkill? 

There should not be any new BUG_ON's added at least they need some
better wrapper function or design so they are not in end-users like
this.

But these cases need to fail by preventing the kernel from leaving the
initial safe boot memory space (ie it is going to crash anyhow). If we
can't recover things then we can't guarentee memory is not being
scribbled on and we can't use it.

This is the general logic why these are made very fatal.

Jason
