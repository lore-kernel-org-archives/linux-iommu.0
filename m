Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7EC55178
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 18:01:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF526247FA
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 18:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOMLAmOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF526247FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 699DB8651A;
	Wed, 28 Oct 2020 18:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p5nw6ayTQczv; Wed, 28 Oct 2020 18:01:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8738864DA;
	Wed, 28 Oct 2020 18:01:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D593DC0859;
	Wed, 28 Oct 2020 18:01:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11FC2C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 18:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F379786F99
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 18:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mVQsXpyg22gJ for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 18:01:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A41768598B
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603908081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Nk2LjAqH68iPpRMmd15ZYH8jce4ByIolJyVBRLfJOQ=;
 b=QOMLAmOVRk5yx8HxX57hhMmv3vJHvHfUlJk6iDjN4rpcIzpSne6fPss7OZHTCnHjuz5y+y
 jWaYRyBwqTgZj17pF3MAuT52o2HLD52kRKl2/1e3ZodWnXMoDqBdZbbJ9/s3cIZo3R+DJr
 YPueTGSMlwMFTR/D/GMB7WWv+rHjTxQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-aFzbW6i8MtiEuLNqzH3sdA-1; Wed, 28 Oct 2020 14:01:18 -0400
X-MC-Unique: aFzbW6i8MtiEuLNqzH3sdA-1
Received: by mail-wr1-f72.google.com with SMTP id x16so144268wrg.7
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 11:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5Nk2LjAqH68iPpRMmd15ZYH8jce4ByIolJyVBRLfJOQ=;
 b=LydqBmawO7F3E2t7N7Jn0NblTWFvAseCVvxTK/tT4y+18L0DWbpMzt/sYUQen9cNkH
 2Trurm2BYmEW7gTUJvVXMUDvuNjl63q+d2R82XZ9LvL4FHyT/TWvmXAhzvDkuc/JmBok
 55oZf3ClSu7ggjgRvfgMrk60BPvDI0F/9qyqYogKfFZDr/7L9zbOeskGIBAXISZ51fq3
 vlEGiO1T/G0dxmiKQlt0/AD05CGDW7JYj2oRJo5YrzsmezzyveRYsPkP9y84ThzNZYfq
 KVkQXi1gVTt0LIUVmD4Ls5YA+Nc2VCeA2S5b92JqhV55d84Fu3hDsvHgEdzqsQjRsYPV
 mn6Q==
X-Gm-Message-State: AOAM533CDAoBdc0X2q7FfUgeV21l38J8pyytxXMC3pHw6GCpkN0dXyc4
 tBLu2V9bYQeYFAfbAXcPe+ctLMlNCyzoA6R0D2dIWsE6dh4NHUuXqm7b6WXm47Js/61y/Fet+p5
 uiogFoT/OEAKRwGU4a2X1hOE7VQypwg==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr525253wrn.257.1603908076711;
 Wed, 28 Oct 2020 11:01:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS4a2Tb6jVLditxSIK/2tiQlDfblWIHCJN1cagQ8Ey8zoitAc/WOhLkPDuLKeb4iVg6mXqJg==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr525205wrn.257.1603908076449;
 Wed, 28 Oct 2020 11:01:16 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id a17sm440271wra.29.2020.10.28.11.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 11:01:15 -0700 (PDT)
Date: Wed, 28 Oct 2020 14:01:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20201028135103-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220161309.GB12709@lst.de>
 <20200221153340.4cdcde81.pasic@linux.ibm.com>
 <20200222140408-mutt-send-email-mst@kernel.org>
 <20200224171657.GB7278@lst.de>
 <691d8c8e-665c-b05f-383f-78377fcf6741@amazon.com>
MIME-Version: 1.0
In-Reply-To: <691d8c8e-665c-b05f-383f-78377fcf6741@amazon.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Wed, Oct 28, 2020 at 03:24:03PM +0100, Alexander Graf wrote:
> On 24.02.20 18:16, Christoph Hellwig wrote:
> > On Sat, Feb 22, 2020 at 02:07:58PM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
> > > > AFAIU you have a positive attitude towards the idea, that
> > > > !F_VIRTIO_PLATFORM implies 'no DMA API is used by virtio'
> > > > should be scrapped.
> > > > 
> > > > I would like to accomplish that without adverse effects to virtio-ccw
> > > > (because caring for virtio-ccw is a part of job description).
> > > > 
> > > > Regards,
> > > > Halil
> > > 
> > > It is possible, in theory. IIRC the main challenge is that DMA API
> > > has overhead of indirect function calls even when all it
> > > does it return back the PA without changes.
> > 
> > That overhead is gone now, the DMA direct calls are direct calls these
> > days.
> 
> Michael, would that mitigate your concerns to just always use the DMA API?
> If not, wouldn't it make sense to benchmark and pinpoint Christoph to paths
> that do slow things down, so we can finally move virtio into a world where
> it doesn't bypass the kernel DMA infrastructure.
> 
> 
> Alex


There's no specific concern really. One can in theory move the code
handling !VIRTIO_F_ACCESS_PLATFORM such that instead of having a branch
in virtio code, you instead override platform DMA API and then use DMA
API unconditionally.

The gain from that will probably be marginal, but maybe I'm wrong.
Let's see the patches.

We still need to do the override when !VIRTIO_F_ACCESS_PLATFORM,
according to spec. Encrypted hypervisors still need to set
VIRTIO_F_ACCESS_PLATFORM.


Is VIRTIO_F_ACCESS_PLATFORM a good default? Need to support
legacy guests does not allow that at the qemu level, we
need to be conservative there. But yes, if you have a very
modern guest then it might be a good idea to just always
enable VIRTIO_F_ACCESS_PLATFORM. I say might since unfortunately
most people only use VIRTIO_F_ACCESS_PLATFORM with
vIOMMU, using it without VIRTIO_F_ACCESS_PLATFORM is supported
but is a path less well trodden. Benchmarking that,
fixing issues that surface if any would be imho effort
well spent, and would be a prerequisite to making it
a default in a production system.


> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
