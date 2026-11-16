Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850961;
	b=W6t163Jpl9kjT8c3rZQcK+JAxVbejbLX+8+0IdoR9X3Wzq/ayxMN397dcRnnPt7RbOEV
	 seTfF523+M/I+DO1wqjXkF97TvaM4lJxDDkjrbFS4q2dMUaGnhppkFdPuNNKXgbYj+F4y
	 qhPaCFrhTekO99wxRG96QlgwqGN3uadkxHvjpa/GELF01K3dVX4pl79TEet33l8oECizZ
	 so9rw8Ye00hbEC91KFOTBq31B4j7+7c/0XXivceC3ISlAQQRx4VphwAJuGw9dirfRWS7m
	 QxvB/889t7rQ55rAx1XryFk59m4xln3c1PHtqp0l3fgB9Fe9bS/tOwvn1iVQvkPUEOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VLeTN5f3dNjgq7/DFz77VAQIKydYxJnpCGV8qATJCLU=;
	b=T6IdgnMvdSoh5Q/OJyuGBNq2x0AmPaNLq5PDjT+IsYUsC++9Gqv2QPic45fuQg7oTpNd
	 x+Ll1gGz0GQVS/pM5rSc1qm95WoN7EhL17mgesgj4Zw9FmUipH8pkP3fpjrMP9nUHFAix
	 ubHph9V0tIg1+lt9QtoO6vVAKe2xn4X1L7iSKn/qrRPSsDRwwn3hdIeKLskWj4n6jDCCh
	 ae9GWtSK283EnMMx9UEEdLDqfyyiC5uLUrfi+6vvqJatRdC1Jwca5wf0RTO8O8RZJYBcy
	 zIg3CpBCCc4yu1x2Ei44wyLWlAVHk1F/Ee1tN6lPVG3BgMA70bQf+o67yWhcjEAnflg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=PSNKh2eH;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A1606A31C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 17:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B0A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=PSNKh2eH
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91f0274f88cso62019266d6.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794850960; x=1795455760; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VLeTN5f3dNjgq7/DFz77VAQIKydYxJnpCGV8qATJCLU=;
        b=PSNKh2eH/5EEStLGq12CZBHFOBdZ+bC1YL83VrWcrFbjlXgLiHmOaPA4mrll+7bJUJ
         aqhPYtlDRM2nyYPt1e2D4IrwnjTIRCqt5g3TgG/iGi1Kj2DtewEk0EbPbZi+NPZmHdUx
         iz91O6nFNBPHP9ETh51GGbVXr1XBqajkCf9wGqF97gi/ue3oNFvK2Aq7hyu9cCkxjKK7
         M4VC60/vn04QHdiQT81V+1twiIhldsMSJA6NOpVYhrYjJiZtBQfH/5xbb4EockdE7vTL
         RTy154hgql3b4lKuYAM9gDEVagm4q8glYt9MSIe96sv6UqWW+guTEwpekFCZtzvcK/nS
         dmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850960; x=1795455760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VLeTN5f3dNjgq7/DFz77VAQIKydYxJnpCGV8qATJCLU=;
        b=wVebuhx2yVCDaEM6D55d3gjiJjDmSquXN+xu3xxD17g3DJGzLCDEKP7MAXId8ph+L5
         UBpEFDS2lnBafpQeA+G0fJ5nsAk2iYhvOybx3h+TJ0lrxU00vYMWHFxLRsr+HgY/DQsz
         huQrshjTnBXb4UCSpEvPSqq3QsUcGVAhr4etnMEgm4cRy8eMGMP5B2wLMrTEtPh+rzd5
         VqQrx3zIsclZ8v9SPc4NapLMgqlErgmAJNo2utMO4GnzGZp2tt/QLnovx7vletifuiVe
         82IvcaX3btaTGAEYk3ZNG6SfeVwO3TZY0qwSQDgaxHF28D9XoBmx8H/7or/yQLe8Dtsi
         WIjw==
X-Forwarded-Encrypted: i=1; AL+hErFx/lLTn8jKpJv+OgUn8HLxRc7xWOYpQIFU/Lq2IqK3sQVkMvfQFKO9EFwEf7dbYWwgxlK3Ug==@lists.linux.dev
X-Gm-Message-State: APuU4Z8xAFnceIfiQ008bCoFgwtZ9s1qQRRTTdqmfiOGgcfG73BBcBrg
	RN4VphRByyZ3Spq4zAl6Zwvmwjo42pX78fnPVjmrQxGkm+ICF80vVXhG7nhAVwa4JNQ=
X-Gm-Gg: AZFdTZfKxmLzC8wVIBF38vVNaJ1PkSoBe7ngK8HFXd/RV/G8YG8aFIB1YzVRyiJF3VX
	/4Qn4UEZnR10DU508DIIj9L66MPgowSHG8CFBmUoYdo1BpAlXHEm+GNJOTA4j7kJYY++blz1OUj
	jr/UQgmutojT2dGRNBN8kzVzEROl8mHy90HnZBvIcYsPsN5qgggZ1NFaspOQnLJKNxprwVwpXzZ
	pp3ydA/kYXud4wtPYw8/rAfg3bAHxCrTHf2UrBxYQE9IkpidGeXfM6iecyU0F3JBCwwEKGXoSGB
	xFBE0agLp5myBZEhtT6gf1g8rSz6lXKYJA9imWJ6yra48WDdwzA26OJLQrRIPqRyfa/TG9284JU
	nla2jM3zYWMxcBh/UEvwiRCHSuRTnAhXOy7thAPJYyy6rdyusDa4nBivoECaoRITjznD6nIjree
	u6y+nDaVEsJ7/fznggsvnJxhTcOgKUIzQIBturzccEfz/YE+GFspeEnSfx91AvByrqYnAL4bUXJ
	goIOnYEOnjocb9ESkgT/7lQ04Va0gANX1osUL2KO7e1+yvN1jiTO4HeAreHHMdGFptN5qgf15GL
	7PdCow==
X-Received: by 2002:a05:6214:4698:b0:91f:1004:2ba4 with SMTP id 6a1803df08f44-91f2400b38fmr177678706d6.2.1794850960144;
        Mon, 16 Nov 2026 09:42:40 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73206sm91150276d6.25.2026.11.16.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:42:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT0j0-0000000A2D3-2QWe;
	Mon, 16 Nov 2026 13:42:38 -0400
Date: Mon, 16 Nov 2026 13:42:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Juan Yescas <jyescas@google.com>, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] iommu: Add iommu.passthrough_devs early command line
 parameter
Message-ID: <20261116174238.GC2299285@ziepe.ca>
References: <20261116-b4-iommu-passthrough-devs-v1-1-dc5b493f7551@linaro.org>
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
In-Reply-To: <20261116-b4-iommu-passthrough-devs-v1-1-dc5b493f7551@linaro.org>

On Mon, Nov 16, 2026 at 05:37:45PM +0000, Peter Griffin wrote:

> Instead, I propose handling this in the generic IOMMU core via a
> kernel command-line parameter. This makes it available uniformly
> across both Device Tree and ACPI systems and across all IOMMU drivers.

Something like this could be useful, but also Leon's series will allow
userspace to do it from the initrd too. IDK if that is more/less
interesting to Android.

>  static unsigned int iommu_def_domain_type __read_mostly;
>  static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
>  static u32 iommu_cmd_line __read_mostly;
> +static char iommu_passthrough_devs[IOMMU_PASSTHROUGH_DEVS_MAX_LEN] __read_mostly;

We can allocate memory at this point.. No need for a fixed array.

Jason
