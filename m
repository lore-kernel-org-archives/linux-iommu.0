Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF22CC433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 23:44:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A69760235
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 23:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A69760235
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 92CB52151E;
	Mon,  1 Feb 2021 23:44:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D80zOnBq37TG; Mon,  1 Feb 2021 23:44:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AFDBB2051C;
	Mon,  1 Feb 2021 23:44:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F0F7C0FA7;
	Mon,  1 Feb 2021 23:44:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83C46C013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 23:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 698DB8357C
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 23:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WGkOdtPM-MCO for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:44:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CF5B5834FE
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 23:44:26 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id c1so13740795qtc.1
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 15:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hd15FyljMQNb+uHNxQHOyHL+pJdt7H/rF6CqnCRNxkk=;
 b=k2UK7o8wQKpImEwvMcIofjhqZsF1yjn8WEus+jyV+wEKwNI6Pdakb/8qDqgA9xjczP
 2vPN1SEc50w2MpyQ7LD+ynXBrNS0ZUMPypuqH73q3LZlHiLudFcbUX2YEdbVreK9GYci
 hvcm6XoNqV/208cemLwAqA8+PAHjy3gR92TFTOvBBJo7+cm3ioe3aJ52NRp9dC77mPPw
 oDjDm0ZwCbl0N5JT1o7/W7KfF4QzaCcJx0mZ8QBXv8kRecO95ouX8OEHg3EnsSZjoY8b
 iZ3BuClJKbypxdM6+deF5MQjc1yclCNHXNUNBUtjO3Rt+RPjmfdltzBcWVgFq5Wf8gYo
 bQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hd15FyljMQNb+uHNxQHOyHL+pJdt7H/rF6CqnCRNxkk=;
 b=oOHWEDXlOqngmXzKee78rNkI7XJAgHfCmjnBnA2qBXtpn5CwZD3IPoSUmaMxWcI3+A
 rdU0TbkldbXUI2dFFINXDy37OIHpXPUsPhVf0DszI3v5Ri6JfyeDztZ4tzlcrsozjMj0
 o86Or6bu2p7aKjsdtTevvR5vetKDnUo4y3D6SqgXdpn01FM+tb5+uFSWHSFgxR7d5MDf
 /zjOw3erjPhsYemiVOHbfevTQySBD1V5vy0LayEzGo3LLegtzmY95JipWAuXUUi5yGaC
 NNbIUcaKKnsVSynoWUb0Yelsx0GWO8ZelT2MxEXZAFnFSQqBLcfWJwUdPFbdLBbR7L9P
 TICQ==
X-Gm-Message-State: AOAM533SBGf/470D3ugITaHA6KO8R8ePsG0rXAWgJXUsRKlInq+QKWVU
 YaWHHHq3eVHXbvx2jNFs4CtbMA==
X-Google-Smtp-Source: ABdhPJxOk/Gr3FI8hipqpO78EuQbpqBCvzEwZtZKwnaYmY8JYjMc8WYuBvCPpUv8lB3nlvifrKdI9g==
X-Received: by 2002:ac8:6c48:: with SMTP id z8mr17373676qtu.252.1612223065836; 
 Mon, 01 Feb 2021 15:44:25 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id p22sm15466415qkk.128.2021.02.01.15.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 15:44:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1l6iro-002MnI-P8; Mon, 01 Feb 2021 19:44:24 -0400
Date: Mon, 1 Feb 2021 19:44:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Message-ID: <20210201234424.GI4718@ziepe.ca>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
 <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: "chensihang \(A\)" <chensihang1@hisilicon.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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

On Fri, Jan 29, 2021 at 10:09:03AM +0000, Tian, Kevin wrote:
> > SVA is not doom to work with IO page fault only. If we have SVA+pin,
> > we would get both sharing address and stable I/O latency.
> 
> Isn't it like a traditional MAP_DMA API (imply pinning) plus specifying 
> cpu_va of the memory pool as the iova? 

I think their issue is the HW can't do the cpu_va trick without also
involving the system IOMMU in a SVA mode

It really is something that belongs under some general /dev/sva as we
talked on the vfio thread

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
