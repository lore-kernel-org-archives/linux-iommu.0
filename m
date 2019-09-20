Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591E4C4CEC9
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 16:38:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239B220B7C
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oof2UcZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239B220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EB2AFD88;
	Fri, 20 Sep 2019 16:38:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3E421ACC
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 16:38:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B3E5A8AC
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 16:38:47 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id v8so7113414eds.2
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=+JjVHOFtPkrIu+975k/69BRdOa3f1zZRGu6VFUJO+SE=;
	b=Oof2UcZtDBoL9r9YUCMpa+YnL1BKRRXdv7Tg4CF5oueJtWk+uI/AjuBbiD2CpsKKDn
	AJyUm43wEixxj0qrSfWYAMFH/5/QhaW282DyEwlTgG4FfNoIRDvyhemzDmKmj1JIloiA
	1NcnNuKU8cn5kN+lFOgJAV49GCt2d3K5r+DV3ZOuIgTWx74V5iWK9PH66MBrRLVPBEUp
	U5x9zERtv5LXZcdyFhAHH4kVijTEt98/vZF2jd80k77DoUU2q1UJen0oKmMMC2UaTi1U
	QOkg3f/Z+qjV88usI7PtEbXVbx0F5kKrmQmI2iY+Xp11ZQ4LcSYhXXD2ejNv6YjUuMVc
	L6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=+JjVHOFtPkrIu+975k/69BRdOa3f1zZRGu6VFUJO+SE=;
	b=ktHXw2qjls4ANf3TvAYmvWE6ircIwBXOWl9D7Ijm+eIr/M0vkmzRHaR7WC4J+IbezH
	MRElVoMwR7qfhIxaBFvd/qNnkG0/Xm800pK2gL+GOQyopl4uAh2v+xYFaMIJHQHipdog
	hn1AsqJu1eb3dov9UWK2Fea+dQiKXxY/b6zu/ho2pdhwgVdtaYnJO3z6Yq85HeBzrLd3
	EOAN+JJEb51qiZVdEhOwmeUZIQsDQwSiB/6yW0Tm9bjz9HmKwLjevgMeX5EuCqVEaLK7
	QAMbEuzpnAkIp54h2t84LPG+7d7Dm/QRmjCiBn6qhshvkSiOUwQW+At7M19P3epK7n7C
	D+HQ==
X-Gm-Message-State: APjAAAUS7bEUZ3fHeCu3qoGl7kYeZOM6oIDD79bNEkOyL/7Diz4TdVvg
	IwbbLh0e0+2howUH9xP/n6p5Cw==
X-Google-Smtp-Source: APXvYqwJczKwjDOiGLA7EtKQlZ9dOCzqyi58hY9xeDlLLlGSMNkfPS+mwtXM4drn+jdNkHaovaWf1Q==
X-Received: by 2002:a17:907:20a2:: with SMTP id
	pw2mr19642839ejb.163.1568997526248; 
	Fri, 20 Sep 2019 09:38:46 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id e39sm407528edb.69.2019.09.20.09.38.45
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 20 Sep 2019 09:38:45 -0700 (PDT)
Date: Fri, 20 Sep 2019 18:38:43 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 4/4] iommu: Introduce guest PASID bind function
Message-ID: <20190920163843.GD1533866@lophozonia>
References: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1568849194-47874-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568849194-47874-5-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Wed, Sep 18, 2019 at 04:26:34PM -0700, Jacob Pan wrote:
> Guest shared virtual address (SVA) may require host to shadow guest
> PASID tables. Guest PASID can also be allocated from the host via
> enlightened interfaces. In this case, guest needs to bind the guest
> mm, i.e. cr3 in guest physical address to the actual PASID table in
> the host IOMMU. Nesting will be turned on such that guest virtual
> address can go through a two level translation:
> - 1st level translates GVA to GPA
> - 2nd level translates GPA to HPA
> This patch introduces APIs to bind guest PASID data to the assigned
> device entry in the physical IOMMU. See the diagram below for usage
> explaination.

explanation

Otherwise Looks fine to me. I was wondering if we would be able to reuse
the API for Arm SMMUv2, which allows nesting translation, but without
PASID - there is a single address space per device, with two stages of
translation. I think it would work, although it would look better with
something like "PGD" instead of "PASID" in the API names (e.g.
iommu_sva_bind_gpgd) since that case wouldn't use PASID at all. But I
don't want to quibble over names, so

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
