Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8425A14298
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 15:18:13 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8BB4A248084;
	Mon, 22 May 2023 17:18:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684768692;
	bh=OmBVHj3DPBXJcYJPJ1O/w+bYN5WmqeyFhld5P3BR4ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHxjIrksQ8WBNCLwx7fuFwqt5WJNdeTFinZz32zZ0Nxmip9ma63L9EifyRALWOUqx
	 MBTyFRxxjxogk9sU2YVOLQJ3HlQ0VWxc0Fhw1KFUfcxgYRfYApOu6ox2vNaJ2hqHhE
	 MPgb17Z0QoM77ZB5wPtr7UNCb7JWLWrIvU/EzA6l9sobqwodwKg8xM+6eTJAqq4IOs
	 eWkr7w/Pp3tKzNPDE6rCxDhObZ9SV9nNmngoJ9Ja71RdhHKKBUl185dQ3pPrQoaK7B
	 ySvAeTBqVDTEkfFsha568U5nIWHh27s1vNtTubrtZ0vlfaJyVXxlyYrxNyabTUl/MB
	 e/rgEfcQ3YsAw==
Date: Mon, 22 May 2023 17:18:11 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu: amd: Use page mode macros in fetch_pte
Message-ID: <ZGuHs7TIR0fcFfdo@8bytes.org>
References: <20230420080718.523132-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420080718.523132-1-jsnitsel@redhat.com>

On Thu, Apr 20, 2023 at 01:07:18AM -0700, Jerry Snitselaar wrote:
>  drivers/iommu/amd/io_pgtable.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
