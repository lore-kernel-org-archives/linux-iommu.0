Received: from va-2-58.ptr.blmpb.com (va-2-58.ptr.blmpb.com [209.127.231.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C8211466
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785122542; cv=none; b=GEwR9gwl/hzCIATScUbGkvKaUoAcb++/w4vLjDtWMaUTp4R8f5kH5UT7B4A7WDgcqVTXk+D06bpKhPsyr/Wcn+HiUYBZxw1CRHx86X+vjPW6u9Pb/RPqO+5GYChNPAhnTtzcOd+2LA/YQXcLF18oZumd6ByHUt6CH9eFdtZjWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785122542; c=relaxed/simple;
	bh=X8s9Mvf+ZvdPQ+lHl9f5VgjmWxvXtAWDQMTe5fx7U+E=;
	h=Subject:Message-Id:Mime-Version:Content-Type:From:Date:
	 In-Reply-To:To:References:Cc; b=ChCsmeSQMC7gvZP8ZYi4Khx5vj50SbxtgeKj9wLcj+gvpB9UBm2TxlfaIQaAGBWOkNnXtWrhti0gYv2Y6JIjdIi9b17TVVTYlSZ6wVuzzJch7KCYImUBqSnM/SUe3JVlOdiUKaaILLMLytVCLD8EWuc1F7gGXWIf0G1f7N0cqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=OQAzmGHO; arc=none smtp.client-ip=209.127.231.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="OQAzmGHO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1785122528;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=t/z/pxfR5KleXe1fUrVt/D1onEzd18y4VdvHLYUNNC4=;
 b=OQAzmGHOpemguEEkngLzr4v2wf49L8zfkzQWZLzzGkMFPQqyoJBF0FpuGIj9dbCVDq5Uhk
 01pEuulfHU/UangoKlVrq8wS6BpMLdRjbM4xjKrZ5rzQgE7VLRqR2Lqgr1pu6U+43TRQVS
 ERekJUE2M5wBqi46OqUnY3fZSpgBfTE6eDSpYDnfXrCs9Xsy5XYNqsWipZhzhM+teAHI4S
 28PPoyohNnY+0rR8Q6p+ZJQFqXSHSPrFYRf+16+qlbQjqgWcToeoX91l0FXQzgdC6CntB/
 kKF/FdDzTJxl/LHyWMkAsuDAQJKkjnVnTaM3FmBfeGxWdilCYv32GuRiH/qPtg==
Subject: Re: [PATCH v3] iommu/vt-d: Disable IOMMU by default on Lenovo ThinkPad P50s
Message-Id: <19be3c19-9711-4cac-bc6e-c2b020588ec8@liuxiaozhen.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Date: Mon, 27 Jul 2026 11:21:56 +0800
In-Reply-To: <CO1PR11MB48354FC225C295EFC745EEF48CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
Received: from [172.16.0.2] ([104.28.165.131]) by smtp.feishu.cn with ESMTPS; Mon, 27 Jul 2026 11:22:05 +0800
To: "Tian,  Kevin" <kevin.tian@intel.com>, 
	"Baolu Lu" <baolu.lu@linux.intel.com>
References: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com> <20260703092348.17583-1-oliver@liuxiaozhen.dev> <775d3d16-f43d-4a5f-9629-4912a4cabd91@linux.intel.com> <0c9256b0-19ad-4d1d-baea-0ccd3b827d0f@liuxiaozhen.dev> <CO1PR11MB48354FC225C295EFC745EEF48CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
X-Lms-Return-Path: <lba+26a66cede+483d34+lists.linux.dev+oliver@liuxiaozhen.dev>
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"joro@8bytes.org" <joro@8bytes.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"will@kernel.org" <will@kernel.org>

On 27/7/2026 09:31, Tian, Kevin wrote:
> This needs an official erratum disclosure from the vendor...
Thanks for the clarification.

Could you please advise whether this issue should be treated as an Intel 
VT-d erratum or a Lenovo firmware issue?

The symptom is:
- ThinkPad P50s with VT-d enabled cannot fully power off.
- Adding intel_iommu=off resolves the issue.
- The issue is reproducible on this platform.

If Intel erratum is not applicable, would a Lenovo firmware confirmation 
be sufficient for adding a platform quirk?
