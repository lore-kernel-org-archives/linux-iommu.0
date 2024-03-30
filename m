Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92B17F7
	for <iommu@lists.linux.dev>; Sat, 30 Mar 2024 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711767349; cv=none; b=F8jbn2T2ubPjToAZIzJ2JYM9rtaEwTKaxHSRWqvgv9NX1IOagMNIC3+0NZ/djq+eOrdgXSN07DfJmhxCOQbT+4vPGaR/Ot1kGC0qSoLotWtr6y60eHxDmIHvrX/ZvXHjHGBeN3BsDw/RFuJJDUwsssbRX+5zX3smVUPnCbNoISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711767349; c=relaxed/simple;
	bh=0VnDNUx5No0InUGDHz18xd4XvgnzvL/GPmTikaNRNSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbZ+/Lb6hxrzCsrTJBil6C5ORWaZJRMKj9iuJl/w/mJeB+fRAlbXg1WxKWv/7yUptkx6KPhMTP492sA2MErsbLFp5IcpbIoXIsOTspRK9oEGPqfiTD3v8liaDN50FN77sWSQ8aRjUj/cMfC/kebdRzQlvXlVhco9rUPEmsowuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=h305St7w; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="h305St7w"
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=h305St7w;
	dkim-atps=neutral
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 428849C5
	for <iommu@lists.linux.dev>; Sat, 30 Mar 2024 11:55:47 +0900 (JST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c65e666609so2029048a12.1
        for <iommu@lists.linux.dev>; Fri, 29 Mar 2024 19:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1711767346; x=1712372146; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8glfhFm/X2eIF0Nkd61jE+/iOe2enj8BzdC/2dzRn+4=;
        b=h305St7w9t/liFdtUdKT59TjT9A/eojRisjvOMCAp/Bq5mdopPxP5rRtGrrEcuNGVc
         DcYRHLcFvHIXUSR4YUwVQr6Zwv/EMeMMRMFfTO5XdficqWW0m2WSrj50G3JstDNTcxtU
         7MCq5Xspf9HuCR63gSihjdbXweWnM6863CR8uGnEbqNZXvAHvLcos2IjjAgjhL2lEz7X
         adDQDfgSKihh/yre/FANffhIH1++oYe9Y4oYNzG5bk+YYhtHFS3AsgWrB0aBXTy0reeF
         +qbQkOI//z7a5fYc+PHKvgpdmRC04kE78StalNXs5lCtBIb6Cwfyi0WB0zFQsZbgY5Rq
         3FaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711767346; x=1712372146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8glfhFm/X2eIF0Nkd61jE+/iOe2enj8BzdC/2dzRn+4=;
        b=vEAZLLtmwrKoT0RqwdfpwukkDM8nNZ0igUhfIAlAoWtE4Pta9nJsk7+Ftgs/mhUxCU
         Ix0ValK/sv/Xig6DAJnZ0AUlLgIaibw8c6cIdoOTiDqZg4SNgHxK2ij6hJIl7OJlIca9
         9kjQLVXSYRidwER2VUJXHIEmrvsWWG7V23rVG+DszYj56y789RQ8aEbSsSQBL7kk151n
         3t7GEI8U9whCvOJyqQ3RnZ337OuytrgVGIQpfb8L2rIP54+4haA9h7BF5BC4NHdYPbN1
         GzAVnO6hauxPYHCDCot6tJVOPFgNOBW5HMcIsbfTtEZgx7dqNvZqGJi7scWGZG0vEbUK
         Ic+A==
X-Forwarded-Encrypted: i=1; AJvYcCVvfyf1qameEHpxwzh4z8e2ypUNbzySb+9ainumHn7UfGn6dCe+LIBQ9oUehRJFEaDduTSsxEQnXP/SsIoosGQNyhKPBmY=
X-Gm-Message-State: AOJu0Yy9c6Xx/Gn5Stq9D8pA+A2LZBOocgeHcyWEArWcbMKc/of3QeaR
	4S9G/HEMjre2AMunm5v0OxqOazhm+J4gt3127f3svu3j/7hZm6aHzns7zzZw1uAT2DUnRmHYKtL
	75hcol43UaugvcntDbu65ZCIYH1x2Z5eCX3hzfyxGJvDoP/A8ZMqNdg==
X-Received: by 2002:a05:6a20:a128:b0:1a3:dc59:764a with SMTP id q40-20020a056a20a12800b001a3dc59764amr4414539pzk.37.1711767346193;
        Fri, 29 Mar 2024 19:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4xb6OliXnzmmC+a2AvHpBjl34nevNeqiwBBaQDRKuRe8GNrieLJEfK4fFkOXc+0OJ1x4pUQ==
X-Received: by 2002:a05:6a20:a128:b0:1a3:dc59:764a with SMTP id q40-20020a056a20a12800b001a3dc59764amr4414518pzk.37.1711767345737;
        Fri, 29 Mar 2024 19:55:45 -0700 (PDT)
Received: from pc-0182.atmarktech (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b001e0a08bbe49sm4225745pla.140.2024.03.29.19.55.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2024 19:55:45 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rqOsh-00B5mf-2u;
	Sat, 30 Mar 2024 11:55:43 +0900
Date: Sat, 30 Mar 2024 11:55:33 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"bumyong.lee@samsung.com" <bumyong.lee@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"petr@tesarici.cz" <petr@tesarici.cz>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
	"lukas@mntmn.com" <lukas@mntmn.com>
Subject: Re: [PATCH 1/1] swiotlb: Fix swiotlb_bounce() to do partial sync's
 correctly
Message-ID: <Zgd_JaCHzOOLqWUM@atmark-techno.com>
References: <20240327034548.1959-1-mhklinux@outlook.com>
 <ZgO3HlYWo6qXaGs8@atmark-techno.com>
 <ZgZNAM337-UEY1DH@atmark-techno.com>
 <SN6PR02MB41574B5BC91B70AE74E51FE6D43A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574B5BC91B70AE74E51FE6D43A2@SN6PR02MB4157.namprd02.prod.outlook.com>

Michael Kelley wrote on Fri, Mar 29, 2024 at 03:18:16PM +0000:
> * tlb_offset = 1 - 3 = -2, as you describe above
> * orig_addr = 39 + -2 = 37.  The computation uses 39 from
> slot[1], not the 7 from slot[0].  This computed 37 is the
> correct orig_addr to use for the memcpy().

There are two things I don't understand here:
1/ Why orig_addr would come from slot[1] ?

We have index = (tlb_addr - mem->start) >> IO_TLB_SHIFT,
so index = (33 - 7) >> 5 = 26 >> 5 = 0

As such, orig_addr = mem->slots[0].orig_addr and we'd need the offset to
be 30, not -2 ?
Well, either work - if we fix index to point to the next slot in the
negative case that's also acceptable if we're sure it's valid, but I'm
worried it might not be in cases there was only one slot e.g. mapping
[7; 34] and calling with 33 size 2 would try to access slot 1 with a
negative offset in your example, but slot[0] is the last valid slot.


2/ Why is orig_addr 37 the correct address to use for memcpy, and not
33? I'd think it's off by a "minimum alignment page", for me this
computation only works if the dma_get_min_align size is bigger than io
tlb size.


> * size is still 4.  There's no computation in swiotlb_bounce()
> that changes "size".
> * alloc_size is pulled from slot[1], and is adjusted by tlb_offset.
> This adjusted alloc_size isn't used for anything except as a sanity
> check against "size".

Right, sorry - so size is ok (assuming slot[1] is used, I conflated the
two sizes.


I'm probably still missing something here, thanks for bearing with me.
-- 
Dominique
