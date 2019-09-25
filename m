Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD7FC432C1
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 04:31:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035B620665
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 04:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035B620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C53E3B50;
	Wed, 25 Sep 2019 04:31:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B96018BF
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 04:31:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 53E0C8A
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 04:31:05 +0000 (UTC)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
	[209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9752F4E908
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 04:31:04 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id m1so2783469pgq.5
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 21:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=4ynUg0HQbXYGY2EZQxVg6auXL0jYkF08J5NPdzyoPwU=;
	b=T0dUV3DCgJZdbLM/PjwsIxSNxXsQND62k1Ao4AdZSs6HZbU7Av+6y1Zjbzo7/TD5ld
	HmM7Q7sXI4gwRoH9Ds7hNAjIfT7HEBDS6hwmikq3GRjAomri2A04j3HA6QfVQy66WkwW
	FTH4dW+sHGgYEURMkuDYz7D1URBOT6lJpvIXiE2ILH61N/Yj+UN/ObKDsy5ZPBWIQxUi
	7IVSmBTUuwBpXoBfgVunN9tLxOQHuieCKN84+KfyQC5mtASYm/84m9B0wjW8eow1Q3CY
	kPG/K3xBtYgWTko9rMGjC0qlyhgDuiQ/oegSXGAh6+22A+qc4hSvIy4MSydzXjhFEkvf
	EKqQ==
X-Gm-Message-State: APjAAAXW9y/4x1ph1DAM1OvlxlSn4pb7bCCYLoCIEmLbd51k5vORTzYy
	GiF9tngJz71EfuAT0Y6wOE+eCJY14kJy6GU2XNZprq9M5hz/cVhWAPODIBvVXq/5k1AYfkONSzP
	L1cfuFhhrlepMUcP6Uiu18wnt7tgCRg==
X-Received: by 2002:a17:902:7796:: with SMTP id
	o22mr7013584pll.222.1569385863883; 
	Tue, 24 Sep 2019 21:31:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYc48a4lrqvlO6kVhQ/UCi7qF+uCt4R+18KQwSaFo3Uxwb45dh8PhpKk4Lh42FKW2HgHzXYg==
X-Received: by 2002:a17:902:7796:: with SMTP id
	o22mr7013535pll.222.1569385863511; 
	Tue, 24 Sep 2019 21:31:03 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80]) by smtp.gmail.com with ESMTPSA id
	ep10sm6428239pjb.2.2019.09.24.21.30.58
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 24 Sep 2019 21:31:02 -0700 (PDT)
Date: Wed, 25 Sep 2019 12:30:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190925043050.GK28074@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122454.9888-3-baolu.lu@linux.intel.com>
	<20190923203102.GB21816@araj-mobl1.jf.intel.com>
	<9cfe6042-f0fb-ea5e-e134-f6f5bb9eb7b0@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9cfe6042-f0fb-ea5e-e134-f6f5bb9eb7b0@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Cc: Alex Williamson <alex.williamson@redhat.com>, kevin.tian@intel.com,
	Yi Sun <yi.y.sun@linux.intel.com>, "Raj,
	Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
	sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Sep 24, 2019 at 09:38:53AM +0800, Lu Baolu wrote:
> > > intel_mmmap_range(domain, addr, end, phys_addr, prot)
> > 
> > Maybe think of a different name..? mmmap seems a bit weird :-)
> 
> Yes. I don't like it either. I've thought about it and haven't
> figured out a satisfied one. Do you have any suggestions?

How about at least split the word using "_"?  Like "mm_map", then
apply it to all the "mmm*" prefixes.  Otherwise it'll be easily
misread as mmap() which is totally irrelevant to this...

Regards,

-- 
Peter Xu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
