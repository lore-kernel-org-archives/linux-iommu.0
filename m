Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E880C2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 15:25:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617862074B
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 15:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lZRNvvZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617862074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4FA22038F;
	Wed,  4 Nov 2020 15:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dOhPFd4H-vdQ; Wed,  4 Nov 2020 15:25:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0AF8420011;
	Wed,  4 Nov 2020 15:25:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCB51C0889;
	Wed,  4 Nov 2020 15:25:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8C33C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 15:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8D40F20377
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 15:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j3mK25FthjTX for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 15:09:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by silver.osuosl.org (Postfix) with ESMTPS id 0D2472036B
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 15:09:09 +0000 (UTC)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A4F3rtH140070
 for <iommu@lists.linux-foundation.org>; Wed, 4 Nov 2020 10:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=in-reply-to : subject :
 from : to : cc : date : references : content-type : message-id :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7FPG47AqrPRMgjGCg5C10UsZjtjnYr6jvMRwngJtz2c=;
 b=lZRNvvZpYv2B/HjwDd5zuwzB8z+v5DmCiQ4u0ir3nMxiWAvgOwxZRUmKOguXO6/Fbwiu
 wlyK4KNVXPWL6tKaMgCe7VULcTdZKzpXVhc+GLhH6fyYN5lqgF7Vzrewmw5JB1LxOa58
 yASFCasc3eIqQKtoI3sk8KI3ns26U2YgWDxJW+zLUXH4ISmeKNGGBUSk5EkEl1sdkBVh
 4E7tiNtpGxww3kxSiBIcNZqZ+PIJozN5xEPBIazM17r8u6ovX7w2tC7jHU7J38Nev628
 MYRfr681Ay8FbDi69RZDgAU+CaLI8PO15GDGsTj+ugzNf1MW5KXPMhOnMu2mSrJM4Byh Mg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [158.85.210.112])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34ksrujc1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <iommu@lists.linux-foundation.org>; Wed, 04 Nov 2020 10:09:08 -0500
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <iommu@lists.linux-foundation.org> from <BMT@zurich.ibm.com>;
 Wed, 4 Nov 2020 15:09:07 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
 by smtp.notes.na.collabserv.com (10.122.47.54) with
 smtp.notes.na.collabserv.com ESMTP; Wed, 4 Nov 2020 15:09:05 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
 by us1b3-smtp04.a3dr.sjc01.isc4sb.com
 with ESMTP id 2020110415090513-490636 ;
 Wed, 4 Nov 2020 15:09:05 +0000 
In-Reply-To: <20201104140108.GA5674@lst.de>
Subject: Re: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
From: "Bernard Metzler" <BMT@zurich.ibm.com>
To: "Christoph Hellwig" <hch@lst.de>
Date: Wed, 4 Nov 2020 15:09:04 +0000
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20201104140108.GA5674@lst.de>,
 <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de> <20201104134241.GP36674@ziepe.ca>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: FDBE80DE:245A259C-00258616:00528DDA;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 54487
X-TNEFEvaluated: 1
x-cbid: 20110415-4615-0000-0000-0000030A33C5
X-IBM-SpamModules-Scores: BY=0.020974; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.378364; ST=0; TS=0; UL=0; ISC=; MB=0.000014
X-IBM-SpamModules-Versions: BY=3.00014135; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01459084; UDB=6.00785062; IPR=6.01241745; 
 MB=3.00034858; MTD=3.00000008; XFM=3.00000015; UTC=2020-11-04 15:09:06
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-11-04 13:11:13 - 6.00012032
x-cbparentid: 20110415-4616-0000-0000-000003BC3BEE
Message-Id: <OFFDBE80DE.245A259C-ON00258616.00528DDA-00258616.00533A9D@notes.na.collabserv.com>
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-04_08:2020-11-04,
 2020-11-04 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
X-Mailman-Approved-At: Wed, 04 Nov 2020 15:25:14 +0000
Cc: linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>
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

-----"Christoph Hellwig" <hch@lst.de> wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Christoph Hellwig" <hch@lst.de>
>Date: 11/04/2020 03:02PM
>Cc: "Christoph Hellwig" <hch@lst.de>, "Bjorn Helgaas"
><bhelgaas@google.com>, "Logan Gunthorpe" <logang@deltatee.com>,
>linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
>iommu@lists.linux-foundation.org
>Subject: [EXTERNAL] Re: [PATCH 2/5] RDMA/core: remove use of
>dma_virt_ops
>
>On Wed, Nov 04, 2020 at 09:42:41AM -0400, Jason Gunthorpe wrote:
>> On Wed, Nov 04, 2020 at 10:50:49AM +0100, Christoph Hellwig wrote:
>> 
>> > +int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist
>*sg, int nents)
>> > +{
>> > +	struct scatterlist *s;
>> > +	int i;
>> > +
>> > +	for_each_sg(sg, s, nents, i) {
>> > +		sg_dma_address(s) = (uintptr_t)sg_virt(s);
>> > +		sg_dma_len(s) = s->length;
>> 
>> Hmm.. There is nothing ensuring the page is mapped here for this
>> sg_virt(). Before maybe some of the kconfig stuff prevented highmem
>> systems indirectly, I wonder if we should add something more direct
>to
>> exclude highmem for these drivers?
>
>I had actually noticed this earlier as well and then completely
>forgot
>about it..
>
>rdmavt depends on X86_64, so it can't be used with highmem, but for
>rxe and siw there weren't any such dependencies so I think we were
>just
>lucky.  Let me send a fix to add explicit depencies and then respin
>this
>series on top of that..
>
>> Sigh. I think the proper fix is to replace addr/length with a
>> scatterlist pointer in the struct ib_sge, then have SW drivers
>> directly use the page pointer properly.
>
>The proper fix is to move the DMA mapping into the RDMA core, yes.
>And as you said it will be hard.  But I don't think scatterlists
>are the right interface.  IMHO we can keep re-use the existing
>struct ib_sge:
>
>struct ib_ge {
>	u64     addr;
>	u32     length;
>	u32     lkey;
>};
>
>with the difference that if lkey is not a MR, addr is the physical
>address of the memory, not a dma_addr_t or virtual address.
>

lkey of zero to pass a physical buffer, only allowed for
kernel applications? Very nice idea I think.

btw.
It would even get the vain blessing of the old IETF RDMA
verbs draft ;)

https://tools.ietf.org/html/draft-hilland-rddp-verbs-00#page-90


(section '7.2.1 STag of zero' - read lkey for STag)


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
