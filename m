Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EEEC433E0
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 09:09:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB4820776
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 09:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB4820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A60F82072;
	Tue, 26 May 2020 09:09:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p5LSYjfh1CyF; Tue, 26 May 2020 09:09:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ACC3C8577A;
	Tue, 26 May 2020 09:09:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 815F3C0888;
	Tue, 26 May 2020 09:09:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C53CC016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 09:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6F55885F50
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 09:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6uvz3KsgJQX7 for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 09:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 955A885F15
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 09:09:05 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id c3so15364145wru.12
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 02:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mKd3JTZJplU94QhSKbd/esureWVCaIfQr3MBhsFOydU=;
 b=uHawcrZ+olrio5JDmIr/B8ozclX57tO90dnhhW5Zk77CFz2dhN5+FHfJeb/CNo4MA5
 J3QM0WG3IW669omDLVUDSOh/oJ+FS75ivo+iqe2K6lGtR8bks3Z5qnwRJGVPlkzeACNe
 HncpEVvEkCuyg9QACgVuM+bs83++CgWGohCKNNbr/nSL32W3xLc5aOsX3G0QxJYqTwlq
 u0TDapSlAjnU3Q7rJ4bEr4Qrmk2X1qLfO39DTRfVkFESddKwZJQhPDSIDxMbU2n1GWsQ
 1YlIPnoUEbWB+wfYZaOfhdXkG2YZM5LffTkBITk3+w3y08JtLlW6Mi7Z4lpxCvbIwsqf
 /z7w==
X-Gm-Message-State: AOAM530NAzO96aSUVLO8KknZJG+yGZBgZRyd81MEJgVbHIK5CopNdSW0
 5Q/kM8GJOSo9deQD3B82tUY=
X-Google-Smtp-Source: ABdhPJzPzLK8j+Jjs7Zi3RaE1b1BwpiXzaWJ/jf4rjIE+RvGFP9AEm4LkOXcV313giaSc3ZJ2hBKvw==
X-Received: by 2002:adf:f702:: with SMTP id r2mr19812123wrp.191.1590484144074; 
 Tue, 26 May 2020 02:09:04 -0700 (PDT)
Received: from debian (82.149.115.87.dyn.plus.net. [87.115.149.82])
 by smtp.gmail.com with ESMTPSA id n17sm20446723wrr.42.2020.05.26.02.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 02:09:03 -0700 (PDT)
Date: Tue, 26 May 2020 10:09:01 +0100
From: Wei Liu <wei.liu@kernel.org>
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH 1/2] iommu/hyper-v: Constify hyperv_ir_domain_ops
Message-ID: <20200526090901.xuzobaw2v4lapfdc@debian>
References: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
 <20200525214958.30015-2-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200525214958.30015-2-rikard.falkeborn@gmail.com>
User-Agent: NeoMutt/20180716
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
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

On Mon, May 25, 2020 at 11:49:57PM +0200, Rikard Falkeborn wrote:
> The struct hyperv_ir_domain_ops is not modified and can be made const to
> allow the compiler to put it in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>    2916    1180    1120    5216    1460 drivers/iommu/hyperv-iommu.o
> 
> After:
>    text    data     bss     dec     hex filename
>    3044    1052    1120    5216    1460 drivers/iommu/hyperv-iommu.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

> ---
>  drivers/iommu/hyperv-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index a386b83e0e34..3c0c67a99c7b 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -131,7 +131,7 @@ static int hyperv_irq_remapping_activate(struct irq_domain *domain,
>  	return 0;
>  }
>  
> -static struct irq_domain_ops hyperv_ir_domain_ops = {
> +static const struct irq_domain_ops hyperv_ir_domain_ops = {
>  	.alloc = hyperv_irq_remapping_alloc,
>  	.free = hyperv_irq_remapping_free,
>  	.activate = hyperv_irq_remapping_activate,
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
