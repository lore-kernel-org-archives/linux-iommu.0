Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F01C2D0EF
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 02:00:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA79120A8B
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 02:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izw+pmjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA79120A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F45788263;
	Tue, 31 Mar 2020 02:00:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sKx-sq7qx6vD; Tue, 31 Mar 2020 02:00:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 69EB88818B;
	Tue, 31 Mar 2020 02:00:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4751DC1AE8;
	Tue, 31 Mar 2020 02:00:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C9BFC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 02:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0B45E84AE2
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 02:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eefd0FWIdr-q for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 02:00:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [216.205.24.74])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 71AB484A0B
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585620013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J7J/WvCRzFDPjN13KVOAH7X96x+em5mLjdDYjxy7JL4=;
 b=izw+pmjLC9dr8T/qpYUQs11AqhXiRYs39kJdLJFRNcNyCXj6CXrmK4pmmJe1l8bSmI7RkI
 67WEKcjLxqiUEIOnbfcWfU0WxHcAlEczvKE+AyhzThyJEqK83+tKfXDFRlSZMuHc5paU6v
 aLPnCr8y9svIl4iCkem4fVdsuYte0U8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-EpzUZZB8O_GoilF-gs7kdA-1; Mon, 30 Mar 2020 22:00:09 -0400
X-MC-Unique: EpzUZZB8O_GoilF-gs7kdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 179D58017DF;
 Tue, 31 Mar 2020 02:00:06 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-247.pek2.redhat.com
 [10.72.12.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40CA15DA60;
 Tue, 31 Mar 2020 01:59:52 +0000 (UTC)
Date: Tue, 31 Mar 2020 09:59:49 +0800
From: Dave Young <dyoung@redhat.com>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200331015949.GB81569@dhcp-128-65.nay.redhat.com>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
 <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
 <20200330134004.GA31026@char.us.oracle.com>
 <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Mark Rutland <mark.rutland@arm.com>, brijesh.singh@amd.com,
 Lianbo Jiang <lijiang@redhat.com>, linux-doc@vger.kernel.org,
 Jan Kiszka <jan.kiszka@siemens.com>, "Schoenherr, Jan H." <jschoenh@amazon.de>,
 Christoph Hellwig <hch@lst.de>, the arch/x86 maintainers <x86@kernel.org>,
 anthony.yznaga@oracle.com, Laszlo Ersek <lersek@redhat.com>, aggh@amazon.com,
 "Lendacky, Thomas" <thomas.lendacky@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, alcioa@amazon.com,
 dhr@amazon.com, Jan Setje-Eilers <jan.setjeeilers@oracle.com>, benh@amazon.com,
 Kairui Song <kasong@redhat.com>, kexec@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, aagch@amazon.com,
 Robin Murphy <robin.murphy@arm.com>, dwmw@amazon.com
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

Hi,

[snip]
> 2) Reuse the SWIOTLB from the previous boot on kexec/kdump

We should only care about kdump

> 
> I see little direct relation to SEV here. The only reason SEV makes it more
> relevant, is that you need to have an SWIOTLB region available with SEV
> while without you could live with a disabled IOMMU.


Here is some comment in arch/x86/kernel/pci-swiotlb.c, it is enforced
for some reason.
        /*
         * If SME is active then swiotlb will be set to 1 so that bounce
         * buffers are allocated and used for devices that do not support
         * the addressing range required for the encryption mask.
         */
        if (sme_active())
                swiotlb = 1;

> 
> However, I can definitely understand how you would want to have a way to
> tell the new kexec'ed kernel where the old SWIOTLB was, so it can reuse its
> memory for its own SWIOTLB. That way, you don't have to reserve another 64MB
> of RAM for kdump.
> 
> What I'm curious on is whether we need to be as elaborate. Can't we just
> pass the old SWIOTLB as free memory to the new kexec'ed kernel and
> everything else will fall into place? All that would take is a bit of
> shuffling on the e820 table pass-through to the kexec'ed kernel, no?

Maybe either of the two is fine.  But we may need ensure these swiotlb
area to be reused explictly in some way.  Say about the crashkernel=X,high case,
major part is in above 4G region, and a small piece in low memory. Then
when kernel booting, kernel/driver initialization could use out of the
low memory, and the remain part for swiotlb could be not big enough and
finally swiotlb allocation fails. 

Thanks
Dave

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
