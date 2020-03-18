Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EABCC5ACD6
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 17:06:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123DB2071C
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 17:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G63eeq2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123DB2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DFADB886C6;
	Wed, 18 Mar 2020 17:06:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5sy22pZsWYgf; Wed, 18 Mar 2020 17:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 68F7C88018;
	Wed, 18 Mar 2020 17:06:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64BDAC18DA;
	Wed, 18 Mar 2020 17:06:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03966C013E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 17:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DD62C883E1
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 17:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id amNdqmUnzuJY for <iommu@lists.linux-foundation.org>;
 Wed, 18 Mar 2020 17:06:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 95161883C0
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 17:06:51 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id z15so31338982wrl.1
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=C6WF92f6FqCxd2uXjXbK38TBNn0Z5GJhzehWNybMYWU=;
 b=G63eeq2nFFKzV+64WvrADIUtMN5OBGThYtmAtjVGtaptHQD4olL6D0s5qBf+u68grF
 sW47lkIys/4zZMTqaHeayGINFFHu8iu3pdaxwOw/JvU59RcHrZBDgLUZVIVrLb4b+rrQ
 nPcGKZS1KdaotMJlEqvaGbLz43a9bzYYVUDA893nGJZ51tHeELpdfLmG3zKd9fGK0KrU
 gx6KnI8nvF4TdxLLI1m1tGk/PuXPfsTQSBLnUqLE5byzxsRGE0rgVmr55vMrGjlJpCWr
 T21zeHodup2gzIENP578OHRpXJZsN5oLUa2k6fLmCjRJy2EYyUhnp3Y/YV5V6WXW5O/F
 c1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C6WF92f6FqCxd2uXjXbK38TBNn0Z5GJhzehWNybMYWU=;
 b=CsOaMKAwS2++go/TRphLwPkjOTtbvaxtZxBnGdl1G7M49T50NNYZgDvpg3Du4Q0Ulk
 3HbMlwyrbYeka4xQdUdmhM4gPZwhJ6quKMhAdbTRQ23SsSGRA7vsVH6HFdY7BImKqazR
 qE3axi4B7xTWlrPFHXktJ0HevM+CQlki+cGR8gceGJ8Kx62H/Ox/PSh2l7XgzQPOqd47
 iZhfeufqMGp39fCTEYbYHNmxAns2v8xjXeyKVTzZoXgcrcJ5dWigRm6KJpeEnRoVIjqy
 Upfi2MU3G2HT8382vEvOgS6MnrELgkRfnHzRGJSP/hHcu+f4bkaGJvgqn2ESikMMjrIi
 9MVw==
X-Gm-Message-State: ANhLgQ2hap+0959OZq/ph4O2nQ8Pob7Zbwig5MaKakfXvwp4KtoRqCnU
 IgQtrVX6890yFGnf0df7nOPBmw==
X-Google-Smtp-Source: ADFU+vvtR8KxLPxbAacgtfInpjUnb7K87vRYKsQyiVxHYPV7R+Zu/ccbSDiZ2M0iAiuIRKOIDdBWWw==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr6960351wrs.179.1584551209936; 
 Wed, 18 Mar 2020 10:06:49 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v8sm10378361wrw.2.2020.03.18.10.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 10:06:49 -0700 (PDT)
Date: Wed, 18 Mar 2020 18:06:41 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH] iommu/virtio: Reject IOMMU page granule larger than
 PAGE_SIZE
Message-ID: <20200318170641.GB1501414@myrica>
References: <20200318114047.1518048-1-jean-philippe@linaro.org>
 <f1f3d844-8080-d26d-200e-a38480895480@arm.com>
 <09a32736-ea01-21f9-6bd5-9344b368f90a@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09a32736-ea01-21f9-6bd5-9344b368f90a@redhat.com>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Mar 18, 2020 at 05:14:05PM +0100, Auger Eric wrote:
> Hi,
> 
> On 3/18/20 1:00 PM, Robin Murphy wrote:
> > On 2020-03-18 11:40 am, Jean-Philippe Brucker wrote:
> >> We don't currently support IOMMUs with a page granule larger than the
> >> system page size. The IOVA allocator has a BUG_ON() in this case, and
> >> VFIO has a WARN_ON().
> 
> Adding Alex in CC in case he has time to jump in. At the moment I don't
> get why this WARN_ON() is here.
> 
> This was introduced in
> c8dbca165bb090f926996a572ea2b5b577b34b70 vfio/iommu_type1: Avoid overflow
> 
> >>
> >> It might be possible to remove these obstacles if necessary. If the host
> >> uses 64kB pages and the guest uses 4kB, then a device driver calling
> >> alloc_page() followed by dma_map_page() will create a 64kB mapping for a
> >> 4kB physical page, allowing the endpoint to access the neighbouring 60kB
> >> of memory. This problem could be worked around with bounce buffers.
> > 
> > FWIW the fundamental issue is that callers of iommu_map() may expect to
> > be able to map two or more page-aligned regions directly adjacent to
> > each other for scatter-gather purposes (or ring buffer tricks), and
> > that's just not possible if the IOMMU granule is too big. Bounce
> > buffering would be a viable workaround for the streaming DMA API and
> > certain similar use-cases, but not in general (e.g. coherent DMA, VFIO,
> > GPUs, etc.)
> > 
> > Robin.
> > 
> >> For the moment, rather than triggering the IOVA BUG_ON() on mismatched
> >> page sizes, abort the virtio-iommu probe with an error message.
> 
> I understand this is a introduced as a temporary solution but this
> sounds as an important limitation to me. For instance this will prevent
> from running a fedora guest exposed with a virtio-iommu with a RHEL host.

Looks like you have another argument for nested translation :) We could
probably enable 64k-4k for VFIO, but I don't think we can check and fix
all uses of iommu_map() across the kernel, even if we disallow
IOMMU_DOMAIN_DMA for this case.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
