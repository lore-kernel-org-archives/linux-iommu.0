Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042D10F2
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175509; cv=none; b=amHWsqLmXytRpQQkPx0FdU55ni/nPiqh3LDShDW1Z5m/LPqkQGhdqYiDarMiqvYgUv8RdSZzIeWqWePmlugDZSL9wWBObwQ8tUxRCYOIlCscxuEaFpE3zqEY+/Hn+9pVWMdzYyYBjun2jVbu7l1pyCVE7+vD/ku0UE6enHrc5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175509; c=relaxed/simple;
	bh=xBH5aVbK39yLoUvQn3PqzJ0XHiE2U8rtD20mZ6DpQ64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCdsaTFwAlpOTYTda+NvXHo/pu3ziiQIlPwy0wbMmo1xqoiTqUeVm/6NUL7OYfDfWMtT2v23o7QZVSlVogQKLWpsVK1PBCk6dy+zAB0CQ8zp24SrEuZTbOuiHOr+IljQViZw5SbQElVybKhgsQVBgwEl+b75iGOUzdl6oCCLDHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PL176z3O; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PL176z3O"
Message-ID: <da9db10e-98fd-405c-9167-a29235f5470b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729175505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yD7KPBCrXNDX/3d9ghZ2BK2EsRa7ts6WN8DN8nkkoeI=;
	b=PL176z3OcHG8FNwQY8WBpYPRRBrbneF4jqumWVWNGF+bPS6Gl4z+rFfkJNLYBljjdhewA6
	hW0Er95E/QbtogUXWIQbRjC77jDJvJIATp17uMuyvsorPEsG/Wdyvkm9+vk5DahJoUuMXR
	KDTfapif/KdxeWPJu4E/gjh5hcWp27k=
Date: Thu, 17 Oct 2024 10:31:40 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [syzbot] [iommu?] kernel BUG in dma_alloc_attrs
To: Christoph Hellwig <hch@lst.de>,
 syzbot <syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 syzkaller-bugs@googlegroups.com
References: <670ebde5.050a0220.d9b66.0154.GAE@google.com>
 <20241016080240.GA30380@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20241016080240.GA30380@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/16/24 04:02, Christoph Hellwig wrote:
> The problem is that the dma alloc/free tracing calls virt_to_phys
> on the allocated/free memory.  But that memory can be vmalloced as
> in this case.  I think we don't have weirdo allocators or pools any
> more that are neither in the direct kernel mapping or vmalloc, so
> we might be able to do an
> 
> 		if (is_vmalloc_addr())
> 			page_to_phys(vmalloc_to_page()))

Do we need offset_in_page?

> 		else
> 			virt_to_page()
> 
> here.  Or just switch to tracing the virtual address to always be
> on the safe side.
> 

Since this function returns a virtual address, I think that would be
fine.

--Sean
