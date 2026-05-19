Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0B33AD9C
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207084; cv=none; b=aQPRlOeUCCU+Yhs6r6XbdMNRUBqrxDT9aRdTLbHrqoAeGGkCh84htLg9ll791Q0dgQn/zXTRP3EV19qLh/NKl3uBRK/I3u+TOUaeeWgMjtma4CNXqgl93Ur9j1ZhOKC6VIHqrillisyfUfmUIN9uhvdvFYa7V5snKeq95w3HQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207084; c=relaxed/simple;
	bh=Hz7s4YAFSInfsBqTFwj3w4O7Cn5r1Vqd8t9F59UC66Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqNbI7rSHHgw7g415Sb0nX3p1X7aWnPcrC0EkZqyP/OQ4d/7LFc53EyE6iXa0xqxphWGkWgpzmCkFpL2abD5zEIcZXj3QcFaeaDGL4nmRpYfHbY6Y/4WRM3+0SbYLG07AnJw8WcuL//jMokjFO4yWOgMewUTUkMB8tZdtyepoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Db1m3CKY; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Db1m3CKY"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65dd9b25829so2981266d50.3
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779207082; x=1779811882; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcSuL4+fBcC8SeCa+tlTSs00pii8MZZ+rCZs+NXP3JM=;
        b=Db1m3CKYbkEs5UGFqOoboRI0EQSnv4eNQ2FHsknbjXYjFUBVBgQYm3nA6tj1YJsp4U
         thFVpj6Ix2lJ25Hezs2fyoKaFVDZ0IbLTWGpnjtie/iquspXdecBkP3ogImL+WO9nTht
         36cKqA32YrJ4jTWekbf1a/1ISsL2XHUCG7QS1H569p3sjpBS58zuAwPv6nk2/I0/mdbE
         6U86TZhUrDwwoEJKB6/KnpuIZ1pWz3bsh/tc6i9SVprT0oqP5HkyH8oW5VrO7PEpyLY3
         pCF4KHTf+b/bsVx5c9sVcFqjf2H3EZznKUI5SxByfqrGWSF25JvZJFI8pZ2/kdYNjiN3
         KBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207082; x=1779811882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcSuL4+fBcC8SeCa+tlTSs00pii8MZZ+rCZs+NXP3JM=;
        b=WiuAG6J2BMue2OgYhdImFanJZSqGt8Mbj5e1PgwY3JvHi0c0cz+VXTuW6bNSIBMGQK
         Rc3zJ0fL7i0zlOp3mYOqhq8013nDX0YHJPZa7s0OJYDLJzJGXKGZHk21/wgTvZgspwy9
         yx+lqcAizm4qE4YYxyLSrS4R7bLNh1OSfQeaZBnusn2ucUzPevsEIh3JwGSZj1yDae3h
         OUS2eWlPt5RI0T82sNTtkl57Sov8B6ghB7k8gKEE/ZGYSdKlPrSY0BzDvrT/w8M88FSV
         dtOFjhVVp+Blx3UiFE42EQlC1XPdT5RNkIeZphrpTG3CJ0Uo1ZEaClO//40BeSJ9378x
         6CcQ==
X-Forwarded-Encrypted: i=1; AFNElJ80YzAMjjrtozoPDl+jef65sNetLtxVx3JdyyoWSHoAdzW0w/M91yydAU5CKHyUwbwfetH4nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiPZXBOM3drHBxVaBzvjJ9CKradcalWn5/0IDGLfqRhEIdZ7VN
	I5qK7ANdcb3yxI39TuOh3oNpqpCy4whf11G6q8nWhUaB8gf7vfprG0tQL4T9bq6SaKs=
X-Gm-Gg: Acq92OFsQvxIeAEw6A60Gd6MJSCaRW/CBghSavjqURlZioX4VjC4FmclaGKp9ZNwTac
	bHJl3QrzQhrcA9BpQ9aAFhXJInHNnB+RsRPcNZnxyJ4eFIz/+lOPGasg9/zmCH0Y/p9sHOcE+2F
	qETCkuyB09YI8Eikw7i2JOSHhKzTq6NMhNMvtDK05mjhQH1JIEHC1zA5ViyMMY1qC51ID7MlA5Z
	fWxPVk4MeXtPl2aofgjwpSaNimcDZtYrJvj70F2lzk1DN8uWITK+i9Nakl8v6+Obnpvlcp9n6wV
	64au8is/iXxntp9/e5vGSKftOesp7ZVKu8LEQA7WP+sM72NLMgEB8HpOi7QEJA+lYX1pbJeQh32
	W03jXuq5vNeKPK0+JHkKTm7xzUJQVg4XCKqedjKGBVCPDh2FD5euCaC7hhaoRvctzlLmnGEpWsl
	mS7fLoFsf6NVaIR3j1uASE80IHNakgmJRoy2Rou2ohKMoHWazeHqj/oVwGmyvgvBiWvg0TgNphm
	yZ4gA==
X-Received: by 2002:a05:690e:148b:b0:65e:18a4:3021 with SMTP id 956f58d0204a3-65e22839e72mr21408719d50.52.1779207081601;
        Tue, 19 May 2026 09:11:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36086a61sm95500586d6.4.2026.05.19.09.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:11:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPN2O-0000000FGo6-1YPM;
	Tue, 19 May 2026 13:11:20 -0300
Date: Tue, 19 May 2026 13:11:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260519161120.GO7702@ziepe.ca>
References: <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org>
 <yq5abjebsaid.fsf@kernel.org>
 <20260519152741.GM7702@ziepe.ca>
 <yq5a8q9fs7ud.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a8q9fs7ud.fsf@kernel.org>

On Tue, May 19, 2026 at 09:35:30PM +0530, Aneesh Kumar K.V wrote:
> Yes, that also resulted in simpler and cleaner code.
> 
> swiotlb_tbl_map_single
> 	/*
> 	 * If the physical address is encrypted but the device requires
> 	 * decrypted DMA, use a decrypted io_tlb_mem and update the
> 	 * attributes so the caller knows that a decrypted io_tlb_mem
> 	 * was used.
> 	 */
> 	if (!(*attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> 		*attrs |= DMA_ATTR_CC_SHARED;
> 
> 	if (mem->unencrypted != !!(*attrs & DMA_ATTR_CC_SHARED))
> 		return (phys_addr_t)DMA_MAPPING_ERROR;

Yeah, exactly that is so much clearer now that the mem->unecrypted is
tied directly.

That logic is reversed though, the incoming ATTR_CC doesn't matter for
swiotlb, that is just the source of the memcpy.

/* swiotlb pool is incorrect for this device */
if (mem->unencrypted != force_dma_unencrypted(dev))
    return (phys_addr_t)DMA_MAPPING_ERROR;

/* Force attrs to match the kind of memory in the pool */
if (mem->unencrypted)
     *attrs |= DMA_ATTR_CC_SHARED;
else
     *attrs &= ~DMA_ATTR_CC_SHARED;


Attrs should be forced to whatever memory swiotlb selected.

Jason
