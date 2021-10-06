Return-Path: <SRS0=yzib=O2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC07BC433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Oct 2021 15:06:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C64361184
	for <iommu@archiver.kernel.org>; Wed,  6 Oct 2021 15:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C64361184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 424C4402B7;
	Wed,  6 Oct 2021 15:06:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-mkgUOiJuad; Wed,  6 Oct 2021 15:06:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 628154011C;
	Wed,  6 Oct 2021 15:06:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D436C0011;
	Wed,  6 Oct 2021 15:06:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B228C000D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Oct 2021 15:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A75083FFE
 for <iommu@lists.linux-foundation.org>; Wed,  6 Oct 2021 15:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O0tmLmYsSub3 for <iommu@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 15:06:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E9C683FFC
 for <iommu@lists.linux-foundation.org>; Wed,  6 Oct 2021 15:06:42 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196EVu1L031318; 
 Wed, 6 Oct 2021 11:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CSCaFGQKbQ0BBGBXLMCDk9QntjBm1YCC9kIlGGumUoU=;
 b=jSQ/RLK41e7lN4wkvxGzhA0D8bjmtzLJIV2BiML9agqVmieoZpg1NI+AWltLcxuYL4Ht
 iDoThUAyZGQHnHux+Swpc/ysXD5GqUyKddy9QtiR8RWCTZausQQFTef22mnjtH7xeEF1
 bv3HdtEPoBKE6IAEXPOqe0vwZCIA9oyeX4ILquXLFKeJaEAZXk/8AxMkIu0A7x2W7yPa
 fjcDC6fG2gW2KtQRd/kFLNLtzl4vjzfCgfV97S09nXfW9wL85z2O2E0wcd5ITnV/LY1H
 KZKJsqZvoFajN5cSJAvZE6hb7zwjLkfoYDYw8CDaNBlPWYiO3r+MepzYfIYVNA7F1A/y BQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3bh1wvrwj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Oct 2021 11:06:26 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 196EvJQQ020118;
 Wed, 6 Oct 2021 15:06:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 3bef2aevw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Oct 2021 15:06:23 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 196F6I4n37880194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Oct 2021 15:06:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62578A4064;
 Wed,  6 Oct 2021 15:06:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA66EA4067;
 Wed,  6 Oct 2021 15:06:15 +0000 (GMT)
Received: from thinkpad (unknown [9.171.8.189])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Wed,  6 Oct 2021 15:06:15 +0000 (GMT)
Date: Wed, 6 Oct 2021 17:06:13 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: DPAA2 triggers, [PATCH] dma debug: report -EEXIST errors in
 add_dma_entry
Message-ID: <20211006170613.455e66c2@thinkpad>
In-Reply-To: <4a96b583-1119-8b26-cc85-f77a6b4550a2@arm.com>
References: <20210518125443.34148-1-someguy@effective-light.com>
 <fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com>
 <20210914154504.z6vqxuh3byqwgfzx@skbuf>
 <185e7ee4-3749-4ccb-6d2e-da6bc8f30c04@linux.ibm.com>
 <20211001145256.0323957a@thinkpad>
 <20211006151043.61fe9613@thinkpad>
 <4a96b583-1119-8b26-cc85-f77a6b4550a2@arm.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ot8L6gpKg8xoQxW_Z7rlAehLfzi_-EZ3
X-Proofpoint-GUID: Ot8L6gpKg8xoQxW_Z7rlAehLfzi_-EZ3
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060095
Cc: linux-s390 <linux-s390@vger.kernel.org>,
 Hamza Mahfooz <someguy@effective-light.com>, linux-rdma@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Christoph Hellwig <hch@lst.de>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Dan Williams <dan.j.williams@intel.com>,
 Karsten Graul <kgraul@linux.ibm.com>
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

