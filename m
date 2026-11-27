Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778352;
	b=B/cn1uYfF/Nkrmiy6YynLJrjK+qjTJu9jktFAxyM56/4a3qdaQeV8IseiNm5kzUg7i/G
	 ilMnC1heBVaaGrtsemFWMM7XHoem+q5qFadL+aazau6UyA8gpH83fvK4TNkYDnHPrLIZP
	 amtX5+Kzt2ZjRU7XWQ72sGLNwGaizjTv7nDXi6RstztekoLIDz+yl2JZJlhf5YoobkGXG
	 EK8KYJTcWedXi5JqRJR7oqVFrXbNoMwk1bl8TSBRcaB9l4SDZixZ/1TJK+oyNvUN9u9vg
	 Nz74etSGR7zqRjhKlDXcxRNZWj7C4i365ZQLuExG5RAXnQwr5Ob/0CDq6rbONH751Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778352;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YBXEOAJiJfCQ9GE1k0BvVgt5VxsFrrFndRGxSCCHo0E=;
	b=21SkwdHYtywV25sW6nCWLROU2yRWQjLRd7lQ9HXXOkY5AS36+KVc+xAHZst9L5LGHw9J
	 +s16VnrUSwML214wdLIqVgcR5pYqsuUGWzX6qlH7WJClsT8NgtLlUqVm8Pv9y4ktNoUVb
	 MekQF+Y0AaW/elEYO3wEtrlMAeHV6Uu2Lfb1JwTJUD4adgyrW9Vl54P+Egsryn1uwt5GJ
	 hXmB+ZLDWHZAOM/7lfJZRpVbrPEP1cx1bWi0LkYMhC+zkL9XcIM37I1Z/lKlozon1U4yI
	 eMzF1ZRU4s3Cr0alf6bASCTelC+icGFN1V5DaQYerh3JXMc4VZj3JOp6SUmYuqCNkxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9AE606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B9AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8CB8224539B;
	Fri, 27 Nov 2026 12:19:04 +0100 (CET)
Date: Fri, 27 Nov 2026 12:19:03 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Qing Zhang <diasyzhangqing@gmail.com>, iommu@lists.linux.dev, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
	Tal Zussman <tz2294@columbia.edu>, linux-kernel@vger.kernel.org, 
	syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] iommu: Fix dev_iommu leak on mock fwspec initialization
 failure
Message-ID: <awlnF_rpSUDAMwiV@8bytes.org>
References: <6ae402bb.0c1d3ab6.e3d48.006d.GAE@google.com>
 <20261107140000.1-1-diasyzhangqing@gmail.com>
 <awQGCKf4UGKO1bjw@8bytes.org>
 <20261123145150.GA179082@ziepe.ca>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123145150.GA179082@ziepe.ca>

On Mon, Nov 23, 2026 at 10:51:50AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 23, 2026 at 10:23:32AM +0100, Joerg Roedel (AMD) wrote:
> > On Sat, Nov 07, 2026 at 10:00:00PM +0800, Qing Zhang wrote:
> > >  drivers/iommu/iommu.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > 
> > Applied, thanks.
> 
> I took the other version of this in the iommufd tree
> 
> https://patch.msgid.link/20261106-iommufd-folio-dirty-v2-1-3f0b0be58c4b@columbia.edu

Okay, dropped this one from my tree.
