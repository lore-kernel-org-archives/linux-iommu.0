Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263251AA797
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383585; cv=none; b=iHZok4/WztLu1f00tjSIN+tpmSBoLaYB1HWY/h8GtV/xyRT0Z51knc4kUTFxlBjWS+UE/2lia4wMAbx3jybj9qelp1ueiDoL1ccOISXsfErLwHCGDs8PKsHCHWFmXmXBa6aLxoX3w3fLnTrPax2TRbNRtTFDWpU3S0gGOmHpx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383585; c=relaxed/simple;
	bh=L8HDnTm3t5UfCzUjApcE3hEgz7xnRCJCpMcVAmSZC+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCF29nP4T3mZmQIp7QoRBRtAS0tPIaEi1tYTUbhy/Hh3zCrg3DIg1kWwD0tqsekACswZnaKl7tTKqhKErvr+dTufwKoM6jSJrlycqHDx5Hhp82kesB6RE2plmbOu8gz8EM8l+39RH42e+y17XRrnfeeNHc7rCuE6abSDKMCO9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mj1Z666l; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mj1Z666l"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b3e37e0d45so7240886d6.1
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383583; x=1777988383; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cP40XfCNqjUZHKaFHTD5m2R9L06qogZbeISGyPC9spA=;
        b=mj1Z666lXbWME4MgYFaWOjbWd5rf0VMqpNvSECGNHul4Clh96AX6zGWx2tuD1EDoe9
         n3YvwC3+BPSn71vT0kk4z+lI72p98QXTPDtibRmqpUox3hXFLd3biDV6u7mtofH3VshX
         +T+BqqMFIODa6NWfPasydd9+j9mGxxtRfzH6ca69zXqyvrfFssg3WQqrjy6TKG10bub6
         vDqDhEZCiRARPH8QboPtkaVrD+8gV8jf/xv9jp4fswHnh+ypeNoQ5+vlMRHmDwBpX4ip
         lU/mjNEzvWztabhr8twgQfz/KMM+FHA2NT0vnxRTPNinEG7Vm3MY/NOm1aFZBwXhRFbP
         eg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383583; x=1777988383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP40XfCNqjUZHKaFHTD5m2R9L06qogZbeISGyPC9spA=;
        b=XzD8ivffryic6zIPb2epKWEJMhX1luLH3BQJ7oDPNp0xpgJDeGXtvzwd9ZAe+PMVmL
         EpasRaEKDHMTvb+rH63jBnBKDqBZdDWBFF2bOro8A1REhSdq3a6s+mBGAM7G1pk1PhZD
         iWjwMTj7E8lFp6CemwTH3PmzHrrghWmpmoMluCzwv3kRnbyt+7hUwk8VJAe+aXWIZ8Ko
         eFU/Dg0dtnoDI3fDxSTae/zZmzgYS0VfjiFsRnyuL9SU92bmZQQzLxvbvcVb9tU/eBpn
         XpOn1RUILHiHcAT+C0SFunwc9E+2LfwnK4E5nY/9oxcALkSmAhz/899mIgD+mPPXHA4s
         SV1w==
X-Forwarded-Encrypted: i=1; AFNElJ/wPa6k2C1sVSklyBT9vyIqA1eSqMYHy+K8uZ2VF/lNWByxFAvHESIZqChA6NsnTreoajrKpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3R3Cci62AqQmVc6QLLXR+9h/NeNTFXukEkINDtpWuDquC7Bb2
	Pn4WtB5MdXTBaZUtYls5MiqEfx9eR0tRFcL09ditKhVoYo4P+qa+kW6qRxXaunST9Cc/6he9gfo
	ucB8dhWg=
X-Gm-Gg: AeBDieurXxk8sgUtp4Iy6ZK52v+A9LyxUxp4mkhXaiQ8Hga9D+QxxucEAU7VfwLwm7u
	Wsm95RjXl5FhMilu0hLuyE7rj9n5NNwmIItb5K/DJVbM7keyEZX6Z8CxvzdZH3LeuE8Gs+wOvJu
	EPtp6zFgfxMSeUYOr85naqQDwoWNf8eVhsEHO3+DEJZdCPqxHyKKX18TOHQBkeYJESvFdij8ZfD
	g3yTc+UTfHw34F0ObivMEKbGtB6DmmsUZ8R7vdUN3FPxfimFgunX5Im81Ce8P1Cb2gzOOD9Mafn
	oc/Ty0WjnFd3VGbLm1SyI90flPB+hL7HJRhfWcK1KlexgF29P0RBwv1XUgcxg9NxEdyffrWNUQs
	YMNa43EjpScPPuaRIJST6g43VbI2OgOgNoR1Z/HQih6QsaBMBO4JzZRMcfRuoOmpjNZi0gUdKp8
	QjbzTX2J44PMkRa/CfYzVybceCV95OedM0PjSftl7Kav6RdpLmF5dyaFjFi56RYg5M36VYUkyD1
	7jsghY7fHuUjny0
X-Received: by 2002:ad4:594d:0:b0:8ae:7146:603d with SMTP id 6a1803df08f44-8b3e2ffa2b5mr47731266d6.13.1777383583207;
        Tue, 28 Apr 2026 06:39:43 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e281bd11sm20759256d6.8.2026.04.28.06.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:39:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHif8-0000000AjUG-0wGD;
	Tue, 28 Apr 2026 10:39:42 -0300
Date: Tue, 28 Apr 2026 10:39:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Zong Li <zong.li@sifive.com>
Subject: Re: [RFC PATCH 11/11] iommu/riscv: support nested iommu for getting
 iommu hardware information
Message-ID: <20260428133942.GI849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-12-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-12-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:59PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Zong Li <zong.li@sifive.com>
> 
> This patch implements .hw_info operation and the related data
> structures for passing the IOMMU hardware capabilities for iommufd.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c  | 19 +++++++++++++++++++
>  include/uapi/linux/iommufd.h | 18 ++++++++++++++++++
>  2 files changed, 37 insertions(+)

This has nothing to do with dirty tracking. It should go with a series
introducing viommu.

Jason
