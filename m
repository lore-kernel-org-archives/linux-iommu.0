Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C65125BA
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376714; cv=none; b=NGL6B1WPqXcEZwjuxxEI2zZ+2bnrJvxpAMtQ6bTBof0vnYe04jrdlVAnKI3Goh/8S9Z/D+PEFo6MW4eRgg++leYNtVd/8hza2DL8Kxa5c+bX/FrCKWxE8Hk1tllqKCDmQcJla77CHQsuu2TegmL+ZMO9Uz6lr9ser1d82W0M5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376714; c=relaxed/simple;
	bh=H4Y1+FoVAIwvnNNM9BRYRY2i6yPu1z0wV9EZRKDv3Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTW9rnlRZ1yuNluYGRQA8c+TwqUHC8GdgHGRMmOWikKyxOPARp+dnqq3R/u9Kq/hryn43sw+Yl07QLgIufc2Fk+ZWo8dK5D/OjyUqCnwLWY8+ycxzv7I1w6mDoxZee33vi6r930C/E/vySZV0DcB4Tq+9oWSYVpHj2PLfVhnvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=iRt2tdM1; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="iRt2tdM1"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BEB771C0BD3;
	Fri, 14 Jun 2024 16:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1718376705;
	bh=H4Y1+FoVAIwvnNNM9BRYRY2i6yPu1z0wV9EZRKDv3Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRt2tdM1Auc9elxxqwNyZ4RCqgObVrbn2Y5+9LnMP+P2bbcTJ23lExaOaWmcHTPy0
	 0Juqrlmb8EQPb7YGJDzmrlwIoAK7ao6jUx3TulW1lTVDtD7FSL8i0WtN0T1lyPwq1S
	 Pc2eQLhgPBAMDrqOWs6UoDbaL8qN9D5UMA1O1x3YWZdogvE4ngalrQZls0IFQGg5Jk
	 TJEGbkol4BHvOlEiD0DhVZgmscScxkyj2+D7GQ3LkHopC797prIf5WV27CsLZuzg/w
	 y+FTL7uGhQRm84LiXPRat+iYwThUScY0DqPzx7eSYV4W+vuCMSBNA3x2xzobZ+HSZU
	 RHwTxZhkp4o3A==
Date: Fri, 14 Jun 2024 16:51:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/iova: add missing MODULE_DESCRIPTION() macro
Message-ID: <ZmxZAH84bZi-9QaS@8bytes.org>
References: <20240613-md-arm-drivers-iommu-v1-1-1fe0bd953119@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-md-arm-drivers-iommu-v1-1-1fe0bd953119@quicinc.com>

On Thu, Jun 13, 2024 at 06:14:36PM -0700, Jeff Johnson wrote:
> With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/iova.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/iommu/iova.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
