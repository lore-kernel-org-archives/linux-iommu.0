Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A3C3A5A2
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 16:33:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A922086A
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 16:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0JX8gdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A922086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1B41CD85;
	Fri, 20 Sep 2019 16:33:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C90FDD84
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 16:33:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3DDD48BA
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 16:33:31 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id a15so4379776edt.6
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Lz9d3bT2iTDFavDzy6sAIcID8XZxtTEbzw7l4vQwzrM=;
	b=p0JX8gdMWPJU184XlO69i0Dlt3nW8kFvKt8mI963agSS06/JfSoqSlNokWJrWOKWTm
	34RIqR5pKEa+G7begH2OXw4SQshgckQPX/dXppsMtx+N2MeAdFmLsgDOLXqoN0UkXhoi
	QojJOoTY7Xi5lrmxoWHP/xp0t0QhRz/4ipE6wAexrkOYXdfFuSotQe7avVo0e7lsoGhS
	wtwhC7Go94C8+nRODNZTDZeIctMnWV806PBo4h4LUEJnV3BuyrWZyVrM2uDVyubj/aA8
	B3LFm8EMoUqz12lM4t85gB/96Q5Y5L/78XophmMcqaoqescwo+YIpC80OGyBz8UjhmAh
	fdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Lz9d3bT2iTDFavDzy6sAIcID8XZxtTEbzw7l4vQwzrM=;
	b=ISQTQnyMVzixuxEfb5qlwFZ0tTTGKF6Dytpi0ZmmQc4vzk/LX2+36ieP3IRTUb5DdK
	Mqxb3jcdnoqpzmblPNAP3z2HETJqnwHbR+HCguqzScD83N/U0USYmKta/OnHB6ARrxAe
	K/tKDeolUbvZxGiMsZ6BO5YizHZhhkK+huWpOXkuUA5s/4lmXrPCb4VvFFq8KgJ/7i8U
	vVk/aqaswxIb5ndLEWsUJlrFKozIZaDcdhs+nRl93Fmq/BM5SCkmBRSfXyny9FUvAsE4
	NhadPeTHnDnQ3E0dOqvU6hLslL3rvFhFuGZg9sKDc8RXIcqxYUkjQB8Bpl9zPD4VHtN8
	0lQg==
X-Gm-Message-State: APjAAAW65wR6816PL9hPtjP7Ub94sUDbmaFLCqeuiP7SKhNveXNUztik
	/9Ls+MiIxWkHg8bHEqgCeE+z3g==
X-Google-Smtp-Source: APXvYqzhC+eWw5Se8TuzumlFhoWwytYvsZACh42IA+xfxeZVTTmhMBFQK9tBtPE5dAtAIa6Slhjkjg==
X-Received: by 2002:a05:6402:696:: with SMTP id
	f22mr21000371edy.216.1568997209854; 
	Fri, 20 Sep 2019 09:33:29 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id s16sm406346edd.39.2019.09.20.09.33.28
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 20 Sep 2019 09:33:29 -0700 (PDT)
Date: Fri, 20 Sep 2019 18:33:27 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 2/4] iommu: Add I/O ASID allocator
Message-ID: <20190920163327.GB1533866@lophozonia>
References: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1568849194-47874-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568849194-47874-3-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
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

On Wed, Sep 18, 2019 at 04:26:32PM -0700, Jacob Pan wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> Some devices might support multiple DMA address spaces, in particular
> those that have the PCI PASID feature. PASID (Process Address Space ID)
> allows to share process address spaces with devices (SVA), partition a
> device into VM-assignable entities (VFIO mdev) or simply provide
> multiple DMA address space to kernel drivers. Add a global PASID
> allocator usable by different drivers at the same time. Name it I/O ASID
> to avoid confusion with ASIDs allocated by arch code, which are usually
> a separate ID space.
> 
> The IOASID space is global. Each device can have its own PASID space,
> but by convention the IOMMU ended up having a global PASID space, so
> that with SVA, each mm_struct is associated to a single PASID.
> 
> The allocator is primarily used by IOMMU subsystem but in rare occasions
> drivers would like to allocate PASIDs for devices that aren't managed by
> an IOMMU, using the same ID space as IOMMU.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
