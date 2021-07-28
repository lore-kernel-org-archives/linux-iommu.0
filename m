Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C558C4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:17:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB5160F91
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FB5160F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01AE9405F6;
	Wed, 28 Jul 2021 15:17:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q61qW1GYLam7; Wed, 28 Jul 2021 15:17:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E2787405AB;
	Wed, 28 Jul 2021 15:17:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2695C001A;
	Wed, 28 Jul 2021 15:17:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3627C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2E7B405E6
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cfufEK6CPWpc for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 15:17:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C400E405AB
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627485453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G74hAD1INJz4al2p5kUqrIQ36rIkhCEJh1SOa5TxS9s=;
 b=PLkuyu1PNnPK5vwatnMIK+ysKtTfN1UCJ6wxI+VVCWADFP/CRIs9QfpmJPOWwdEZPooYGr
 /+XCIPOgWyyKw5KF1PKSmgE9gYcIiaa2smUQI74RLgtAfmpxPzPMbHVNI8tsnflnsQZDbd
 VdEOCuKIDOtG+eMyQ4JWSSthIG8O80M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-UDtteHy1NGmvPeuayJGZwg-1; Wed, 28 Jul 2021 11:17:29 -0400
X-MC-Unique: UDtteHy1NGmvPeuayJGZwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B449801AC0;
 Wed, 28 Jul 2021 15:17:28 +0000 (UTC)
Received: from T590 (ovpn-12-35.pek2.redhat.com [10.72.12.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27C7A1971B;
 Wed, 28 Jul 2021 15:17:19 +0000 (UTC)
Date: Wed, 28 Jul 2021 23:17:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YQF1AKS6Y14dLU/A@T590>
References: <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com>
 <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
 <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com>
 <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Wed, Jul 28, 2021 at 11:38:18AM +0100, John Garry wrote:
> On 28/07/2021 02:32, Ming Lei wrote:
> > On Mon, Jul 26, 2021 at 3:51 PM John Garry<john.garry@huawei.com>  wrote:
> > > On 23/07/2021 11:21, Ming Lei wrote:
> > > > > Thanks, I was also going to suggest the latter, since it's what
> > > > > arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
> > > > > indicative of where the slowness most likely stems from.
> > > > The improvement from 'iommu.strict=0' is very small:
> > > > 
> > > Have you tried turning off the IOMMU to ensure that this is really just
> > > an IOMMU problem?
> > > 
> > > You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
> > > cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
> > > disabling for kernel drivers).
> > Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
> > on this issue.
> 
> A ~90% throughput drop still seems to me to be too high to be a software
> issue. More so since I don't see similar on my system. And that throughput
> drop does not lead to a total CPU usage drop, from the fio log.
> 
> Do you know if anyone has run memory benchmark tests on this board to find
> out NUMA effect? I think lmbench or stream could be used for this.

https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/

-- 
Ming

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
