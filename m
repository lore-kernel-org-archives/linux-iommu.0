Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D84FC388F9
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 21:06:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA93720791
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 21:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGqMqjNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA93720791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 32A9B87588;
	Fri, 30 Oct 2020 21:06:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YLWiGefDOI-p; Fri, 30 Oct 2020 21:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9987B8731B;
	Fri, 30 Oct 2020 21:06:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E27FC088B;
	Fri, 30 Oct 2020 21:06:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3B39C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 21:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9EF69844DC
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 21:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJV3eFMEgX1J for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 21:06:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 72A0E84420
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604091993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7I6BvcvTcATCs3ne7yJMoF1DIkz9Wxm1G9qxszsAaE=;
 b=FGqMqjNpxjq6VNuLlH1Wol/wvVkJzBJINBBq823QlZwB1QtQkDXPXZR7IoVAGwgbS0dv+J
 G1K0k14WI87E3HH3e/zebE/TTCtzFuy+cfQLrZ1I3RUZ8tzyWzOv2bnnOS92s+I6ADM7j0
 WxQWU1ts+Ipo09uW9Shs3IEEpnqSJjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-S3rixnEdOD6JCsTzbTJiPw-1; Fri, 30 Oct 2020 17:06:30 -0400
X-MC-Unique: S3rixnEdOD6JCsTzbTJiPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B01B1005E77;
 Fri, 30 Oct 2020 21:06:27 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 448DD76668;
 Fri, 30 Oct 2020 21:06:26 +0000 (UTC)
Date: Fri, 30 Oct 2020 15:06:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v6 5/5] vfio/type1: Use mdev bus iommu_ops for IOMMU
 callbacks
Message-ID: <20201030150625.2dc5fb9b@w520.home>
In-Reply-To: <MWHPR11MB1645DEBE7C0E7A61D22081DD8C150@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20201030045809.957927-1-baolu.lu@linux.intel.com>
 <20201030045809.957927-6-baolu.lu@linux.intel.com>
 <MWHPR11MB1645DEBE7C0E7A61D22081DD8C150@MWHPR11MB1645.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, 30 Oct 2020 06:16:28 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Friday, October 30, 2020 12:58 PM
> > 
> > With the IOMMU driver registering iommu_ops for the mdev_bus, the
> > IOMMU
> > operations on an mdev could be done in the same way as any normal device
> > (for example, PCI/PCIe). There's no need to distinguish an mdev from
> > others for iommu operations. Remove the unnecessary code.  
> 
> This is really a nice cleanup as the output of this change! :)

It's easy to remove a bunch of code when the result is breaking
everyone else.  Please share with me how SR-IOV backed mdevs continue
to work on AMD platforms, or how they might work on ARM platforms, when
siov_iommu_ops (VT-d only) becomes the one and only provider of
iommu_ops on the mdev bus.  Hard NAK on this series.  Thanks,

Alex 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
