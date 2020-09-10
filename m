Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33EAC43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 02:17:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6344521D40
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 02:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jF6zOfls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6344521D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ED11E8759E;
	Thu, 10 Sep 2020 02:17:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQs1ukIXtUl8; Thu, 10 Sep 2020 02:17:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DDA8E87561;
	Thu, 10 Sep 2020 02:17:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E163C0052;
	Thu, 10 Sep 2020 02:17:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E5C7C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 02:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7426186DB4
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 02:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D718nZ6kFgBL for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 02:17:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2CC938698F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 02:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599704260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hRuaCM4UO0QYlTpMIEqBgJQxJgieRpUxJTH6YhefOQ=;
 b=jF6zOfls+0ksvegN9SXwWt6wpl3j55B5IUmgEjyJHeVduUjjaUNT4BgmI3UHDJlN83I3Sj
 KR4y4XM7oU5bbyKqJ2SctcdDrhVfJPmZnh6ex9FvUh6k0QPou8wYzde51+6UUBmQ2AQNZ5
 xsWrFp9O7oakV0as+UCn+BS4y1679xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-levCQ31sNTGtP_svl2bqAA-1; Wed, 09 Sep 2020 22:17:38 -0400
X-MC-Unique: levCQ31sNTGtP_svl2bqAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8D7E1882FB0;
 Thu, 10 Sep 2020 02:17:36 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC6151002393;
 Thu, 10 Sep 2020 02:17:36 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 953A018095FF;
 Thu, 10 Sep 2020 02:17:36 +0000 (UTC)
Date: Wed, 9 Sep 2020 22:17:35 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
To: Ashok Raj <ashok.raj@intel.com>
Message-ID: <491540137.16465450.1599704255365.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200909171056.GF104641@otc-nc-03>
References: <20200909083432.9464-1-jasowang@redhat.com>
 <20200909171056.GF104641@otc-nc-03>
Subject: Re: [PATCH] intel-iommu: don't disable ATS for device without page
 aligned request
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.24]
Thread-Topic: intel-iommu: don't disable ATS for device without page aligned
 request
Thread-Index: OZU0O/7OadpZCvrZzmt7QzTbbYaicg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 Keith Busch <keith.busch@intel.com>, eperezma@redhat.com,
 iommu@lists.linux-foundation.org, stable@vger.kernel.org, dwmw2@infradead.org
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



----- Original Message -----
> Hi Jason
> 
> On Wed, Sep 09, 2020 at 04:34:32PM +0800, Jason Wang wrote:
> > Commit 61363c1474b1 ("iommu/vt-d: Enable ATS only if the device uses
> > page aligned address.") disables ATS for device that can do unaligned
> > page request.
> 
> Did you take a look at the PCI specification?
> Page Aligned Request is in the ATS capability Register.
> 
> ATS Capability Register (Offset 0x04h)
> 
> bit (5):
> Page Aligned Request - If Set, indicates the Untranslated address is always
> aligned to 4096 byte boundary. Setting this field is recommended. This
> field permits software to distinguish between implemntations compatible
> with this specification and those compatible with an earlier version of
> this specification in which a Requester was permitted to supply anything in
> bits [11:2].

Yes, my understanding is that this is optional not mandatory.

> 
> > 
> > This looks wrong, since the commit log said it's because the page
> > request descriptor doesn't support reporting unaligned request.
> 
> I don't think you can change the definition from ATS to PRI. Both are
> orthogonal feature.

I may miss something, here's my understanding is that:

- page request descriptor will only be used when PRS is enabled
- ATS spec allows unaligned request

So any reason for disabling ATS for unaligned request even if PRS is
not enabled?

> 
> > 
> > A victim is Qemu's virtio-pci which doesn't advertise the page aligned
> > address. Fixing by disable PRI instead of ATS if device doesn't have
> > page aligned request.
> 
> This is a requirement for the Intel IOMMU's.
> 
> You say virtio, so is it all emulated device or you talking about some
> hardware that implemented virtio-pci compliant hw? If you are sure the
> device actually does comply with the requirement, but just not enumerating
> the capability, you can maybe work a quirk to overcome that?

So far only emulated devices. But we are helping some vendor to
implement virtio hardware so  we need to understand the connection
between ATS alignment and page request descriptor.

> 
> Now PRI also has an alignment requirement, and Intel IOMMU's requires that
> as well. If your device supports SRIOV as well, PASID and PRI are
> enumerated just on the PF and not the VF. You might want to pay attension
> to that. We are still working on a solution for that problem.

Thanks for the reminding, but it looks to me according to the ATS
spec, all PRI message is 4096 byte aligned? E.g lower bites were used
for group index etc.

Thanks

> 
> I don't think this is the right fix for your problem.
> 
> > 
> > Cc: stable@vger.kernel.org
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
