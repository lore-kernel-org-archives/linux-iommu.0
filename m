Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8560CC3A5A6
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 15:10:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5341921924
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 15:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oP8A5i+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5341921924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2A177C75;
	Thu, 19 Sep 2019 15:10:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 22119C03
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 15:10:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E2D1B8A3
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 15:10:06 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id r9so3497438edl.10
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=AtJmx7YzvmNMJX7vvcIKkFLqCflOxxyrvK1PoirDPTw=;
	b=oP8A5i+95DshExg2j5Uy8V9cUWkT0LstsMnL2HErbO3Vbig4wntTV4m9mYDptkb17n
	DAQHzC8LQ2HHXAIlqY5oIicOzr1wdnGP8KPctTWRc8JkI8n/5S2+1EkzYZyn93b7xA1L
	NRMSQHt8iAoE7YAYXWfur0TQYTo8GWxJZe5JgQytR/3NugB/OyojB6PhG45vS5P5rCgU
	vIx+13MlRVX+3pbxQFpNkjMlKkilkbYM3IuJysA6VOviuAKnocL55IrKfuuCVLzkrQjJ
	X3ULAwILuiC2s4Vo0QyTdo9hMV7Jp7SwibWqDyGQH8nHWaysISxxH80tBDisIJEEM9WM
	HTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=AtJmx7YzvmNMJX7vvcIKkFLqCflOxxyrvK1PoirDPTw=;
	b=dXahRQvZvsn5hT1q7jo2FefiafaqtUAp3YPGAkSsnAOLs9guD1/vJtjCX5azLK5TH1
	tj0owj9U+diba69bzM4DUsMzFxw1oflZYA64EdgfOO8kDtApPVImUy7j8d1tvItIll0q
	lqRonbGhTT+wql0kEWrzgKrtRfLhW8QODFmtBwsUgAqi7uQEVHR46ajn9hvyX5lpltKV
	GunfDsARTYEPOqIZnTPAvbbLA0s/rvopr+RWs3U10QUsP8NJuqq+YJ7V1fY8ECUOUnjd
	OlJ1hjggBieezDGeEVg2gCmXoy5sL5+dzeXo+TYRswy9SsUSsSNs5+PUVSojPb4AzGAS
	UdrA==
X-Gm-Message-State: APjAAAW0bhVJaLd0y32P7POkJ7a4dU4XlWH57YhNhSy8fLbVnPU+pPWb
	ersuqSKAyE5yErcXqlimaf4KHA==
X-Google-Smtp-Source: APXvYqxYxiZ2bVj5BdC3D15rlj8ekrnex1zF/A83CKnKWTrXRSvBVCzcdgefGE1QNSwyzfOfjt1OGw==
X-Received: by 2002:a17:906:244c:: with SMTP id
	a12mr14473110ejb.288.1568905805521; 
	Thu, 19 Sep 2019 08:10:05 -0700 (PDT)
Received: from lophozonia ([85.195.192.192]) by smtp.gmail.com with ESMTPSA id
	j10sm1683364ede.59.2019.09.19.08.10.04
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Sep 2019 08:10:04 -0700 (PDT)
Date: Thu, 19 Sep 2019 17:10:02 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 8/8] iommu/arm-smmu-v3: Add support for PCI PASID
Message-ID: <20190919151002.GF1013538@lophozonia>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
	<20190610184714.6786-9-jean-philippe.brucker@arm.com>
	<b0e3d9a9-6085-b393-1982-3dd95bf5d100@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b0e3d9a9-6085-b393-1982-3dd95bf5d100@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, robh+dt@kernel.org,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Mon, Jul 08, 2019 at 09:58:16AM +0200, Auger Eric wrote:
> > +	ret = pci_enable_pasid(pdev, features);
> > +	if (!ret)
> > +		master->ssid_bits = min_t(u8, ilog2(num_pasids),
> > +					  master->smmu->ssid_bits);
> I don't really get why this setting is conditional to the success of
> pci_enabled_pasid and not num_pasids > 0.

num_pasids only contains the value of the PCIe PASID capability. If
pci_enable_pasid() fails then we want to leave master->ssid_bits to 0 so
that we report to users that SVA and AUXD aren't supported.

> If it fails the ssid_bits is set to min(smmu->ssid_bits,
> fwspec->num_pasid_bits) anyway.
>
> > +	return ret;
> > +}
> > +
> > +static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
> > +{
> > +	struct pci_dev *pdev;
> > +
> > +	if (!dev_is_pci(master->dev))
> > +		return;
> > +
> > +	pdev = to_pci_dev(master->dev);
> > +
> > +	if (!pdev->pasid_enabled)
> > +		return;
> > +
> > +	pci_disable_pasid(pdev);
> > +	master->ssid_bits = 0;
> in case of a platform device you leave the ssid_bits to a value != 0. Is
> that what you want?

Yes, this is only for PCI devices, there is no standard way of disabling
PASID in platform devices. We just take whatever the firmware gives us.

> > +}
> > +
> >  static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> >  {
> >  	unsigned long flags;
> > @@ -2413,6 +2456,9 @@ static int arm_smmu_add_device(struct device *dev)
> >  
> >  	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> >  
> > +	/* Note that PASID must be enabled before, and disabled after ATS */
> > +	arm_smmu_enable_pasid(master);
> In case the call fails, don't you want to handle the error and reset the
> ssid_bits?

This function fails if the device doesn't support PASID, and we leave
ssid_bits to 0. That said, I think it would be nicer to move the above
line (that deals with fwspec) into arm_smmu_enable_pasid()

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
