Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B523D1D52B;
	Thu, 26 Oct 2023 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="I0UkOpqK"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DBB331A6964;
	Thu, 26 Oct 2023 16:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1698332103;
	bh=aNMHImipwcFhnEH/KDApHhNmiJl+VZlZ+TvCRT48sTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0UkOpqKluA/YpkdyqQMNKspNDvlR//E6QKQRdsBWvzWfijoeiABw7TzaHmABapyC
	 t/FQp64LQTFfniDnu37MyP4K3Tctgj25VDEAW4H+4pUmVsnGTPTXtqRh3gL/UizXs3
	 CBVrnDduyDWdcTLB0gkl76Jp8Vj7IDqeydQRQ7QzwX+XGbeRQGXD5k5dm2bqXwEvZa
	 qZ0Esy3TFxOjJwSj35Di5Z/4GuIn6aKuHNrYdx90/E7oNHg0Apdmti6Lf9K5AYqp1+
	 5b+BqR5eMBsHR+ANxpXhZ0sKNVxbPUpJZJ6ISJwxvLFD4LR4756KNQuGiT7DkuRP28
	 30cNxjFM90fDA==
Date: Thu, 26 Oct 2023 16:55:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Hector Martin <marcan@marcan.st>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v2 0/9] iommu: Convert dart & iommufd to the new
 domain_alloc_paging()
Message-ID: <ZTp9xVgfz0c1_i2a@8bytes.org>
References: <ZToaD1tuNJ7tra-g@8bytes.org>
 <20F398C2-8F87-4149-9154-44EFF2A966DE@svenpeter.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20F398C2-8F87-4149-9154-44EFF2A966DE@svenpeter.dev>

On Thu, Oct 26, 2023 at 12:34:54PM +0200, Sven Peter wrote:
> Acked-by: Sven Peter <sven@svenpeter.dev>

Thanks, the Dart patches are now also applied.
