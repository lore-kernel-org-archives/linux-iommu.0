Return-Path: <SRS0=/Eks=4X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF54C10DCE
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 10:10:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CA7207FD
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 10:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3e46LJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CA7207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3B5AE860C5;
	Fri,  6 Mar 2020 10:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ERnapnfQXCh4; Fri,  6 Mar 2020 10:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B1D7868CE;
	Fri,  6 Mar 2020 10:10:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1442C1D8F;
	Fri,  6 Mar 2020 10:10:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56E18C013E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 10:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3EACE20033
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 10:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XRKYzUAIBKhh for <iommu@lists.linux-foundation.org>;
 Fri,  6 Mar 2020 10:10:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by silver.osuosl.org (Postfix) with ESMTPS id EFD6620764
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 10:10:03 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id g134so1705713wme.3
 for <iommu@lists.linux-foundation.org>; Fri, 06 Mar 2020 02:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=og3sMPJN+Nb579KWuJJ61AJ7TUDj6TNf09RkDt7hsI8=;
 b=W3e46LJj5LqwGN7bmYVtalGehYEZNj3nHr/KAjP31KhaaXN+m0uWmMkf3acHKomptm
 89d0LyK/fwtGemR8XoQyJ0Ys/LcWeWGdlwW4CeVEEcaicTe2FKFajLwdJ5fOYlueg0Sl
 TK9CYNYdO7MxSrz07jDyQcWVpS506xMCbX+/TC3r/e8J6B1ZMT5UKVvra0iQbFiIzTGv
 115moqqHKTtOhYVG2HvcfiNX1TYPoAk1uZbA5LrtS1I/ItmZcZ3+3JYMcA9v6viTj0Yz
 eEAPwp4x5R0wWQQAwxCEk2yzvnV5bNaOC/JH7GsT7wADh0zmXAuNdX6IGcE4tUIHjkXg
 jtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=og3sMPJN+Nb579KWuJJ61AJ7TUDj6TNf09RkDt7hsI8=;
 b=uf6jnjwXqKiGzpZcpkX/TX/uY4RHVSVJoOh4wu55pT2THSPGPGfsHmdFQLYzJsPI2y
 6nV8WsrR+ZtH6gVQjfba2lydoG1QlRNL7t3OgVm/ns05M27b1oVEC9y4UpNytvbQglAi
 //1REX2pgzvgrizS2KxjIsBapHt6ZuP5gxcXTWwZQxNkNtiv+L4FrFSt7xjWT26X0jIJ
 KKoWR/ym0Jr9Fc1pYKNTmHAbMiBuoMzXLG/5eHY6+GulN2fi6/PVEgYNMeS1iYLQZiPM
 6YIWYR1E9AnjMcmO6X8BGhAtWOGYyIdd/KRtreI/q+wMEQHCfKFuY3vriOXNEhJaCmgO
 7X7A==
X-Gm-Message-State: ANhLgQ24sfpxETGry4Ow4t9iZpn5bcYIMArpIcXZgJErNzlHydrUiGC7
 8Z6Bk2pyVy184umX9oFrALEUaA==
X-Google-Smtp-Source: ADFU+vuYWMHCslvUNwXUcaXSJwmBGmrU+STTteHzbOUtCKoxHdMrNV0++OcL5lLFlieALAAa/Z3NFg==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr3204485wma.5.1583489402366; 
 Fri, 06 Mar 2020 02:10:02 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id f6sm12992707wmc.9.2020.03.06.02.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 02:10:01 -0800 (PST)
Date: Fri, 6 Mar 2020 11:09:55 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 00/14] iommu: Move iommu_fwspec out of 'struct device'
Message-ID: <20200306100955.GB50020@myrica>
References: <20200228150820.15340-1-joro@8bytes.org>
 <ea839f32-194a-29ea-57fc-22caea40b981@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea839f32-194a-29ea-57fc-22caea40b981@huawei.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
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

On Fri, Mar 06, 2020 at 04:39:37PM +0800, Hanjun Guo wrote:
> Hi Joerg,
> 
> On 2020/2/28 23:08, Joerg Roedel wrote:
> > Hi,
> > 
> > here is a patch-set to rename iommu_param to dev_iommu and
> > establish it as a struct for generic per-device iommu-data.
> > Also move the iommu_fwspec pointer from struct device into
> > dev_iommu to have less iommu-related pointers in struct
> > device.
> > 
> > The bigger part of this patch-set moves the iommu_priv
> > pointer from struct iommu_fwspec to dev_iommu, making is
> > usable for iommu-drivers which do not use fwspecs.
> > 
> > The changes for that were mostly straightforward, except for
> > the arm-smmu (_not_ arm-smmu-v3) and the qcom iommu driver.
> > Unfortunatly I don't have the hardware for those, so any
> > testing of these drivers is greatly appreciated.
> 
> I tested this patch set on Kunpeng 920 ARM64 server which
> using smmu-v3 with ACPI booting, but triggered a NULL
> pointer dereference and panic at boot:

I think that's because patch 01/14 move the fwspec access too early. In 

                err = pci_for_each_dma_alias(to_pci_dev(dev),
                                             iort_pci_iommu_init, &info);

                if (!err && iort_pci_rc_supports_ats(node))
                        dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;

the iommu_fwspec is only valid if iort_pci_iommu_init() initialized it
successfully, if err == 0. The following might fix it:

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 0e981d7f3c7d..7d04424189df 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1015,7 +1015,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		return ops;

 	if (dev_is_pci(dev)) {
-		struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+		struct iommu_fwspec *fwspec;
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
 		struct iort_pci_alias_info info = { .dev = dev };

@@ -1028,7 +1028,8 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     iort_pci_iommu_init, &info);

-		if (!err && iort_pci_rc_supports_ats(node))
+		fwspec = dev_iommu_fwspec_get(dev);
+		if (fwspec && iort_pci_rc_supports_ats(node))
 			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
 	} else {
 		int i = 0;


Note that this use of iommu_fwspec will be removed by the ATS cleanup
series [1], but this change should work as a temporary fix.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20200213165049.508908-10-jean-philippe@linaro.org/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
