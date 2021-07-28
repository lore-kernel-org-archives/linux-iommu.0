Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC562C4320A
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 09:51:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E79B603E7
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 09:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E79B603E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 171BB4042D;
	Thu, 29 Jul 2021 09:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lNOfhDwxuje1; Thu, 29 Jul 2021 09:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 861F740378;
	Thu, 29 Jul 2021 09:51:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57FD1C0010;
	Thu, 29 Jul 2021 09:51:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF996C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id AF8E7827BB
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id yrVAk49HtEYA for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 15:20:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id CDB5082695
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:20:49 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1627485654; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=NMBA6eMZ2++sBypZUxc6pdznV/MW5syE3FBstf0UH5I=;
 b=BFqPU2m2R0GQVlIJZVI6K/7QZNxnNuJSIP8x1G7QoFadzO8IG3HeieOaPr4HZUP5QWSLUOAM
 c8MF6WfPimB92MWX3OgXsnsRoRwnV66oB2LtYDPChx4wZV+W2fkcLQMR6H2Q5Aoa4loZrWqh
 VLO9L/sstCmL2+t9yk5EFdDeyr4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 610175c61dd16c8788c57f93 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Jul 2021 15:20:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id D2570C4323A; Wed, 28 Jul 2021 15:20:37 +0000 (UTC)
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: bcain)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CDC3C433D3;
 Wed, 28 Jul 2021 15:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CDC3C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=bcain@codeaurora.org
From: "Brian Cain" <bcain@codeaurora.org>
To: "'Christoph Hellwig'" <hch@lst.de>, <iommu@lists.linux-foundation.org>,
 "'Russell King'" <linux@armlinux.org.uk>
References: <20210712061704.4162464-1-hch@lst.de>
In-Reply-To: <20210712061704.4162464-1-hch@lst.de>
Subject: RE: add support for the global coherent pool to the dma core
Date: Wed, 28 Jul 2021 10:20:34 -0500
Message-ID: <03d501d783c4$1d3f10e0$57bd32a0$@codeaurora.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQGLBLs9KUWyWP2l5ibPYuIecai1XKvxfn8g
X-Mailman-Approved-At: Thu, 29 Jul 2021 09:51:07 +0000
Cc: 'Vladimir Murzin' <vladimir.murzin@arm.com>, "'Manning,
 Sid'" <sidneym@quicinc.com>, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, 'Dillon Min' <dillon.minfei@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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
Reply-To: bcain@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, July 12, 2021 1:17 AM
> To: iommu@lists.linux-foundation.org; Russell King
<linux@armlinux.org.uk>;
> Brian Cain <bcain@codeaurora.org>
> Cc: Dillon Min <dillon.minfei@gmail.com>; Vladimir Murzin
> <vladimir.murzin@arm.com>; linux-arm-kernel@lists.infradead.org; linux-
> hexagon@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: add support for the global coherent pool to the dma core
> 
> Hi all,
> 
> this series adds support for using the global coherent (aka uncached)
> pool to the generic dma-direct code and then switches arm-nommu and
> hexagon over to it, together with a bunch of cleanups.

Christoph,

Thanks for sending this -- I will take a look and give some feedback soon.

> Diffstat:
>  arch/arm/Kconfig                |    5 -
>  arch/arm/mm/dma-mapping-nommu.c |  173
+--------------------------------------
> -
>  arch/hexagon/Kconfig            |    1
>  arch/hexagon/kernel/dma.c       |   57 ++-----------
>  include/linux/dma-map-ops.h     |   18 ++--
>  kernel/dma/Kconfig              |    4
>  kernel/dma/coherent.c           |  159
+++++++++++++++++-------------------
>  kernel/dma/direct.c             |   15 +++
>  8 files changed, 124 insertions(+), 308 deletions(-)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
