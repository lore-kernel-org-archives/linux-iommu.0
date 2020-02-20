Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B9DC11D24
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 21:30:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95AB208E4
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 21:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjnlaq6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95AB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 82C93860E6;
	Thu, 20 Feb 2020 21:30:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NrBeEhbRzaiY; Thu, 20 Feb 2020 21:30:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 93386860DE;
	Thu, 20 Feb 2020 21:30:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F0E3C1D84;
	Thu, 20 Feb 2020 21:30:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6583FC013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 21:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 49B2F20341
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 21:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c0rGMKAdhZIi for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 21:30:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 5173B20242
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 21:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582234201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lf3au2MSHJPbioLz91pJ+pe3QhvFI4k4CcE4NuKgsdw=;
 b=fjnlaq6AffDnj7+dY3+2CVPoWv1XnbTVbky16NoeAELj5TZJlK9jD35zK72RcH8SXRA34x
 j9+siZwuTwpEcSzD4a8sble22kvlueV5/8+lhzD/a2Uy75Ep7XTlbS8kDcf1VICIY+0HIT
 U04LgQ+UjrY7azT6J7n7b+nzkYOP9ag=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-gurn0o9BOUuBZB0dPVNYHQ-1; Thu, 20 Feb 2020 16:29:59 -0500
Received: by mail-qk1-f200.google.com with SMTP id i11so28472qki.12
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 13:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Lf3au2MSHJPbioLz91pJ+pe3QhvFI4k4CcE4NuKgsdw=;
 b=KzRs8ujRZbwErgMN0DpnAvbmiqvaS7HEIMhrdsvhBtQMBcTaBF8O6jviDCA2FWePns
 +YGz8VMEEzxpqyhHW9NEYXSlOBK0Iqpy+OG96cD6mVGc4QSpW/95m8nL1/BHrfrBqcPB
 sbdz4d+Y78fhLHLjrqrIbb5sgK3KiCafCBxOo373KAyfzDw+Do8q7oT3Q7gwuePJdafW
 kDB09v+xhRrn/sX2NtuAb8KoUmO50hIu+BZ48bcZlliMbmdV1DfZnTFmZcQPx9iCpv65
 KoIGPuzW/LQrRwOjmGCGGD23iGPCq00BQHZ7HsxWtdC4EPC3ujSiLyYJCOg5SD/td+ZK
 TbOQ==
X-Gm-Message-State: APjAAAV/l9i8qQudLUXdZvvRzY152+MqLVOCpTMky3gmAPGTa2uW7qSR
 kmDdlYBK0p5HGzTKWPo/b+OdNlqE6vaDC4IpQ7oj5qa7J8Y/I55C+qsurU+53Fb7SUH675J755m
 CbY4j4ZVlbyByeX3Uqctm5pMQhW04iw==
X-Received: by 2002:ac8:4616:: with SMTP id p22mr29036892qtn.368.1582234199339; 
 Thu, 20 Feb 2020 13:29:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCyE/IGRqPbb728yukodcrAAG8HoUGpZIWGc8w9a3plX9TiklcItDV0lrQNkao9NxMwpK5TQ==
X-Received: by 2002:ac8:4616:: with SMTP id p22mr29036863qtn.368.1582234199118; 
 Thu, 20 Feb 2020 13:29:59 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id c45sm453698qtd.43.2020.02.20.13.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 13:29:57 -0800 (PST)
Date: Thu, 20 Feb 2020 16:29:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200220162747-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200220160606.53156-1-pasic@linux.ibm.com>
X-MC-Unique: gurn0o9BOUuBZB0dPVNYHQ-1
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

On Thu, Feb 20, 2020 at 05:06:04PM +0100, Halil Pasic wrote:
> * This usage is not congruent with  standardised semantics of
> VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
> for using DMA API in virtio (orthogonal with respect to what is
> expressed by VIRTIO_F_IOMMU_PLATFORM). 

Quoting the spec:

  \item[VIRTIO_F_ACCESS_PLATFORM(33)] This feature indicates that
  the device can be used on a platform where device access to data
  in memory is limited and/or translated. E.g. this is the case if the device can be located
  behind an IOMMU that translates bus addresses from the device into physical
  addresses in memory, if the device can be limited to only access
  certain memory addresses or if special commands such as
  a cache flush can be needed to synchronise data in memory with
  the device. Whether accesses are actually limited or translated
  is described by platform-specific means.
  If this feature bit is set to 0, then the device
  has same access to memory addresses supplied to it as the
  driver has.
  In particular, the device will always use physical addresses
  matching addresses used by the driver (typically meaning
  physical addresses used by the CPU)
  and not translated further, and can access any address supplied to it by
  the driver. When clear, this overrides any platform-specific description of
  whether device access is limited or translated in any way, e.g.
  whether an IOMMU may be present.

since device can't access encrypted memory,
this seems to match your case reasonably well.

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
