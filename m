Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBD1D9324
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129241; cv=none; b=rgFj34Pw/QGG8fans5a291zY4idXvOlO7YI+BRAqRpBbimwiNu7ablPDsmwEQlU/877YJSAl7arwg/aNlL8/29Yx0vdxRD9jlnQBUcw0tuR6lBuakfTkq9l0G+mq+5H3EPl+YKQOzCGmoHo3mi968VfgIcCivQuZh+ZQbjAM2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129241; c=relaxed/simple;
	bh=tv7ZmdEVt6Hd2cJJbeVfRGwzT3ZTCpCqOxMtoU3uCrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE3qv01l9Le3KnelbiwNx0tCTzIznnoNaR5vBGP5SBym3/5npkTMsrcXhYu+gMyK47PRVXlQU8Vi5tgo2t627Oem+RG2q7hwcnKFwHV2V5R7Yzc4zhcuLbo7493shtBXgGb8DHOqeAjVexwTsT2C+Z5s2/gQS6g3Kl+4uph8u+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Fznqz4J3; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fznqz4J3"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d18dff41cdso9199396d6.0
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730129238; x=1730734038; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifVc/4b2r1Ftc5kQccZILD37baUzykdlEkygQjm6Ppk=;
        b=Fznqz4J3y0diJ37TwaCZH7GdvTwVEjyPaJMkvn3S/Q8sG6iwVBNHt+ndE2a+68HRe+
         pck/H2YSaK1B31VqWJzj8HtXWkG5T3jVJL4eLjJ4JxofbtzX68Sj2S24NoDfdPAtlWXs
         VM1+pc2XixRNiix6WJOGVBN8cotGiyLiPvj3s2hCoW9PDoTQSJkTeWPrAXIwu0SozWPH
         WRm+OT9Lki5TwuJHxnhqUScN8ICL6h1YA/tekoRG0pE944CoRswgJSD2TqbWuPE5qOgu
         uF9GYeRmn4zjDtoZqKQ078ZBXorbt9PEVqmfyI3KyLa1cK2hONzJyWl7zT1Q7LI9XcKU
         XB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129238; x=1730734038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifVc/4b2r1Ftc5kQccZILD37baUzykdlEkygQjm6Ppk=;
        b=eHGTGyjP3K4SK+reMlcnUtQLGaNHHLOhr8l94TBi4Li5wCwzWStKD9JI9eAeshLHM8
         7cJuR4UV/vBng0uGGkgENT27YZ0zlC1e7+LwcoUQrm8IrUVNKqHaFIXqa7eoaQrRfRWA
         lwbXD9kd3zYRNoSIZ8FIVNAwyE3WXLYUIodre/ZNi5O+1zVzawqiIjKMyvF6uPoiuXYm
         gQu7rmPMRhbuQ6TDAds8jXYitxRftGmiL7Enp6qeba5pIT7AxwZXXJ4ayaEFHC060elN
         OsVxVyYCzR0fyG7O8qvMiLjUmIjoz11fo/svoBJSHD0M9D27NTJGGaQPwObadaUKXaEH
         k0PQ==
X-Gm-Message-State: AOJu0YwTNq2sDXJ3BYwto3HjjL6onZN0TXvfJVpvsVCoG3rEzwQCILyO
	vPzikOxP7yXD4lpA36k098oB3COz8SdbET5ytCiEEv60fBo2+G9dsozSqbhInlM5EQoIp9LcBWD
	u
X-Google-Smtp-Source: AGHT+IH9ZND4qSgjbeRBMboXSdDqGJTBFgq26bH+0k8OaYmmmQfzFagDB/lZHzSI/qmkURu8q1d7yg==
X-Received: by 2002:a05:6214:4408:b0:6cc:1dd9:290 with SMTP id 6a1803df08f44-6d18584d51fmr132477066d6.40.1730129238132;
        Mon, 28 Oct 2024 08:27:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1799fd53dsm33116706d6.96.2024.10.28.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:27:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5ReG-00000000QmH-1t6k;
	Mon, 28 Oct 2024 12:27:16 -0300
Date: Mon, 28 Oct 2024 12:27:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v4 02/12] iommu/amd: Use ida interface to manage
 protection domain ID
Message-ID: <20241028152716.GD20281@ziepe.ca>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
 <20241028113148.5774-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028113148.5774-3-vasant.hegde@amd.com>

On Mon, Oct 28, 2024 at 11:31:38AM +0000, Vasant Hegde wrote:
> Replace custom domain ID allocator with IDA interface.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  6 ++--
>  drivers/iommu/amd/init.c            | 31 ++++------------
>  drivers/iommu/amd/iommu.c           | 55 +++++++++++++----------------
>  3 files changed, 34 insertions(+), 58 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
