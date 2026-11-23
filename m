Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428002;
	b=Ql8PgNaE1uOZLTAC8v6r278fcln7roBGtUDI6b4TbwtATNYNCw5RL/xbJ5An0UvyEJsO
	 x2sGW80F6ct2KgpqMRs/tegosdfwQjeYWlntBBbZfvnzcbstEA/ge6yttiD5UfXXY6brk
	 SwkOom8lOal+WGdzpG0STbdg3Gl8Hom2weEEgiwOI9o4zQFEthqTUnJEYYLOW7puVqa0N
	 IXFT1YzI1ufdFQmDcFbpe5dsIeFChhQTVoxgd1nPBm2vBwqm2XWABAInN+ybn/sMp93AH
	 0Am6+H2TAXobOZt3iJl7KHIKb8p3kCC5r3huYxzGGtI4RUVeFaxJe2XgOZnJj0/+06Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428002;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DUUt4d5FfX5wK9J0Ab/mw7sF993N4uPKgtbtDWygzpw=;
	b=WyvxlaCmB71/1PwAOxlio9CJH9oi42eJpaTWkU3n4SxaCQvjTt163Qg107g/atJjhcdF
	 B00g7cGYtLtemHxtIenGW5yzfck+lAtkqy6r7uEKfeMxjGQKtPw7NjhI3Nh2FcV+dsGsc
	 F+WZHMafS6gGoqtLpyHKrfhFaPXOWBdr8+7C2RS7uEj+B9OAId46YdGr7kxbktlswi0IL
	 5G0NFbw/ClE0/CqjSDtkppNsleDjOXF+P0sUVLvC0rRvvAtLqih5EYu+Zy4Q4rUe9IWAi
	 8ZtU+oxlhjLM0vWRLGG+J13e8i/BoUa6GBxWJ//jJpLmEL51FNWyqCzbIX+goYQ8rpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9534A606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 10:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9534A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 019A62436B3;
	Mon, 23 Nov 2026 10:59:59 +0100 (CET)
Date: Mon, 23 Nov 2026 10:59:58 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Will Deacon <will@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Dexuan Cui <decui@microsoft.com>, Yu Zhang <zhangyu1@linux.microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Message-ID: <awQOkV6RFl0TM6Hb@8bytes.org>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
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
In-Reply-To: <20261112195710.1417744-4-oss.patchbox@gmail.com>

On Thu, Nov 12, 2026 at 02:56:58PM -0500, Yuho Choi wrote:
>  drivers/iommu/hyperv/hv-iommu-guest.c | 29 +++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)

Applied, thanks.
