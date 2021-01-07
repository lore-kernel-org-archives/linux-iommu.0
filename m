Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB170C433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 18:04:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8468D23403
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 18:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8468D23403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2EC6F86AF2;
	Thu,  7 Jan 2021 18:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FZjynJ31-Zvc; Thu,  7 Jan 2021 18:04:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 898BC8610E;
	Thu,  7 Jan 2021 18:04:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74D6BC0891;
	Thu,  7 Jan 2021 18:04:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE68C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 18:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0C23286AE9
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 18:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BFoyEd57gJUB for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 18:04:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5E1088610E
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 18:04:51 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107HrhgY122489;
 Thu, 7 Jan 2021 18:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ONFAFUzWR9/dYKX6R5UPSmvsMe/XM4yxSwwcXYnlluo=;
 b=k3kFeIEgW4vzaR4ZfvPTjVDuH82iItpQcMeLnIZSpNlBXO/nlBJ/2BedFegemuW7x/n9
 5T6zuoIODh1nvQIYNbV9vtdd0rkp3MUUvbNymJpULPQWthCaupOJ61QzYsXDU2hvVRhn
 qSOhtKNsApENoFNmZMg9EGRXgSsWsgqbyJEs0W+O4pQl3q7wgB3x2Tc1NIu0vNPjaYLF
 ahKo9px5Rnbgx2GNFk96Gn3MxndBpVBPpEgZqrkAzR0w7bYROrVdVAjXFF1piDy5oe49
 6/Q4bDILkejn3BnDHnJupHVRcGxIzzKa+mHpAQh45hxoZjVrh8Rc5ocBK4sOtLZhDO5Y lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 35wftxd6hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 07 Jan 2021 18:02:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107HsxJ2096626;
 Thu, 7 Jan 2021 18:00:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 35v1fbhu8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Jan 2021 18:00:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 107I0YBv019522;
 Thu, 7 Jan 2021 18:00:34 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 07 Jan 2021 18:00:33 +0000
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 56A6B6A00C3; Thu,  7 Jan 2021 13:00:32 -0500 (EST)
Date: Thu, 7 Jan 2021 13:00:32 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [RFC PATCH v3 5/6] dt-bindings: of: Add restricted DMA pool
Message-ID: <20210107180032.GB16519@char.us.oracle.com>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-6-tientzu@chromium.org>
 <20210106185757.GB109735@localhost.localdomain>
 <CALiNf2_dV13jbHqLt-r1eK+dtOcAKBGcWQCVMQn+eL6MuOrETQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALiNf2_dV13jbHqLt-r1eK+dtOcAKBGcWQCVMQn+eL6MuOrETQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070105
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, rafael.j.wysocki@intel.com, Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, will@kernel.org,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 rdunlap@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 xypron.glpk@gmx.de, Robin Murphy <robin.murphy@arm.com>
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

On Fri, Jan 08, 2021 at 01:39:43AM +0800, Claire Chang wrote:
> On Thu, Jan 7, 2021 at 2:58 AM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
> >
> > On Wed, Jan 06, 2021 at 11:41:23AM +0800, Claire Chang wrote:
> > > Introduce the new compatible string, restricted-dma-pool, for restricted
> > > DMA. One can specify the address and length of the restricted DMA memory
> > > region by restricted-dma-pool in the device tree.
> > >
> > > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > > ---
> > >  .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > index e8d3096d922c..44975e2a1fd2 100644
> > > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > @@ -51,6 +51,20 @@ compatible (optional) - standard definition
> > >            used as a shared pool of DMA buffers for a set of devices. It can
> > >            be used by an operating system to instantiate the necessary pool
> > >            management subsystem if necessary.
> > > +        - restricted-dma-pool: This indicates a region of memory meant to be
> > > +          used as a pool of restricted DMA buffers for a set of devices. The
> > > +          memory region would be the only region accessible to those devices.
> > > +          When using this, the no-map and reusable properties must not be set,
> > > +          so the operating system can create a virtual mapping that will be used
> > > +          for synchronization. The main purpose for restricted DMA is to
> > > +          mitigate the lack of DMA access control on systems without an IOMMU,
> > > +          which could result in the DMA accessing the system memory at
> > > +          unexpected times and/or unexpected addresses, possibly leading to data
> > > +          leakage or corruption. The feature on its own provides a basic level
> > > +          of protection against the DMA overwriting buffer contents at
> > > +          unexpected times. However, to protect against general data leakage and
> > > +          system memory corruption, the system needs to provide way to restrict
> > > +          the DMA to a predefined memory region.
> >
> > Heya!
> >
> > I think I am missing something obvious here so please bear with my
> > questions:
> >
> >  - This code adds the means of having the SWIOTLB pool tied to a specific
> >    memory correct?
> 
> It doesn't affect the existing SWIOTLB. It just utilizes the existing SWIOTLB
> code to create another DMA pool tied to a specific memory region for a given set
> of devices. It bounces the streaming DMA (map/unmap) in and out of that region
> and does the memory allocation (dma_direct_alloc) from the same region.

Right, so why can't it follow the same mechanism that Xen SWIOTLB does - which
had exactly the same problem (needed special handling on the pool) - and do
a similar code?

> 
> >
> >
> >  - Nothing stops the physical device from bypassing the SWIOTLB buffer.
> >    That is if an errant device screwed up the length or DMA address, the
> >    SWIOTLB would gladly do what the device told it do?
> 
> So the system needs to provide a way to lock down the memory access, e.g. MPU.

OK! Would it be prudent to have this in the description above perhaps?
> 
> >
> >  - This has to be combined with SWIOTLB-force-ish to always use the
> >    bounce buffer, otherwise you could still do DMA without using
> >    SWIOTLB (by not hitting the criteria for needing to use SWIOTLB)?
> 
> Since restricted DMA is for the devices that are not behind an IOMMU, I change
> the criteria
> `if (unlikely(swiotlb_force == SWIOTLB_FORCE))`
> to
> `if (unlikely(swiotlb_force == SWIOTLB_FORCE) || dev->dma_io_tlb_mem)`
> in dma_direct_map_page().
> 
> Also, even if SWIOTLB=force, the restricted DMA pool is preferred if available
> (get_io_tlb_mem in https://lore.kernel.org/patchwork/patch/1360995/).
> 
> Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
