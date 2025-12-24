Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776CD78F20
	for <iommu@lists.linux.dev>; Wed, 24 Dec 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571467; cv=none; b=QaeKhyAL1bY9Cw9OPlXSmAaaaeY+Ul3rsza1xU6erWsD91nCjtt4nGflMEtwMBbrI6WHL4mpWepnFSMZmoF1z/x/tXeN2NswiXkw44jdnqv0al4IAwh3qtK9F0XY2atT7n8Yc53NQipOjXk4aJhgaI4jw0UBKIklHBypS9/mmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571467; c=relaxed/simple;
	bh=yT1IifU3Y6FqkXPB03pTZdWn12N4Oj3n/1+IwjZ9kvU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Zj7h1Ct1upha/O8x/3T6Dml8sHQ3Vjo0Ud+iCXaYgS9fpH+swxPCqQVoCZW87nO8lUZehFTuwyGgYw55hCdgr75fZVUOQnKgw15tgfiv97wrnCubtrCSjJ3kEsFYfUVi1wA9YA7iTxc/yU9dHyAlpVfAhFSH6Q3LKU5Ipywr2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PmNDXALE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KrDeGtj4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PmNDXALE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KrDeGtj4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70E097A00B3;
	Wed, 24 Dec 2025 05:17:44 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 24 Dec 2025 05:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766571464;
	 x=1766657864; bh=amEsHc8X7UUILzkMGVY7QNYa19+rIBqPch+bp74xtvc=; b=
	PmNDXALEx3jFrHxqNtdVBNIwE1tdEQmfnVLudNUm3hIcT18YTYrryng4MzyMqy66
	F6gIok0y4flLt93QZjBgRCL5ZVOx03W4aOS+GFRLeuFUXJ7BBJ0/iKu7a3lQmTq/
	Jnr/0VYR3RfG+wSzvW8Q9K97sQon766TxFenjTJUyq6I67lFpsE1/KggX0nJhXww
	Molfdb+/7srb/ITVAJutri1Ttu+HeCIDRYLVxKlgyZDOdHfHAMvWAR1/i3ERQBBm
	SlzFJLc3a4OIFzB36xRiuiaa/UzQV8vCVqVezLJHBBUxDHkmlLQJuqE4quSmTXQU
	Q3M4o0dIaBzFYlwYGjmBjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766571464; x=
	1766657864; bh=amEsHc8X7UUILzkMGVY7QNYa19+rIBqPch+bp74xtvc=; b=K
	rDeGtj4hdYOaXsNb+NJcP5jWuGAq1xWwF2HZ5bBhcEHS6S+2nBaXMOM4Wcj93g1l
	dKHXKT23iSiCtKCq/C6r6BK6qf8frKKI0ZwYgbpeqggKoMIvmihXjEOnH9MJykGA
	vN64MZCl5ZSlNHg5IrXPlZM3qSaBKrqVzm9d0dPrPyslRxOCorxdAGkmOMvuRFju
	Epl8rq38BPKTpYnbrRD/slzCDBueEQBtHfXAIJbjCqTujdDNWu42XZIvEBBP28cB
	e9Vkq/yK4bi8miqYrqeeUc177wLTZQ3HQWZUCfwKImOSWoW87+2f3zgjdCUEG5nN
	G412zvPufyNh38kCSeRoA==
