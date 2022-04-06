Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ACCC433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 21:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B68E60AEC;
	Wed,  6 Apr 2022 21:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AyqpBfWKX9zQ; Wed,  6 Apr 2022 21:53:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 482DE607E3;
	Wed,  6 Apr 2022 21:53:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AFD8C001D;
	Wed,  6 Apr 2022 21:53:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9863C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 21:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AFD5040192
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 21:53:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T7jtBqcTwZhJ for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 21:53:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD77740017
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 21:53:41 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 ch16-20020a17090af41000b001ca867ef52bso5115513pjb.0
 for <iommu@lists.linux-foundation.org>; Wed, 06 Apr 2022 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/t0ovIQiUOSTuPx9jgrpi/PzvlKilbnhNLqfgQvkTNs=;
 b=QL0b/ugDp7rEfToKioRS6zaw7qMCtRzhXcx97rQeoYhDmLHwlXGgRRpH9/kMshrhwz
 ZvfKDIfCfddTINqz3Ut1ZA5+lG4dH51YXHRcB685tp/LLFVd+aL6aDHRAaXBXeaP6ANW
 4wa9+Hz52fWdDsWuwwvC2oYNMX47hWa75bcMo1oNuFEnf2Q+saFIXZmUZ5kOGRfNhDI2
 VqFM4m5yVogBKZQfMTG0q4TTzLkFv0CfYmaikSIzrQwO3FFMv665RR+Woci08izfo7pg
 zKIWsGtKJoQaGHwZlbiuouHhnmLo+dBwCFunJka+1riOfe31SJ/hXerOQsM4QBAwMxpQ
 u3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/t0ovIQiUOSTuPx9jgrpi/PzvlKilbnhNLqfgQvkTNs=;
 b=xnuwqML4B7JNFygPboWQvfL4I0fIfEakzviYfOlpuWHof6oXluV4t8k/W/kdnd2du0
 CAw+eVuUYM7xJAor0ADXC4euX2dAd6Ib9vSrxbY6dJckK2kRvOa/hZemuDvtkPZKwtp3
 NMlNnuXuJR+ZFYYhCnqsvKkAC2FJy+kECxn2S6CmJx1n9sSXE6GT2SdmJ8bnTKUOdV3E
 Mt5p339MaakUu3e1safW+rzLPMp5GDL0V8ztl/bMmwyYeMk+5jTDOgoAxnVTpsPuTQAS
 L8jbF0XLpidq0qNmWZkrW07uHEOCoi828V90HhEdpKTVSPjiehLFaNlnR7TW5CKvJfj8
 Mk6w==
X-Gm-Message-State: AOAM531TJwRDwXzrxKQgtIx5QcxA2Crbxe9ByRqaJhbAtedeNqg2Vuz6
 nOGMTie9fdBmvhBi2tZ9ombDpQ==
X-Google-Smtp-Source: ABdhPJzpSTHlVf5liK/Coh3Y8gHE/AVi3LRJciJq/cTWPnnJs2IFkVnqTH+/PxB+ksKiO4u5dnoncQ==
X-Received: by 2002:a17:903:246:b0:153:87f0:a93e with SMTP id
 j6-20020a170903024600b0015387f0a93emr10696792plh.171.1649282021257; 
 Wed, 06 Apr 2022 14:53:41 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26]) by smtp.gmail.com with ESMTPSA id
 z7-20020a056a00240700b004e1cde37bc1sm20683081pfh.84.2022.04.06.14.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Apr 2022 14:53:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1ncDas-00DxdY-9t; Wed, 06 Apr 2022 18:53:38 -0300
Date: Wed, 6 Apr 2022 18:53:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] RDMA/usnic: Refactor usnic_uiom_alloc_pd()
Message-ID: <20220406215338.GU64706@ziepe.ca>
References: <ef607cb3f5a09920b86971b8c8e60af8c647457e.1649169359.git.robin.murphy@arm.com>
 <202204070316.vOzwORw5-lkp@intel.com>
 <87075d61-c51c-8d94-9263-17aa40f7d70e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87075d61-c51c-8d94-9263-17aa40f7d70e@arm.com>
Cc: neescoba@cisco.com, kbuild-all@lists.01.org,
 kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 benve@cisco.com
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

On Wed, Apr 06, 2022 at 10:39:47PM +0100, Robin Murphy wrote:
> On 2022-04-06 20:54, kernel test robot wrote:
> > Hi Robin,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on rdma/for-next]
> > [also build test ERROR on v5.18-rc1 next-20220406]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> 
> Oops, I failed to notice that this does actually depend on the other patch I
> sent cleaning up iommu_present()[1] - I should have sent them together as a
> series, sorry about that.

No worries, I'll take care to order it right

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
