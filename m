Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC2346A04
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963420; cv=none; b=DSu72XnKtIUiVRJMrBVNgOHBeUyP+iNEGKKSDUEnj0W8aBOpsS0KMnkCFGzumXj4V01uyjspIrkzCk0Wea0fhV6xSIlPnVJIKPdhK8w9yHvrCzGr3/wHvkK45OEIUhDrMIMhzt+dLszGJEfsNXXO+3NlSqHoN6xuGzNVJ2cOQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963420; c=relaxed/simple;
	bh=wxEdqGJIuwK7FxHMypKlsv3XOm1Q2G8Mhu9SSr2IMQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFf0dVQCtXf7VrUs2x/QmKhrgo6UKDfICm01aqqbC4DR0qMNA0aFAhKBChE9nwDdMgA1YuhkporgtcCtscAAZh3EOpvOdowiskiFUECPjqZ7PbzpOJ58H/WWf+6pfNowpVd2D51SN+w2bkh0lGji2UPGbBjF6DgwimUid0k/ajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aLzo8ZaL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aLzo8ZaL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c0a81d286so762871cf.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783963418; x=1784568218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uuXth6kM41aD+brEyw7ekEydi1QKQ14BXBpZiPQW7/0=;
        b=aLzo8ZaLnhKlwOdWyDIxolPyRmbbg+NuvFed39GuD0RrCeqfpww+dcJzCu98uQZvh3
         ynh+KnqrV9bbE9uNaSlPleUmG0ED8E+ZJZsutMeu1r8nfFf/9/uf8/ewsUquRllSZxu3
         KtRARMhoD8EWN74IENcyoMy89tBBlmgoCNzrNVtfDS19hn8f9GC9cxdw9dVYFLChVnUI
         g1PwTje73b4ORJW4cdpLq9sOV8heiq2OcZoABpqmNLNlOlGHBvKA1Q93MvOMxYhxce1s
         g5sysVvE3cZbgWzUJK+HBPB9xEcya4S5AFEVPPDGSuS14Oq0IH0uQz7pU/2UoYQeGOSD
         46Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963418; x=1784568218;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uuXth6kM41aD+brEyw7ekEydi1QKQ14BXBpZiPQW7/0=;
        b=qbC5kqRnYHaMWNqu3IFbMe+NkI+6j1sc9QrbbxIX12JDAnPcN0H0WVDQ/3nHTzSb16
         FwliGK8YBtr+uJ6+3VpifUPCSC1eJkyzlbw2g7f0D+6zcR7Ltb26S0XRPcb9ucNDZt5v
         nvTgkOTJf3CuuHNDdrJE/tQ6ozTxdHbds7oZ7DJD66yZQgXuCNzfc/GqxGjnHvZvyx0C
         M+erImIpSC6cccfGQRcF/cETh6h//nI91wZemSUGcf4N1/MURY+xTsPVTIdPWcGr6qpQ
         pOsVfTPsWVU7roXrWRU5D/WwUjypRLtyhmPHA2QnK1IaJ9+WJaHydCcqcq5Zn3gOO0FC
         a4Eg==
X-Forwarded-Encrypted: i=1; AHgh+RqfQexMHADXMSAnx7dLRqpOj6KFxUCsArWpZNlIWvLa1PHil2DmTr/Noqs9UP7LXbQHXNb0dA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCOuqChOANcZcV+JjARx5QzM3n0wjEEJoPml8HFg8IsQOHZVKj
	YpWxvVJ7hS7NU4TdJs7GdxBLGpafuWm8wS8Z57SeWrDZGBTVFDGwu8DgF8qG6eiYT4o=
X-Gm-Gg: AfdE7ckBif6ZZY09pSfZ5Agkob+58LZ9CNVXJl5TxWvuCqMzgZi/Lm9eZXx04MrRBqq
	gu3VUhnLh7k408QUbfXdNalmFhpb8ln5gAW7IHaWLOjMUvukl0ykqtGxxY3xJ6WCpB78pN6JQIT
	xh5LfbcqABqWRSTC7ZZy3sHhAUinlgRt04kKu1MX7Hd+0HzVWnONcpNOmYVa+U8tgRABlxfQar/
	1mz90cDOft+2n8341XEIEd/Tvo3JCot3pdXyOPlw8UNcmtSsuxDVMi7IeYvo72NRfp33qEKXhZe
	ZfAvw2cwUYdQuXnz4Pl33INLl0yPykEiUeUgefuEyZGc2U8YFXyyW/mwI9Grq8i9HhZxcQ5V/l+
	l7lk1W6unNWvpdN75k0LKBW7+RdxJ5zOqLUPazPw01QEN7IeeX4Z2i2XxrO1S
X-Received: by 2002:ac8:5850:0:b0:51c:7aa7:e0ed with SMTP id d75a77b69052e-51cbfae7cc2mr97664661cf.42.1783963417634;
        Mon, 13 Jul 2026 10:23:37 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6e9f4sm89206921cf.2.2026.07.13.10.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:23:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKNU-0000000Dlr8-09oi;
	Mon, 13 Jul 2026 14:23:36 -0300
Date: Mon, 13 Jul 2026 14:23:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] iommufd/selftest: fault injection in iommufd_get_object
 can trigger a teardown UAF
Message-ID: <20260713172336.GF3133966@ziepe.ca>
References: <870BB9ADBBEDDD1A+37c5bfab-ad32-4fc5-a302-57c81a8432b5@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <870BB9ADBBEDDD1A+37c5bfab-ad32-4fc5-a302-57c81a8432b5@smail.nju.edu.cn>

On Fri, Jul 10, 2026 at 01:46:55PM +0800, Peiyang He wrote:
> Hello Linux kernel developers and maintainers,
> 
> We found a KMSAN use-after-free in iommu_device_release_dma_owner
> warning when fuzzing IOMMUFD with selftest with Syzkaller.
> 
> After our digging, we believe this UAF has limited impact, but it
> exposes a possible improvement on how fault injection is handled in
> iommufd_device_pre_destroy().
> 
> The root cause for this UAF is that iommufd_device_pre_destroy()
> uses the fault-injectable iommufd_get_object(), causing it to
> mistakenly assume that the vdev destruction has been taken over by
> another thread.  More detailed analysis will be given below.

Yeah, I made a different fix for this than you suggested. See the
patch I'll post..

Thanks,
Jason
