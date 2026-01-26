Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0412F6910
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414732; cv=none; b=b+etgmQeMw5Vi/7ZZgiyJerBVHW0qiIAHircBky4nIV5kZgMqGLlTvDcUlqWi61Sly+C+sfnX6y98lAbBEg7g2Y4EsXOXDcxAHZ0h5QRrLzs6OdIA20q9Vuu+J0ZSJDrvOWngGFwaQF1QvjhogKliRXQynKsBE9ILJG8kVYyXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414732; c=relaxed/simple;
	bh=zMUckWgGtcirGJLEx2UUjbpZqgAfgZosdpNUcdalQWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNc8YxkK12hTu9Zic+yqoXKvUvA4XCHh2U8qWtMxPSG9QeixvyvsCRKYBweHb2Kxsh3SD5oRwf1eiE0CbhUluPzpNYY1UawR+8vEAz5/5A2dB5vagWhkR1kSqKKUV4Yn3YCuuPpJePyDC25/MqPZl45MCaC9bgcNhHnAO81vskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cwq6pbKN; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cwq6pbKN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769414729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMUckWgGtcirGJLEx2UUjbpZqgAfgZosdpNUcdalQWw=;
	b=Cwq6pbKNtfv15F/Yv3/GYVSsu+X7TYZ8ypk5rmzA0ZzytJ7IHMlEMuWrer24jYfxgpFWGA
	/wCTJvSOpSi/4TZFH0v5zJHZO9lEv6scV/Agkp5/36jFWHWZ9hsJ6i4Q2EIHQldToPYD9+
	OBNgtqpK/pTW5P35yv0JlutwU1ch3js=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: kevin.tian@intel.com
Cc: fushuai.wang@linux.dev,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	nicolinc@nvidia.com,
	robin.murphy@arm.com,
	syzbot+a0c841e02f328005bbcc@syzkaller.appspotmail.com,
	wangfushuai@baidu.com,
	will@kernel.org
Subject: Re: [PATCH] iommufd: Initialize batch->kind field in pfn_batch
Date: Mon, 26 Jan 2026 16:05:06 +0800
Message-Id: <20260126080506.83112-1-fushuai.wang@linux.dev>
In-Reply-To: <BN9PR11MB527624911E329D4B870380418C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB527624911E329D4B870380418C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> this is incorrect. 'carry' means a portion of previous batch was handed
> over to the new batch, and it already initializes the array with a valid
> item#0. So the old 'kind' type should be kept.

Yes, you are right.

> From this angle Deepanshu's patch [1] is correct.

I was not aware of Deepanshu's patch before, please ignore my patch.

---
Regards,
WANG
