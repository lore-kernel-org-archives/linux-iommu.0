Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDC334373
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826138; cv=none; b=lSjn+Hykr/5UwcNe/hsGaUj6d8myYXVJNaE/Cc/Cu4Mi3jPqBnaoQRcIe+IHNcb+rqb74Ic4hNtkf82qwFPQjzsKJ9HN4wt7w1cHiGB74rMtL7KBIaka6Z3E21lzhzK0MEZLOQD1y7IJXiBK1hwP62h5eVYtZQijGHi7CxHRUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826138; c=relaxed/simple;
	bh=VKk6SzIDa0VJfKCc2IipI8ftT71UavZWS/pZcUXizVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l47GkpGxO5FrMYZpVLegKf6yMBlVXzcuuwtPiXSevtGi6JjExndu67WNXudQoil03FzECgIwYOe8Mj9lrWQ49HDp3loSLvnYvEx+vwq9gPKEscDB1y/0pAYFf1AZnxxOeF3YvX89xD3eJWPxjgHiK11QM1NdXZ2Acu+sTs4RWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2+EiHKI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2+EiHKI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae4b40999bso10475ad.1
        for <iommu@lists.linux.dev>; Fri, 06 Mar 2026 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772826137; x=1773430937; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCkpZ4LdQvemSO0g73V09z38m7dGhRDD91oaI4a+UVA=;
        b=W2+EiHKIerpUFrYqknFcCGy4SMWLR9k5nsFc8gA7esllp+JA76R7CXVma+qZqd/FRe
         Sr1MKD+4ynbOmuFJpt8uvkY1BkuLp8v1bDQ5Ok5eZUAtXKeBnsiUNeBXTRdka1ubVf8n
         JFMLqheC0/4RnISAVt8rxg+GnGtnj4Y86fUfOKAQ/3AFUDOuch4lLqGcJgzmwW+apcmh
         TiLy2IfF4G8wogzxNUsAVQ0tkESVby6ZeeKWTG0uwH1rbiqqoABNYlJNjyt1T8iivirq
         fvktY+gMs++/6IFJMV31nUax9aBaEKzruZ7HSs8YuFwEfvRErWbDl2poYEFY9qqtCbkY
         FDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826137; x=1773430937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCkpZ4LdQvemSO0g73V09z38m7dGhRDD91oaI4a+UVA=;
        b=iN6He4A+4iqMsoiqtiOlwmSTn5p8My1dv/kfjN+aIFfdDYTRY2q+9YcALqisKMV2Kb
         F3A95DxscgJwXbjkY29tWU0TkwRHb8eL+9ZyCWEFOrLXlCI/Jw8QKDGX6JXy3rOEgtnD
         BCJFBv7IBkTC1qrbBBWCFEFOE6dcEpbveJxfIAXlVC3EjldIE7MDHJsfo8+STaVlA5O7
         a4k/Xy9NH61ijXocH9uDBzcamJiWw/AbKxvGPtHySTzxHiHxBvRcfraIHWXQUYytemj8
         B42G7GUDljbD74rRHbeSaDh4GrcdwVlOmMwSXg5J5HkXjtGf0AMiv3BmQeISDWWWuwt7
         BvQw==
X-Forwarded-Encrypted: i=1; AJvYcCV4hRLaoSHn8qumfHfoGfnNwKNTYI/RiZ9CBSp4YUVmaPfAUB6xebdeLhjmo5Cow4mNT1ArSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxD2BD5sscSaMxCzcnVCbkA8/U/UaINQEN1tYrutQmZ60aOXCm0
	8zBdI73qZ90z5v3WLg6S/dp29WfevVBRiiie/ot0jHFNe04GAn5OW+XNcm80XNPPzg==
X-Gm-Gg: ATEYQzyNTwXhlv2RFjR5PjpK0HyOT+lTUNzG76VcgTjA2IMg2S0XmdrKYn6TlzXQshz
	P5ZAABjxix/drm46qZ3ls9d7yLIpS6K5JakrPJ3oteHcZd2K/B+C+Vm9hHOgsAx9ryLHgG2AHKK
	scFZ6r7blBeoctF+lV15U9gLmSYYlA5+DVRPXXyDn9WWi/Rw4CmQhC8GRobkoOZLCkAYne2vN3x
	L3uBxZMRLwz5jzkDjl73POcQ33xjhrr8oZgYkyWbGw1jdKK4x6EYpfi32OImCcjZGIwQJ4N0KCZ
	8d/LATyGj/QsLAtdkfP332dgIdOoArh+VR3LnVHII/n1cEqRCtYzMCIizxTehHq++nIvx5xGy79
	s+WD/zcTqFcLKbaEqiQjlYRFYX1T/J4VYGK59289HZaY2VWTkN98V6q5KRyPrVIksWOzs0yZPG7
	je+EW2BK9rjERBK/iquUHZnxP7b7zbsskOu9ellpuoyN6YZFD9lMxzrctNn/xz0g==
X-Received: by 2002:a17:902:e54e:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2ae8ae4f6e9mr231605ad.19.1772826136464;
        Fri, 06 Mar 2026 11:42:16 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e83ad5sm28500545ad.26.2026.03.06.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:42:15 -0800 (PST)
Date: Fri, 6 Mar 2026 19:42:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/vt-d: fix intel iommu iotlb sync hardlockup and
 retry
Message-ID: <aast-ad3ZmSWh2Pl@google.com>
References: <20260306101516.3885775-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306101516.3885775-1-guanghuifeng@linux.alibaba.com>

On Fri, Mar 06, 2026 at 06:15:16PM +0800, Guanghui Feng wrote:
>During the qi_check_fault process after an IOMMU ITE event,
>requests at odd-numbered positions in the queue are set to
>QI_ABORT, only satisfying single-request submissions. However,
>qi_submit_sync now supports multiple simultaneous submissions,
>and can't guarantee that the wait_desc will be at an odd-numbered
>position. Therefore, if an item times out, IOMMU can't re-initiate
>the request, resulting in an infinite polling wait.
>
>This patch modifies the process by setting the status of all requests
>already fetched by IOMMU and recorded as QI_IN_USE status (including
>wait_desc requests) to QI_ABORT, thus enabling multiple requests to
>be resubmitted.
>
>Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
>---
> drivers/iommu/intel/dmar.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>index d68c06025cac..69222dbd2af0 100644
>--- a/drivers/iommu/intel/dmar.c
>+++ b/drivers/iommu/intel/dmar.c
>@@ -1314,7 +1314,6 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
> 	if (fault & DMA_FSTS_ITE) {
> 		head = readl(iommu->reg + DMAR_IQH_REG);
> 		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>-		head |= 1;
> 		tail = readl(iommu->reg + DMAR_IQT_REG);
> 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>
>@@ -1331,7 +1330,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
> 		do {
> 			if (qi->desc_status[head] == QI_IN_USE)
> 				qi->desc_status[head] = QI_ABORT;
>-			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>+			head = (head - 1 + QI_LENGTH) % QI_LENGTH;
> 		} while (head != tail);
>
> 		/*
>-- 
>2.43.7
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
