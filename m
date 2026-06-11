Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13533EDAB6
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179183; cv=none; b=Yk+IUOIwheOxheFGJalYUBmGdteqRQsBADAj+/hzcjjTBpeVtKM8fTKkxulhiLUCfPUeYJQfaAMjy3Hxjh70S58PnQTMNEeDiVT5YNO5dh+o4RWkoBBvLGsjEDFWgAnbhVK3laA6ZteuXWy1e/B8eraCak5LBTwqyi2sKDsTHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179183; c=relaxed/simple;
	bh=HXI+6KUA5mCzTZAPeYkUL5Bgn+onXknGZaQEl5FIVI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5bC9pPwmJI/fvERzvWvAEcq82NrvwzNfwkTlHp0/GvMNw3sF1Yvq2+2VY/g3YaW1ShJSxpbi30Aq7IM/gLCnTmOdItAOmChqgEUCEtCavfUzTC0QNkG5WLJ0Epxl9wJQkzcXJMAjwwmIM4dwdqnPqyKoF8RLEd2YKCSbXmGOYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MNx8ytfX; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MNx8ytfX"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91562bf6c12so947229085a.2
        for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781179180; x=1781783980; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvizeKh300V4RgKQE8JEUwSI0zRPQK5L8Dj7T0K8bjs=;
        b=MNx8ytfXkpk9nJsCrSJVTi+sKKiCQ0gREHxI1gW1OooINCqI/q+Gm1qE6nd+X0H9dw
         KGlr0dO7uYMSVjxh+09pJKVd0zs5SD/8xEVIjITsFIeT0HiphuJTrMoYEIp+94mwh4Yp
         CZJhbWVo1UfXIKv5nr5cEDmeedfao3WsNurzz8i1/mYiBXTtPOtMIW0YiYpsJRQvrsqO
         1Bz1HzjN1fUJkGEmik736XfSUMdrRleQjkuTkg0dqB4m7AG7LEjqZblF5gH7MTJHqkha
         TH8E8uzDbd0/tnXcsuHfcoiavP/MfopuFi8Ube/5bnBO4Ow0k8U3sfCgo+sCJlk2hyBA
         Bj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179180; x=1781783980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvizeKh300V4RgKQE8JEUwSI0zRPQK5L8Dj7T0K8bjs=;
        b=bkjvIZHsu8l+GIyf7QhvAivSN+5ig88e7txyNSOparJq+EeEOyrEe8cpphydTfuMF5
         G8ZZ3zwp/LfPFDNyYLz9SqFiYFrLiaxASyqnoOtRg3RDD9uxGBylkdZjbKNDo1b/tuIv
         NPLndzqohnoVYt4lsFT+J4WbXWOmSTIpUoBSjV/R9PI2Xc3EUpM2N0wdojZ0VF8OUsTG
         LDpuGK0/64CriviDzMrCjoNcW4jHKF0hubkqyUXepgpbo1ZUfDHBc4OuPBCrMQmlbP36
         3V7th+zi7OX2YdgOX2HTTvSrWBGa1/e6KhxLiCEt6gZGXGJRRE0keWWK1r1xh1mBEjfq
         RzHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QTGAe3zSbVXzZt9natfKgOu2X7t7rgcguJsAO2qZ389VCPaHTefDUQR4yMfh8hcv4J8SI5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2Z7VswP7Qr3gzT6Wjv80inyR25EB0OdHbFE0XkTHMOqapBrnv
	8Tg/7NLNj7P6Zu+Y3OuPDLGOkL8dYUExSwqfiQuQSTV0rZuqvaxRxn0KN3MsjlUk5eU=
