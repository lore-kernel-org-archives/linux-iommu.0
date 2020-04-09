Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ABBC2BB55
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 14:25:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309C420771
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 14:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oMGThugx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309C420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DDE8124BB3;
	Thu,  9 Apr 2020 14:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id saNQi6Ndfbp1; Thu,  9 Apr 2020 14:25:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ADABC20009;
	Thu,  9 Apr 2020 14:25:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1A27C089F;
	Thu,  9 Apr 2020 14:25:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D48EBC0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 14:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BF39F86F9E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 14:25:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2MwMZWdivA+P for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 14:25:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 11F6C86EB2
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 14:25:21 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id s18so5570890qvn.1
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Wlx3aZDVPHXIXqqfehtYav0dozLPbgNKBjgQ2dqLKYM=;
 b=oMGThugx07VFsLObLoZP2pb6TFOEhv+z2fSLgvju/BQ5bzNLQwpD+ZoU4G1RtrOeaA
 02UNJAs07MsAH530zOqhz5XWDIRYxtYCvjrc4VO47c/hCbrmwnTBlkaNQrNI+smvYWM5
 dBTa8/6M/shP9kqzVFvc5MWN45S2IovwFZUYkM55jAIArYA5CHeZTod3QLHmNBFEqYbj
 c6vMZYxlxmLBa6lYx3BlwBgCzTJOhIm2WDRJByFEqbdGIfib3aD/rBNkv41MCdLgM20W
 ftJpeGy651xgHIkZQf4tK2xjt7gPUhwwEk+kCdJK8QtHJw9K1x+k2eSXUraahFxpwv46
 Q/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Wlx3aZDVPHXIXqqfehtYav0dozLPbgNKBjgQ2dqLKYM=;
 b=n/b4qH/Dfa7JDsbKw/u1Udo6c/CUi6nozXIVxIJVusashgUWgLHxOXnEz34A0DGF60
 olVEWVzjm270fIsk7QGEBaIRB4Oj+WRbZCYXFIhAt3rzuhIXe8bOjWpdKVCuHZQvCirO
 C/5t93ElhZm6SqMLCpmNRUmK8H0SAGtfupdNWQ+RUEvOJf2NV+nJb2Yv2ZOxbl6qhbl3
 4qshlFFVRVObCPX4WNg6RoaVHY6R8Wm04RolqSwkDRJeTQJVXP9NsiPa84xx4QhAFtM4
 3GRpU/1QUFsrtbIDIKaTp2TyJ106DbYVCbSXOcxflynNRrwIoAe6wSShourJFpcGHn8M
 Z27Q==
X-Gm-Message-State: AGi0PuYlyxDdJT+7ylScn5VMOr1ARQrYTl31pjYW0/OUs2KaLgRgJfLD
 PlP5he1urWnDluK4m4Zf6fsK8A==
X-Google-Smtp-Source: APiQypJRij+tpcX+OWL3WCYLrKZIJESsNNwGV++ms1oJ3xGqf4WBCPP9TwD+/PSSQEB/OpVcLYX2Fg==
X-Received: by 2002:a0c:e7ce:: with SMTP id c14mr295568qvo.100.1586442320120; 
 Thu, 09 Apr 2020 07:25:20 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id x17sm21227451qkb.87.2020.04.09.07.25.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 09 Apr 2020 07:25:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jMY7L-00034s-5O; Thu, 09 Apr 2020 11:25:19 -0300
Date: Thu, 9 Apr 2020 11:25:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200409142519.GH11886@ziepe.ca>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
 <20200408190226.GA11886@ziepe.ca>
 <20200408143552.57f5837c@jacob-builder>
 <20200408223218.GC11886@ziepe.ca>
 <20200408164802.155a69e3@jacob-builder>
 <20200409063905.GA2435@myrica>
 <20200409071424.1653b889@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200409071424.1653b889@jacob-builder>
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

On Thu, Apr 09, 2020 at 07:14:24AM -0700, Jacob Pan wrote:
> > When the process is killed, mm release can happen before fds are
> > released. If you look at do_exit() in kernel/exit.c:
> > 
> > 	exit_mm()
> > 	  mmput()
> > 	   -> mmu release notifier  
> > 	...
> > 	exit_files()
> > 	  close_files()
> > 	    fput()
> > 	exit_task_work()
> > 	  __fput()
> > 	   -> unbind()  
> > 
> So unbind is coming anyway, the difference in handling in mmu release
> notifier is whether we silently drop DMA fault vs. reporting fault?

Userspace can significantly delay the final fput triggering the
unbind, the above is only for the trivial case where the process
owning the mm_struct is the only process holding the fd.

The destruction of a mm_struct should be treated the same as unmapping
every vma in the process. The observable effect should be no different
than munmap.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
