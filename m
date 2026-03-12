Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F83B9D97
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322829; cv=none; b=dxsV9fmwSWcRdcqhMSbjRRVye2LTr2JT84ejgKpEcuwFFTYe9DLbGevfJChXdU/9EI3/cs1pnT9wQdQCvngITjgMCpvajGMKyWQqi6fjAuKgxbCyZ1WZnH1eoxmAI0w3XIj1aNrYa5jZ9+wLRSQCR/rgmP+Zv7V9yZMzN/WgZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322829; c=relaxed/simple;
	bh=rAsG53T7VzeVL8MPN/j4EPmItrg7aAE61kEiWgrhL/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu2WXfn3+wUItKfj2BPKKFHW9CADB51jmFruH+Gwdh4qL+MMtCqs9ktvBDeDX2MehVTtXIG80xok4pIIbFsGKww6JWqYD1c2dantRYBZCPi1nnxaVu2RPsHvuTDMEh0ZG7iUeYEw+CJGl8aSzX5Q8qK6j/J0/YjX5YQEwVyeYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dmtpA49H; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dmtpA49H"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899fac9caabso13616006d6.1
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773322827; x=1773927627; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYBFQ99Inco1AF/xc7g0EJHr1Nl8OM4ewTd8eM5kz8A=;
        b=dmtpA49H/veABQSneKbgtuOE3j7s7XlZLINnimVAa9aVy6PnxFFjpzQTJs6nbcruVD
         wOCJJ85EuNvXHMXm1emIDvWuMHqm7wXljYr+ztWbo/PSrRYFYaEqS2GZaWR5UC0TtC9r
         OjJW4UD/eqFCl1rgJ01qldfm2GvZ2rRKP15LzvbxEKaVgsYmt8ta/LUyXvGH0s2uYUk3
         dBUlI5991HrvcYnb5RT9XUD+ilW17mrs03uf56PtFM3pfSGOg+kYzas449rz++kWxTCO
         pwkLflY2nCYU2dW3kCBt7/euQu3Whm3pVEc4C9D+1ABLIeXrNP/Xjbmv90hDIp08K9wc
         fziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773322827; x=1773927627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYBFQ99Inco1AF/xc7g0EJHr1Nl8OM4ewTd8eM5kz8A=;
        b=SNJ3duI3d3hi1xBNSfa382w9AizVHLED8+oBsE8eR8PjtaaVdawAbGUeB1+A6hJUmp
         /eR98Oe8pf6VB47ihSdvnSGEmRCH/FaN2s7gauS5GdUBUysr/ZLlEq7Pv6dXdaq31f5U
         iIGr+Yc1kFKmDoyoPjeEdCE6Sw4FMuBQPcVv9uH9JgIoPgPqwzXcz16LqHg+9l2PbvSP
         N/ClQsXHci5isSnfIl0toX78Jm7TzAybspbpaI9VJSHzFtssM3EJd4RQFmqJqqKV8zpP
         iy0VasTq46iQklCh4tX3t2qzsB4UwcDFjif8Cw+K4aIk1v1EY1BjnrawlMYTZSj90PSH
         YNHg==
X-Forwarded-Encrypted: i=1; AJvYcCXi3Z3Dn26qApneK+QaIku9fPEB8dKlVuIgCyegJQLxMyCa3UJkTOZ3UJJnR4TMD5mY1p/FXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhO+j46247W/aZvnno+EptpJFzjDNfw4mDmXRO1n26fj0T39Rw
	PCCYKJzyJP3kDN3Q4eabtfjmQnGQda7pgQaAQ9KX+J/v0m7XFzDXbKog6KFPA6Mq5KY=
X-Gm-Gg: ATEYQzx0ECzCdTdFEZd6TUc0OOiOpQS1aoFR/V/TMnyOopQrmg3ElDgjuV3yJKOvIiu
	+BzadXQVMlm54Pd4H56vFLjG+OA3bApU2jTEZtB6MjRUiitjQh0R1eEu1/7zk2LbdOF+HAQJB1q
	/yPdd3ksR+BeprWq4krXWJyKQosmnQS1TN9jHvJaXu+bnB8V0Rj+1eL4ddZD2o5Oh953wjqWTXk
	yE2hrRuCNpVhFAZoymhFK/UAwuNbQQgw37H+KpVCSU1do20aiHnxoQMEZULfWm7+F1DIGoU2pPH
	DXa0+8nzDEMvA6MB0Hkxvr1ykdv+mu81Z/Ti/MTzbUBMLRUcPEA3U3HX4oFgrLUkG6Lu+8JUnUM
	ea6Tcvd2f8mCA3Epu3gxSSNAFaOlMh9IlZ6zoyfnveBOC+Tq0ajd62T7Z/ULahdLQRqTq3V56Mh
	SftURTLt7ObHg8fAeL/xguUdC9EhQzT4TYP2/QIsFQSzFxgn4uUfFb+lviqE1ef5jELJ5Qa/cf5
	LXPe0Lf83TQEOfkia8=
X-Received: by 2002:a05:6214:258a:b0:899:f741:5aea with SMTP id 6a1803df08f44-89a669c0189mr90996506d6.8.1773322826949;
        Thu, 12 Mar 2026 06:40:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bed85bsm34252386d6.17.2026.03.12.06.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:40:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0gH3-00000006fil-1PUY;
	Thu, 12 Mar 2026 10:40:25 -0300
Date: Thu, 12 Mar 2026 10:40:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Josef Bacik <josef@toxicpanda.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
Message-ID: <20260312134025.GJ1469476@ziepe.ca>
References: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>

On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> We are hitting the following soft lockup in production on v6.6 and
> v6.12, but the bug exists in all versions
> 
> watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w:1274919]
> CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
> Hardware name: Google Google Compute Engine/Google Comput Engine, BIOS Google 10/25/2025
> RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
> Call Trace:
>  <TASK>
>  amd_iommu_attach_device+0x69/0x450
>  __iommu_device_set_domain+0x7b/0x190
>  __iommu_group_set_core_domain+0x61/0xd0
>  iommu_detatch_group+0x27/0x40
>  vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
>  vfio_group_detach_container+0x59/0x160 [vfio]
>  vfio_group_fops_release+0x4d/0x90 [vfio]
>  __fput+0x95/0x2a0
>  task_work_run+0x93/0xc0
>  do_exit+0x321/0x950
>  do_group_exit+0x7f/0xa0
>  get_signal_0x77d/0x780
>  </TASK>
> 
> This occurs because we're a VM and we're splitting up the size
> CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
> amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes. 

This function doesn't exist in the upstream kernel anymore, and the
new code doesn't generate CMD_INV_IOMMU_ALL_PAGES_ADDRESS flushes at
all, AFAIK.

Your patch makes sense, but it needs to go to stable only somehow.

Jason
