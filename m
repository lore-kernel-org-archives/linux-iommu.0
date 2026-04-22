Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E73BFE34
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849204; cv=none; b=tvuQA2cUbxwpWry35fFI66QEk3Oy6UdNzHp52WPRDZbgypYH01mXR2TYo5gihywAgZq9DPPqVjMhANLaWnETcZP+HoSafLLTbhc2/vz8mz38J9Vck8NJJXwLFJV9S1JcbWqhhDnVGJ2vg8yIIa4/w+BEbyhMXOxGLzRch7b+NKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849204; c=relaxed/simple;
	bh=AU6tkIXFpBsARMpEVsdwE7fgBgmv+feIL9n8Abb8Aog=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4Ghx5E1EIK3HQhnkMhj1A2kO64hYXGPKVyoarbShtrVsP3VB3fMuxffOb95FGGmIKA9XYBgvOZeCDHZSfPwq65R5tNvx8bqXnuNlW6Bqb6dUNeogxfz9UkVOrSyxU81REVgA9jFgal37LFGu17GklYynaoauGBtOqlt5ff5mHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=rG3naTai; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="rG3naTai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1776849189;
	bh=NvDzVjyERqO/2mnoaNmE3DhHkGdFG83VRowcx91DmpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rG3naTaiNCqJwzxaN3ZazwsiosJPHU+8tq29ksM9VyghzIkErXgYLNvh9NGW553tS
	 rNfib7LgzKL4eJ1lc+rPdl0UVW/WIfis+UN24GLnrIUtaV8ovWLrMPHVnbp86qABCE
	 80gPqXm6w6gcnse1h2PZDOYb+8i7GT8vxI+llCVA=
Received: from localhost ([61.169.175.90])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 3478C04D; Wed, 22 Apr 2026 17:13:07 +0800
X-QQ-mid: xmsmtpt1776849187tfue4b4ka
Message-ID: <tencent_DA99B62735469A0CD219E9FC73E234A47309@qq.com>
X-QQ-XMAILINFO: NT2OMgh8In2+nYCaIOTawZv6IJQwWeGK62m+35J0rj/sa1nkowXbkgMqZsr0d8
	 /BjdMHQZOXQMlngH7fH7mx04zyols9XTvb3hxAKf1muunKmZwK5C18bXvj5fCHydT2RaCnuVpSU8
	 CEoPev0BZphm2rl3TNNQ4MDEN94kZwjq4PcLilxzRTNg1E2yj8OUxqebLbaYneE08KftnWnjaLjM
	 R3yC13IHEDshCuowhgonkvcr5eW8xc3QYRB8+z71Ypd7Tt/i7YZkdKjfHFahwomLVwtobGBugDUZ
	 295sd5ARD5nhyYOHtV2xOuchiQElJYzWEt1mFAaseuB608sLX+L/+tx6ByyxA/RMX0DM2BjWdhHS
	 bsb1zNOpSzD37NpmaAvKvCkMti0UnGGn8NK3Evb64SaSoY66vCi+4+fu8S7BHBFS2hq2z23TfhEw
	 A3izZHSCkCs2g5WFju8HCUcxIMa6bKxonwbryiIuw9hITl8qE00Dwid5mOun4NCMn6L5P1xyquwq
	 XejrZwcN17l+zaiZ94WoGv1DOcwMx6SVR1EjCxwmxtN/7b1JDHqzhlpNJ6DyA0rYXYw5QxiY3noA
	 ocY8F8P7o1TPObVmqGPLN61bkGNpNJtcsICweFk8oo9QfYU9DIAbkQQTAJSRAL9h3cr832YX1zeE
	 OT1oSF5Gu2XhvZ76JgqtGBSD5xI8XQQREk5s0ol7rSf62EXYGzVlNHQ8gWjoM9QZmiVWhmlfIrHj
	 Z8Eip8gmzRBUjnZ80RRSr41YHe7mdysbMOTiliypFCzGXFtIAjA5C3B0o3y6qeSgD0IWkYlNndTb
	 Cabya2wVon/rNaeTPVkCsiElBcA9zEs+G1RFkFE+n+3WOJe9TEqZhYYcy8Pyuv4862QCYh6qrC1v
	 YC6gAM0DGf9nXJS9kMJ3ec8qgOQWhHfgyan7d+hkbKbh0LXDBsNuWC7I2rl36rk5yDAE/Ikwo1uy
	 vToRpjRHKfhorzHjE89dKPjcHRmvRT2sA8aBuMWId7UQQopC1yiRcvtPE3EiTRESzsC8HY4EQUIc
	 ksXlIevCBO4J17ZJNHm5T4dAGvGsAMx+MCsWSJf89XkhMKTwbYwOb0EmA8f/xa4sVLKj0aOaLNxF
	 8F9oYL37Rq4wI7K+mJtOh1lCFjrT2lM5Y1k2AnkoJiN2jbFOk=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