X-ME-Sender: <xms:x71LaQRr7rSdky1s04KPK5LPM2vdZPL4JMhIsK5fs1w0FqQP5hicBA>
    <xme:x71LaYn85zgMUFyWGIWisej63d8zVp0zK_ZznI7urBOvtIT7QLF3DsjsePjI51J-3
    AoGDh-YaCpSXNTAYrGYKHXSx1VexH_WKvGngoZqR7hB06C2kahLr8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeivdeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehrohgsih
    hnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopehprhgrrghnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehskhhhrgifrghjrgesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpthhtohephihi
    rdhlrdhlihhusehinhhtvghlrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlh
    drohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggrohhluhdrlhhusehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:x71LabBUxEitJML0MOLBQJlOzKsZkqrughf3MtZv6lO3XaAa8PrcLA>
    <xmx:x71LaVMitK9q-l-vrkl30OybiP-cjo2-7eisXw23Jg6F9JGJFznaBA>
    <xmx:x71LafN8hAyv8BjtGDvHon9LMMUhTF8Ah0Z0xz_AOCt9mJeHTOqu0A>
    <xmx:x71LafLML3cfUfl9GO-rOv2AiGPEILyupVShysXL8BBpCpM0dv29IA>
    <xmx:yL1LaSxDai_Gq_p7mkQE4vpY1ZNsbRuMAdBdR6ojXIbe2PhlygEowmvg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6B6FC70006B; Wed, 24 Dec 2025 05:17:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AWSZljzAJEEZ
Date: Wed, 24 Dec 2025 11:17:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@ziepe.ca>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Kevin Tian" <kevin.tian@intel.com>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Nicolin Chen" <nicolinc@nvidia.com>,
 "Baolu Lu" <baolu.lu@linux.intel.com>,
 "Pranjal Shrivastava" <praan@google.com>, "Yi Liu" <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <beb85629-4912-4279-b025-a7debd1dfc6a@app.fastmail.com>
In-Reply-To: <aUtHZ1KHTJjW7SPP@ziepe.ca>
References: <20251223215127.603969-1-arnd@kernel.org>
 <aUtHZ1KHTJjW7SPP@ziepe.ca>
Subject: Re: [PATCH] iommufd: fix selftest link dependency on amdv1 driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 24, 2025, at 02:52, Jason Gunthorpe wrote:
> On Tue, Dec 23, 2025 at 10:51:22PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> When CONFIG_AMD_IOMMU is disabled, the selftest runs into a link failure:
>> 
>> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o: in function `mock_domain_alloc_pgtable.isra.0':
>> selftest.c:(.text+0x1590): undefined reference to `pt_iommu_amdv1_init'
>> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x280): undefined reference to `pt_iommu_amdv1_map_pages'
>> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x288): undefined reference to `pt_iommu_amdv1_unmap_pages'
>> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x2b0): undefined reference to `pt_iommu_amdv1_iova_to_phys'
>> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x2d8): undefined reference to `pt_iommu_amdv1_read_and_clear_dirty'
>> 
>> Change the top-level function to skip all the amdv1 tests in this
>> configuration.
>
> kconfig shouldn't let this build happen:
>
> config IOMMUFD_TEST
>         bool "IOMMU Userspace API Test support"
>         depends on DEBUG_KERNEL
>         depends on FAULT_INJECTION
>         depends on RUNTIME_TESTING_MENU
>         depends on IOMMU_PT_AMDV1
>         select IOMMUFD_DRIVER
>
> I think this is more fall out from Geert's change to make GENERIC_PT 
> unselectable, the 'depends on' is no longer enough??
>
> I guess the right fix is to add a "select GENERIC_PT" above, does that
> work for you?

No, it's already set.

The configuration that had the build failure contains

CONFIG_ARM64=y
# CONFIG_AMD_IOMMU is not set
CONFIG_GENERIC_PT=y
CONFIG_IOMMU_PT=m
CONFIG_IOMMU_PT_AMDV1=m
CONFIG_IOMMUFD=y
CONFIG_IOMMUFD_TEST=y

I suspect this is because IOMMUFD_TEST is 'bool' and can be enabled
even when its dependencies are =m, but if the test code is built-in,
it can't actually link.

This should be fixable using

       depends on IOMMU_PT_AMDV1=y || IOMMUFD=IOMMU_PT_AMDV1

or by forcing the iommufd code to be a loadable module when
IOMMU_PT_AMDV=m, e.g. through

config IOMMUFD
      depends on IOMMU_PT_AMDV1 || !IOMMU_PT_AMDV1 || !RUNTIME_TESTING_MENU

A cleaner approach might be to split out IOMMUFD_TEST into a separate
module rather than including it inside of the IOMMUFD module,
but that is likely much more work.

      Arnd
