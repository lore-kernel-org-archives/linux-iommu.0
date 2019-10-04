Return-Path: <SRS0=qml7=X5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9C0C4360C
	for <iommu@archiver.kernel.org>; Fri,  4 Oct 2019 17:18:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86850222C0
	for <iommu@archiver.kernel.org>; Fri,  4 Oct 2019 17:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="enBXaEXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86850222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 21BC3CAC;
	Fri,  4 Oct 2019 17:18:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 93892ACC
	for <iommu@lists.linux-foundation.org>;
	Fri,  4 Oct 2019 17:18:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5F82E8A0
	for <iommu@lists.linux-foundation.org>;
	Fri,  4 Oct 2019 17:18:40 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id a15so6625928edt.6
	for <iommu@lists.linux-foundation.org>;
	Fri, 04 Oct 2019 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=P6ILDe87atoSpFhr4YLtT8v1Dvs0XN+7b56hhQlsV+s=;
	b=enBXaEXpHjow9+Pz4mdlFTKzl3G3RGqsECSmVPyToON6sDWTvSqWHSCx3aJP7zHb8m
	c5uclc8HWH8hKvhXKNL0V66ONtWbEHwLYEKfdDFvB2KSdfzcCscgixU48XqCxakcz/FZ
	+qIWnSiT09Tf9EyszAAZicDPeHJ5BrbR8rjE7aaiuwurLJA1u9SBnHjmsCMQJKhElirg
	3Qhh9ao8k5amjIpmewf2qbDCXbwfHZ4YoESlQVwSlJiqcB76aEbrl7hu5ITYQIiY+qyI
	Czo3TxSQRSd/4RyxPrqJtpyVh/yUh1/W7htb9LUJ+WVZaB22qdnYAd4q5YLPc3FHkbz6
	G+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=P6ILDe87atoSpFhr4YLtT8v1Dvs0XN+7b56hhQlsV+s=;
	b=lKLB3/4Ck4krA/phCEYjbcHTVU2SyJmKiCSMonkd2CzPPygmySpyyaSY5XslRnOYZ0
	oVb308noyuqpFkQfzm+metRkKlt8Z9GHfn2vxH56OUZrYvfKeqp7BXACfIsGLSca+FdT
	7NYNB1mULibGC6/0FmiRTkzjBsC4OHBSgPOVAPhBMw8AtUQKZctTwE6lyVkwO4YZkfkw
	0g6GHNUC6i5EBX7s/FDVNE6aAx8ynZOIZJbp3wtBb1ePHP+Qfc8IunADx8kn5TY+aZe+
	8ElR4KchMkh/khFDOhk3HIUEuPvZ4Avr118x6oEmiN3gjQWQPGRbXhLnJyzIzROYPSYl
	7eSg==
X-Gm-Message-State: APjAAAWxZ9qVnqjQTDZHVnxvxQEnXVhep16zV2Rsuws7jjezc3qfVZXx
	LcymTdpD1hrv33FYinNvWVcv9WCF3dnkWQ==
X-Google-Smtp-Source: APXvYqzwBvrnmFzZsa1Mpgi+XTXje83ZYwyx65gwJfmNiNPb0bxR4U6+rzPdd2I0VzhmJVaxNcWfaQ==
X-Received: by 2002:a17:906:b30b:: with SMTP id
	n11mr13772893ejz.35.1570209518810; 
	Fri, 04 Oct 2019 10:18:38 -0700 (PDT)
Received: from lophozonia ([85.195.192.192]) by smtp.gmail.com with ESMTPSA id
	s42sm1230595edm.57.2019.10.04.10.18.37
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 04 Oct 2019 10:18:37 -0700 (PDT)
Date: Fri, 4 Oct 2019 19:18:35 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 3/4] iommu/ioasid: Add custom allocators
Message-ID: <20191004171835.GB1180125@lophozonia>
References: <1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1570045363-24856-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1570045363-24856-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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

On Wed, Oct 02, 2019 at 12:42:42PM -0700, Jacob Pan wrote:
> IOASID allocation may rely on platform specific methods. One use case is
> that when running in the guest, in order to obtain system wide global
> IOASIDs, emulated allocation interface is needed to communicate with the
> host. Here we call these platform specific allocators custom allocators.
> 
> Custom IOASID allocators can be registered at runtime and take precedence
> over the default XArray allocator. They have these attributes:
> 
> - provides platform specific alloc()/free() functions with private data.
> - allocation results lookup are not provided by the allocator, lookup
>   request must be done by the IOASID framework by its own XArray.
> - allocators can be unregistered at runtime, either fallback to the next
>   custom allocator or to the default allocator.
> - custom allocators can share the same set of alloc()/free() helpers, in
>   this case they also share the same IOASID space, thus the same XArray.
> - switching between allocators requires all outstanding IOASIDs to be
>   freed unless the two allocators share the same alloc()/free() helpers.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Link: https://lkml.org/lkml/2019/4/26/462

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
