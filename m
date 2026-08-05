Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B63DAAD4
	for <iommu@lists.linux.dev>; Wed,  5 Aug 2026 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957080; cv=none; b=krNrSMfRR3UnlaQKjOr/b7awZUf2AtbwSTMve+XVg66ze4zzPt38r1uKJ3IA4HmEeea+1Skv0AlKtTjH3XEX1mnOZ+If4v23L3VzBy48FKKQrQasgk27GAlHseItH+LfNsou7Yrx5q6zdLWLM0GbBEd5J4JWabEscQppUYk9Tnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957080; c=relaxed/simple;
	bh=g6HU23i5fSRX/KH4Y44SrBTLW+Efym3AnaxqepOQoxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFZ+rrfx5zlRVLz5veeT4W3x/iYA3cYXc8tId/rJ9BCva0mhF3IrTuyasqFcS+KFc2AumM4HS5zjFrazn18M6Mr+QAWIcQBk9yxNRc78YzY+QnaRtgnzuUnA7YcA6Oos/MTaU2cgqhhBsIPy43LRLBxBp6Ocopmmy4I7wiL0HKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ic8cgKZa; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ic8cgKZa"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-527e352a167so8915991cf.1
        for <iommu@lists.linux.dev>; Wed, 05 Aug 2026 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785957077; x=1786561877; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b0xkTaFSxQkbT4PpYQuH0yFvquaeQpeK5woUXN7RqdE=;
        b=Ic8cgKZaClklI6NVhyyJYZchxh/9iBeWgRpm7GQF05q5UuYXn8V3YEQsnIJXIlYpjk
         cHsTH0e1vuIqdFv6NnW2Dx1m98pAg3zBRNGTMTBr27LraNl2zP/SYotHYLIUAw18aGlb
         tU5345AVoqz3pR7/8FG6h1Ue7YEUNcKVim/ZhtwwVo5U+fPXT5AsWf1Sa5/sUA3NNL03
         acAm8LravVx5vbdyMNO4fbQwtsvWIXTDe5NU0vWLvtlmgcq+bn0SM1B+NbqAdW8JTDU2
         pxoAkGQBZU5N4UF9eokuy1R9nDPzc3P59cSRGpNZqaTvS2xUb+4n8rD0Txd9+vXqABjc
         CUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957077; x=1786561877;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0xkTaFSxQkbT4PpYQuH0yFvquaeQpeK5woUXN7RqdE=;
        b=Z7SwCcHwORUyKatqh3YnqcHUmmcomrQLQ3lDwanYl054gM0j2SkXL7qM4BF/ed5/yn
         /ztrUw8Ej8/XNqA9cBoxqhUJELixMxpieWYzqB6oKVz6O5uGVtHTHJgg4cntSjpX8G40
         DpW6R4rHwbX4tBdX2E8MqLhfoLA4eH48aNqhFMsy556Ww+nOyN9JHcsNhS+RN8Yz8okl
         qbu8uFg/h0RD0Fl7UL8AM+/ES3Ux7XfVyZbzupgvMRj2ty78yx0rdHysOgq3fks8zxgI
         Sq/DowHnkfdM+dGxIjcarHIOc/7wqNLG4ZrUHlweix9IMUaAhkREJupNnYOZxG/p+FLt
         nGhA==
X-Forwarded-Encrypted: i=1; AHgh+Rqvj3j3FoknauhPURkX627AqMJUpzgm/wJCbdceVDP7hTXhI4e22gMVjnV9H6zN8j5ufblg5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEki4hcsFEdyO6nrkMsoBqZze2mlHaacrQ+XM0kHK6wv4GSLQp
	bPIzQDjV/R3l+Bn0dSSx/RdoN5t5PKj8Pdw9NzjZ20k1icdO04kNiEBX9DijBWHNGPw=
X-Gm-Gg: AR+sD108uxhiY1HBPxUUneppyfAYZPPGBPQ/Bn3iVRlDWcmldmEo47a5EBWJc5zX4VT
	anQuiup+6K6EQ86JQz4f6kQZsis8FH25G1EEa6n1JOQctSbjPboF6UETIN8x4I7Ox4vUgE1Itlw
	MA38Tbtx5XUX2OiarfbusVWJ9oRa/FmD93mCHz2my4FIqvUNIFfVeImEzRECHUb3WK3O2Ls1rr0
	A6gHeEland6Zix6S+6RboWHStjRLDLC2sPNXL9tGVienx0Mvler6Zhcfm3byMagvowFffc1SL7F
	dbTHpTBgQMhHSu0HvgZlrrv5mi6Nth6PDUwN5hUkDl0z8wT+x2K/V2tVWCOnGWLJZ1A9X0FFjm/
	xG6BiX9J0akJFoKOmb003hPH4RruZa0lCetVqgY9am7sLNITCE3WuCMpfERjcwlZP92bVykd2fS
	4qq7rTpP2Sr4omU0inW23agDUu2gYsei31zXAsJg==
X-Received: by 2002:a05:622a:480c:b0:51c:1c73:5943 with SMTP id d75a77b69052e-52ce6145233mr106545321cf.23.1785957077642;
        Wed, 05 Aug 2026 12:11:17 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffe0f93sm32516756d6.21.2026.08.05.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 12:11:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wrh1I-00000000NIN-0fnn;
	Wed, 05 Aug 2026 16:11:16 -0300
Date: Wed, 5 Aug 2026 16:11:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260805191116.GE28508@ziepe.ca>
References: <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>

On Wed, Aug 05, 2026 at 06:12:05PM +0000, Deucher, Alexander wrote:

> > On Wed, Aug 05, 2026 at 05:22:22PM +0000, Deucher, Alexander wrote:
> >
> > > IIRC, they supported SME, but it wasn't usable due to other
> > > limitations (e.g., the requirement for identity mappings due to the
> > > display hw bug and the latency impact of encryption for displays in
> > > system memory).  Do you could effectively pick either SME or displays.
> >
> > IMHO the GPU driver should fail if it cannot work because it can't reach the
> > IOVA space requried for SME ...
> >
> > I don't think this should be a iommu problem to deal with
> 
> That means no display for the user which is a not a good user
> experience. Most users of systems with integrated graphics would
> probably prefer displays over SME.

You said IOVA translation doesn't work at all on these devices due to
a bug, so what is the iommu even supposed to do? It can't select
identity because the device doesn't work that way and it can't select
paging because it doesn't work that way either.

Or are you saying paging sort of works enough to do something
half-busted?

Why did AMD even offer SME in the BIOS on these systems if it doesn't
even work and turn it into Linux's problem?

Jason