Date: Wed, 22 Apr 2026 17:13:08 +0800
From: Leo Jiang <leo.jiang1224@foxmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Stop queue allocation retry at
 PAGE_SIZE
X-OQ-MSGID: <20260422091308.2j4cp7xwj5rlc67i@LAPTOP-LEO.localdomain>
References: <tencent_F6E384A40D990A279B460A0CDE1927FDF509@qq.com>
 <0fdf4b1f-90f2-4f69-9d2b-dc5f608e9c1c@arm.com>
 <aeeoEHHNKPo32H9R@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeeoEHHNKPo32H9R@willie-the-truck>

On Tue, Apr 21, 2026 at 05:38:40PM +0100, Will Deacon wrote:

> On Tue, Apr 21, 2026 at 04:56:47PM +0100, Robin Murphy wrote:
> > On 18/04/2026 6:31 am, leo.jiang1224@foxmail.com wrote:
> > > From: LoserJL <leo.jiang1224@foxmail.com>
> > > 
> > > In arm_smmu_init_one_queue(), the loop reduces max_n_shift if
> > > dmam_alloc_coherent() fails. However, since dmam_alloc_coherent()
> > > allocates at least PAGE_SIZE, retrying with a smaller size after
> > > a PAGE_SIZE failure is logically redundant.
> > 
> > Says who? It's certainly not a guarantee offered by the DMA API itself, and
> > indeed some allocation paths can definitely still allocate less than a page
> > - e.g. anything which hits a per-device or global coherent pool.
> > 
> > > Moreover, if a sub-page retry were to succeed due to concurrent memory
> > > release, the hardware would be configured with a smaller queue depth
> > > despite a full page being allocated. This leads to inefficient memory
> > > usage and unnecessary hardware performance limitation.
> > > 
> > > Terminate the loop once qsz reaches PAGE_SIZE to ensure logical
> > > consistency and optimal hardware configuration.
> > 
> > That's really not an argument - even if an allocator does happen to
> > over-allocate for the requested size, that is hardly the caller's concern;
> > and as far as "optimal" queue sizes go in this case, those very much depend
> > on the number of CPUs issuing commands and volume of expected stall/PRI
> > events - in many cases PAGE_SIZE would already be far too small to really
> > work well.
> > 
> > Also note that if we _were_ to fail to allocate a PAGE_SIZE or smaller
> > queue, there would be very little chance of the subsequent allocation(s) for
> > the stream table succeeding, so realistically the driver is probably going
> > to end up failing to probe in such circumstances anyway.
> 
> That's all true, but tbf I think I just fscked up the comparison in
> d25f6ead162e ("iommu/arm-smmu-v3: Increase maximum size of queues") so
> I'm not against fixing that up even though the "rationale" given by
> Loser doesn't make a whole lot of sense.

Hi Will, Robin,

Thank you both for the detailed feedback.

Robin, you are absolutely correct. After a deeper look into the source code,
I see that allocations smaller than a page are indeed possible in certain
cases. My previous assumption about the DMA API's granularity was wrong,
and I appreciate the correction.

However, as Will noted that the current logic deviates from the original
intent, I have prepared a v2 to limit the queue allocation retry boundary
to PAGE_SIZE.

In v2, I have:
 - Updated my identity to Leo Jiang.
 - Removed the code comments as suggested.

I will send the v2 as a follow-up shortly.

Best regards,
Leo Jiang

