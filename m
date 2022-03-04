Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABA1C433F5
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 16:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDA10841A2;
	Fri,  4 Mar 2022 16:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c6Gv1GcnDMGa; Fri,  4 Mar 2022 16:55:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C3E9283312;
	Fri,  4 Mar 2022 16:55:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B5A7C0012;
	Fri,  4 Mar 2022 16:55:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD565C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87D638418F
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:55:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rk7CO65Cc838 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:55:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBCB383312
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:55:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 200DAB82A88;
 Fri,  4 Mar 2022 16:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1876C340E9;
 Fri,  4 Mar 2022 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1646412944;
 bh=B+UV2G70h7lvv+8DpIMYl/VkQqHKKqEhFln4Go7FLAs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yrtl1+N2serLhyYw9ro0Lc+ScqdI+QhjwGsZ0Xcn8nioqaibMGTcmY1W15X8iYB1F
 qAxiCwOm2XWiux8ofFHdnD0uHKn8HsMYLNsBVOnRmslIyO7dFoMT2jypzsNiaDbhAq
 9eFsm7WD16wtZniLKMPz3NP/VREUDo22CgO2S7xA=
Date: Fri, 4 Mar 2022 17:55:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/2] Revert "swiotlb: fix info leak with DMA_FROM_DEVICE"
Message-ID: <YiJEjLdpXoGxtJsO@kroah.com>
References: <20220304135859.3521513-1-pasic@linux.ibm.com>
 <20220304135859.3521513-2-pasic@linux.ibm.com>
 <YiIiHD7uA1o7Sj1X@kroah.com>
 <20220304173447.27dc0798.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220304173447.27dc0798.pasic@linux.ibm.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-doc@vger.kernel.org,
 stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Doug Gilbert <dgilbert@interlog.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
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

On Fri, Mar 04, 2022 at 05:34:47PM +0100, Halil Pasic wrote:
> On Fri, 4 Mar 2022 15:28:44 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Mar 04, 2022 at 02:58:58PM +0100, Halil Pasic wrote:
> > > This reverts commit ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e.  
> > 
> > Why???
> 
> TLDR; We got v4 merged instead of v7

That makes no sense at all to me, you need to describe it in detail.

You know better than this :(

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
