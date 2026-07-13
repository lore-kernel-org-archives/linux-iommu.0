Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F243382F1
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959403; cv=none; b=Xgq/mEnWUOts3qX+7sj97H7CTJTVhYHpFAw+O/DA5RU3L41AIWUy/oGi/OmB0Y1t89dcnl6N/tInNyjmZ/0Gh1ghwT4Gekr/zXyxfsAOMIg8KGjvqM85IdkNEULab4ojCgnRDUwIk0Og0KTg6QVBxPPDvN58mDSXYkAX6YMgS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959403; c=relaxed/simple;
	bh=o/3X8qJfS04d5H4GJiWk4LFrZzJZM/gUAGPj9Rj5yF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZjANcIzlsp3vRf7pubb166gs8uhPUhNwBrEO7+2IeKWn3TVEGzr/R7S7vxGpfbjQ+bHx87VskvBQnb9noBK7vy8k7gu5dIdV1+4zBqkHVOrq2Pp1XzKiw4cZMOeCOKWbILpXxlqrHKq28M21+9mHx5C/VjRnfcU9vhIF/y19bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QpghGmid; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QpghGmid"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e50a650a0so163684885a.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783959398; x=1784564198; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dpixIpjcDPgpofyf+7cua6RAMpmGcsNH5+NcZZyFYf8=;
        b=QpghGmidIUhC3dbts0uNPpZZ0LWjmC8ts1u3sxAfAYegH0k0uH3WkHkVgo4+2onbNM
         jK/m90y6wTr0O4xEANfuULT/9cjsYuy6X08tlmxDW802r5Z6rXiAjYw56GZesReIv+41
         T9vH9jsbPh8ugZ4CnC3K1x1nTOlUEOLc49JA2WbySPIsGux95RWC0R7X6LQUDzatFpuH
         j+K8Welj68hJT33dSQZudAwPdCJ8a4cg4e4BEv7hlYwg8+0oCLeFOcmS8TKKkLkvUMtt
         LYECElctZSt9/AJR0RF420+AldwpVzeI+3a3tiaoGpDrDPCfn2oHMZ+xPNhdUKQTlL81
         1KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959398; x=1784564198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dpixIpjcDPgpofyf+7cua6RAMpmGcsNH5+NcZZyFYf8=;
        b=q9er9ohBo2/ZWy4mpPxtVS20rWeFsomkBDUnZ6jmjwDCOs5eGi13jsGG7vOj7MvJMy
         LyRPwkmjcifwcPXeAhyuD/uDWsVIq/V14A9jUOijxxOQI65EOpnA6Wj3pf7tm5ic8BVE
         0fKZHHwPnBdA3OPVuo+H++MYG+bXeQ1RRqH+4CMudWHvxqaskRvcAX2V/DDRFuJ61o9Y
         zdjd2zErPPbIwrMEuhrVYkiYuhGKrAwGMwRifTVftRbt8r8eTTp5qVKRyyc5x0VRJdi4
         kDyqCAG86KEf5kjExCLUf6ISH6n4QwuoVwB7TFCSm2ltiOOw3z7azVobO/RVrX8bURj1
         MT2w==
X-Forwarded-Encrypted: i=1; AHgh+Rr0Vl5qdhi9ZRB6oINRnRbvWnAv1P+poOjz2ylxKowNcjJRKhOLZqujGkS+mQFeKUqK5U2hGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YybkoGBRk2Rza7/9eMjM+0oar24rQx1vXd5R2snSRdHq3tX9l73
	j0VEzVMA4s8rGn3p5FTKrZoY55HkeFfkRSrkLW1zLTn3KuIdfQh4IkVALFV1Vt89iCo=
X-Gm-Gg: AfdE7cljgsH69G+HItwF3JHvMB2UAQ6dvr0vAQU9lVNrETzfqkpztrdcwZ3PfQoxTSx
	JnYi55NvQlGqG8cF3w871ZK9u8RJEZ6oPyMqjZv+TaSALz3RH7wSnotJclVuvnQDpUlM1F1Yt4i
	QWiNZqhZFLi7mrDdpPbj+WOvS8WKzCi+23vCE4vv8+Bqh7N2u3VIB1WMWDzp9j0I579hXw8IWoL
	L7lIEA3Tid2dDSUAeZaUblcTNy8kfzpI7Bgs5X3rCnTPuZxmacd1lWw8/6GklyLpvQs1G6UJX4h
	JEvX+qUDKgUJsrGKo4/mD8IuswW8oT9+lJUSvmeXxS1MOxqVkkPPawph0yMk+bP0P9CmS5aTSRO
	rhMror4D0ZG5ACq+UzLnJ1L+sEkFAdE+t1PbPWHHW21ksaz2sC6mgx7jxn0Ue
X-Received: by 2002:a05:620a:488c:b0:92e:f1a9:7d39 with SMTP id af79cd13be357-92ef2ca77b1mr915627685a.62.1783959398290;
        Mon, 13 Jul 2026 09:16:38 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b8b3f2sm1106407085a.13.2026.07.13.09.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:16:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjJKf-0000000DYTi-0Ihx;
	Mon, 13 Jul 2026 13:16:37 -0300
Date: Mon, 13 Jul 2026 13:16:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: YeeLi <seven.yi.lee@gmail.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest: Fix dmabuf leak in
 iommufd_test_dmabuf_get()
Message-ID: <20260713161637.GD3133966@ziepe.ca>
References: <20260707030635.221577-1-seven.yi.lee@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707030635.221577-1-seven.yi.lee@gmail.com>

On Tue, Jul 07, 2026 at 11:06:35AM +0800, YeeLi wrote:
> From: yeeli <seven.yi.lee@gmail.com>
> 
> iommufd/selftest: Fix dmabuf leak in iommufd_test_dmabuf_get()
> 
> When dma_buf_export() succeeds but dma_buf_fd() fails (e.g. -EMFILE
> from fd exhaustion), the dmabuf is leaked with no dma_buf_put() called.
> 
> Reproducer: exhaust fd table near RLIMIT_NOFILE, then repeatedly call
> IOMMU_TEST_OP_DMABUF_GET — htop shows unbounded memory growth.
> 
> Fix by calling dma_buf_put(dmabuf) on error and returning directly.
> 
> Signed-off-by: yeeli <seven.yi.lee@gmail.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied thanks

Jason
