Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BF7C433ED
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 08:02:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02662613C0
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 08:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02662613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC61A40E78;
	Tue,  6 Apr 2021 08:02:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lFw4bzHH4qQq; Tue,  6 Apr 2021 08:02:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7069340E75;
	Tue,  6 Apr 2021 08:02:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48724C000B;
	Tue,  6 Apr 2021 08:02:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95E4FC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 08:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7604540E77
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 08:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uovv_DU4Ggqq for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 08:01:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FADC40E75
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 08:01:59 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id a6so7124133wrw.8
 for <iommu@lists.linux-foundation.org>; Tue, 06 Apr 2021 01:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=l6nxo53q82s9jFF8yCXZZrdNcQ5A9DZSWcm5GmtmFA0=;
 b=SbBE1QB1LbEE/X6vrKzgWskUD23QC2zC7nnG0k0s03MqGXbNuFBFlqHTKpZPrf36rr
 gdfF6F8BpEP3FHWFUC6H8VhRNbjTkQG8KgaqOSxGBx7DncuyAbBmd7AHSNrb7F1soS6U
 EbCvV1ry8PkKV8qV4W7J1HqpnlOWwES18/B1coP8xIF7Ev0riTJzZXY/xFTB7dcfZNgR
 /wVztKBl6Cxj6u0hzYMp0WNdgQoSe9QkMvMWgFHcbOzAekjWMtpBJ/GEJIVNLghZjd+i
 p/qIGNCinh/zRwMR/vQF3h5vcanwPIlyQVowBJK8CcwG+4S9Y5RFSPxCftiHuxvE27DL
 fOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l6nxo53q82s9jFF8yCXZZrdNcQ5A9DZSWcm5GmtmFA0=;
 b=Wb2c9oD6y+CoHMvozeSz40vGnQG3XUSC7Id34kEmuzwGOrH5vmJsYCnOKoii/YpisM
 nXY6SChTh9Ixjrx01CaigS5JG1n2BZLAdW6kY5vXZl2nyXzu/OpRS8c8Yx3b4tzva5bA
 hSLAKIMHIY0pskNocX/YPiVqKlhxL5GpHNFoQLMtTo81Hih0xij3O1/pCXgUQA9LBkkk
 CXh6Tc4DYXUDDR1Vl6OguGN+n0llLhLDWSOUXMuYN4jqnHgu11O/LPt4TARJwu+rWcZc
 sOjvYPJ9x8m0AgXnZ1FtfRElTeTNy8Mk/NZXFv2KjsjND9gZ7K12/IJoph+sLsrzGaxo
 XX3w==
X-Gm-Message-State: AOAM533Y9xK+TpLzimxiONPadfZ3gioOI/HpF8Ff5SjaER+gBBSnYCDa
 BhExL893yZ5eflwRDN+OzNYR4A==
X-Google-Smtp-Source: ABdhPJzhRli50lNrS7WlnHzOkeHBK47qTBIwPKWqBK58LCMpLq00FFsdNzmzvYgkzLnXPgKx2ZkRMA==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr4755320wrp.19.1617696117707; 
 Tue, 06 Apr 2021 01:01:57 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id t20sm1803704wmi.15.2021.04.06.01.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Apr 2021 01:01:57 -0700 (PDT)
Date: Tue, 6 Apr 2021 10:01:39 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v14 00/10] iommu: I/O page faults for SMMUv3
Message-ID: <YGwVY3W4vk6kve3G@myrica>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
 <20210401171501.GC9447@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210401171501.GC9447@willie-the-truck>
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

On Thu, Apr 01, 2021 at 06:15:02PM +0100, Will Deacon wrote:
> On Thu, Apr 01, 2021 at 05:47:09PM +0200, Jean-Philippe Brucker wrote:
> > Add stall support to the SMMUv3 driver, along with a common I/O Page
> > Fault handler.
> > 
> > Since [v13] I added review and ack tags (Thanks!), and a lockdep_assert.
> > It would be good to have all of it in v5.13, since patch 10 introduces
> > the first user for the IOPF interface from patch 6.  But if that's not
> > possible, please pick patches 1-6 so the Vt-d driver can start using
> > them.
> 
> Patches 1-7 look good to me, but I'm not convinced about the utility of
> stalling faults so I'd prefer the later patches to come along with a
> real user.

As others said, it is possible to assign queues from the compression and
crypto accelerators on the Kunpeng920 to userspace, using the uacce char
device (upstream since last year, but waiting for implementations of the
SVA API in IOMMU drivers). I've been using that platform for testing my
code for the past year, with the UADK tool as well as an openssl plugin.

Securely assignig a queue to userspace requires full SVA support in
SMMUv3, which consists of PASID, page table sharing, and I/O page faults.
The first two were already merged, and the third one requires either Stall
or PRI. I'm not submitting PRI support at the moment because there is no
hardware, but the Hisilicon platform implements stall and will be able to
use it right away.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
