Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BF4C3A59C
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 15:14:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C7E2171F
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oy5sZFjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C7E2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 41521C3A;
	Fri, 16 Aug 2019 15:14:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E584FC11
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 15:14:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 747048A0
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 15:14:54 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id m2so4961364qkd.10
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=fov2CgaO1O1CFkZX4IfqnTZnTK7C3zpSvYgzXGSY56g=;
	b=oy5sZFjQp1BCVaEwQsb3+KNPFbSHSZHWPBMzBnqM3YkM8M6TeLN/TchFjkEdsICSuJ
	1C+Aqtldy/Y4ldUDXhcLTuhfNncF7+Dyd3fNJ1bom3uP8hS9LridrmdEdsAQXWEZtKjz
	7XP3pkdVorvFX0x7VQ1DMygwaFOvfV+UwasgUORcn3BEim4b1kFT8oE06M97uDUrjOv5
	mMHA/Z8hsM7HRGW+maHrZQD/1QDaaYGCk/ab/4r4vI2lVu52wx2id8gV5icj3phd9BLt
	KUOXu736r5AT7W/9wY/TxeK4Ryn6yfFSyNCnwDYASLlBBEV0NjKDADW49yLgEKf3SWZn
	2lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=fov2CgaO1O1CFkZX4IfqnTZnTK7C3zpSvYgzXGSY56g=;
	b=SNoLuM25zXOFqrASeKaHlo7JBIKSm8NphaIlieYvZ7KdtlEyP0anSL1moZssNVRfmQ
	9zKkNH8VfFc4iCs1UibL6bEqJZMUnmkNtbiapzfL2BdF8Nqp33pnsW35NtUUH9LevIPi
	FmGPfpYuvjvvu5ON87upMiEe5DLn0/C19e8rmtqoF37hFPlw1DfnfWwwVwd4MzZUv0Bk
	Dw9onf7x7U5yA+VD4tuKaWB+MPrPQS7r9phJ73Qtff+klpZuTGDvNLnYBSj2ML2tHOKM
	o64mGvhYEaqi8vjKgwb0KIm7qJi64PAsgA/sOwipcWuG+L5tZACUIIs+3pSat2PK78vq
	0Bpw==
X-Gm-Message-State: APjAAAWskyFep2fWcNBbzamIDNGpnOGzzl+b2Ljdov3GuggiVBGVnMTT
	WyQI50DTvKKanHnbQYi4U3Vktg==
X-Google-Smtp-Source: APXvYqxJQYOJO15q7RlRP/vufAQqFSxN3g0+gtugu+v5p95C5icfuXRjyKSuaK0zmQH83GKJGhGMfA==
X-Received: by 2002:a05:620a:1590:: with SMTP id
	d16mr9385834qkk.18.1565968493491; 
	Fri, 16 Aug 2019 08:14:53 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.55.100]) by smtp.gmail.com with ESMTPSA id
	o127sm3158342qkd.104.2019.08.16.08.14.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 16 Aug 2019 08:14:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hydwK-0003JY-LJ; Fri, 16 Aug 2019 12:14:52 -0300
Date: Fri, 16 Aug 2019 12:14:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org
Subject: Re: [PATCH v3 hmm 00/11] Add mmu_notifier_get/put for managing mmu
	notifier registrations
Message-ID: <20190816151452.GA8562@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	"David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
	Ralph Campbell <rcampbell@nvidia.com>, Dimitri Sivanich <sivanich@sgi.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Andrea Righi <andrea@betterlinux.com>,
	linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
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

On Tue, Aug 06, 2019 at 08:15:37PM -0300, Jason Gunthorpe wrote:
> This series is already entangled with patches in the hmm & RDMA tree and
> will require some git topic branches for the RDMA ODP stuff. I intend for
> it to go through the hmm tree.

> Jason Gunthorpe (11):
>   mm/mmu_notifiers: hoist do_mmu_notifier_register down_write to the
>     caller
>   mm/mmu_notifiers: do not speculatively allocate a mmu_notifier_mm
>   mm/mmu_notifiers: add a get/put scheme for the registration
>   misc/sgi-gru: use mmu_notifier_get/put for struct gru_mm_struct
>   hmm: use mmu_notifier_get/put for 'struct hmm'
>   drm/radeon: use mmu_notifier_get/put for struct radeon_mn
>   drm/amdkfd: fix a use after free race with mmu_notifer unregister
>   drm/amdkfd: use mmu_notifier_put

Other than these patches:

>   RDMA/odp: use mmu_notifier_get/put for 'struct ib_ucontext_per_mm'
>   RDMA/odp: remove ib_ucontext from ib_umem
>   mm/mmu_notifiers: remove unregister_no_release

This series has been applied.

I will apply the ODP patches when the series they depend on is merged
to the RDMA tree

Any further acks/remarks I will annotate, thanks in advance

Thanks to all reviewers,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
