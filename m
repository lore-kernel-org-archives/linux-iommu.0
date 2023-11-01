Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4E10A0F
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dU+vLXzf"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso4404550a34.2
        for <iommu@lists.linux.dev>; Wed, 01 Nov 2023 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698838862; x=1699443662; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FHDdTo0xw0CeTOfybYuakNtKEAEzS/7tS2HLJVX5Rc=;
        b=dU+vLXzfV0PbBKHdWnrGP69HGVl//k2FLzuydvAroZm0OGJYNGoCtoK0/ISfflZhCn
         YXqf25bx50Z4IuEVID30cEgsIn3W28uSgOOlQddmP9kFyC41sgfSHyKtSA7O7dH5kQzs
         2jbBLFw8fVBLfG+RgFjjSOLe284AKSb/ItnXl26kbJYf77A2O8KlvASKmGQBoygbB0sT
         FJ+b2EETqSGHnJS1Bgns90owc/Rwa61/IY0uF9T3H/LrnyNfKVUl56VFqV3+TkLLIllw
         8ZnhEBinmEZvDizutW8GsboDf/HAbM2nqRBIwDW5ciTfioIsemK8YRjjC1Mkaj0rsrVJ
         tOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698838862; x=1699443662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FHDdTo0xw0CeTOfybYuakNtKEAEzS/7tS2HLJVX5Rc=;
        b=KXDt8Z3OZeXEAlhaIQpttIEGpIcKe9aiOY4KsD8ECggc9WLd7guBcAzATYPo1SnP8r
         gdwoB/+iAI3BW9JGzD3IciwEcSZp6t4UPj759DBkh6N+sy7DWBFUSyQGVqSkCwRv/wO/
         yIlxzJyjRzm8lZDOhvXy1QML4O0z11OQS+KjIY+swkCH5CUxaAETDbfGWcldRtYeFPt3
         EvObPERI4rgfygK9EW08oacSUdqkC55EWdblWtujAJhi5o7EUzR04oj9VXt9HlZoHUn4
         qgpdAWEnsbtrk3nHD3dF3yot8BZWE1n0JLAZ7PRe/yPZ/5O0lnMLHKsVvofs6CMkw+Uj
         CdWw==
X-Gm-Message-State: AOJu0YxlQ9nIgnxiYl7aq8wgkmeIIhx2QmQXhrw0aYhtZ0h0/61jRQ/H
	5HaBNPFZYNOnFW4oXepHqLY2Pw==
X-Google-Smtp-Source: AGHT+IHqSQb4XYlupFI/7jvcRxPMQ1qS7FUqz7C/cqobb0l3gR2NbYXd6BI6//mH/WNE3AcDQJ1NFA==
X-Received: by 2002:a05:6830:2054:b0:6af:95f9:7adc with SMTP id f20-20020a056830205400b006af95f97adcmr16123618otp.14.1698838862545;
        Wed, 01 Nov 2023 04:41:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id m10-20020ac8444a000000b0041803dfb240sm1321271qtn.45.2023.11.01.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 04:41:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qy9an-0083p0-83;
	Wed, 01 Nov 2023 08:41:01 -0300
Date: Wed, 1 Nov 2023 08:41:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] iommufd/selftest: Remove unused function
Message-ID: <20231101114101.GL691768@ziepe.ca>
References: <20231101012323.33154-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101012323.33154-1-jiapeng.chong@linux.alibaba.com>

On Wed, Nov 01, 2023 at 09:23:23AM +0800, Jiapeng Chong wrote:
> The function are defined in the selftest.c file, but not called
> elsewhere, so delete the unused function.
> 
> drivers/iommu/iommufd/selftest.c:511:1: warning: unused function 'get_md_pagetable_nested'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7104
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 19 -------------------
>  1 file changed, 19 deletions(-)

I think this is a miss placed hunk it is used by a later series that
hasn't been merged yet.  Yi?

Jason
