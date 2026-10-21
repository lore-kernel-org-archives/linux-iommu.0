Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547153;
	b=LKuCh5dLIXUkEVQ0Z3uIbuaTvJHlurfBY6Yf86zSB3Ec/ocis89khmbQx5volyd7zAIb
	 Td+0VKq2054zkUe60U2SQXw8Nl87EddOkEIwvpiOz7AsdhXKjxhGRuNp+pfn97jBbcNXh
	 RUn5CHYrnWKe0g7lwxBf1poEAIRYxB/Ju9jFuz2L1i82YiAmbo1CyC2POvY2rDhUxtaNu
	 V1MEbpfUSmyLMwLEpQXCnonWkPyJm3KJPNtT9QbYSryOMukfAGiY9dP9DmL2h6QKKYq7L
	 22GBHmoGE+VkOmG4J1wVThKx51rmgzs7UTb92zuFa9IVypnRmAFQqU8PtYkoNoJK4EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=N685GSgBsocOGOaVWgwO0dJAiPky3e+vK7Q06g1oPm0=;
	b=JLSqkOS6i3o/JqrV/y1/B7o2oXkl4fMtMpIeo8C74HfaxzXLu+Kd28g7eE71PduzKfAs
	 Fzg9Ud81PIcmj7FFaX/D2h6osJ1hqbAR0Kcw/mYbh/rGykn8KsITem+eTtKnyNsv0YWzs
	 u3z2PBuiuAc0Xbi1NM9532cf1Oap2tg1hhZYKGX24gffPtxm1lkk7OYiRb6Z/KjXv8bah
	 xmGvvjYaYRjeaBio0YprRNnAMQXwicqjon1B1hwESykeKJXH6SvK15aYP376NvSB2kQge
	 Os/VqkYm8PTKgMoTsGUIv6lVU5FhTeWVLOrFFhB/tXWNr4NKTzAgZlp0kHnsvvEQH0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I5R7u1iH;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A2606A31C
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 01:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C17A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I5R7u1iH
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so853015e9.2
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 18:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792547151; x=1793151951; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N685GSgBsocOGOaVWgwO0dJAiPky3e+vK7Q06g1oPm0=;
        b=I5R7u1iHdZjpjRIxTK8HD1dhPUTwWEHFoYr1Ut2NZIlANRt+lBIjBtmUWngVyQMadG
         3FJuEUftBo61LUmP5V+WNe7iwjjUa42rek+wcNJt3d3ucqPi/5OdqzaPFPhzKnunVa9V
         nMCyLDXkP3OGd6ihnSB8P8m6KzNyy7uSnhqMmv3XetMIvfY+xLad3KJ3ehkEon+mE9/H
         6vBCmj+AxcRTKVx1JY/Wzu576BcdNRfFWqjqt4qFQWJ4SJz/mvSsWztJkjxnsWdto8FS
         4RCzW3NaCK9FCLPttuHMg7vCfkDw+MwL31lZX8VF9xeIWmY51EN2nEcYsjkTyeuxYyn7
         2buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792547151; x=1793151951;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N685GSgBsocOGOaVWgwO0dJAiPky3e+vK7Q06g1oPm0=;
        b=okIdAeCUF/HCbxWyXsSXP6tN6Vev7AUNzJ0IvDmAt2kqosQFP5JTNicY6rWiZTWmQc
         CIXCBrKYSBPRK8VJdCrzXHV6p3xduYQ+1oM6/FR58dqn/XmwdJALqiMRLylQ0WYJWJjc
         //yU1DRm7tRV9nppcoaks33/WzZN7LMydV86/dj+RqmEcg6f+0NTri4e8vnxFMeMhub9
         hkofjqjEplOoNoXIiaw0s0sVepdtNeifMz5SlPVIfXpJpT78DBH/0O3/JcYnahNG6nQI
         No+HlNq2FbEI2G1+h/58Hg1Sp+KloyAjBwVOrr0EhMsymCKxn2bOUK0bVXTvGM16Ebaq
         /OHg==
