Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A47C43331
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 09:24:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7C3206D3
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 09:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ozs9wvGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7C3206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B7D6920450;
	Thu,  2 Apr 2020 09:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cms2rcPxckc2; Thu,  2 Apr 2020 09:24:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CD9BC20417;
	Thu,  2 Apr 2020 09:24:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE7D4C1D74;
	Thu,  2 Apr 2020 09:24:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82C31C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 09:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 75D2820417
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 09:24:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FliosaRuS3Rv for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 09:24:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 6A16B203F9
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 09:24:28 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id i19so2831763wmb.0
 for <iommu@lists.linux-foundation.org>; Thu, 02 Apr 2020 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QBLTad+iICgypznQbxOsc5K7y6BcjDBR3loOYsj8SjI=;
 b=Ozs9wvGWhInw+jHbV+TIbhn0mHoMFHCEFO25FeTvEMCTPyY7OHacXfEcXTiNoiBAeQ
 1VC8fPDraFaL2tn2VMqFbzjR1t79IdHS47FEvt89UccYOkek8UikchvvcScI+YAjAs3/
 TE8T3z8N4aqHw3WD5KZR9MWiTu/hQbk1lodhGs9xJG5gBFJa61Vrvi0K7VDctd344t/N
 /jNl1HvBSa9zNSpEP8Trto2aUS9cIST5YLl/mwd5+LO0lomPjvAW9JdePTMIqtmHn82N
 lN9l20L2TlPcVG4dnFhtolx0+Ct2YljEiGF98iw/XLHqCdoCP7NhtERc1Kweco00bYgX
 /fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QBLTad+iICgypznQbxOsc5K7y6BcjDBR3loOYsj8SjI=;
 b=BmZhT+Di/spEveA08lTD4kyaOphuaGrmrAXM23KwUXQDwz6lwQ7zETFOTUBpKounsz
 HCk30+xbmSzHWJEhgtsZpc4R2AMRKzf2yUAMQH/DEg+dbq1ZMLc4YJD6OdbNH8SB7xsc
 9JUys2RCVKfEVoZyWHNTDgWh8RstKdurisvRYiLXy9qIwiZXKy4k+hp5hjMY9bctpWGi
 mXbZWqNGVfSb0c1LdePi6ran6arz6g8E4SOnnoodL/3J7IHJC3a9+V3KG6ZOfQCFLHUB
 V6N3s+zoE/W1W97iHIThmnR3nHTi61x7GRVPLqc1zZ8K1WKU94ePDFCqeK7rSSfN9pN2
 t7cQ==
X-Gm-Message-State: AGi0PuY9gq89vd3g0YJN3SlFaraq7Z1qUvRsSefUGmcOvYgpxDv+kDGf
 JQniI511vjAxSS+isQBWLV2/Og==
X-Google-Smtp-Source: APiQypI7yks1BQgHkRfqDIDPyzmNDQl3OkV9mh18UeW9nruJ9Kr3U7S557vz+0veoQwZ4Jzint1MtA==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr2493598wmj.87.1585819466713;
 Thu, 02 Apr 2020 02:24:26 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
 by smtp.gmail.com with ESMTPSA id f13sm6396383wrx.56.2020.04.02.02.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 02:24:26 -0700 (PDT)
Date: Thu, 2 Apr 2020 11:24:17 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [EXT] Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap
 supported by endpoint
Message-ID: <20200402092417.GA1176452@myrica>
References: <20200401113804.21616-1-bbhushan2@marvell.com>
 <b75beb74-89ce-fd6a-6207-3c0d7f479215@arm.com>
 <20200401154932.GA1124215@myrica>
 <MWHPR1801MB19667BA1D59590BC3DFD87C7E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB19667BA1D59590BC3DFD87C7E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
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

On Thu, Apr 02, 2020 at 03:53:40AM +0000, Bharat Bhushan wrote:
> > > > +struct virtio_iommu_probe_pgsize_mask {
> > > > +	struct virtio_iommu_probe_property	head;
> > > > +	__u8					reserved[4];
> > > > +	__u64					pgsize_bitmap;
> > 
> > Should be __le64
> 
> Based on" iommu/virtio: Fix sparse warning" patch https://www.spinics.net/lists/linux-virtualization/msg41944.html changed to __u64 (not __le64)

Yes that one was only for the virtio config struct, to play nice with
other devices. We should still use __le for the other structures,
including probe properties.

Thanks,
Jean

> 
> Will keep __le64.
> 
> Thanks
> -Bharat
> 
> > 
> > Thanks,
> > Jean
> > 
> > > > +};
> > > > +
> > > >   #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> > > >   #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> > > >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
