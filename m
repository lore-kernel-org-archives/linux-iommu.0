Return-Path: <SRS0=vtxH=ET=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875FCC4742C
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 14:53:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C232222F
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 14:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C232222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C2FEF2E248;
	Fri, 13 Nov 2020 14:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i1OsdKhugbtR; Fri, 13 Nov 2020 14:53:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 702C9203D5;
	Fri, 13 Nov 2020 14:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53CFEC0FAA;
	Fri, 13 Nov 2020 14:53:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89536C088E;
 Fri, 13 Nov 2020 14:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 49D3A878C9;
 Fri, 13 Nov 2020 14:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GoCE+BUPKO4u; Fri, 13 Nov 2020 14:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4F007878C6;
 Fri, 13 Nov 2020 14:53:08 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id s8so10188796wrw.10;
 Fri, 13 Nov 2020 06:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=J3g1EmbPGYLgsVJyJusBp+ecz9drgGWXqp9ghw7oo04=;
 b=ucwVJ46TYFe5FakYXHYhOLTIEgD9muvDuLKseZ2INIc0GB8/cL0Y+WAeHw9gIE83Am
 1BHd95Vdpv0tD+ph2fLlvg8dsfYDyj+9kEy++QwP4P1h+jm2SEyxl4OimASNfzwgmXWe
 hC4f6vcgF3D4P3yndU1rNFREgrGc+25gnxUSqsXqUazNu4FCDQAa2ufbnuP0RgmyFpp/
 1BQvc+0A+FAwSA6AV8Xasz0+DYD81HVbIhDd6lU9z2BDwQ/uX6yVYpTCj6WDmWZJytwk
 q16bPsMA0cfZkWW1uQfm4dS2vTD2xHrB9lvopg5OKTe8SeCo9UbXKbOUnh4sB01TwbEF
 1U0A==
X-Gm-Message-State: AOAM530miraoANB/mmD6AMdO2VL6SQcYZFSiHe8XYS7qORYUi+xMXVKA
 KBw34mTNDale3v7k+fNqStM=
X-Google-Smtp-Source: ABdhPJzVhgHWH+ov3Hd5rUXZqXGqiSjFrXDw4D/7d7K8Q6VCR1SzDiuP4R19ZvbbTIhBSZZZ4eN/EA==
X-Received: by 2002:adf:804b:: with SMTP id 69mr3963167wrk.274.1605279186710; 
 Fri, 13 Nov 2020 06:53:06 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id a17sm12104587wra.61.2020.11.13.06.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 06:53:06 -0800 (PST)
Date: Fri, 13 Nov 2020 14:53:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2 04/17] iommu/hyperv: don't setup IRQ remapping when
 running as root
Message-ID: <20201113145304.37w3h6xi7fmhgcg6@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-5-wei.liu@kernel.org>
 <87ft5ey4rx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ft5ey4rx.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Joerg Roedel <jroedel@suse.de>, Stephen Hemminger <sthemmin@microsoft.com>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

On Thu, Nov 12, 2020 at 04:27:14PM +0100, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > The IOMMU code needs more work. We're sure for now the IRQ remapping
> > hooks are not applicable when Linux is the root.
> 
> Super-nitpick: I would suggest we always say 'root partition' as 'root'
> has a 'slightly different' meaning in Linux and this commit message may
> sound confusing to an unprepared reader.

Fixed.

> 
> >
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Acked-by: Joerg Roedel <jroedel@suse.de>
> > ---
> >  drivers/iommu/hyperv-iommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> > index e09e2d734c57..8d3ce3add57d 100644
> > --- a/drivers/iommu/hyperv-iommu.c
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -20,6 +20,7 @@
> >  #include <asm/io_apic.h>
> >  #include <asm/irq_remapping.h>
> >  #include <asm/hypervisor.h>
> > +#include <asm/mshyperv.h>
> >  
> >  #include "irq_remapping.h"
> >  
> > @@ -143,7 +144,7 @@ static int __init hyperv_prepare_irq_remapping(void)
> >  	int i;
> >  
> >  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> > -	    !x2apic_supported())
> > +	    !x2apic_supported() || hv_root_partition)
> >  		return -ENODEV;
> >  
> >  	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks.

Wei.

> 
> -- 
> Vitaly
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