X-Gm-Gg: Acq92OEWtP2Uqy26jS7MSkgsGWHygzTARRDCcOGaRuaTdcBY6uz33+CSwRTt2SWlrb8
	dcGUXkeaDPxxL2c//r3POAFzWnlsBnsapZk98gpasYb0fyhkmVGSPk72nNK2/btfhe9v0ymEkuM
	ybn2Jx872IQ2bHYu6rDBcYxyETah3SxgI58+FbOjvBtGp4K4FM19evzX4vYFI6a4kI93j4PNBZJ
	XmPkNaVOdqJd4kq8MuLCG2kdezIvyBTGNRE+kTBWBFky9E4GR/trB/8ykhLS0mcqMZRuTkZR8xC
	jHqtzuSv5zsZCveO0Gy8r7824XbhZbIyED/JnH7TGDhg3dLFasr6nFj7pkV1yMzyrFWJstaVz3e
	vBsdizUo5Z5aKVSp7dMgn5VcNl9ttxb179+n7IIFtXPA1gfCBmyGNx0/qPHLNo5BfZ+caW8MeBF
	GxoYPyiEvxSmkot3cd9mcjdXNvZldrk20M+Xxi7O6ijG3u/Dk2i5tRU0yn1/u+CNFFkWEhY9KIM
	4yR2MG6GAPwiMczCZcZBeTGYyA=
X-Received: by 2002:a05:620a:2681:b0:914:b65f:6abe with SMTP id af79cd13be357-9160ac976ffmr356715185a.5.1781179179928;
        Thu, 11 Jun 2026 04:59:39 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160adf5832sm163280985a.31.2026.06.11.04.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:59:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXe4Q-00000005hL0-1GzB;
	Thu, 11 Jun 2026 08:59:38 -0300
Date: Thu, 11 Jun 2026 08:59:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Li,Rongqing" <lirongqing@baidu.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>
Subject: Re: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2?=
 =?utf-8?Q?=5D_Re=3A_=5BPATCH=5D_iommu=2Fdma-iommu?= =?utf-8?Q?=3A?= Fix
 wrong scatterlist length assignment in P2PDMA path
Message-ID: <20260611115938.GF1066031@ziepe.ca>
References: <20260530112852.2321-1-lirongqing@baidu.com>
 <c666e384-b365-4891-a01d-736948b995bc@deltatee.com>
 <5e2f30a4121e4672ab309460630d011b@baidu.com>
 <c441256c-e4f6-427f-9f25-7570c991a420@deltatee.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c441256c-e4f6-427f-9f25-7570c991a420@deltatee.com>

On Tue, Jun 02, 2026 at 09:42:40AM -0600, Logan Gunthorpe wrote:
> Hi Li,
> 
> On 2026-06-02 00:12, Li,Rongqing wrote:
> >>> Fixes: a25e7962db ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
> >>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> >>
> >> Hmm, I thought I had tested this stuff pretty thoroughly so I'm surprised I
> >> missed that. But I guess seeing the users of these specifically don't allow
> >> mixing with anonymous memory the vast majority of tests would only have
> >> one segment.
> >>
> >> Can you confirm that you've reproduced and tested this and it actually fixes a
> >> bug? Not just seeing something that looks strange. I have a vague feeling it
> >> was intentional but looking at the code it looks wrong to me too.
> >>
> >> Thanks,
> >>
> > Cc: Christoph Hellwig
> > 
> > Thanks for your feedback!
> > 
> > This was found via code inspection. You are right that if nents == 1, or if nents > 1 but all segments happen to have the exact same length, this typo remains benign by pure coincidence.
> > 
> > However, for a multi-segment scatterlist with varying lengths (e.g., a short 2KB head segment followed by standard 4KB segments), sg_dma_len(s) will mistakenly assign the 2KB head length to all subsequent 4KB segments. This will inevitably lead to silent data truncation or IOMMU page faults.
> > 
> > Since sg_phys(s) correctly takes the current segment's address, sg_dma_len(s) should definitely use s->length to match it.
> > 
> > I don't have a specific P2PDMA test rig to force multi-segment lists on hand right now, but the typo and its impact on varied segment lengths seem deterministic.
> 
> Ok, yeah, I think you are correct. My tests that ran multiple segments
> happened to all have the same length. But I don't have the hardware I
> used at the moment so I can't test it either.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Rongqing can you please send a proper series with both of these fixes
without threading so Joerg can pick them up?

Thanks,
Jason
