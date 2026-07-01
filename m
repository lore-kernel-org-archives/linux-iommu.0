Received: from va-2-20.ptr.blmpb.com (va-2-20.ptr.blmpb.com [209.127.231.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C437D133
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925451; cv=none; b=Dy9pu14p9UybRWgyfDVrfBeH5kXgafn8buU7r3hTN7ybKn+95KBX6+vlLXnrleU4uM8vvljG3s/LLhhaDfKkIXS10KA1ZkDMJiMQrUiu6OcxQUWyX4lqXeY6M/rYNr257MyTkGR+jk+9cJj67AsmyLtHRudU8Vp2F2Q43B0E62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925451; c=relaxed/simple;
	bh=Daj0dbkaos4Wz91jBB5kK1s7GaOi0AqoCpMkmzvBtGU=;
	h=To:Subject:Mime-Version:Message-Id:From:Date:In-Reply-To:
	 Content-Type:Cc:References; b=ScY02OIEga7SudRPJUwTbEYyHbsBncxMVGWodwbsv8T45ng5y3Mm//NinkbQs4fYbMCXUDAIUrTxUZ4fSjrFjBGMIHPH80WKJZhx3xIPGjHtW8Qv32WLMwJASUbNFdnHE7lAz6wdGEJdud8tGy/FA+ez49Z873JLje+5Z7kSkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=HbSAhLzY; arc=none smtp.client-ip=209.127.231.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="HbSAhLzY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1782925438;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=7BVMB9YIQkUZy14lWL5C/6fmBKrZtOxqjkLTfJ35tSQ=;
 b=HbSAhLzYOXjgn+MAXVipQzlU1SbhM1l6zmOkrKViuvmU9Dkkj6/DowDDO6UP49htOX/BKi
 iJmw4uxgeFlaWhNQQo5i/PMymf7DqUHT3I750OEgF5lUEat1Bq3PTC6F0BVxxIeVY5qIR8
 tNL5KRysFuKmGl+Myk4OzoIRqyYeFWB0zc/XbKDPr+xM5sxr6u5dJ88gp9ZBTgGoURnm/E
 LwTljnVm5bic/jvqpl5uYZyiaxZ6gcOl1hxFhwDn5wCZBBCkrqe6O31/lPANeLZEh48EyR
 vlWhCQKIA6Unsy+PRheDjnpiBz8b3FDjktFUSNPdwNbuI+WIEHUH6dXc9L62lg==
To: "Baolu Lu" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Disable IOMMU on Lenovo ThinkPad P50s
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
Message-Id: <8d131b2c-978e-4aac-88aa-21b39237344a@liuxiaozhen.dev>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a45487c+dc0982+lists.linux.dev+oliver@liuxiaozhen.dev>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Date: Thu, 2 Jul 2026 01:03:45 +0800
Content-Language: en-US
In-Reply-To: <e4deced7-aabf-44d2-859c-d0b0add48d76@liuxiaozhen.dev>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	<dwmw2@infradead.org>
Received: from [172.16.0.2] ([104.28.165.55]) by smtp.feishu.cn with ESMTPS; Thu, 02 Jul 2026 01:03:56 +0800
References: <20260620192214.923500-1-oliver@liuxiaozhen.dev> <7ebdaa50-2048-486e-9da4-145cea4e3753@linux.intel.com> <e4deced7-aabf-44d2-859c-d0b0add48d76@liuxiaozhen.dev>

Hi Baolu,

Thanks for the feedback.

I will investigate the DMAR table further and provide acpidump + dmesg 
comparison in the next revision.

Best regards,
Oliver
