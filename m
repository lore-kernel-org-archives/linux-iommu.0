Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E306FC4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:30:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E40D23741
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qk0VM2b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E40D23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ADEB623018;
	Thu, 24 Sep 2020 10:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 53ehM1075TZi; Thu, 24 Sep 2020 10:30:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0D11C273E3;
	Thu, 24 Sep 2020 10:30:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E014FC0889;
	Thu, 24 Sep 2020 10:30:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08630C0889
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E4EE787490
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P1BF2K9GHiOP for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 10:30:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 036B1873E1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:30:14 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id z4so3231124wrr.4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=znzUeIRH1ne+QRXgI3ldPbArevzy1R8C3LyhHivzoF4=;
 b=qk0VM2b6qYCdVzwHNTA9pKcSI+q16THf//P5w/CjrxapWjynBG3uVUmYe+J1sMZrD/
 LNFbCu9JUK3q3nJyk/a+Q/nNFSrtAf+aOAdGDrjB/f/tlUzHyZk/e6HukMxXwPLS7wPd
 5TC0ccHevIrMKtFwr/rlDrNFYEC/WVtzjHiflol+lbiYXA9RqRnLc9PIx+e5xCj2sBcU
 tsXixF8PPr0KylfAkv7YzHuF/9fK0i3DmlIfoOrVqPNPtKaWQo89vT4NiDUmWPXW4pZJ
 d3TdFMZmu9s5ySjxM2xo0mvbDN7TtxQwB6/sbF/JPVKo30rQtdBO+LMDkQmSJJOcrkTM
 Nucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=znzUeIRH1ne+QRXgI3ldPbArevzy1R8C3LyhHivzoF4=;
 b=IQsJHRDTCxfkcOc9h9meysvKLkVquxAQ1IArauXpGi0bSMWRenSmVSMQl8I9hw79VJ
 qPQUBQFlJLFcHpNScwkZpSW4YEk15FR/FsiOvlo8JipYRU6KWb3NsZy5DUGJ/HfBObnZ
 MBcR34+GRLwA3l8aTxDVpvSA000j0DyailelTenptFnItEOciaIyTCEOv6HlVMMpmZXY
 7HSvvVy8vLOs2xCr8j/dLLHEubE5ekPsQ+bPSU8xObNfMM/SLVgzotkap7HJ4osVW+rT
 Igji45TjgFShj7+DSB/Eq3IFXiEbW6YzXEPQnIfFeUBHA8sDgaZ0a4LSeU0uNV3OAl5p
 wQYA==
X-Gm-Message-State: AOAM532lpXnx0fmpdTE1J5E0vnJeY0z/Tum9v1JfITIvumaE3hFv3LRH
 Lr2n+UftMMPw/9lvy2m9d6p7QA==
X-Google-Smtp-Source: ABdhPJxtACZr7VVPwp22Cf6DNucqOWM3y2OALl52UMDzWmOMP+EbGgfCzGceL1CMmGKZg4tjOTJEFQ==
X-Received: by 2002:a5d:4246:: with SMTP id s6mr4274207wrr.414.1600943412498; 
 Thu, 24 Sep 2020 03:30:12 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u126sm3619614wmu.9.2020.09.24.03.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 03:30:11 -0700 (PDT)
Date: Thu, 24 Sep 2020 12:29:53 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924102953.GD170808@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <20200924100255.GM27174@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200924100255.GM27174@8bytes.org>
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
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

On Thu, Sep 24, 2020 at 12:02:55PM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:38:13AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> > > On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > > > OK so this looks good. Can you pls repost with the minor tweak
> > > > suggested and all acks included, and I will queue this?
> > > 
> > > My NACK still stands, as long as a few questions are open:
> > > 
> > > 	1) The format used here will be the same as in the ACPI table? I
> > > 	   think the answer to this questions must be Yes, so this leads
> > > 	   to the real question:
> > 
> > I am not sure it's a must.
> 
> It is, having only one parser for the ACPI and MMIO descriptions was one
> of the selling points for MMIO in past discussions and I think it makes
> sense to keep them in sync.

It's not possible to use exactly the same code for parsing. The access
methods are different (need to deal with port-IO for built-in description
on PCI, for example) and more importantly, the structure is different as
well. The ACPI table needs nodes for virtio-iommu while the built-in
description is contained in the virtio-iommu itself. So the endpoint nodes
point to virtio-iommu node on ACPI, while they don't need a pointer on the
built-in desc. I kept as much as possible common in structures and
implementation, but in the end we still need about 200 unique lines on
each side.

Thanks,
Jean

> 
> > We can always tweak the parser if there are slight differences
> > between ACPI and virtio formats.
> 
> There is no guarantee that there only need to be "tweaks" until the
> ACPI table format is stablized.
> 
> Regards,
> 
> 	Joerg
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
