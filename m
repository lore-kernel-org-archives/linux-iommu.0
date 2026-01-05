Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901D2D7DE9
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635607; cv=none; b=tHQNXPiLO/d9pbGZVpquFB6KMYlFHqMZUKFyJUSPYKfCoCYVDQAhsTe+BMW2nD6c969oDrVZ3HnNmZvklPuJLQQ/4itWX6flGZiGLJgtQcwHKcSNdfsEMOV/zJ4Fn8aLymloWMiaJ3YQBHPNDzuqMQbPqUWd+adIpmgKiSiPhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635607; c=relaxed/simple;
	bh=6oExjFrcLVcafthRfmrHDyoj1J0W9+IDJveHTTU+UM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml/gRy08dB3Lioba7BV22vGFSMu7V6UvYTCiXzGXzvUzy4FCo4gxkT6OdWSB0DHiiWKjE2IlXLwvfV2ooJtrSvInLpGuZ3evcaQQaYpuffJXcXUKtIt70kZTKD1nPuUBZPDgp5kBjVG6cIZhClEhQ7ScM3K/qoT1daG+/LBQv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Fr5F5W4f; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fr5F5W4f"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2d56eaaceso16720585a.0
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 09:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767635604; x=1768240404; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oExjFrcLVcafthRfmrHDyoj1J0W9+IDJveHTTU+UM8=;
        b=Fr5F5W4fEyFSg/nUqVaJ0b1trlPV+BeQOh7zAI4zoePmp2Tx0fsOFsOU8c07D/SIyR
         WXpBsrcDLmN/hkxDZnX+Mytqs82UT+guC4fzbZ9omXTupZOBLOhDs+5w8UKd4a/b6s81
         FP6GvbI3fOAWNf3iizGpUYVy9jnYjnJf3DBpi6au6ZnAMdbyJwL7S9GSVyHii5R2OqqW
         t7kfYwPP7kEhOdihmsz9LAwQHad0qe8yoOYdEMCeXxGczKyyquzCwjiB6mC3VUvvSBgU
         96No1T1dQlds3MfxjbS1RvNRDqXNSjsctRDmllvVkYV6CT6i8ChIxm3opHHD56rJH7sL
         plOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767635604; x=1768240404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oExjFrcLVcafthRfmrHDyoj1J0W9+IDJveHTTU+UM8=;
        b=K0ZVDvi2mpGDeVtDh5qqvQrXZtn+xwzyYGX+NOWzmh13LLP5oHq/3UsXLL0ZQsOlOn
         F1UxN3lV1Db3ahh4FbgULs+7X1bKVUk2LZf8YiXXnRFLxHOIgE5MkFiuiJT3lvD0E21H
         JrGNre80e9Q76ausvAW858CKuF0ziy1tsrpQA9qCp3tfKniAisHQu2uSjkqJq7HGrTo1
         24Hjpvu7K2vt4luyhaL4Dm8WEyz8+IZ2sP/IHyxATw/IWIlI3NbXt7dFJyA75lv0t1Yg
         XeguYTaKIyuXx268UtpzlwIz8FQEmlGrXCS+vLkfLizeHgL9+e5/QJkWK29NVXT9ZP7K
         Ln5w==
X-Gm-Message-State: AOJu0Yztso70c08yZiAvwDfklE7Bazd1WTDW7N8BZwENhRs+6fXia8r+
	GoSWSh8UlDxaQ8DHiapSKPl8D6FQs17l0swmtxIq2KuUNfj9XNXs/D0Qq/+F1hvI5R4=
X-Gm-Gg: AY/fxX4Pkq5URFEgNQObmfzL4w2dAhIlzl+gur/N/yZ8xJggQnm/+BR4NtOdRNWuJSi
	xiuHGyEmMg6/FfzEm6dPdf9zdNRipAFjzDR9jFvbr0sq6y6QN5D97ZYyWtg1TN2ZIil6sL+Kiop
	GYMcAjLLg14UBqYYrbGTzYihet95mHc7N9qWW8DjgSRMG6YYr0bYrXcFkibRJ2lPESLe5F0xuWp
	npBfapfryNqh4WvSeZVwQUHp56EyDiocCbhX3aj1LXhOGvrQ5aWnTJws1qE3Gh76zGgVfkt6Y6h
	VDSvlPtbucxkno7UH3YtMXKXrPhIb2+cr2Mg5pxxLa0UJzoeqzFEd18P5F2xOckX0r/AAjLRSGh
	8BvQzPM2+rZZJ9tYFCNKf1RsZteKSsSUT1eGe1nr5Mx9R+4OIMxKHAdDF6Nu/8xhB/d9j92mjZc
	jVJb/tLuJzUMqzKLVY/wr/vSGa1cOWOsOoJhtHC6UNNqgB1+0MHm8S6xseHvV6wbAy34c=
X-Google-Smtp-Source: AGHT+IESZ3ULwHuALvq/u4YvHXFCCMVmARAtgn9Kh85N0zEp0zd2NOjJk/m0lLMQOwoGO1mknCPiIw==
X-Received: by 2002:a05:620a:2952:b0:891:d993:1bdb with SMTP id af79cd13be357-8c37ebe9cd4mr51644085a.86.1767635604411;
        Mon, 05 Jan 2026 09:53:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890755326easm3346286d6.32.2026.01.05.09.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 09:53:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcolf-00000001Bae-1S4A;
	Mon, 05 Jan 2026 13:53:23 -0400
Date: Mon, 5 Jan 2026 13:53:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2] dma-direct: set decrypted flag for remapped DMA
 allocations
Message-ID: <20260105175323.GF125261@ziepe.ca>
References: <20260102155037.2551524-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102155037.2551524-1-aneesh.kumar@kernel.org>

On Fri, Jan 02, 2026 at 09:20:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Devices that are DMA non-coherent and require a remap were skipping
> dma_set_decrypted(), leaving DMA buffers encrypted even when the device
> requires unencrypted access. Move the call after the if (remap) branch
> so that both the direct and remapped allocation paths correctly mark the
> allocation as decrypted (or fail cleanly) before use.

This is probably fine, but IMHO, we should be excluding the
combination of highmem and CC at the kconfig level :\

Jason
