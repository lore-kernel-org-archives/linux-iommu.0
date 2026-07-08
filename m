Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CB3148A8
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521373; cv=none; b=Tvq4d92zbnAtsS5yaGNI5QC0dG4e8V3xXqKbOKEh6XjfK5vGUVbGCJfit8qixwKHduNYurEfCApL8rL2uvfFsn+EmeW0GjLDSY0a4ZqPGQZ4Oyx9KvT2YrrRO2j8eTLnE0HvZR1++cmdy0rgkM+SmzwxMzYI5LuGazTwlNfvBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521373; c=relaxed/simple;
	bh=vhqUkjlrROSO5xWLT1ElT8o3eP4pscAWwwCBQKJyhiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyMxtSPyymc7qHIWL88SjkYXaBXolRpwDGdm8EiEgLeC3yE5sU7TI/hfdGokYlO5zL4TK8KUIl2zHAyWzE6ok/+PDZUIQuNRw4A/gO4TODJNs7XPsFm1bUEcJBMcL4QfueVq11wH45cq1boSaLMzHd0v3XIUhPXBOJWd4Nd6KCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d6OwFBVX; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d6OwFBVX"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92c7a0a701aso38021285a.3
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783521371; x=1784126171; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0G1PJlvlk1IiQotaA2tgdr00kw07zQwazFg/oJxTng=;
        b=d6OwFBVX7oEh1PZ33N4s9el3S+7GVKf6K8El98UroN0xgtgn9bD5eUl/D1YIcZSJ3/
         Xe5q5CMxCgOmM+vbsj0NrYBPKaBuGZSGEZxUahKzXdPU70xgWCbU+XwMjRtM8eZid90Y
         TXYkvOxElKtfy1FVgdC7yfnLrwkAaD7BwX7nf6ozu6K6LlZstchv/loGwiqZvUZea5u6
         aspYo8uzBXPup+4pZxhWywUI59YFgoS6m3G3uUaEULE7NDXEQ1m2NaMJ4T2Zkfuyo6t0
         wAGeI84/CSd4Lnc3vyTUfeuImQ7Kr/uJ8IlIReESEcEmvZICfLc1+UFqv1ksKGh4LBjI
         up8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783521371; x=1784126171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0G1PJlvlk1IiQotaA2tgdr00kw07zQwazFg/oJxTng=;
        b=l2qqryTfqh0wtxigH6q8QLz5+m1qcGLhvMkDGP1j9TbZpZ0JGSlbG2b67QRrwUsg2R
         ONm+mAdzHcmZK23L9RBGLk2YnZsg1YrfbAp5B4b5zqlCULarDXwTEvD2EXEFoWk4v3hH
         pdO+1+Hc5whhh4od1jCJPw0oVJoFH4VL9Wt5frw/tQPQ1xoU/3z1ucl/DBRXXESN6Z6A
         cpnB3PUCeZzxvsO66wV+RMZdfiTXzrQ3IjazaS/XkDvCQcYnFOrMBQCiknM2FVS6/Et1
         rkGtsOKbMmFZOqIl+pz3h23pChg+89YVkOp/ZSj5hLrjnsOmizxpPpxlqb3YOVO0qfeq
         EINA==
X-Forwarded-Encrypted: i=1; AHgh+RqMO0ihhJhxx7MS/mvjiEUc5WLUYyN9I1M1FNIVcMjFJH6QSs+xJHgGi7FpLwTFfjPfk92WLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT2bXQGJxi2Y105s7bgu52PUPkzvvPE63oMipYsMGXGtsorQ4x
	GRDVVrXVAIrBWCNeiONxqdG+qZg0OHX4J5VGjAXGd77HQhJwF5NGJyygoLea/OGzSDM=
X-Gm-Gg: AfdE7cnVpNyKeqCnfEfaOc66SHtYWHJ1npNdiqutbh7v/iyCZl2Hhk2Am7u+SgU6HoT
	jwDn/vPT5MyzsTV5UZh5qEpMUx+W66rxuSAP4dLI60Pr9cIPkgjTcHox8rTILzJ7VSSpwOSoXte
	vq6gL0DYFlYm0ri5CbjoqAP/Ef3xlbZSGYHBtJlZgRQ3BSl4YVEFR3eeKqbXHk3WXkADgSX8e81
	a33p0waQZeUcsJH2VFXsaxPHYruxbfyHqp2WOBLD5kLUN0xf7e2j+n4nXpVr6NMgvs0GxWsbXkq
	oABjURnd6s9sOPYq03rSmdFcVfktEXzw1xYKXOiF2HdX3NFD7PFWUjEBL4eCtFTcu8eokTy5taH
	xht1RJB1msAdTwQcBET3DxARbRfCs5aFr6mZBHXOSiRT4s8mPjzMHImrTHp1J
X-Received: by 2002:a05:620a:1710:b0:92e:87a8:6f15 with SMTP id af79cd13be357-92ecf6bc50bmr260180085a.69.1783521370605;
        Wed, 08 Jul 2026 07:36:10 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90bb8629sm1426076385a.19.2026.07.08.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:36:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1whTNh-00000002wv9-0Sc6;
	Wed, 08 Jul 2026 11:36:09 -0300
Date: Wed, 8 Jul 2026 11:36:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [BUG] iommufd: dma-buf-backed iopt_pages wrongly reaches
 userspace GUP path and triggers lockdep warning
Message-ID: <20260708143609.GI118978@ziepe.ca>
References: <E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn>

On Wed, Jul 08, 2026 at 06:44:25PM +0800, Peiyang He wrote:

> =============
> Suggested fix
> =============
> 
> If above analysis is correct, we should add dma-buf rejection in iopt_area_add_access()
> or/and iommufd_access_pin_pages(), similar to iopt_pages_rw_access().

Yes, this is right, it is definitely a meaningful bug that DMABUF is
not blocked from access. Do you want to send a patch?

Jason
