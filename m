Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D463B8406
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254635; cv=none; b=dhbhgl68IFA6sv+oD49DtdY4k32rOgitybEMk4H05QX4dzZkvJNtI/Yn3gKqwnaaK6ABLPlIN5NFWQ4cynkzhVWEvVUmWuHaOZekdy7hOV8LbTbsbXFoNAY2A4SRNf+GaLaISFs9qbczoZ2J4gHHdv6vW9dZahrSt9cywYL1H9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254635; c=relaxed/simple;
	bh=b/+fpaFW0vKgUAFBQ/1zRaA3lXmEdh8rLxuHE/mn+Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6JhelBrl/5B5c1rhrjo8xmQHVyRWYSL1WI8GtjHvDCT23XXNibvXl00z3KBkqG1s/Ky4sW0aDhRCEJ5wl//TPZE1jc3IdnaVptvxf4CvOqRIcmhjOqQUfDBhwueUbTbvOSzuAVPCN0DfKYfThZ/s9sY2bMjoA6ezbvILwPsdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGOTTX5n; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGOTTX5n"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cede6375caso20605ad.0
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787254632; x=1787859432; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tds+ZK2HtbgOhGJkv8NSgdEf5Dv6/nMJNRb4hCg7D38=;
        b=uGOTTX5nxMgac4er+C1UhSixZRDdw6n3O61YS3M2H7irmRLO06z/8tfw4GOERKovDq
         4eTAjc2ujLlCenDyMTPVwsNrP5oFZp+4NtwYxxgx/ffnEKS6YYTYQ3gK+VCTN90hl7O3
         3oYR8/RCz9Ciwj1n0tjtRInZZ0YeJGW1gMewhF+fFZsAbbweLK3zrp8JjFqHtAu8l2K5
         qEo38kuFQNLxdj5idQlOvoP96ZNzJikW38TYHq42oro/NRg2cf1xbfQOcOertF+NxLMN
         GOczbhzMWzAsSMGvxjuUuLvKp0U6VOM9bFp/1qMdryh5SyFM6GdY2BFSRC43rDopKcIz
         wCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787254632; x=1787859432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tds+ZK2HtbgOhGJkv8NSgdEf5Dv6/nMJNRb4hCg7D38=;
        b=PPjzgXVaYh6y4tWU7lqZ+vdqgxVqFQUGVmLP1B71XuVjD7xK+01EKzAVppg9PfgRyG
         uOUZARsmYecQpPwcAZTzRGJ70TedNef1Ro1vUtC9oQSW4nU5fk3Jrcrfvt4f4nDUMEdz
         HYdx7pTcbH9njP2G2EJ3Sy1PT4S+8v0rUBlXjuAfvFdTYWcAAMhsid4hHKozLXHaHLFX
         46lMnUUja4nIYAHSKnLf0AP0XHtop7+Dvx8zVh+yNRZJ8xcRfKTMoMuGOHPpZ+GeYMsG
         wWy+MLksdfazYSX0Ga8SHsbWmZB2fS5dARug8aeUoydgZwpCizWD0EAHmOlv/Lb63BQz
         MXYQ==
X-Forwarded-Encrypted: i=1; AHgh+RomYQmWJjawMKuYm2I4BV3Ug6kDH8K0Q6e/Qo34bMZ4IcUztm9l/GDd1iTiLPETWiYcRQ0Xcw==@lists.linux.dev
X-Gm-Message-State: AFuF++n02vF++pQKJidKtNGoDOldZm8t0FiCNLo7fRr/Ll78Tv/XTkVF
	BCaMnHAvXawKKlhNlciV3bI4GMWPH+0paXY9CXZQoaNf9bdsc7wl6Gnc//R0ZFfRUQ==
