Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857424;
	b=VLFKrgLtgxYRWK4kcWkoeB3IcNRKviZbQ0aeDpiYFee+5ynpAA1S9lQg2puG2H/JhfAX
	 ohOLi5vQrJ4o9BJLTIeHCMu/PyD9NXyHYhE4KssHTEan5OfxHU4MrvskYoDvcfMypqC8H
	 efnO+wLoq749FUL4SnjbzgvR0ThKVDP2L2xZ0Tmx/rBNMaaPeCl7INYX5scPn2RMQoRWk
	 iP/pAaNCZY98eTgcJ2iUiU52HlRwIUffFqa8By9iHTvgeWNwOOG9bPsUf3Q6wObc8/kbY
	 t8d4q+0GkVlgoa8/Jfw+QdPs/+1WbQLZk1F5EBDmd5VKVg8ulxsLEiNm4AWXK8M4aVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8Y8Yw9LOdvyV/HcUuJyObmf9/gu6aH92RylQl5nKXvI=;
	b=SxoevxVOtGavjaN9uTzMITAI2InKXSNCzmswOggwEl59CJu8/qXYcF0T/CrRlHrIhJ69
	 8hmV7WGMNajR9nXyXJq2Y8vmu/VVdUwo+vbCqTWMM7+54Z3SPcXqjebzX+qG7RAqWqYNh
	 Qp6gs4WQD4tyLF3zFkbpuE9l+OwIcnIAFMuTURTLRtn3c6XzHofp2PF9MaMy8sGzQXre8
	 aQkvZOS7FItTDjLWX3ZjjJ7ZJGJhH0v5og5Zp+qgW/9B645YiSmFF2Q9P6mkJMDwR8Ug+
	 9cJtqkTYukYxpKenW5FwiI4Z40biNUBMhyPX0+E3hRqr30pLaKimQEkMcnw02urb0Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="RQD/txRi";
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D96606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D96606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RQD/txRi
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9496577d4c4so19907885a.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794857423; x=1795462223; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Y8Yw9LOdvyV/HcUuJyObmf9/gu6aH92RylQl5nKXvI=;
        b=RQD/txRiRUFi7AwX7Om/2sU0m9cWKtXi9W/mBpWJEquZMKjsTyj43jBIQvgRESRcPR
         FkLkGztJitS7hqDPkWHUi4gGlrTV007ocbJp3Crqq+ri9PNUrlVAbE05xhE68q4UhDa6
         nhkLtw2GHI/18Yl1NFZZKabzvLXV73gH5HKtpVfGpzs0IWc9i4GE5G7sxCbu6eRCWVS3
         keYL7bVg8Uu9/MN3v1N6OAi/Xb6r45m2AYXOh1BtukOtTvCJJx6RQzeasHVSpbesVr/y
         3VvcvawUZ4bBY6r5+Mf2d0QZpqSipN7Y0wAjIV91VLx/uep+QB+3v1LwleSAz0m3FAze
         PFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794857423; x=1795462223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Y8Yw9LOdvyV/HcUuJyObmf9/gu6aH92RylQl5nKXvI=;
        b=eYbK9NPrIfwzEgGQc4H4KdQUT8bYujDo3NMd6DSUw8A1MArky6tDPCb3VBnptZvVkP
         6Q5bGYAZHWRaEsQ84lufObQ8xQqeW2at9nB8y1BjszmduukJOwW00wDUYSfxImdOma7r
         dwHyFaGz9ztqgp/wqNXpH093q5VjkZypaN8NsOtzntIHB4+UpaSIk/eMPdUxvssk8I0w
         aTd0dX2DNJAb01OEvbDqNzwWaopsMdRbD//+9tIN3X3TUB4xdEUFeC3N93ofCuEQjg5Z
         mCBIVzWd/A9kVKqdtstrT/440rM2yOvo4suYdy+FUbA4Uh+9UbJ0cPLKBlt5xG4UTyuI
         dElg==
