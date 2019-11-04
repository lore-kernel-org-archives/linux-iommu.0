Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31ECA9ED2
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 07:54:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C7421D71
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 07:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2yVQ/mZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C7421D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CC76BB49;
	Mon,  4 Nov 2019 07:54:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BBC77AEF
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 07:54:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 748E1710
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 07:54:25 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id q13so15811332wrs.12
	for <iommu@lists.linux-foundation.org>;
	Sun, 03 Nov 2019 23:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=q3RH9aKhMCOj6QTRmd89NHsLi2YVADcB75E8Mv/2sWs=;
	b=z2yVQ/mZtfyy1iWUj+6k/cl0a6kCAdgr+Pe8zQowUyjbK4OWqECLs1pysJPTVENjs2
	T6LU0ahnuSsLLo2l4nntm2Ysu0P/WvCSgEFKgLEyLh/rdDelWE6h+4h7KU78TBcDTfkt
	72Y8iJZjS0ih4q+TCyYuYYAuxdpTDd1pps4UimDpoEl4RIC3IiSOgzhwtNZqmmLz7nb0
	7+I2j/YkNtoCG3AvzTQxcad/x+Qtn0EcE3FbvZwHTIt2sKFs/JqXuqyHLRMCC218Luqi
	tCOtrv3rHwmMD5i7EnGvekWmuEsYVt8ZHHYEV7ekcLZu58rBhXwZTvPqwiwQobv/TafL
	CFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=q3RH9aKhMCOj6QTRmd89NHsLi2YVADcB75E8Mv/2sWs=;
	b=qXI7OwcEb1PcBb4po+qz3QcMYFpB5tmLsJ5sO+2msf9DT0VWpUZFSpvujAVbsDpc04
	uxOo7BBwYNtthN6dWN1FTDsdQxHyAeg+4qi3/D9MDX5dLAdhgnTV0x6Ux1rh72ITmSjw
	M75RMIXViZLdGQ3aXqsjJTV44Vs3Xb0qe98xtm+4ovI3HiVceKrWgELOUDFk33fhelXr
	J7LW8+WoTmkcAE6Y1ZyYMFdLWJydD3c+f2trL7g4yAIocY/SaoE7fx9wlADIjOyzSI1N
	OBQaj+Namb7Kkoy/ZAWTgKjUmdMILjF6Jmh917iIQu9FLlWfw+X7XqO5SjnyQczusFwi
	fE4w==
X-Gm-Message-State: APjAAAWdzq7tKALNPWzzACQFprQccDZiS/MpoqL6S7pt7TzCuwYnma45
	QKyO8NoVGz8b1lYSzBGTc4dNMw==
X-Google-Smtp-Source: APXvYqzwTl0p24NIwpPNLzuLF7ZBZJYcawaApLHhcSd1TLwu+/dFYxfxYP6hXLot3M5Zc/SG+0qPmg==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr21547527wrv.119.1572854063846;
	Sun, 03 Nov 2019 23:54:23 -0800 (PST)
Received: from lophozonia ([85.195.192.192]) by smtp.gmail.com with ESMTPSA id
	o12sm7166620wrw.50.2019.11.03.23.54.22
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 03 Nov 2019 23:54:23 -0800 (PST)
Date: Mon, 4 Nov 2019 08:54:20 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
Message-ID: <20191104075420.GA2781989@lophozonia>
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
	<20191030155444.GC19096@willie-the-truck>
	<CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
	<20191031193758.GA2607492@lophozonia>
	<20191101172145.GA3983@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191101172145.GA3983@willie-the-truck>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	Saravana Kannan <saravanak@google.com>
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

Hi Will,

On Fri, Nov 01, 2019 at 05:21:46PM +0000, Will Deacon wrote:
> As far as symbols exported from the IOMMU and PCI layers, did you find you
> needed anything on top of the stuff I'm exporting in patches 1 and 3?

No, I needed the same symbols (minus fsl_mc_device_group and
iommu_group_ref_get).

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
