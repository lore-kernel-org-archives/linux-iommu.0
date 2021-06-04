Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF0EC4743C
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 21:45:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA7461404
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 21:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA7461404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B0B26087F;
	Fri,  4 Jun 2021 21:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PVSJTZ9MvEjw; Fri,  4 Jun 2021 21:45:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id B54406087B;
	Fri,  4 Jun 2021 21:45:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80A85C000D;
	Fri,  4 Jun 2021 21:45:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ACECC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 21:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C2B3842AE
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 21:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KQqOYN_ehjTg for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 21:45:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 879A1842B5
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622843117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zSr4NtU9kRyTYI9vJXKuouCcXbXTwJvBiHy5x/6JVcU=;
 b=fcnVncYapAN6jmFpfDP6b2i0X2v0av9nsoMrHn7Hm7YvkzX9NLaDsGtwO1NrDCw5ru+6AE
 9w467ql5Xphk9iqmp/jm4iwqkzmR26NuDmyB1QE/KoIytDm52ZSydEOb2eTYMc9rJV4RiU
 ZDfofarlE286OgvK3+FDX+ai6w35MjU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-OODfqINUNveHF8LPPowvAA-1; Fri, 04 Jun 2021 17:45:13 -0400
X-MC-Unique: OODfqINUNveHF8LPPowvAA-1
Received: by mail-oi1-f198.google.com with SMTP id
 e5-20020aca23050000b02901f0c4e00a29so5248617oie.18
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 14:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=zSr4NtU9kRyTYI9vJXKuouCcXbXTwJvBiHy5x/6JVcU=;
 b=mZd8Sgm3mZRQknUdtK0PtTwe0WQY/kh7g/wXjGOvFmId/cxNxCwz5az5XMj/6Vmaff
 uiL6pe6r6mgIg5O4exNbFZ0+bhqfKoPT9e8K4kCBaP5E2CI36OYJ2vPfk6BJaKCSgUzt
 Vrs8DDt137vZJuMcSQx3sU6S/eqpQoXHrUzp25hmh2M/G2vdfhOYQ1RRXfVxFRnvZbhp
 XgjQHeT9lBdpFQ+V/3F7aYL68cTqKWF8+zKGQpycryNQ4zkkaGbf1D9kZuC4eU1nwwtT
 +GjPwHdXhaJVpQRdBko00bYIi/mC3Cn61S7Oz3UbmIXeVE/qr8MVPUfYekUuU+y2491P
 agaA==
X-Gm-Message-State: AOAM531CodwKGbxFMearaZVoQr6zEISYRFqrATnqYHN2YzocZYi0iGSY
 jx8+T3ZAw4ry9NuhrMFSgLcF4W9gipmFs4uv+CqaVEOMLwTz19nCyryOvYGS7tJM8obujtsGfsJ
 7FBdhheGiWol7mvXv5XOYrGvURJRY5g==
X-Received: by 2002:a4a:b544:: with SMTP id s4mr5214646ooo.62.1622843113098;
 Fri, 04 Jun 2021 14:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXMJF5jgtVADecJNiiiu5bWXOc0GxXvl+uaj344NIz3ZPmM3VepTqHL8yFOEd8Ck092h+X+Q==
X-Received: by 2002:a4a:b544:: with SMTP id s4mr5214626ooo.62.1622843112930;
 Fri, 04 Jun 2021 14:45:12 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id l10sm752196ots.32.2021.06.04.14.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jun 2021 14:45:12 -0700 (PDT)
Date: Fri, 4 Jun 2021 15:45:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604154511.2bcb48dc.alex.williamson@redhat.com>
In-Reply-To: <20210604121337.GJ1002214@nvidia.com>
References: <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <MWHPR11MB1886DC8ECF5D56FE485D13D58C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603124036.GU1002214@nvidia.com>
 <20210603144136.2b68c5c5.alex.williamson@redhat.com>
 <20210604121337.GJ1002214@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Fri, 4 Jun 2021 09:13:37 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Jun 03, 2021 at 02:41:36PM -0600, Alex Williamson wrote:
> 
> > Could you clarify "vfio_driver"?    
> 
> This is the thing providing the vfio_device_ops function pointers.
> 
> So vfio-pci can't know anything about this (although your no-snoop
> control probing idea makes sense to me)
> 
> But vfio_mlx5_pci can know
> 
> So can mdev_idxd
> 
> And kvmgt

A capability on VFIO_DEVICE_GET_INFO could provide a hint to userspace.
Stock vfio-pci could fill it out to the extent advertising if the
device is capable of non-coherent DMA based on the Enable No-snoop
probing, the device specific vfio_drivers could set it based on
knowledge of the device behavior.  Another bit might indicate a
preference to not suppress non-coherent DMA at the IOMMU.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
