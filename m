Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B67AC433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 17:17:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE89650AE
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 17:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE89650AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E46374ED3F;
	Fri,  5 Mar 2021 17:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g2muFFNyvYfN; Fri,  5 Mar 2021 17:17:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A31594ED4E;
	Fri,  5 Mar 2021 17:17:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88F00C000A;
	Fri,  5 Mar 2021 17:17:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9BAEC0001
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 17:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB16184435
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 17:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8BbQC-Kd5FLj for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 17:17:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC5FB84422
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 17:17:09 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id 7so2924991wrz.0
 for <iommu@lists.linux-foundation.org>; Fri, 05 Mar 2021 09:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Omevd0FBx005iXL14bFQltfa8ss9fF32vxOQu4J/uVM=;
 b=tzl5fhX/krPPRB6sEiaTWhW3YSjAMn88PlLbuYq0oNviAauvjp07tfa/KV98lTpk8/
 NLtaeVriS8ldYE4HDi94XRMPJg/1jy8NVsE89wO9zNH5POQyMAGWdMezN8SXiSGCA+SW
 kTdZqwqIDjGngUrv3hzgxlYhC+UDloP7Y7T0o+4Iw9QzRzG2RT802XrB52IFqNQMSJTj
 98HpANBxIWiGVNQHsqfmaNpvFN2VFuPOYEeZzoSAYzrboUEKuii9VegR/lZKLsUtYiId
 OItjdFaJCWib4s1ZjBYyiFg/qes7r9HJfyzcGqhdcmnL0LKAYU+sK7HFcG7Iii62F6mW
 2C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Omevd0FBx005iXL14bFQltfa8ss9fF32vxOQu4J/uVM=;
 b=oA9JV/akr+c84p1udjW8jGsdMPF4cZehMSjyjdth1SLiLdgJeHO4Wmgo2cASH/tpSW
 lQ3JrC7Hg2daN+d/GVD6W+9lbWrO2QiRhLF3SVw5TVmUbZ1CxCZNNRukhyh0Zw26oAo1
 ZSNiUhE2iBlXXfvLbwWk8ajqdjXpLxg0tXymTs9jLIut6QoRXBgr9+yB+9Mh/VHwHG6y
 BBUpeTFNYth+cDWTh61LAZsxXE1UloJOg1EJ3JfXOAFstawOCrn9ZCGlP+FTIrXW8KeX
 HWdujACP96TSDGt+4jUZLcfMewbjmrALDH6ahVYvOIObdKqpHnFr8aFGc7skJoWhFeXU
 qFYg==
X-Gm-Message-State: AOAM533nakJ9p8YCekmUOmqp1ewTimfcFazxJXqQfDQH1FOK1Lhn639M
 XGUw4YCxGEzWuEMxren+dCMG2A==
X-Google-Smtp-Source: ABdhPJzfKiNKYjg6f7z6fr15XCgQ0/breZONvYfwgXzPwXgjDe6AXHNnBp9m+CxfcpCHPXsoaldN7Q==
X-Received: by 2002:a5d:468e:: with SMTP id u14mr10462111wrq.359.1614964627745; 
 Fri, 05 Mar 2021 09:17:07 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id l15sm5462818wru.38.2021.03.05.09.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 09:17:07 -0800 (PST)
Date: Fri, 5 Mar 2021 18:16:45 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <YEJnfe+E0ZifuFR+@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
 <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder> <YECtMZNqSgh7jkGP@myrica>
 <20210304094603.4ab6c1c4@jacob-builder> <YEHsOR/XjDxQapE6@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YEHsOR/XjDxQapE6@myrica>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Fri, Mar 05, 2021 at 09:30:49AM +0100, Jean-Philippe Brucker wrote:
> That works but isn't perfect, because the hardware resource of shared
> address spaces can be much lower that PID limit - 16k ASIDs on Arm. To

Sorry I meant 16-bit here - 64k

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
