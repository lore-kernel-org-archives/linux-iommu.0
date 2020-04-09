Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F16C2BB55
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 12:12:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4314120771
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 12:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oAnfmA1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4314120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3535387ADB;
	Thu,  9 Apr 2020 12:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tAaw8aUJgd8V; Thu,  9 Apr 2020 12:12:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9DDA0877AE;
	Thu,  9 Apr 2020 12:12:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84449C089F;
	Thu,  9 Apr 2020 12:12:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88065C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 12:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7DCBD81F4D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 12:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-5kvkbZO8fF for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 12:12:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C22CB81F2C
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 12:12:31 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id g74so3578445qke.13
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eQglJxMmvdzqfQWZt43CM8v64Xs2BBDelCw8fh6zOi4=;
 b=oAnfmA1DrbHR3zDSoVidNJj4pYZTE+ELZFpL0v4TrJkuP/KJHSZamSQDlWPBig163o
 6vmOTDnhw2LoiPG7/9GIXLhSjE8gpCqyvF0eU8bTqM6niIBX5QnzX26pm5m1Ec9eWvrw
 juU9w25c0WMDGvlQae7dIwy3sLKPRgeWxZoFfVD6u0iF19/2EdxT/O6UPILvelvy++1b
 ixdLvr2LE9a8/QxidRrz/OFDuMM76/A1yS0gJLe4ONfrB511xDxH7kr/DhdlS/35S1C6
 sqqmxPZh/5T5L4cWPv+f3gPwy+9m5mxwu0j8j9ed5ANMG07vqStlUqBN+9+yJ9MNHSnD
 mLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eQglJxMmvdzqfQWZt43CM8v64Xs2BBDelCw8fh6zOi4=;
 b=HJXREKNQu6F2uGHOACHa76jrNBSr6nlA7GjxmB5baXCKvx3LzGo2X5qsIpef4+sH30
 +CO2iOmjY5ur3D9M2Kkbay90ct5JF6aOO0lpZdpB3QUdpwfPIjJVleky2INshxsSnKNT
 oJB/jcLKrZ/dExaUIZz9YWuN5i3jXja1qYxtNjO9Djq9rauYd+GIyqMRqzER1Lb+Bzye
 p7IfgHAuXR5GWXvHrlCgH624GaotUBrgbWqztcCHgmAUp1iWSfWN58DIfov180WXTS5n
 PVz0bqOBZkTvFBdajvfw6Yo+iuwNIWJGdySHy164VNXWDtYdVACr98z9FWfihTT1FDwQ
 x0vg==
X-Gm-Message-State: AGi0PuYS+Joj4H+iCdIatgUugTXdpeNCd96kDMg9ZN+9DkVy7NBgwVGA
 7XAeRUfW7Sc4n80K4ut28E7XVA==
X-Google-Smtp-Source: APiQypJ2135NWZbiqrPA/mxEBmjLSSFmQE1kcv8RCc0NXkKYIyzjATq9BXqgXyiTxBW+jknoUx7Yjw==
X-Received: by 2002:a05:620a:1011:: with SMTP id
 z17mr12690772qkj.142.1586434350791; 
 Thu, 09 Apr 2020 05:12:30 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id k43sm368368qtk.67.2020.04.09.05.12.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 09 Apr 2020 05:12:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jMW2n-0008E5-KG; Thu, 09 Apr 2020 09:12:29 -0300
Date: Thu, 9 Apr 2020 09:12:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200409121229.GF11886@ziepe.ca>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
 <20200408190226.GA11886@ziepe.ca>
 <20200408143552.57f5837c@jacob-builder>
 <20200408223218.GC11886@ziepe.ca>
 <20200408234901.GA209499@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408234901.GA209499@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, arnd@arndb.de,
 gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, linux-accelerators@lists.ozlabs.org
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

On Wed, Apr 08, 2020 at 04:49:01PM -0700, Fenghua Yu wrote:

> > > Isn't the idea of mmu_notifier is to avoid holding the mm reference and
> > > rely on the notifier to tell us when mm is going away?
> > 
> > The notifier only holds a mmgrab(), not a mmget() - this allows
> > exit_mmap to proceed, but the mm_struct memory remains.
> > 
> > This is also probably why it is a bad idea to tie the lifetime of
> > something like a pasid to the mmdrop as a evil user could cause a
> > large number of mm structs to be released but not freed, probably
> > defeating cgroup limits and so forth (not sure)
> 
> The max number of processes can be limited for a user. PASID is per
> address space so the max number of PASID can be limited for the user.
> So the user cannot exhaust PASID so easily, right?

With the patch Jacob pointed to the PASID lifetime is tied to mmdrop,
and I think (but did not check) that the cgroup accounting happens
before mmdrop.

> Binding the PASID to the mm and freeing the PASID in __mmdrop() can get
> ride of the complexity.

This is a much more reasonable explanation and should be in the patch
commit instead of what is there.

However, it still seems unnecessary to reach for arch code - the
singleton notifier can be arranged to live until exit_mmap or fd
release, whichever is longer by putting a mmu_notififer_put() in the
release() method

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
