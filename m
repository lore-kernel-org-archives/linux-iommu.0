Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F5C35DF5
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 07:14:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225FA2082F
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 07:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QSWYzPYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225FA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E6867863FD;
	Tue, 25 Feb 2020 07:14:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id svaD8Nwx0lTU; Tue, 25 Feb 2020 07:14:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2DD4D861A7;
	Tue, 25 Feb 2020 07:14:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 200B9C18DA;
	Tue, 25 Feb 2020 07:14:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9BA4C0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 06:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D26CC83883
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 06:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gt9FFbYcl-Y4 for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 06:59:15 +0000 (UTC)
X-Greylist: delayed 00:05:49 by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 07A98826E6
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 06:59:15 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id q81so11614733oig.0
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 22:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fSxteq8BvR6bLu5LA6jd2BwkLJks1DyRranxnHnzEYU=;
 b=QSWYzPYTbGtdSQcLlCKj5AEGOQ+3AMV+xZg0/U1875q3JKfM5DYKKf5p6HAK6CwjIP
 AOzaHHJjmake0476dUff+71jZhuvNc745oA0rLIGZ2I2H4J5IKOXbhyQXmahB1wqF2Iv
 U7eNIah3q24sEOYyMKrA6vRUfjNnXNBHWLXsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fSxteq8BvR6bLu5LA6jd2BwkLJks1DyRranxnHnzEYU=;
 b=uJdZG/248o66gwMZqdj2lbhGqiIdeJjPD5tFFWKdxZcyfKvqSL2ooB1rFrxVAJNxAn
 /zm6xsVU6hFTTDSqkhyh6/pItARBihLbIMhFtG1M9zHbb8hwEKgq8hqnLDdkUyS7IxPY
 bGrYZ/H4tovsnc+DZdRCDmcHyVuBcddclli/PhGSxyXQ0i7ZjXPOWTpeWk69KkTFehnY
 bH1RAb0vz58/ZfZGV1pR429FIAsCGVPTdaKOVOdV+gbOyuf93Q6q18H19kibP739N69M
 12sOoy2KuTOKPyjGGy1KLJh7AjsCa0prCU1yc+lb/zXFjES9sVDeBsIuPUx2sML4tfHA
 liKw==
X-Gm-Message-State: APjAAAWkct/Q1ae3d/DUtl3HPJxeAjQBCxSW+xhNe2AKmwxZwr2H+MWB
 XzLQMcnHFjoht5acIJjgewnK9uFTx/oU12JqnJ6LO1yDcxwP1+sv
X-Google-Smtp-Source: APXvYqzA/xFMqccjb+BVRQhIHMzDqHfwlaweZ5oYatBKG1/zxpMzG0KS3wxN/jHbU7SS9W3Ga5Oz56oRA9wsAEb0Dk0=
X-Received: by 2002:aca:f587:: with SMTP id t129mr2226747oih.143.1582613605142; 
 Mon, 24 Feb 2020 22:53:25 -0800 (PST)
MIME-Version: 1.0
References: <1578489498.29952.11.camel@abdul>
 <1578560245.30409.0.camel@abdul.in.ibm.com>
 <20200109142218.GA16477@infradead.org>
 <1578980874.11996.3.camel@abdul.in.ibm.com>
 <20200116174443.GA30158@infradead.org> <1579265473.17382.5.camel@abdul>
 <1582611644.19645.6.camel@abdul.in.ibm.com>
In-Reply-To: <1582611644.19645.6.camel@abdul.in.ibm.com>
Date: Tue, 25 Feb 2020 12:23:13 +0530
Message-ID: <CAK=zhgpWCz0+xpSGymbQEAbysH_rQf=s8iQ1gn4KwysP3c1Gcw@mail.gmail.com>
Subject: Re: [linux-next/mainline][bisected 3acac06][ppc] Oops when unloading
 mpt3sas driver
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
X-Mailman-Approved-At: Tue, 25 Feb 2020 07:14:21 +0000
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Chaitra P B <chaitra.basappa@broadcom.com>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
 manvanth <manvanth@linux.vnet.ibm.com>,
 Sathya Prakash <sathya.prakash@broadcom.com>, jcmvbkbc@gmail.com,
 iommu@lists.linux-foundation.org, linux-next <linux-next@vger.kernel.org>,
 Oliver <oohall@gmail.com>, "aneesh.kumar" <aneesh.kumar@linux.vnet.ibm.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Brian King <brking@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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
From: Sreekanth Reddy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Feb 25, 2020 at 11:51 AM Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
>
> On Fri, 2020-01-17 at 18:21 +0530, Abdul Haleem wrote:
> > On Thu, 2020-01-16 at 09:44 -0800, Christoph Hellwig wrote:
> > > Hi Abdul,
> > >
> > > I think the problem is that mpt3sas has some convoluted logic to do
> > > some DMA allocations with a 32-bit coherent mask, and then switches
> > > to a 63 or 64 bit mask, which is not supported by the DMA API.
> > >
> > > Can you try the patch below?
> >
> > Thank you Christoph, with the given patch applied the bug is not seen.
> >
> > rmmod of mpt3sas driver is successful, no kernel Oops
> >
> > Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
>
> Hi Christoph,
>
> I see the patch is under discussion, will this be merged upstream any
> time soon ? as boot is broken on our machines with out your patch.
>

Hi Abdul,

We have posted a new set of patches to fix this issue. This patch set
won't change the DMA Mask on the fly and also won't hardcode the DMA
mask to 32 bit.

[PATCH 0/5] mpt3sas: Fix changing coherent mask after allocation.

This patchset will have below patches, Please review and try with this
patch set.

Suganath Prabu S (5):
  mpt3sas: Don't change the dma coherent mask after      allocations
  mpt3sas: Rename function name is_MSB_are_same
  mpt3sas: Code Refactoring.
  mpt3sas: Handle RDPQ DMA allocation in same 4g region
  mpt3sas: Update version to 33.101.00.00

Regards,
Sreekanth

> --
> Regard's
>
> Abdul Haleem
> IBM Linux Technology Centre
>
>
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
