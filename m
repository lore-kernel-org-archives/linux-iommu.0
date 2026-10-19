Received: from enforcer.machelett.com (enforcer.machelett.com [85.25.207.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E64D5979
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.25.207.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406802; cv=none; b=QTmd9H8Sw6OKlN+1Ty1GuCeNow607ye76XAyInw2hO2CNa5nfp8tbtzB5qSP896sBFZ/D829t3YbIAGtvppBhi5RseoZPU5AH3Oz1YT1dt/fbDx3WM2NAgQ3CKhaKOSgNrelyAlfD85tr9peWC1H5RarMQRV2M+UvLMNwQ9hO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406802; c=relaxed/simple;
	bh=1jlM7l2FJXdvCom8YqW1fUt0PpZTx0lCuVbsAXI37nU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rR2y0uRxSbgtpbVLDvMeANn7u+whVqTlsuE1mdj0JiMB8kCGstksJguH2y+QmEs4Hf4wqIYiDyFqPj1o7VqDIhqnv85UCujhGwVORobemSBPmbR4qGREFTss8c7JsBi/yDOFU7E2Rc11ab+4waVOXwnQR513ppKtkSwk3DpjYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=machelett.com; spf=pass smtp.mailfrom=machelett.com; dkim=pass (1024-bit key) header.d=machelett.com header.i=@machelett.com header.b=MQIXcsyN; arc=none smtp.client-ip=85.25.207.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=machelett.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machelett.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=machelett.com header.i=@machelett.com header.b="MQIXcsyN"
Received: from localhost (localhost [127.0.0.1])
	by enforcer.machelett.com (Postfix) with ESMTP id 06A6A3900AA0;
	Mon, 19 Oct 2026 12:46:24 +0200 (CEST)
X-Virus-Scanned: Debian amavis at machelett.com
Received: from enforcer.machelett.com ([127.0.0.1])
 by localhost (enforcer.machelett.com [127.0.0.1]) (amavis, port 10024)
 with LMTP id m8LrBqmJkQ8L; Mon, 19 Oct 2026 12:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machelett.com;
	s=mail; t=1792406783;
	bh=dC+wPEPavM/pYIdlybtY3Rj3Be8U1e5yjA+U4KdezT0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=MQIXcsyNaAmgjvM/9FCmTQ3ukFLBLEL/HsCGokumBOFacfhAGhaCvo56y4Jv647rF
	 ukth+odQaixvw24QyAuDDoX1CnYbLBXp7Sa3BwClz/IguXNcyixargpRGlVptOQhXv
	 tChX+5HsqoDAcXGSEeGsO3fvPw4m/NUm9/Vca5vg=
Received: from RAIDER (ip-037-049-016-046.um09.pools.vodafone-ip.de [37.49.16.46])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by enforcer.machelett.com (Postfix) with ESMTPSA id A3FCD3900174;
	Mon, 19 Oct 2026 12:46:23 +0200 (CEST)
From: "Renato Machelett" <renato@machelett.com>
To: "'Baolu Lu'" <baolu.lu@linux.intel.com>
Cc: <robin.murphy@arm.com>,
	<joro@8bytes.org>,
	<iommu@lists.linux.dev>,
	<kernel-team@lists.ubuntu.com>
References: <02b201dd5ea3$02b88430$08298c90$@machelett.com> <ea131a99-d3f0-4d52-a076-d80d84d690e8@linux.intel.com>
In-Reply-To: <ea131a99-d3f0-4d52-a076-d80d84d690e8@linux.intel.com>
Subject: RE: iommu/dma: SATA RMRR reservation omission in shared group on HP Gen8
Date: Mon, 19 Oct 2026 12:46:23 +0200
Organization: Machelett Software & Consulting
Message-ID: <034b01dd5fb7$159f53c0$40ddfb40$@machelett.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL3rCQ/ffDLjWMz8A82jwqZSWah8AGj2rRXtMLTYPA=
Content-Language: en-de

On 10/19/2026, Baolu Lu wrote:
> The early return is still there. Have you tried reserving the second
> device's RMRR in the IOVA allocator as well? Something like:
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 68ee57800fef..e9b39009f109 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -704,7 +704,7 @@ static int iommu_dma_init_domain(struct =
iommu_domain *domain, struct device *dev
>                          return -EFAULT;
>                  }
>
> -               return 0;
> +               return iova_reserve_iommu_regions(dev, domain);
>          }
>
>          init_iova_domain(iovad, 1UL << order, base_pfn);
>
> This would at least confirm your analysis.

Hi Baolu,

I have not tested a patched kernel because this is a production server.

In the October 2024 thread, Jerry Snitselaar proposed the equivalent
change, and Robin Murphy pointed out why calling
iova_reserve_iommu_regions() in the already-initialized branch is unsafe
as a general fix (https://lkml.iu.edu/2411.1/00575.html):

> It's also possible for the second device to get here after the first
> device has already started using the domain, so at that point it's no
> longer safe to use reserve_iova() due to how it merges overlapping and
> adjacent rbtree nodes, which could really screw things up once there
> are normal allocations in the tree as well.

Best regards,
Renato

