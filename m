Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A120BC432C0
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 18:22:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680192067D
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 18:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="FQbLHBCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680192067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 499A08713E;
	Thu, 21 Nov 2019 18:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ygvV3-SD2rM; Thu, 21 Nov 2019 18:21:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CB9CD8712E;
	Thu, 21 Nov 2019 18:21:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC40CC1DD7;
	Thu, 21 Nov 2019 18:21:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73E3BC18DA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 18:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 69BE32563C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 18:21:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c51pgRwPQZoU for <iommu@lists.linux-foundation.org>;
 Thu, 21 Nov 2019 18:21:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.52])
 by silver.osuosl.org (Postfix) with ESMTPS id E39D020478
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574360508;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=jNSqqBbrYyqRlctFmIILYVh2+dTk9ekgd8eo+LGizrs=;
 b=FQbLHBCpCZ20QVnOqFEiJS+ai3DePe/VhpaWXZe9OhrHAlADzgcM6VoQ0T52wro3n6
 8oUWIzyIXLeUjrxpqEfgmc68kjLEIZnYkQXfdY3oQseC2tKWLUd9SKg2O8DLu3zqnaCh
 Zg7U3w6pT+v7Yz75xSF/AU6jFaVOqt5yxBeq2RBFJAwzWuOOOWfd2+Fuc8mKpQxro0vY
 ox0MXKaOUslNMS1GPth7iWvVoSCi+alR2utp6QsNpgyPqpfra9eQNkebg6bNhQGxCKLa
 qtf79fjD5is4NIMw59iixqfUrICGtrv1lFkmDIfray0OHzFS2/urHg75qodbgb6O9W21
 7SUA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4QgaM9fNtIXuaJFG8GgaIfjP/sNprV1dfhtth/q6Z5w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:31b4:3e86:1da2:8b32]
 by smtp.strato.de (RZmta 44.29.0 AUTH)
 with ESMTPSA id q007c8vALIL5lAy
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 21 Nov 2019 19:21:05 +0100 (CET)
Mime-Version: 1.0 (1.0)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <20191121180226.GA3852@lst.de>
Date: Thu, 21 Nov 2019 19:21:04 +0100
Message-Id: <0F53CCCE-738C-4024-9C3C-4BDEB0D0728C@xenosoft.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, darren@stevens-zone.net, rtd2@xtra.co.nz,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, paulus@samba.org,
 mad skateman <madskateman@gmail.com>, "contact@a-eon.com" <contact@a-eon.com>,
 Robin Murphy <robin.murphy@arm.com>, nsaenzjulienne@suse.de
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

On 21. Nov 2019, at 19:02, Christoph Hellwig <hch@lst.de> wrote:

On Thu, Nov 21, 2019 at 05:34:48PM +0100, Christian Zigotzky wrote:
I modified the patch and compiled a new RC8 of kernel 5.4 today. (patch 
attached)

We have to wait to Rolands test results with his SCSI PCI card. I tested it 
today but my TV card doesn't work with this patch.

I think we have two sorta overlapping issues here.  One is that I think
we need the bus_dma_limit, which should mostly help for something like
a SCSI controller that doesn't need streaming mappings (btw, do we
have more details on that somewhere?).

And something weird with the videobuf things.  Your change of the dma
masks suggests that the driver doesn't do the right allocations and thus
hits bounce buffering (swiotlb).  We should fix that for real, but the
fact that the bounce buffering itself also fails is even more interesting.

Can you try this git branch:

   git://git.infradead.org/users/hch/misc.git fsl-dma-debugging

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/fsl-dma-debugging

and send me the dmesg with that with your TV adapter?

- - -

Yes, I will test it at the weekend. Thanks for your help.

Christian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
