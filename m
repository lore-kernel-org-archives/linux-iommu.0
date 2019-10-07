Return-Path: <SRS0=Lo8e=YA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D473ECE58C
	for <iommu@archiver.kernel.org>; Mon,  7 Oct 2019 18:24:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0193B206BB
	for <iommu@archiver.kernel.org>; Mon,  7 Oct 2019 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="as1shgEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0193B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 84C9CF2E;
	Mon,  7 Oct 2019 18:24:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5BA6BF14
	for <iommu@lists.linux-foundation.org>;
	Mon,  7 Oct 2019 18:24:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D6C8F604
	for <iommu@lists.linux-foundation.org>;
	Mon,  7 Oct 2019 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1570472660;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=eCQBbH69Pg1ZkWDiANjXEs7D77CgeYE54SQ2IQO4wnE=;
	b=as1shgEVyfW80E+FyuBBhml/4IPmzY6C1o7qN1rq0In3bsYU25sO1Liv3HUEeSN8opYVI6
	3xuxGUGqo9raOeWICrhvgwMbOV6VYsxZ/NBg5NEyjDw8CbiXp8kHY4mnYEsr4KjdVxp3bc
	EI9XkLsHSaKtxv3JK+Z1NLULpw3mjNQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
	[209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-256-uq8wuJiENpOLY3eKDgWp9g-1; Mon, 07 Oct 2019 14:24:18 -0400
Received: by mail-io1-f72.google.com with SMTP id k14so28119950iot.14
	for <iommu@lists.linux-foundation.org>;
	Mon, 07 Oct 2019 11:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=eCQBbH69Pg1ZkWDiANjXEs7D77CgeYE54SQ2IQO4wnE=;
	b=Eo76Gge3qkSXrHa7tg77NPo8z2CY5CCoitOL7KELiE7Bhbp5d233pcHPeNVcnd1pW3
	j1U4CFb7BJbkflIpS4K4xmAtXEuR8Nohv5kbIj1zDlGHJMHtuhvWGCMTwYWaMj5Bo8Hp
	Ug9L9BOXq69cj4PK0vzbgOw9dpFKb4rm77gZCj6eY9xAlG2OPs0gnbXUeZWAg/WAD8fn
	XYqY1rADl7gaVXmcqYwFVsdie62XPmfzFpkjyA7JkPDLpgMllpTwcWkQHFqBMMA9GHaU
	9fuOJlMSlXapTMwh0Blp542isEKKtlOu/pz9WATnCwTBdSViMz0s49IdRWH3+j1iDrvJ
	+pOw==
X-Gm-Message-State: APjAAAWJw0MBFdwzkZWG+7teoU1rv9+LytSCeaGq5Yxp/YD8wnIPbWjt
	8dOo/y1JorSLNBTV4zlrhR57zUEA9mLYtAQXzMQ6Sq4iaIEiU132EFzlQ1XCw3Nntpr2qSfACnX
	58w002jBJWJXI02gOj1ZJl5R7VP0gTg==
X-Received: by 2002:a92:9cca:: with SMTP id x71mr15879284ill.245.1570472658215;
	Mon, 07 Oct 2019 11:24:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRjcepKCt0gHU4J1fh/VS38XxOBSx6x1eDJ//ttvcWAF97bQNybglqC62SyFGnxx6CS0fwfw==
X-Received: by 2002:a92:9cca:: with SMTP id x71mr15879262ill.245.1570472657939;
	Mon, 07 Oct 2019 11:24:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id
	l13sm7026832ilq.56.2019.10.07.11.24.16
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 07 Oct 2019 11:24:16 -0700 (PDT)
Date: Mon, 7 Oct 2019 11:24:15 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Message-ID: <20191007182415.ftpojfdluoun34xm@cantor>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
	<20190924193739.86133-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190924193739.86133-7-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: uq8wuJiENpOLY3eKDgWp9g-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue Sep 24 19, Andy Shevchenko wrote:
>Since we have a generic helper, drop custom implementation in the driver.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
