Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A013C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 12:20:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C05D20578
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 12:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FBMROBQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C05D20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4E55620DE;
	Mon, 29 Apr 2019 12:20:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7AD6F1F64
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 12:17:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 33D2D608
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 12:17:57 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id h11so15417140wmb.5
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 05:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=a7DlJaTbTNvFX68xDqMIysKa66WvtISND+ST6l40r4o=;
	b=FBMROBQeOH6h3eUXycnL1eVmXPv/W8DNxbzlOukDZhwV0KHK/Bidvn6Znnb/U+NnPk
	u0RE93Fi6qEqRz3WHdtssqlNLBYqALzZNYi2cvX3pqZhoknJdPhbEv1+demtMX2b1auw
	RNcO/FMauPbBwXsG1jLIOsAXLhML5U7WA1mU6THHF5s+XKnVcL9rg/jlMcNnaQsM21jD
	Yeo78SOTIXjGee3DJDGMe2PHZqyFV4RX04b/CdKviREP2/LUUy5pc7Yc07TkimC1ib9L
	Ex/ZAXrNt+AwXyu30jKwR1cqPTv4PS6DRb4tUYiRCTbbrSGFyG28OHLfKodLjWI9qpVQ
	6Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=a7DlJaTbTNvFX68xDqMIysKa66WvtISND+ST6l40r4o=;
	b=rLUx2oQyea9VYRRHJrtfHhxUdxY7GWuqLFQJDCaoY26A5DwIzUxsZ+Fu3xIQB5vC2Z
	zrQiutvuOi1S2Ru4uMMpIIoZEAtIiK5By/D/ZSC/rr8p5ZZcZtmwc6T6ot9f3Y7JkwE6
	X4WYKqXx+rZUI9kgem3bC/988Irrcks+nNz+Hp815anHjy9/nk9D6K03nQAGnCf/MYiB
	Zk7KVZRjE0rzCm1+OHhfSYdMZggqQFqqKQbC/LI0snMN1gaqY8EWXhpBVOYHD2yCIs2c
	6SVYZf+/Bqor7NfApjY4ShueODKLqHiFAgGDumOgchEDQh9JEy6wUD51l/I13dtzg7fQ
	QfOw==
X-Gm-Message-State: APjAAAUf5/D2M/dRnfKj23alMfr6NCagl5lut+Jnkw6d7MHHmKkrg+T/
	/5uChzpm3DDACQLz2Tn3kAz07dQIQ9mQHFRlvnqutQ==
X-Google-Smtp-Source: APXvYqztmcN6GpEmbERFxt6fPz3VDi6tdTf4b4mpj6GJ7H7zw4lc4d5VvjVO5bFyvWno2N9/vT5K6bH1uJjKQ/t9m3o=
X-Received: by 2002:a1c:c142:: with SMTP id r63mr17922446wmf.97.1556540275726; 
	Mon, 29 Apr 2019 05:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190424165051.13614-1-tmurphy@arista.com>
	<20190426140429.GG24576@8bytes.org>
	<CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com>
	<20190429115916.GA5349@infradead.org>
In-Reply-To: <20190429115916.GA5349@infradead.org>
Date: Mon, 29 Apr 2019 13:17:44 +0100
Message-ID:
 <CAPL0++7G4zNp76z_8bzV84ky2vXeoX2jTCLSCC-CCWZMgwP5Pw@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429121744.Xjo3RaQlJ6br27ilb48QLYUpI077FFdmYvwBUkRoTTw@z>

On Mon, Apr 29, 2019 at 12:59 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Apr 27, 2019 at 03:20:35PM +0100, Tom Murphy wrote:
> > I am working on another patch to improve the intel iotlb flushing in
> > the iommu ops patch which should cover this too.
>
> So are you looking into converting the intel-iommu driver to use
> dma-iommu as well?  That would be great!

Yes. My patches depend on the "iommu/vt-d: Delegate DMA domain to
generic iommu" patch which is currently being reviewed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
