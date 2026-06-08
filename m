Received: from mail-m1973197.qiye.163.com (mail-m1973197.qiye.163.com [220.197.31.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE953367297
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895725; cv=none; b=UA6fxaXxvV49hIdGFl9JEKx6bsxnyKLJ9vr7B7BD1gFu2fbYkwHvr4KAiOp3u7P6Y4aY5vIlbI9Mxv+RC4wUJVyaQzGD4IoeQ0YrKLCLIwXfdkRLoGBH7+J0EPe2X+ISUqyLzyN5CMmlSAcgaKq3I6aPUAAidVRE4MPqq/LqoL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895725; c=relaxed/simple;
	bh=ivtol/J+iFUXgjxze69yMpBtbl+ljp6Q1P7Qq6Rk76A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wk6CpFB2hggifrIKbrak8RDSDFOsoYLr12QAXHza/SuTsTMGVNQNJuT+1tIOkDRgik2fKzgNsTK+y0U9o4Yy0oEhq8uRg2BYr0QlsbI0p0X/RsmtCnd3n4bu/B7uvIqg3Y0VIHqKhw43lGBRmDa0lBkiF82OpbudOmbXNQ8vbcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jIgtsz0T; arc=none smtp.client-ip=220.197.31.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jIgtsz0T"
Received: from [172.16.12.90] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 416bb7c88;
	Mon, 8 Jun 2026 09:45:55 +0800 (GMT+08:00)
Message-ID: <0919ffcc-81c3-483a-a3ba-404b455c2040@rock-chips.com>
Date: Mon, 8 Jun 2026 09:45:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
To: Midgy Balon <midgy971@gmail.com>
Cc: Simon Xue <xxm@rock-chips.com>, tomeu@tomeuvizoso.net,
 ogabbay@kernel.org, heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260604135255.62682-1-midgy971@gmail.com>
 <20260604135255.62682-7-midgy971@gmail.com>
 <e44b506e-e9d2-48e3-acea-ab28b7be9b37@rock-chips.com>
 <CA+GS1Y16++cztPxdUGLrPA73ENm4vJGFrjm-jP8r=8OQqcMJGA@mail.gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <CA+GS1Y16++cztPxdUGLrPA73ENm4vJGFrjm-jP8r=8OQqcMJGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ea4e8693b03a7kunm5581ce41167e8e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0lLVhlNHkJLHRlDGU9CSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jIgtsz0TyrcFAl+irGQT/FzW/PHecgbmGKsmkt1lnYbbFGDHi1B7akwRMLwY6y/4vFy4+FD+auD6oR1rDOMqmmDFeT8wfSpcb6uQYaIlHVgWzsfkXqJCGQLq4+vHplwYP9NJaOVglVtq7rO5PPu+Hx5XWacT4HRifZn4QvoaS0g=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=gtF5hamNMT8w7gwfV8u7Brm72XuPs2uaU6pQ7P0r8NA=;
	h=date:mime-version:subject:message-id:from;

Hi Midgy,

On 6/8/2026 5:05 AM, Midgy Balon wrote:
> Hi Chaoyi,
> 
>> As I said, it is v2. Could you please try using the code below instead and
>> see if it works?
>> [ auto_gate = read(RK_MMU_AUTO_GATING); auto_gate |= BIT(31); write(...) ]
> 
> Thanks -- that's clearly the right shape (read-modify-write, before paging is
> enabled, keeping the reset value instead of my clobbering 0x2).
> 
> I rebuilt v7.1-rc6 (with the rocket RK3568 series + your per-device-ops work)
> using your bit-31 version and tested it on a ROCK 3B: the NPU IOMMU comes up and
> services the NPU's DMA cleanly -- the NPU probes, attaches its domain, and runs
> repeated conv submissions with no DMA_READ_ERROR and no page-walk stall. No
> regression from the write.
> 
> To be precise about what I can and can't show: I tested both ways on v7.1-rc6 --
> with your bit-31 write, and on the reset value (0x3) -- and the NPU
> IOMMU services
> the NPU's reads with zero faults in both cases (no DMA_READ_ERROR, no page-walk
> stall). So I don't have a failing baseline here that bit-31 visibly
> fixes. Is the
> AUTO_GATING write needed on current mainline, or only under conditions I'm not
> reproducing (a particular traffic pattern / silicon rev)? I'll keep the patch in
> your form unless you'd prefer to drop it.
> 
> One question so I document it correctly: what does bit 31 of RK_MMU_AUTO_GATING
> control on the v2 block -- is it a master "disable internal auto clock-gating"
> for the page-table walker (i.e. so a TLB-miss walk's AXI master keeps its clock
> to completion)? The RK3568 TRM I have doesn't cover the IOMMU registers, so a
> one-line description would let me write an accurate comment.
> 

Glad to hear this works. Please refer to the commit below.

[0]: https://github.com/rockchip-linux/kernel/commit/7f8158fb41b5cc8e738aaeebc3637c50ebd74cae
[1]: https://github.com/rockchip-linux/kernel/commit/6a355e5f9a2069a2309e240791bc3aad63b7324e

-- 
Best, 
Chaoyi
