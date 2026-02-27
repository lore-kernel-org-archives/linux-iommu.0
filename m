Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE508261B71
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772226146; cv=none; b=VahdrEM6U+xCg/DWMKeWSjN7BIwxsVaxSq04KcNCot61LJqZAvYR7PWV09jHNL8/YCINIfglHFSCx0Dovph70CURYS5F+96qvhG+ZrGklZB5yriljuPBIaziWDI3FYX8sDtUcbUrFpK488vmWVvEtE7sk659eu03Ng/XbWTYWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772226146; c=relaxed/simple;
	bh=dMaUZ7J6Gnase1ad6aNEBj5E0J3iCuPXIEZCn5Ehmtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0Fq8A4+NTwZeBv/lnfXXtiNGKd2Cuz4mQbjVTqfrV0bgSTmDoO6XxNatN41AkpH3g5/sastD+JamQZ1Z2+05uWAWo9YzDsY5TAIeUci6FGuysaCi3LcaFrFgcpIu31c1UD0Fa5mbTQaSQdSOs6WemvwnIKbS8xU8UQHSj8njL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dj9MgT5V; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dj9MgT5V"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so19955ad.0
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 13:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772226145; x=1772830945; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZresrJtZIiQ6e34UlIzbrUsxenNO/JCWiXnfWRWt66w=;
        b=Dj9MgT5VXwhSC4Wje7vTSe71PxRQJLYsG6rCDagjcSB87dzcSqyh8l1SiQ936+wCoH
         zSOWa4y0K+ua2HP4jGByEJ0e/VU9bz+AyvB3BdkBI4s3rTsDqe036YrRA57n4sO88sJI
         CHF0JjBLBuBJ/YTLVGBe08isXZKPaUpOd3Zpvfw2RkOJQk/hcDGQMwU0J3yKUc+DCAg8
         iafrfz1ge8c5Vbt2nbmTMOEIh19N4z0oQy/joIW9ZNKmxkhcJINEKZir/zGVgRsnDmi4
         792fYSEi+Wq+pjHXB/dFEq5sBtUECnDemP6eWbRJsDlNaP6TxgpqC/QqvMGfUwXci6/Z
         uU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772226145; x=1772830945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZresrJtZIiQ6e34UlIzbrUsxenNO/JCWiXnfWRWt66w=;
        b=faKqMZTlzjDffrVGFPVBtbjLwWpKFzfQTFXdkO6bHqFopXU8HvFZ+I164vHQ6Hk8/V
         gfyQdYubQtZKa/Wor/eLEafvZKIEsouEhXqt/15sgZ+Y8Eepu6xSE97HHeQVl5GXfxM/
         8e3KkQvN6/PF5irSFL8AumcWCpyOAiI5Eu1FK0eLgUr3rJzoqa6zoUpqbRbaLutv2ljm
         f/4LRnrGrCeHxB4cteHr3mRJajwr0IgrEWkoxP4UYCl4cLcPhhhCplp32Qsf7NBOFsfw
         fFSN4A6F98DsAs8nFrG0YMbZTiGtyb/9xquuWdWYds0BwnH9tplV9skhwx3kqaE1bMtg
         bn7A==
X-Gm-Message-State: AOJu0Yz13+W49RYpJ1VddsIC1XAcg8uJNu8yYRJwLtqxkX9PnoTH/m4n
	RNZV3UHCgGqtVf+KwxqWG5UIUwZhbHxdg7gDUefSflVFkuBv5pNMxfu+aCjQ5pzTrw==
X-Gm-Gg: ATEYQzwulre/ZxffTMUBdm9pE4X79gPWUFu+/RpE1Nx603NDqYBSenUNqJTLhpO1xPF
	geY2JR3AdtbWAZ7dGCOmNq6ssIPZanAM7urQSnZszpZS4eWr9QLerCa0qW8o7Js1Xku8N7agjbd
	lOXHVhX1QRHROfW75M78nWIwPleCP5MnqRz0NnKGyWjY8C0T0vEbE5HhjbklziKoYLZcThntLU+
	azsRpXTOvzhNJ9nvGCFrJlmmFJJH35j0bWfoo8lEbcxOYYRXkC79q4Vds8xHw/s21kxUQgddo6U
	lB8YUXxgDuPdLgCduIMBiVQ5epmpEmqrGxjucb0BRzC1BDNiMF4mGGjRtL0PrlIl6Eie3gRWvAV
	P5dnCO5+Y6KMt6jXoFHR0Yzawj5pdVM9mdN1hxyhg2COVazr3uUYGfK0yVg2A70yG2PV6emZfhn
	hyHT1JWyjrN3PtSLpIMonSckCE4ECSfbUvJfsedurVKOEl6Dh3bzENBRUlAlxStA==
