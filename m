Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53714C49ED7
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 14:51:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBFA207FC
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 14:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BB6nymCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBFA207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BCAB8CA1;
	Thu, 19 Sep 2019 14:51:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8E8E1C8F
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 14:51:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 038BA86E
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 14:51:27 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id t3so3417831edw.13
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=vg2zcBttUsMDTXTj6Y52ujR6gzQ0UC888oEHXYicUhU=;
	b=BB6nymCjrYWzk/ezn8V9Bq8KAzOheOe4V00zoaJQI/atMda4h54Mjta1Uc/U1nU5Sv
	P6uItwg2j6i5JS/3XBWemgPA5lOFQlGF4omk6PSeLFhTPsuwvLfEdAN8F1cZA7Fy9KDZ
	A2YZuhQ4yXE1EiOkGERPUkqchDSHIsSEoDo5/WkhC0zhcUY4OtX81qD1iqULmAkagnwK
	dTz/N78siErEbNh/2BPf/7174+TI8olQ+ElxPCIRoWyvP3GV6e2NqI+7g2CK6e0Opqha
	WHvMmg1qNdrM9FHLjYqcHpKnPlaJMQWxp/xK1G6+AJFDSKtYA5YRCKwktG72ZCxkar5v
	W6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=vg2zcBttUsMDTXTj6Y52ujR6gzQ0UC888oEHXYicUhU=;
	b=ZOw1QS3Xv4GiVpitUXLciqbDO1gXqI5PJgXMFL0fjL5Qd58lW4so9AT0K6dAm7W6UT
	h1F06Q2eoIfDXzsC+L5vXj7LofkTQ6aEKvEWQULo8uTQ+qc0hKmXukYQR0mtNGHQbY9n
	/QhlImQpGgp43so4YxNvz1iOyvIxNbFw+RA07naEOcI89mC5WcfVPbPn5XnmldDLysH/
	eCpD6z6jYjGoZ59uYBOGVq5KJulWGdCwuoYzGYEcxpteLID4xLttU64C1zf9EjRR8x8D
	2Vd19A+Ga56KxknGpVf2sTVnWOE22UVSFfoN1rqKmHOXGye+lIM79VJo1hadEz/QGVe3
	U9Qg==
X-Gm-Message-State: APjAAAWVUsHzqBnV9FdrWonjR/+iU33vEIvaYbNVcq5ISBmgztyIBWW2
	tcnukHVaD5r8qCnEsOJ+BqQd+Q==
X-Google-Smtp-Source: APXvYqyCvmJGG8xROMmxyF0PjR7AUd5prnHdYr7FnNrvlnFxqdqu5Pi0sRzdrKGCbsxBEQrr2IcUKA==
X-Received: by 2002:a17:906:31c3:: with SMTP id
	f3mr15028805ejf.296.1568904685177; 
	Thu, 19 Sep 2019 07:51:25 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id f6sm1666003edr.12.2019.09.19.07.51.23
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Sep 2019 07:51:24 -0700 (PDT)
Date: Thu, 19 Sep 2019 16:51:22 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 3/8] iommu/arm-smmu-v3: Support platform SSID
Message-ID: <20190919145122.GA1013538@lophozonia>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
	<20190610184714.6786-4-jean-philippe.brucker@arm.com>
	<63d4a71a-8e3f-f663-34bc-6647971b7e4b@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63d4a71a-8e3f-f663-34bc-6647971b7e4b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Hi Eric,

Sorry for the delay. I'll see if I can resend this for v5.5, although I
can't do much testing at the moment.

On Mon, Jul 08, 2019 at 09:58:22AM +0200, Auger Eric wrote:
> Hi Jean,
> 
> On 6/10/19 8:47 PM, Jean-Philippe Brucker wrote:
> > For platform devices that support SubstreamID (SSID), firmware provides
> > the number of supported SSID bits. Restrict it to what the SMMU supports
> > and cache it into master->ssid_bits.
> The commit message may give the impression the master's ssid_bits field
> only is used for platform devices.

Ok maybe I should add that this field will be used for PCI PASID as
well.

> > @@ -2097,6 +2098,16 @@ static int arm_smmu_add_device(struct device *dev)
> >  		}
> >  	}
> >  
> > +	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> In case the device is a PCI device, what is the value taken by
> fwspec->num_pasid_bits?

It would be zero, as firmware only specifies a value for platform
devices. For a PCI device, patch 8/8 fills master->ssid_bits from the
PCIe PASID capability.

> > +	/*
> > +	 * If the SMMU doesn't support 2-stage CD, limit the linear
> > +	 * tables to a reasonable number of contexts, let's say
> > +	 * 64kB / sizeof(ctx_desc) = 1024 = 2^10
> ctx_desc is 26B so 11bits would be OK

This refers to the size of the hardware context descriptor, not struct
arm_smmu_ctx_desc. Next version moves this to a define and makes it
clearer.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
