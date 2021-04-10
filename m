Return-Path: <SRS0=3YoF=JH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878E9C433ED
	for <iommu@archiver.kernel.org>; Sat, 10 Apr 2021 23:50:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70DC610C8
	for <iommu@archiver.kernel.org>; Sat, 10 Apr 2021 23:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70DC610C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86464403CE;
	Sat, 10 Apr 2021 23:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rdXrlBJt7tiy; Sat, 10 Apr 2021 23:50:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E94B403CA;
	Sat, 10 Apr 2021 23:50:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C551CC000B;
	Sat, 10 Apr 2021 23:50:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 814B9C000A
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 23:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6158A6063B
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 23:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XNphVk7QPL0R for <iommu@lists.linux-foundation.org>;
 Sat, 10 Apr 2021 23:50:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBB67605FA
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=ImmH4my3bHskVbDwy22MNIevC3JZsdugYTzI/EryWkY=; b=aR70jOycvNYFuV3tcZOk7DKHNV
 wwdlXd86iX0i7Dv4V81aWvKYteZk/MeMjLynkhLvjrXt3BTKk0BhyYN7PXzX0l6NX/NHwqtCx+EGe
 2pObU6rHjWf+xepnPo8orlZIISsbSszsp9wIGauULGChfa8owXWceYyprrwIvGHwAc0rpnG9svFon
 G44UhroOekVI4z3OzypDxyS5zW1To35PbppALbOEP/ThoGonzb9Z1BdRVYsoHRCAHAfzzjtZDsyZk
 jEfWFLWOPIV9fhM0L6UIAVf0FlSh4wczWKL3QXA+Byp4+r9HLg1Ylptj89O40GaFOMr5jyeEjjO5U
 bm1fQlPA==;
Received: from [2601:1c0:6280:3f0::e0e1]
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lVNMu-002HrR-Cl; Sat, 10 Apr 2021 23:50:36 +0000
Subject: Re: linux-next: Tree for Apr 9 (drivers/iommu/intel/pasid.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210409215103.03999588@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7fbf0e6e-bd63-d370-7d22-eafc2ed81ad2@infradead.org>
Date: Sat, 10 Apr 2021 16:50:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210409215103.03999588@canb.auug.org.au>
Content-Language: en-US
Cc: David Woodhouse <dwmw2@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/9/21 4:51 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20210408:
> 
> New trees: iio, iio-fixes
> 

on ia64: (not X86)

(from a 01.org kernel config file)


../drivers/iommu/intel/pasid.c: In function 'pasid_enable_wpe':
../drivers/iommu/intel/pasid.c:554:22: error: implicit declaration of function 'read_cr0' [-Werror=implicit-function-declaration]
  554 |  unsigned long cr0 = read_cr0();
      |                      ^~~~~~~~
In file included from ../include/linux/build_bug.h:5,
                 from ../include/linux/bits.h:22,
                 from ../include/linux/bitops.h:6,
                 from ../drivers/iommu/intel/pasid.c:12:
../drivers/iommu/intel/pasid.c:557:23: error: 'X86_CR0_WP' undeclared (first use in this function)
  557 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
      |                       ^~~~~~~~~~
../include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
   78 | # define unlikely(x) __builtin_expect(!!(x), 0)
      |                                          ^
../drivers/iommu/intel/pasid.c:557:23: note: each undeclared identifier is reported only once for each function it appears in
  557 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
      |                       ^~~~~~~~~~
../include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
   78 | # define unlikely(x) __builtin_expect(!!(x), 0)
      |                                          ^



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
