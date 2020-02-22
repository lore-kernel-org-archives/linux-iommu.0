Return-Path: <SRS0=f0z+=4K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA2C35671
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 19:08:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082E6206E2
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 19:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWNXQdKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082E6206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 47180855B5;
	Sat, 22 Feb 2020 19:08:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id va9JkoOOfH1m; Sat, 22 Feb 2020 19:08:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 63EF9855D1;
	Sat, 22 Feb 2020 19:08:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39A02C1D81;
	Sat, 22 Feb 2020 19:08:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CEA1C013E
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 19:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 68DA987A04
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 19:08:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XxHvFHJ5b7dA for <iommu@lists.linux-foundation.org>;
 Sat, 22 Feb 2020 19:08:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A1589879F0
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582398486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l8Co0LvRp3ramNpVW3gFF8vKkokm29L15IzKuQ8ukBs=;
 b=NWNXQdKf1K6da2Ths6s9CB6Gl17KaDXkUmxkV2O267owuNKaZUsJJkzrO/lZ55mM2l3Vk6
 1xj1df9UwhaME0hohDSIstB0M51dPph7KLFoeomGJ63roJQ8GN4slBRitfWzbfyyCGxwEX
 bL7ZxxDUOYjecDlj/Rnl9GoR3MDZl3E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-M-zIRpuQM7SEwSIK2Der1w-1; Sat, 22 Feb 2020 14:08:04 -0500
X-MC-Unique: M-zIRpuQM7SEwSIK2Der1w-1
Received: by mail-wm1-f72.google.com with SMTP id 7so1593222wmf.9
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 11:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l8Co0LvRp3ramNpVW3gFF8vKkokm29L15IzKuQ8ukBs=;
 b=MgFjtTh5O9mcMPXduOMKjcMcpzN0AYfxA4MPhGZPMsqBypSGK0Bodcld2/QsxHPXjK
 R9N2zDEk+f/PTKb8/ZwZhwykh2P4mRRvRRwpXj9XiEFLHoaHGs6cq+83YlK8O6u2kU1z
 a0x72PbzaaPFVrRQANP5uvMTT0kFp02kZKR3yz+LGrVfqDFNQmjR//whMnKPPLZ8nlVf
 Dlf5Ik+QtzhhhdQfm619/sVJ9/F6qopycixqfUtENkphrCybBlNPVN65jpQ6eq/wvn1n
 VZBZJys32S8KgGXRsZ6DQtodoVMMQJdw1vrJWGGhDyGckEVLdsi9Y0xDsL7LwIHiW1IO
 Qk7A==
X-Gm-Message-State: APjAAAXoaN7ToR+s2EepRy+l/E9SDUzZjGq855M/m3AMh2NyTLasbQ3z
 BYgmzPCq/mv47v1n58ilZseHAqqaWlr2wT33xwnmQz3eakumho3W1a1UvLSMwMXCi1TrKT1DYYj
 F776FloYlgHumA6bhxf8HH2J7ghI+2Q==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr11484223wmc.39.1582398483435; 
 Sat, 22 Feb 2020 11:08:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkw9wErSHWGp2TCjgAZ9qrXX7+D7Wndcr6dYdr8omT/WT5gNCQFRWrzivLVlKcFtBEcNGXcA==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr11484193wmc.39.1582398483111; 
 Sat, 22 Feb 2020 11:08:03 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 m68sm9604715wme.48.2020.02.22.11.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2020 11:08:02 -0800 (PST)
Date: Sat, 22 Feb 2020 14:07:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200222140408-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220161309.GB12709@lst.de>
 <20200221153340.4cdcde81.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200221153340.4cdcde81.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
> AFAIU you have a positive attitude towards the idea, that 
> !F_VIRTIO_PLATFORM implies 'no DMA API is used by virtio' 
> should be scrapped. 
> 
> I would like to accomplish that without adverse effects to virtio-ccw
> (because caring for virtio-ccw is a part of job description).
> 
> Regards,
> Halil

It is possible, in theory. IIRC the main challenge is that DMA API
has overhead of indirect function calls even when all it
does it return back the PA without changes. So that will lead to
a measureable performance degradation. That might be fixable,
possibly using some kind of logic along the lines of
	if (iova is pa)
		return pa
	else
		indirect call

and for unmapping, we might need an API that says "unmap
is a nop, safe to skip" so we don't maintain the
dma address until unmap.


-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
