Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020747DD4A
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640359; cv=none; b=Hlr5Ik9qPjCGaQTIH/9B5VO8O6Y1+V2YDJQwqkt3+LatMJ+7OP+m48m7w5fKYs4a+QoCKDJUVAkwPVFR4fUGezkxIl7ffRpD/JUiU0cGUTO4DldTdQJmWIT14J+bVTSidFdA79b6t3jOH8CWLRS7wlpptEE2ojqO8z73BJV+CBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640359; c=relaxed/simple;
	bh=fNnIa62LQih6GeVVWW0x6Zn/llt3dEzQ7bQP3IWz+Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHguuiD1DBNrRSPxI75c92w3+1qIuSHpV0HKHZKVxzgrHWXtM21QsdUes6hNvGS+PvYoV/9ApcRfsYm/KVoy4+REOOUnBXD9NllbfUcH+J0KNKLrKsQPhv2vjgw2NqxZJyfvM5Cn4ROlTraa3YOq1uju2brZYQLkqCFrHBYJwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BF5mBW2T; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BF5mBW2T"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7323B1576;
	Thu, 13 Aug 2026 09:59:12 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 166263F66F;
	Thu, 13 Aug 2026 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786640356; bh=fNnIa62LQih6GeVVWW0x6Zn/llt3dEzQ7bQP3IWz+Hs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BF5mBW2T0Rjy3QlP9CCabOJ2hJ5G/jab0BWCM+P6fZo3WKsuI5YMutHmk9XVv1EmE
	 XkaCvCuVflURqiKYjAkhzVlKv91HR8CpNLfBTMAxSgtnkDzv2F4x0SnjsTI/x2vRaE
	 Gj1VFIeZ9o4R/2IptVRmZvxyO4MUXbbhj83Pda+M=
Message-ID: <317c8a9c-3b40-407d-bcf2-02b9be1b14b3@arm.com>
Date: Thu, 13 Aug 2026 17:59:05 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in free_iova
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: syzbot <syzbot+90c2d711b5218d10ce61@syzkaller.appspotmail.com>,
 baolu.lu@linux.intel.com, dwmw2@infradead.org, iommu@lists.linux.dev,
 joro@8bytes.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, will@kernel.org
References: <6a7910da.9c11d2ce.289b96.00da.GAE@google.com>
 <68eebaf3-2427-48c0-93d3-87455ff266fb@arm.com>
 <20260810173230.GQ200537@ziepe.ca>
 <6f650cc2-b4fd-4305-b4d7-847ef935449a@arm.com>
 <20260811131154.GA544626@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260811131154.GA544626@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 2:11 pm, Jason Gunthorpe wrote:
> On Tue, Aug 11, 2026 at 01:57:38PM +0100, Robin Murphy wrote:
> 
>> But where would that unmap be?
> 
> If the theory is right then the bug would be some concurrent driver
> thread like a work queue/timer or a user thread going into a fops that
> outlives the driver remove function. That thread would do the unmap.
> 
> This is an extremely common bug class in drivers at least..
> 
> eg DRM has lots of challenges in this area if the guess about VGA is
> correct.

Oh, indeed - I futzed with it a little bit and sure enough:

[  225.056075][    T1] [drm] Found bochs VGA, ID 0xb0c5.
[  225.071671][    T1] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebd4000.
[  226.061260][    T1] [drm] Initialized bochs-drm 1.0.0 for 0000:00:01.0 on minor 2
[  229.801060][    T1] bochs-drm 0000:00:01.0: [drm] fb1: bochs-drmdrmfb frame buffer device

It's a well known thing that DRM drivers can't really support device
removal or any kind of forced driver unbinding at all, as the drm_device
can be held open by users and outlive its underlying driver, then it's
UAF city in more ways than anyone cares to enumerate. Furthermore, a
completely bogus dma_unmap() of the VGA framebuffer's physical address
in a misguided attempt to clean up a doomed unbind might well explain a
reserved IOVA getting freed as well...

So yeah, move along folks, nothing to see here :)

Thanks,
Robin.
