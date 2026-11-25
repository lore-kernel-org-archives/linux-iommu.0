Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620331;
	b=u6rg/F2f5l5ulVD92XTUrO12j6u4bpNe193IRd/tHMN4l/ezA6cEC+oBuM+rFXRBgyIh
	 kz/WBrcVvTvdzuVNIlGJ61Thq5Z4y4w1pYYdCFzFMOx0EZJ22oMjGf1uw5dTz4+KCT8Or
	 l2PdRmaW1l+3QtpfJdHcR2pgW69acCcQGebCJiHKJenbNJkfwX2okpKzyEYW1+trs4pxq
	 Q48bXyzXLwXQX0oHEtLtX+yZc1nT2ABP+dT6Zs6FM4Qw7hya1JCSrm2Mpk1f6Wed1DCyY
	 RKNj/QbZMC1EY3e8re/GjySsy39OS4J7NeaqRcakWSBbnVgz+WpfP0p8IFBb3oAevxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8twhPZWezouYqnEgR9F+FlFfS4vpJ/v0U2VffsuCrB0=;
	b=I2lx+XTkgrQ/fKJrUZ9C7WINN7S9rYrocXbdOfhwOzcr/0GHV1ClYQ4tI/sdIYnxpFGs
	 KShJx6oWWYk7bWeQg1ujxumiok/6qmcKI6HevJODbJwE2UWiCIKJkW9pgwcKKAqlFDcS9
	 /aqzaMSmBZKDERcVh5Xx83tdgZcGlks59PJKMAE+mDi0G/6r/z/e2qQe8wZot2ig5dTgc
	 sYJi1375WnNXRaSgMClzIFZUfHWrurHjtqkm2IOe98oY0R3zumRWenC8I7mayvgNzcUvM
	 W2NEeg8MqZZm253cj6ck2GhEsQ4pSwCY9CZtcO/QYhW25Jw8UUj9X6IsUK9xQCLmF6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oXvAMhEh;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56D606A329
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 15:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F56D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oXvAMhEh
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-980c4258105so3343886241.2
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 07:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795620330; x=1796225130; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8twhPZWezouYqnEgR9F+FlFfS4vpJ/v0U2VffsuCrB0=;
        b=oXvAMhEhR0UY/Om/QDZHoOQuwHzJ0pn16rqKr9IxHq/PDpsgO0tNv3bwqORRpL/PJT
         E/WHPq0LQH3t4qF0OSYDOMBrrmy5wQkHbuNmBmVbTffZ1SAAOI6NW8G2PkKhXgeT2Ijm
         dv/RxafjEqePqSneFyq2TqkP511F/s2zvrtdG/l/nRNfWeDK5T9SiVHZ1nCxlvaFItlf
         D6tq1ztVHxmCcNGywdpeAT7kowl+LCio/qaQa4DwH8tTBWMnug39qDLy225bukVz3M0O
         TwMI+k2/iRs4LY/Agr16wVFW2r1x9EYswMqgsCiRm2iK0DS9JINt2tmoucqEXZtvkzC2
         yiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620330; x=1796225130;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8twhPZWezouYqnEgR9F+FlFfS4vpJ/v0U2VffsuCrB0=;
        b=r92veoByFhAu1dTlW1BThmgu5G5aHJoUiNfT2IPTf4g3uP3E8EAjqdaT77h4jiImds
         tm8c28gHhSC3vtFPaoxMiTxsDcxwJIqUomI5fFI+p7U2YSXhr5F13JSYC2fNRya2eKqe
         YWZv/EVYtgd4pTwTtX3ByETiNJ/5pxiGozN8dvu3R+BUvEhp4mbKfV1iFrjAQHXlvp82
         NC+cKoQT85EetLuLR+uo8gz9HktsrrWXAwPS42amCWJsU60Ar1C3+wvuc7qi5yBX5VMA
         8dLXXqgWbCap9Q6wFj9Hiqt4D/gUKl7fTUnp9+KNQ1GmWxkcWY/Y+oIoGJImg0e+O3bz
         /UVQ==
