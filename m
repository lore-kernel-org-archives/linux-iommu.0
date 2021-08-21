Return-Path: <SRS0=A77v=NM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC48C4338F
	for <iommu@archiver.kernel.org>; Sat, 21 Aug 2021 15:44:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFAF6121F
	for <iommu@archiver.kernel.org>; Sat, 21 Aug 2021 15:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DFAF6121F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B28D80D91;
	Sat, 21 Aug 2021 15:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hNfl6zeL1sqQ; Sat, 21 Aug 2021 15:44:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2F03380C4F;
	Sat, 21 Aug 2021 15:44:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BC4FC0010;
	Sat, 21 Aug 2021 15:44:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42AB8C000E
 for <iommu@lists.linux-foundation.org>; Sat, 21 Aug 2021 15:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 228AF40288
 for <iommu@lists.linux-foundation.org>; Sat, 21 Aug 2021 15:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xk8bj6LzUXto for <iommu@lists.linux-foundation.org>;
 Sat, 21 Aug 2021 15:44:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB9F8400CA
 for <iommu@lists.linux-foundation.org>; Sat, 21 Aug 2021 15:44:41 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
 id 9061E7F54F; Sat, 21 Aug 2021 18:44:39 +0300 (EEST)
Date: Sat, 21 Aug 2021 18:44:39 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Use report_iommu_fault()
Message-ID: <YSEfZyrLSWR0gFDu@wantstofly.org>
References: <YP7jbfRFxMeFONKl@wantstofly.org>
 <8cc39d3c-6086-cfe3-9743-901c51ad4bab@amd.com>
 <YQNksD4G1SS/yGM2@wantstofly.org>
 <0d353fc0-79d0-36b7-eeee-ba27249bb258@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0d353fc0-79d0-36b7-eeee-ba27249bb258@amd.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, iommu@lists.linux-foundation.org
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

On Thu, Aug 05, 2021 at 11:26:25AM -0500, Suthikulpanit, Suravee wrote:

> Lennert,

Hi Suravee,


> > - EVENT_FLAG_I unset, but the request was a translation request
> >   (EVENT_FLAG_TR set) or the target page was not present
> >   (EVENT_FLAG_PR unset): call report_iommu_fault(), but the RW
> >   bit will be invalid, so don't try to map it to a
> >   IOMMU_FAULT_{READ,WRITE} code
> 
> So, why do we need to call report_iommu_fault() for this case?
> My understanding is we only have IOMMU_FAULT_[READ|WRITE].
> So, if we can't identify whether the DMA is read / write,
> we should not need to call report_iommu_fauilt(), is it?

I don't think that we should just altogether avoid logging the subset
of page faults for which we can't determine the read/write direction
on AMD platforms.

E.g. "access to an unmapped address" (which will have PR=0, and thus we
won't know if it was a read or a write access) is just as much of a page
fault as "write to a read-only page" (which will have PR=1, and thus the
RW bit will be accurate) is, and for RAS purposes, both events are
equally interesting, and important to know about.

It's true that we currently don't have a way of signaling to
report_iommu_fault() (and by extension, to the io_page_fault
tracepoint) that we're not sure whether the offending access was a read
or a write, but I think we can just add a bit to include/linux/iommu.h
to indicate that, something along the lines of:

	 /* iommu fault flags */
	 #define IOMMU_FAULT_READ        0x0
	 #define IOMMU_FAULT_WRITE       0x1
	+#define IOMMU_FAULT_RW_UNKNOWN  0x2

(Cc'ing Ohad Ben-Cohen, who originally added this API.)

I don't think that it would be a good idea to just not signal the page
faults for which we don't know the read/write direction.


Thanks,
Lennert



> > - EVENT_FLAG_I unset, the request is a transaction request (EVENT_FLAG_TR
> >    unset) and the target page was present (EVENT_FLAG_PR set): call
> >    report_iommu_fault(), and use the RW bit to set IOMMU_FAULT_{READ,WRITE}
> > 
> > So I don't think we can merge the test for EVENT_FLAG_I with the
> > test for EVENT_FLAG_TR/EVENT_FLAG_PR.
> 
> The only condition that we would report_iommu_fault is
> I=0, TR=0, PR=1, isn't it. So we should be able to just check if PR=1.
> 
> 
> > We could do something like this, if you'd prefer:
> > 
> > 	#define IS_IOMMU_MEM_TRANSACTION(flags)	\
> > 		(((flags) & EVENT_FLAG_I) == 0)
> > 
> > 	#define IS_RW_FLAG_VALID(flags)		\
> > 		(((flags) & (EVENT_FLAG_TR | EVENT_FLAG_PR)) == EVENT_FLAG_PR)
> > 
> > 	#define IS_WRITE_REQUEST(flags)		\
> > 		(IS_RW_FLAG_VALID(flags) && (flags & EVENT_FLAG_RW))
> > 
> > And then do something like:
> > 
> > 	if (dev_data && IS_IOMMU_MEM_TRANSACTION(flags)) {
> > 		if (!report_iommu_fault(&dev_data->domain->domain, &pdev->dev,
> > 					address,
> > 					IS_WRITE_REQUEST(flags) ?
> > 					IOMMU_FAULT_WRITE : IOMMU_FAULT_READ))
> 
> Actually, IS_WRITE_REQUEST() == 0 could mean:
> - I=0, TR=0, PR=1 and RW=0: This is fine.
> - I=0, (TR=1 or PR=0), and we should not be calling report_iommu_fault() here
>   since we cannot specify READ/WRITE here.
> 
> Thanks,
> Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
