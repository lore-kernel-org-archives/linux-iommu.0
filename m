Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9D8C1E
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237421; cv=none; b=oWfU6Q4+nOdqK5wdTsjTP867r83j5HEw9r0UqQOjfU6rSml+Uu7LbJ5SwUuHzZz2Akl1k2sfFRnPgmedrvEM6G4UfLqZtg3KmYBs5aC4O53lYKcmIZ4bTCXdtmHZFp2Xz4Y+77OM2bdpT6WT7RtYQS9lr/BOmI8Y7nBlk1fxFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237421; c=relaxed/simple;
	bh=xcKLiHYg+v+qSIz2QryU5EZ8bTDkjxz95GacEk+LC5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi0/nJLa5ca/TpbdEXs2G598qGJagrL5FCSmjodXqAyO6dwSfMo4r1vvnCfWGFOQozSnSrcyrkXU6Pcnkmrf97r4VnosxhWicNGDjAo4KrAXyKhj2nBE5ePhCLDQ/Dz8Fn1zS+nzqaHfWs+Xm4GlEAL/iEGCPQur+YlWkkvsFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PAJxkxNF; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PAJxkxNF"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-219108b8e9cso2973233fac.2
        for <iommu@lists.linux.dev>; Tue, 06 Feb 2024 08:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707237418; x=1707842218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+ctx48dQm8h8eecqxOQr4XrxDktHoecl5/KwbnuIEE=;
        b=PAJxkxNFiVHa3fAW/MZaY9SkL3t7cnbMdYU1bvbYsF4n0GdDnNme7Zylo2u/zVbuUP
         VgGjibnj8CNVZqafm9jq4ezlis0ySRlSNvMQTBQhhSdnQ00uQLQFJXCljrNsVALkDQhJ
         U+1AW+9hHTWgDXdg7GcKG/PTM4JYU50Ge5BRdytcAlp6uOteTtsCoiacCMa5eafzbDsy
         T2/T11QYJ5GBdZ88L37GLbavL5VK+i1Z+zNj1DpBnbj3sjqHtJlBGRHeUaASyFPtxYnf
         qdf58xq0ggblv3CbQ2waoBZhmTyK2GfVCW/0qM5JOfxVwOoE7X2UaBSmJur/1nDMgUAn
         bMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237418; x=1707842218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+ctx48dQm8h8eecqxOQr4XrxDktHoecl5/KwbnuIEE=;
        b=EImHk3agjjUVlQbcYnyuza5K01HOp/md6CsJcg8PTbtJ++j8NY8xGkHCcTaHqnRZw4
         bNcE6YBvPq28B0mTbNS/1oELeW4Jt+wufC2ZJsyaiDHtv/oLOLVD7Tua7UeyxHCY67c7
         RLDboHnlRWredlnC+4EvxshQym8HBOYnhwsi1IIOELUTniprBjzLbTvZL4oDh9ftC6Oq
         F+8o06qq0BooLk7yPq6CK041FxGXpDaqCYE+TTIJ3RUt29Up4eppH/o3y7KssJGQOxse
         RxFKAtfy3vmXgTqRLjsxlPmtU/orjRYRWTF209M0kMfdaXNDSP9bTI17AdioiZPm/6cg
         tNsw==
X-Gm-Message-State: AOJu0Yz44L7huRBmOFPaPhjbmlu7xVdr8SQ1V7EscJtt7c6kv7tK/QFM
	yFYMyIl+cmj/gJrTI062WFST9+hPYKOGuvVtxn2YB+iiFK/Sq6TngIFeaxbb7J8=
X-Google-Smtp-Source: AGHT+IEPk88biFhxuSpaE2TWHNtlxX7CQG9kHTocGpRU2dGO71ncVabHrAPVLPb5l0vh3S145yGteA==
X-Received: by 2002:a05:6870:3309:b0:219:6ad2:3b8d with SMTP id x9-20020a056870330900b002196ad23b8dmr3255792oae.26.1707237418684;
        Tue, 06 Feb 2024 08:36:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVAetjL9BHUZVLOkMgL7XOQG2QGuwodIGJA3igZGSQsOhRDZEQqztQaFSwFBMT84WT+jbJ7wWmXpMv/6RNWT+Gfxle/HhJ2l3cUzCdhkRdaN/HY6l8vkailO1NaYJ9kuN5fAHjjMK40G6pY+jwj9C8kFJiaynyjvSGvN8v8V5o0POqBW8M+qpE=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id wz7-20020a0568707ec700b00219447374c8sm499098oab.4.2024.02.06.08.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:36:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXORN-002jHz-69;
	Tue, 06 Feb 2024 12:36:57 -0400
Date: Tue, 6 Feb 2024 12:36:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable
 IOPF
Message-ID: <20240206163657.GG31743@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-11-vasant.hegde@amd.com>
 <20240201214949.GT50608@ziepe.ca>
 <9d3579c7-66c3-3752-bad8-a8a8ebc5c74c@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d3579c7-66c3-3752-bad8-a8a8ebc5c74c@amd.com>

On Tue, Feb 06, 2024 at 09:49:36PM +0530, Vasant Hegde wrote:

> > This dte change is in the wrong place. When the domain is first
> > attached we know if it requires PRI or not. At that moment the DTE
> > should be set properly, it should not be set wrong and then changed
> > later.
> 
> We want to enable PPR support only after setting up the handler.

That's backwards. It means error handling can't really be sane..

> > (and again the whole dte setting flow needs cleaning, I think you
> > should do that before trying to build more complex stuff on top)
> 
> Yeah. I want to fix few things in that path. But that's outside this series.

I was looking at it and there are many security bugs in here now that
iommufd can change the DTE at any time. The current design assumes DMA
will be stopped and ignores the spec guidance on how to do a safe DTE
update :(

I'm really not comfortable with adding more stuff here until the
security issue is solved. Especially if the more stuff is drifting
further from being correct. If you can keep the updates in set_dte
then maybe with some reluctance. But not like this with random touches
to the DTE all over the place.

I was looking at what it would take and got part way through. It is a
very similar problem to ARM and I drafted a similar solution.

Jason
