Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B08C43603
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 15:21:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE5C21582
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYpxZTb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE5C21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5D2D785B25;
	Tue, 17 Dec 2019 15:21:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eD3lp65Audbm; Tue, 17 Dec 2019 15:21:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E3DDF85B0D;
	Tue, 17 Dec 2019 15:21:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7DBEC1D7D;
	Tue, 17 Dec 2019 15:21:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09C0AC077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 15:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DCCC985B25
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 15:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hjUxeS4D7LCo for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 15:21:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B98B485B0D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 15:21:29 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id q6so11697332wro.9
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 07:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/U6kIWQCRrt5t46RzQq83Cexhdp96mlj0bDDsvo61J0=;
 b=zYpxZTb+W4CafynX/GjHKf3cPY+ZcFMKhPepfPIsR2ENTx1vIn6Qcj+OWPPMn78rvn
 8ndC9NFyie5drvYpo3BgXxap1zVlvHUw7Tp3zeqOCom9nhTtk8XnZ9PVVeWp59fjML+q
 md0iB6uixCMDeJAQvm1Dy741/FBYwIxlVuhB4OvmccJdlNQ5C5VG1/1pEAyRS8Rui4Cz
 Q8V633DYjfwnqDBdCv2Jzz/Bum12yws5o8/xTlLHVliu03pI/CGDZc0wgx/5bhQYaVhX
 JKeGrk+H7oFKNRtKza+FurEMK4Rh4OJWVScTuxx5EVgA/01UT5CgEcldpppYf1h/nVID
 rKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/U6kIWQCRrt5t46RzQq83Cexhdp96mlj0bDDsvo61J0=;
 b=X7buyDCQfbrxuij/C27rqk4q+mxqel0C1yxnYZlrziSLdTlJ9NBZxj/oEcXFGJ7wfh
 PVtn5Zs5E/xX1We8WecKI7ybUNsaqmjeW/vbMKNOYGIltw9yaPsw9BK4giFkpqdw9S9R
 SEbYfRw9VjABhuyaaTsHFRPKEO9WA1mH41GBRgJMuH6ufXlJLAAgK91jilZ758hn1HUY
 9VhooQdbaQUNeMAErg/FeMo7uV2v4ZgXrkmjxLcHpUr6QRMs0IlK15SAFeyZ4QANfO8U
 7Arcxe0CB5/nRaZUmq0EqFqFAdc3XXGGo4fd1J8+2BKL023w0mGD80dTaf2yt2tNUnDL
 AUEQ==
X-Gm-Message-State: APjAAAVZr+K/izVZ27kh3ipzXmO+K0vlxKHu5s7qNpDpbOXg9bmUsupC
 d2htdJIEGVLR/6cfkqtrTE5N4w==
X-Google-Smtp-Source: APXvYqxGZpcrEU2hF1yXvjy3TQGwn9Ed0+ek9wFSXQ/mi7LzOCYo9KI6i5ueC9DEOAbG9y2v+MiMeg==
X-Received: by 2002:adf:de84:: with SMTP id w4mr35905632wrl.97.1576596087819; 
 Tue, 17 Dec 2019 07:21:27 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id s16sm25985278wrn.78.2019.12.17.07.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 07:21:27 -0800 (PST)
Date: Tue, 17 Dec 2019 16:21:08 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Support platform SSID
Message-ID: <20191217152108.GB2305883@myrica>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-4-jean-philippe@linaro.org>
 <e5b9a017-585a-5425-77bd-be40b86010e6@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e5b9a017-585a-5425-77bd-be40b86010e6@redhat.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, robin.murphy@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, guohanjun@huawei.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

Hi Eric,

On Tue, Dec 17, 2019 at 12:05:18PM +0100, Auger Eric wrote:
> > +		fwspec = dev_iommu_fwspec_get(dev);
> > +		if (!err && fwspec)
> > +			of_property_read_u32(master_np, "pasid-num-bits",
> > +					     &fwspec->num_pasid_bits);
> > +	}
> This patch dedicates to platform devices however I fail to understand,
> at that stage, how/when do you retrieve/store the same max capability
> for PCI devices?

For PCI devices, the max capability is only described by the PCIe PASID
capability, not by firmware. Patch 13 deals with PCI by setting
masted->ssid_bits from the PASID capability directly, ignoring
fwspec->num_pasid_bits.

> Besides,
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
