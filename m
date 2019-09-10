Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63305C3A5A2
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 13:07:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0873320872
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 13:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fNHYzend"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0873320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C80FBD83;
	Tue, 10 Sep 2019 13:07:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4F12DD7E
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 13:07:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
	[209.85.160.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C65918A8
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 13:06:59 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id l22so20558790qtp.10
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ASE1TxqHxoQy/9+ZIyebCZ4/X98h1y96zbHFXcrt9Hc=;
	b=fNHYzendEn+7XjJwESvxEJECk5xkJay+I1Gc4OARmEZxdP1tio57T5S/wiXJGSF2YJ
	ChoOi1PTCisVsvCe/D4KtArcRmurIO7q7OYAQT2m2sdYkv5HAzVaCRVAIQXvtOtg2EYd
	YB9qx534XiqcgDk4etBwB7rpR9hDRuWcFEFG+qV4pP9t+WnHNOWmVgbz2ZJyCEFSVzKz
	35W5w9Jq2Q7B6rDgwzzbgxpD7QgEY7bkMrlxEbU8hB9XXg8XrDRDB2MKAXKCuem81j/X
	q1kBqxTQDJCL5i8sTn3Hn0vwGvgbMBx6DliR3VLUu/ox5xoP+khOpVMhA+6vhZBiniGT
	Nmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ASE1TxqHxoQy/9+ZIyebCZ4/X98h1y96zbHFXcrt9Hc=;
	b=Cp7YvOTgI7Q0pUyfu4+xxprZHWfyhIQYWXy02SW67irhhrXgNG5dDW/2YWJa0f3ICs
	/Qnbm9tSabICpaKOX1v6ehoMxVBq5ihZMY7kmZnqgtJ95su/VjKO7TDT6OLGZpteNkJl
	cgd0cFoz75sJZatCdw/ViMz0f76Ll0Us8HrUMur1tKnqlRIe6XSb8x3EPX/qWMzW0cQe
	pXMZYnAR4jbUVfpoM5lsUFZDi+412sOOWwySRyNqQK/7d9+iPNchnqdSY9sCPAEo3GVT
	4UlInJS0E7ye11leTlro0WQo28sRUs0TB1xCyXw08Sr5NOIgLcaYKvJ4ByUyRYh8wmvF
	0ZCQ==
X-Gm-Message-State: APjAAAX0Nxzq75IWpFeLu9iz7GWPbIYnhW9MKgLD99WaZFAcuBqzg94e
	vxJh+czXNpWJooNwRaZybmWXVQ==
X-Google-Smtp-Source: APXvYqw6NzXuCBBt+jzAvP6t9yWH5gmW7Ib/dIYVefW5g2jqFLgtnGa1SM/rDn3t5HMOEbbcqrS7Qg==
X-Received: by 2002:ac8:4915:: with SMTP id e21mr28871983qtq.5.1568120818685; 
	Tue, 10 Sep 2019 06:06:58 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	h137sm8838344qke.51.2019.09.10.06.06.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 10 Sep 2019 06:06:58 -0700 (PDT)
Message-ID: <1568120816.5576.125.camel@lca.pw>
Subject: Re: [PATCH] iommu/vt-d: Make function signatures static
From: Qian Cai <cai@lca.pw>
To: Joerg Roedel <joro@8bytes.org>, Adam Zerella <adam.zerella@gmail.com>
Date: Tue, 10 Sep 2019 09:06:56 -0400
In-Reply-To: <20190910081545.GC3247@8bytes.org>
References: <20190907064933.15277-1-adam.zerella@gmail.com>
	<20190910081545.GC3247@8bytes.org>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org
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

On Tue, 2019-09-10 at 10:15 +0200, Joerg Roedel wrote:
> On Sat, Sep 07, 2019 at 04:49:33PM +1000, Adam Zerella wrote:
> >  drivers/iommu/intel-iommu.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Applied, thanks.

Joerg, not sure if you saw the reply from Lu,

https://lore.kernel.org/linux-iommu/ba8d4792-3b62-98a8-31d8-74a08be2f983@linux.i
ntel.com/

This patch is not even compiled for me as well.

WARNING: "intel_iommu_gfx_mapped" [vmlinux] is a static EXPORT_SYMBOL_GPL
drivers/iommu/dmar.o: In function `iommu_device_set_ops':
/home/linux-mm/linux/./include/linux/iommu.h:382: undefined reference to
`intel_iommu_ops'
make: *** [Makefile:1096: vmlinux] Error 1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
