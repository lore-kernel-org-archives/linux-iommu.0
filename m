Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2907FC31E44
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 01:07:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5F720866
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 01:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dOhGUtsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5F720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B327014A4;
	Wed, 12 Jun 2019 01:07:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BE66C1497
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 01:05:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4A888E6
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 01:05:01 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x5C14Ac0006780; Wed, 12 Jun 2019 01:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=SMgI7h2wwqxIZjG0qWoXTL05mqIN7/DG3AzEmKOzYWY=;
	b=dOhGUtsMBzfnXA0+F8jZcjlUHETN6uRn4mAzprD/4KlpegcFnjVw/Ga4dpDZyc4gqE8Y
	8RLIoiNEe/t8cORAq58WWxH72eCUF3iZBUKhEerZ7wHleTi65yns7+dokVtHdAubQQWb
	WXIstmtRTY/0JPpBstHUn8DH8IjgUEjwwWBXWkOIaRaUVpmaGxrs73PY1ox1WIw/FW4x
	jwJTjKKjxCFLSYQ3qWo7czReZJ/kref3KFzRmPeso/9LD5WqnkOthPKxF4jJYMlNDK1d
	NhFIHFlrKxo+H3eFvu51KMCpt5P0YWmip2KyefEuKIef23NuNLoodmPyDPRFGH5qj2De
	tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2t05nqr96w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2019 01:04:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x5C14A4c021922; Wed, 12 Jun 2019 01:04:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 2t0p9rkg31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2019 01:04:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5C13x83029202;
	Wed, 12 Jun 2019 01:03:59 GMT
Received: from char.us.oracle.com (/10.152.32.25)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 11 Jun 2019 18:03:58 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
	id D6D0E6A00D8; Tue, 11 Jun 2019 21:05:18 -0400 (EDT)
Date: Tue, 11 Jun 2019 21:05:18 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 3/9] swiotlb: Zero out bounce buffer for untrusted
	device
Message-ID: <20190612010518.GB22479@char.us.oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
	<20190603011620.31999-4-baolu.lu@linux.intel.com>
	<20190610154553.GT28796@char.us.oracle.com>
	<ec6ac2ba-7b88-2bcf-aa95-f8981b258c5c@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ec6ac2ba-7b88-2bcf-aa95-f8981b258c5c@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906120005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906120005
Cc: Juergen Gross <jgross@suse.com>, kevin.tian@intel.com,
	Stefano Stabellini <sstabellini@kernel.org>,
	mika.westerberg@linux.intel.com, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, alan.cox@intel.com,
	Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	pengfei.xu@intel.com, Ingo Molnar <mingo@redhat.com>,
	jacob.jun.pan@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Wed, Jun 12, 2019 at 08:43:40AM +0800, Lu Baolu wrote:
> Hi Konrad,
> 
> Thanks a lot for your reviewing.
> 
> On 6/10/19 11:45 PM, Konrad Rzeszutek Wilk wrote:
> > On Mon, Jun 03, 2019 at 09:16:14AM +0800, Lu Baolu wrote:
> > > This is necessary to avoid exposing valid kernel data to any
> > > milicious device.
> > 
> > malicious
> 
> Yes, thanks.
> 
> > 
> > > 
> > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > ---
> > >   kernel/dma/swiotlb.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index f956f785645a..ed41eb7f6131 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -35,6 +35,7 @@
> > >   #include <linux/scatterlist.h>
> > >   #include <linux/mem_encrypt.h>
> > >   #include <linux/set_memory.h>
> > > +#include <linux/pci.h>
> > >   #ifdef CONFIG_DEBUG_FS
> > >   #include <linux/debugfs.h>
> > >   #endif
> > > @@ -560,6 +561,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> > >   	 */
> > >   	for (i = 0; i < nslots; i++)
> > >   		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
> > > +
> > > +	/* Zero out the bounce buffer if the consumer is untrusted. */
> > > +	if (dev_is_untrusted(hwdev))
> > > +		memset(phys_to_virt(tlb_addr), 0, alloc_size);
> > 
> > What if the alloc_size is less than a PAGE? Should this at least have ALIGN or such?
> 
> It's the consumer (iommu subsystem) who requires this to be page
> aligned. For swiotlb, it just clears out all data in the allocated
> bounce buffer.

I am thinking that the if you don't memset the full page the malicious hardware could read stale date from the rest of the page
that hasn't been cleared?

> 
> Best regards,
> Baolu
> 
> > 
> > > +
> > >   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> > >   	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
> > >   		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
> > > -- 
> > > 2.17.1
> > > 
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
