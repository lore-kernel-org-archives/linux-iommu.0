Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE342CA6
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 08:53:09 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3D75D2409B7;
	Wed,  7 Sep 2022 10:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662540788;
	bh=PbJNz8e+eLuPd03LpOTi4uNeF9KXbmGmwB8GxoCqd40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IG3Uto1dtr422Vi2d0xYJaLwwJyzsAB3r707UvCJmwY1S8zNC1ZB3yOmb7DmX2JJP
	 If78vWvcb84VtumNkmqwnG6ehqrbPPi3J6FV+yCgtSW2LQgYgUNZV6x6GqQcATzkok
	 5Vvt50zREcfxQXbCwoBA4lWDDSxDXYNXphFuDx1m/Euw2yziAJ73dMMzRIapgb2K5m
	 yemT+u00rEfjDhQA3uopzkwlHHZbZ3kpVBeVY9DdPT5H/Zjdzm/jyCYeloKzYIgCts
	 UBk+uQLyatswchX4BUwZQvdkWQ22GQe05fm1XbOMiJMzxhMuZCdFnmM4YLOMb2BtEq
	 CKA+vkza/2+6g==
Date: Wed, 7 Sep 2022 10:53:07 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yuan Can <yuancan@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: Remove duplicate ida_free in
 iommu_group_alloc
Message-ID: <Yxhb86pnOWLJ5qoM@8bytes.org>
References: <20220815031423.94548-1-yuancan@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815031423.94548-1-yuancan@huawei.com>

On Mon, Aug 15, 2022 at 03:14:23AM +0000, Yuan Can wrote:
>  drivers/iommu/iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
	
