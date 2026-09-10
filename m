Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CFF40911B
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044806; cv=none; b=o2fTCOY242fmvy8Vpo5+NchXCZiX9mdKrikmJXmEwrww9bX25oXas7g6odbK92EUiT36FBDxOqqUhzKtPDcbCFuN5/eTedEA5c/nhwJ+uAjsDvIeLkdI65VSF4CbjRmD3vvIJvIbFnsZtBd5XRG0jjVGkKRlsvcQ2N8SxJxXhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044806; c=relaxed/simple;
	bh=guLDhJ6ZyKq8+hcs+PxAXVS1CrsGCXfmslmq82z2LuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNpFqlBUKSckRibbG6dLz8z0AJJKW4tWUGurwj+ZJ/srBGRNYlbR9wac9xXaeO1dWmyI+ANTY0CrYjQis3VOO7mf0gPo6jecJ+nVwxMcsMnWjanQRdaRBI4LIRRMd/KNJp+vQuMByacXiE9Lcy86UWitUk9oFv2RXr9cCzgZDmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NsFi2Pfv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NsFi2Pfv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6021B153B;
	Thu, 10 Sep 2026 05:53:20 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E68303F7B4;
	Thu, 10 Sep 2026 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789044804; bh=guLDhJ6ZyKq8+hcs+PxAXVS1CrsGCXfmslmq82z2LuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NsFi2PfvyLst+INRWtF2yNw0Omd4UwkceAxkwK5wIm59I/pNOA42pZ29ILrJ1dUBW
	 sMeXXpzg0BjgT5HtTQByXqrn53rtnxBwG4dMGTYsv/ed4APaFU4mf4eehAX7SNVw4C
	 S/IZx7MJ8g/DM8eMZ5IfOjS3FCQf3VeoehWuCebk=
Message-ID: <a219c25b-bc19-4a48-ba0e-dc50ad36f3b2@arm.com>
Date: Thu, 10 Sep 2026 13:53:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dma-mapping: split cache maintenance at highmem
 boundary
To: Karl Mehltretter <kmehltretter@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre
 <npitre@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260909064443.90544-1-kmehltretter@gmail.com>
 <ff220a24-edae-4b75-9873-1a58f5948a01@app.fastmail.com>
 <aqJJ5fQ60Nm6xf5G@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aqJJ5fQ60Nm6xf5G@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2026 7:24 am, Karl Mehltretter wrote:
> On Wed, Sep 09, 2026 at 09:24:23AM +0100, Arnd Bergmann wrote:
>> I can see how the fix addresses the problem, but I don't yet see
>> how you can arrive in this situation. What type of memory allocation
>> can produce a physically contiguous page range from multiple
>> zones?
>>
> 
> Hi Arnd,
> 
> You're right that a buddy allocation cannot span zones. I found this issue
> during code review while investigating another ARM DMA issue. I plan to
> post a patch for that soon.
> 
> My Pi test deliberately reserved the last lowmem and first highmem pages
> in DT. It confirms the crash with a crossing SG entry, but I have not
> found an ordinary workload that creates one. I should have made that
> clear in the changelog.
> 
> In a follow-up QEMU test, sg_alloc_table_from_pages() merged the reserved
> pair into one 8192-byte entry. It checks that the pages are physically
> adjacent but does not check page_zone().
> 
> I also searched a bit for a real-world example. Rockchip's vendor 4.4
> boot-logo code looks like a possible case: it builds an SG table from
> firmware-reserved pages and calls dma_map_sg() when no display IOMMU is
> used. Product logs show the boot-logo feature in use, but I found no
> record of its reserved memory crossing the lowmem/highmem boundary.
> Such a crossing seems unlikely.

That is completely bogus to begin with though. Calling dma_map_* on 
reserved non-kernel memory is liable to blow up in various ways anyway 
(e.g. in sparsemem page_to_pfn/pfn_to_page) - what's the justification 
for being more lenient towards one particular corner of invalid usage?

Thanks,
Robin.

> I still think the change is worthwhile. For v2, I will update the
> changelog to make the test setup and its limits clear. I may also drop the
> Cc: stable tag.
> 
> Thanks,
> Karl

