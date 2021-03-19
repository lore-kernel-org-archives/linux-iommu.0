Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6667C433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 13:41:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5632564F18
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 13:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5632564F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BEFE400F3;
	Fri, 19 Mar 2021 13:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1cO0Mbclvxb; Fri, 19 Mar 2021 13:41:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 38C0540113;
	Fri, 19 Mar 2021 13:41:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16F79C000A;
	Fri, 19 Mar 2021 13:41:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FE43C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 008FB4ED46
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6YCoY42KL_MP for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 13:41:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7EE2E4EC41
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:41:52 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id x16so9159971wrn.4
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 06:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DAYPn6BONqpHEbUgtaq686MIszfpE7Ws+kMTTaVpKdw=;
 b=IOd4Cob2v4qwcVrJJUnC6ZJVxIF2WBZVUhabq0Mv+BS0jxbHyUnYBlGulXszdU4mh5
 JXzpsK3jKuoU/S5b9nKYFRf5F0sT8Ih0u+BBZ97AbRXwrnLfybJJGTeRgA19XHDBH/6A
 EIDPKhijEx951g3qBOvaySlcB+XCF59BiLWj7FAAa+dfvbhhKPrkAChUBce435eNngqn
 R+HJqOzXYp0v+9UH9mxi/ExOXRx5qD4c7l8r5Po2L8As98VwmoUM9fKmxEPZfPe/fd7Q
 UbCXx9Q/ZuSWaZ1C6p/tiwNnPCGMuVJaU5azJ48KpQKEX3nEV8O7VaIWzhCFinZ0/Xoq
 OHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DAYPn6BONqpHEbUgtaq686MIszfpE7Ws+kMTTaVpKdw=;
 b=hy2TZY8K0ZI0wAcfnD/jVeJg9NBQcjuaQ8n29b/ftA5vaenZJkPIuAe2vf5VqxR5z6
 5TYmRqZg+cTYDPzDP0a0fnzS4aCgSD7YmBwEeQjbdm5HxkZEnEJQtsm+31GleNYO1waM
 xmVoEHcGfJ6v0/GFjoZM3AMhuLqfaVpTm1o7Maf9oqi+fdbFUK1eyW8lYLr8mpsXE2UE
 wNghdqPU26xVlbAyg6TP2ffgmruUjfppEUrhqgPbUpVorymFwLC/rOgWAZVPFRufChvO
 j0VgNhOXRs/3d2EvhsrBYlt3ThEs/MdWJntdTyzqt4zQ1upxF64M39z8Redjjs4K+bLH
 dIyQ==
X-Gm-Message-State: AOAM532eks+XHhnEm+U+I+yp4kCWkDuFAkfkQNQJDFHNll5Eeq85HNUZ
 pcpuhMV+3vP9FEjuZCxuIlccFg==
X-Google-Smtp-Source: ABdhPJyQGtsZyiZINsYu1PPARQsbLsQTm4cSQr/DP78vQm+uFeco8MqdIu7fVUjhkFhpApMilBcfpQ==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr4678213wrn.174.1616161310724; 
 Fri, 19 Mar 2021 06:41:50 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id l21sm6625021wmg.41.2021.03.19.06.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 06:41:50 -0700 (PDT)
Date: Fri, 19 Mar 2021 14:41:32 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YFSqDNJ5yagk4eO+@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319124645.GP2356281@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
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

On Fri, Mar 19, 2021 at 09:46:45AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 19, 2021 at 10:58:41AM +0100, Jean-Philippe Brucker wrote:
> 
> > Although there is no use for it at the moment (only two upstream users and
> > it looks like amdkfd always uses current too), I quite like the
> > client-server model where the privileged process does bind() and programs
> > the hardware queue on behalf of the client process.
> 
> This creates a lot complexity, how do does process A get a secure
> reference to B? How does it access the memory in B to setup the HW?

mm_access() for example, and passing addresses via IPC

> Why do we need separation anyhow? SVM devices are supposed to be
> secure or they shouldn't do SVM.

Right

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
