Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F4FC433ED
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 14:47:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FEF161029
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 14:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEF161029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48FD640FAF;
	Thu, 15 Apr 2021 14:47:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2IlI2Wkqj-n; Thu, 15 Apr 2021 14:47:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C9C840665;
	Thu, 15 Apr 2021 14:47:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04CFDC000C;
	Thu, 15 Apr 2021 14:47:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3753FC000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30F1840F56
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PGTgX9xCmnGC for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:47:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C3A640665
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:47:19 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id f8so28388761edd.11
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=n4QXf+cOw2jRuJk6NYVPzxIPebbr2HANj3LDOYShp5I=;
 b=Jd109QuvoPbeOBhKixUtBt5/Xnwa4xQuAOpVjrA87QwRWKtQDFDLIibyYB0+5GQIEJ
 aHUKSd66q6DYdd5JpKX4S150mKovE2TxkNTVe3vl2MLvTAzMdKOrCTHKx25rOnCWhR/F
 OO4Cr2eqsGRjUtNMQeJd1kDyoNYi5qwmQzWyAgVUOQnLYaqJf3mXGFsDGn57h5DDvtGD
 KhoiVuXcprEmmgcifdilXVTen5ekgIhIs4/XfFslUGr+rZWJmekmcoEtSDRWtOdWei9G
 1YVduS3e4+0pra7kKAPLQTYuiyZs1aOvYfMfhDDV7Bo6XiJq/rMj/UIUDB3UkQewSxvl
 gPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=n4QXf+cOw2jRuJk6NYVPzxIPebbr2HANj3LDOYShp5I=;
 b=cGVC/CG9QdWIl0iZQsBs1XsOH9jw8fGR2da7Wf/7tJfSVjGGxPutSm4QEplVtmpO7O
 74QNcMLZWsf9ZoyDmtZUnQyM2J0tsTBGHIufCGCZvKu/qrRizt3kAMmRvkY15Ws+wDEJ
 zi243gps57b9tfj9eMGCQR2BRjhR1AkYq+F64QLzYMSJEf93wUMZlYujWNkrXX6xuL/t
 5PAYZVyFnFJLGZWPAGETCeuyDeSviF+J3N97VlNz1GwhwDrX3IXW5beTg7JN5FdSDQSC
 J+qwmuMjBzZhE2rtftTY3x5pjbwozL1+uvkPB2nEgMbWtwCSzt//bDn+vWHByedMKBaU
 dUhw==
X-Gm-Message-State: AOAM533fiP4oZqkNl3iKpubthPp1tvm7sMArGfpXEqTmBzsVm1b0JrCg
 vhn3shNvBqE7hLK5W0+Ls/pJ0Q==
X-Google-Smtp-Source: ABdhPJz2+0NTKepbuICEjxCSs4LahmAuUZrrzKCZRlpZy/ROS/vkdkyyfjikrFbRCEfvo5bTe/kvaA==
X-Received: by 2002:a05:6402:614:: with SMTP id
 n20mr4606117edv.58.1618498038320; 
 Thu, 15 Apr 2021 07:47:18 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id f10sm2627950edd.29.2021.04.15.07.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 07:47:17 -0700 (PDT)
Date: Thu, 15 Apr 2021 16:46:58 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 2/3] ACPI: Add driver for the VIOT table
Message-ID: <YHhR4nSKYogouGMJ@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-3-jean-philippe@linaro.org>
 <cea43eef-35d2-b6c5-2bf0-ab7ba8473fb6@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cea43eef-35d2-b6c5-2bf0-ab7ba8473fb6@redhat.com>
Cc: kevin.tian@intel.com, mst@redhat.com, robin.murphy@arm.com,
 rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, will@kernel.org, lenb@kernel.org
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

On Fri, Mar 19, 2021 at 11:44:26AM +0100, Auger Eric wrote:
> add some kernel-doc comments matching the explanation in the commit message?

Yes, I'll add some comments. I got rid of the other issues you pointed out
while reworking the driver, should be more straightforward now

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
