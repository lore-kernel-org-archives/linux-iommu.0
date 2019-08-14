Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B3C433FF
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 21:53:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001FA2133F
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 21:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DuHQyhEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001FA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B525DB62;
	Wed, 14 Aug 2019 21:53:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4115FAE0
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 21:53:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F017CCF
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 21:53:50 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5d5482f40000>; Wed, 14 Aug 2019 14:53:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate102.nvidia.com (PGP Universal service);
	Wed, 14 Aug 2019 14:53:45 -0700
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Wed, 14 Aug 2019 14:53:45 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
	(172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Wed, 14 Aug 2019 21:53:42 +0000
Subject: Re: [PATCH v3 hmm 11/11] mm/mmu_notifiers: remove
	unregister_no_release
To: Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>
References: <20190806231548.25242-1-jgg@ziepe.ca>
	<20190806231548.25242-12-jgg@ziepe.ca>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <84b35625-9877-0f35-155a-2d5ee1af4108@nvidia.com>
Date: Wed, 14 Aug 2019 14:53:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806231548.25242-12-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
	HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1565819636; bh=jn8qPKX3vGj+tzC7jfWRezHMQaQX7LZbuyruFud4LQQ=;
	h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
	Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
	Content-Transfer-Encoding;
	b=DuHQyhEkn2nVu3F9JE1Jqs394XgDiOloB/DupeDvogYw6EVbMONwcehm4ND30nlJe
	coLB6ipCN1oIyc4w1mqCCYewK+PC5YV9u55ueYp2oaHr/1plVEnMB9PP5+CTSD2S+f
	/EwXD2xqdd7b1DugwUAbPGKM94w9rldbIHus7fAOpSWXDg6bOvnb9bZD9px5zT4R9w
	fNKaAnXFzpPWTG2T38iLy/xRORGPkKKaDbUB4Y5JUU/eQRUnl/o4i6ggHqZCwIPAQU
	XR1OQDE52UPDPt8SmWG+WQaZO6Cc6+YdybR1YFmKROUzj521DapTNnEGLy+4532Itg
	+dCm77lSoXV4A==
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	"David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
	Dimitri Sivanich <sivanich@sgi.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Andrea Righi <andrea@betterlinux.com>,
	linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	iommu@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org,
	Jason Gunthorpe <jgg@mellanox.com>, Alex
	Deucher <alexander.deucher@amd.com>, intel-gfx@lists.freedesktop.org,
	Christoph Hellwig <hch@lst.de>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


On 8/6/19 4:15 PM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> mmu_notifier_unregister_no_release() and mmu_notifier_call_srcu() no
> longer have any users, they have all been converted to use
> mmu_notifier_put().
> 
> So delete this difficult to use interface.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
