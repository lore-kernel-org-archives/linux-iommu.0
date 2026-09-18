Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85E51AEF9
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750400; cv=none; b=RMSC83yZcrPILTl4uROwgL6n8SO6gbeHdPj6pssMUEoyDCLt5slrrM6A4eIaxUKrixV/oOuiF5sqpdjHq1h4925OH5xLxS0N7GnmnO83yzMt1sQxN3mQjTDYJbu9bcBPFO9cPRlqwcavJfymxIKn3b0PVvFFnHPIOlg7rca1Hg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750400; c=relaxed/simple;
	bh=QHr3HItRfGIiXW33vm4AJyjNNIRgLrxwO2wwjz3RPCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdoKsTa+9NwC2UVB73322rV8P+Om6ZNTmaB0EqGA53wUavNBv1DugCmrC8gfKEwQCWklDQX6v4SeqtqlJzJG2E+xEIhiyUlEknMvwWJFrILkw3NVeRVOJClFOPR9BfRILAWYUmDL2185dB0Cpp4CUa7esJDZy7Gt4nBSCd2PihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pB5gO3mD; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pB5gO3mD"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a135ffb08so129365585a.2
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789750397; x=1790355197; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZHhNZflcpTf7gpMtfLnrd+b6TKn7wbbrgvwwdWjf0M=;
        b=pB5gO3mDN1zFng2UzRAaAMcg/2DgorsFsoNSlY0HwOHCNY9m48jA8HES6C7+/vXb5N
         DEvZIgK/Z8/xT20/4l4SYZEcR1CjIBD8UR7OuFVyZhFY6yLmPk7dxfJ8q6j7Zj6VODth
         wgJKkG5W9G6pvSt2k464qwAvMBnwq5DvPQvivZ7V2oi22nbuhYmfgb4/7LeLu1mgh0JK
         oVX9ZLI+gt9evdOM/191RE8UlhxDDURPCvswkLwctcAsGLPar8d7y5SkzWNDZ6xsbJ7a
         6N8BR3UXZfs/9zdo9y1Uk6o0/ZbGFfmoPVXxqYoOJaENm3PXB+vE/SC+kUtg1SCmeeOc
         BXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750397; x=1790355197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xZHhNZflcpTf7gpMtfLnrd+b6TKn7wbbrgvwwdWjf0M=;
        b=LSi/q3azglH1Wq/Ld61aFEzDsL1g6Eo3Au8+0k8YVgjaLigH4FwyJmodb2Q7Vz5xLJ
         Rc4ce3rplYRyyeIoYgtEcwQXEhtkY/srRKye4z98M5zfbCXtdlSL2vzw6SiUvOHNhIH2
         BeyBwB6FUOh4p3a9EL6IYOaeGLgnf5EORezgZ+vimn/fPPpRc8ZG4iyw78tRArtxggLS
         n7nIGY4ga/nKyZl/KsEgSOoB3iS0ZBwSAUDGC2qbZqVivFdXKwemMlLC5ALfzxKDCXiq
         b3c6PkDg7ielqdvghqyJmT4nhDfWa3z3rye0b/+wXucNg0knZ/F3R0GR2glBr8KqfJhh
         Q0Lg==
X-Forwarded-Encrypted: i=1; AKwUvBzjtQ0QMzq/gMCk19Mm6T3jKNye70yoKxrzSLvKVGfG6jWYMg6Ngerz39igFzx40tQnNQBaNw==@lists.linux.dev
X-Gm-Message-State: AFuF++ldc+ZAz8eoMgTygPI8VAxdF7iX7MtN0GKBNWdWFInptzeXp1zr
	UM+YTydIe29Hu1vHf6d3onLXE+qzGB0x0fqFwfl3pKsjBt6f2yw+jdCIBA83KLyOPN8=
X-Gm-Gg: AYBFou0hzxQvJ1zkuFXYF97ufNyMWviH5bDGg95bMvV6LEouRkMQNcS0m1XOBoumL+Y
	SLIlCOGHPrQ2n/u/+SbpwjcNw2KGZk5buWVUi/NzxZqjMS1pdFu+NkwoeLRqUbtbrG1s5ctcSU+
	AuKbYmffIxTgoegxkzSFZgSOpMHkHzGc/mzUKAsRa/7AK0cnexo2zaXWVHUZtoyu8Yw7iUQePSM
	PCOv34GlLUoEviRoPJNxByhKoYUfwZx7K1GreHNlYgMtEbQcBL6UQWceOyY6WKF4Je5c4LGNiBy
	yifa660+Jdoi1HmlbBJRWk2DxDHNHQAnjfOqq/sTyg2PS6dUTOnDdy+sThnCDh1Dd3+BSzYvv7R
	f3fImg9EJ3cdiSMQ856d49nF5HYxngvyY6kQd/SeDVKYhBt3dHnLaUOu926NWBrEYB+JxcDX7PN
	Lxw/9Ohg2kbpFvyy9talMoU5jm5FHy8kX0vPFHt3Kvv8QOsvk4ezCtyuVyJ+Tyvzfo2+7Ldx1l3
	Lcz2sCXP4KShVblyhH54o4RsQTdJ3xkQu4nTUHC9t2oZv1MJ+9mZYuV
X-Received: by 2002:a05:620a:1a17:b0:939:ee44:36bf with SMTP id af79cd13be357-93bdc72000dmr495588285a.29.1789750396680;
        Fri, 18 Sep 2026 09:53:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a60f21sm68476d6.19.2026.09.18.09.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:53:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7bpr-00000001yyx-21Yo;
	Fri, 18 Sep 2026 13:53:15 -0300
Date: Fri, 18 Sep 2026 13:53:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	"T.J. Mercier" <tjmercier@google.com>
Subject: Re: [PATCH v6 7/9] dma-buf: system_heap: Enforce shared-granule
 alignment for cc-shared buffers
Message-ID: <20260918165315.GF11599@ziepe.ca>
References: <aq1V3oeDdvXobt8J@arm.com>
 <97c30fce-9bda-4c61-b1b9-10297b89c8d9@amd.com>
 <20260918153642.GD11599@ziepe.ca>
 <d8123f21-d5ce-415b-a05a-392d97b8b57d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8123f21-d5ce-415b-a05a-392d97b8b57d@amd.com>

On Fri, Sep 18, 2026 at 05:39:55PM +0200, Christian König wrote:

> > Arch code can figure out how to do it. If some ARM configs only give
> > order 4 folios or whatever then dmabuf heap doesn't care.
> 
> The fundamental problem is that DMA allocations are highly
> architecture and device specific while Linux memory allocation APIs
> are generic.

This isn't a dma allocation, this is a memory allocation.

We made things so the CC shared folios are DMA mappable through the
DMA API. From the heap perspective the only difference is passing an
additional DMA_ATTR_CC_SHARED when DMA mapping the folio.

Jason