X-Forwarded-Encrypted: i=1; AKwUvBwF7ABLBN+J8t+GwGOYdPW1o1jDI0CIpGyLg/qOqvJs56uajgFHxaCgI2KhGpURD7flMIa0tA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLxngy3uLhT7QSn6pdidEhgLh8zQvfZ30qrTj2cHG2MGGCKVRPK
	8sy8F3lHbv9AERWR2ev3EMfETs7WkPbZTImupOdOJ2Uq8HfWGsttsj79
X-Gm-Gg: AYBFou2pSa4qZTwDWtc7XQIovV00lMjts0G7tLs/sLZky4gtYkBk+ZBeJ3sqyyIRI/o
	1TKbKPy2ZLdFYSOlQNIzewlzLoZKUqdCcphU1aUQbS1r014syMAs3xK3Qp6Dm5DEu3UjXYIz5cV
	v13M2GdgnL8zHdPk9cZDPzaY/Nm288KaG1gVoohrjTlshyTvUWbOXLQpOfbWR2/C7exAkz4A1ce
	HMRFHcwPQwRbxtvaw7gKIUlCsl//RhFjzH5STaMX0rHj0XgJGhOunRNMzJ9wem/GG5JOCW/gvgw
	9drCZNxdoae15btGY+gtTtk9HqbKOSiTyW2EaqmovvheiRbxq/+2TMGb1pT9rBk2odmtTDGi5eU
	3La9crpO+eDmcZBxr2IvF5KbZqDkAuXj5XUhpSN5RZi1ssXC0O02xiHLjcK+3jYBF+oHvpgPvwb
	1a5PpBWM5UCW/qqfJrOQX3GvgqR71T+j+Wr3HTbNXrKqiDTx9Qvix9WSZnAnW+tgvRLXeBs6wVI
	2t16d+/rTOFn2bxSZ8nxguy0l0f52BR2tGO5+kC6bWl/LTgctaHlzu+gBTTpikRSz+QDwRmoPV7
	RlBo3KFVkAn2Vp9pykYDXny0ef6gPWrEfXFFuE3Nld72rOZlHsQ7NZar78XXq5L09ykQitSo/no
	Qj/ZA5lzz5arjiiE=
X-Received: by 2002:a05:600c:8714:b0:4a1:d97e:cd60 with SMTP id 5b1f17b1804b1-4a1fdd1604fmr8629335e9.16.1792547150977;
        Tue, 20 Oct 2026 18:45:50 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-095-117-105-001.95.117.pool.telefonica.de. [95.117.105.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ca3666sm118638605e9.1.2026.10.20.18.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:45:50 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:45:14 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, 
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC PATCH 0/6] iommufd: harden DMA-BUF PAL setup and release
Message-ID: <atgWXLYKOFj5cZ0F@gmail.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
 <atdKZpEJVZY0enR2@nvdebian.thelocal>
 <20261020182029.GH3008132@nvidia.com>
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
In-Reply-To: <20261020182029.GH3008132@nvidia.com>

On Tue, Oct 20, 2026 at 03:20:29PM +0100, Jason Gunthorpe wrote:
> On Tue, Oct 20, 2026 at 10:16:26PM +1100, Alistair Popple wrote:
> 
> > I haven't had a chance to look at these patches yet, but if some of them are
> > fixing bugs in Jason's series it might be best for us to fold them into that
> > series, with correct attribution of course. Anyway I will take a closer look in
> > the morning.
> 
> Are any fixing bugs in tree right now? I think one of them is already
> applied from someone else..
> 

Good catch. None of these fixes a bug in the current mainline tree. I
based the series on the stale c37cf2824740d topic and missed two fixes
that landed in mainline afterward:

- patch 4 is already covered more broadly by f2d70dbd3dce
  ("iommufd: Destroy the pages content after detaching from dmabuf");
- patch 5 duplicates Ankit Soni's e745cd2c749e
  ("iommufd: Take dma_resv lock before dma_buf_unpin() in release path").

Patches 1-3 address lifecycle issues introduced by the PAL conversion,
and patch 6 tests those paths.

My main goal with this RFC was to put the concrete lifecycle issues and
tests on the table and get the discussion moving.

I am not concerned about preserving these as separate commits for
attribution purposes. Please fold or rework any useful pieces into the
mapping-type series as makes sense.

Thanks,
Karl
