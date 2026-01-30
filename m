Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E956221FCD
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732236; cv=none; b=D3VoQ2sMj5sR6Sem+XYtHxhRHABNG+roqndS3OqmqZ7FbK+qhrELpEwl4/vG78e87JEWNVb4f5sVb5LUTH7QLqJpjRp69JWIqCcOppLpZhXcehEznwRL1vIKcx6OyFaJx8bgaWp1q0KrF8qJo0BGmbokEljGD0L6XizVJY+fdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732236; c=relaxed/simple;
	bh=PgxWXxtJeqUdvgjP5KxrfenUWVrCXmnl/Ip3hY3gzr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHufKybpIwYfcUotPTv1PI+x+pRazx2R8J9Gj+dT91eg4okioE5LCf6PlLH5dzdoRSn+cE5Gj0K2/E2zQKiMgJM1Z/rWmHBW7iH0+sRyo1MYrP5/N68hFxRm7GcONLIBFLsRBYDdix4m4cVW7WoQQY6wkIqXogvGot+JxAnjlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H0gg8EBt; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H0gg8EBt"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c52c67f64cso148147185a.0
        for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769732232; x=1770337032; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQnCcQDZjp9U0R1Q7JCyNDeekOxxS8phMo1p2crcsis=;
        b=H0gg8EBtPMqKEknAuFR0p4aWl8eOqMRb8JU0ZEmmQKX3QI58fYfis1Cws/2r7bCqSt
         KmTt4Zk3BevOEr0dNXM+F0wRCSpfCEtAaLHfTeQYaUcy4rb/V9Wgg4ohcP4l+oHs5v8i
         QWkVVWJhd1AMQBVc7wr1UoFPpZo8WorQQTv+Gn7Wt9HEilZMX7rfTfqz8DXdU2dMhwMw
         8rtUMs3JFrk9PG6HIevEk6brIVwznppFk7A40p8jaCQi+jAu/kzaRE3BwjrBYr8ezCye
         Irl7Uyd9nK2tA91yaYSpR1uPrzmJLPkFZJfQqoEMzvT/kALn2UOBsp5IfxRtMr1GRe19
         cdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769732232; x=1770337032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQnCcQDZjp9U0R1Q7JCyNDeekOxxS8phMo1p2crcsis=;
        b=cr0tl6/92Dox7LyQHSjNrUFNr0V594G6QrbXDsSF/yPhWgOLV8LxlK5FnEchoATaXl
         8YYIQnzfZmaLajulSKRJzY0JR8E30Sktpl8wkZWA5kTdiALkKKbFgIMOVuDrx4p9ArpM
         8bND5iiZrDNYa02PyPdUlBexyfAY4EY72ibQ33RhRM8WRhHQftFAaBOpB/liF3m0Yrr5
         kK3rS/W0ITP6WGxSZn64kykNVhtRaZUW9nD+TmVYH4kq6okyuhNf0cW9x0Gvpv/XvF4F
         TdtVKjDnkRYQ7hZHa3e2l/M6nHTvkIFVEKqmlYNRwjJBTSjft1snwUO7mCbrbWZGyG//
         uYgg==
X-Forwarded-Encrypted: i=1; AJvYcCX0LGcThB9VBSMwd3ox+kw9KI/IC2k0bQvS63K9KTnfz2JW0Cj+Wo9wYDxu40s1kD7U5TtIvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx51XwezssVIn12cVPjVmZWICIeG/T8VEI6eZVSvrW2LgdohXK5
	tGEecaxdoMDLghIc0i/Rne83NUdxWGINFcyE+Ja87VXhaVNseETu/gI1Ds2Oko6Cvrs=
X-Gm-Gg: AZuq6aL9HV7od/sBWGSZ2sfp9fmuXsKofq/iPQvZ8aEYmHOGDq7zs3vicX3IsOMXdg6
	FBXK8pV2ZWpVzeKRTKsDB2bB7FqlidueOjkyGMmg4XVLr/j048uX/sskRiyKZ3UgodIfCbadtsg
	GUsrKM4jH07Usu0msFvfuZkq+zs0B0Xkv5LACkDge5/4dLYyarP16+UswF76w/vjYggSOuKS/ho
	U5bIQC4TN1c5JPKgshkYjNBqTn0zvmFZJCLTZor1IAd0locApOG6kCBfICQhglSp3h/0q6KrPWs
	T4BirzNlKrCycMIlMVoHH8g5iHKi4rUbsIXLrRzuSkCBNDO5Npb5vj8YKQX3HTUuOzeL1zRuTL7
	QJfi//s631IV+Cnntvx+WykG0lMw2wso3xvI+K2w7bFiwlSAHQ7BDNvnOxnPQy/x9rss5YroRWn
	POMDs1JTTFCb9lcmTkQtQILecgrL1Sa6Q2frjhudBuxZcja23+VcWwB3cgdU/+ICGKR/oG1aiqQ
	eQtVA==
X-Received: by 2002:ac8:5781:0:b0:4f3:5f7b:cc1d with SMTP id d75a77b69052e-505d21846b4mr19549181cf.34.1769732232444;
        Thu, 29 Jan 2026 16:17:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cc19d7sm45008611cf.35.2026.01.29.16.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 16:17:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlcCE-0000000AQZD-13C4;
	Thu, 29 Jan 2026 20:17:10 -0400
Date: Thu, 29 Jan 2026 20:17:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
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
Subject: Re: [PATCH v5 8/8] iommufd: Add dma_buf_pin()
Message-ID: <20260130001710.GB2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-8-f98fca917e96@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260124-dmabuf-revoke-v5-8-f98fca917e96@nvidia.com>

On Sat, Jan 24, 2026 at 09:14:20PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> IOMMUFD relies on a private protocol with VFIO, and this always operated
> in pinned mode.
> 
> Now that VFIO can support pinned importers update IOMMUFD to invoke the
> normal dma-buf flow to request pin.
> 
> This isn't enough to allow IOMMUFD to work with other exporters, it still
> needs a way to get the physical address list which is another series.
> 
> IOMMUFD supports the defined revoke semantics. It immediately stops and
> fences access to the memory inside it's invalidate_mappings() callback,
> and it currently doesn't use scatterlists so doesn't call map/unmap at
> all.
> 
> It is expected that a future revision can synchronously call unmap from
> the move_notify callback as well.
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
