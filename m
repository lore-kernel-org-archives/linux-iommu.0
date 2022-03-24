Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB0CC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 18:02:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A895403AA;
	Thu, 24 Mar 2022 18:02:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0DBJxeTkDjt1; Thu, 24 Mar 2022 18:02:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B51394011A;
	Thu, 24 Mar 2022 18:02:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BE66C001A;
	Thu, 24 Mar 2022 18:02:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6D71C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 18:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE22B41CB0
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 18:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j98e8hWv9Vsz for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 18:02:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D467441CA8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 18:02:37 +0000 (UTC)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OHdpdx028652; 
 Thu, 24 Mar 2022 18:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=7N/Uygt+143zP1GtcKOONYQzUeuYDGnbzS8lAEa/ht4=;
 b=orZn5/JJHPLU3aXi7QTpaZ5Czx9MkFWvCy6VS9j1sQFwvDaNk44fFCgOg135hXfxmdZc
 7THzrDaOfxXn3zjwLe/faPAApLdB9K/JfUCKPi3DtfufF4GOob4cliM045llpIvvJUyY
 Rzfrq0x8LbmVXpJ5CAsp3+EVRza2WHBDyzSmRE2u/6OfPXgGd219KcTs/50mvKryuhJt
 GeFdl1tYurjSfaYri8ylmr62AvKiZJIUWlmjKNWp0ouRtR1/QKb6rkyBpmmHlWM1P+Q9
 DEH/ZSOUmCvhhzGqJfOXpiJ21L1W8cSw8v18NJVGcFY3A7fBsLn+WfG/pEF5dwQDkR1y BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3f0pxd1pyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Mar 2022 18:02:24 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22OHhWqv004212;
 Thu, 24 Mar 2022 18:02:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3f0pxd1pxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Mar 2022 18:02:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22OHxcHC020458;
 Thu, 24 Mar 2022 18:02:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma03ams.nl.ibm.com with ESMTP id 3ew6t93dsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Mar 2022 18:02:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 22OHoXog52691430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Mar 2022 17:50:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 456E54C04A;
 Thu, 24 Mar 2022 18:02:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BC5E4C040;
 Thu, 24 Mar 2022 18:02:18 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.63.111])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Thu, 24 Mar 2022 18:02:18 +0000 (GMT)
Date: Thu, 24 Mar 2022 19:02:16 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Message-ID: <20220324190216.0efa067f.pasic@linux.ibm.com>
In-Reply-To: <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
 <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2MudIYovaPOAUEbTqagMNrUaYICtVj4D
X-Proofpoint-ORIG-GUID: 7Gru2c9X8jDDAUwXo23TBQWTusNqnneh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-24_06,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203240098
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, 23 Mar 2022 20:54:08 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2022-03-23 19:16, Linus Torvalds wrote:
> > On Wed, Mar 23, 2022 at 12:06 PM Robin Murphy <robin.murphy@arm.com> wrote:  
> >>
> >> On 2022-03-23 17:27, Linus Torvalds wrote:  
> >>>
> >>> I'm assuming that the ath9k issue is that it gives DMA mapping a big
> >>> enough area to handle any possible packet size, and just expects -
> >>> quite reasonably - smaller packets to only fill the part they need.
> >>>
> >>> Which that "info leak" patch obviously breaks entirely.  
> >>
> >> Except that's the exact case which the new patch is addressing  
> > 
> > Not "addressing". Breaking.
> > 
> > Which is why it will almost certainly get reverted.
> > 
> > Not doing DMA to the whole area seems to be quite the sane thing to do
> > for things like network packets, and overwriting the part that didn't
> > get DMA'd with zeroes seems to be exactly the wrong thing here.
> > 
> > So the SG_IO - and other random untrusted block command sources - data
> > leak will almost certainly have to be addressed differently. Possibly
> > by simply allocating the area with GFP_ZERO to begin with.  
> 
> Er, the point of the block layer case is that whole area *is* zeroed to 
> begin with, and a latent memory corruption problem in SWIOTLB itself 
> replaces those zeros with random other kernel data unexpectedly. Let me 
> try illustrating some sequences for clarity...
> 
> Expected behaviour/without SWIOTLB:
>                               Memory
> ---------------------------------------------------
> start                        12345678
> dma_map(DMA_FROM_DEVICE)      no-op
> device writes partial data   12ABC678 <- ABC
> dma_unmap(DMA_FROM_DEVICE)   12ABC678
> 
> 
> SWIOTLB previously:
>                               Memory      Bounce buffer
> ---------------------------------------------------
> start                        12345678    xxxxxxxx
> dma_map(DMA_FROM_DEVICE)             no-op
> device writes partial data   12345678    xxABCxxx <- ABC
> dma_unmap(DMA_FROM_DEVICE)   xxABCxxx <- xxABCxxx
> 
> 
> SWIOTLB Now:
>                               Memory      Bounce buffer
> ---------------------------------------------------
> start                        12345678    xxxxxxxx
> dma_map(DMA_FROM_DEVICE)     12345678 -> 12345678
> device writes partial data   12345678    12ABC678 <- ABC
> dma_unmap(DMA_FROM_DEVICE)   12ABC678 <- 12ABC678
> 
> 
> Now, sure we can prevent any actual information leakage by initialising 
> the bounce buffer slot with zeros, but then we're just corrupting the 
> not-written-to parts of the mapping with zeros instead of anyone else's 
> old data. That's still fundamentally not OK. The only thing SWIOTLB can 
> do to be correct is treat DMA_FROM_DEVICE as a read-modify-write of the 
> entire mapping, because it has no way to know how much of it is actually 
> going to be modified.
> 

Very nice explanation! Thanks!

> I'll admit I still never quite grasped the reason for also adding the 
> override to swiotlb_sync_single_for_device() in aa6f8dcbab47, but I 
> think by that point we were increasingly tired and confused and starting 
> to second-guess ourselves (well, I was, at least).

I raised the question, do we need to do the same for
swiotlb_sync_single_for_device(). Did that based on my understanding of the
DMA API documentation. I had the following scenario in mind

SWIOTLB without the snyc_single:
                                  Memory      Bounce buffer      Owner
--------------------------------------------------------------------------
start                             12345678    xxxxxxxx             C
dma_map(DMA_FROM_DEVICE)          12345678 -> 12345678             C->D
device writes partial data        12345678    12ABC678 <- ABC      D
sync_for_cpu(DMA_FROM_DEVICE)     12ABC678 <- 12ABC678             D->C
cpu modifies buffer               66666666    12ABC678             C
sync_for_device(DMA_FROM_DEVICE)  66666666    12ABC678             C->D
device writes partial data        66666666    1EFGC678 <-EFG       D
dma_unmap(DMA_FROM_DEVICE)        1EFGC678 <- 1EFGC678             D->C

Legend: in Owner column C stands for cpu and D for device.

Without swiotlb, I believe we should have arrived at 6EFG6666. To get the
same result, IMHO, we need to do a sync in sync_for_device().
And aa6f8dcbab47 is an imperfect solution to that (because of size).


> I don't think it's 
> wrong per se, but as I said I do think it can bite anyone who's been 
> doing dma_sync_*() wrong but getting away with it until now. 

I fully agree.

> If 
> ddbd89deb7d3 alone turns out to work OK then I'd be inclined to try a 
> partial revert of just that one hunk.
>

I'm not against being pragmatic and doing the partial revert. But as
explained above, I do believe for correctness of swiotlb we ultimately
do need that change. So if the revert is the short term solution,
what should be our mid-term road-map?

Regards,
Halil
 
> Thanks,
> Robin.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
