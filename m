Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6A3ED5A3
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251996; cv=none; b=h52Iq+aqq+E4e4bz9fzSnjIcwN5HB9cJ9V0VwtMLdQhfvCy4wPUyb8y8ynXlsVpARI6XvUGI6Lmv1Z9RaZf6zG1kgVK2iKhtwfbABt9WxXXfBY+KD61r4Y82gKPSeh/c6dsZ2+qaFwo8B9TNPm0+TLhyYeZjj64F0biWHff/3WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251996; c=relaxed/simple;
	bh=keOZjFbD7XSeQ5DRxiwp6bDt30m5IxxmZ/NS6BOpi3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bplZRLwVQXIXF1tlaXYHCumcbK5OC9WjyMgPvvaI+3nE/ZMFEX8b2PCrS8ITkgAUqkTUCMjZopPiHfl76inUCGkQhAjx6WgbtQXdV8Kk85I4snpNyTnUd9+C6Fup//3GJ0Rkc8pjOemIaHiHOXxraS0rZDf9rzMosME+kHeA3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VESi8HwG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VESi8HwG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba180a022dso95305ad.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778251994; x=1778856794; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XktoxOSdy+7UpPmhAwTtEdQpOxHTuyByFDWP5fxlwiA=;
        b=VESi8HwGf2NZbn1mz37sJMx3xa3WFooFlgBJTL6g3ksLn2aJxCkh4wzShoqBs+s7jI
         go3adfo8Q2k6W9+7b5wyuH9yi/Id4fFnkKhcK6jiSexFyCaDir7/T59yLfm855vMUIrq
         ce+gZdiz/TNj72KwZgQm71BEG0DmiYxKgv1irrzH55qJIeynCx0rrGK9zzURRup0Nfyn
         U8kmUp6E79v5/yoNTs4kYY28BRQMVYf+lFUQtWTA95A7HOaNHN16LmtUwBh30QwV0VTN
         nI6WYJoD6K/04QwqC0IqlaBb9qqM6s+d/t8ZYuOy2kIqT4bH0VsBH3DP2O8EBTTlPmAN
         z/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778251994; x=1778856794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XktoxOSdy+7UpPmhAwTtEdQpOxHTuyByFDWP5fxlwiA=;
        b=FC73qN4POnXrQdKbRvgKwxqY5LBGQeZFScd1mkqA8e1GjQ3/mhsQmolZ4O45YNJs21
         4vUY5B5xE6ihitG070E+5F99MwtruO6PDnJoJLSRwIg56LeWJGopixhdDAm6fOSMJUL6
         ypbsFV3HoCdYIfYu44zEzXcmBG4HPDuZl2YUzcQYI7PUNUQBBQfVpJOZX9/RMVmswPmU
         zGzYsmK7Fj6UVTSdWvqNS/86sQZE/44SjfOk6CsXtPT7A5F/jm94XbuXMp5E4WmDVRzk
         bhfT9SEp8SvBquBXCwrXpCstvyTQaOu3/cBA2XHssl7r5o8n1Vm/UU0GOA1n7S8u2bpA
         +9OQ==
X-Forwarded-Encrypted: i=1; AFNElJ+chmmtInurq2mUItOqg0fRtNk2uXjmfdSE4iCusM1Q9R6WsqMW3b8U+xwl98DS9nfXAvhdwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYDRTVLua9kzOfNltj4dtyAYcZHs85WlmFfOzKb4Dv4ER+2SVh
	Uwqj7mytfnvyrBYd8oVc3H6KxD9IbSEOHgip+8qbJ7904SN3pNpje8lbUWxT5tS1sw==
X-Gm-Gg: Acq92OHgN3akLq9dc+3HVI9FVtXZ43wxFOJsh18COaIzKKd9jd/x09Ocv6a4LmmutHh
	03wg42zIMZzQBflsaTWE4mAND8WiST77HJTEzcLM7cB86xdUZE8a5eB/e54fGzBp2wXZ0xibjqW
	4jEKEdD7qBgdSXuDJRwKCMK926SrsqVrgPm6guWcqP/NJwIjjXP0PbKUSJmm7+ynFfBu4b1FYi+
	vn3ffOoumvZt9VUy64JMsGgqzOSbZ8pLS7uMNzrd3lLyRAxmAsrzJuwCJ77PkFs152Q159FjysK
	LLvf1bIu1C2EjQm2TEasQ9TKiy8K4xJkzgE9v/O1yqdSJObx7PdJXpvAXXfIyG7xQZswnuxV01r
	SaLITAw/Gt84Cq2ywIk5TyYDHDr7IWJtW7/YKS21D6tj8Wa+WQ2qljTs9bpB42lVoPSZ5hXn1t6
	4OhnHjM4QZTNezlBqveEhT7j405wgC7Mn0HudEl0E8UukKYsCpp1AGd6ZUmapYYxsYW5ArEC+/R
	Wvmdu0=
X-Received: by 2002:a17:903:247:b0:2b0:7a9b:82f3 with SMTP id d9443c01a7336-2bae9ab01fcmr3296545ad.8.1778251993701;
        Fri, 08 May 2026 07:53:13 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367c2ccfbeasm8405a91.13.2026.05.08.07.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:53:13 -0700 (PDT)
Date: Fri, 8 May 2026 14:53:06 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leo Jiang <leo.jiang1224@foxmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Stop queue allocation retry at
 PAGE_SIZE
Message-ID: <af340uhd40FLTaEO@google.com>
References: <tencent_F6E384A40D990A279B460A0CDE1927FDF509@qq.com>
 <0fdf4b1f-90f2-4f69-9d2b-dc5f608e9c1c@arm.com>
 <aeeoEHHNKPo32H9R@willie-the-truck>
 <tencent_DA99B62735469A0CD219E9FC73E234A47309@qq.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DA99B62735469A0CD219E9FC73E234A47309@qq.com>

On Wed, Apr 22, 2026 at 05:13:08PM +0800, Leo Jiang wrote:
> Hi Will, Robin,
> 
> Thank you both for the detailed feedback.
> 
> Robin, you are absolutely correct. After a deeper look into the source code,
> I see that allocations smaller than a page are indeed possible in certain
> cases. My previous assumption about the DMA API's granularity was wrong,
> and I appreciate the correction.
> 
> However, as Will noted that the current logic deviates from the original
> intent, I have prepared a v2 to limit the queue allocation retry boundary
> to PAGE_SIZE.
> 
> In v2, I have:
>  - Updated my identity to Leo Jiang.
>  - Removed the code comments as suggested.
> 
> I will send the v2 as a follow-up shortly.

Hi Leo,

The general guidance is to send the v2 as a fresh email so that it
doesn't drop off the commmunity's radar.

Thanks,
Praan

