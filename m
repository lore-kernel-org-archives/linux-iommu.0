Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30877256C9E
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709385; cv=none; b=RXag7tDB2JN7ETfaT6ipAYLpmplFe4NrcTgBycJJCrAiqdZbNcl86eCMT1vweBC3vt0UzmbYVpFECk0na6tD4EJZMPMY6OUEMWER7KdEEesYqF9MWC/CEu4NLSR4XodI4ORcyOCM5le0BAKCN7y1GqK332OvWC6Z9zFnIqj4VNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709385; c=relaxed/simple;
	bh=D3hn8o8W41ASib38yz54W9zJegHoNaEKK0H0y7laV3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXWTr66Ob6kho8P/2SCfb8Mz87AY67gNXSWgE3HKqtjpSl5YItI1ae8NTpyU24nVeULTqUFtkZuC4LZID/NsZp/ng9Fk1xeokR0OPpPdmLGj1nn2b9i5s03/Dbyf02ASsN34yEjp4M1lIJavzXhFpbVGT6UVE29Hw2ApoTLUDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ioWXoHVF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ioWXoHVF"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a367a1dbbso13531096d6.0
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 06:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767709383; x=1768314183; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0D3CvlFcm4pr/seu4ZgrWAYZBh6R3LQGn6S/koqnKc=;
        b=ioWXoHVFgsGVxifT9sYUzyjmgUIkGwhLDYGe46e6Il85ivwxCEw8mLO9/Amr2kjL0q
         +HQqoKeY7bC3A+U7a+hdzbdLVB2ZX7OrcFpAHdauZ2E6HCbiRtiDE9umptRs6buVWSZ6
         JWl7sYa/0eoNVJTThS1OcHHuk2LxuFjj+Ia/zopJ0kcR888YhZC+xSCfx0kKPQXEsKLP
         eL5VL0HMgAT/hEcVm1oPSg7bMi7wqvrpAfhzKb7ppXE8qR8JIGi7Fow2flJRHEF/OtMm
         R3R35kH8EbTOyIloHajQkuph9NuLlgiRs3DrtaARHYgFtzsyk3+23kTXBbEBXQKi0uJb
         ZpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767709383; x=1768314183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0D3CvlFcm4pr/seu4ZgrWAYZBh6R3LQGn6S/koqnKc=;
        b=ZfO7jQZ8kG0dMXBaoEeaGFdN7YlBFI7HHJYvOO179JD94dGeyBDAqZL/DOL5rGFIjS
         FlMaNA4UIElBXnDUWdHwuFdkrKqbpPMaYGDcLyYqXgnILxStf0XyeK4nERZGe2nL1Ke4
         KcLeIebrZ9cw1xW2U1OOOKqjaHkAcJSK2G6IHMHzwa71+82u0fa/zObjRqbsv5JE01mi
         0ArcZaE3dKz42EiUZDIFOW/h3wEfNTP1GrUU6KFWivc9ays16q+Uxn2/K+oW3+gb2Yxw
         LCpSkGUiQaiHcZdgENiRHSfbYyfQBJaZVGT7JlC+W2bw4LAoMgrPY39CWByrzrX5nMqn
         CgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/z5/YwL1zv/UhJNNTRXaACDBTR2KfWojGMKo9rADnYvyWg3fkJKBquqFpETX5UrFUH9eHlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy13EbFkcXp9KOfCHZSk2BPcXpKQ3kOln0/1GdDz2RNognrzPdD
	CkPShvztGd6hlz2rFEiRk9J5KTVdBCIjYs8gtopMOMl+LwVNvdBfdaAUSRThTXdf/aY=