On Wed, 6 Oct 2021 15:23:36 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2021-10-06 14:10, Gerald Schaefer wrote:
> > On Fri, 1 Oct 2021 14:52:56 +0200
> > Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> > 
> >> On Thu, 30 Sep 2021 15:37:33 +0200
> >> Karsten Graul <kgraul@linux.ibm.com> wrote:
> >>
> >>> On 14/09/2021 17:45, Ioana Ciornei wrote:
> >>>> On Wed, Sep 08, 2021 at 10:33:26PM -0500, Jeremy Linton wrote:
> >>>>> +DPAA2, netdev maintainers
> >>>>> Hi,
> >>>>>
> >>>>> On 5/18/21 7:54 AM, Hamza Mahfooz wrote:
> >>>>>> Since, overlapping mappings are not supported by the DMA API we should
> >>>>>> report an error if active_cacheline_insert returns -EEXIST.
> >>>>>
> >>>>> It seems this patch found a victim. I was trying to run iperf3 on a
> >>>>> honeycomb (5.14.0, fedora 35) and the console is blasting this error message
> >>>>> at 100% cpu. So, I changed it to a WARN_ONCE() to get the call trace, which
> >>>>> is attached below.
> >>>>>
> >>>>
> >>>> These frags are allocated by the stack, transformed into a scatterlist
> >>>> by skb_to_sgvec and then DMA mapped with dma_map_sg. It was not the
> >>>> dpaa2-eth's decision to use two fragments from the same page (that will
> >>>> also end un in the same cacheline) in two different in-flight skbs.
> >>>>
> >>>> Is this behavior normal?
> >>>>
> >>>
> >>> We see the same problem here and it started with 5.15-rc2 in our nightly CI runs.
> >>> The CI has panic_on_warn enabled so we see the panic every day now.
> >>
> >> Adding a WARN for a case that be detected false-positive seems not
> >> acceptable, exactly for this reason (kernel panic on unaffected
> >> systems).
> >>
> >> So I guess it boils down to the question if the behavior that Ioana
> >> described is legit behavior, on a system that is dma coherent. We
> >> are apparently hitting the same scenario, although it could not yet be
> >> reproduced with debug printks for some reason.
> >>
> >> If the answer is yes, than please remove at lease the WARN, so that
> >> it will not make systems crash that behave valid, and have
> >> panic_on_warn set. Even a normal printk feels wrong to me in that
> >> case, it really sounds rather like you want to fix / better refine
> >> the overlap check, if you want to report anything here.
> > 
> > Dan, Christoph, any opinion?
> > 
> > So far it all looks a lot like a false positive, so could you please
> > see that those patches get reverted? I do wonder a bit why this is
> > not an issue for others, we surely cannot be the only ones running
> > CI with panic_on_warn.
> 
> What convinces you it's a false-positive? I'm hardly familiar with most 
> of that callstack, but it appears to be related to mlx5, and I know that 
> exists on expansion cards which could be plugged into a system with 
> non-coherent PCIe where partial cacheline overlap *would* be a real 
> issue. Of course it's dubious that there are many real use-cases for 
> plugging a NIC with a 4-figure price tag into a little i.MX8 or 
> whatever, but the point is that it *should* still work correctly.

I would assume that a *proper* warning would check if we see the
"non-coherent" case, e.g. by using dev_is_dma_coherent() and only
report with potentially fatal WARN on systems where it is appropriate.

However, I am certainly even less familiar with all that, and might
just have gotten the wrong impression here.

Also not sure about mlx5 relation here, it does not really show
in the call trace, only in the err_printk() output, probably
from dev_driver_string(dev) or dev_name(dev). But I do not see
where mlx5 code would be involved here.

[...]
> According to the streaming DMA API documentation, it is *not* valid:
> 
> ".. warning::
> 
>    Memory coherency operates at a granularity called the cache
>    line width.  In order for memory mapped by this API to operate
>    correctly, the mapped region must begin exactly on a cache line
>    boundary and end exactly on one (to prevent two separately mapped
>    regions from sharing a single cache line).  Since the cache line size
>    may not be known at compile time, the API will not enforce this
>    requirement.  Therefore, it is recommended that driver writers who
>    don't take special care to determine the cache line size at run time
>    only map virtual regions that begin and end on page boundaries (which
>    are guaranteed also to be cache line boundaries)."

Thanks, but I cannot really make a lot of sense out if this. Which
driver exactly would be the one that needs to take care of the
cache line alignment for sg elements? If this WARN is really reporting
a bug, could you please help pointing to where it would need to be
addressed?

And does this really say that it is illegal to have multiple sg elements
within the same cache line, regardless of cache coherence?

Adding linux-rdma@vger.kernel.org, sorry for the noise, but maybe somebody
on that list can make more sense of this.

For reference, the link to the start of this thread:
https://lkml.kernel.org/r/fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
