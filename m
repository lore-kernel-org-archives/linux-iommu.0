Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91F5C2BA19
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 16:59:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C28320753
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 16:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MOv2PoC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C28320753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3FDB58487A;
	Thu,  9 Apr 2020 16:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1PXB9YLmahoz; Thu,  9 Apr 2020 16:59:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AE6BE84775;
	Thu,  9 Apr 2020 16:59:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85337C089F;
	Thu,  9 Apr 2020 16:59:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17D1AC0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0F55783883
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:59:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XXN2VeFjLfnF for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 16:59:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5A4C9833C6
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:59:00 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id 13so4658590qko.10
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lGCw3VJLJccp/WZbCXgDk7u0LJCEp+ZXTszR32Hza70=;
 b=MOv2PoC5YnPLf/YstgOgGs1EkmllEwiOJdrsiJtLPEBTcTC/rCDzeMULZ8W+MQS+xn
 X50FFPnispfbOX2Cw5z/04nPDNipBFNp5BHUgfm1rzyc76zxxo0y7SmI8lIua0G8Kiap
 tSDsjASpWyYdgtS8mIPdvO2vrEGnSXZZbMRn3x0FTCOHNW+qO8bKr4CYFNCv1Bc9ok8N
 S4Ckox+y1F2+4bN+ibFa4vqfnb7A29oxq7W0k8q7zFhzPKJzijoiXrB5/888dPJyp4u+
 F62BaOYXkQfKh2MtQGL/ensP6NyUSYBWWtqdjM7KAzj0mHGIdbCHxgT7Mm+U9iahdxXY
 MaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lGCw3VJLJccp/WZbCXgDk7u0LJCEp+ZXTszR32Hza70=;
 b=YGkausv8XM+p7zDc68Ob3q0KPAMJCELOtJCvKOn2dvh4qhPvRlI2/0OTI8JnVKHkg5
 KhN8RXPFhWyTiapYqNpJ3p6XS5Ykq0NeTORBIEL0Go6hgvlzt2Hh2a4LUD3hHgZu/gBS
 brt8CV6YcMbcMNJ1taNNUZdpBEN/iSHEaundBT40IktwkW0BkTnxhW2z4NvW325e0/OK
 Yc9OAIvxFiyA6+RyHLQtELuFniYyTKCnhvd9q8Jtf4tz+SY8SKELFLfIReOFoVhaSlaT
 dq8h2+C2o1HvHhe6Z3aTIucxg3W1q/+zBjOOojJglBoi8HmrkpA65sITWxlPluwyvV64
 VWmA==
X-Gm-Message-State: AGi0PuZqIDX7QO8BQUIese0SX5T+gflwVHQaTYk1tzlInC1KWDpptZCe
 cV3HaXAsmjUnme1hs0cceE4tbA==
X-Google-Smtp-Source: APiQypI02ehuK5Rc+UbsKY6UIXeMiSvAmpUUsms1cpHW8GsVeNZwrIMirzRBfSwLhtjvCrbvs5p9oQ==
X-Received: by 2002:a05:620a:47:: with SMTP id t7mr775712qkt.153.1586451539347; 
 Thu, 09 Apr 2020 09:58:59 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id u65sm21841893qkh.100.2020.04.09.09.58.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 09 Apr 2020 09:58:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jMaW2-0002wu-AN; Thu, 09 Apr 2020 13:58:58 -0300
Date: Thu, 9 Apr 2020 13:58:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200409165858.GI11886@ziepe.ca>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
 <20200408190226.GA11886@ziepe.ca>
 <20200408143552.57f5837c@jacob-builder>
 <20200408223218.GC11886@ziepe.ca>
 <20200408164802.155a69e3@jacob-builder>
 <20200409063905.GA2435@myrica>
 <20200409071424.1653b889@jacob-builder>
 <20200409142519.GH11886@ziepe.ca>
 <20200409092134.0c427b95@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200409092134.0c427b95@jacob-builder>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, arnd@arndb.de, "Yu,
 Fenghua" <fenghua.yu@intel.com>, gregkh@linuxfoundation.org,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 linux-accelerators@lists.ozlabs.org
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

On Thu, Apr 09, 2020 at 09:21:34AM -0700, Jacob Pan wrote:
> On Thu, 9 Apr 2020 11:25:19 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Thu, Apr 09, 2020 at 07:14:24AM -0700, Jacob Pan wrote:
> > > > When the process is killed, mm release can happen before fds are
> > > > released. If you look at do_exit() in kernel/exit.c:
> > > > 
> > > > 	exit_mm()
> > > > 	  mmput()  
> > > > 	   -> mmu release notifier    
> > > > 	...
> > > > 	exit_files()
> > > > 	  close_files()
> > > > 	    fput()
> > > > 	exit_task_work()
> > > > 	  __fput()  
> > > > 	   -> unbind()    
> > > >   
> > > So unbind is coming anyway, the difference in handling in mmu
> > > release notifier is whether we silently drop DMA fault vs.
> > > reporting fault?  
> > 
> > Userspace can significantly delay the final fput triggering the
> > unbind, the above is only for the trivial case where the process
> > owning the mm_struct is the only process holding the fd.
> > 
> Are you talking about FDs owned buy children after fork() or FDs sent
> over to another process. I think, in either case SVA is not supported.

Supported or not a hostile user space can trigger these conditions and
it should not cause misbehavior from the kernel (eg log spamming)

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
