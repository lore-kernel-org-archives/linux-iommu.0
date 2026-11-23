Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429772;
	b=y6IEJKFNE4/5twoTSpdFtA8ufRJ4vJQLAzE9WrXXBX8sO+UjQodE6Zr0RP66dmA4aJYW
	 gH4aImlhgMV99YXLDClfwnYZTlkvHl+XLKeMNbl5yqtbb0UDcOBP24xV2Q1ePzC3cUt/C
	 a2gkDXf/Yth3dRZ5u9jsGVqnCH/mJA/94y6641BxsZ2SJ8TcKuvAHciYsL0E91yVsDgV0
	 tBr5D64k528g1acObm7Kv2BdsSDk2My4UHIngobOsePEjcTjDITMHWX4NpOjiy7ZWvqH3
	 pEO3krTXe9HHXsGwS6yhwRNddalyS7lSGYNH3TLWTviJhbkaS9aEShryGHGr7gwUhWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429772;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jndRP0KHeEAhLbcGZ7O6vlSEpn7B250QW9w4/f7LcOQ=;
	b=PIcQczPO3hbW5Laao1ZkfrkNrZ3oHGn6/m31fdTyKu0R0W/p77/wfeYJX/lT/HHESa5P
	 LBqDwlDfE52cnavIDWnXrYUrLFt62ZpiEiZL1Wg8LTrWsLgO23Q4lN3oSxK7rBUp1/sjO
	 tTQ8gbC5TZo0o3//IQuLYHl2tZxESLZ06FKDCrL4TOa4zAPs5okFeMzwipwbG5gJmYNIL
	 a+c/t79q/Ix92OJfafXDqztTawQVKNAz/RdV4evwHCNgYA7SyO/bd0xGdOqzc+fPOQ2e+
	 nBVDd31AT2uF+irjLzUgor/p0jQt1EGJ07rShniBQwt7nLL5SXj1UbojX7gjC9cE/Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF8606A31A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 10:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AAF8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 39291244826;
	Mon, 23 Nov 2026 11:29:31 +0100 (CET)
Date: Mon, 23 Nov 2026 11:29:30 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: aiyengar1990@gmail.com
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/vsi: Fix the runtime PM of the IOMMU
Message-ID: <awQVfiCrm3CABa_0@8bytes.org>
References: <20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com>
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
In-Reply-To: <20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com>

On Fri, Nov 13, 2026 at 08:04:35PM +0000, Arun Iyengar via B4 Relay wrote:
> Arun Iyengar (2):
>       iommu/vsi: Don't leak a runtime PM reference in the TLB flush
>       iommu/vsi: Don't resume the IOMMU in its interrupt handler

Applied, thanks.
