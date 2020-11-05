Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EE6C55179
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 13:45:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0662072E
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+IcUuXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0662072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B625855A1;
	Thu,  5 Nov 2020 13:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wey-58nsMQ3J; Thu,  5 Nov 2020 13:45:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 13FFA85184;
	Thu,  5 Nov 2020 13:45:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E09A1C088B;
	Thu,  5 Nov 2020 13:45:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01018C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 13:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E42F7866BA
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 13:45:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KS0dgzqb5ucl for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 13:45:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EC72084AC4
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 13:45:23 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id j20so1585093edt.8
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 05:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cY/3RFCiWlUQB6QrufifDT87BGCRqW+LDcFPe8yjfGQ=;
 b=L+IcUuXNaN1Fu+OLg8NKhGiXu2ZR7uMIOsXv4280ppuO80GsRl3gF6GA8IZer6iCKi
 j5qgoByJVUBmRhd7svseKrZOU/ckFj9amkrH7KPbtipX85sn9NnfdvSH4lzuPXuMgezb
 efDFfsltEHuBtDKGLBTByR25u+fde4ZPoIifOlz93/jq9QxbFXxh4Q1NZh0Q+jYMMYrF
 8fhVMrl6HqMi08SEJdn/cufHjECbMmYoNOGmpDNZLHWhprg5rqFfj27SDA1GJyKBCnxG
 YCQYZw1C6yFkoQ5Ze/Q2z5AD75nwcdcAPlRndRKc/zOhL2qMWh4bv35ocslYVLOTWXxa
 zgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cY/3RFCiWlUQB6QrufifDT87BGCRqW+LDcFPe8yjfGQ=;
 b=BKE+pvg63epA7T09YCsTGswSduytvKu81L5ZXcmJQ5svBGFvnWXqh0Ob3xi/pjo35G
 r0QXX/rQ069ewVssqlhd/Q+fJadPoU8Fk4QtTGfnIgb5x45yJ2tJIsRdSBl0JMa4xBAc
 76QlELRRfXp1YFx5BsPYp19P4nsgYYsVd0auKsuPQJMIUgdFw7lWj/PrbEM3GJKjbXEC
 nCh+pQlDrYOVh1kdUBRQNfTE7gvcgmPmwxc73uxELVZFFivJcQhTCpTjtL9QBabkZrJC
 cHKvtdG9qFgeXWAzOBLKIg5DQjJ3xhbfFVsYUGxGOoeAWbrJYHZgbvbc22/+ZyyNCkm2
 qcFw==
X-Gm-Message-State: AOAM5300H/fSCrDRfFyQWvD7pGxnuyDDeXIOPNz7ni/1viTsP5ZhQcC3
 g8y3aU4p+lqdIrrfplSTUrsDnA==
X-Google-Smtp-Source: ABdhPJw+x2zq6rPpbtXD58CRplnH32FyiXu11PZf7hEFkW8jWOR5QS06eGGcQYiJodZl1HwmzjaFbA==
X-Received: by 2002:aa7:d843:: with SMTP id f3mr2700216eds.354.1604583922317; 
 Thu, 05 Nov 2020 05:45:22 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id rk5sm977288ejb.18.2020.11.05.05.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 05:45:21 -0800 (PST)
Date: Thu, 5 Nov 2020 14:45:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Yinghan Yang <Yinghan.Yang@microsoft.com>
Subject: Re: Question regarding VIOT proposal
Message-ID: <20201105134503.GA950007@myrica>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 sebastien.boeuf@intel.com, Alexander Grest <Alexander.Grest@microsoft.com>,
 ahs3@redhat.com
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

Hi,

On Thu, Nov 05, 2020 at 12:13:53AM +0000, Yinghan Yang via iommu wrote:
> Hi iommu developers,
> 
>  
> 
> I have a question regarding the recent VIOT submission for supporting
> paravirtualized IOMMU in guests. The spec defines PCI Range Node Structure
> (5.2.30.3) that maps to a single PCI segment.

(To provide some context for other readers, a description of the node is
available at https://jpbrucker.net/virtio-iommu/viot/viot-v8.pdf)

> 
>  
> 
> Is it possible for the new table to express that an IOMMU covers all PCI
> segments?  This could help support scenarios where:
> 
>  
> 
>  1. Devices are dynamically assigned to guests during runtime
>  2. Devices in the same guests are assigned to different segments.

This is possible with the current descriptor, assuming the PCI segments
are static. The platform can provide a PCI Range Node for each segment,
with a BDF range 0 - 0xffff. For example a table could describe:

* PCI Range Node
  * PCI Segment: 0
  * BDF start: 0
  * BDF end: 0xffff
  * Endpoint start: 0
  * Output node: &viommu
* PCI Range Node
  * PCI Segment: 1
  * BDF start: 0
  * BDF end: 0xffff
  * Endpoint start: 0x10000
  * Output node: &viommu
* viommu Node

Then the IOMMU covers all PCI devices on the two segments. To identify a
device when configuring DMA translation, the IOMMU driver builds a 32-bit
endpoint ID = Endpoint start + BDF.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
