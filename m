Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432200;
	b=xI+v9KA6RHMdLY9I/dFZUIEEu3AnIKJNn1+1vq7TK+LajIZR+yF174q6V2ACMWzZcvM4
	 wA55Fv8hD8uhR/rNWWkyB/z9tV1no6tNAyIRfCr/Gr5kYgALL9nqEe2+CF213sv0aLIO9
	 jhuxnZyo17FUIc0AU4NDpHDnVQIUrfAVaaIjULRzUju+Mr3YW2oRgsfWGvVxCzcg3pWqD
	 H3qxeHmVyqKJYIkLK2iAHB6q+9q8TBIN1qKGLYN7IQAaQczUSDHBCKqFENqPMLVtdbci/
	 F9q3w4VdsEplH3VSVcopLswS9Rp8mg/82pc7FtTWDgFPp/CUK139BoDzqb+YEJAdQ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432200;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lrb0YFMFrFE7HyTUV8Y84CUpLSY3p3XgELY1JaOTjxA=;
	b=UMSHv4dn5pX1v2c3rZVUwNKngeNPwNU3w6C3ilIdc0bFDat9N+nlC6Wr3T+Nul4motws
	 6Tz+DYzqXwmnsqe2qvDOBFJLM2iltVqH+ivFU0vp/P163PwNaBJ6AAncKjRt4id8NVdU2
	 nUdxsp0jHqB4ZqK8okW+sF/LyAb3c2Y1vH7N/CGmTF66OGf7+WindbMDzEY/A1+g3Yhfo
	 GI5Fme6G0FA9qBcm+A9aABcF7MNHEPUjnylz6SpdsLVsjAIa9ssNcJUxX2+kCaFzPVETz
	 R/Kgk3R9Nso6TVo2Jw9j/JMXZws5Z5tTylt6SFVHQGrSyahZFmJT2DDYUvFhVJccqxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C2606A33F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D03C2606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 26D0B244C20;
	Mon, 23 Nov 2026 12:09:58 +0100 (CET)
Date: Mon, 23 Nov 2026 12:09:57 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Yuho Choi <oss.patchbox@gmail.com>, Will Deacon <will@kernel.org>, 
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Yu Zhang <zhangyu1@linux.microsoft.com>, Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Message-ID: <awQe8NR3bnJoujMC@8bytes.org>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
 <awQOkV6RFl0TM6Hb@8bytes.org>
 <MN2PR02MB68630C9F5A4AD705B3838FABD4452@MN2PR02MB6863.namprd02.prod.outlook.com>
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
In-Reply-To: <MN2PR02MB68630C9F5A4AD705B3838FABD4452@MN2PR02MB6863.namprd02.prod.outlook.com>

On Mon, Nov 23, 2026 at 10:48:09AM +0000, Michael Kelley wrote:
> Hmmm. Did you apply this v2 patch set, or the v3 that Yuho posted a
> few hours ago?

I applied v3.
