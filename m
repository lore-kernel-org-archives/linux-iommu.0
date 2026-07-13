Received: from va-2-43.ptr.blmpb.com (va-2-43.ptr.blmpb.com [209.127.231.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37709265620
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909674; cv=none; b=BH2V4od8Qn3dteEa4SaI8Jrak3AIROkc5sLjW0jrh8oLpWVW5j9amhoxkQh4RyKhAT4un4aiIPUC+OvRoXLvIqBYgRr6itZefTGCj+DgDFw4K5Mh5ye+m7toCRBrOA81p1hv+63mCDA6AsvHAY+MxcqgoDYFoPZEYTXhLUUBLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909674; c=relaxed/simple;
	bh=Ed1hFzuiafOlePmuHhy+YpqujTuQb45E2mGbVA8RRK4=;
	h=Message-Id:References:Subject:In-Reply-To:Date:Mime-Version:
	 Content-Type:To:From:Cc; b=i6gfLzs9I/71t7dkOk6lC5F2EXrii87n2e+rrCbRk2ys0t20OhQA5SULEdoEd8wOuvG3URz3PxJD/aHUv6hrG7rKyygxBQ5JSCWvH03NurzzGsXJBPAARFLOK/sRg/XjGkIXn9htj6vUdAUMk6t83tLH4fQ8++F7v4fGa4Al2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=JCa/zNO6; arc=none smtp.client-ip=209.127.231.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="JCa/zNO6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1783909660;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Ed1hFzuiafOlePmuHhy+YpqujTuQb45E2mGbVA8RRK4=;
 b=JCa/zNO6jJy13PrjQXrbi5cvrlHS2LgQ1pn8QMXnR8q6zQ+9u4kqXr468+suodE4MP3+1g
 nyL2c48DDHvJqARJAVXy4RsI+mN+DFiD06BpItekU19+51ut4Ew4mjSZwKiBSF7jkTmxnQ
 7yLX/Ve8fSiFM8bcLvV/7UymLXc9qCQyweB5Q8994vRe6hd/bsGs4W/hqMWlTUqPBJ56jp
 I/4/D8ZQBWBRmALjY7gVmaJ0VMhoJxhc8U5rkOuxEz/P9V1lafwwSl66QAIfVZ+CQxLtgc
 cCcbiIANVNWG+VdxIJWclWnOSqgPP/1A0rFC6nZ66Wxd6FirTTijoRCYcGUb3Q==
Message-Id: <0c9256b0-19ad-4d1d-baea-0ccd3b827d0f@liuxiaozhen.dev>
References: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com> <20260703092348.17583-1-oliver@liuxiaozhen.dev> <775d3d16-f43d-4a5f-9629-4912a4cabd91@linux.intel.com>
Subject: Re: [PATCH v3] iommu/vt-d: Disable IOMMU by default on Lenovo ThinkPad P50s
In-Reply-To: <775d3d16-f43d-4a5f-9629-4912a4cabd91@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:27:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Received: from [192.168.3.207] ([120.231.246.10]) by smtp.feishu.cn with ESMTPS; Mon, 13 Jul 2026 10:27:37 +0800
Content-Language: en-US
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
To: "Baolu Lu" <baolu.lu@linux.intel.com>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
X-Lms-Return-Path: <lba+26a544d1a+55e1dc+lists.linux.dev+oliver@liuxiaozhen.dev>
Cc: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	<joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>

On 13/7/2026 09:55, Baolu Lu=C2=A0wrote:
 >Why not fix the firmware issue instead?

 >So the driver already provides a command-line workaround for this

 > firmware issue, right? Why is a hardcoded kernel quirk necessary here?


Thanks for the review.

The machine is already running the latest available Lenovo BIOS, version=20
1.45. I am not aware of any newer firmware update that fixes the issue,=20
and the ThinkPad P50s is no longer receiving firmware updates from Lenovo.

Yes, intel_iommu=3Doff provides a working command-line workaround. With=20
VT-d enabled, however, the issue occurs during a normal default boot and=20
causes several unrelated failures: DMAR faults are reported, tpm_crb=20
times out during initialization, and shutdown and suspend/resume are=20
unreliable. Adding intel_iommu=3Doff consistently avoids all of these=20
failures.

My reason for proposing a DMI quirk was that users installing a current=20
kernel on this platform would otherwise encounter a partially unusable=20
system without knowing that the failures are caused by VT-d or that=20
intel_iommu=3Doff is required.

That said, I understand the concern about disabling IOMMU functionality=20
based on a single platform report. At the moment, my testing is limited=20
to one ThinkPad P50s. I can provide the full DMAR, TPM, shutdown, and=20
resume logs for both configurations, and I can also look for reports or=20
testing from additional P50s systems before pursuing the quirk further.

Would additional reproductions from other P50s machines be required=20
before a DMI quirk could be considered, or would you prefer that this=20
remain a documented command-line workaround?

Thanks,
Oliver
