Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140A53373
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963269; cv=none; b=OISIJcGpE3aGLF7gDBNUW3yRHvMLX96h2F3c5BOcsltQ9VAsl7YbJPaYMF7o4zPfvQGFTzAnB6COp3J1m8rcAwcTGRisDW3h/kywz1WeYza2lnh2mYt8M5roAgjneXscclfF3hahBGBqfyEj+f7phu9veDjJNMURJ9/yn90BKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963269; c=relaxed/simple;
	bh=wYfaWsh6Sn8wwLS9gnk0eyrAgYMx+qgcYiLYh20Su9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU2aVlVPLt0jXq1jZGL7tBc+1ObxCWoRLQSmfrXIgKjHtDHkS5WpXPYAd7aieJgGM7qTcxXuaIN7WJdBdyuHrLSL+AlunRHpP551CYYhQf7ag8tlLdoXWbtYKTuOmRHdpUoX+KUy2tkpXIiKImtg3S67G3HnwsGwJBdTg+whhF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HHiIETNE; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HHiIETNE"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44f6700addcso3804291cf.2
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722963267; x=1723568067; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAtE3NrwvMQADtEx9/Wu95vxDu4saq6pM1UUIbdCnAA=;
        b=HHiIETNEIHNDDHhi9kPrBzmVWi0hNmYVRh921aMJp2QXweSUeNC0WNACEDRIap8dQK
         LiaiX0V230H+ohzKT7ysmFhv2gfJLGaKI6RPy8oPCOjaiBw+W3gOPO0XCZ/gdUCtQSaN
         vqtxgeqi71vuBXsbzHR51W3HEkTM5AbUJ9EDHLy5egBle3ClPcUtIR0DFeTQGohsINtp
         hCl35VunOo+ts0ZWzEarseLBmj/slx3p6L+TExRJ9LhW0EU747+Oy5osj0QVyCXlYHQN
         jfNEMUH+d8oQdQB6X4mg8GCSL87rThRoVKi8AyYAyaBsuPvQylv/r3AqvXgGy7JgJoFh
         S9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963267; x=1723568067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAtE3NrwvMQADtEx9/Wu95vxDu4saq6pM1UUIbdCnAA=;
        b=U6lIN9CKKxbmqyJlWXl1fonKZC6p9iTeWFxjLCAdtxiaAqPDTXyhtQZ1T1E1RrFUVZ
         cABhv0PdAUl1nPWpRVLWvnxl74537T2nVP6UORd4+DVj/zKhtH0s2bMKH2YSah3NzT0C
         TSYYfU/jr1NtCve+0yl5rL2BUl/SUl5dpKHiV88eaPNgXfRSd6YYvgZrEMEer4ATc/eP
         URO2XfV2EbeHJDe1tYTE+elU3UmIEGqdWjckO2ODBI3wMunL6S0K5fKCz6yKjxhYU5Ul
         J2q6Qzn/mLSUnKObO+Jlp4nNBSb7ismYOP/A3W0VgTKAuvSJ4Vx5TZoYB9knx4y82wkB
         v+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUba1loixP5oYvaJrUBPeISO6ZBbNCE3Z5Nd47KceOpd7HagG9Lw7i6iJ5JXEY6Iegs8NmYbMKxXtyUFTRNSmo7eJmw2lk=
X-Gm-Message-State: AOJu0YyBd1iJInFpvx5qkaPO6xnHmr6ApD7qpGI9xQ5ULDz0qWcYusb0
	Hs/lH2Haq9fVcDVN/JQJm8g+JfaSqKygGnRUsNfUbOO0xRManpe7Len8zeRlOlk=
X-Google-Smtp-Source: AGHT+IG7NmK09twXabrf/broQ0lPcxWf11duxdRdIzqDmUxQ0A445hpYQ9qMVh5SqopGRWRDeernQQ==
X-Received: by 2002:a05:6214:4586:b0:6b0:7d80:38b9 with SMTP id 6a1803df08f44-6bb983d0e04mr201635916d6.16.1722963266718;
        Tue, 06 Aug 2024 09:54:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c87bb90sm48302166d6.130.2024.08.06.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:54:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNS5-00FQVe-PN;
	Tue, 06 Aug 2024 13:54:25 -0300
Date: Tue, 6 Aug 2024 13:54:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] iommu/vt-d: Require DMA domain if hardware not
 support passthrough
Message-ID: <20240806165425.GJ676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-2-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:35AM +0800, Lu Baolu wrote:
> The iommu core defines the def_domain_type callback to query the iommu
> driver about hardware capability and quirks. The iommu driver should
> declare IOMMU_DOMAIN_DMA requirement for hardware lacking pass-through
> capability.
> 
> Earlier VT-d hardware implementations did not support pass-through
> translation mode. The iommu driver relied on a paging domain with all
> physical system memory addresses identically mapped to the same IOVA
> to simulate pass-through translation before the def_domain_type was
> introduced and it has been kept until now. It's time to adjust it now
> to make the Intel iommu driver follow the def_domain_type semantics.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
