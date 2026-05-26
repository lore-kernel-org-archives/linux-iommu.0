Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF87372ECC
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809992; cv=none; b=TeyzFM7I3TP2Zqh6h8YAD1b/2Adz5CU0OCV38667bbU5dcdm7/p9pJUSPciIRrdCf8oCBbB80Y4FzqsFDZXS0/5jE6/4ZLdjYeujYLCJI4GJ8APdEhMBNXuPMpQLX+OkrVr20FcpCZM9e8yFl4vES0BZ4PZ6s9nhvAev3fPOmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809992; c=relaxed/simple;
	bh=ItPd3iMhIb7X3YkSIy7+Cw4n/7vOFcAzSgB6r5JqsAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Seuq5ILWzWSVQkpBRzU4/MK586GObJOU+ID9EcigoFTKGPp35LsqwxOJMfGqYZzudP8qbJxkbeHp11KZJy2ecQK/Y0F3hXr8a+d3+TMSwO3HVrW2RD3QdOcFR7JDSnlZ2NXXJo5zPOqIwPZGYiohM2Q96naJQuBCackyd+Dd+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YN4tnjoI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YN4tnjoI"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516cbde40f2so58121431cf.3
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779809990; x=1780414790; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItPd3iMhIb7X3YkSIy7+Cw4n/7vOFcAzSgB6r5JqsAg=;
        b=YN4tnjoIqf20BEH1nUmokEWllLURU1kJWEu3Wdy0cN/cuGpdt5NnC2OnJwdlIEipF3
         XXKLdoJMK4TAEJ44pemPIPCi4Hxxoat5U92FmSh3wLcxz0Hxj4zAwhs1/a82ZZ05PePB
         IEU1vZlADBi3r5HZqwCHc76eafRDPFQ82jGiFrQi5NputYzlRsdUNcqjzvlwQ7EftSXG
         9xOTZ0QDaP57rfFuaUJV8QQsGoWk4HQiDDj9ckDGN0nDwo3DEC7t3wTsfORWs0LYICRp
         f3AhqrP0VJN7fE8nwKszbskR58kY4qX1/NDDp5rD0VUlGrfE6z1GcMpi3wwcSoBaleoW
         tbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809990; x=1780414790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItPd3iMhIb7X3YkSIy7+Cw4n/7vOFcAzSgB6r5JqsAg=;
        b=B9I8eS3GvMVq+Pyk8CEBP9h5mS8OMWy5NvValk7yD1aXygmPM0zgxPgHtrzE2rXuWq
         nSnCmS9lx8qx4zphEMgWn9lfhJ4+qUpBKhe2gQcVghM3nBk2gs6llWAX5wQry1HsLGtN
         xtu55cFNKnqmMCEjAk2+eKw4z2U2T25hSTewC1FmvnckkfxckX1KPL8Rj5nl+QQkT/zc
         JrLLPpwY7k6Uf70oUbyxQnQ+SUZoho9i/7ykWSefoXbr5KX4Jv6ji0LS2hkZpCN31CcW
         tuwKQicsTx+I4dpNPGf6FCcr5jScCtuDKDFlIDQpuU9eJtPr7hIz8vC96YuLC9D0nV8/
         1q/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Ry3gYlgYPSmjLOemEBAXjWjIZTk344qAgD1aiT8cTx3yLHwAbeCJF6NusTK9onIfD29U88Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpNdwnCbPVvA72qJMZ1q+ijS+4tQr7dgoDSl1by4jyWib9GJ8K
	2RuWUCrOaqk1vcjMoaQxrbSlLz1MbsuiTIFvFTLx96DAbScdte1q1ikRgsxhHLhEvNg=
X-Gm-Gg: Acq92OHQF0OhdTVE8Yg11152OArwQjKJKqNJJuGlVJhQWSilh1PDQhv+EW4meIgPCsU
	lZ1qecZq/pWrPKy/zOLwLM/EIbpML0aU8xEQocuTRRrW0/esoh8eD7YPcSf8dqv/NSd+Ntu/VcH
	Ult/VBca+R81oEjx6HY15/ivahbzOra2ZAuYNzsWBP9bfWdIdmj46SoV4bEVBiI5T90G/PXeDy4
	7ZT5HjVdnEyoOiLLgCxIGhbRgB4KJd/+wzzFCcTcpLysvN3EHSsYuxT5/kaujFG86XrZoprSWnZ
	+WoW0dzZk/2N5uwf+7Dr4KxrM98H2mVCuxPNw3o8aoUWnHx3o8ZiwEmDX39uzcUbpkGAaa2dUXd
	3dxcteqTe9qiMye0GMQGbXX/ANERia6lwoh0aD7u34cK74HiQo+WnAAmefcfe6VIk1E+kZlHtky
	rlSq2swvaJrz33ORJUSZs3ycSm3Nvmoenp/joAWTv3v0/VdD1VbnfqypJcwMb7+wt7py59zXWQi
	MUeeg==
X-Received: by 2002:a05:622a:1452:b0:50e:5cc3:6f3a with SMTP id d75a77b69052e-516d45eaf62mr265877421cf.26.1779809990039;
        Tue, 26 May 2026 08:39:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5170c403529sm7414661cf.10.2026.05.26.08.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:39:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wRtsi-0000000DiUf-2t1G;
	Tue, 26 May 2026 12:39:48 -0300
Date: Tue, 26 May 2026 12:39:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v5 10/20] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260526153948.GH2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-11-aneesh.kumar@kernel.org>
 <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, May 26, 2026 at 02:56:57AM +0000, Michael Kelley wrote:

> With this patch removing SWIOTLB_FORCE from four places in
> kernel code, there are no remaining places where it is set.
> The test of SWIOTLB_FORCE could be removed from
> swiotlb_init_remap(), and its definition could be deleted
> from include/linux/swiotlb.h.

That's great! I think it shows this is the right approach!

Jason
