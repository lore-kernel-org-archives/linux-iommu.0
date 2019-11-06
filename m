Return-Path: <SRS0=/wjm=Y6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C1FC6194
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 23:40:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C9C207FA
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 23:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C9C207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 99424CDD;
	Wed,  6 Nov 2019 23:40:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 25A49CC8
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 23:40:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
	[209.85.167.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C01AA196
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 23:40:28 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id v138so310639oif.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 06 Nov 2019 15:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=F9+XxF3bme0TDxNV87CvWxfYp74g7+cBn1OYi++I3PY=;
	b=Zc1Sv/YKr7zvIFTXGsYuhKEKQxNIHwQAQ4INSsRCLxTxc0hxPqybpNgzXnUwG+2PZO
	d9zI9AMo6YsCff5bhhXPWX9gDn1IdHu9sap1Y4e6+7Wnj+kRX/qeMzjiomUoQXe0Z2Ll
	z8XdJVV+XvAY9q7PRufCYhsAu3gzdj9NpH9NghwmucSbvVouInwtd9ywWYHQ8+KwW0zA
	Qj7Qnv9MDoUQGVJ4wZctEKAgIKBEGnTAAA2uUQC/5UzRwW0RR3+PGohGXEYXHqv5Eq4C
	9FCvYszGF5NtCHrGac5folIavHKBa3fK8UMJfNnk7y8Xa+wjx9Hp+nhEXs4h9tKQEFhK
	nD2Q==
X-Gm-Message-State: APjAAAXrYyXPsQrM8gZXyV6jXFH/cpe0rqkUL94StyGCnQFiL4c4c1HW
	yi5gAI6cCzV5QIVSFsAMdg==
X-Google-Smtp-Source: APXvYqySo4f8qKaS3Uh1xjvS4bwqGL+HLtxodI5d2sqmKN62Uk9p/GW8ZMzcEf/idpRcKBR9Z7JIMA==
X-Received: by 2002:a05:6808:3b1:: with SMTP id
	n17mr565821oie.50.1573083627798; 
	Wed, 06 Nov 2019 15:40:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
	[24.155.109.49])
	by smtp.gmail.com with ESMTPSA id u4sm140222otb.35.2019.11.06.15.40.26
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 06 Nov 2019 15:40:26 -0800 (PST)
Date: Wed, 6 Nov 2019 17:40:20 -0600
From: Rob Herring <robh@kernel.org>
To: Chao Hao <chao.hao@mediatek.com>
Subject: Re: [RESEND,PATCH 01/13] dt-bindings: mediatek: Add bindings for
	MT6779
Message-ID: <20191106234020.GA19463@bogus>
References: <20191104115238.2394-1-chao.hao@mediatek.com>
	<20191104115238.2394-2-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104115238.2394-2-chao.hao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
	Cui Zhang <cui.zhang@mediatek.com>,
	Jun Yan <jun.yan@mediatek.com>, wsd_upstream@mediatek.com,
	linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
	iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
	Miles Chen <miles.chen@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Guangming Cao <guangming.cao@mediatek.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, 4 Nov 2019 19:52:26 +0800, Chao Hao wrote:
> This patch adds description for MT6779 IOMMU.
> 
> MT6779 has two iommus, they are MM_IOMMU and APU_IOMMU which
> use ARM Short-Descriptor translation format.
> 
> The MT6779 IOMMU hardware diagram is as below, it is only a brief
> diagram about iommu, it don't focus on the part of smi_larb, so
> I don't describe the smi_larb detailedly.
> 
> 			     EMI
> 			      |
> 	   --------------------------------------
> 	   |					|
>         MM_IOMMU                            APU_IOMMU
> 	   |					|
>        SMI_COMMOM-----------		     APU_BUS
>           |		   |			|
>     SMI_LARB(0~11)  SMI_LARB12(FAKE)	    SMI_LARB13(FAKE)
> 	  |		   |			|
> 	  |		   |		   --------------
> 	  |		   |		   |	 |	|
>    Multimedia engine	  CCU		  VPU   MDLA   EMDA
> 
> All the connections are hardware fixed, software can not adjust it.
> 
> >From the diagram above, MM_IOMMU provides mapping for multimedia engine,
> but CCU is connected with smi_common directly, we can take them as larb12.
> APU_IOMMU provides mapping for APU engine, we can take them larb13.
> Larb12 and Larb13 are fake larbs.
> 
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.txt         |   2 +
>  include/dt-bindings/memory/mt6779-larb-port.h | 217 ++++++++++++++++++
>  2 files changed, 219 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt6779-larb-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
