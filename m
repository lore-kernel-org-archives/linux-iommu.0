Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B982AC4338F
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 22:18:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE7560F25
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 22:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BE7560F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13E1B83A8D;
	Fri, 23 Jul 2021 22:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hsAQO-4g8i6L; Fri, 23 Jul 2021 22:18:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD74883A41;
	Fri, 23 Jul 2021 22:18:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B48CBC001A;
	Fri, 23 Jul 2021 22:18:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED9C8C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 22:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC31D401CB
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 22:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BIlnqiahsvw6 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 22:18:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5ECD400B9
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 22:18:32 +0000 (UTC)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16NM4ddP169159; Fri, 23 Jul 2021 18:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ihYo7DOCFpOk/lgPMcBynDMgjuYqAw4chfmF+lCdcM4=;
 b=qFJhgjKS5VtmyWozBJwiUFLWb8CiJGGAL7jFanaYzfRH56l/UbKh6dK55lddDMjEqy/v
 o36eEFFm8i2kTYryJQkqLsSdw8R1jXLCas7fXDp4iYgJ4xCo5zB9EnjViVWTgeo+mu6F
 s26IohzzQ0YR1eJOCs8oaRN8PVhroqb4hdP5GMdssFPbIjxPg8Qd/LVBXI0OoDzf9XN8
 65HNMqwvMK+wklrM8JN4pMy9/xFw7tOII4sx7X/6Tru9co+WhnGfADVZpHaVxFMOIdFx
 eMhxlevwL6JpyXOI/KGqemg33l9e+63YpxJTQDZBAAoaPXYKXnrTX1J/jDy91MQ0hbBZ BA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3a05g79gva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jul 2021 18:18:27 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16NMIPO2013261;
 Fri, 23 Jul 2021 22:18:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03ams.nl.ibm.com with ESMTP id 39upu8b8nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jul 2021 22:18:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 16NMIMhb26739128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jul 2021 22:18:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 892AF11C04C;
 Fri, 23 Jul 2021 22:18:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 704D011C050;
 Fri, 23 Jul 2021 22:18:21 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.6.217])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Fri, 23 Jul 2021 22:18:21 +0000 (GMT)
Date: Sat, 24 Jul 2021 00:18:13 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
Message-ID: <20210724001813.07ae518d.pasic@linux.ibm.com>
In-Reply-To: <b5eec658-7c15-5eb4-bb17-4d598997b521@de.ibm.com>
References: <20210720133826.9075-1-will@kernel.org>
 <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
 <20210723031252.655d6a83.pasic@linux.ibm.com>
 <b8985c53-a83d-f11f-9fa8-af06d1d4bfd0@de.ibm.com>
 <20210723104701.3f8ac227.pasic@linux.ibm.com>
 <ab29cae0-2c1d-354a-5213-9fe4159570e0@de.ibm.com>
 <YPrLualvV9/lE41j@char.us.oracle.com>
 <b5eec658-7c15-5eb4-bb17-4d598997b521@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _tAZLwpBgAQOmvTpwbf1vZNhPJV_iXkj
X-Proofpoint-ORIG-GUID: _tAZLwpBgAQOmvTpwbf1vZNhPJV_iXkj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-23_10:2021-07-23,
 2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107230133
Cc: linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 iommu@lists.linux-foundation.org, Claire Chang <tientzu@chromium.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

