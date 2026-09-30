Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FC5172E2
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787161; cv=none; b=a1s/eJnH9sNFhoXzXujw8Mv5ZtAzX+0WWRVjpj1Sc1L/gAHip6jJ6DMQyR6rMr+EvMkxGJGJ1OK+t1t8wurjYQDWTq2W0v4gK+vcU8BAAkk1OKUlSURM7rQif5D3+Q3MwXZXDhTonjnz4qaHG73NFB98LpZNAHVvfO3CIZd2thc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787161; c=relaxed/simple;
	bh=USoosmtGDycX1a/Va/WTZ2HKM0YP5/LMRYBi/jK/1WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5Mg3SiFLffNaQeJucSwdtvzQXGWyxrH34fJXt3U72jJFlFecZdWXqujeJ9Cq0wKeEUakgR1eY7hOFGl8kdu3CfTA+tJ2m7Crx/R31m6HVRWMWD5/htA+NOftahO4zCuRuDkqrcS4E7evuBH2Cb1HGpLgZVmsCgVGgF9tOJTDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iSZbTdeo; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iSZbTdeo"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd046b87so4176450c88.2
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790787158; x=1791391958; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=USoosmtGDycX1a/Va/WTZ2HKM0YP5/LMRYBi/jK/1WU=;
        b=iSZbTdeoTz/eG8lnpDKwqbT+gu+bHQk+/2o8MovsylHOaHMhBRWQzBVBfR6QAjDDTX
         lx0z1BhmfeyNhmJQz5P0NOJb826R1IiboQS9jst5NXBl9RuuV9+fZfk7DbKIRyy1WCpo
         jqbfuhL6ru2RR570TdyPM42TWq1bwYQ2n26CrHjE4o29Q67cGVp5HtQ4VhG6rpyzO/ts
         cYn+9OjhlPcLmhltekCz18I98qobpsvmfwWxeWIK3d57RQApFuOM5ho4WJgnXjTgBOp1
         EXRoCkr6dJ6lZWBHYesELo5cJZGlEp53oovOtirsyple69DUbeesD6yoDkhwCUJyNyZO
         8FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790787158; x=1791391958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=USoosmtGDycX1a/Va/WTZ2HKM0YP5/LMRYBi/jK/1WU=;
        b=mriWc3zrVbwj67c9fWEi01GyJl6arOhyMxxprDQbiv/ivpBL/IZz37FxRYDUNGBukS
         Pn89cHI1nqQnMkU4bNGUudG3ADNTt96NJzS42FOVwrshqAaKy0ySbmzqVFReGz7ZF/yW
         pwVZT3r+MJ7E0f1zmhBYUKiMu2wcO5/gUBnoiwazOhVFEw+s9hgVYOYbfuZckN7qeiRS
         9JFDIi9AyLhb+36nrAGg2DSPQGK/yO6cL3ogwZE295QkHtBUnO9LWmSJMHiDlmdMvumk
         YIVq1/uKXrqWCqfXz1kJXIsFzav/BYZ07jTpRcELQHH1IcmLw7nSWyw8pvYHMbzKRl8L
         wgVQ==
X-Forwarded-Encrypted: i=1; AKwUvBw68ubO4KIcshdpD5eiminIViBSSGfl5roCQ1CJd1O3fcVkmnD4F3OUFCpYlIayNfQ6/hbHlg==@lists.linux.dev
X-Gm-Message-State: AFuF++mOHyWyHD849DL83cyLR20doyeN7X+dIX/mgouxg3uUZV6ikOHR
	1qbTGPUrxkPEdXJBACpNGIR6dumOgkN4uiMcuudGGrKYUjaDggTRyd07RykAyv+UNVY=
X-Gm-Gg: AYBFou0zLxJ/PWXaRC1bzALf6IqkrALHL9N8xG0AYhriAaCGb4fnAXRSiwYqxHMJ2CL
	AWHXzpwA1O0e6Lw0lpOiWdqL5DlfR5FfEdCB+HGGC7EPpPCGhIHknBLDHHa6eE1CYY1OIrircSm
	tgOD0dRTozpts9D0dvyWPWV8ncTJQQZ9bzn+KPyQGoJdpkdKI2EmdqVU32SzWu3+T+6sxVuo7L4
	/gHHzMnXaWQ7T3FK34cIbNEHSoQWw2P7ch8DDCRImEmAVRws3CGSmV6MMq0cg3vIWugmaBgAqt8
	pooQeFv9gS51NUXN9oOgyQbIEc/Ab9HGMEPvTw9cnEPryMfgeIh/XGekXtNPPsT86SfS5de198W
	QZMP9ZS9NX0J4PGEEa0sGZ66YHV1XpHPZEdiB9W0lMqH5bHiPYvSFel+IH7gyZ6vFE8QZ3Usv7m
	3WHik8FQJoYFtSgcJofZKzlgfAe2N/+vuzUn5mfp5WDMG3nA==
X-Received: by 2002:a05:7022:4595:b0:143:297c:276c with SMTP id a92af1059eb24-14d330b1ca2mr3017652c88.33.1790787158196;
        Wed, 30 Sep 2026 09:52:38 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d313b9c38sm4523537c88.1.2026.09.30.09.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:52:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xBxXo-0000000C7JB-1eI9;
	Wed, 30 Sep 2026 13:52:36 -0300
Date: Wed, 30 Sep 2026 13:52:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v8 16/23] dma-buf: Let importers ask how peer-to-peer
 traffic is routed
Message-ID: <20260930165236.GS163130@ziepe.ca>
References: <20260929132305.GJ563127@unreal>
 <720dbac3-24f6-4c91-899e-e205865c1fd1@amd.com>
 <20260929175737.GK563127@unreal>
 <eeef5951-825e-459f-b474-bf8c59588446@amd.com>
 <20260930081832.GA3401365@unreal>
 <4549640c-f4a5-4dac-9be3-2e5aa127555c@amd.com>
 <20260930114356.GC3401365@unreal>
 <fbdc710d-7be1-4021-83c2-548c798d9d14@amd.com>
 <20260930143237.GI3401365@unreal>
 <b2e766389e57a55da959369c5ad4b9e39e425659.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2e766389e57a55da959369c5ad4b9e39e425659.camel@linux.intel.com>

On Wed, Sep 30, 2026 at 04:57:04PM +0200, Thomas Hellström wrote:

> Returning again to Jason's series. Let's say we'd add just the mapping
> type infrastructure, converted users of pcie_p2pdma only to use that
> and then we'd have access to per-mapping-type data. This could actually
> be done as a prereq for this series and merged separately. It's a
> couple of patches only.

I'm happy to say I found someone here to pick it up again, so we
should see something on it after LPC!

Jason
