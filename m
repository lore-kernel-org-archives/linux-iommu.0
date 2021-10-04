Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF4C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 22:31:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0953060F6E
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 22:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0953060F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C278F83C14;
	Mon,  4 Oct 2021 22:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBXom_sfUEWF; Mon,  4 Oct 2021 22:31:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B0D9883C11;
	Mon,  4 Oct 2021 22:31:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82678C000F;
	Mon,  4 Oct 2021 22:31:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A847C000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 22:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CFA483C12
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 22:31:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dALPMBHzwUG3 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 22:31:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D14AC83C11
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 22:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633386710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6a7Mk6masvQrG2jLXSsH1TBnPfgw5I+N+EIPzAog1I=;
 b=crG0NxoGeVcWmRtSmTb1QRiu7LcsD2MGnTEisyaKBqEkWrtiyRIKONwBhnroSfJET9L8U9
 2C9j2WZpn/GyHYM5xJ7P4vnalXhNqkNlhOteo5EjET6i3vgMusXNAror5jYqMnPA9LVFmn
 fzzmbk8YMnOHHtSnMsNoUmJT0ChH4DA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-xpPwM7nxPkeQHGcdMRLnAQ-1; Mon, 04 Oct 2021 18:31:49 -0400
X-MC-Unique: xpPwM7nxPkeQHGcdMRLnAQ-1
Received: by mail-il1-f197.google.com with SMTP id
 i2-20020a056e02152200b002587ac62443so11618357ilu.14
 for <iommu@lists.linux-foundation.org>; Mon, 04 Oct 2021 15:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=k6a7Mk6masvQrG2jLXSsH1TBnPfgw5I+N+EIPzAog1I=;
 b=xw49wVyuGORyOiHz+1F/dcVPvxKnP/hkeJ1TtZa/AiHR5w4DglR0gF8TgvQhniOw2h
 zr7a82GDEn+aZmPFeikl1jcHVnWZwzOdEH6lvRyU9oxbTPFke+wcJzZnWJPj0zsM5uk8
 J5TPtwQqfuwL1gVC0TmezSW1CtrSoXBAoMlP7aSR1ExIpAXDxKZJQ9p0/bCZan/AlBXD
 GcalE11e8Rl4SchWuqib+qvv+/2iqZwiAP3ZjtELbrPAiA5HmxwNjZygF979cY3paV1Z
 PVjxFRa0189uf+gRxXizCdx5PBlCw5rxgfwDwZ7X17IErMpTSRfL2zreo/D7fRuK3Swj
 UHFA==
X-Gm-Message-State: AOAM5337F1BINNlYHPpe8te29isIiBfS1uL9J6SLfiibMKsh4as+g8YE
 f718DImkdO4eY2rGKlYbOX5+EeFqfnOAmiUoGKdHdZ55TlP9SI028RUtsg6shx/aKH07rICZ5UR
 EkteZGmjBCwRrYh4pZIEaJSH5Pou7PA==
X-Received: by 2002:a05:6e02:8ad:: with SMTP id
 a13mr486971ilt.136.1633386708710; 
 Mon, 04 Oct 2021 15:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0L83MvMLkr/6+IdyIY0rPwtfBHAvQdPfMp3mBYCUa8IZHMaQLCDaoD7TjRxtwh23+H0xxUw==
X-Received: by 2002:a05:6e02:8ad:: with SMTP id
 a13mr486960ilt.136.1633386708578; 
 Mon, 04 Oct 2021 15:31:48 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id l1sm9952807ilc.65.2021.10.04.15.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 15:31:48 -0700 (PDT)
Date: Mon, 4 Oct 2021 16:31:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ajay Garg <ajaygargnsit@gmail.com>
Subject: Re: [PATCH] iommu: intel: remove flooding of non-error logs, when
 new-DMA-PTE is the same as old-DMA-PTE.
Message-ID: <20211004163146.6b34936b.alex.williamson@redhat.com>
In-Reply-To: <CAHP4M8Us753hAeoXL7E-4d29rD9+FzUwAqU6gKNmgd8G0CaQQw@mail.gmail.com>
References: <20211002124012.18186-1-ajaygargnsit@gmail.com>
 <b9afdade-b121-cc9e-ce85-6e4ff3724ed9@linux.intel.com>
 <CAHP4M8Us753hAeoXL7E-4d29rD9+FzUwAqU6gKNmgd8G0CaQQw@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org
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

On Sat, 2 Oct 2021 22:48:24 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> Thanks Lu for the reply.
> 
> >
> > Isn't the domain should be switched from a default domain to an
> > unmanaged domain when the device is assigned to the guest?
> >
> > Even you want to r-setup the same mappings, you need to un-map all
> > existing mappings, right?
> >  
> 
> Hmm, I guess that's a (design) decision the KVM/QEMU/VFIO communities
> need to take.
> May be the patch could suppress the flooding till then?

No, this is wrong.  The pte values should not exist, it doesn't matter
that they're the same.  Is the host driver failing to remove mappings
and somehow they persist in the new vfio owned domain?  There's
definitely a bug beyond logging going on here.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
