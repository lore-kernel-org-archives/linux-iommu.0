Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A2C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 06:16:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAE560EBB
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 06:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BAE560EBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D05D940201;
	Tue, 10 Aug 2021 06:16:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wHUYr93Iu-f; Tue, 10 Aug 2021 06:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A550401AD;
	Tue, 10 Aug 2021 06:16:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3857C001C;
	Tue, 10 Aug 2021 06:16:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2387DC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 06:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06B2B607F5
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 06:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="HR+BeCiI";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="wwzOTzwO"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e6jIWSP2TBzO for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 06:15:55 +0000 (UTC)
X-Greylist: delayed 00:05:36 by SQLgrey-1.8.0
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76AF760802
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 06:15:55 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 779AF3200936;
 Tue, 10 Aug 2021 02:10:15 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Tue, 10 Aug 2021 02:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=qNvbQWvcC0Lv3u4CugSoZXlVZMPC
 ExlFhgw8eKIUSmE=; b=HR+BeCiILJ5qQ9VkGi8Xjxrs0w/38sMiKC62dBvLUClK
 W8cosNzGCj9f/MDx1jiUCdPnd5qtewv2k2awc9digTuPC9+9AQofYHfuq0hFqSq/
 lP6XK/VHiUx7N/4J+/ZA2FT0keoRFED1RP+Py4zb3EzPiFk2Mmo5neSOUuzV0th5
 2uBi2uAwpzN7ZKPuds/vX7YSfeJ6FrFGciNKENp8S9cRaEEhOn5DYhSAq+5/wmfE
 zYGvPZCmFoYJgqOpcSTxK/KV/FcFtEAhqYIn/ceW5i//1lHfMwRL+siF/sPg/gn7
 i7j3UflNUnrNtxjVMTNKULvvTbhGgFYSovxM+eAbaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qNvbQW
 vcC0Lv3u4CugSoZXlVZMPCExlFhgw8eKIUSmE=; b=wwzOTzwOeGD/FzxCKUQpVH
 XgzgVmd6tqrfYap0kgbzzDoUp+h96VhxO8f6ss0zWfhROIvMgjpnIk6wy2/vPJa9
 aV0Jj40lNyrpIakx1GxD3HwwFAON29Kbi20LZWy9X0C0rPyFUHoL5OleBiiewe86
 E6rMtT9uT07uZQF2DRgN3kbUkF4y0x+HCPyWZQuCWTRF29ipNGR94jhWbeTcLj+N
 5WMZT/weyBN5TsZ3mxIUPyaAVUDUhOW/UCj/pislF7du/w0yLdb0pmDFI5CQAGkC
 jCJIPQhAN4wWKF2p8X9QWwu1dvRQwSg84aGGag9axb+eXK5itVdO6cwh99HcHsbA
 ==
X-ME-Sender: <xms:RRgSYY9C_nkDES2E-jrw53iRXaIoXNsjaRTe7Ixkf7zrx4_ZLd5zJQ>
 <xme:RRgSYQvt2Abxl3s7JjnEIK_vgMeq3WTpbQQMt0mJGitfFzYbBJr655yIuwDHz-zXP
 99k_zRLn-FZ5C8XWhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeekgddutdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpeefjefggeejuedvgfeuffffhfefhfdtvdeggfdttddtuefgudevfeelhfdt
 hefgudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusghushgvrhgtoh
 hnthgvnhhtrdgtohhmpddtuddrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:RRgSYeAn2dYyUkR6S_6ho3dDbrhn2qO8jeiTTYMXzHG9m4j8HyqAdw>
 <xmx:RRgSYYemrNv2ONJo6MgIv-dcJk7h1F-eNzKUoJD8whDZs5SUVVJBiw>
 <xmx:RRgSYdP113h4DSwZlmLx3FNW-YlhPp8pHEnd4rqeTliUzqvRHpC-GA>
 <xmx:RxgSYb1biZKfNuzQ7RXZBt8BgCkdcly8eNcWfv8RHGdr8vpsc4xlQA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C527A51C0060; Tue, 10 Aug 2021 02:10:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-552-g2afffd2709-fm-20210805.001-g2afffd27
