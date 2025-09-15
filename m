Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BECB27F74B
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953695; cv=none; b=jREGAuoSzR59T0QNY6A36e+lq0ixVPbErlsE7koRKVfi7gCuaOrLN9ddlhesFlQedkJuy5hl9uzdaP7zA82wlR8S/bNZtYOYbNG/nWU5pO6BsXezAp22LlOFzqvlopteceWI8sbpE4ARmwM71gcAJcWN90U6VuK3387MuMFxkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953695; c=relaxed/simple;
	bh=12n9Pb+yXcwNFTqQGEMETuHrAQlt2tUiKpfSOPcrC3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro/zSjHKC5VltnPlAQ1EuSMZ7I3fbYi0hq3quZ3KIMxD1jf8SkNYmDZc9eymFv5EEd2LltHdM68K8GvImn2SHth8leW+I4sfaOb1vYB0bbuTHF0ezkGb5Lz0HammH0nNjHxyiaR2N3xe91V8hifiGhU4OcB9bi6WtAAK0vuXBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XNTuNo2B; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XNTuNo2B"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-765936cbdfeso41092666d6.0
        for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757953692; x=1758558492; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vDAemr4/lmLhb7KTewKWDzn1cjfqOTzFv/5msg8t3TY=;
        b=XNTuNo2BgkaT70pH91MOtkQ/U5aOi2arANZ3y2UDUIgi4P8jRKG8ovS6kiVWW41QHH
         tqJzCc49s6MUkQ0B+xY0CZ0TMI0Mu5i1GrOI9Dwn9QcsHRTdFRxXjdGQm7FY8Lv/r45P
         nrqlyYSCI4RV/AAKGH5T/pHPYwR7FrKxW0Vs7nGQmIiGlaBK56uJNIIbfy0umLECB4Px
         Ng0NIOYlDsrMRR/k+C7nzAGG5fKibWofsaunN9udB4EA1jwXLAV+/zH+1aDeEQCgKldt
         uOfD9R0agE47CgJk9yM2aiBORKSsACVDGQTBFWTkVczgc8qGEIf2MYV533C00vL2RNsv
         fPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953692; x=1758558492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDAemr4/lmLhb7KTewKWDzn1cjfqOTzFv/5msg8t3TY=;
        b=mhsVkuTnZNCVYJVUwNBayeE+vs/OCwVNaAciN7QenKggKMSi1gpGriq4luozcaswQn
         GIQQVz1x2BFMj0QelDGNJ9Psa815XjHggJpjLFcFHswHz9TZ1Si6G8DBvaKFMbaoCNLP
         B3DlhZwAPnxItczlhdDTJPGfdMOKWjOsRwogYXqezg9Rl41kk7DsBbzuBGAqQg4WJk5g
         5XkCPWEESIdfzd945SHasoLxiwVUjLxHOmQ0HGFsN+3ULcrMWemo4cXrM2ARL1iDixO5
         B0hSZ2WFV33p20idj5FQHNG1a/jTpSXbL14TuKiQyLIjAg2zj7jDue5qV6eCftVTHRgH
         cjmA==
X-Forwarded-Encrypted: i=1; AJvYcCUPmBg/QZdEhZ1aPrBjnRkHw3CwwMFvCZKMBaQi4iHNe06DKJsUWYDBnNlC1/dwZMaZI5gObw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzP/2GT9D8qX6CZ9A7tD0EvIQRWkxrz+Iyov9uWtQIlWrpJr5p0
	zcq3ofzNU6B25Ui9pfU+uB2NlkumhiHUpRUEfiCUnIXcRaLp3xWFay3B1f/DgB2cXyk=
