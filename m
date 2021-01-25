Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FA8C433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 15:46:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAB72224C
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 15:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAB72224C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61C6D870DD;
	Mon, 25 Jan 2021 15:46:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tW4ZGyij5Nhs; Mon, 25 Jan 2021 15:46:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CDB9E870C1;
	Mon, 25 Jan 2021 15:46:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B17A9C0FA7;
	Mon, 25 Jan 2021 15:46:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84EBBC013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 15:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6406F203EA
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 15:46:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G59paFAJmn4q for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 15:46:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by silver.osuosl.org (Postfix) with ESMTPS id 241D82001D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 15:46:44 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id c12so13153716wrc.7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=saz5MoILAriaGIGWK/aPOZ/clAw3tEuyZYXwjAIF/h4=;
 b=VS0BjJtjbfWaablRqn0zungdUl/9sUQPgs1HlDBWPi/HhTcQ4V51xv8PhvyQejN99w
 9+mbU0x0Qz+97ncS/+vVjyrbn/4XWyOiMKPd2aNQfYjA61s+wW2L4hJRM/rEYtkixRAW
 UpGDFehmsrz1n/f0ETRjIa/AWnp1vtB06TppHxksWw2dgieejtP2x4iUDSoKDxPShB1Z
 rUUw/zsO6H8E7MUcG2DwcvzrOZG7MUeim0tqlTSehE0ykcFGNnqWEMk1u0k6Drb3JDGd
 1b0fLWtIkFTSeGvMJRM9A3NKbaxGWmGfXiOKFDSip0LbsPEw4F6/E70ADOp1++04L6iw
 KrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=saz5MoILAriaGIGWK/aPOZ/clAw3tEuyZYXwjAIF/h4=;
 b=tLHb8kup4kWEGO+ucr5hZWKoFjXZK7uhicqSkmsMj9RE0qC3A0zJnpeZd6scWXq7Y5
 gAL5anP/PZNUm8kPwdYDmZsCsS5RC0S35E+hcAd/l+VnxPG3u64aITgJ5IVgjY6O8McV
 bmXDUDWPDWXRzPuvkCAf1SGFPDF9KhfuPJJmfNOP7nJhrr2sWHN8QzSDmDMgaR4PZGHF
 91zQ54U6LmME5I3+hhsVMWuZLaGhha7jp78iNASJ2EBSwhAlRCcDIyGSOBRx6dmRLF2R
 0T2p0pgxmcyHnpPMawRV23gtlDlD3k/+yoQWeAeUUggBwoPESrxtfXX3o2m7TNQv/sCa
 osXA==
X-Gm-Message-State: AOAM533N9wUA6u99n/smnVd6Rt1DLzAI6cNIKq18ef1J7kqqENFFKN0I
 xrrDq9kMjiPBdzYPgciWRqvZHQ==
X-Google-Smtp-Source: ABdhPJzQ1UgRTJEpMAarcXiQ9ehSoyIIoc9yIqhQjtx7Ga46cwKGEdr4iKFHuMclmoLDLgZQw0k+ZA==
X-Received: by 2002:adf:dfce:: with SMTP id q14mr1302807wrn.133.1611589602413; 
 Mon, 25 Jan 2021 07:46:42 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r1sm23377838wrl.95.2021.01.25.07.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 07:46:41 -0800 (PST)
Date: Mon, 25 Jan 2021 16:46:22 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v11 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <YA7nzllIPBahYKCw@myrica>
References: <20210125110650.3232195-1-jean-philippe@linaro.org>
 <20210125110650.3232195-11-jean-philippe@linaro.org>
 <20210125135009.00003ca3@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210125135009.00003ca3@Huawei.com>
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, will@kernel.org,
 linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org, lenb@kernel.org,
 devicetree@vger.kernel.org, kevin.tian@intel.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jan 25, 2021 at 01:50:09PM +0000, Jonathan Cameron wrote:
> > +static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
> > +{
> > +	int ret;
> > +	struct device *dev = master->dev;
> > +
> > +	/*
> > +	 * Drivers for devices supporting PRI or stall should enable IOPF first.
> > +	 * Others have device-specific fault handlers and don't need IOPF.
> > +	 */
> > +	if (!arm_smmu_master_iopf_supported(master))
> 
> So if we have master->iopf_enabled and this happens. Then I'm not totally sure
> what prevents the disable below running its cleanup on stuff that was never
> configured.

Since arm_smmu_dev_enable_feature() checks that the feature is supported,
iopf_enabled can only be true if arm_smmu_master_iopf_supported() is true.

What's missing is checking that drivers don't disable IOPF while SVA is
enabled - or else the disable below can leak. Another thing I broke in v10 :/

Thanks,
Jean

> 
> > +		return 0;
> > +
> > +	if (!master->iopf_enabled)
> > +		return -EINVAL;
> > +
> > +	ret = iopf_queue_add_device(master->smmu->evtq.iopf, dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
> > +	if (ret) {
> > +		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void arm_smmu_master_sva_disable_iopf(struct arm_smmu_master *master)
> > +{
> > +	struct device *dev = master->dev;
> > +
> > +	if (!master->iopf_enabled)
> > +		return;
> 
> As above, I think you need a sanity check on
> 
> !arm_smmu_master_iopf_supported(master) before clearing the following.
> 
> I may well be missing something that stops us getting here though.
> 
> Alternative is probably to sanity check iopf_enabled = true is supported
> before letting a driver set it.
> 
> 
> > +
> > +	iommu_unregister_device_fault_handler(dev);
> > +	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
> > +}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
