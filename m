Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71229AAEA
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841183; cv=none; b=nIAal5r/iq3gg2zc2kBdeC5IHnvwpvf+wL3uoouwsjLSP7M5o6436BmTO6YMrsKNWgtVyxUQG40sI2egzPjxkZIoIt/5JTxDyMi6/hdI+hoa1zYRipQ1n5fjU/teNivNZcXdKuDfYv2z2WfUgagsfeQU/h6t8YVHDYg4SbhbkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841183; c=relaxed/simple;
	bh=QIsc13zuNMkL3drL8s77g4pkAR1CgvBQvDpaSTaFqoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRFExAX5iowaHp78QZh7P/DNy2s58OOjq3eg2lFNNvsOcKtQQpLHUO7VZxh0CXnrTSsZYY/jAQdXVA7+TbdeFBQ0eFcb7PhBOg+MTewnirJB8Tqg0YQZWsKv+UpJEOvf5iuFlNtZqxFwnhYWoFIwZbWOK4owy9Rfy5+hSE9o/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BzjajVOq; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BzjajVOq"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so37390121cf.1
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 08:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768841181; x=1769445981; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfC54g6ZC0VxR+dcM7NfRz1NWoEdvriN2xR6YNn2bfs=;
        b=BzjajVOqiCRnwQSNC9QGYRmvShy3rjnjFXjSufSEmGHw0w1sGeImq/zIwxjKN31qic
         XNhCrt0fuk9iNTuZHq6kqH0UrYMYq7hyDSh9rhfJjVzyTcYhfiOGx8bnIB7ywJIovS1U
         RMC7isVHiPUTG8tnr03D+o+L7BYHltg7WLaNO+kH2aQ35OvcyH17nMdteKtQm0MUFemg
         0ZVHznDBEzYjk0OYD84KS1cHgj26oCfxrc4wqHU7hGlXfusZvkF/eyvSxz+U+S4mz7ZO
         ceHn7ApZ/KPfvhKEgvr19x5jd+L4skMegQvvUE4jhOhldJqReML4rb4zp0r65zooQt4q
         cenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841181; x=1769445981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfC54g6ZC0VxR+dcM7NfRz1NWoEdvriN2xR6YNn2bfs=;
        b=l+ftdUOBf2ieyzWZx4mvyixMaRPK79tr/aADwsluNI+y3uVxrFXn2HT1pSgwIr65Td
         jT8CcKUxnNkc+7JNzZWpgP+RxhG+9SPq9cgt1n1a1tfrl8BHkRmu9yyNQlAQaeFpf93j
         Hh23qcH7rgZ2s0SDwd4f1mlpHR0IsnIw2rAVpOtsxCbQPD3rhNUp8VpeS6ylyAddbm+N
         R43ESPjSAqMWTVUv/js9Puj05k25P1UrLixPR3aeR0IbCHtYu+yOe1HwSD9dhf2dHqg4
         wcBteHbjPcc8e6etkb4eqP+twaRvX3nMNYY6CTM8p9n+LrGf2zR38mUkNWZj17DeIX/p
         WpAg==
X-Forwarded-Encrypted: i=1; AJvYcCVFKM08oxJBtTu0T4Opag1HQf209lY3lUMtALhZ9uzMt0VJFdfkkFaRZ7iiSExusXf5ovuvbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVPuqrGzkHIR5gQbzsga8zbVVZruC4CRKufU79MRuSTyiU6rRJ
	RzdreGptLPUaS4qfltnhBFHPrAIgUmju9uXZDTpv5Fbmd6VYZN7KiF6wyNbQ1lXyxn4=
X-Gm-Gg: AY/fxX6BFjwD6GPNaXuzDPEpWGOj14bEktWZVpEPuwmgwoeB4tG1cHR9mfz2ci0GYVw
	h+hJFzXeVna3ouZIgwEMHsSQJDWnshRfRD1a5JkUSxYh08qw7jC2N/CNThlVFYRJzm9WJpjQz87
	jhgQ016Sfw6aiMV7RVzMKVdN4JBR8Q3m4gJS4FzkyaaXQRgKq49pyNBE7yvTeQtqh84afvVqWan
	As3ukRMyYJr0dKgn0LWwLwniKH+6eIujwSeEQ3e7S2mtkGLlSzrAoPaz/dlRiVARUeCBEzh4oL6
	1kvYenxw1X1bd6PR54EKHVAXuHInS9eCHJ3ro+3yYG8UjtJb12cmunGBqtF/+wWCGQsl423pEaU
	AsqRtZdEHRrRRkBe3eEHYbPrPTbKL3eO/ySy/bcq9/oSr31KSaa2msB36KfUA12tleqfxBlyuv3
	JvPFZOvRtCADpeTahmjPIinR3ZowfHqlBnYDEkR5vPhpTDvlfJrXlel1DIChKsfLEESzs=
X-Received: by 2002:a05:622a:58e:b0:4ee:17e9:999a with SMTP id d75a77b69052e-502a1e551b4mr166978451cf.33.1768841180580;
        Mon, 19 Jan 2026 08:46:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9ee19sm71855641cf.14.2026.01.19.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:46:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsOR-00000005IML-2VzR;
	Mon, 19 Jan 2026 12:46:19 -0400
Date: Mon, 19 Jan 2026 12:46:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
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
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dma-buf: Document revoke semantics
Message-ID: <20260119164619.GG961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-2-a03bb27c0875@nvidia.com>
 <8bc75706c18c410f9564805c487907aba0aab627.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bc75706c18c410f9564805c487907aba0aab627.camel@linux.intel.com>

On Sun, Jan 18, 2026 at 03:29:02PM +0100, Thomas Hellström wrote:
> Why would the importer want to verify the exporter's support for
> revocation? If the exporter doesn't support it, the only consequence
> would be that invalidate_mappings() would never be called, and that
> dma_buf_pin() is a NOP. Besides, dma_buf_pin() would not return an
> error if the exporter doesn't implement the pin() callback?

I think the comment and commit message should be clarified that 
dma_buf_attachment_is_revoke() is called by the exporter.

The purpose is for the exporter that wants to call move_notify() on a
pinned DMABUF to determine if the importer is going to support it.

Jason
