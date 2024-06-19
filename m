Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BBC1DA4C
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807527; cv=none; b=CM7eBJ/0ZgwlMr+zjsh3PRrpHFZhsEQAJ3ct454puMqjHvlolgvvos3QPsLlc7UWgG98Ldu1b3h3DulqrwQ6TTTF44aLgZWaQOjN+/UzevwPjN0M/pE4I+94FKTluT9ozDDZ6exs9cynQfS1ckHD2H0TplEIueXjvRgG2jGKhTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807527; c=relaxed/simple;
	bh=Nk3viGawuArziw5+sHP0ZhUL9Lqm72T1o8iA8Vi8L2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9+qCy0h1cCRe5Fy1z/Rbb0FyoPVqZ0q9Zv7L+MAZg6/PloBnI8SJkyj2ZXiPerlgaYaGfUzEocJDnO6s45yGGvWRAWkQMUBrrxaFldoGG68C5k2HltesVRTgZNPz6BHRddxZSxRWuRjgHZXiXn1mVt2QJDvV0DwAmmxN3EGVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FCob7B0m; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FCob7B0m"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-795fb13b256so71961585a.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807525; x=1719412325; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LZUM5jfj4JrQADb+518kXqO9JR2q1Dki1G0Ben/yk4=;
        b=FCob7B0m7ay4jAf6RVOV0wQVAgPjfeug5r4e6ZolwXLCZs8ApmBLHq/JhiRMlg8Two
         t3SZv6yFQa0HjlXorKQTm6G7uDC2DxRrmFmqRfIMTRd+UIkjch7nWb7tWtuAHYND9hJd
         KJSvStJAKiHVNo669VglZhktSM2P2rwPDGD91XO2kbiNU028oTXOxExOFOpMN/LL92qC
         DAqA+KOnI8zgY+/0aaKnf3iGUuON88j7y2tS/LTCn2obUqW2L14y72kkkFNlvX63pRxN
         NdmwUJLaLPNxkSCrNOPSQ4bYxgiv/xjPCvxaYQ+zUlTKUg9BUno+VHEpHlZDaffMPV9F
         xmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807525; x=1719412325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LZUM5jfj4JrQADb+518kXqO9JR2q1Dki1G0Ben/yk4=;
        b=C/XJJ2zQjhLqXdiI5OdmIX/+KMNVHrc4hZTvqNyzMoMNzRzpOCIV4pEIaBat1B9uH+
         /8UYJk1P8pAP9962d24R9zL5JQwdEv/wfKb1Lv/6QTcVZ7C2XI7fewn0CYdqGe7f3imC
         F83J5fmlazWYKQROuM2z6uFShEpbpi+BUP18uLLpIF/KzzSiJajRdKGFnDexJRmsHWOM
         Q9MjaI+mXH7laFEV0Q9S4BqSDH/SvPLW1ENCg4GGOIfYUar+1+g/K+qQjW1w+mH0sTsR
         lfFqdQklviJW8DX7e+ImqKhPdKtUEvrztOMQPs6Zd693ta/d8O9xcJzCMXJq5e9r5cGS
         hkIw==
X-Forwarded-Encrypted: i=1; AJvYcCVgcXg4baqztiqfAHxGNmnmoMB9kifnARv/rCdsDz7FNtgPHvFzNpYmOTvujFU7iTbuyHD/+c1AUqzK/q3dihxLf+zWfeQ=
X-Gm-Message-State: AOJu0YxcPuLnBgqk1X0o1ZRBk7UKxw0JxnmVlvv24R/EbD0bqbodoK4n
	giCt31de2bok0mvvCCgd55q0CIDYnDM/uKl4Y2jjCVotTgc6zpZuKnBeEzNl1Gs=
X-Google-Smtp-Source: AGHT+IGuQBogl5nnCa0xO+oPgBraH+EqrP6Ubhg3FSeuAcnXv1sZiKKYgQ7jm2DbFVYX9xP9hURczQ==
X-Received: by 2002:ad4:5f8b:0:b0:6b0:72ac:b306 with SMTP id 6a1803df08f44-6b2e22d60bdmr86925786d6.1.1718807525299;
        Wed, 19 Jun 2024 07:32:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb498bsm77913746d6.76.2024.06.19.07.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:32:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwM0-004bip-ET;
	Wed, 19 Jun 2024 11:32:04 -0300
Date: Wed, 19 Jun 2024 11:32:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/21] media: venus: firmware: Use
 iommu_paging_domain_alloc()
Message-ID: <20240619143204.GD1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-10-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-10-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:43PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in venus_firmware_init() and is attached to
> core->fw.dev in the same function. Use iommu_paging_domain_alloc() to
> make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/media/platform/qcom/venus/firmware.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
