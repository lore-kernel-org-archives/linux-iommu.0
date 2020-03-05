Return-Path: <SRS0=kRV3=4W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC4C3F2D1
	for <iommu@archiver.kernel.org>; Thu,  5 Mar 2020 15:39:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E00A2073B
	for <iommu@archiver.kernel.org>; Thu,  5 Mar 2020 15:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Me8PdntW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E00A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 06AC686191;
	Thu,  5 Mar 2020 15:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yt9kOXL6iKWI; Thu,  5 Mar 2020 15:39:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9AAE386135;
	Thu,  5 Mar 2020 15:39:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96416C18DA;
	Thu,  5 Mar 2020 15:39:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E39CC013E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 15:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1774C86141
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 15:39:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YJUxjbaDkivD for <iommu@lists.linux-foundation.org>;
 Thu,  5 Mar 2020 15:39:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A1F0286135
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583422767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NqkJYnrX939afrvZWNAzIUgTdi1dF3s2yc9aSiDADMI=;
 b=Me8PdntWsdSMYPB7S6cDG8kXcXIWyMSsPtvTgewxEte/DHrlpk/iRVZn1A6SVXBtP88jxP
 IMQ541gi4MZ2l+b919l/QD6ua2xoT7Uq8D/Ot/ZZDb/6tF8V3i8qNWH/+yTdFBomX45mB2
 Dv6O8uTy4kJ4p58YPGBZL/Af1kYYsNQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-35L0gFsbNKqhGu8rEmjehw-1; Thu, 05 Mar 2020 10:39:26 -0500
X-MC-Unique: 35L0gFsbNKqhGu8rEmjehw-1
Received: by mail-qt1-f198.google.com with SMTP id y3so4066292qti.15
 for <iommu@lists.linux-foundation.org>; Thu, 05 Mar 2020 07:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NqkJYnrX939afrvZWNAzIUgTdi1dF3s2yc9aSiDADMI=;
 b=GxnnRD3UPZrm8giNuL6Np8RPe70rvlgcB7FD0rrP+tF8qHmIBFzIsjCv/a43LkkkSb
 PwEzIb07A0sHuGgMqrE/WSNVzxInoWGkzVd852U+NvFoEEaCA9JhA3TYvFkBh1UrqI2O
 DEQ1lN5ScUKvmipc9nJMHR2Yp/KVLe91Wb54sbJEP2WoVp68OHGDwRAOb3b168Zx0alU
 XPLx2DU4YmwwCBgtawRm5mOoK0Qf80S0DMVDahUe3kqgPwN1MrjGPuzcNdSThg/wkRrJ
 lE8MUJ3gpMx1ZK+UrmC6BmHaRZRzHwszJLEQjXXgVnKssc5Or6qy+NsGVQK+qiSTRry0
 ChBw==
X-Gm-Message-State: ANhLgQ3V2PXLDtKKE5ym7DVuNlsG23fGe7drOfwdvQA9wDzPOLoMgf6V
 IuuYjPCxw2rR22S0G/lYXKjMeXEdAuBXf21s3sS23MX5ngMoIF8IY9Xyg+VGF9KZEOv4OygbdWO
 Ea4VqhKuJOVNLN8PftvzQ00E+lREzqA==
X-Received: by 2002:a37:ef04:: with SMTP id j4mr8605770qkk.68.1583422764390;
 Thu, 05 Mar 2020 07:39:24 -0800 (PST)
X-Google-Smtp-Source: ADFU+vugbQrzs1xvBMEx8t8NnE6JKtfBaXVhDcJzv5NXl0ZNLWtGWOLk269aWs3+9NVlpA5U/V3/0w==
X-Received: by 2002:a37:ef04:: with SMTP id j4mr8605755qkk.68.1583422764197;
 Thu, 05 Mar 2020 07:39:24 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id w4sm2509730qts.92.2020.03.05.07.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 07:39:22 -0800 (PST)
Date: Thu, 5 Mar 2020 10:39:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200305103759-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
 <20200304142838-mutt-send-email-mst@kernel.org>
 <20200304215001.GD3315@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200304215001.GD3315@8bytes.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 linux-pci@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com,
 robin.murphy@arm.com
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

On Wed, Mar 04, 2020 at 10:50:02PM +0100, Joerg Roedel wrote:
> On Wed, Mar 04, 2020 at 02:34:33PM -0500, Michael S. Tsirkin wrote:
> > All these extra levels of indirection is one of the reasons
> > hypervisors such as kata try to avoid ACPI.
> 
> Platforms that don't use ACPI need another hardware detection mechanism,
> which can also be supported. But the first step here is to enable the
> general case, and for x86 platforms this means ACPI.
> 
> Regards,
> 
> 	Joerg

Frankly since a portable way to do it is needed anyway I don't see why
we also need ACPI.

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
