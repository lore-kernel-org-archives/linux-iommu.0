Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479ABCCA47C
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 14:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D26208459A;
	Thu, 23 Jun 2022 14:48:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D26208459A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TXilrHjw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EiBzcimaFHKL; Thu, 23 Jun 2022 14:48:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7BBC083EDE;
	Thu, 23 Jun 2022 14:48:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BBC083EDE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3274CC0032;
	Thu, 23 Jun 2022 14:48:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD68C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DEA341754
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:48:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DEA341754
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=TXilrHjw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z80XW3DQgSLP for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 14:47:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD2CF416D4
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD2CF416D4
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:47:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 22A8FB82425
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4860BC341CE
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655995675;
 bh=au8iIbHJe6C0t5TRQVq0kBytOZGBWB60SJOjT91kNOY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TXilrHjwW0ul/jGd3QfygDh1CU4HiF0PU/EzK46nAvJvTnB7XphH5wugAHMs1fdlT
 NAqqU76jOfKTik60xczB0waviSzFdqWuwhXl1/AJhpUVqBXnxgXh+rXRWUZbyIAIfT
 MXY+AAkp/4isrf3wbF/41a4O47pIx0lhHdXXqUpgU3G/wIwHtQ9t7Z0SBnWqXB2wSB
 iVcAM5tuh7hr5MsxeuvRowsH5pMrEP17+mia0+1+NCIgkbthZnCKNQsM5UYKAXvnlK
 6Z4gx88v1vU1izvEInQc+fAMFcfSjnqLgreLl5trAdnQyTagdfqFujQuJEru0fKMmB
 zdJiyNlat54Ng==
Received: by mail-yb1-f179.google.com with SMTP id 23so36229596ybe.8
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:47:55 -0700 (PDT)
X-Gm-Message-State: AJIora9MSKcPPjTwFLT8EtBs1nZSxoCppfnS56yPX3Xtpn1fG1irVdCC
 ilmHmAsALIWj8Tp/Q4MV23Bhfs+MIc4nQxDJ+cM=
X-Google-Smtp-Source: AGRyM1ts0XQnj28PXnyZfJ+lmwDmSBI5jCCoOoZ4U4DnpJA2vL/8Iy7f05Xa3tSfeBpkphX7+GgcnVPiJZGvgoh27MU=
X-Received: by 2002:a25:e808:0:b0:669:7fcf:5f82 with SMTP id
 k8-20020a25e808000000b006697fcf5f82mr9435202ybd.550.1655995674287; Thu, 23
 Jun 2022 07:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-3-arnd@kernel.org>
 <7a6df2da-95e8-b2fd-7565-e4b7a51c5b63@gonehiking.org>
In-Reply-To: <7a6df2da-95e8-b2fd-7565-e4b7a51c5b63@gonehiking.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 23 Jun 2022 16:47:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0t_0scofn_2N1Q8wgJ4panKCN58AgnsJSVEj28K614oQ@mail.gmail.com>
Message-ID: <CAK8P3a0t_0scofn_2N1Q8wgJ4panKCN58AgnsJSVEj28K614oQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scsi: BusLogic remove bus_to_virt
To: Khalid Aziz <khalid@gonehiking.org>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 linux-scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Matt Wang <wwentao@vmware.com>, Parisc List <linux-parisc@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>, Robin Murphy <robin.murphy@arm.com>
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

On Tue, Jun 21, 2022 at 11:56 PM Khalid Aziz <khalid@gonehiking.org> wrote:
> >       while ((comp_code = next_inbox->comp_code) != BLOGIC_INBOX_FREE) {
> > -             /*
> > -                We are only allowed to do this because we limit our
> > -                architectures we run on to machines where bus_to_virt(
> > -                actually works.  There *needs* to be a dma_addr_to_virt()
> > -                in the new PCI DMA mapping interface to replace
> > -                bus_to_virt() or else this code is going to become very
> > -                innefficient.
> > -              */
> > -             struct blogic_ccb *ccb =
> > -                     (struct blogic_ccb *) bus_to_virt(next_inbox->ccb);
> > +             struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter, adapter->next_inbox);
>
> This change looks good enough as workaround to not use bus_to_virt() for
> now. There are two problems I see though. One, I do worry about
> blogic_inbox_to_ccb() returning NULL for ccb which should not happen
> unless the mailbox pointer was corrupted which would indicate a bigger
> problem. Nevertheless a NULL pointer causing kernel panic concerns me.
> How about adding a check before we dereference ccb?

Right, makes sense

> Second, with this patch applied, I am seeing errors from the driver:
>
> =====================
> [ 1623.902685]  sdb: sdb1 sdb2
> [ 1623.903245] sd 2:0:0:0: [sdb] Attached SCSI disk
> [ 1623.911000] scsi2: Illegal CCB #76 status 2 in Incoming Mailbox
> [ 1623.911005] scsi2: Illegal CCB #76 status 2 in Incoming Mailbox
> [ 1623.911070] scsi2: Illegal CCB #79 status 2 in Incoming Mailbox
> [ 1651.458008] scsi2: Warning: Partition Table appears to have Geometry
> 256/63 which is
> [ 1651.458013] scsi2: not compatible with current BusLogic Host Adapter
> Geometry 255/63
> [ 1658.797609] scsi2: Resetting BusLogic BT-958D Failed
> [ 1659.533208] sd 2:0:0:0: Device offlined - not ready after error recovery
> [ 1659.533331] sd 2:0:0:0: Device offlined - not ready after error recovery
> [ 1659.533333] sd 2:0:0:0: Device offlined - not ready after error recovery
> [ 1659.533342] sd 2:0:0:0: [sdb] tag#101 FAILED Result:
> hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=35s
> [ 1659.533345] sd 2:0:0:0: [sdb] tag#101 CDB: Read(10) 28 00 00 00 00 28
> 00 00 10 00
> [ 1659.533346] I/O error, dev sdb, sector 40 op 0x0:(READ) flags 0x80700
> phys_seg 1 prio class 0
>
> =================
>
> This is on VirtualBox using emulated BusLogic adapter.
>
> This patch needs more refinement.

Thanks for testing the patch, too bad it didn't work. At least I quickly found
one stupid mistake on my end, hope it's the only one.

Can you test it again with this patch on top?

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index d057abfcdd5c..9e67f2ee25ee 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2554,8 +2554,14 @@ static void blogic_scan_inbox(struct
blogic_adapter *adapter)
        enum blogic_cmplt_code comp_code;

        while ((comp_code = next_inbox->comp_code) != BLOGIC_INBOX_FREE) {
-               struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter,
adapter->next_inbox);
-               if (comp_code != BLOGIC_CMD_NOTFOUND) {
+               struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter,
next_inbox);
+               if (!ccb) {
+                       /*
+                        * This should never happen, unless the CCB list is
+                        * corrupted in memory.
+                        */
+                       blogic_warn("Could not find CCB for dma
address 0x%x\n", adapter, next_inbox->ccb);
+               } else if (comp_code != BLOGIC_CMD_NOTFOUND) {
                        if (ccb->status == BLOGIC_CCB_ACTIVE ||
                                        ccb->status == BLOGIC_CCB_RESET) {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
