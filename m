Return-Path: <SRS0=ltgl=33=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E317AC352A3
	for <iommu@archiver.kernel.org>; Fri,  7 Feb 2020 08:47:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA738214AF
	for <iommu@archiver.kernel.org>; Fri,  7 Feb 2020 08:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IB3SDQMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA738214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BB7B86432;
	Fri,  7 Feb 2020 08:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oTUhglPpPhDd; Fri,  7 Feb 2020 08:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E7770863CD;
	Fri,  7 Feb 2020 08:47:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA17EC1D81;
	Fri,  7 Feb 2020 08:47:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B9A5C013E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Feb 2020 08:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 733F987D65
 for <iommu@lists.linux-foundation.org>; Fri,  7 Feb 2020 08:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5BuCnWa-c0m7 for <iommu@lists.linux-foundation.org>;
 Fri,  7 Feb 2020 08:47:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7AF2C87D57
 for <iommu@lists.linux-foundation.org>; Fri,  7 Feb 2020 08:47:43 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id s144so2674480wme.1
 for <iommu@lists.linux-foundation.org>; Fri, 07 Feb 2020 00:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=309I1I7pmnmndXbQ/NrLjRZ5f4RF1ubjPE99EH9brrw=;
 b=IB3SDQMetP4BY0/eWhuXAQOym90cQN+0zLfSkhbRZYzUZ74jSGXrVyDm3f4e3jqS4s
 dmWvlHVO58GacxDzmsAZSthT9AIwjna7LXWIyp92G9LWRJN7lfc8sFJ3W5X4OhlrnKRB
 lXaxxocvYowIZ9RYRJCWxgmZWPhsvOITOJrYcQijufHHhDcCbDuRHK91DfysrPHJ1VPq
 RRmugKvN9NMDF0AlrjJ6achOuMLYc+f7u6uNEogy/6ur0qedNqQsxwbdtC7ZfWWI3vBk
 MN4icM1zoWDA96M7ZqwT9cv/4gBo5MCejS38NmQ1d2O6Gah3ObeXeIxLWMN6Zc3yO7aS
 8Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=309I1I7pmnmndXbQ/NrLjRZ5f4RF1ubjPE99EH9brrw=;
 b=WaS+CQBLIc1nO9SStrjznUhjzglJE0n8l+0YBTAE2goGzcu2nzONrpr+kUGk0SNius
 mQ3l0ib3aWvPml3+LCq4+/GHEo+2rkwGYFNO331mxIyJWNeTVr+vdxhg/zojB7ECYV3V
 nbmFlqameM2nmpK0g9pu4KnaemNB7lyPDA8hq7x4FVcG+i0io90Eb1uxUBRwUUF7t/0H
 E92BS1SSaTIG3lN0xHRy7XFsJWVuPNnXWBPdiRH9ZLjBcnUdq/eWuisn1efttbWmxa9U
 /TR3texMMNjlvNGvURCDpH4/c9pQp1zKs7foWX2hMEyqoK1mX+ZdA+y1jenrOTBu8CiT
 efzQ==
X-Gm-Message-State: APjAAAVsUumPV/dhTNeJN8iVsYDBzBponww+x+S7bhAifdqeu5uSmmOB
 SvZmI9uS3+rhjqflXzdCoMUigw==
X-Google-Smtp-Source: APXvYqw3+blGRg0QVRTyhSizPcM9fuksHU15TzCcQW2Mtlnt3tqUT1gUsX+krTKQ+KNFLGHY38wGqQ==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr3116111wmj.105.1581065261841; 
 Fri, 07 Feb 2020 00:47:41 -0800 (PST)
Received: from myrica ([2001:171b:c9ad:af70:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c141sm2495221wme.41.2020.02.07.00.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 00:47:41 -0800 (PST)
Date: Fri, 7 Feb 2020 09:47:32 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200207084732.GA1994440@myrica>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200129144046.3f91e4c1@w520.home>
 <20200129151951.2e354e37@w520.home>
 <20200131155125.53475a72@jacob-builder>
 <20200203112708.14174ce2@w520.home>
 <20200203124143.05061d1e@jacob-builder>
 <20200203141236.4e2d7a74@w520.home>
 <20200203144102.643f9684@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200203144102.643f9684@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Mon, Feb 03, 2020 at 02:41:02PM -0800, Jacob Pan wrote:
> Yeah, that would work as well. I just feel IOMMU UAPI is unlikely to get
> updated frequently, should be much less than adding new capabilities.
> I think argsz could be viewed as the version field set by the
> user, minsz is what kernel current code supports.
> 
> So let me summarize the options we have
> 1. Disallow adding new members to each structure other than reuse
> padding bits or adding union members at the end.
> 2. Allow extension of the structures beyond union, but union size has
> to be fixed with reserved spaces
> 3. Adopt VFIO argsz scheme, I don't think we need version for each
> struct anymore. argsz implies the version that user is using assuming
> UAPI data is extension only.
> 
> Jean, Eric, any comments? My preference is #1. In the apocalyptic event
> when we run out of padding, perhaps we can introduce a new API_v2 :)

I agree, new extensions will most likely want to extend the vendor
specific structures at the end rather than introduce new common fields, so
I prefer #1 which avoids fixing the union size.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
