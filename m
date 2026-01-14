Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A733A0EBC
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406345; cv=none; b=BmaI1DFjbScHPPDEbhQR8qrVWzGn+jkoEEAF6DXtAnwJoZxYdbEjE5m9jMc4W8uKPiQ5tNS0rFLihnmjczX+zb2xjxFxCj3C7GspDfnZA/tvhYzeZiBUzB0XwOkwWbpI3wy8lTb10GrV55EGw9rz/8bdFjSPeH8vUQIbVUdhWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406345; c=relaxed/simple;
	bh=OykPioFm2HrWkbcpe5oROzH3fK/ruH3+Fif/ozx1c34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZwTJ5FQXiZ7SnJmj78xlc77Bx8gVhmQloXygQB/gMuV+TprtAhFGYxTJRoDhPMjQj16CFu9NYuRrO7O/Y2YKWOqfIypYxFe8DyhCui+x1AqAkg1zIuJAu/wO0ct32isS4Vi2khzMOkI1g/tH8LwDjuWYrq+gOA3YtyPWw7XuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRiUte2a; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRiUte2a"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a1462573caso85475ad.0
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 07:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768406343; x=1769011143; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9h38yxI+Yu/9dFGuGUR3LKj4LUkkS33DMYVrIMJ5AZY=;
        b=bRiUte2a5Kswayfu3N0xauYYenls8m0s+pffMmkCyO3idkpamgws+F9Ydt9QH5oyGY
         mgkpKXGsol65tyrj8WS/YjLzxNiTZqH+iap7Ira+NJyeIo3jUzVbynxP953ORVD9gI4Y
         9oTyob68+PSzT7+Hn3+in50fOuAtiEITXb/rtRkx+zRmdmPXFGe6wqHUkQlfqIcwJ82H
         OpaXtKqI/Xo8tBfEJF9U1TGaMgvMuH8TUaH/FpesSrZsDgjDgIGvHgR7WIF4DhAI1Ljg
         62QVAwveh1ChzbnaAvqzu65M6eKrU3p3COlaz6mXS9OdPJrpMorC/useQNO8ka8udfsX
         IB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406343; x=1769011143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h38yxI+Yu/9dFGuGUR3LKj4LUkkS33DMYVrIMJ5AZY=;
        b=A7VIj2phVo50lx1cVLNazXMzCGMIlUn8UZFof3myxf7w87M1PuRfMH1NVTCEvm2LgI
         ZxHEFBbWEs5JEgHcOVs/daK0T3sLa0s9oScdVVhqrO/kxrb1wOMfRXBtfigfAdPUlIJN
         UdXt6ToroDTm+R/+PT3gWlTNuhonJInx6n5ko/Ua7Ce0z/LPfXck8N7F6VdVb6TJ7w2Z
         5fAb54F8L7FSPKde9Mp7mt5OBP/4v/trMIu9l0aKoYa9OW2/roj5MaQa1Je9eMzBtjH5
         Frsm2S50HkvSYkgh4PO4D+ckUBxKa7fg38w9LpXt+D3XXyaJgWY3znplERXrsuW0ABrs
         JS4w==
X-Forwarded-Encrypted: i=1; AJvYcCX/XdQQm+BTHbK5v2oXGf3D3isL0RRAwc1ua8UmL9ddssI+Mrck2X8jsoZxRfhDQjbsBjqYlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNeEzyv77Y3DOlZ9sTXR/Gqcq1MUJlMVGESTlftXpBnv/usnYe
	y3GFekiibaAqh0dhYsyW0EwHEfX8rTOoP1Ng9CVxl+KTCq2yvvObDkhST8QAeufrCA==
X-Gm-Gg: AY/fxX7TfHAbFUBMatL8A4l5Fht7Z2Dpp0bBmdGauo7CyNg9cZIZrdjh9FDRAcrt2hz
	WoEbmTn5Ow0oxWAe935LE80k6kiabBf9TjF6qv4MTJSDfHArDQgSG31sQQhD1akjy1D8bAKVGHV
	qT1tZ3rqVSBhmeW735XM/hzcNZRVHJudwu5WVk2qfFexUTFlakdMXCvbDMYM25IemOMtJcIlQNv
	fo12zBb6MWS53W7/906hFtyz0SZ4Z04LvKSO54mo36nfe6/IWjf0W8eP7BnzDaQ+R6bIxkfgc7s
	2MRym8L3OqYI+ZSoutBwQsCA99moEsSOPfAmYvtQNLomV6/HdwCLK66i0qVigPM/N13L2eMlQmn
	AqBG5rysV0+XU+oQx8CCzhU7QPLMpJ8rftNkHzReX/5nWo3SvQHSbCxeExHbYPPLe3ApfIvD6ji
	Dzb8nEzMXV02+vs8e13p30wmgpEfwXPdUjdEBqAqKViUilG43G
X-Received: by 2002:a17:903:37c5:b0:29f:20b:6d1e with SMTP id d9443c01a7336-2a59a91a40emr2491455ad.9.1768406342960;
        Wed, 14 Jan 2026 07:59:02 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e4e3efcsm19748b3a.20.2026.01.14.07.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:59:02 -0800 (PST)
Date: Wed, 14 Jan 2026 15:58:56 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jgg@nvidia.com, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v6 4/4] iommu/arm-smmu-v3-test: Add nested
 s1bypass/s1dssbypass coverage
Message-ID: <aWe9QI0ZoqjFCjSd@google.com>
References: <cover.1768248467.git.nicolinc@nvidia.com>
 <a72a60a36c9831bd91f369de5af0ccd96d180dbf.1768248467.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a72a60a36c9831bd91f369de5af0ccd96d180dbf.1768248467.git.nicolinc@nvidia.com>

On Mon, Jan 12, 2026 at 12:20:17PM -0800, Nicolin Chen wrote:
> STE in a nested case requires both S1 and S2 fields. And this makes the use
> case different from the existing one.
> 
> Add coverage for previously failed cases shifting between S2-only and S1+S2
> STEs.
> 
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

