Return-Path: <SRS0=bJ3n=6P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09784C4724C
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 12:55:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EDB208D6
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 12:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Nq8HOg9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EDB208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9BEDF88677;
	Fri,  1 May 2020 12:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CBpoV-bacMSZ; Fri,  1 May 2020 12:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F28988673;
	Fri,  1 May 2020 12:55:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A6D6C0864;
	Fri,  1 May 2020 12:55:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE4A7C016F
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 12:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E875A8797C
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 12:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t8iklMahiDOR for <iommu@lists.linux-foundation.org>;
 Fri,  1 May 2020 12:55:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com
 [209.85.219.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AA0F387962
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 12:55:16 +0000 (UTC)
Received: by mail-qv1-f66.google.com with SMTP id v10so4671838qvr.2
 for <iommu@lists.linux-foundation.org>; Fri, 01 May 2020 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=P0z8kBnXrlZIDie1dLQeqogN9MwmVy7z4o7SA4TqzwU=;
 b=Nq8HOg9n7Z+VdnITQnbqqVABmWu3/6twaYJ7q1ZG6DqOfwLX2pqDKfEDSh+EIm/he8
 8XxNujX7EOvHA+Z3U42zDC/h9oN+aKWNxlISO0Rq2tTCVZNWNCIrJWk7sh2DWdjcVwvU
 wCvE4KNEgpOv+mKqLqLC6erVH6iCBHZ3nggeOEQIkaDvn7IPj2tAyOj9O8z6V4Qx2f1V
 20zcGw/GN8o0n+NfO/8kyZsltT7TcTtCKSej9x25s7Vy8ZXZSAEGpL08aolIMnLihAqM
 O4lVQbo50EUAWIw62edP+hXhKTif6IJbYSGaALf2LAPuTPfJPTwd2r2FjwrGZ5t7qGNY
 ydVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=P0z8kBnXrlZIDie1dLQeqogN9MwmVy7z4o7SA4TqzwU=;
 b=XjJCxQzl5s/u5PmgTzyFiAGU4wE0eHdidA6pXGg5SqbAUx33M4zav7jo5PzkUXmSY/
 IeuFoAXa17w58b01iLV7qZPK16ln9nnHROZejxQVPeJFir6hy7rLVa9Ebo7ah0Cw37IS
 fTb4L0P0fD1ZewFMyCna0g+KCyIzdpCEWQcW9IbGpag3JT80uT26wuTKqUuqRnWDiPlU
 vK1myS9ykIZKAZGzNF/mXyyodu4bTO2Xkhpfr9jaTwMRuqj/Hz2VTlQt3cFU4wDraRoC
 YyW3JqepocJvmwwDFEmBFZKFNBmSobsZztQ1R+QYv3LTVhMBHYihev2p4uK0+weNttT+
 OtqQ==
X-Gm-Message-State: AGi0PuZRuM1/z2xUprHWRPzn2T9E2+KoHZjMe5y4mji25AFUqC+axxjg
 TItbmFSRHpXDSRJ+DP9H+UqJNQ==
X-Google-Smtp-Source: APiQypJcH2wlws52fFFXitF6KkzvvmTMs6scpT5jXa1TBx4TcLMsA/h0u5FOFpvXuuZfcR/nYumjiA==
X-Received: by 2002:a05:6214:a4e:: with SMTP id
 ee14mr3877158qvb.121.1588337715542; 
 Fri, 01 May 2020 05:55:15 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id 28sm2645211qkp.10.2020.05.01.05.55.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 May 2020 05:55:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jUVCD-0007LO-33; Fri, 01 May 2020 09:55:13 -0300
Date: Fri, 1 May 2020 09:55:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 17/25] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20200501125513.GN26002@ziepe.ca>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-18-jean-philippe@linaro.org>
 <20200501121552.GA6012@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200501121552.GA6012@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 will@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 felix.kuehling@amd.com, fenghua.yu@intel.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, christian.koenig@amd.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, May 01, 2020 at 05:15:52AM -0700, Christoph Hellwig wrote:
> > @@ -432,6 +432,7 @@ config ARM_SMMU_V3
> >  	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> >  	depends on ARM64
> >  	select IOMMU_API
> > +	select IOMMU_SVA
> >  	select IOMMU_IO_PGTABLE_LPAE
> >  	select GENERIC_MSI_IRQ_DOMAIN
> 
> Doesn't this need to select MMU_NOTIFIER now?
> 
> > +	struct mmu_notifier_ops		mn_ops;
> 
> Note: not a pointer.
> 
> > +	/* If bind() was already called for this (dev, mm) pair, reuse it. */
> > +	list_for_each_entry(bond, &master->bonds, list) {
> > +		if (bond->mm == mm) {
> > +			refcount_inc(&bond->refs);
> > +			return &bond->sva;
> > +		}
> > +	}

I also would like it if searching for mms in linked lists was not
necessary, this is kind of the point of 'get'

Is this a side effect of the earlier remark to get rid of the linked
list inside the notifier?

> Or we could enhance the mmu_notifier_get to pass a private
> oaque instance ID pointer, which is checked in addition to the ops,
> and you could probably kill off the bonds list and lookup.

This might be the best option if it can absorb the above search..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