X-Gm-Gg: ASbGncvWfGpGpGNqekSK5k3Y8pxOVqD9EGViCacGKLCa9HTZWkB5EevQzbjM9TeZba1
	/CjdlXxZxvw9g6VEiHXEhtzfxMdvRwuVbz5gOKthOQIrDLXicuiSn8Mv00P71kpNIldrEMKJpmT
	vgKVSqEeS1OwNqoO5FI/mDkYqTdm4XOV7AI1Tm06iU8CTUv4ZcT+DxDBJsNumRRxXRR6b7b7Yvj
	G0NKNVaZpzQTXyWIDFmu6zYIVAmpOMYwe4oThOb0lJ0j/JddZ8qF18giilPuLAxgvfG2gpe0/oL
	fCOpieNyOKx5HHqRXun4SeRPxi13Bazrs2imPPkOoeGXgIBJbcPn1XbOHuX9rzLZabzND9P89RF
	e4SLfv042uzt94y5SAw==
X-Google-Smtp-Source: AGHT+IHXUa+XyZ1S/pis0/NjQwmdYj7V5DxWg4goJxyPrDTodTnzzzbHD2bc6ZPRF/QWzQoUXXlmuQ==
X-Received: by 2002:a05:6214:21e7:b0:784:4f84:22e9 with SMTP id 6a1803df08f44-7844f84232emr43875496d6.18.1757953692165;
        Mon, 15 Sep 2025 09:28:12 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-76e576ee0fcsm55860646d6.69.2025.09.15.09.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:28:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyC3m-00000004TCU-1UNv;
	Mon, 15 Sep 2025 13:28:10 -0300
Date: Mon, 15 Sep 2025 13:28:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	yangyicong@huawei.com, wangzhou1@hisilicon.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 0/2] iommu: Add io_ptdump debug interface for iommu
Message-ID: <20250915162810.GI882933@ziepe.ca>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
 <20250902161028.GC184112@ziepe.ca>
 <f2720f17-5e81-4f69-aaf5-791b47973178@huawei.com>
 <20250910141547.GD882933@ziepe.ca>
 <bb4c3f0b-06da-46e6-9769-efe3dc00e9fb@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb4c3f0b-06da-46e6-9769-efe3dc00e9fb@huawei.com>

On Thu, Sep 11, 2025 at 10:08:55PM +0800, Qinxin Xia wrote:
> 
> 
> On 2025/9/10 22:15:47, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Wed, Sep 10, 2025 at 11:20:08AM +0800, Qinxin Xia wrote:
> > > Ok, I see, my colleague Wang Zhou also released a version of io_ptdump
> > > a long time ago, which is implemented in smmu debugfs. Will recommends that
> > > io_ptdump be implemented in a way similar to CPU page table dump. Using
> > > debugfs to expose the data and using format-specific callbacks to implement
> > > specific data dumps, I'll talk to him about this as well.
> > 
> > I feel we should have a iommu subsystem debugfs and per-iommu_domain
> > directories to dump the page tables.
> > 
> > The smmu debugfs can report what iommu_domains each STE/CD is
> > referencing.
> > 
> > This also needs RCU freeing of page table levels as a locking
> > strategy.
> 
> Thanks, I'll add RCU in the next version, but there's some
> confusion,

Please don't, RCU is quite complicated, I don't really want to see
attempts to retrofit it into the existing page table code. This is why
I've said debugging like this needs to go along with the new iommu pt
work to consolidate the page table code.

> Do you
> mean to create a directory for each domain? like：
> 
> /sys/kernel/debug/io_page_tables/domain_xxxx (xxxx=domain addr)

Something like this could be a reasonable option.

> tree domain_xxxx like:
> domain_xxxx
> └── group x
> │ └── device

Though I would probably not include this information..

> └── DebugFS file: /sys/kernel/debug/io_page_tables
> └── Operation: Reading this file triggers the entire debug information
> collection process

I don't think we want to dump every page table in the system in one
file.

> Do you mean that the interface in io-pgtable-arm.c is directly invoked
> during the process of obtaining page table information without passing
> through arm-smmu-v3.c?

Yes, this is what iommu pt brings.

Jason
