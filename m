Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E099C32753
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 00:13:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053E22171F
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 00:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kQ7rO4Rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053E22171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A412ACAB;
	Thu, 15 Aug 2019 00:13:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E794DAF7
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 00:13:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
	[209.85.222.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AD07F67F
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 00:13:21 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id d23so644450qko.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=qzhD8inHCWGPsSExfxoS4FMI+7+fcQwlxaBDgT12qb4=;
	b=kQ7rO4RrHFSZ6MZuuxxoF8VbnBnjRycJLb07elyvEnUiIa4wJgsVinEba3cE2MqTB9
	fJulQuWx6Y5tYTxlddWTc11PBfISadqD+ExfUHnpoPQON92Ku+S5Y/WG1rnAqUDmFm/t
	sZdh11B/5WH1wkWaQw580ROrmY5paRB/mKD6yO6YRdOAjXFOKeMa/lNRNHsDHR11a2YM
	fH5CrO9kz+3OETBgm2cIOfKwCC5iyZs6YtbJwN/rErrCwql6u7WwlNfS1W19r/IYCdLa
	OB/xGbNt8+DZYg3Zcz43LE9VgkFuylrF77Y+9lVNSAp5BzomHMMBV2AknnHcgTQXagXw
	j3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=qzhD8inHCWGPsSExfxoS4FMI+7+fcQwlxaBDgT12qb4=;
	b=KeqP9jaG3z73+jZ7kHd/UeW7HKwlmsORA4Fmq8o3bbF/L2Lq5/NEU9+pGpqMSSchcm
	E2BOlUY2Fc39EJAqsgBseXIAKkJ9ayXu6LTUFkg4jRdl8CWyh/wtAxTl6xmeIL1I4tkJ
	/vIxaP+k5BtBJWqqw2GQ1C6IZ0We/7npRi/A9/gebzUVMHn5aI9aTbA+vC6j/HeJhPv5
	ixeu9+T+6qvg/5LTZH5lT2a0nVAA7tvvEP5mcPFaxyqsTSvsOS3zp/uPVn4xrDWGhMlw
	kTKzLGd9NNO1/PvM+KVC7iAAJJZz8y/P2IZKhDUS27PhR9ecZ9vZD6y9AbYGg0WFdxI0
	Tc8A==
X-Gm-Message-State: APjAAAX6HF0q3icxBcQ7fxjS/dQwvDXty9/8JUPi1xv2AZ5GT0+hi6Mq
	UQeMSKBPsO5nRlUYf7Fb67JQcg==
X-Google-Smtp-Source: APXvYqxctXlgOtCTuI+nHfly9zVzKydMCFWuaFknzokpvDUX3JdzMaNu+TsBvuyQsnsSgXcVbMLc+w==
X-Received: by 2002:a05:620a:130d:: with SMTP id
	o13mr1851841qkj.285.1565828000618; 
	Wed, 14 Aug 2019 17:13:20 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.55.100])
	by smtp.gmail.com with ESMTPSA id i5sm756517qti.0.2019.08.14.17.13.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 14 Aug 2019 17:13:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hy3OJ-0003bl-SN; Wed, 14 Aug 2019 21:13:19 -0300
Date: Wed, 14 Aug 2019 21:13:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v3 hmm 03/11] mm/mmu_notifiers: add a get/put scheme for
	the registration
Message-ID: <20190815001319.GF11200@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
	<20190806231548.25242-4-jgg@ziepe.ca>
	<0a23adb8-b827-cd90-503e-bfa84166c67e@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a23adb8-b827-cd90-503e-bfa84166c67e@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	"David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
	Dimitri Sivanich <sivanich@sgi.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Andrea Righi <andrea@betterlinux.com>,
	linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-mm@kvack.org, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	iommu@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	intel-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
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

On Wed, Aug 14, 2019 at 02:20:31PM -0700, Ralph Campbell wrote:
> 
> On 8/6/19 4:15 PM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > Many places in the kernel have a flow where userspace will create some
> > object and that object will need to connect to the subsystem's
> > mmu_notifier subscription for the duration of its lifetime.
> > 
> > In this case the subsystem is usually tracking multiple mm_structs and it
> > is difficult to keep track of what struct mmu_notifier's have been
> > allocated for what mm's.
> > 
> > Since this has been open coded in a variety of exciting ways, provide core
> > functionality to do this safely.
> > 
> > This approach uses the strct mmu_notifier_ops * as a key to determine if
> 
> s/strct/struct

Yes, thanks for all of this, I like having comments, but I'm a
terrible proofreader :(

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
