Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BAF3D4112
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536584; cv=none; b=RUov2p6qZWeYqGIXxSf7KbqjNWazwyR6+hvEzgHSKSblnRBDZ6HBxb9SJQXaiClfirrSMX4apb0vmrakVYSmoBscxWMWmbYKYl9bmiPPg0pBco2L9aAP4YopZ8Y5ePHXCZ8lfXjxTVvXOD+YDJuSQwwHmJqELvzt9dj2pPs6jOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536584; c=relaxed/simple;
	bh=GPCWI6nVfOfpazpLXLX1aP8CSGxk059XPKv+ekl7lhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoRMpcRxH/7TKKOu9CJyJM2GSVmB97PkjhaahVRlMfnekefkmEDsiNht9Z+Q0MPGIYh/7eQo5PaiY7G4yJqduVq0FdcGqsGO6k22UvzRf/8d6psHI/1Mf+Hq3Ba/760gB3wzCPTK7J4JELpXIeFVjWEwojFiPekGWxfHJVwmC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00448550d0471e54ea.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:4485:50d0:471e:54ea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1FC8B1C77A3;
	Fri,  9 Oct 2026 11:03:01 +0200 (CEST)
Date: Fri, 9 Oct 2026 11:02:59 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	liam@infradead.org, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	ashok.raj@oss.qualcomm.com, jgg@ziepe.ca, kyle@mcmartin.ca
Subject: Re: [PATCH v5 0/3] iommu/iova: convert from rbtree to maple tree
Message-ID: <asith_7x71HNWMDl@8bytes.org>
References: <20260818152505.1057922-1-riel@surriel.com>
 <arUZwesREX05SZ0J@8bytes.org>
 <mcki6p5d6u7ofhiucoz6vi3jdldzmc7yv7n3ppoiwdjbwuriji@e2ezt37ga6i7>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mcki6p5d6u7ofhiucoz6vi3jdldzmc7yv7n3ppoiwdjbwuriji@e2ezt37ga6i7>

Hi Ankit,

On Fri, Oct 09, 2026 at 08:45:29AM +0000, Ankit Soni wrote:
> Summary:
> 
> alloc_iova() is O(log n) in practice, on two CPUs and by two independent
> tools. The series costs about 2x on a near-empty tree and wins by orders
> of magnitude on a deep one, which is the trade you describe. Memory is
> the same within noise below 786k live IOVAs and a third less at 12.58M. 
> The costs are confined to microbenchmarks on near-empty trees, No regression
> in any real workload.

Thanks for providing these numbers, this is very helpful.

-Joerg