On Fri, 23 Jul 2021 19:53:58 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 23.07.21 16:01, Konrad Rzeszutek Wilk wrote:
> > On Fri, Jul 23, 2021 at 10:50:57AM +0200, Christian Borntraeger wrote:  
> >>
> >>
> >> On 23.07.21 10:47, Halil Pasic wrote:  
> >>> On Fri, 23 Jul 2021 08:14:19 +0200
> >>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>>  
> >>>> Resending with the correct email of Heiko....
> >>>>
> >>>> On 23.07.21 03:12, Halil Pasic wrote:  
> >>>>> On Thu, 22 Jul 2021 21:22:58 +0200
> >>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:  
> >>>>>> On 20.07.21 15:38, Will Deacon wrote:  
> >>>>>>> Hi again, folks,
> >>>>>>>
> >>>>>>> This is version two of the patch series I posted yesterday:
> >>>>>>>
> >>>>>>>       https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
> >>>>>>>
> >>>>>>> The only changes since v1 are:
> >>>>>>>
> >>>>>>>       * Squash patches 2 and 3, amending the commit message accordingly
> >>>>>>>       * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
> >>>>>>>
> >>>>>>> I'd usually leave it a bit longer between postings, but since this fixes
> >>>>>>> issues with patches in -next I thought I'd spin a new version immediately.
> >>>>>>>
> >>>>>>> Cheers,  
> >>>>>>
> >>>>>> FWIW, I just bisected virtio-errors with secure execution mode
> >>>>>> qemu-system-s390x: virtio-serial-bus: Unexpected port id 4205794771 for device virtio-serial0.0
> >>>>>>
> >>>>>> to
> >>>>>> commit 903cd0f315fe426c6a64c54ed389de0becb663dc
> >>>>>> Author: Claire Chang <tientzu@chromium.org>
> >>>>>> Date:   Thu Jun 24 23:55:20 2021 +0800
> >>>>>>
> >>>>>>          swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing
> >>>>>>
> >>>>>> Unfortunately this patch series does NOT fix this issue, so it seems that even more
> >>>>>> things are broken.
> >>>>>>
> >>>>>> Any idea what else might be broken?  
> >>>>>
> >>>>> I've done some debugging, and I think I know what is going on. Since
> >>>>> that commit we need to set force_swiotlb before the swiotlb itself is
> >>>>> initialized. So the patch below should fix the problem.
> >>>>>
> >>>>> --------------------8<-------------------------------------
> >>>>>
> >>>>> From: Halil Pasic <pasic@linux.ibm.com>
> >>>>> Date: Fri, 23 Jul 2021 02:57:06 +0200
> >>>>> Subject: [PATCH 1/1] s390/pv: fix the forcing of the swiotlb
> >>>>>
> >>>>> Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
> >>>>> swiotlb data bouncing") if code sets swiotlb_force it needs to do so
> >>>>> before the swiotlb is initialised. Otherwise
> >>>>> io_tlb_default_mem->force_bounce will not get set to true, and devices
> >>>>> that use (the default) swiotlb will not bounce  despite switolb_force
> >>>>> having the value of SWIOTLB_FORCE.
> >>>>>
> >>>>> Let us restore swiotlb functionality for PV by fulfilling this new
> >>>>> requirement.  
> >>>> I would add:
> >>>> Fixes: 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing")
> >>>> as this patch breaks things
> >>>> and
> >>>> Fixes: 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
> >>>>
> >>>> to make the s390 init code more robust in case people start backporting things.  
> >>>
> >>> I agree. Do we want this backported to the stable releases that have
> >>> 64e1f0c531d1  (i.e. do we need a cc stable) or should the fixes tag just
> >>> serve as metadata? My guess is, it's the former. In that sense should I
> >>> add the tags along with an explanation for the second fixes respin with
> >>> cc stable?
> >>>
> >>> (BTW I don't think this formally qualifies for the stable backports, but
> >>> I hope we can make an exception...)  
> >>
> >> I think it makes sense for stable as it is cleaner to set the flags before
> >> calling the init function. cc stable would be better and the right way
> >> according to process, but the Fixes tag is mostly enough.  
> > 
> > But the reaso for fixing this is for code that is not yet in Linus's
> > tree?
> > 
> > I can just pick this patch up and add it in the pile I have for the next
> > merge window?  
> 
> That would also work for me. I think Halil wanted to send out and v2.

Sorry I didn't interpret your answer correctly. (I interpreted it
like the fixes tags are enough, and those can be added by the maintainer
that is going to merge the patch.) I will send out a v2 right away.

Regards,
Halil
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