X-Forwarded-Encrypted: i=1; AL+hErFneR5F7N/9gZBB8H3H6DdVpcMSzrSPL7+RsDJEuFCBeq+jq3dYF33YOgV18XY5acrOAFu1WA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+mtEHAk6F6C3b74boTH8HN6xB8uEk8kjFXjlBapoL6kz9pXtCt
	KOdHdZ/0Ep117/zuwi6iIYeKLOHBjW1nW7LOvF4s5OM/1mznBwisiMvATetg7gHcqLY=
X-Gm-Gg: AZFdTZceF4N/qRzCL1GiTfXxpKBmssSRLxewMYbA4ldw6ohh3HQrOkHlt4VzfFiUCVg
	M6WoKEGn23dasIzft0Ec/WuX9Lm+cZUZ2AW99YFzbeDIRZ7C1wa2ko0ix36yKfzQLmi7KOH+MBb
	NN3C03QLOyJ5VH/2VsfW+FiZRkTS9HKCIaX7owpsxxpFNqhVRHhh5VdunNIWcSxHqix07NBrGVJ
	U7hmxY0Y2tTS79KUlz7oHy8K9B4/uvlc5+zMPHsgoN//8xrU0+/cTg8pvhuK9JHQBeev7h64Jer
	dTzYsAVWg+v4d9emTzGvS3fFkf2u1g57QNcH/3q+pV35HPLGzHvXrQ4DeD9w0usgLtYd5LufOZJ
	usgQfzwDmhnpr27LfMVHv54ovmpRKJqVbkKelvi2KzTBjH8b591hzq0UZJ1d/cgErVz1nFNDDm3
	8lUw31KCbDn45KjxZid17/P/ef8Mwegvgw2wKEdgwrkIQeTXI/XkERdjruT48U5GQctILMF1MZV
	n0pt+MOlOxMmw2HIYi3hJuaZ8hQ+TKCx+QKBnhCGV43HuFvP2glnSrk+nlMsdVXzApZp7jhEJJC
	TzCtlMG6gXsMf1CA7y9NH1uBCSU=
X-Received: by 2002:a05:6102:3e8d:b0:7c3:fcb:180c with SMTP id ada2fe7eead31-7d739572406mr10710273137.20.1795620330327;
        Wed, 25 Nov 2026 07:25:30 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213479655asm165007476d6.4.2026.11.25.07.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:25:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWEsD-00000001rUc-0W0U;
	Wed, 25 Nov 2026 11:25:29 -0400
Date: Wed, 25 Nov 2026 11:25:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peng Fan <peng.fan@linux.dev>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
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
Message-ID: <20261125152529.GK246011@ziepe.ca>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261116193021.GB2452510@ziepe.ca>
 <avwQl18smAW4R6ec@fedora>
 <20261117130005.GC2606445@ziepe.ca>
 <awGWcq_nKWShC81B@fedora>
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
In-Reply-To: <awGWcq_nKWShC81B@fedora>

On Sat, Nov 21, 2026 at 09:02:42PM +0800, Peng Fan wrote:

> Do you think it is reasonable to have chan device(not platform device) do dma
> allocation? 

?

Any struct device that works with the DMA API should be able to do
memory allocation consistent with its DMA parameters. That's an
integral part of having a working DMA API.

If you are asking if a struct device that can't do DMA should be able
to do DMA allocation, then no, obviously it should not be able to do
that.

AFAIK the main issue in most of these cases is the need to get a DMA
capable struct device for a particular SID because of a confluence of
decisions the HW designer has made and the Linux limitation of struct
device baaed DMA.

> I ask because if we allow chan device to do dma allocation, we need
> to provide a dma channel bus for iommu_buses to fix tegre186(TBH, I
> am not familar with this platform, it even has iommu-map for the dma node).

If your question is 'should I be able to have a "board file" that
creates DMA capable struct devices from C code" then I think that is a
pretty "smells bad" solution. Especially if you have to then create
fake busses and add them to iommu discovery.

The DT should create the iommu devices as platform devices.

There was yet another thread about this, so we are at like 5 drivers
now with this kind of need? This was my suggestion on what an API
could look like to solve this general problem:

https://lore.kernel.org/r/20261119143151.GH3115493@ziepe.ca

I recognize it would not be so easy to make, but it would be easier
and safer to use.

Jason
