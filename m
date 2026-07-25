Received: from va-2-16.ptr.blmpb.com (va-2-16.ptr.blmpb.com [209.127.231.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2E387369
	for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784947516; cv=none; b=Rt4/qHRTokygDH+Dc9NdMd0++4NvZ15vLLD/6VYxCkhv9rUPd4IV2jqeYOFfCgsxfX/GVd34tx9BMIIf7C457qZ2x+3vJW+SJawAACjyUdlGlJeuEKySpDtPNegxf8jEc9juqGMS7i8X0nJ/cZQUjugCeRn39zyPqDdVjX7g0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784947516; c=relaxed/simple;
	bh=RKokfwrCMvEWzzUNkYeiib5xPiE4ygIwDXSNCzA7EPs=;
	h=From:To:Cc:Date:Content-Type:References:In-Reply-To:Subject:
	 Message-Id:Mime-Version; b=XD3826lIltAtDcf08fF8h+aT4dLr4lTVYzX6lqgiMGzfuEL9GO/uGGhYKXqVSjUQV9p67NqZOuCmutGws2JALXXJv0zpw0cSMgUfMX4C50/2ZerU/nHbXqoRcFLmfJs3dqku650Q/10cbhG1FY1AFqdo8pavJD0EEGhK4S4HlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=i9LKjGea; arc=none smtp.client-ip=209.127.231.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="i9LKjGea"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1784947496;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=RKokfwrCMvEWzzUNkYeiib5xPiE4ygIwDXSNCzA7EPs=;
 b=i9LKjGea76gbN9K2rgFdyYpUJMX9Xj81qRVnO64gn1vcH214hmRkqy5cdch23jAHrTMpXG
 8+cbFKHZs2PlZ5Mi7s7wgN4ZYIAmN6OIF7VgjKqa9tI9T5sPm2jcNCyEjpAVdn2GsOD2Le
 RDy0DJrhUc3W23f5ArS2znM0DPI4/lMz4E9Iqf+qSAiW88dg74ohfzKfV5jD6IQs9VmiEq
 fytpNTZCMxdI23fBIBU4OXHfPzaN0ATDucZ9AKT0ieF17bgnNXP022kpHnwMOtYsBkzhyi
 WDZfCAO48Ia0O5fMDcsgLWjkC4nvwyYthSARNd9V7Cmtscy1J38YARyGanVyFQ==
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: "Baolu Lu" <baolu.lu@linux.intel.com>
Cc: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	<joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>, 
	<oliver@liuxiaozhen.dev>
Date: Sat, 25 Jul 2026 10:44:46 +0800
Content-Type: text/plain; charset=UTF-8
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
References: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com> <20260703092348.17583-1-oliver@liuxiaozhen.dev> <775d3d16-f43d-4a5f-9629-4912a4cabd91@linux.intel.com> <0c9256b0-19ad-4d1d-baea-0ccd3b827d0f@liuxiaozhen.dev>
Received: from [172.16.0.2] ([104.28.158.228]) by smtp.feishu.cn with ESMTPS; Sat, 25 Jul 2026 10:44:54 +0800
User-Agent: Mozilla Thunderbird
In-Reply-To: <0c9256b0-19ad-4d1d-baea-0ccd3b827d0f@liuxiaozhen.dev>
Subject: Re: [PATCH v3] iommu/vt-d: Disable IOMMU by default on Lenovo ThinkPad P50s
Message-Id: <ecec6b5c-f143-4fc8-92a4-a07f3388edd6@liuxiaozhen.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a642326+074ac8+lists.linux.dev+oliver@liuxiaozhen.dev>

Hi Baolu,

Just following up on this patch.

I was wondering if there are any further concerns about the approach,
or if additional testing/logs from other ThinkPad P50s systems would help
evaluate whether a DMI quirk is appropriate.

Thanks,
Oliver
