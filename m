Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF375C43381
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 13:34:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A12364F5E
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 13:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A12364F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4BA4286372;
	Tue,  2 Feb 2021 13:34:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4cXqh05FUStm; Tue,  2 Feb 2021 13:34:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B047C85656;
	Tue,  2 Feb 2021 13:34:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1955C0174;
	Tue,  2 Feb 2021 13:34:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF9E5C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 13:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 12F3B81FA0
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 13:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wM4bU8ySo4wX for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 13:34:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9056C81E21
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 13:34:05 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 521FC64F51;
 Tue,  2 Feb 2021 13:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612272845;
 bh=Qc82Rs1BO/kqAuHM5fqbYivehM9Zpe/q/Rk+nnanzSg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rq0QnvC6dVMTqTSjlBcM3j0Fae/zpps7YBL8rDHFtXiYCHsNkpgUTppGN6K4hqIrb
 edDS1gAiPwbetu6tWSl9Vta07jbjBtsbXymdYJVMz0BAFERuwrWqOoE8JEWlITWUym
 kSBu1Hvj7++Q3KhFAOn7GYFAJRobhWTnQzDhPpgPkDJBb2+vmwtgNEI1rTZfcDLk34
 uH8V0g7QGutVlEEhLHM96YbjM0IeXlx42/IDhP1pbBV96U0TPX8TeQz8BzqVldtr7O
 8bOnNEZUbb1tqrf/yES4UgRiBbNfflqqdQt3ypOMeBlaUFdtPWOuacG/CjCSQXYwjZ
 s0ZTqM/4rso+w==
Date: Tue, 2 Feb 2021 13:33:58 +0000
From: Will Deacon <will@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v6 00/33] MT8192 IOMMU support
Message-ID: <20210202133358.GA17070@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210201145422.GA15263@willie-the-truck>
 <1612231425.2524.12.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1612231425.2524.12.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Tue, Feb 02, 2021 at 10:03:45AM +0800, Yong Wu wrote:
> On Mon, 2021-02-01 at 14:54 +0000, Will Deacon wrote:
> > On Mon, Jan 11, 2021 at 07:18:41PM +0800, Yong Wu wrote:
> > > This patch mainly adds support for mt8192 Multimedia IOMMU and SMI.
> > > 
> > > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > > table format. The M4U-SMI HW diagram is as below:
> > > 
> > >                           EMI
> > >                            |
> > >                           M4U
> > >                            |
> > >                       ------------
> > >                        SMI Common
> > >                       ------------
> > >                            |
> > >   +-------+------+------+----------------------+-------+
> > >   |       |      |      |       ......         |       |
> > >   |       |      |      |                      |       |
> > > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > > disp0   disp1   mdp    vdec                   IPE      IPE
> > > 
> > > All the connections are HW fixed, SW can NOT adjust it.
> > > 
> > > Comparing with the preview SoC, this patchset mainly adds two new functions:
> > > a) add iova 34 bits support.
> > > b) add multi domains support since several HW has the special iova
> > > region requirement.
> > > 
> > > change note:
> > > v6:a) base on v5.11-rc1. and tlb v4:
> > >       https://lore.kernel.org/linux-mediatek/20210107122909.16317-1-yong.wu@mediatek.com/T/#t 
> > 
> > I've queued this up apart from patches 6 and 7.
> 
> Thanks very much for the applying. I'd like to show there is a little
> conflict with a smi change[1] in /include/soc/mediatek/smi.h.
> 
> This is the detailed conflict:
> 
> --- a/include/soc/mediatek/smi.h
> +++ b/include/soc/mediatek/smi.h
> @@ -9,7 +9,7 @@
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  
> -#ifdef CONFIG_MTK_SMI
> +#if IS_ENABLED(CONFIG_MTK_SMI)   <---The smi patch change here.
>  
>  #define MTK_LARB_NR_MAX   16  <---This iommu patchset delete this line.
> 
> 
> This code is simple. Please feel free to tell me how to do this if this
> is not convenient to merge.

Thanks, but this should be trivial to resolve, so I don't think we need to
worry about it.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
