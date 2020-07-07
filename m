Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D447C433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 11:24:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA05D206CD
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 11:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFs2OsBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA05D206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9CD502655A;
	Tue,  7 Jul 2020 11:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ps66c9CGLyQX; Tue,  7 Jul 2020 11:24:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7C13C2636C;
	Tue,  7 Jul 2020 11:24:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 601EAC07FF;
	Tue,  7 Jul 2020 11:24:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D65EC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 11:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 72A7487941
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 11:23:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CnZ2iPUhCa2m for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 11:23:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6180E87923
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 11:23:58 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id dm19so31789094edb.13
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jul 2020 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Z+HTaDJORry76de6xJh2nNWpDzvXRte/7hWFD6xg3L0=;
 b=zFs2OsBCi8DqKxj1YR0JHMK7UjSD/oZ/Z7BDnr1ZUxpIoAaPD4S4IKK4hGDeddFjTt
 3BGApI+F1fzdkFWT7exYU5xyhldcg7eLpeBuLLhJ+aXC5j8cN3+H/i5LrHVnap88M9dH
 W34FYzJkfIjh/aDMP9w8uU0X6SEe9f3nCfiKHej0GGxTEieXobrFZ5elrhd7Q4athgmt
 K8jd2P2nrdufj2lG76LEKtKxltV8v5QSXfHnH3VFLr4WQvymX2Y2EdwHEr6pgZ10Ue4E
 4hMYcgs1r5y1LAAd6lkwxqLFOJMEXIuCVdwCqAKlyfTHjvcB6L4J0Vy2Z6FtePyO6I9E
 EHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z+HTaDJORry76de6xJh2nNWpDzvXRte/7hWFD6xg3L0=;
 b=UtZWA64sE/N0HnmVItCOtaXRd+ajvohvaquQjnoGFgOonipibyCw0jqKJb9u7P8iot
 HCcTLA3TqWNw2wZ5P/uJfjAYIRXaiiucqLdX4vDcXx1Fbhg/MbV1tgpCB+f6zxpCiW9r
 My3W0064GZQiavfSTiOTd7zaUrDODbiqNzZfSG1OYWNTd6tTrC9iBTSqyuX4ifbLaWIa
 8yIdYHxM8Nhdf6Q+fV+J76ddW9QIxRdsrQXpGF8JkrUbR2GPiwo0K5Qr6ZfH3KD1JFRL
 XcWLf9qH84JPCiSm3xvMMeNVmzIx9MeUjZ+IczTxOGZ7oicbIUJ+roZ4VfMd8bPMU+F4
 m3AQ==
X-Gm-Message-State: AOAM531ybil265p9ip4oIhEtMacTPruZ/gKOOC7U+dqp2X1CWevO3ddl
 /OaWlCLnUrm3j9xr/lqWfpXXYw==
X-Google-Smtp-Source: ABdhPJyYekwZMG+8JnnvjOeze0PtU9kmUGUw77NAnpt4KdPekwPaq5NofPFrBGFOfhl9DiucSf9AFA==
X-Received: by 2002:aa7:da46:: with SMTP id w6mr50895220eds.261.1594121036582; 
 Tue, 07 Jul 2020 04:23:56 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s1sm25488302edy.1.2020.07.07.04.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 04:23:56 -0700 (PDT)
Date: Tue, 7 Jul 2020 13:23:44 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 3/4] iommu/vt-d: Report page request faults for guest
 SVA
Message-ID: <20200707112344.GB159413@myrica>
References: <20200706002535.9381-1-baolu.lu@linux.intel.com>
 <20200706002535.9381-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200706002535.9381-4-baolu.lu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
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

On Mon, Jul 06, 2020 at 08:25:34AM +0800, Lu Baolu wrote:
> A pasid might be bound to a page table from a VM guest via the iommu
> ops.sva_bind_gpasid. In this case, when a DMA page fault is detected
> on the physical IOMMU, we need to inject the page fault request into
> the guest. After the guest completes handling the page fault, a page
> response need to be sent back via the iommu ops.page_response().
> 
> This adds support to report a page request fault. Any external module
> which is interested in handling this fault should regiester a notifier
> callback.
> 
> Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
[...]
> +static int
> +intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
> +{
> +	struct iommu_fault_event event;
> +	u8 bus, devfn;
> +
> +	memset(&event, 0, sizeof(struct iommu_fault_event));
> +	bus = PCI_BUS_NUM(desc->rid);
> +	devfn = desc->rid & 0xff;
> +
> +	/* Fill in event data for device specific processing */
> +	event.fault.type = IOMMU_FAULT_PAGE_REQ;
> +	event.fault.prm.addr = desc->addr;
> +	event.fault.prm.pasid = desc->pasid;
> +	event.fault.prm.grpid = desc->prg_index;
> +	event.fault.prm.perm = prq_to_iommu_prot(desc);
> +
> +	/*
> +	 * Set last page in group bit if private data is present,
> +	 * page response is required as it does for LPIG.
> +	 */
> +	if (desc->lpig)
> +		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +	if (desc->pasid_present)
> +		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;

Do you also need to set IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID?  I added
the flag to deal with devices that do not want a PASID value in their PRI
response (bit 15 in the PCIe Page Request Status Register):
https://lore.kernel.org/linux-iommu/20200616144712.748818-1-jean-philippe@linaro.org/
(applied by Joerg for v5.9)

Grepping for pci_prg_resp_pasid_required() in intel/iommu.c it seems to
currently reject devices that do not want a PASID in a PRI response, so I
think you can set this flag unconditionally for now.

Thanks,
Jean

> +	if (desc->priv_data_present) {
> +		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
> +		memcpy(event.fault.prm.private_data, desc->priv_data,
> +		       sizeof(desc->priv_data));
> +	}
> +
> +	return iommu_report_device_fault(dev, &event);
> +}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
