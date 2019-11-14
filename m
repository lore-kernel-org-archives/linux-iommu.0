Return-Path: <SRS0=E0xS=ZG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B4AC43215
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 18:23:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7EA20709
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 18:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dq3qLRwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7EA20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF9B7DC0;
	Thu, 14 Nov 2019 18:23:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3F7C5DBB
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 18:23:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
	[209.85.160.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B57D6102
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 18:23:04 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id p20so7833853qtq.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 10:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=BZpbNyceFmO3/Vbl5Ka3YtEiXE22oq/IC6LtKtPgmrU=;
	b=Dq3qLRwfRX4oLpT6zzHD2JT6vC4q0PYGlWr76+9aT/JKXktJvg1MRaT4K0WJUbzYRJ
	lWUMxebFIwGE1BKukZM/ikNtESz5vUam+BhC494zdOl6KheSGyu2N+a4zHaUzUcpLzuM
	5xMVXXG+yeQc5/n5eGRbFYJNSDbTxFMqVOSY/JsiBebW/SQDTtCO4ho6gqipHqiNFzlD
	X0s1GooFdaXgQaVGDg2OkxhnfXvF2+1TcZp5b16rwvxo+K1dIfXWXA4W0DhTxuDoJM0E
	8VbRgIoRqWDFwNbDx6W7RAltLzWKXeJdjx3jP6gTSQD0he77PUuOy8kVdqWaCZAT+Dlm
	6TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=BZpbNyceFmO3/Vbl5Ka3YtEiXE22oq/IC6LtKtPgmrU=;
	b=DZOVSR1t1Mdp0PQMttr6+3pFGjbgL1Jz39oIwRlIWAvnxgXp0bABH2ArNtng8Gh+Dj
	sOst4Jot7l0jBDMqgOWqsampB4faG2DALgxPiE0UxBfAqNhRZOGi8b/bhsItnxZqd3jn
	+OZdZUFWVL2J6i9IWzJ8JPNIP06efFtabo50rh5CGkjV1yEuCXWBUOjF4lEHRQdPnqN8
	nRu2PBMy80Kgh1nE87Zs7ffJvzET49AfVjHgEfU//po5chyYnxla+hPxCEs0+JKtCVc4
	Y+24KnvcOJGahCAV7XVsqR2NpA9xo16kYDMXicVVo+1dvHtXKtEeNRahjx9EcCjrnAkN
	UrPg==
X-Gm-Message-State: APjAAAXucV/oPW38EpKAPZOKMd1Xsbx+jYr9nd0lbyZz6ELUtUnafGEE
	0mDP6brXZkXzov4UKtZynTdIhA==
X-Google-Smtp-Source: APXvYqyBiaBbcNqy1rmudd4fmc8ctCp1bidAc+QrE8F82EV4TmQjHqb5Rz0V8xR2O64Tyd1Tl+g84A==
X-Received: by 2002:aed:2907:: with SMTP id s7mr9637139qtd.265.1573755783693; 
	Thu, 14 Nov 2019 10:23:03 -0800 (PST)
Received: from ziepe.ca
	(hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[142.162.113.180]) by smtp.gmail.com with ESMTPSA id
	f10sm3216323qth.40.2019.11.14.10.23.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 14 Nov 2019 10:23:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1iVJlm-0004aM-QL; Thu, 14 Nov 2019 14:23:02 -0400
Date: Thu, 14 Nov 2019 14:23:02 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: remove DMA_ATTR_WRITE_BARRIER
Message-ID: <20191114182302.GA7862@ziepe.ca>
References: <20191113073214.9514-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191113073214.9514-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-rdma@vger.kernel.org, Michal Kalderon <mkalderon@marvell.com>,
	Doug Ledford <dledford@redhat.com>, Ariel Elior <aelior@marvell.com>,
	iommu@lists.linux-foundation.org
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

On Wed, Nov 13, 2019 at 08:32:12AM +0100, Christoph Hellwig wrote:

> There is no implementation of the DMA_ATTR_WRITE_BARRIER flag left
> now that the ia64 sn2 code has been removed.  Drop the flag and the
> calling convention to set it in the RDMA code.

Applied to rdma.git for-next

There were a number of conflicts in qedr, I fixed them up, but Michal
probably should check it.

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
