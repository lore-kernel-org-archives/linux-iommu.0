Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4574BED
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150246; cv=none; b=PNgqnFkwEoFoH1jPmyo/SvazjPucOg1wFNjD+5SdhC5tMXyRSUB0ffRyJ4NWJ2Qz10T28r3iF0/MQBTBKT9N7b0G9R3Rn4dIgVwcrAfDpf7WZtvnIyAXvmeHf4BVaBfa7fchL7EeTg2hHaRCFuH6XFsRXZy/ypUdhVa4cbuTg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150246; c=relaxed/simple;
	bh=KFRtnFkBQ3nC/ONHLc235b88cizu7aDwFPzxp2mtWKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3yS+k8ZAF8eccCPnVvEAYomCWYygZ/lH2LErIOAsy7FHx/xMJcV8ZlWRYDa7WLN5hFszvBNw/ooaj6wxeX0+zWAP5/hxtgSmJc5YmAVOwKbRb9q6jIPAWrgaQEwDCmAd8JBlm1CILH9cfZxzXwzJkxQk60s5as7BtyRSpqXk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NJw32Yeh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NJw32Yeh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4720cfc35e9so35353371cf.2
        for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 07:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740150243; x=1740755043; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=raGdtvv05v7TE9T3+zg6DVv8x4HSkjlAQxhegISHwbU=;
        b=NJw32Yehq/v3k0G+L8i3yNGCvg/GSPqzZRxQXUDgfn7dyUMr0AaAp0svUVGv9bl1Bi
         TPDU9QZiyrYRp1YKHFAa0nDRVl+fAiRZweIIXdD6+meSLUC0N7XWFjsZ7K1HZdsxPK/a
         Xvx8iQpOULyqXwlOTBobVQXAe8yy3qAMrwAm5mUxJm5nvj+2RnrTNYtLScFIIm0Zwj+S
         XMk0N+EXp89JCY2s9lDie30cXSMoxB02nFPHd9ULMnpufmS5KDmiUFBVoW01L2yXS8FB
         xYVnt1RsHOYyOqAkkI92RkgpmeNWvVgjFborXzAm6HlKbf7HoSL7A9J/DMGrpvzKzvRp
         jU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150243; x=1740755043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raGdtvv05v7TE9T3+zg6DVv8x4HSkjlAQxhegISHwbU=;
        b=UlyuuwyHFN8yQfNR2ECobsD+Xw2nbSzG6sHLT4ryoQv18ZgCECW8/ghgAqPudOpPpj
         AaGKrmqO+zfkuk+HjVsI9oP7O56M9d2GzVK9YJyGHI9NATf6iut9L1GleaouBIk2hsdF
         dDZ0boWLaR0s7hz4WOfkT69SEeunAIk7Qmp0L5gBJwp9wK9pW7c5pxbSvBRZwKT2hih7
         E7JmrNCc6Gw2rZtvfhLWxSpWKApQZqHwLCg1LXhBJE9RiVm9G/aC0RASfC+NAOE1vFFG
         aviT9Sw/dA70egObo3lDq9SgDQAu+gp7CoV86tgOVhy1Hlm/xaMTvl50/76fKpQXZDXY
         pMpw==
X-Forwarded-Encrypted: i=1; AJvYcCUyhlZFTOtNfUOndNej/B7oLgTv/H9chxdjH+m7I/Z8J+MLGGKJbPQuAP+n42QSNTYZBrvcyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBtAO8+KgE/1oKj854OqZPUS4aZzCdXyV6i6EeZxn36cJ6Qp+5
	Qp8TyugoeQWpq1cpKncOfiksMnHb/npOVX9vQ21s0E3ERO85GBMrdTksNRwobSI=
X-Gm-Gg: ASbGncsY2ZOVYMsO64XflO9EG88ZYgc+dExG7EmpJTaG++itQ9lxEx9AlwdBL0FH1K8
	0CI6wvejWBBMUE0y6iEPZY5oEYsmuvPj2IEKpIvvITV2Ky+GUWE1/Na9IRK6nY1abI84+sePeWl
	17fxk2+u6mNbGM1D1wlE7FUIdxRWDjWJGJyqeMfiWxRcLiH1l63D6yVB42d92TkQi0d4xxdfT4h
	xaCfrjFZ4CV84sjtyeg4uZyaCWV984NPSseKeGDE7EJbjuGQJ8IgOZ8ksCy+Tgy2YWeTTXw7R9K
	wEcyWfJrDu5dq2cQqXZhJkck+3L6fkLaDJQWqoU9oGlj2uHVPukt6T0DneldBa+kq1Uhn7FV3zs
	=
X-Google-Smtp-Source: AGHT+IEyhGHpN40DqDI/gpoNpoHjMZUsgC5bbatQsZIqzLlRoImR8TUs8p3nfPNs4rz85K0lqk/aKg==
X-Received: by 2002:a05:622a:148c:b0:472:16c0:202e with SMTP id d75a77b69052e-472228e4c54mr51741521cf.29.1740150243373;
        Fri, 21 Feb 2025 07:04:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f2b0476dsm56422141cf.28.2025.02.21.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:04:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tlUZN-00000001IAj-3wKe;
	Fri, 21 Feb 2025 11:04:01 -0400
Date: Fri, 21 Feb 2025 11:04:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
Message-ID: <20250221150401.GY3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-9-baolu.lu@linux.intel.com>
 <20250220010250.GQ3696814@ziepe.ca>
 <d93c8cc9-77a5-4b78-85d2-6b4601f52266@linux.intel.com>
 <20250220180004.GX3696814@ziepe.ca>
 <6754e308-d2ee-4389-9dcd-c2a5bbb16c48@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6754e308-d2ee-4389-9dcd-c2a5bbb16c48@linux.intel.com>

On Fri, Feb 21, 2025 at 09:31:48AM +0800, Baolu Lu wrote:

> How about below change?

Sure

> -       return mock_dev_enable_iopf(dev, domain);
> +       if (mdev->domain)
> +               mock_dev_disable_iopf(dev, mdev->domain);
> +
> +       ret = mock_dev_enable_iopf(dev, domain);
> +       if (ret)

Though here the domain is disabled but not removed from mdev->domain,
is it OK?

Jason
