Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947234678B
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010605; cv=none; b=CMOBgqsLx6Pqg9+7F8S3eHoSpqtUpaUaidZ4xBOc+y4e/MDhZ5QKnPDBKXFS8mi5E3UpwlpY51au5z+olteTMB0Jyq4ffe8cElN6mhAohtxzaxZOmPkuThNU7HVqX9smPRYvWtVLNGUSYz4wOsiqmGu96euCq3ANU7IQQrQT+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010605; c=relaxed/simple;
	bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYdT5YIh7zRB9iyscz/uIotO7lURVTAdOiBXPpYM8u9UaAAFZ9JezPvGb/M8BtAFb423FT5hnTywNQJk21bff4/jhPk+0Bm6B5kQvXPukdip06c2vtdE2fTfESwnNj1mkHqh1ykLiyKqGHzlh+HwEbTy5bL88HxKSU8vFp70N8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nZUVGpxt; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nZUVGpxt"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c531473fdcso879748185a.3
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769010601; x=1769615401; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
        b=nZUVGpxt8Rl3ANaRPtFG3YTk3vP0mq49LXuiK2IKtC/z7grN2ASbxYV+gdA3+rt5v0
         OPpfBsuODEJhrifTdDkkJD4kShvODnMrUJupz2at+mBb6igxHRiMtEWivRo9bxsXZ3UN
         Sp1xwZJ4oYI1t2ptZ/yWeQ9YagqwyIsKTnZlOB99fmsMM8yO/ICUeTvVtgi+DHlmYL+k
         9NlnnEF2xOrFGnj9YOkiDb3fiW3FFi7WEsGoLZEZuoBDPF5g8VMmdV63Ysh2uxjJZba4
         AIGcTz5VL9fChN8WT7rDtj/QtAOwKszOMwPEMYtRVHkIr2Yy/aSdcJIQoZSswjMG+8lI
         Wspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010601; x=1769615401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
        b=NrdUxPL4K3pThela6+AnbI612QrUwzlLBz2Y3vH/c27jPJhyDXAnAJZAm8LnYKcXF/
         Ve7Kej06HMlSjFTAPuZ+C5ZvqOmmnSkAyskYg1x5r9hukYBZvfQuIFz0j0/84sWlEk6I
         MI3wdKnbHJ9sRe9Y3V6AtFmmVLHNPWqaDDllRyS4UIsIMmrFUg/OgMDA2BlQ8gqUSlIG
         0NPaSgAFm+C+VjC5na+vtekdsvABuUUIdigPF52SASoHChRDreZDcMqcuwB4ZsiqnC0S
         m0n7ws/vdLbJuAqGaU6jUCJGVrkx5x/STYYQcyr+kn3NX6H3J5qqjRp5RaMn8gA03Tsi
         egaw==
X-Forwarded-Encrypted: i=1; AJvYcCWkyKTUgSut3vqQKkkeX0GEG03cWFnmiMDxe2B37r5M+I3YOveuDZx5fdrKmLmN3bcd2ZhRCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxuPg+BuHA8JTvp1k9nGrieXkqy/P7pm5PVKZ7vYg5vB8mfUOa
	bdOhwVUR9pdeQ2snWIPV6q8V0EhE4QImpfPhk5h25w2+95iJ7b5YtgZbbqzTmheOryQ=
X-Gm-Gg: AZuq6aK8YUiioYMwVohx05jKcNznJNyAkVSBz+Od46BPIPY7TxOKdd18CenIbWfGIUI
	EMlrlh1EHbJJSq+Uq9ooWyeKTy7y7ACafUCOjmAIg/orugOS9Bgjyr80R8+t7tpcWBWkbox/N2W
	P9UXFFfEj9bBd/pJEsZ5fG1DPYwQ2DrP0kkE7BUBZ7I38QFTu0/PmAu22KAzYMFKfP46LzJLin7
	6dxMtPC6m+W8a4lmB9tyyeA1UCJWh5VvvTxGm5M2hjGfoEfbKxAlIESEDtRQ6z47beHJXWCOPf9
	TIErObsQaq9244eHfvE+Xnj8atJdEvFvaZ7+899qHPb91MvleJF/6R79Bl5giu+kOMeK4bkmTwN
	nK/GoWlYRin8CRAg2uJD8BlFLRnORhT+3MgevFHTHExueNxMMokTGMUWp6zVP9JDyz5zCGOu7ta
	qa7t9cQbZl/nJGqtZBK8d6aL2DuXFHHXxsm1zynHi2jPaEyOSDp0WSP4m3C02pqqeZv/A6epaVa
	C5vuQ==
X-Received: by 2002:a05:620a:298a:b0:8b2:7290:27da with SMTP id af79cd13be357-8c6a68ec70emr2561552085a.12.1769010601362;
        Wed, 21 Jan 2026 07:50:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6a9d97sm127467116d6.34.2026.01.21.07.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:50:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viaT2-00000006Emy-0KMB;
	Wed, 21 Jan 2026 11:50:00 -0400
Date: Wed, 21 Jan 2026 11:50:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121155000.GE961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
 <aXDhJ89Yru577jeY@google.com>
 <20260121142528.GC13201@unreal>
 <aXDnAVzTuCSZHxgF@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDnAVzTuCSZHxgF@google.com>

On Wed, Jan 21, 2026 at 02:47:29PM +0000, Pranjal Shrivastava wrote:
> But at the same time, I'd like to discuss if we should think about
> changing the dmabuf core, NULL op == success feels like relying on a bug

Agree, IMHO, it is surprising and counter intuitive in the kernel that
a NULL op means the feature is supported and default to success.

Jason
