Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F95C4363D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 10:22:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0369521D91
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 10:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGmIBEkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0369521D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A1C032E161;
	Fri, 25 Sep 2020 10:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I2pCPPS5Cwn0; Fri, 25 Sep 2020 10:22:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 540192E15A;
	Fri, 25 Sep 2020 10:22:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 379A8C0889;
	Fri, 25 Sep 2020 10:22:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 750F6C0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 10:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7159D86C59
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 10:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zIgl--zY4raw for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:22:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B25CA86C56
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 10:22:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601029347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FIrDkYdRBbVhi3DlgkbBKaCC5KZCzUdxrIcyXtujywg=;
 b=bGmIBEkYs4Kdnw48jUdgosWOXBnAwc3S3gfQxKyZfFuxBSwCBMZVl4MhM1hybA4BU2DxnC
 qxMbaaC8jG/y43jqHbrcFgTcpsCRDHu4qnRlBrtom4nN+onaC7Ojm4d1/QneD4mdFY33yh
 zsVf+HT0y1pcR/CCfwwgAuMzd783DeI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-rljfRHgVMkqlu9hI8ydS1g-1; Fri, 25 Sep 2020 06:22:25 -0400
X-MC-Unique: rljfRHgVMkqlu9hI8ydS1g-1
Received: by mail-wr1-f72.google.com with SMTP id l15so894534wro.10
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 03:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FIrDkYdRBbVhi3DlgkbBKaCC5KZCzUdxrIcyXtujywg=;
 b=PxySftLIziVIk1MwUxi44/fn5LvdH8HnJQwENB3YncKUDqkyWRjARrkigBec1cW5zR
 im9SKq3VpCqOI1uWmt2/C5oPMlGVvqxNTG3l6z6pmhQRoCHKh/p6IiTs4mQmfAhUngu9
 K++qj4M0huvmLHeWjBE94NhYvt2u3VsaIRMA+O9Eff/vXsB3MNGt5cqMVW+B4Ay5c5wT
 FypQu+4gaOHtcrJzPB6eo8ZPWExm1j508iMzA60HedWNjHnNb2WbANdiUD4FbZWUza1g
 Lh5EUzLOXXEEPXNnW1GHz7e2ckob8Vwmwyx95Obi838KkGMqpRLxhaTRMmge2kgzoD46
 67cg==
X-Gm-Message-State: AOAM533/8QltaEKAAo1IkHOQ6hFuNtnZn6g6oowgTkiZ9hWQUN0Cj1/y
 t1IBw2pBAfQRx7xC4Y8Wye4xbVDPPa4aCyVvOgaTkI6chKKWlxYAQ/Hya9gfrY8tm7sJ1/dyO1p
 b0PkMjsgQFN39TeyWRDdQkW5NCy6XJw==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr2311706wme.136.1601029344133; 
 Fri, 25 Sep 2020 03:22:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/J1hHVBw+R8oMJc/+peFSRFq7cwzBLkEQMc+s1atOIZTdN1uBg5mFmmxkcJWGpJb6G3bMjg==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr2311686wme.136.1601029343977; 
 Fri, 25 Sep 2020 03:22:23 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id c14sm2297007wrv.12.2020.09.25.03.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 03:22:23 -0700 (PDT)
Date: Fri, 25 Sep 2020 06:22:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925062122-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <20200924100255.GM27174@8bytes.org>
 <20200924083918-mutt-send-email-mst@kernel.org>
 <20200924125046.GR27174@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200924125046.GR27174@8bytes.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-pci@vger.kernel.org,
 jasowang@redhat.com, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 bhelgaas@google.com
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

On Thu, Sep 24, 2020 at 02:50:46PM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 08:41:21AM -0400, Michael S. Tsirkin wrote:
> > But this has nothing to do with Linux.  There is also no guarantee that
> > the two committees will decide to use exactly the same format. Once one
> > of them sets the format in stone, we can add support for that format to
> > linux. If another one is playing nice and uses the same format, we can
> > use the same parsers. If it doesn't linux will have to follow suit.
> 
> Or Linux decides to support only one of the formats, which would then be
> ACPI.
> 
> Regards,
> 
> 	Joerg

It's really up to hypervisors not guests, linux as a guest can for sure
refuse to work somewhere, but that's normally not very attractive.

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
