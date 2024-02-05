Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5247F70
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156929; cv=none; b=Mr24A7C5EO1JBv7zknv2tMiRBFwAqeyVWuTZp4m0evAXRjCD4t8iCFdD9rDMMSROASaqbjmiq9PuptqwRhojIvX4w+8uNots589hMxE+9tdoHlWtUDPsuBhsOVM8/wKTeicJQ/bw8KbdrcItLBEdOzdohNtcnlHN60ZW7Dm6c60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156929; c=relaxed/simple;
	bh=FyCREsOOqtnuvOoqGa+Thr/EI1MAjxJC1gzLyFekjtk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DIWBP46NgW+Ts9DVOy4Cpws3merVnnM362+mMLpoziBnSxiF3EoI4l5C/AblPK60xj1I782iHHWoY3ZLPsNtIwGLvF3kewBkUrNL4uQKXX6HXFmlaJrUdhASecY8bmvyqFbuw+PTVi6wTCunGpN5SuTlECqPurc/cXgr3IaiX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1vwOmWqK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1vwOmWqK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d93b982761so32825ad.0
        for <iommu@lists.linux.dev>; Mon, 05 Feb 2024 10:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707156927; x=1707761727; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hMMhCHPdnY6a53r0AdRn2ZwMuoekqmZTBFnKYjfzR8k=;
        b=1vwOmWqKlevXvYu/jeswEA03Auc+C0uJRcLNd9evw4V7CNF/e4c8bU4r15/2EsrEyw
         ymQ50/ix+EOKbZJiHjnYl9NONsewtXmd/qnzOSj5KpZdLFA1WZOgc2XmU6w5RWFQnqxk
         9HMSKmEw0ap2YWzT53Sv4L3ddp2sRQPbpsfLJ8v17CTIJ/FVH/aR46Ky4RTt2CDZg5t8
         rjqNduoYQPR7k8LuaAgThYgsBwNcq8OX6wZRxxgmi79ZbmSK/zj4XiGmzCt2F2F2SPVc
         mtgc4zu0Rq1xQZ5jB3Ovre6Fi2jxJkIIR+dUzWcALvtI9Shf7tW3wPO5K6CQR+UpCffC
         YnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156927; x=1707761727;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMMhCHPdnY6a53r0AdRn2ZwMuoekqmZTBFnKYjfzR8k=;
        b=dLpYZGr9cu+daxniXnJi8jh/kAf8VEV9tR74UJOqGY1J+aOSXgIurkgLTpB+s9SLj6
         YqHWmI4vAGlinY2V/1TZKnCN8WJX2L4I+eQTpVCJzbr/9R27dW1zF8wcKx8H+SbEH7s/
         G/bAvdhnnUwi1sWvAGk9uGu6epZRMPefDrBtuM2/gMhLuZ1ThmmuRZK5zvmSIPzD4eAF
         q6Rp39cqq7NTKGNExWBVhYVPU8NYD+hFY1i47RGJx/7DAbBQ5cL4jry0f8epA6PQO80+
         ORvDcqIgFnvGT4O3QAb010xAc20C55ulkJYqH/L9BkIXTKazNXxCPO1xUdchCVJN7Hf8
         JNLQ==
X-Gm-Message-State: AOJu0YwkuQXNYYCYCbO61L1gw/3/Dx+A+zLxCB2LBXoyZETnJPZMsg21
	WK8GW5We3QaYuTQYBiNQwbjtQaOLuYnclj4z2ol3ErrEWwO+7mToKMSwliX2EQ==
X-Google-Smtp-Source: AGHT+IFmTazqpWxkymD9klp2+KFfWCRx+EupD0mFw2cWZMoCAXLe/HcNB61W1KMXdPfJpDeeBspVlQ==
X-Received: by 2002:a17:903:22c4:b0:1d9:7a7a:3cf6 with SMTP id y4-20020a17090322c400b001d97a7a3cf6mr27342plg.12.1707156927140;
        Mon, 05 Feb 2024 10:15:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpktWhh0NPQ9FcoM14zHXRSVA+RTqr1vPpQx8XPTdbH/a9BsBmFFWsoICE46TUKEz2jnUcs0RApYUBIZO3cT84iftmz8MttslQPRRdCYheYhXIe6a8hD1DwQlwkCsTYZnlHAbBRnlI8tntWDUXpCoiJ4Ken8Pr+/0KjyKOIAhjGiomQTQRlXCWtaCsPPcC+JIrdNOLcNagrcQTtqRKcttUEj55yLcKaYXkHiEgvvcHdB6EAdtODlFokODt1vWmC2pvRz7B0RQhLIpQYdsQbc8WLgjK
Received: from [2620:0:1008:15:1e99:232a:d721:3dff] ([2620:0:1008:15:1e99:232a:d721:3dff])
        by smtp.gmail.com with ESMTPSA id ka5-20020a170903334500b001d8edfec673sm159673plb.214.2024.02.05.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:15:26 -0800 (PST)
Date: Mon, 5 Feb 2024 10:15:25 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: joro@8bytes.org, will@kernel.org, pasha.tatashin@soleen.com, 
    iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    yosryahmed@google.com, john.g.garry@oracle.com
Subject: Re: [PATCH v3 1/3] iommu/iova: Tidy up iova_cache_get() failure
In-Reply-To: <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
Message-ID: <9a779ae8-c965-b2b0-6f94-865f49ed0e9b@google.com>
References: <cover.1707144953.git.robin.murphy@arm.com> <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 Feb 2024, Robin Murphy wrote:

> Failure handling in iova_cache_get() is a little messy, and we'd like
> to add some more to it, so let's tidy up a bit first. By leaving the
> hotplug handler until last we can take advantage of kmem_cache_destroy()
> being NULL-safe to have a single cleanup label. We can also improve the
> error reporting, noting that kmem_cache_create() already screams if it
> fails, so that one is redundant.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Much easier to follow :)

Acked-by: David Rientjes <rientjes@google.com>
