Return-Path: <SRS0=PSAu=2C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A68C43603
	for <iommu@archiver.kernel.org>; Thu, 12 Dec 2019 19:27:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86E721556
	for <iommu@archiver.kernel.org>; Thu, 12 Dec 2019 19:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL9RAbLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86E721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 990D58842A;
	Thu, 12 Dec 2019 19:27:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JA9-RJ36hRhs; Thu, 12 Dec 2019 19:27:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B587088416;
	Thu, 12 Dec 2019 19:27:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F381C1D81;
	Thu, 12 Dec 2019 19:27:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3B4AC0881
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 19:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E452E2052B
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 19:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pqp9SJdQxeTM for <iommu@lists.linux-foundation.org>;
 Thu, 12 Dec 2019 19:27:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id C56822051D
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576178839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRNZi12NfQovBg9PBpGcHfPyXDNHTvtnfOB+YZa+9mM=;
 b=fL9RAbLEv+Bv/ScBBKqJWstbJDWraxrPToqY3Nh9/2lgNAyw1PuG6UQeWH+q8AcgKT4fkZ
 WamoJ93FpQBD4NlYqqJojVgIOYNzBKDqmZK7JmuhRHnFCxr2VgQPKbCUHyJY9PIUoOBul6
 DULXYaRaPsUsLI8hXh8XgLPvM3PIbUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-CeBb-B9zMIuFnOcsg3aU-A-1; Thu, 12 Dec 2019 14:27:18 -0500
X-MC-Unique: CeBb-B9zMIuFnOcsg3aU-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11B42107ACC5;
 Thu, 12 Dec 2019 19:27:15 +0000 (UTC)
Received: from x1.home (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4724960BB9;
 Thu, 12 Dec 2019 19:27:12 +0000 (UTC)
Date: Thu, 12 Dec 2019 12:27:11 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH] iommu/vt-d: Set ISA bridge reserved region as relaxable
Message-ID: <20191212122711.30e3b8ac@x1.home>
In-Reply-To: <e330865d-6f88-4537-72c6-f0ecc8252327@redhat.com>
References: <157609608124.14870.10855090013879818212.stgit@gimli.home>
 <e330865d-6f88-4537-72c6-f0ecc8252327@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: eauger@redhat.com, cprt@protonmail.com, iommu@lists.linux-foundation.org
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

On Thu, 12 Dec 2019 09:49:37 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 12/11/19 9:28 PM, Alex Williamson wrote:
> > Commit d850c2ee5fe2 ("iommu/vt-d: Expose ISA direct mapping region via
> > iommu_get_resv_regions") created a direct-mapped reserved memory region
> > in order to replace the static identity mapping of the ISA address
> > space, where the latter was then removed in commit df4f3c603aeb
> > ("iommu/vt-d: Remove static identity map code").  According to the
> > history of this code and the Kconfig option surrounding it, this direct
> > mapping exists for the benefit of legacy ISA drivers that are not
> > compatible with the DMA API.
> > 
> > In conjuntion with commit 9b77e5c79840 ("vfio/type1: check dma map
> > request is within a valid iova range") this change introduced a
> > regression where the vfio IOMMU backend enforces reserved memory regions
> > per IOMMU group, preventing userspace from creating IOMMU mappings
> > conflicting with prescribed reserved regions.  A necessary prerequisite
> > for the vfio change was the introduction of "relaxable" direct mappings
> > introduced by commit adfd37382090 ("iommu: Introduce
> > IOMMU_RESV_DIRECT_RELAXABLE reserved memory regions").  These relaxable
> > direct mappings provide the same identity mapping support in the default
> > domain, but also indicate that the reservation is software imposed and
> > may be relaxed under some conditions, such as device assignment.
> > 
> > Convert the ISA bridge direct-mapped reserved region to relaxable to
> > reflect that the restriction is self imposed and need not be enforced
> > by drivers such as vfio.
> > 
> > Fixes: d850c2ee5fe2 ("iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions")  

> Maybe it is rather a fix of my patch, below, since above patch landed
> upstream before the IOMMU_RESV_DIRECT_RELAXABLE availability.
> 
> Fixes: 1c5c59fbad20 ("iommu/vt-d: Differentiate relaxable and non
> relaxable RMRRs")

Sure, if you remember the ordering between these then that might be the
better option.  I checked that they both entered the kernel for
v5.3-rc1 but didn't dig deeper than that.

Joerg, if you'd like a respin for that change let me know, otherwise
just swap my Fixes tag for the one Eric suggests.

> > Cc: stable@vger.kernel.org # v5.3+
> > Link: https://lore.kernel.org/linux-iommu/20191211082304.2d4fab45@x1.home
> > Reported-by: cprt <cprt@protonmail.com>
> > Tested-by: cprt <cprt@protonmail.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Alex

> > ---
> >  drivers/iommu/intel-iommu.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 0c8d81f56a30..6eb0dd7489a1 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5737,7 +5737,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
> >  
> >  		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
> >  			reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
> > -						      IOMMU_RESV_DIRECT);
> > +						   IOMMU_RESV_DIRECT_RELAXABLE);
> >  			if (reg)
> >  				list_add_tail(&reg->list, head);
> >  		}
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >   

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
