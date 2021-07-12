Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA07C07E99
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 18:42:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F27160FEA
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 18:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F27160FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14B034051E;
	Mon, 12 Jul 2021 18:42:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02QUy5g22C69; Mon, 12 Jul 2021 18:42:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA5C240425;
	Mon, 12 Jul 2021 18:41:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80DAAC0010;
	Mon, 12 Jul 2021 18:41:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E370C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 18:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C52F60653
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 18:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id co6EHbfxWA4G for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 18:41:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A43DE60656
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626115316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rz8zwYlKIBwilT7nuaKV92zNGRhD3wv0rHn55OLUrN8=;
 b=g1Ig/2wMmKHxsog5xrqJ2YzAg27QjCxduGpQ+o+TOQjrQAuOKChUbEPp33Q1ClyIRgoZZ6
 TnaAcVXQpeSkAKB6ppeu9wGb5hrRDDVDeaywsEMgRkAmciSvfXTplbb20TG/iECR/cUNFj
 3FZ4VrWEbtswL8M9ga0NA7Dd9JLUrlE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-7iBFm6jBN-Kogo9gI2iv9w-1; Mon, 12 Jul 2021 14:41:53 -0400
X-MC-Unique: 7iBFm6jBN-Kogo9gI2iv9w-1
Received: by mail-ot1-f69.google.com with SMTP id
 l44-20020a9d1b2f0000b029048596759dfcso13833350otl.2
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 11:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rz8zwYlKIBwilT7nuaKV92zNGRhD3wv0rHn55OLUrN8=;
 b=G1CEHiHJ1HpVyVrnIj6Mfh7RImfy0DCB4uQRAN1zR3vXRglcl/glPkgtrqRt/o6fIV
 Mh7x2uOujwZzuaDd8dpX9Av3MiOH/VQWaaKlOcRhR4nZb1Uy7m1AcCdPQ/A6DIaY7EM1
 exgGfOKPPvDUp4o7Z7ugKNhfRc7x0AEzMVK0+eglDt8a4dzZf1YRkMXsG0aUUWFarOMC
 mWMTkKz+ovInFdivUnIJxYHBhh6/KZHMAp7IcQ/BAUrSImXlJxTG/bxs8hzFx503AB4x
 xfV8lyE8Dz4FGdSqrSsdxD6bMPv7UTncAmluoTwwycdMPskvMzLID6Mw6uYCmUhXhcHf
 SZLw==
X-Gm-Message-State: AOAM531GiukdT8j79Mq4/2mV9A79xzf8X38EOgibgl4Y5nsoFelYWTzN
 44ZnNl35ZxjWKt9nVI1SNr1+/qyJ05aQap6FEMsOW3SS6LAw6eM+ZJO8BDzpTGCPv/UfIu8f1xQ
 rh04vdLdhgH7h+f+R4cZjx/XUJZ1PYg==
X-Received: by 2002:aca:59c3:: with SMTP id n186mr158962oib.98.1626115312823; 
 Mon, 12 Jul 2021 11:41:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoabeJODq5qo6mubZ8IkE3585WLLaxnVDFrK1i442BlsHLyAD65SVY+xLexK9+lGo6s2ymfw==
X-Received: by 2002:aca:59c3:: with SMTP id n186mr158927oib.98.1626115312574; 
 Mon, 12 Jul 2021 11:41:52 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id o9sm1221754oiw.49.2021.07.12.11.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jul 2021 11:41:52 -0700 (PDT)
Date: Mon, 12 Jul 2021 12:41:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210712124150.2bf421d1.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB54336FB9845649BB2D53022C8C159@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210709155052.2881f561.alex.williamson@redhat.com>
 <BN9PR11MB54336FB9845649BB2D53022C8C159@BN9PR11MB5433.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang, 
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, 12 Jul 2021 01:22:11 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Saturday, July 10, 2021 5:51 AM
> > On Fri, 9 Jul 2021 07:48:44 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:  
 
> > > For mdev the struct device should be the pointer to the parent device.  
> > 
> > I don't get how iommu_register_device() differentiates an mdev from a
> > pdev in this case.  
> 
> via device cookie.


Let me re-add this section for more context:

> 3. Sample structures and helper functions
> --------------------------------------------------------
> 
> Three helper functions are provided to support VFIO_BIND_IOMMU_FD:
> 
> 	struct iommu_ctx *iommu_ctx_fdget(int fd);
> 	struct iommu_dev *iommu_register_device(struct iommu_ctx *ctx,
> 		struct device *device, u64 cookie);
> 	int iommu_unregister_device(struct iommu_dev *dev);
> 
> An iommu_ctx is created for each fd:
> 
> 	struct iommu_ctx {
> 		// a list of allocated IOASID data's
> 		struct xarray		ioasid_xa;
> 
> 		// a list of registered devices
> 		struct xarray		dev_xa;
> 	};
> 
> Later some group-tracking fields will be also introduced to support 
> multi-devices group.
> 
> Each registered device is represented by iommu_dev:
> 
> 	struct iommu_dev {
> 		struct iommu_ctx	*ctx;
> 		// always be the physical device
> 		struct device 		*device;
> 		u64			cookie;
> 		struct kref		kref;
> 	};
> 
> A successful binding establishes a security context for the bound
> device and returns struct iommu_dev pointer to the caller. After this
> point, the user is allowed to query device capabilities via IOMMU_
> DEVICE_GET_INFO.
> 
> For mdev the struct device should be the pointer to the parent device. 


So we'll have a VFIO_DEVICE_BIND_IOMMU_FD ioctl where the user provides
the iommu_fd and a cookie.  vfio will use iommu_ctx_fdget() to get an
iommu_ctx* for that iommu_fd, then we'll call iommu_register_device()
using that iommu_ctx* we got from the iommu_fd, the cookie provided by
the user, and for an mdev, the parent of the device the user owns
(the device_fd on which this ioctl is called)...

How does an arbitrary user provided cookie let you differentiate that
the request is actually for an mdev versus the parent device itself?

For instance, how can the IOMMU layer distinguish GVT-g (mdev) vs GVT-d
(direct assignment) when both use the same struct device* and cookie is
just a user provided value?  Still confused.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
