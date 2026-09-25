Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56724FB9D8
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375263; cv=none; b=ppeY9cSAyyUFLMwkTtn1erSkJZ96/yjoyZJ+gJuD3daGPAo+OHWyHbq13qWUQvP6zSyuYDq/cF5C418RJ6KRyA6YBqoITB870AgBesqcawbNBu/9+bn0mbZQwrW4+TtAK9SZQWYO9rKh9PbT6NDo7SPYqoDrbPYz2ZgVL5xViUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375263; c=relaxed/simple;
	bh=eqrGq9U7VRoYaZqERBwu6fkmIt7Dpd2MB+CWCce54G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq3qp1vOBMAtEAma58sgPrFue8ZtRK4Rxj46Emvp4y+yER3Zk8VikRQY9z9SoeR4D0w1fDqXPYQ2pvl9aolEWZMwLasoZWTrJwIpAPlFgAdAnrXG3QOET33oR0m3S+imitefQ4vQm7jQhJPtvPLyxpQZDtq3w1tDLReLin1fP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptvqtVsJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptvqtVsJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so11755ad.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790375261; x=1790980061; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eqrGq9U7VRoYaZqERBwu6fkmIt7Dpd2MB+CWCce54G0=;
        b=ptvqtVsJgc5zIy2LkMlsfMy/fFHODvtx1HpkiZwKCZ3yUsDBnmqVv3chewTHCpaIp/
         JnIzJ1512XaniEluCecXuRiHEN+hhMbp/mK8LpsWPUMXoOcuoFi4nBWVJX/aLz3uoBCH
         2lq1RAZSGMKWUIWmzUrq7l7Dth0RXuiFh4RYWcdC2J0ZuVvXEeIVFbD5D3Kb4aHlJJol
         kTpKr+6ezlygfGqDiJvw/wawT0HxATUIaBmcAQQ6iMS8QyWheKhONeiFiEIeAOJGFB4U
         AFRSVs5bB3IyW9NgHpDkPXg61wDEry13qSOnWRP5bKKAhuRmD7ocS1L+bLyuIIY/aisc
         KyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790375261; x=1790980061;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eqrGq9U7VRoYaZqERBwu6fkmIt7Dpd2MB+CWCce54G0=;
        b=Ag5l5z1JDazoUIDrdwoMcuMgHqxpQeLACDcq1yPNMRFt3Wf5XwNhl2aazxkHXy22Py
         z49iydI4XAY6jg02bxVx6l7ZAEHhlxIvTuC2ctVolidTuKg17Wcqme0cVqtaiZ8pKLsA
         WTGn07e9ZcOJ7Acy5xeFu7U6uApLLxQJtbwVIf7qSoaZ+nvkmz5ozUWTK7E5Smpk+Lcs
         8cnWXwqZmUS/H27OKB7elogtEBANB9VljHx0HlmmXgLEMz0mCaVlncVB9JBYni/USEve
         xH0ATcFJLpJF/QvnA8pLx0oiAlTC9tQUfRxaLcjUnBu5zvSe7qhHt4iEW3nieam/NWpb
         FOPA==
X-Forwarded-Encrypted: i=1; AKwUvBz1rDgls3cCSM62yFGqT0Fz8zYn6i1gh98QmbEj9eS2lVvES7dKON0hAzmzoMcgcNz10sXOxg==@lists.linux.dev
X-Gm-Message-State: AFuF++ltixCo9xfwwS9KSbbbhCiP1zJCie/EK0n8M/7kO7evUkgAG357
	OAfswMBw5Xzn3aJZojbadhR/S9HJc14fhPaK810SeCgrlgEab/EiBlDjC8zjorrZqg==
X-Gm-Gg: AYBFou1QyAHjjuEiWE4T+evuCqh8Z/tl+EOR8zYW9tMk1Nu00SdQX/6680+oNjmDys+
	3faF5QbDBfSr5YzqM46UGc1hUZPf4lFAbx/fsYwREo4hgOWCtVSvsooeHeGpJRKnr59escJPjB6
	HYhrDqsc/rMGmZtqFiBQNkKQVedzmNqNtuHYh9nVJ2wy4thVxvEuXLFdhQ+XmrTWlvsAyaoxNaz
	XErhqcEVd22X4B8VuOQsqHqiFNdW+hVl8Twu3aGXwgnTbyj4+yysWlxvrQccf4mu42HE48Nxtzh
	PurbMKhfKwxfoCJ5NXTx+SLtJbPZ+Uf+83fVnz0e/W9swnQPPFZUn23Tdgjvuvmw6jvyknQdJr/
	KN//MbCNye7VRAoN6m0LX/RvMkh1MtpuTw2w4UKJ3CyZnP1b2IgnPSVjqJrd8vAviCxswbEkBPw
	u8fqYTtmr+7dQnFju6Jlx72cuU5eCPT2WVofdMh/g1W7X8PLINOxcLTnaLTXrGQtSALPWqxzxxi
	m83x85dbURSZhMcqS8HUADDuXPd6mMuYsxzQ7KMv9zoYWHErm5I9sE7Ull5AsOkQxItXg==
X-Received: by 2002:a17:903:46c6:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2dfa968787fmr828795ad.1.1790375260342;
        Fri, 25 Sep 2026 15:27:40 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bda430b3sm5720254a91.0.2026.09.25.15.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 15:27:39 -0700 (PDT)
Date: Fri, 25 Sep 2026 22:27:35 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH 0/3] iommu/arm-smmu-v3: Add support for hitless
 replace of CD entries
Message-ID: <arb0EZ7mPWUfhy9K@google.com>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <arbrJYsILS1IPpCK@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <arbrJYsILS1IPpCK@google.com>

On Fri, Sep 25, 2026 at 09:44:05PM +0000, David Matlack wrote:
>On 2026-09-25 01:13 AM, Samiullah Khawaja wrote:
>> This patch series adds support for replacing IOMMU domains with S1 page
>> tables hitlessly, that is without disrupting the ongoing DMAs. This is
>> one of the dependencies of the Liveupdate IOMMU support for Arm SMMUv3.
>>
>> S1 domains are programmed by CD entries in the CD table. During a new
>> domain attach these are updated using arm_smmu_write_cd_entry(). Since
>> ASID and TTB0 are in different 64-bit words, arm_smmu_write_cd_entry()
>> considers it a non-hitless update and sets V=0. This means such an
>> update is disruptive and would generate translation faults if there are
>> ongoing DMAs.
>>
>> Replace the CD entries by using an unused temporary ASID in the
>> following sequence to allow hitless replacement of CD entry,
>>
>> - Update the CD entry with temporary ASID.
>> - Update the CD entry with the target TTB0.
>> - Invalidate the temporary ASID.
>> - Update the CD entry with target ASID.
>> - Invalidate and release the temporary ASID.
>>
>> The series adds a vfio selftest that triggers a continuous DMA and does
>> the hwpt replace while the DMA is ongoing. Since domain replacement is a
>> race with the translation requests, the test does it multiple times to
>> capture the small window where IOMMU faults can occur.
>>
>> Without this change we can observe the SMMU faults in the kernel logs
>> and with it the SMMU faults do not occur.
>>
>> This is only tested on qemu with the emulated SMMUv3 and an out of tree
>> NVMe vfio selftest driver, not on real hardware. Following are not
>> covered and can be done later,
>
>Out of curiousity, does the in-tree VFIO selftests driver for IGB not
>work for this testing scenario?

I tried with the IGB driver first, but I couldn't get the DMAs to work.
Its probably my setup, will recheck.

Sami
