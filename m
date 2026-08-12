Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C943802F
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537840; cv=none; b=rLsda6N9J1C0s6uiqOVr9ICz3b4h2I69j53ePkp+pXKsCT3G1ekmbR+rZ2km7VLZQ1YDmPq1ACipk8K6+4TLQRKC8cj+pD3Lb1ZZoheBLlOC+KMBF7MiygFTr4wRflI4hgzWNCXEdSCsDPpSKY4lVe518kia3vzwRz5r+mN+MrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537840; c=relaxed/simple;
	bh=oPx8rA1LxifIFXbFQU3CUDbGAZuvNtfeA5eTxK6h5cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX594rVIYX3a7/F//EOydbqq9P37UgczRMCv4O1MNsOtIYKGznFduLrcL899S/PjF/L6o0Cr8Rr7Sn3OcDEBOy7nIJylqQFWXL32xzBzGbHBXbleoI5ClsSAL8D3H4bjxCKtiornZ5jsLs6Z+eH1PYspuQKhbO15Ztwu2TYfG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ef3YXt8O; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ef3YXt8O"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9349ad9c857so105820785a.1
        for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786537835; x=1787142635; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xTId/AcxtpBf7EUq04FOwN+m2Ext7rtU8m+LVRU8E1E=;
        b=Ef3YXt8O7gOjRM3T/aevYQeihJSLr2vvwTS5ZHoJaFpRcYRq96HotCE9zd/Y6f3jho
         yT42UInxmncXPg7UG+gv6HRVBME0w0uuuQf3eBbYejDc+n1TTAUrTBSquHOycyqsVODX
         qLAVSNIPEe48lrxmgNfWXpFGsxUvWOaJv6gEmdBMJelRxIev7FCczOQPxRmVxiMfYZ9n
         MWsHJURSgy7mdCnT6bnjBiXN6YBeaoOndemzmx7ueR8OpWbbEHvqF6cBsmoR48IQSB9r
         vU4AQaK0qqVZzWoEztY08PRwMv74bZwQ0DYHhmWfdf5IgONGmcOe/7ZYVVlhCey+B7uS
         dnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537835; x=1787142635;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTId/AcxtpBf7EUq04FOwN+m2Ext7rtU8m+LVRU8E1E=;
        b=ghtHk8ocGE+pJil7jNCkVi/v0WFBLxgouobO9Yf7lMnupJen3r85b1i0bIa6/o4wsr
         sljP7m4jJ6S4Vi0qROMX28LLevpaDNpY9MEoMtGM+7hhFrptOd6Wqr+eVVHFPl57wqNz
         tVgzjG/lY668qo1D2a68wZTUGfYEGRAGl+I6DazHKGrBdVt1dEOPc+OtdYyIgu8mJykZ
         /CABFxj4Yvtc+FKIQ6O+T+lf3o1q0hUDUFrv83dv6QyKzE7W4obZoN9X7UTGz6H+mwlU
         k/Muygohh972tH8EWEh4hlvJP/1AH1IdHnBo6b1eFvPF0eBwcfSeB4U6YM1J3MmDbSlV
         B76A==
X-Forwarded-Encrypted: i=1; AHgh+RoqNcxRqgBKWPa/z/l97dygwJQg65W+fp26UYX00cYj9liD1M64Fk8Q1KJH4rgisydH//qaAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFag+uPsv0wG95WI9jFS5XExHNyTyzDfFq2xxU6EqWj+R1/BET
	osxVn6Xcmm6m2sY76iUM+VUsnl5NcBs4JgY4To0WBhk3ZzPsT+zDhV/bAEt5eQcqLSU=
X-Gm-Gg: AR+sD13k8NlqWWU+SkjRVqURUdaH3FCRaP3DxOtAP0JHqPvTO7AWHy9FBZlJyMt2boQ
	DBRMpOW80Ryi4JtBSln1w6r7gGA1ZfJZpKgyFHX5tnlPV7YQrLrXQlspP6c1BRb1h58B3yKHWUd
	OHsmRec7Ic74b+zsq3AaF+eAlRZyOwU7CpZXXT9yoDtJwEcJH385SL1S+HbDSbADTgrb08ehB0p
	b4pCnTG6Ymn+TD6HDSwag15nxdzGloEZJ41T7lOKOVz5gBzCM8Th1NtBd0ETGptIa7o2fP1z0N8
	TvQ8p7EJD6j4Psk350E5F7vDZ013Brh68P/xpx5kxlUarOjkRUzzihf+iVkdoOl6JdA5RpFMaD/
	14J7GOoa9HFKUq1U7b5e02yjaJfFAhQhj/s7XcEh246ubxlNc0jyT2BBk9mRqJYHhlhMc1jNwG4
	vOuKpJqT+AWxTOc0YJWcritEWkTSKN53DKzDoWKEtEoq6Mocqs
X-Received: by 2002:a05:620a:4013:b0:930:e2ea:2881 with SMTP id af79cd13be357-936b3d940c1mr359405785a.36.1786537834756;
        Wed, 12 Aug 2026 05:30:34 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5f1388fsm117247585a.24.2026.08.12.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:30:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wu86L-000000030Ox-0KWD;
	Wed, 12 Aug 2026 09:30:33 -0300
Date: Wed, 12 Aug 2026 09:30:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org,
	arnd@arndb.de, mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 3/5] iommu/x86: Share the architectural MSI reserved
 range
Message-ID: <20260812123033.GB662699@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-4-zhangyu1@linux.microsoft.com>
 <20260811162124.GK544626@ziepe.ca>
 <obiixds667qdhv5upqdpxmgrvrvp3bl5gfbpingvog2vzbexhg@b7n4fpfbkff5>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <obiixds667qdhv5upqdpxmgrvrvp3bl5gfbpingvog2vzbexhg@b7n4fpfbkff5>

On Wed, Aug 12, 2026 at 04:58:28PM +0800, Yu Zhang wrote:
> Thank you, Jason!
> Do you mean something like below?
> 
> -#define X86_IOMMU_MSI_RANGE_START        0xfee00000
> -#define X86_IOMMU_MSI_RANGE_END          0xfeefffff
> +static inline struct iommu_resv_region *
> +iommu_alloc_resv_x86_msi_region(void)
> +{
> +       return iommu_alloc_resv_region(0xfee00000, SZ_1M, 0,
> +                                      IOMMU_RESV_MSI, GFP_KERNEL);
> +}

Yeah something like that.

Jason