X-Gm-Gg: AR+sD13z+gkXdwo4yUKmAUz2j4xXoZEu9SnfICstFi80ozUb2R4fkmQjRTelW65wQdW
	Pxb7psi0+c4ePHRh5H9DJK6ldgUBFen1ab3ZM78VgGPKlJOrK9OoZKd6bRxg6nJr9CNXXsHdQAA
	TMyHkKtgcpaiw3LF0CDUxRRzA3kLBitzSCHDvPlmCTMZXvmhxvgmQ7+kUrnZp6Cmmb4qoT711jJ
	2gEeOJcligI9hjUyInvKp99LciM5cQ+EPCXWexKW+xeuTsE5wR4WKrp471QXecgVTWVavCWm4Uk
	/UPxryja/zx+VFA1JFQZ/rBMMU8bFJbQGYKx5XhsNqd3E6DwsdrXGc+M8/1K3VXDqoU4Bo9yFo/
	lfCzBVl+V5x7m6Lwirp3cy4g0WOEB8BtAeZct0n/zFPD8a3qExeuEBjpayEi6wDfEOJYt4k91iR
	rAtNuQwJ8zCv+FVeb8dUNrVQOh7V4coGDgq/2IhdBxjuEbD7f/mEXQ4TizJHFTUDt3jvdlhT7ec
	b9uJK6obePBPQm0wZz5IuHGJriJY3m8qLaXO5ghuoQ8ZBBUwjT/yLjjztFkqBjq74SOMw==
X-Received: by 2002:a17:903:40cf:b0:2c7:a13a:7fe6 with SMTP id d9443c01a7336-2d64b33392bmr1459795ad.10.1787254630549;
        Thu, 20 Aug 2026 12:37:10 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4552234sm160717a91.2.2026.08.20.12.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 12:37:09 -0700 (PDT)
Date: Thu, 20 Aug 2026 19:37:05 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org, iommu@lists.linux.dev, 
	joro@8bytes.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	will@kernel.org, "bikuan . zbk" <bikuan.zbk@alibaba-inc.com>
Subject: Re: [PATCH] iommu/vt-d: Fix IQE handling to cover all descriptors in
 submission range
Message-ID: <aodXMGx1nGwyRMRa@google.com>
References: <06975717-677b-4c81-8c74-63d42b335db7@linux.intel.com>
 <20260820144741.920858-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820144741.920858-1-guanghuifeng@linux.alibaba.com>

On Thu, Aug 20, 2026 at 10:47:41PM +0800, Guanghui Feng wrote:
>Currently, qi_check_fault() only handles IQE (Invalidation Queue Error)
>when the faulting descriptor index exactly matches the first descriptor
>of the current submission (head == index). This is too restrictive in
>multi-descriptor submissions where the error could occur at any
>descriptor within the batch.
>
>If the IQE is triggered by a descriptor that belongs to the current
>submission but is not at the starting index, the function returns 0
>without clearing the IQE fault status. Since hardware stops fetching
>new descriptors until IQE is cleared, this leads to an indefinite wait
>on the wait descriptor completion - effectively a deadlock.
>
>Fix this by expanding the IQE handling condition to cover all descriptors
>within the circular range [index, wait_index]. Use explicit bounds
>checking that properly handles the wrap-around case of the circular
>queue.
>
>Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>Signed-off-by: bikuan.zbk <bikuan.zbk@alibaba-inc.com>
>---
> drivers/iommu/intel/dmar.c | 15 ++++++++++++++-
> 1 file changed, 14 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>index ba675b08cd20..ecc95af06f61 100644
>--- a/drivers/iommu/intel/dmar.c
>+++ b/drivers/iommu/intel/dmar.c
>@@ -1366,8 +1366,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
> 	 * is cleared.
> 	 */
> 	if (fault & DMA_FSTS_IQE) {
>+		int head_idx;
>+
> 		head = readl(iommu->reg + DMAR_IQH_REG);
>-		if ((head >> shift) == index) {
>+		head_idx = head >> shift;
>+
>+		/*
>+		 * The faulting descriptor can be anywhere within the current
>+		 * submission's range [index, wait_index]. Since the queue is
>+		 * circular, this submission may wrap around QI_LENGTH
>+		 * (index > wait_index in that case), so check both the
>+		 * non-wrapped and wrapped cases of the range.
>+		 */
>+		if (index <= wait_index ?
>+		    (head_idx >= index && head_idx <= wait_index) :
>+		    (head_idx >= index || head_idx <= wait_index)) {
> 			struct qi_desc *desc = qi->desc + head;
>
> 			/*
>-- 
>2.43.7
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
