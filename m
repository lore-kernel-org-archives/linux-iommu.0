Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A019EC433DF
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:03:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4201D2075E
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+sE0UZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4201D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DCC6120773;
	Thu, 18 Jun 2020 15:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oIG-FhQboBNX; Thu, 18 Jun 2020 15:03:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7F05720528;
	Thu, 18 Jun 2020 15:03:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E3E2C07FF;
	Thu, 18 Jun 2020 15:03:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5CFEC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8DC6288364
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id egcMgPWESvXP for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:03:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 922298832D
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592492614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6QMulUcf3PlGaHVamIGvyTjSJ46/ODEDY2mInJBKDZI=;
 b=O+sE0UZUvUY1jhx6hrPGOqxZ4gEc3JO1VeO/Y3aDOb6rU2gS6HONcT/1kxZEiLr2heXi0z
 58/btDYCPjMcdiiBeiZvYIbJ87HZh6of7b+pttPavcDGEIWr/hUeIjzFMDbH4HIXdxHcPL
 Y3pPVuYRiuJ5fNyyALCm72i8X8YahyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-ROYba9Q7NLyFHwQDXYTagA-1; Thu, 18 Jun 2020 11:03:31 -0400
X-MC-Unique: ROYba9Q7NLyFHwQDXYTagA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B6A68018D9;
 Thu, 18 Jun 2020 15:03:30 +0000 (UTC)
Received: from w520.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF28419D7B;
 Thu, 18 Jun 2020 15:03:29 +0000 (UTC)
Date: Thu, 18 Jun 2020 09:03:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [Regression] Re: [PATCH 18/18] iommu/vt-d: Remove IOVA handling
 code from the non-dma_ops path
Message-ID: <20200618090329.2d38f697@w520.home>
In-Reply-To: <4548c140-c0db-8e17-d3a7-7dfc5f5ca576@linux.intel.com>
References: <20200516062101.29541-1-baolu.lu@linux.intel.com>
 <20200516062101.29541-19-baolu.lu@linux.intel.com>
 <20200617140639.7ed58926@x1.home>
 <4548c140-c0db-8e17-d3a7-7dfc5f5ca576@linux.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>
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

On Thu, 18 Jun 2020 09:52:56 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Alex,
> 
> Thanks for the report.
> 
> On 6/18/20 4:06 AM, Alex Williamson wrote:
> > On Sat, 16 May 2020 14:21:01 +0800
> > Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> >   
> >> From: Tom Murphy<murphyt7@tcd.ie>
> >>
> >> There's no need for the non-dma_ops path to keep track of IOVAs. The
> >> whole point of the non-dma_ops path is that it allows the IOVAs to be
> >> handled separately. The IOVA handling code removed in this patch is
> >> pointless.
> >>
> >> Signed-off-by: Tom Murphy<murphyt7@tcd.ie>
> >> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/intel-iommu.c | 95 +++++++++++++------------------------
> >>   1 file changed, 32 insertions(+), 63 deletions(-)  
> > This commit results in a massive increase in memory use from the VT-d
> > code.  I have a 16GB system where I reserve 7168 2MB hugespages for VM
> > usage (14GB), leaving the host with 2GB.  I can no longer even boot the
> > host in this configuration.  Bisecting to this commit, I find that
> > reverting this change shows the following memory usage difference
> > immediately after boot (no hugepages, nosmp, single user,
> > intel_iommu=on iommu=pt):
> > 
> > @e70b081c6f37:
> >               total        used        free      shared  buff/cache   available
> > Mem:       16090860     2219372    13673044        1040      198444    13602664
> > Swap:       2097148           0     2097148
> > 
> > reverting e70b081c6f37:
> >                total        used        free      shared  buff/cache   available
> > Mem:       16090852      101648    15789156        1040      200048    15719572
> > Swap:       2097148           0     2097148
> > 
> > More than 2GB of additional memory used!  There's also a notable stall
> > during bootup for this allocation:
> > 
> > [    9.703360] DMAR: No ATSR found
> > [    9.709768] DMAR: dmar0: Using Queued invalidation
> > [    9.719370] DMAR: dmar1: Using Queued invalidation
> > 
> > ### 4+ seconds! ###
> > 
> > [   14.076387] pci 0000:00:00.0: Adding to iommu group 0
> > [   14.086515] pci 0000:00:01.0: Adding to iommu group 1
> > [   14.096635] pci 0000:00:02.0: Adding to iommu group 2  
> 
> Can you please try below changes?
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 887f184b900d..7eb29167e8f9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2705,7 +2705,9 @@ static int __init si_domain_init(int hw)
>                                      end >> agaw_to_width(si_domain->agaw)))
>                                  continue;
> 
> -                       ret = iommu_domain_identity_map(si_domain, 
> start, end);
> +                       ret = iommu_domain_identity_map(si_domain,
> +                                       mm_to_dma_pfn(start >> PAGE_SHIFT),
> +                                       mm_to_dma_pfn(end >> PAGE_SHIFT));
>                          if (ret)
>                                  return ret;
>                  }

Yes, this resolves it.  Used memory after boot returns to similar
numbers as without this commit.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
