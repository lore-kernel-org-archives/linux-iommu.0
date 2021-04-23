Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E431C433ED
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 13:01:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A79261406
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 13:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A79261406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16BBA40618;
	Fri, 23 Apr 2021 13:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XpRfNdzaWQW4; Fri, 23 Apr 2021 13:01:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09C90400C1;
	Fri, 23 Apr 2021 13:01:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8BC4C000E;
	Fri, 23 Apr 2021 13:01:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5DE9C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 13:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A28B40435
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 13:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j3ji12DfTDv0 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 13:01:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 186FC40411
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 13:01:08 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id s15so57394831edd.4
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2rHamcAk69i1heErTD043nvHWdBaYcGMYqk0SxlLX3w=;
 b=AI4OF1eHAcLvyWD6iouxBu3wzPXbE7lqxD/nvUDlUK6sCGPvqEiURU18cQsgP60E9B
 79XpQibjTf/FlzQDqoN1m5Xox0apvDhFykYVGLADrOrtndSOh4jcTHehoSL6CP5+tm3A
 K0hA7VUPU7KcWWquu+KenypCJDq2PzLWPT13f3BEr3icJCOt6wvTHM2Vbdp3dw0p4ELx
 dJMs/UerJVfhV13oS+6JAVOptYzHzjOwPt3NZPtEdroHfd5ogVdtz78kjCWB/KMlKxrO
 UeVaHJ8m1HYcZ0RhK4C8RpAYQU5X1LCldsFsS/aQlKYGbqWoMuPE27tWoUwBkuhT49t9
 nruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2rHamcAk69i1heErTD043nvHWdBaYcGMYqk0SxlLX3w=;
 b=S/QKCZk1T2gDPuBY2tKpICEfFwO1EFno30w/rP3sUd7JijyM1Sc+0kFMnNz6lbTdez
 NuOiNlcW0B/ypFfm3icT0CTgy6KwYK5SIXZcdikW31395S8E8PPPtSMkPpYQNe8wZD1A
 BFJPNYykj7f/QO226n9ohnhjsc+wQgMsXv9/hMyZ3+V1XyR8jnZAb4cpuBRESaY6ndfJ
 dvAazpw4HxgP0o0Q6V3sItfq/V6lEdZCcngq4TCbqzPh5gGpmTX89+t0bBkYycT6zlCe
 jmTYteL8XP4gZU4wnFU6FltFQGnrxAJeML1SW9y068R4AsFMLwnwVMffC1hv0gieRLY8
 ew7A==
X-Gm-Message-State: AOAM530ciAd4pC8mtonlq6ZPydsSGspv16YfP5D3Iq9we/+/cNGulldp
 WnjdN1tJ4ITV46OlWor8uQW6PA==
X-Google-Smtp-Source: ABdhPJyDrw4UO6yanfUyRpsU9b8VpZWr1Al+SSF6+YcbsniqaahON/TAvV32FxXYlw+iumrp6+ExVg==
X-Received: by 2002:a05:6402:4d1:: with SMTP id
 n17mr4292611edw.118.1619182867214; 
 Fri, 23 Apr 2021 06:01:07 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id d14sm4537418edc.11.2021.04.23.06.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 06:01:06 -0700 (PDT)
Date: Fri, 23 Apr 2021 15:00:48 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>
Subject: Re: [PATCH v14 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
Message-ID: <YILFAJ50aqvkQaT/@myrica>
References: <f99d8af1-425b-f1d5-83db-20e32b856143@redhat.com>
 <1619103878-6664-1-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1619103878-6664-1-git-send-email-sumitg@nvidia.com>
Cc: wangxingang5@huawei.com, kvm@vger.kernel.org, lushenming@huawei.com,
 maz@kernel.org, jiangkunkun@huawei.com, will@kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 vsethi@nvidia.com, alex.williamson@redhat.com, vivek.gautam@arm.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
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

Hi Sumit,

On Thu, Apr 22, 2021 at 08:34:38PM +0530, Sumit Gupta wrote:
> Had to revert patch "mm: notify remote TLBs when dirtying a PTE".

Did that patch cause any issue, or is it just not needed on your system?
It fixes an hypothetical problem with the way ATS is implemented. Maybe I
actually observed it on an old software model, I don't remember. Either
way it's unlikely to go upstream but I'd like to know if I should drop it
from my tree.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
