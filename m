Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424804;
	b=NcL+8tcqEELphEXv5PrOsyl7x/P/GvZChMlhppv7FsjZt0q10LBSkrw1ekeknuKB5i4/
	 io07VSBInHM8gezzILb+lwK8UOWqKZ+OGBR+wJJqcEL7H2mKyocwpSTEmPpsqJ0EEi/Xz
	 N6Wv+ilwrhzY3xfh/2zteWe8K0Z/nD4IrPe1SdNMBaFQK8+4xJugKldkhJoQutjSbXsnH
	 Ys8Gwvrcg05Q1vPYjFL8MLuxVH5u9xqO4eI+42ZTYpK7xy5VSopWds4RhwsNUYldd7KXF
	 y4Y/XJfJwzmPsvUmZw2hKcVx/5N90v1/SvZlnEA6+/sACsVn/3DlWzmTSt2R3x4uuAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424804;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qfVG+9159819Kzvw9diB4DBZrJSQoGD8HuiVS/PJANk=;
	b=afHgIx7LX7u8wDxh8Xa+p0nK+GRqE3JE5N/9Nd2xB47QtfRNUzqQcckjRTJE3+Xe75fl
	 FgXd1Ow25lm9COPwjHbT1jtHswT/jYPPJjnE0MqadQOh5t6XAEX0ZXYmbAJQcZ+2URHbT
	 DcXNt/wl0gwLWxOiJWPVeWIvq9xffr78aMPuFUv2v/82HOB+YygdkW0PKNO0JlmvU+M8s
	 pSTjTdqDFQkQ27cswHuNwzFNueljCcLHj8EpM6fEVa0oAZWrtJVOEJZ6EbTd65jycY3fK
	 2FuZvc32txSeo0umZ2FVnxW7LyCrZPXuaNOrXVJck+9TJxRBT9pPkFsqpAG0KmRHg1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6F606A32D;
	Mon, 23 Nov 2026 09:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2C6F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 74CE4244C20;
	Mon, 23 Nov 2026 10:06:42 +0100 (CET)
Date: Mon, 23 Nov 2026 10:06:41 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Will Deacon <will@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/sun50i: Report TLB invalidation timeouts from
 iotlb_sync_map
Message-ID: <awQCEz3ip1AwDBjR@8bytes.org>
References: <20261020170324.1223144-2-oss.patchbox@gmail.com>
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
In-Reply-To: <20261020170324.1223144-2-oss.patchbox@gmail.com>

On Tue, Oct 20, 2026 at 01:03:11PM -0400, Yuho Choi wrote:
>  drivers/iommu/sun50i-iommu.c | 42 ++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 16 deletions(-)

Applied, thanks.

