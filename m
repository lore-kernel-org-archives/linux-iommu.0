Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4347F2F7
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350924; cv=none; b=J11wcNGfR5IietCKexGsnn96jWQ0sJN9Ho4fXYKjyKJnrxWI7Or5Z7WZ+gpZwb5cJ/cwjuXnHRCzgOpvGyzwqmt3k5oVPpXtWSThHqPrM7FmUWxaxyxnNwcQVvZmg3iQLeYof2dDtyIxCr1w4RztE30/vlDBVXPWmzrG5fk7fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350924; c=relaxed/simple;
	bh=hEgKcI0xSVAo+OQaZ6TD8YxlJUNtrHvb4B26iG5AXFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwCM/waC8F3sP7EyQj5+zszrteBqTRg4FPgYq3E7a3aBZL1f9f9nJ0hl9SdYlWZE02PpPCXwHKDN3uWK9wjgjU3bzKyWRChbD2IOJ24oFkdAwPeDjt5kiAHSVhPwKlx+DqkqXIy2Sy70adbwVGvrZiLa1uG4gdcazCqktOjJaWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Gz2hcbsg; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gz2hcbsg"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52e2d1bdbc0so6519691cf.0
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788350914; x=1788955714; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=puJ4uTbfv83ic1yzfkUg8CloAoVj8WRg32Yh9dx02hk=;
        b=Gz2hcbsgT0llNqM7FQlnU5UUCehB7WcyOtLw5oqio2SH1Xln4LxtdysL8Hj6nAzJoZ
         ked7EFIbHgXTB9wHDNTEdoi0fzx3aSqbY5Co2InQLfmXalKOoGCOAU5K0vbnzJ65prKk
         DoVnvj9KObGD8YaKb2S6D558OHyFYFkfu1t4gDf37+zChwKYKUVSz5VB3gDQ57nAwYir
         Co+yKdl9ywkrnTqKYigyUKe2jvk73/nwldoMQMaOiedlpFg1bnrpakuzhnJPlxtcy1GT
         CQtkqyb3LBEsYR0Sam0EXyyuzK7vcie9EAZ5r5ml4j3s2SaKMQIgskozTUFeZFgNP97j
         5R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788350914; x=1788955714;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puJ4uTbfv83ic1yzfkUg8CloAoVj8WRg32Yh9dx02hk=;
        b=KXJRNAqTpbiI2E288gYFUJ+c6O2lzEa7BaloaonlVNw79qKHe50u11vDessfN1BKlx
         khOSzaPl+k2UKvysVyrNOAWyaU/I6yQDOi/JBv1+qzFNLADyn9SK82i28/7ZwRwiY4x5
         NMRu4fPO5Hqfcmgrall4yhg6QZ81rA1gagrqjkWOYNg4XXePOv/r2uaydzrNxajUhaA8
         2YaRpNdhRw4H2+gI5HR1X4srLQZSrnLGZsaeXAQV161TT3TbXLbUoH4OZJbLeGLgtW5Z
         cDeZnos0r2e5dXgFTh+CbTjrgi0PZXhxmmH1eMw5F1yqi3zUBmt16VjKvaVywjsH+UpS
         +/Fw==
X-Forwarded-Encrypted: i=1; AHgh+RrP6FH9TRtMO/nGkEWilkmP+TppoZYQUrkSU21BV7rx64oQK4EXbJzeuMO+jkoE2Js3NNw0ZQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mQ3/DEKO0LL18NRv5dY+8bAyklZHBQDSRzPCDfokDuitrpKKv6
	7rIWiap+9HnoY5qK9I8r3EVWo+i8fZM3YVfbnNZ+y8qyJnXAJoUN93TUtTwDmrgxL2A=
X-Gm-Gg: AR+sD130ya+ycdsDrpO+5SfN7nZhVxKKWita8xOAKrw0vOcKi7bNCNAVAS7Rjmf6wIy
	oOXDOoEqQcpqHHR7I05RqGXj75rhjplrNCE2m4NY1m89FTQOww/KzH7d2WGl8hY+ddeT0t73+HF
	lG5okQvRvyOP7HGD+zlhEUysHdAIJYBzASrTasFZYA3k4VwHiWXrwk/n/o+jmbCF/KRbnRffBT/
	CwrB3Vx1tfYpuUFOb0s73KhQT+ptvenjv2Cu3uSBc0dMdMNu3fIn0ZDwE+fvfvLF4Cawn+3fTlG
	Gl383KdPmP/5lLVTLiuOhJi5Sz56fhcRBu9CdiWjAFqnOePgYWs0oO0WvdvEoA59vv4PbqJlVqA
	n6c7aG1l/v0ovB1AzhJ0VLVeIzrjO8tq2PG7IQ15MiAhIUCoYKuGXdDV/upKoK3amHbGD8UpPF2
	QVpVxdv0difXjkCYe51+89HlXiS14UGsT0XPxWgwFEcUydfPrjB+Uj2tlprPSsuTlX68vMBQ1Tj
	B7lU4N6+vuZa+Wfql8AXEJGPEupt0YRVutafItVAamRxfIagFjnVcLQ
X-Received: by 2002:a05:622a:1452:b0:52d:9c11:8937 with SMTP id d75a77b69052e-53036cc0d8amr38235061cf.26.1788350913894;
        Wed, 02 Sep 2026 05:08:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff4e90sm17442101cf.2.2026.09.02.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:08:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x1jlY-0000000E9vh-1aE2;
	Wed, 02 Sep 2026 09:08:32 -0300
Date: Wed, 2 Sep 2026 09:08:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hu <dhu@x6u.co>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, alex@shazbot.org,
	ankita@nvidia.com, chriscli@google.com,
	david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, jmoroni@google.com, kevin.tian@intel.com,
	kpberry@google.com, leon@kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	nicolinc@nvidia.com, praan@google.com, sashiko-bot@kernel.org,
	stable@vger.kernel.org, viursachi@google.com, xuehaohu@google.com,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260902120832.GB2890729@ziepe.ca>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <20260901170849.4052816-3-dhu@x6u.co>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901170849.4052816-3-dhu@x6u.co>

On Tue, Sep 01, 2026 at 05:08:49PM +0000, David Hu wrote:
> From: David Hu <xuehaohu@google.com>
> 
> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.

This patch is fine, but pedenatically a scatterlist's entry limit
should be bounded to dma_get_max_seg_size(), though I don't think it
helps this. Operating scatterlists at the size limits has proven
problematic in a number of places already...

> In addition, a non-page-aligned sgl length will trigger an edge case
> in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> buffers, we will have a `va` with lowest bit set to 1. That will lead
> to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> to find best page size for the mapping on the NIC side.

That's an IB side bug, the newer logic that joins adjacent SGLs should
have avoided it?

Jason
