Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E3E14F61
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B28j4+Ug"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VVhvRIlQqXGnJRR9+75jpe4XOyrEd50DqThibj3ReZo=; b=B28j4+UgaFzw453tRvs72NdXSl
	I2Z0dLC5hPPnj0ywIP5zD8YYstf4UXvNhnlomEnP52ijEefej+i9InagDQXrsphVZFatJWYfCYYFd
	htEYny0GJEj0XsOENTwyCHhAyGfzldVAyhXVR0zoHH8LN+LBTQeDpedAycF8WYj5SvASyFDXrOM6K
	SWQbXwxJqe7ZzsBlfuWLsxP1uMlkVAfjJ8oKk8vyb5j9RaFN98HYEKToRCHwySwCtxrcfjT6qqiAJ
	+Kjn4YhiIMaYnfi0xuqjgY+YLpQ5Mvk0d8ZBju1ztybgKLcCWNOgqJtwWSac9TPeUPZdoOl8Hi7Dv
	4N+z7nJw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qv3OG-008Mvt-0W;
	Mon, 23 Oct 2023 22:27:16 +0000
Message-ID: <9e56e94d-536e-435a-afb0-4738e6eddedc@infradead.org>
Date: Mon, 23 Oct 2023 15:27:15 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Oct 23
 (drivers/iommu/iommufd/hw_pagetable.c)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>
References: <20231023165831.30d525ad@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231023165831.30d525ad@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/23 22:58, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20231020:
> 

on ppc32 or i386:

powerpc-linux-ld: drivers/iommu/iommufd/hw_pagetable.o: in function `iommufd_check_iova_range':
hw_pagetable.c:(.text+0x90c): undefined reference to `__udivdi3'
powerpc-linux-ld: drivers/iommu/iommufd/hw_pagetable.o: in function `iommufd_hwpt_get_dirty_bitmap':
hw_pagetable.c:(.text+0xa4c): undefined reference to `__udivdi3'


Is there already a patch for this?
Thanks.

-- 
~Randy
