Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661D43B815
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866165; cv=none; b=Pok/xEDWnqvu2fTx01Um+E+18O0jfdwEkz+bL8hg9KdglLk534uLzeAH9Hq4+x2ZTpUybAlygSGHuUywU6Wc9heOTjA6/VyMo/kERtrD7YRz7+wqy+baz4oDyBJaFeOag8JkLmhzr9gWg7M8BhZvOQCDVl9MYfI7OJe7SkPJCNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866165; c=relaxed/simple;
	bh=MQCufUGGKAIIlGRfEfQuAs1yRJpzc1EJSOelMzd0zKY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RfZ2OXcvlN10anf/q2LyHvU18z9ka8bc1CWoSaNZH3AUnYIRJDVxxF+TdbbA+3lV3y0ibhX8GhBPJAsLS1YOMKIQ0MG2rYJONDSYZ1t20mfeFOlDyr+Flx+IK2n0LFpcCpCNwO/LlIQPUdGpz0Z8I+Qy1gIvjU7HFOP71sIQmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOlXMpKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOlXMpKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEC1C4AF09;
	Thu,  8 Jan 2026 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767866164;
	bh=MQCufUGGKAIIlGRfEfQuAs1yRJpzc1EJSOelMzd0zKY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fOlXMpKeMA3BU2HpNM6GbXtORS60qLs+Xrfnx9isCu0qbrIresUWUi4bxicRRFqz1
	 by6bSBLycnTN6y4yf31WnXIXV9fPtJ2kKSpMJDtiwVMZc5bfvg7WlEyrcneSQKyLr4
	 Tt92CJgtGSSH3KJiVuMR7YndTlaa4o0Bg1fMXH1u/H8hochL0OvE/UiGPLQG1ov0Rf
	 aSQoa2msJVBt3X8mfEqWxNLuWmJv+8puanv77jagasijCvYNn7SQnxT2FkK8r+fauG
	 PSZMRuqGS0MRquS/zFL89389xv0kiyh/LpWmaASQnl2CmwkzP+u10a8yCfopanVSM9
	 VWcFXjWqlEsAw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 176F1F40068;
	Thu,  8 Jan 2026 04:56:03 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 08 Jan 2026 04:56:03 -0500
X-ME-Sender: <xms:M39faenJtqZQukDPVOgHw0e5ER9AUl5tzMB7A84-nRemvQBrouvM5g>
    <xme:M39faQoilkFuXxfMQ3qr1QnXVkDvylgM-2g8ysb89Pwn1w7NznM-KuIp-1jnGCwhm
    0ONNzW6qKlRhdgbJuYgkvY0mtCS5QNm1WxIl_FDLfX5bOB-Seh9eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepvdfgjeeffffgfeehteeuledugeehtddtfedvuedutdeiffeflefggeeuuedu
    keehnecuffhomhgrihhnpehlfihnrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrh
    hnvghlrdhorhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpd
    hrtghpthhtohepshhuiihukhhirdhpohhulhhoshgvsegrrhhmrdgtohhmpdhrtghpthht
    ohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrnhgvvghshh
    drkhhumhgrrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushifsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhsthhsrdhlihhnuhigrdguvg
    hvpdhrtghpthhtohepmhdrshiihihprhhofihskhhisehsrghmshhunhhgrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:M39faTEBT5t7jutQ6sWrFiMU_4CdFiVXLSl47hictbc25rSq0skgew>
    <xmx:M39facWFmZOS2isPcYJJV9NghrwrfL4cF1_ycaeaAaxLkFS-h0x7Ng>
    <xmx:M39faXVD7HDFPylZyySU_yv2yIJ7XST9CLoccObiA7oFqloQH1Db-Q>
    <xmx:M39faSK3wzHeKgdI_RjbKsrzcZepha2KGaTLD10Qz6HSBEs6TIyg-g>
    <xmx:M39faXBaU93i2FDWGyP-tCzd0dpvF0UJ87NXS3pfwjF2rDsprfyywDdN>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EB91F700065; Thu,  8 Jan 2026 04:56:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: A400LX6vvWzw
Date: Thu, 08 Jan 2026 10:55:31 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: "Robin Murphy" <robin.murphy@arm.com>,
 "Linus Walleij" <linusw@kernel.org>, "Matthew Wilcox" <willy@infradead.org>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>
Message-Id: <984c3737-3934-49bc-908e-8d67facd68a6@app.fastmail.com>
In-Reply-To: <94dae28d-82ae-4340-9abd-097e2d08fb9f@samsung.com>
References: 
 <CGME20260102155138eucas1p1563e460256561f6974079d3de733e895@eucas1p1.samsung.com>
 <20260102155118.2551804-1-aneesh.kumar@kernel.org>
 <94dae28d-82ae-4340-9abd-097e2d08fb9f@samsung.com>
Subject: Re: [PATCH] dma-direct: Skip cache prep for HighMem coherent allocations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jan 8, 2026, at 09:38, Marek Szyprowski wrote:
> On 02.01.2026 16:51, Aneesh Kumar K.V (Arm) wrote:
>> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
>> cache lines from the kernel linear alias before creating a coherent
>> remapping.
>>
>> HighMem pages have no kernel alias mapping, so there are no alias cache
>> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> Indeed this is an overhead to call prep for HighMem pages, but on the 
> other hand highmem support is being phased out according to 
> https://lwn.net/ml/all/20251219161559.556737-1-arnd@kernel.org/ Does it 
> make sense to apply this assuming that it will be removed soon?

I think "soon" is overstating what the plan is. With my proposed
series, the majority of current highmem users are changed to no
longer use it by default, but there are still three ways in which
users will get highmem for a number of years:

- anything with more than 2GB RAM inevitably uses highmem for
  the top portion of physical memory. These are much less common
  than 2GB systems, but are not going away soon.
- systems with sparse physical memory where the first and last page
  are more than 2GB apart currently still rely on highmem even
  if the total RAM is 2GB or less. This happens e.g. on Tegra114
  or RZ-G1H, IIRC. I have plans to address this in the future.
- Users that have applications using a lot of virtual memory
  still have the option to go back to old configurations with
  CONFIG_VMSPLIT_3G by selecting CONFIG_EXPERT.

On the other hand, my proposed change does mean that we have more
freedom to optimize for the non-highmem case. I think we can
require that the CMA area is in lowmem, and we can make the use
of highmem computationally more expensive if it helps simplify code.

      Arnd
