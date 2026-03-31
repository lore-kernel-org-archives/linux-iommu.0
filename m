Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610F3F7A8B
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974322; cv=none; b=iNt061Kub+fXZEaDPZE9O2R0eGCgfaMhmHG/FtxRuiDs2pD/wOt4yDeViMzR0E2s8zzR44SXc4H575nbpuxs5D8zGNmzjnI+Ra/4+fF7uJ5FngAETBigKqXhm//kqWSsmoCTfgZQ6hnioZPDLDVxhmzax21fveTPdW3/j4jzOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974322; c=relaxed/simple;
	bh=5t1FqBMRuAaBCjDjDh+ZUpJziqPUYp8Eoc3Ac0ouYOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etP7aG+Dm8BMjl54gKDyf1+ECOSkej0AYzem9V09SsCvL5YX1tnVeen3Lg8str5jFIAuuNpyIvdhJxW/YrgHZzQ9172ewfTWdgc3m0UkpK346faCNE+tvJjtPLd5RNleAdzfvjBktrni2sFu0fR0CeJw/nVq2xW5QwUaI8cOpto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fgRp56t2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fgRp56t2"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfcb045909so734021685a.0
        for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774974319; x=1775579119; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsKEfazYLGr0lh88GcHa3cSE8LWBmMeMFJDl+wqwlHE=;
        b=fgRp56t2Rlf0VJCDkwuPrWee/TwPQubzM5I2/HIxGONKx92e7kgrLHET+7g7/RHRCg
         jIMwU8/HflO/TvHlo/p4Ua5e0FnJkR6Pb0FgAA4VafUK82AirdOx2Smc86Mfxq/8GrRi
         yKnBo2Gta7AY0Zg0ULNeTsSBWaYAOQvR/liXQziC23+2M0ixjdPyChCRTpF4M5TJmfCg
         fZKrg1qi8m8C+RwQTHJps6z4zipJeZk7G8LBXZ0xik8ekekbEbskEeUl3mKB4I4nzcAj
         KTKDaeF+/Jfhg3dEBpSw8BYXxgfXMbF0VhtKfEJGYrpLJLMRjijK8w4ykucToq+DlZsK
         rGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774974319; x=1775579119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsKEfazYLGr0lh88GcHa3cSE8LWBmMeMFJDl+wqwlHE=;
        b=eXo7oPOvMp0AZWj9eevQ+HnyVbAUk0CvPij+O5CkHcZOVblNgrQjcdHbJUuzYtPwK/
         lgxpH2QhMtXzLNyjzk+8yM+hCTh9YP+EI4FBxypPWS0UXAh+YpxNQ+FLydu8tXGV210f
         trFboIF/2HIJT83Zx7uscO2pzOLbF+UxHgVwsiIOgoG6AkGkBYvIZsLCZ9TSMYkSQOX2
         MD5326EDGMfxvtdD663395kCk2VRapkmejzNqekaeEfFTKcBHMaiTowzZt2HSRr76Gcn
         AwuphSbWVFfCw5MUQGSs7+ppNVfSW8O3JjeWbROnXI8oN/msE2eiyC+YYJ6vEAZzours
         IGFQ==
X-Gm-Message-State: AOJu0YyJgGGY+YcZPoGzuam/LCuVuIks7faVFna9Y1dQRnvnujXkynFN
	FwiPfAo6VmuQ08krrGrrGN27WnyayTE38h58z+Ay2pJ4J6FRqxWdo1Y+qjf1POeLoOc=
X-Gm-Gg: ATEYQzyShi9jvgm3bWeZVY8crs9aRj1G3mxJ5ZCyHoirY6EqdLHNhqGcEaVYr4A4DA2
	w+M1bBSbTgWgs+x4EoYz7x9NWm2xaSYA9fiF7+5VtyRAXYocXwe75Q+50c7vpG5Dls7o6jnMZvI
	duVqHVhvbfBdbuOz9cbxf+szoBH1XUF38zgRYJQMyi9K3WJ4ciYiZSvv7sqQD4tgwQnDQV/YIg/
	FJI6tHJ0dUxiiKcCoVW5EdBVVljxT2N+y/5fyG2qAPE/CKOMAT0C15XqviJtufatK1rVMooWht1
	YZvCri0Ptwl/kh5ex4nvHKY18XtrhuJm1Z8aBrj9Kj7GVMN35BOteM/ukBURBmuz3fVVq0PpUE2
	3jA7OUj+n2vk6X2C7ccCOgmTX7mxrAEj1+r4dNjuqRz3HcVl8o+SGEbpUFNb0Sbtmbjnt1KFH17
	wmzL8YIn6EB31qOie5LvaEMmSz2fL9/NJGyJ+62mxlrITtrZFfwFD7hOiqItcWycfYiEDaHQ==
X-Received: by 2002:a05:620a:390c:b0:8cd:8d79:6c6e with SMTP id af79cd13be357-8d1b5c67078mr37101785a.69.1774974319269;
        Tue, 31 Mar 2026 09:25:19 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb7ddsm881241785a.9.2026.03.31.09.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:25:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7bu1-0000000A1cm-2DKX;
	Tue, 31 Mar 2026 13:25:17 -0300
Date: Tue, 31 Mar 2026 13:25:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, baolu.lu@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()
Message-ID: <20260331162517.GJ246076@ziepe.ca>
References: <20260330030755.12856-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330030755.12856-1-zhenzhong.duan@intel.com>

On Sun, Mar 29, 2026 at 11:07:55PM -0400, Zhenzhong Duan wrote:
> copy_from_user() may return number of bytes failed to copy, we should
> not pass over this number to user space to cheat that write() succeed.
> Instead, -EFAULT should be returned.
> 
> Cc: stable@vger.kernel.org
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/eventq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
