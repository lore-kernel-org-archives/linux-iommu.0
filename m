Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C16156E5
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="3pnU97hW"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 87E851A5736;
	Wed, 25 Oct 2023 17:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1698247950;
	bh=Z44oKumXmNElfkclGxRpmyPsTR5qH0d3Pur+vFzUclw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=3pnU97hWaP7qF7xRadKvd7jH2sZQNQP9kg6tzXIMGWM+CmNJFpBxGjkWo31QOGIM+
	 nRDC5EjeOjLgmjRLLJkWvKNyMTXV147pkm4cCHXMgNX2tnFRTBlk8hz7dK9hkadJoS
	 26hQZ1+GgKu6wk8JTABdxyLfs/efkTpBP8HylQN/rcEQw8kL8mmXGk/84+ERGqAcn9
	 I5gB2Z0r5BRxS1wg7gvqvwSV7PNWm8IsIU1hTKcqOJHxEwFJbe+fYhSxPJ2IxAgvww
	 OD3Fx45XUCpGRZ4s5ZzOUxth41l8+l0+Q71qPA7osURA+dWoTlwBXbBj6IUhvvytEh
	 hGokUPficRUBw==
Date: Wed, 25 Oct 2023 17:32:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Stephen Rothwell <sfr@canb.auug.org.au>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Remove unused function"
Message-ID: <ZTk1DTy5w8XwlA0K@8bytes.org>
References: <20231025131854.375388-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025131854.375388-1-baolu.lu@linux.intel.com>

On Wed, Oct 25, 2023 at 09:18:54PM +0800, Lu Baolu wrote:
>  drivers/iommu/intel/pasid.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.
