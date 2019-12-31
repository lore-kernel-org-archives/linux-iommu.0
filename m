Return-Path: <SRS0=RkdD=2V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BA5C2D0CE
	for <iommu@archiver.kernel.org>; Tue, 31 Dec 2019 08:07:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8EE206DA
	for <iommu@archiver.kernel.org>; Tue, 31 Dec 2019 08:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8EE206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5802F2046C;
	Tue, 31 Dec 2019 08:07:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SzIv-XvltU19; Tue, 31 Dec 2019 08:07:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1BDCC20015;
	Tue, 31 Dec 2019 08:07:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 011BCC1D81;
	Tue, 31 Dec 2019 08:07:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68451C077D
 for <iommu@lists.linux-foundation.org>; Tue, 31 Dec 2019 08:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5C5F6847F3
 for <iommu@lists.linux-foundation.org>; Tue, 31 Dec 2019 08:07:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FYxwN0nJS3TX for <iommu@lists.linux-foundation.org>;
 Tue, 31 Dec 2019 08:07:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 48D21824FC
 for <iommu@lists.linux-foundation.org>; Tue, 31 Dec 2019 08:07:27 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id dc19so34693329edb.10
 for <iommu@lists.linux-foundation.org>; Tue, 31 Dec 2019 00:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bGuUl/aBL2OgivOMmQPi9elv22h6HOh655j0TjOw9KI=;
 b=epNPKIdjDfl16HtCwuKGauY1VFRvAc2BqVlE2AkfRypylNZvAJg5mmRI+2WyA4S3i3
 PwKk9LXp1tTyBJr7FgaCaPPK66ixoosy4qesB+BUf9dgwRjdWEysHbaLBHeju7/0prWe
 eVsONoeML88p0GHZPuzgNUNWLZvPHA1q3sSyX7pnyneIk6WfD1gD6itmCsXoP4Zo0hJh
 2ZXv4UoVjW2vYQvZsY6zQ8Hv5zEzLvlwi+65bFZoqgnX1lMmZe/3zsdw0IKmHXqKh/7L
 +dEtrEVEmCfHSmBL6QB4OEKXvvWH0MNKmW9yPXhwnDEnis84fBITFVzyUYNbo//bHW56
 G1Pw==
X-Gm-Message-State: APjAAAVG1jRFyi3EP84yOCaiuz0Sh7e6cu993EW09bJtCYTmNXC/kEHj
 XT5ex7oceDm1CmIwVkN+PHdIY+Jj
X-Google-Smtp-Source: APXvYqyUAj8bK+pKQYVDqB5++Bf/GRvlOmPn+lZAb7XKAKfKly/WHhtd4ywRHtqTB+Dy6Q87e8va7w==
X-Received: by 2002:a17:906:ed1:: with SMTP id
 u17mr74859457eji.286.1577779645556; 
 Tue, 31 Dec 2019 00:07:25 -0800 (PST)
Received: from pi3 ([194.230.155.138])
 by smtp.googlemail.com with ESMTPSA id dh4sm5818294edb.77.2019.12.31.00.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2019 00:07:24 -0800 (PST)
Date: Tue, 31 Dec 2019 09:07:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] iommu: Enable compile testing for some of drivers
Message-ID: <20191231080722.GA6804@pi3>
References: <20191230172619.17814-3-krzk@kernel.org>
 <201912311551.tBrb3BhH%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201912311551.tBrb3BhH%lkp@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kbuild-all@lists.01.org,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Dec 31, 2019 at 03:43:39PM +0800, kbuild test robot wrote:
> Hi Krzysztof,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on iommu/next]
> [also build test WARNING on v5.5-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/iommu-omap-Fix-pointer-cast-Wpointer-to-int-cast-warnings-on-64-bit/20191231-022212
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

I saw it already while compile testing my patch. I must admit that I
could not find easy/fast fix for it.  Probably the
omap_iommu_translate() helper should be made 64-bit friendly but this
obfuscates the code. The driver and hardware supports only 32-bit addresses.

Best regards,
Krzysztof


> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/iommu/omap-iommu.c:33:0:
>    drivers/iommu/omap-iommu.c: In function 'omap_iommu_iova_to_phys':
> >> drivers/iommu/omap-iopgtable.h:44:21: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>     #define IOPTE_MASK  (~(IOPTE_SIZE - 1))
>                         ^
> >> drivers/iommu/omap-iommu.c:1641:41: note: in expansion of macro 'IOPTE_MASK'
>        ret = omap_iommu_translate(*pte, da, IOPTE_MASK);
>                                             ^~~~~~~~~~
>    drivers/iommu/omap-iopgtable.h:51:23: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>     #define IOLARGE_MASK  (~(IOLARGE_SIZE - 1))
>                           ^
> >> drivers/iommu/omap-iommu.c:1643:41: note: in expansion of macro 'IOLARGE_MASK'
>        ret = omap_iommu_translate(*pte, da, IOLARGE_MASK);
>                                             ^~~~~~~~~~~~
>    drivers/iommu/omap-iopgtable.h:27:25: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>     #define IOSECTION_MASK  (~(IOSECTION_SIZE - 1))
>                             ^
> >> drivers/iommu/omap-iommu.c:1649:41: note: in expansion of macro 'IOSECTION_MASK'
>        ret = omap_iommu_translate(*pgd, da, IOSECTION_MASK);
>                                             ^~~~~~~~~~~~~~
>    drivers/iommu/omap-iopgtable.h:34:23: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>     #define IOSUPER_MASK  (~(IOSUPER_SIZE - 1))
>                           ^
> >> drivers/iommu/omap-iommu.c:1651:41: note: in expansion of macro 'IOSUPER_MASK'
>        ret = omap_iommu_translate(*pgd, da, IOSUPER_MASK);
>                                             ^~~~~~~~~~~~
> 
> vim +44 drivers/iommu/omap-iopgtable.h
> 
> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  38  
> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  39  /*
> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  40   * "small page" address mask and size definitions.
> 97ec7d585b33bb arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2010-02-15  41   */
> a9dcad5e375800 arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2009-01-26  42  #define IOPTE_SHIFT		12
> 5ff98fa68c88d7 drivers/iommu/omap-iopgtable.h Suman Anna   2015-07-20  43  #define IOPTE_SIZE		BIT(IOPTE_SHIFT)
> a9dcad5e375800 arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2009-01-26 @44  #define IOPTE_MASK		(~(IOPTE_SIZE - 1))
> a9dcad5e375800 arch/arm/plat-omap/iopgtable.h Hiroshi DOYU 2009-01-26  45  
> 
> :::::: The code at line 44 was first introduced by commit
> :::::: a9dcad5e375800fcb07f7617dba23b3aade8f09d omap iommu: tlb and pagetable primitives
> 
> :::::: TO: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> :::::: CC: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