X-Received: by 2002:a17:903:4b4f:b0:2ad:6f9b:7819 with SMTP id d9443c01a7336-2ae397c5984mr570825ad.24.1772226144535;
        Fri, 27 Feb 2026 13:02:24 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b0691sm87042495ad.11.2026.02.27.13.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:02:23 -0800 (PST)
Date: Fri, 27 Feb 2026 21:02:20 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, patches@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommupt: Optimize the gather processing for DMA-FQ mode
Message-ID: <vwrkpp2ewff7mw3e7mzmfvrqi3wqobc5wwy4y2vq53ylvteiyf@7lg5lksll32r>
References: <0-v1-37d146e56632+ce4-iommupt_no_gaps_fq_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0-v1-37d146e56632+ce4-iommupt_no_gaps_fq_jgg@nvidia.com>

On Fri, Feb 27, 2026 at 11:27:02AM -0400, Jason Gunthorpe wrote:
>In PT_FEAT_FLUSH_RANGE mode the gather was accumulated but never flushed
>and then the accumulated range was discarded by the dma-iommu code in
>DMA-FQ mode. This is basically optimal.
>
>However for PT_FEAT_FLUSH_RANGE_NO_GAPS the page table would push flushes
>that are redundant with the flush all generated by the DMA-FQ mode.
>
>Disable all range accumulation in the gather, and iommu_pt triggered
>flushing when in iommu_iotlb_gather_queued() indicates it is in DMA-FQ
>mode.
>
>Reported-by: Robin Murphy <robin.murphy@arm.com>
>Closes: https://lore.kernel.org/r/794b6121-b66b-4819-b291-9761ed21cd83@arm.com
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/generic_pt/iommu_pt.h | 27 +++++++++++++++++++--------
> 1 file changed, 19 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>index 3e33fe64feab22..9c08bb594e4173 100644
>--- a/drivers/iommu/generic_pt/iommu_pt.h
>+++ b/drivers/iommu/generic_pt/iommu_pt.h
>@@ -51,16 +51,27 @@ static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
> 		iommu_pages_stop_incoherent_list(free_list,
> 						 iommu_table->iommu_device);
>
>-	if (pt_feature(common, PT_FEAT_FLUSH_RANGE_NO_GAPS) &&
>-	    iommu_iotlb_gather_is_disjoint(iotlb_gather, iova, len)) {
>-		iommu_iotlb_sync(&iommu_table->domain, iotlb_gather);
>-		/*
>-		 * Note that the sync frees the gather's free list, so we must
>-		 * not have any pages on that list that are covered by iova/len
>-		 */
>+	/*
>+	 * If running in DMA-FQ mode then the unmap will be followed by an IOTLB
>+	 * flush all so we need to optimize by never flushing the IOTLB here.
>+	 *
>+	 * For NO_GAPS the user gets to pick if flushing all or doing micro
>+	 * flushes is better for their work load by choosing DMA vs DMA-FQ
>+	 * operation. Drivers should also see shadow_on_flush.
>+	 */
>+	if (!iommu_iotlb_gather_queued(iotlb_gather)) {
>+		if (pt_feature(common, PT_FEAT_FLUSH_RANGE_NO_GAPS) &&
>+		    iommu_iotlb_gather_is_disjoint(iotlb_gather, iova, len)) {
>+			iommu_iotlb_sync(&iommu_table->domain, iotlb_gather);
>+			/*
>+			 * Note that the sync frees the gather's free list, so
>+			 * we must not have any pages on that list that are
>+			 * covered by iova/len
>+			 */
>+		}
>+		iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
> 	}
>
>-	iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
> 	iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
> }
>
>
>base-commit: 851dbe76d47e790db0d6ac5151e7f22be357846a
>-- 
>2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
