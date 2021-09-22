Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0EDC433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 20:10:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67ECD6120E
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 20:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67ECD6120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32931614E9;
	Wed, 22 Sep 2021 20:10:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rc1ZQBDXr0-F; Wed, 22 Sep 2021 20:10:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F3553605D2;
	Wed, 22 Sep 2021 20:10:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC73AC000F;
	Wed, 22 Sep 2021 20:10:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C58FFC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 20:10:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A796F84052
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 20:10:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4L0xAUrBDKz6 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 20:10:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACE5A84050
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 20:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632341443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVDSHQbpVe8JTY8isblrL8p142CPVwt8+X+MPr7eWPw=;
 b=c6tXdCNIT5bOBaaBUo0JPA+ExsKrTtpzQSLJlWqDFjErsra3vzJRo9Z7nQfcTiu40XmNmI
 z1dOqXaLZzMB37hxZenZows17CSqhYCqMbxApq9n+O8yO6LRFAvx7M/lttv03oZ9J7ozI4
 +KIV5DK5CnxpGhg1r43qyy1vMNR7jeI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-omjZhyhtNGShTsQbVlPyQA-1; Wed, 22 Sep 2021 16:10:40 -0400
X-MC-Unique: omjZhyhtNGShTsQbVlPyQA-1
Received: by mail-oi1-f197.google.com with SMTP id
 bh31-20020a056808181f00b0026d71fa022cso2464672oib.9
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=LVDSHQbpVe8JTY8isblrL8p142CPVwt8+X+MPr7eWPw=;
 b=anYq5hVOnCDbSXCjGqEmdZm0aI+Maq51Q0tLRmstAMaqcmGt5o2USbnDb2Wx3o8N+l
 ljJgDFaumdLgLjMu4S8Pu01pnNQ5vZGvbOAlIf0xAPLSFXuaO4BSQsA3TndRmRE5g+/E
 SrKAu1ZwOU9lvRijEY3+Gs7s/8aR9ZPKMLXnHv//5aaNQZqvojlGWiyMQho7O2rzN942
 /dHzZLfT+CqqAMuwRsMPvKPV7v+TrASpPsDiPvBr9Na5bkvwuIXz0r3wLv8smEoO2vwz
 JJKUaNkBQstJC4HvqzQxLEjqvkQDq3dTFFVDzr2Ao42e3YHvEaQuuKcWQ6RibQGnSEnN
 Haow==
X-Gm-Message-State: AOAM532xdWR2RHY3kg9ulVFBKsi1+tOuhttUFtlBG9Lgx3FOJrSPNf98
 f4dETOmLZQG2+UFZFQjb4A2S/Wa2TRN68SwA6DVOvz9qu4HsXMIIDYiaPVpcH13pS1qgBISvcQy
 QLRXy/0QYl9OvlYOGJA6svAYZ9csEZQ==
X-Received: by 2002:aca:5f09:: with SMTP id t9mr785746oib.157.1632341439238;
 Wed, 22 Sep 2021 13:10:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsexkS3ssuL6wF9vSWKPex4M0QKWRz+hAFF7uOcJjumY+ZptpBRjRLEImjoapaxD27rGKTYw==
X-Received: by 2002:aca:5f09:: with SMTP id t9mr785712oib.157.1632341438954;
 Wed, 22 Sep 2021 13:10:38 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id a15sm720852otq.13.2021.09.22.13.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 13:10:38 -0700 (PDT)
Date: Wed, 22 Sep 2021 14:10:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
Message-ID: <20210922141036.5cd46b2b.alex.williamson@redhat.com>
In-Reply-To: <20210922122252.GG327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922005337.GC327412@nvidia.com>
 <BN9PR11MB54338D108AF5A87614717EF98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922122252.GG327412@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Wed, 22 Sep 2021 09:22:52 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Sep 22, 2021 at 09:23:34AM +0000, Tian, Kevin wrote:
> 
> > > Providing an ioctl to bind to a normal VFIO container or group might
> > > allow a reasonable fallback in userspace..  
> > 
> > I didn't get this point though. An error in binding already allows the
> > user to fall back to the group path. Why do we need introduce another
> > ioctl to explicitly bind to container via the nongroup interface?   
> 
> New userspace still needs a fallback path if it hits the 'try and
> fail'. Keeping the device FD open and just using a different ioctl to
> bind to a container/group FD, which new userspace can then obtain as a
> fallback, might be OK.
> 
> Hard to see without going through the qemu parts, so maybe just keep
> it in mind

If we assume that the container/group/device interface is essentially
deprecated once we have iommufd, it doesn't make a lot of sense to me
to tack on a container/device interface just so userspace can avoid
reverting to the fully legacy interface.

But why would we create vfio device interface files at all if they
can't work?  I'm not really on board with creating a try-and-fail
interface for a mechanism that cannot work for a given device.  The
existence of the device interface should indicate that it's supported.
Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
