Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F14B374E46
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324307; cv=none; b=H16lXXtI/mRrkQCODU+60Bfo4Fj6tr4ngnU2IoPOwWBOyk64QHFZXWrDJAT/AWSSYn9TbqOkPx6jDfmV7EFVBSWy8kZFYuHvsKs8hNm9nwlViI91LZD3prQpjK5abULLjAAV/tiCWY6+BvOBDj0kk3bR7I2VAk7wMUvy9VmmVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324307; c=relaxed/simple;
	bh=5+eRi2P0IhQkVffVIzXnn4OZsEFB83MX7U5Varec24o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQBFPGQr3AzlYw4mCmFuM2PbcVkahNGi1C2UJgvxcdzEJ0pIZHfA1vD1G3XQWfYqadwFgTGHLCrHQvnkDQaf87qSsIP39Dcm+KeKI3R5bIzEP4Rn2anwkhyInWynXd9YyVaVWO2k/l5Lw7bG+ZDZ5sJGAh6saTdWDKFAbVi440w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xr+RJOTk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xr+RJOTk"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ce65629acaso19507136d6.3
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780324305; x=1780929105; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xvsjMwD/preuv2Qmrdbeq0ug8WdJ2lDONAxR5Koyc4Q=;
        b=Xr+RJOTkReKvLXVphYsqGYlF44DU0FOVglkrtk1XVzdoQtFLir21Woay41fw79MMFy
         dLANSs+JB4ONdRBkAuJXeMm+fx0SlMIBIlm3A5JzCsD1Tuff5Zk0ZpRclDMLr8fMlpNC
         +HjViT/ze2gsxmJWHhFIMhY9ZXSJjEPBbaVgBDlZNMe5DYdUYflxPw803t2z5vYRUrOo
         3JccUgGZVGM662UNUraJACCXF1RuTnkpIls9hVhRwaiXDeKrDPucME7UK7ewdcbAB0ew
         4YTBFyi7fKAEnG7q3HbSX9QXaCmp3jpu1rhhVU5APCCNvo0f2pUYHqH3hBYvkzKy+A08
         FsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324305; x=1780929105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvsjMwD/preuv2Qmrdbeq0ug8WdJ2lDONAxR5Koyc4Q=;
        b=o4hPK1OXtCX5vMpgl87lEYkxQ/Jjk2FeVYOPXpr+m+PA6lhvjuYTLWClmvm+hAkRSU
         Lp24VDhl7o6q+pgsTvZ2errinP/1ufSME4ge26bDiyJkpV0TFaro5OewK3lKpyGIRt0f
         usgWWh0vroB9dysqg0ZHGR8i1xzEDR8accggV9GGlO9zD5cEVZQKIWoY0GjILXIrzbeV
         +gTmovwPoVjMKm6T1g41PJFzRjdM0/83wEbNj7vSfm7Ed4ovI1OkaMBD06DoGT39neiM
         qXrUkP4EUshwfMUh84YBsaY+v+FnO9r/GQICMUzmupzDtMK1YJWLdkHUEnLT2GwgteBo
         pS6g==
X-Forwarded-Encrypted: i=1; AFNElJ9g/5hY9n8jTyvT1N8h3DDoEpzffG+WZccXeZbywWJcv4esvcOPL7xn8mzKwr58WM5E/l7XPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw60rCU0/czhhwzsa7lIVnXlW99mma6FxJuNZj3C+lotvMZRSso
	shFITnTycIqFlCaVRzmSAurZKq63k0JGg/FI5sQ2YmgqPfVXGaprJoblFUMg5UVilOw=
X-Gm-Gg: Acq92OF8jEw9FXCPr//VnOM96rPWTh+sRdFifjq2ZyM28pcUubXFlkQcVECiBUE3BOB
	4tCsWNgO+X0iX0jGxDgCH6S2ZT9JCA6HFE3MzOjVMYNGJe+nHw++cQjwbO5rW5F6vIOmdvlamY2
	GYJfECKbCc45tdHfEwIHApM9wT04jZhFvflrtxrN/0NjvFtLAc7pCjhsRdFD3i0zvE2Ts5eCi9O
	LSLYLuG05AphSeArUgQAtwXdvxuksP6bB/F8LaRBps/vmm9gGevmXXxrKTJxtF2iFUs6C7ikKY4
	zJHLff5CVQc5qHUaZnw9feP11wzt48bIRPJeAVRD63vYb7wnO2cSj3+eynZZ7up5mWPhQiWAjIg
	SS9fGTbPzAHgjnKoQvO3gsMDwvil5Sq0lJTZUQvEAEy1VQ7fx/SS3emRzwdj8x6wyEvMJn5Rukb
	EVrt5qfQodJgVzjRbysUWG4lHNcft/XtGpEsK7m4UHulf5DXJI8jZUB+8oyJtFrAvyeZmazJBWp
	LQcIhMrJl0xhJcL
X-Received: by 2002:a05:6214:2502:b0:8ce:b2e9:a4b9 with SMTP id 6a1803df08f44-8ceb2e9a80cmr38343386d6.12.1780324305009;
        Mon, 01 Jun 2026 07:31:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea064f97sm94142866d6.13.2026.06.01.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:31:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU3g7-00000001mzs-39uT;
	Mon, 01 Jun 2026 11:31:43 -0300
Date: Mon, 1 Jun 2026 11:31:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com,
	alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH 1/9] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260601143143.GZ2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
 <20260531235148.GV2487554@ziepe.ca>
 <a0875d9f-4aed-4164-861c-6fbbdfe04080@linux.alibaba.com>
 <20260601134322.GY2487554@ziepe.ca>
 <ff2a4364-8463-42cb-9a2b-fae1ef64c423@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff2a4364-8463-42cb-9a2b-fae1ef64c423@linux.alibaba.com>

On Mon, Jun 01, 2026 at 10:14:27PM +0800, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/6/1 21:43, Jason Gunthorpe 写道:
> > On Mon, Jun 01, 2026 at 04:41:48PM +0800, guanghuifeng@linux.alibaba.com wrote:
> > > > > +/**
> > > > > + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> > > > > + * @domain: IOMMU domain to query
> > > > > + * @iova: IO virtual address to translate
> > > > > + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> > > > > + *
> > > > > + * Like iommu_iova_to_phys() but additionally returns the page size of the
> > > > > + * PTE mapping at @iova through @mapped_length.
> > > > > + *
> > > > > + * Return: The physical address for the given IOVA, or 0 if no translation.
> > > > > + */
> > > > When introducing the new function I would like to fix this 0 error as
> > > > well, it should return PHYS_MAX for error
> > > Implementations such as arm_smmu_iova_to_phys/DOMAIN_NS(iova_to_phys)
> > > all use a return value of 0 as an invalid state, so 0 is used as the
> > > representation of an invalid state to maintain compatibility.
> > I know, but this bad choice has already caused bugs so if we are
> > changing everything I would prefer we fix it.
> 
> OK, there are a lot of changes in the current commit. This issue will be
> fixed in a subsequent series patch.

If you follow the plan I gave you then introduce the new function
using the new return code and only support it in iommupt, then you can
convert the other drivers to the new function one by one including the
return code.

Jason
