Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADF417F2
	for <iommu@lists.linux.dev>; Sat, 25 Feb 2023 06:36:17 +0000 (UTC)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7BF14223E49;
	Sat, 25 Feb 2023 07:36:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1677306976;
	bh=fINj1L/2N/K34tvWL4lOCuHLc/Au0lnD8D8hQA8Fx/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpUIrqBQHyU0lARI5wVll2WEC9NpecnTYoxYpSHtmdXA0ausjLdaqrJcJUr5XIcav
	 S4Mp4JLWYeXzRspDBvMYQ9pEikVSbl3l7p+jSlLpsTt5FdUSYKrohqW+BEpi6EMxFW
	 OJTcq3WKx5UpApjpcXdiSRla1EJvo8flca4MiN2IU05fYXWCMO8BLn3lGe4oYgPiOV
	 plJuG6t/VS14brV2yYSyUCJfNMXpFhxh8azE+jb6a/Ch/OmtPlQDLCcUY8tibPqWBa
	 UKYR3qO3hiyS1WP2zn3CT4oHlagglUW/Trlxp+Qjepc0SzaFgWcp+P7lJRxENQZM4V
	 8CHi4vrLxH4tw==
Date: Sat, 25 Feb 2023 07:36:15 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v6.3
Message-ID: <Y/msX5PwHtvg3Jnv@8bytes.org>
References: <Y/SGAafMEGBn4fWy@8bytes.org>
 <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
 <Y/k1pGjjRIznCIu2@8bytes.org>
 <CAHk-=wg__gUh4gSVzCJqoCFMDiiQRDRuBaX=Yhra3=mxb7uSHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg__gUh4gSVzCJqoCFMDiiQRDRuBaX=Yhra3=mxb7uSHA@mail.gmail.com>

On Fri, Feb 24, 2023 at 03:14:21PM -0800, Linus Torvalds wrote:
> I suspect you mean rpmsg, not rdma. Because I just pulled the latter
> with no conflicts that I can tell.

Right[1], it was rpmsg and not rdma.

Regards,

	Joerg

[1] https://lore.kernel.org/all/20230127180226.783baf07@canb.auug.org.au/
