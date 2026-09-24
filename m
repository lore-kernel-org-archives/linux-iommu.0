Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED0A3AF676
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251445; cv=none; b=mk41K336n3RZq5WSHojQIQRNumLeXOivR2xEhNsdvf8Fqz4N+aT+2Pcz4YYksBV/gd7XAHyzx2xdZ3rUIsANe0lagGkwKwugsdt32vt6utgs94gluTwiPQZnW62WwvaLJVTEzKE/j3xQml93IwwLEbrWVWKnyRL38qKMPEe7Gps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251445; c=relaxed/simple;
	bh=kdUOaPKwgRuI6k+XN0TSBHEjJrOPQ9Rn7XoA1G8Zeg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJscEKHkahskmaVCV7usxBGUsTOeGbDelo2aq5VpjTk704Qk27DXFAUcQYlPoM27O9y5qqgXQI34LuMYk84jCbC1v4B1qcp5NKSyUScMc0k6MC5yBhfT95ONfanq7/ZMmK6+jiqr17OhQFfsE6rsJ90ODLJZ4hVkuQaURj/evNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 48E981C7465;
	Thu, 24 Sep 2026 14:04:03 +0200 (CEST)
Date: Thu, 24 Sep 2026 14:04:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix leak of data->entry in
 irq_remapping_alloc() error path
Message-ID: <arURoy4S2KIfvEhg@8bytes.org>
References: <20260922090035.1724-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922090035.1724-1-lirongqing@baidu.com>

On Tue, Sep 22, 2026 at 05:00:35PM +0800, lirongqing wrote:
>  drivers/iommu/amd/iommu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.
