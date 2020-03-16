Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08C1C2BB1D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:40:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C680920663
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w84O1QQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C680920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F7A4881F3;
	Mon, 16 Mar 2020 15:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-obB291Wzeb; Mon, 16 Mar 2020 15:40:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 20620881EC;
	Mon, 16 Mar 2020 15:40:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC34DC1D88;
	Mon, 16 Mar 2020 15:40:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB44CC013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 980BF8713E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P-MMGwO_7RjC for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:40:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A571586FB6
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:40:13 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id f3so14838886wrw.7
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vJQ7s9x85ia8HxlMYprwaZJGn4L6RP+BR7+jWVKPLTo=;
 b=w84O1QQJwU6wMTGEhyd3tdZmzyokkNQNgtvlgCbk7JrgRg0w2R3EtdUzes5TKo/XyE
 0GN9BzerCd+PBe2gdX+VVWalWV0GvUaZ1Hvpn02xC7Z6cQbZ9zUYoVR8SlrMkeTHa5pO
 ZNV7G4zwVtMQAtwNFVsP7G9rAugODJUvegfg+Joz2/pLSwTVFLeBdLC69Mm9fmsFaT0H
 4lQ985eQTWmn73BDP/WhhWDXVBZBfC45ZHQLQxe35G5uOfpUGYH7dFLUTw7I6qKsVqm6
 VCf79+8VBzgdX46YQ4mkH13lYwMdQrGC6Ai/EhOinV88dF/tVd63mOiTbTus//PTo1AD
 eHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vJQ7s9x85ia8HxlMYprwaZJGn4L6RP+BR7+jWVKPLTo=;
 b=K+nZFe6lphDcpZ8DeuISfhGzOTLTNPtHIsRlVXi3N2dxOydLniy4TadUVAmNtPUvSJ
 eoefO8UmcJBaM90rGodXbqdI3IGzqN0otdpWd0Bs8Ftv8A0MeAcSrh0tMZCwg+FlZ3V4
 yQJd/zoRIHBx2+WObQnRH64XGwdtxBIj2s1YSEuBUbeoaxJW1MbXK2k3C0Hz41LDWjAe
 RNqh+nfK7OimlBDRm2cKLJQ6QVnWMkigl8lVxQ1ueTUKuOMncNwvK0Sfv/nqh9ZyZ3Z6
 lfydiWYy7h69jlCeHSf8rNaW7fgCCRPFDhSWyPkW0nGcid+B+w1r3G25lsJw9YBTXYjM
 HrGQ==
X-Gm-Message-State: ANhLgQ3dCDKMqPr1nRCyxgtK9cQXX+6MBMi2mCOfKlwVACR2ZPLYrynw
 mUxGDaREGAIUwwIbjDkk6npOYA==
X-Google-Smtp-Source: ADFU+vu5RlEmmjxd74oFX3RvJEdQFPOMmKqi/N4OkXyJVDSx1NxqeLTrLEHwet7QRQD2B1qytUrz8w==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr29213545wrs.119.1584373212032; 
 Mon, 16 Mar 2020 08:40:12 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u17sm393519wrm.43.2020.03.16.08.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 08:40:11 -0700 (PDT)
Date: Mon, 16 Mar 2020 16:40:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 02/15] ACPI/IORT: Remove direct access of dev->iommu_fwspec
Message-ID: <20200316154003.GC304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-3-joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Hanjun Guo <guohanjun@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Sean Paul <sean@poorly.run>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Mar 10, 2020 at 10:12:16AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use the accessor functions instead of directly dereferencing
> dev->iommu_fwspec.
> 
> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/acpi/arm64/iort.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ed3d2d1a7ae9..7d04424189df 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1015,6 +1015,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		return ops;
>  
>  	if (dev_is_pci(dev)) {
> +		struct iommu_fwspec *fwspec;
>  		struct pci_bus *bus = to_pci_dev(dev)->bus;
>  		struct iort_pci_alias_info info = { .dev = dev };
>  
> @@ -1027,8 +1028,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     iort_pci_iommu_init, &info);
>  
> -		if (!err && iort_pci_rc_supports_ats(node))
> -			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> +		fwspec = dev_iommu_fwspec_get(dev);
> +		if (fwspec && iort_pci_rc_supports_ats(node))
> +			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>  	} else {
>  		int i = 0;
>  
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
