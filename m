Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE825477E20
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248790; cv=none; b=munhr9UWRcvW1LVm/OuD4RG5ii1Zgkb6fua/0ZR9gy3u1Scsk+yodr2oai7T69Bj40DCooVq3lcwffBgR5AP9niwMSx+/+/LKQYAWqZSUvI6ZI26RA1ZpmP/HsburvnDNAD+Fqf5uieO116rGsJxASZ7gV8glPY9gUHKt5Y1ff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248790; c=relaxed/simple;
	bh=2TFbphBbI/gwZlavoTD0D4ENeBckd92XPWy8tsKPZcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSpI9WahoHMhs56PGddsu7WxgGnRuTmqbOBIyGunvGCwzIik18q3GXgKN6dox6wKeuuWKjdHMsFJQeVzWzTo0XCbe1lnjkHMnNVEPLvavq5ghmn0TJQp8cPg+8UXe1V9oA3UM02JZlQs3LaIOH21JwtYo7idGkRhFVCRXTmDIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CE4C31C7465;
	Thu, 24 Sep 2026 13:19:46 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:19:45 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, jgg@nvidia.com, tomasz.jeznach@linux.dev, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com
Subject: Re: [PATCH] iommu/riscv: Report cache coherency capability
Message-ID: <arUHQrcUWgU5nbVE@8bytes.org>
References: <20260821112100.572037-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821112100.572037-1-andrew.jones@oss.qualcomm.com>

On Fri, Aug 21, 2026 at 01:21:00PM +0200, Andrew Jones wrote:
>  drivers/iommu/riscv/iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

