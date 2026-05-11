Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C313FAE04
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508971; cv=none; b=VLvnqq1B1v9cxu2J+jMUJWQYFyJDyJmSOT9SMXICCDurq0eMrjy4NB8FKDhct8SoUQSq7/Ddql+VLt1B+xHlKlBhgW4vIY0ockY+THk2qv6ijqiDqhAwm9LiSbcaA6OafWmr+dIfYroZnOWS5Yt3CZJU0hfQ3K1VV1heJVZxRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508971; c=relaxed/simple;
	bh=Qin6jo88CkHlgiIxNlYjfJTx4GowjgUxVDkj317PXw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxpRZDxB7qry//foxyPZ+A8lVdcqsw9qu+yh3iJU5xs826bkY1F1PDyPJ3w5oMSuTz3A3Y8AL19QirilFLYtmPzPeHOZitLCIz3XjRZPl/ND3L16HtZ8G51UkZj2jINgpOiv727GAWPKYgGaNjpbPdmQ9jty0YT5W2RX/pgdpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YUHyZnRz; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YUHyZnRz"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48270f099d5so805621b6e.0
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778508969; x=1779113769; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2XYfpgDr8rhwU4VmZAcmnr3FHYX6CTKDgcqkhraCAE4=;
        b=YUHyZnRzykuehKnEdfTeYv2sZwi+DMVoYIpcdAecT+4nHH3hP0a4BePQuZ/XsikDz9
         U4akuI6bGqel+Z68TfHLJHAVYYCVY98HW5aX4R3tST6Bpu7H0dAqDwV2MiFmc7jfg9Ho
         +wMl8WrPqZKeljeHmNmmgMOUaSGsm5XfxPYvEnezR8l5zTXGKdRJowT3B/NIo/WbtCmG
         batlnedon4oEu0WUVlEzSorCnNZ4tRxOREfl+3zT27hvDzbfLMTgRab+BdnLwgGrib5X
         bPsV6lgBaYEhQccol6bKmBbuZmWrWrK8NtGsw+4gq9x42Nca3DPE+1ii4pKGvaF7RllQ
         IZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508969; x=1779113769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XYfpgDr8rhwU4VmZAcmnr3FHYX6CTKDgcqkhraCAE4=;
        b=PTXaskxFVtaT1M5KaxRR3K2LBXPmHQl9QjAcBzxIm0Lluli9pk5mqd2jgbWD6dIXzQ
         u9O1DXwr/oIGE02v/BDrH8oTTGXGG5twGCzAejUspx/gCxGr1sGLnPcMBpDS/zkR0fkF
         QIzBtNJHI7WdSUbBZ7PC6TecYU9E1870dr0ka6ER0jorVrxXZGVUdDYFoeQ0TcX2er1Y
         i52GQg69YV4Zq+rdF/p/UdA/g8sFYZRIJ4oqx/Ugnes2BLqWi+HUZWN3GONzaj1eV0GD
         DdmVLNP7A8MmCs2nzpfHPru4HJQO1kRQlF8MemdIkkDReRLsfDHkiuC+vDKgQ6NSd9sH
         Rl9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/p/4iRxeN2sjGcaiNGMJb3/afS8Um92L+dZryYCoJK9YYeicN+N9sFVSF7C45erScPX/dfRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWomidVueippHOTwH8mMXGgEPnqv3alLkshXfGsBr/jJR4RAK8
	kh5j/9s1mkS8f7BnE+JaLzdf8x53mBWqzMxOhyV3BTQzUAUFEWjWJbCD9s1p4b8ylkw=
X-Gm-Gg: Acq92OGt78giyC7/G99nkvr68CNaD+aDqI1sxXtDoyyR4pOFXw27bxgDRlv2J0WDgL5
	VJyy7RAo0RGt9RVPWK93CFZvOsUMHmvBBe4exVSoRs5jj+ErUahDYYknTqNNT+YsrRV1Ei5t+/3
	ATpfe2/Xc3IGKhXP/QRDnVTckS8iOCWelDy/LT+74XO2zSoIg11IPAJoZysm/f5QZ2pG/iezFvp
	sWlAqOD0lusVQ9aQFXzh/fg+acCpZ6G81CAKBDGKdZqFo/13s1pgsh52VK33+VmO5tnod5tLQ06
	ruyFXihIIyEqPzKOShzR5oYqL6H1BTnQBffldIjB1jb7owzw10OFAPxSsARfCkduKvuJI7h2U1c
	9voNKS3VT2yE1XSw4On7Jf+f5RIiobWDlJ8Sql7A43XGlGbSrGbpmej1eL90zSXiFyRMRHsdr4M
	Tqmu5XG0n6yHRTcJlb/dGMqwF6CTK4fmC8eO5lhlkd/icnsN2n5vzrtI26ILxPop7dBJf4h96e8
	4ZqWw==
X-Received: by 2002:a05:6808:2382:b0:467:1da9:2b0f with SMTP id 5614622812f47-480424ee5eamr14020119b6e.34.1778508968626;
        Mon, 11 May 2026 07:16:08 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7e3d90sm88620031cf.20.2026.05.11.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:16:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMRQV-00000004oAh-1lMi;
	Mon, 11 May 2026 11:16:07 -0300
Date: Mon, 11 May 2026 11:16:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <20260511141607.GN9285@ziepe.ca>
References: <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca>
 <afu5Y55W5oj70b5v@google.com>
 <afu69hAtkRlI1GJd@google.com>
 <20260509171451.GG9285@ziepe.ca>
 <agHGaJfwPr7-F1z2@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agHGaJfwPr7-F1z2@google.com>

On Mon, May 11, 2026 at 12:07:04PM +0000, Pranjal Shrivastava wrote:
> 
> > Thus the quirk should cover the VFs too and also disable ATS there.
> 
> I observe the quirk does apply VFs but after the VF's iommu attach
> because of how the pci_iov_add_virtfn() is written:

Ah, that seems to be the issue then :\

> While, we can move this quirk to be in fixup_early / fixup_header.
> I still think we should add checking the PF->ats_cap within 
> pci_ats_supported before bailing out happily (return 0) for VFs.

I feel like this should stay in prepare... supported is a differerent
thing. Maybe the quirk should be more directly tied to ats_supported
instead of whatever it is doing now? The ACS code calls directly into
quirks for example?
 
> > So I still think my original suggestion is appropriate, fail to probe
> > the iommu device if ats prepare fails (serious PCI layer bug, like
> > broken quirks) and fail to attach the domain of ats enable fails
> > (serious internal kernel malfunction since enable must succeed if
> > prepare succeeded)
> 
> I’m concerned that refusing to attach a device because it isn't ATS 
> capable is bit too aggressive.

Sorry, I was thinking prepare fails because it *fails*, prepare
succeeds if ATS is just not supported and won't ever be enabled.

But these odd cases where prepare sees ATS as available but can't
prepare it should fail and that should fail to probe the device.
That's exposing some kind of kernel or device bug that someone should
be fixing - exactly like you discovered here.

Jason