X-Forwarded-Encrypted: i=1; AL+hErEsj5oVWbIIYK4mNaJQ7bK+ucBpKOt2BJET1MsZ/VwiVqlsBstYhoPYMyF2AaiNtEwA/8GWuQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+7Y0ZmF1/eQPkLPIUbA8mwcRtgjWabwusIt719ikXGaKpKKM3U
	vkoCCoIKS6f3xjlq8HjOXdcUvzoqIDXFfS15XHpirHPJK/P13nbdkBPDCJ2ktkyzbeg=
X-Gm-Gg: AYBFou2oLhpcTymPwyADtS+IPGaLsDRqKsAFfTK5ELt9JanPByDdj2nuAulJ1BQ8AM0
	6K7KFw6G3IXInwXD7KNjuHT6lRi3L6NwcsP7iGsvZhiqiegsOGMWzYTrGBLIZ98kkNIwmCsKjsM
	nQgf+pjBZGZyOCXAwZQuFJzRzaBOELw0AwmRAIDP41OKaTKm9S5yzaApLrF1R+gqJIDXznRvLFD
	uqnh16JmyQb/Pjv+WMnBWRrKRmN+3wW75caYTItvVIvA0kLrqHizla/ODfqQtCaiML+6Q4UVnQu
	SbBoUZvXtf6DuAwkW4mQEv88f351d9bE8zZmQntnuA7uvzKuPBqa0u6r3+oCVaCNoWNQhf6x/Kb
	DxVXjE2vMHE3VgfT4hADyT/X/clyWjd8WFNFhA/GAD9C0SDIw0EhgfI/3Nk+gs4zHRA7T22TR+u
	oPYQCJpPAAKZ2hsfFIIeKSR/PovJ3/nABZGyraTm5u0vXzyEeyZ7GtqIe30Z4HMNYNfId18uTFv
	/8f0IQ6hjWHh2Q36ToAm7DD83u/cMyaPNIMpyPRHO21QZ7AWd1/by+SjikZ1+6GYi3OEJK6d4YP
	Ow2+ng==
X-Received: by 2002:a05:620a:4406:b0:949:7058:dbcb with SMTP id af79cd13be357-9498b875510mr84935385a.14.1794857422999;
        Mon, 16 Nov 2026 11:30:22 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94978ae5483sm390417085a.12.2026.11.16.11.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:30:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2PF-0000000AJAU-3HLU;
	Mon, 16 Nov 2026 15:30:21 -0400
Date: Mon, 16 Nov 2026 15:30:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@kernel.org>,
	Larisa IIeana Grigore <larisa.grigore@nxp.com>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v6 0/9] dmaengine: add DMA channel bus and fsl-edma
 per-channel IOMMU support
Message-ID: <20261116193021.GB2452510@ziepe.ca>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>

On Thu, Nov 12, 2026 at 03:53:03PM +0800, Peng Fan (OSS) wrote:
> I used iommu-map for eDMA, but iommu experts rejected it:
> "Using iommu-map to describe synthetic dma_chan_dev devices that the
> kernel creates is the same kind of DT abuse from over here:"
> More info: https://lore.kernel.org/all/20260917144804.GI3196566@ziepe.ca/
> 
> So I followed here [2] as Krzysztof wrote for QCOM VPU:
> "Thanks Jason for context and detailed arguments. Robin did not chime in
> yet, but from what I understood the DT-child-node approach will be the
> way we should go here.
> 
> I accept above point of view and I am fine with this, thus Vishnu and
> Vikash - please go ahead with DT-child-node solution we had some time ago."
> [2] https://lore.kernel.org/linux-iommu/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> 
> This series adds per-channel DT child node support to fsl-edma and, as a
> prerequisite, introduces a proper bus for DMA channel devices.

To be fair this is discouraged too, now that I've seen 3-4 people
trying to do exactly the same thing I'm not as positive about the
DT-child-node hack.

Can all of you come up with a proposal that doesn't involve hacking up
DT just to unbundle the SIDs?

Jason
