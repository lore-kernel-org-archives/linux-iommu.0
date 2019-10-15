Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B88ECE58E
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 07:56:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6E92089C
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 07:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i21eyPVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6E92089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 71421B6D;
	Tue, 15 Oct 2019 07:56:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F03A1B62
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 07:56:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A21E18A9
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 07:56:45 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id a15so17076599edt.6
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=purHCPGDjaKXkBT9wvD+Vn4dLucXAl8XRe5APKFmAL4=;
	b=i21eyPVWB0UJJtw29IaCJIn5X5m/4qC54mNfQFbR+mZgoEjTJrVlCkS3NRRnzDyFrE
	v55vFv3KYyKnKs/yP1Dk9iNltDwfelTDqDzVWY4yUZTb+memeZRKr3gXQAqRQunkumZl
	LSIe+GCv7AXoRPI6r0mcmAdTZvsK1tyYVfFiBZwV4IUGdsi6KBYcl2BLpMJo+m05x2MJ
	K8VMJdqusGaVP5K+2VrbuXSNoKsebYb+RnpqbEK4Sxmx3Op2+dibzT6IEL3of/xgD6ij
	HqIgNbJFjFj+IgDBy23MHdoibAIqZVp8ShbibSsp6HH7h10x98K7I7datCyiKmNeK7s/
	K30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=purHCPGDjaKXkBT9wvD+Vn4dLucXAl8XRe5APKFmAL4=;
	b=ddah6sqtYugtcGef79EH6ZRPNGWU7Qz8t0QBfgrGZd6rOcsqQ1CgiFttMiseEyzvJE
	xHTjuxajNPa3qvHsNw4lKniHUD2At3ICmd3FCiDEF4I86jdvIezKOWr6sfkOyQEZ7uYQ
	Sd5EPfS9mVVHJlFb+uv1X6rFYa7hc9Whss+Cn+taiJ4D0gZIBzl1Ex76KgVPMfUHJFH6
	MgiphI85qB7Iq4EpCXajT+4FiHVVJI7Ih0xRZSsCu9mXc7x2IbsarlFfZvFY5PyrzMCn
	v0UO007LHKOV7lRucwfUgHYUHrDAx1BGMCJwhqvhj8mutmPkhhYMMzG7PxoiqezDKaP8
	SwGA==
X-Gm-Message-State: APjAAAVRzeqgQAjULB4aBI5dBtETbYA26kTns8lyfr8nOWq2zGkrVaiK
	hNbtYrt3EKFnFqkOIg/6TYHaFg==
X-Google-Smtp-Source: APXvYqz87++12wSGikge8AEkKIiQU8AjWcOWzGOGNRXHRWUIyzTL0GFPStDmWg3XJPNCBwz9LHpsjQ==
X-Received: by 2002:a05:6402:21d6:: with SMTP id
	bi22mr31741791edb.19.1571126204054; 
	Tue, 15 Oct 2019 00:56:44 -0700 (PDT)
Received: from lophozonia ([85.195.192.192]) by smtp.gmail.com with ESMTPSA id
	br14sm2644807ejb.15.2019.10.15.00.56.42
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 15 Oct 2019 00:56:43 -0700 (PDT)
Date: Tue, 15 Oct 2019 09:56:41 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 0/4] User API for nested shared virtual address (SVA)
Message-ID: <20191015075641.GC1467695@lophozonia>
References: <1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20191007123912.60c19a79@jacob-builder>
	<20191014101405.5429571b@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191014101405.5429571b@jacob-builder>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Jonathan Cameron <jic23@kernel.org>
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

On Mon, Oct 14, 2019 at 10:14:05AM -0700, Jacob Pan wrote:
> Hi Joerg,
> 
> Just another gentle reminder. I think we have reached consensus in this
> common code. Jean and Eric can confirm.

Yes for the whole series

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