X-Gm-Gg: AY/fxX5dQP/oWSRTtmIunIxlXja9q02V1/pB65OsjvtG1jFG9XydG+mdIl1VzHAejZt
	P7xWyJfI6HPI57x1IgJargxO75z/IE3zIP++9ZHO4H/xBwqI3VtdhdcydPHtzekFRxA/0YopACG
	tkX7pW4HDMiPkujRb8H/q4OO5+t1823I5oMscNHSoJTyhpcZx0emQ5L6yGXPjKF61FSScPeAp+W
	AHgiTg2xq+FlVxlV4T2s1hi0jdpe3KDPoWF1UsmTvC/7+VoR4KBgK0BZ9bhuWUkpEF83xNqS3d/
	EhQy/hO4F3N1peplahZ0Ui4rH2eetr6qIIFv18YS1+qEbLuATyUuzFkMfqGTkmxZpsZzBJrZHN8
	klU834yE21sVxiOAQEQNT5TIETFsLIlik3Rd/9wdMgYEvrvWuWnn89pHvyNK0jPU+B363lE14T6
	RpfZeY4YB3PI24OgpRrmqZmXcAAkuCMwXWwaKrDxne+pUgimXkW2wWvWAljvRheDsrgFE=
X-Google-Smtp-Source: AGHT+IFzGRnnY+E+PXxkKzl3qVqNXYs8quD8xdQVu6fDbp50qflJwpcycz/Aa/6inYojSY9MRZgTJw==
X-Received: by 2002:a05:6214:590f:b0:87b:f369:35d2 with SMTP id 6a1803df08f44-89075ebba0amr44896036d6.39.1767709383008;
        Tue, 06 Jan 2026 06:23:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772682besm14029016d6.50.2026.01.06.06.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:23:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vd7xd-00000001QS0-3KsY;
	Tue, 06 Jan 2026 10:23:01 -0400
Date: Tue, 6 Jan 2026 10:23:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Message-ID: <20260106142301.GS125261@ziepe.ca>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
 <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca>
 <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca>
 <aV0TalseaDGW-1Jp@mitya-t14-2025>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV0TalseaDGW-1Jp@mitya-t14-2025>

On Tue, Jan 06, 2026 at 02:51:38PM +0100, Dmytro Maluka wrote:
> >    WRITE_ONCE(non-present)
> >    dma_wmb()
> >    <cmd to flush caches>
> 
> Regarding a barrier after clearing present bit - good point, I should
> probably add that to my patch 4 as well.

It is already integrated into <cmd to flush caches> I showed it here
for clarity.

> Regarding flushing caches right after that - what for? (BTW the Intel
> driver doesn't do that either.) If we don't do that and as a result the
> HW is using an old entry cached before we cleared the present bit, it
> is not affected by our later modifications anyway.

You don't know what state the HW fetcher is in. This kind of race is possible:

     CPU                 FETCHER
                        read present = 1
    present = 0
    mangle qword 1
                        read qword 1
                        < fail - HW sees a corrupted entry >

The flush is not just a flush but a barrier to synchronize with the HW
that it is done all fetches that may have been dependent on seeing
present = 1.

So missing a flush after clearing present is possibly a bug today - I
don't remember what guarenteed the atomic size is for Intel IOMMU
though, if the atomic size is the whole entry it is OK since there is
only one fetcher read. Though AMD is 128 bits and ARM is 64 bits.

> I was talking about compiler guarantees, not HW guarantees. I mean: when
> setting some other bit in the entry before the barrier, if we do that
> without WRITE_ONCE, with a mere "foo |= bar", are we certain the
> compiler will not implement that as, for example, setting the value to
> 0xffffffffffffffff and then clearing other bits (for whatever crazy
> reason)? That would be still a legal thing for the compiler to do, in
> terms of its single-thread guarantees?

The HW doesn't read the values the CPU is writing, so it doesn't
matter if the compiler does something strange. That is the whole
justification for why it is possible to code it like this at all.

The dma_mb() is also a compiler barrier and ensures all that
uncertainty is resolved. Once it completes a DMA from the HW will see
the program defined values only.

Jason