Mime-Version: 1.0
Message-Id: <0589c725-401b-482f-ba2b-0707c02ea40a@www.fastmail.com>
In-Reply-To: <202108100801.aYU4IXvh-lkp@intel.com>
References: <202108100801.aYU4IXvh-lkp@intel.com>
Date: Tue, 10 Aug 2021 08:09:53 +0200
To: "Joerg Roedel" <jroedel@suse.de>
Subject: =?UTF-8?Q?Re:_[iommu:apple/dart_3/3]_drivers/iommu/apple-dart.c:730:17:_?=
 =?UTF-8?Q?error:_initialization_of_'size=5Ft_(*)(struct_iommu=5Fdomain_?=
 =?UTF-8?Q?*,_long_unsigned_int,__size=5Ft,__struct_iommu=5Fiotlb=5Fgath?=
 =?UTF-8?Q?er_*)'_{aka_'long_unsigned_int_(*)(struct_iommu=5Fdomain_*,_l?=
 =?UTF-8?Q?ong_unsigned_int,__long_unsigned_int,__struct_iom...?=
Cc: iommu@lists.linux-foundation.org, kbuild-all@lists.01.org,
 kernel test robot <lkp@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Joerg,

This happens because apple/dart is missing the "Optimizing iommu_[map/unmap] performance"
series which is already in the core branch [1].
The same commit works fine in iommu/next since that branch merges both iommu/core and
apple/dart.

Thanks,

Sven

[1] https://lore.kernel.org/lkml/1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com/

On Tue, Aug 10, 2021, at 02:12, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git 
> apple/dart
> head:   05ce9d20d699b093dec985192a7db63b48f26ca2
> commit: 05ce9d20d699b093dec985192a7db63b48f26ca2 [3/3] iommu/dart: Add 
> DART iommu driver
> config: sparc-allyesconfig (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget 
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # 
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?id=05ce9d20d699b093dec985192a7db63b48f26ca2
>         git remote add iommu 
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
>         git fetch --no-tags iommu apple/dart
>         git checkout 05ce9d20d699b093dec985192a7db63b48f26ca2
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross 
> ARCH=sparc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/iommu/apple-dart.c: In function 'apple_dart_map_pages':
>    drivers/iommu/apple-dart.c:380:12: error: 'struct io_pgtable_ops' 
> has no member named 'map_pages'
>      380 |  return ops->map_pages(ops, iova, paddr, pgsize, pgcount, 
> prot, gfp,
>          |            ^~
>    drivers/iommu/apple-dart.c: In function 'apple_dart_unmap_pages':
>    drivers/iommu/apple-dart.c:392:12: error: 'struct io_pgtable_ops' 
> has no member named 'unmap_pages'
>      392 |  return ops->unmap_pages(ops, iova, pgsize, pgcount, gather);
>          |            ^~
>    drivers/iommu/apple-dart.c: At top level:
>    drivers/iommu/apple-dart.c:729:3: error: 'const struct iommu_ops' 
> has no member named 'map_pages'
>      729 |  .map_pages = apple_dart_map_pages,
>          |   ^~~~~~~~~
>    drivers/iommu/apple-dart.c:729:15: error: initialization of 'int 
> (*)(struct iommu_domain *, long unsigned int,  phys_addr_t,  size_t,  
> int,  gfp_t)' {aka 'int (*)(struct iommu_domain *, long unsigned int,  
> long long unsigned int,  long unsigned int,  int,  unsigned int)'} from 
> incompatible pointer type 'int (*)(struct iommu_domain *, long unsigned 
> int,  phys_addr_t,  size_t,  size_t,  int,  gfp_t,  size_t *)' {aka 
> 'int (*)(struct iommu_domain *, long unsigned int,  long long unsigned 
> int,  long unsigned int,  long unsigned int,  int,  unsigned int,  long 
> unsigned int *)'} [-Werror=incompatible-pointer-types]
>      729 |  .map_pages = apple_dart_map_pages,
>          |               ^~~~~~~~~~~~~~~~~~~~
>    drivers/iommu/apple-dart.c:729:15: note: (near initialization for 
> 'apple_dart_iommu_ops.map')
>    drivers/iommu/apple-dart.c:730:3: error: 'const struct iommu_ops' 
> has no member named 'unmap_pages'
>      730 |  .unmap_pages = apple_dart_unmap_pages,
>          |   ^~~~~~~~~~~
> >> drivers/iommu/apple-dart.c:730:17: error: initialization of 'size_t 
> (*)(struct iommu_domain *, long unsigned int,  size_t,  struct 
> iommu_iotlb_gather *)' {aka 'long unsigned int (*)(struct iommu_domain 
> *, long unsigned int,  long unsigned int,  struct iommu_iotlb_gather 
> *)'} from incompatible pointer type 'size_t (*)(struct iommu_domain *, 
> long unsigned int,  size_t,  size_t,  struct iommu_iotlb_gather *)' 
> {aka 'long unsigned int (*)(struct iommu_domain *, long unsigned int,  
> long unsigned int,  long unsigned int,  struct iommu_iotlb_gather *)'} 
> [-Werror=incompatible-pointer-types]
>      730 |  .unmap_pages = apple_dart_unmap_pages,
>          |                 ^~~~~~~~~~~~~~~~~~~~~~
>    drivers/iommu/apple-dart.c:730:17: note: (near initialization for 
> 'apple_dart_iommu_ops.unmap')
>    drivers/iommu/apple-dart.c: In function 'apple_dart_unmap_pages':
>    drivers/iommu/apple-dart.c:393:1: error: control reaches end of 
> non-void function [-Werror=return-type]
>      393 | }
>          | ^
>    drivers/iommu/apple-dart.c: In function 'apple_dart_map_pages':
>    drivers/iommu/apple-dart.c:382:1: error: control reaches end of 
> non-void function [-Werror=return-type]
>      382 | }
>          | ^
>    cc1: some warnings being treated as errors
> 
> 
> vim +730 drivers/iommu/apple-dart.c
> 
>    723	
>    724	static const struct iommu_ops apple_dart_iommu_ops = {
>    725		.domain_alloc = apple_dart_domain_alloc,
>    726		.domain_free = apple_dart_domain_free,
>    727		.attach_dev = apple_dart_attach_dev,
>    728		.detach_dev = apple_dart_detach_dev,
>  > 729		.map_pages = apple_dart_map_pages,
>  > 730		.unmap_pages = apple_dart_unmap_pages,
>    731		.flush_iotlb_all = apple_dart_flush_iotlb_all,
>    732		.iotlb_sync = apple_dart_iotlb_sync,
>    733		.iotlb_sync_map = apple_dart_iotlb_sync_map,
>    734		.iova_to_phys = apple_dart_iova_to_phys,
>    735		.probe_device = apple_dart_probe_device,
>    736		.release_device = apple_dart_release_device,
>    737		.device_group = apple_dart_device_group,
>    738		.of_xlate = apple_dart_of_xlate,
>    739		.def_domain_type = apple_dart_def_domain_type,
>    740		.pgsize_bitmap = -1UL, /* Restricted during dart probe */
>    741	};
>    742	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> Attachments:
> * .config.gz


-- 
Sven Peter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
