Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC6815E95
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 10:40:32 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0ABDB1A225B;
	Mon, 25 Sep 2023 12:40:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695638431;
	bh=ixpbAl30uSMXCbWCe7QIuo3MbvUbWLssM/PbpFm1VIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w2/ocTefnRdXaUADT/XWIlqgGDkU9BhEFSzKhWPg/NggG2JU/k43AJbEnG+9pUa8m
	 4NUSqQUcnmMFbj9geR7Pn8LbNYZu7QfT7ocuSyQHLeEL90cUbpukUOVBopC8WE4X00
	 wiufJWU6QZWvwra8k5Q0bvz2g7k3Ds6G1Poaeh5BB4PlE1ZMvipNFvlBMICSMdTsiz
	 uuv3oyF9oyPXaXNu7Hdh94R48DwCjeybw2bbl6fElz1nX0E6j/2nmKv1ULJb6Uzat3
	 49vKUCwVkr+X8YXOwRuopNPwgr4Lr0U4siptaJ1zfP5bMXAKoFsl1dLEAc5h0BxcjT
	 8cB/9yCg8EfzQ==
Date: Mon, 25 Sep 2023 12:40:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vasant Hegde <vasant.hegde@amd.com>, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v6 00/14] iommu/amd: SVA Support (Part 1) -
 cleanup/refactoring
Message-ID: <ZRFjnaztAmplwIBW@8bytes.org>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
 <04e44120-61fb-3aa1-50b7-8a9ac01cea7f@amd.com>
 <20230921172147.GX13795@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921172147.GX13795@ziepe.ca>

On Thu, Sep 21, 2023 at 02:21:47PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 03:19:37PM +0530, Vasant Hegde wrote:
> > On 9/21/2023 2:51 PM, Vasant Hegde wrote:
> > This is an independent part of bigger SVA series. This particular series is
> > tested independently and it works fine. Can you consider picking this series
> > while we work on sorting out Part3/4?
> 
> +1 

Applied this, thanks.

> Also the v2 API removal:
> 
> https://lore.kernel.org/linux-iommu/20230921093140.6162-1-vasant.hegde@amd.com/

For that I need more validation that it will not cause regressions on
older hardware.

Regards,

	Joerg
