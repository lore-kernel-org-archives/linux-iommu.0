Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085F6C433E2
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 09:38:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C394920679
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 09:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="drH65z9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C394920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7D5222210F;
	Tue,  2 Jun 2020 09:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EyFsNmZohbYt; Tue,  2 Jun 2020 09:38:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 99F2722011;
	Tue,  2 Jun 2020 09:38:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 813E0C0178;
	Tue,  2 Jun 2020 09:38:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 090D1C016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 09:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EB5348607A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 09:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BCVZckwS9QI9 for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 09:38:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DBD5786044
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 09:38:48 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id q13so9547183edi.3
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=W0EAxKYZ1cy7EQz5SmmqXsQnpOBPA6z8vgEtS2GOSuY=;
 b=drH65z9QCFx7VpluTZaPf8cNXvMnji1Zw2v13zTnotv2QHpST54MDbm33aYUQRGTJv
 0QULZlT5uAkEZuTvOhzrSMqJ9YapVqZYDij+6jchFqzqcjtUcMPrwrCgKP7ct/hpwUiK
 Icvl+0uC9vWI4KC69z0KY8jHbZGlZhyLd3kpE57L7bfJ4Cpt8dz+qs04+Y0J/gRKD0gE
 SYD0xd89cpu3EFRcQji9vlrDA7Dv0jvvwKCxGAp1AJ9A5QTEgCe3eZQGd6LNx6AU6Aus
 M68A0D5RvptQcClwn9HKmhlxaZARlTB0HTQQ4CBTd55q9gyNSOhbya3xERNyLzArDc6X
 iOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W0EAxKYZ1cy7EQz5SmmqXsQnpOBPA6z8vgEtS2GOSuY=;
 b=Q0JGz6beWCfq9nVCX8azRcWI00r0azzbPFvJPDxy0vvw5j2DgcroDmkHlgDZut7A3M
 S57EkVa5VeIKil7WVPsENwz7FGGs/+cUsTUmlBzgsb3LtPHMsNbAobWJYrGaQSLKYoeA
 5EVZCtMECI4/fnNY9AGBzeNxgyjCout8FfPdEcFePwJDvdy7Barnpe6Gvcr5jUBaZH0q
 61TfBcpEcvJ8YVVejIhp+vSHzynlsmQ20/0SSyLzUBREXWcr81R60U/WvjQmJlq0ZGvV
 M/bxOKAqlniyI4f8+OsueD4mLwIdb5sxDTWWJsuKQuPc5tJ0+G9fBRNO/44mmKxsHIU8
 mKRw==
X-Gm-Message-State: AOAM532YxVFGn421RtCPJKl/BU9+sfZXo/88ySB0I0mDZE9dI2oS8Pg9
 4Ild/jqDFTIWVHx/d5YGj/Qd8g==
X-Google-Smtp-Source: ABdhPJwh69GX0fxQPd28WCwoX+IJ3u/GdmphexSL7+uh9AzkMYiU+9haAje2FoMpFLt799mKYxxrDw==
X-Received: by 2002:a05:6402:17e6:: with SMTP id
 t6mr24443948edy.243.1591090727183; 
 Tue, 02 Jun 2020 02:38:47 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id j5sm1319532edk.53.2020.06.02.02.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 02:38:46 -0700 (PDT)
Date: Tue, 2 Jun 2020 11:38:36 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v7 21/24] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20200602093836.GA1029680@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-22-jean-philippe@linaro.org>
 <4741b6c45d1a43b69041ecb5ce0be0d5@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4741b6c45d1a43b69041ecb5ce0be0d5@huawei.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "will@kernel.org" <will@kernel.org>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "felix.kuehling@amd.com" <felix.kuehling@amd.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

Hi Shameer,

On Mon, Jun 01, 2020 at 12:42:15PM +0000, Shameerali Kolothum Thodi wrote:
> >  /* IRQ and event handlers */
> > +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> > +{
> > +	int ret;
> > +	u32 perm = 0;
> > +	struct arm_smmu_master *master;
> > +	bool ssid_valid = evt[0] & EVTQ_0_SSV;
> > +	u8 type = FIELD_GET(EVTQ_0_ID, evt[0]);
> > +	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> > +	struct iommu_fault_event fault_evt = { };
> > +	struct iommu_fault *flt = &fault_evt.fault;
> > +
> > +	/* Stage-2 is always pinned at the moment */
> > +	if (evt[1] & EVTQ_1_S2)
> > +		return -EFAULT;
> > +
> > +	master = arm_smmu_find_master(smmu, sid);
> > +	if (!master)
> > +		return -EINVAL;
> > +
> > +	if (evt[1] & EVTQ_1_READ)
> > +		perm |= IOMMU_FAULT_PERM_READ;
> > +	else
> > +		perm |= IOMMU_FAULT_PERM_WRITE;
> > +
> > +	if (evt[1] & EVTQ_1_EXEC)
> > +		perm |= IOMMU_FAULT_PERM_EXEC;
> > +
> > +	if (evt[1] & EVTQ_1_PRIV)
> > +		perm |= IOMMU_FAULT_PERM_PRIV;
> > +
> > +	if (evt[1] & EVTQ_1_STALL) {
> > +		flt->type = IOMMU_FAULT_PAGE_REQ;
> > +		flt->prm = (struct iommu_fault_page_request) {
> > +			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> > +			.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]),
> > +			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
> > +			.perm = perm,
> > +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> > +		};
> > +
> 
> > +		if (ssid_valid)
> > +			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> 
> Do we need to set this for STALL mode only support? I had an issue with this
> being set on a vSVA POC based on our D06 zip device(which is a "fake " pci dev
> that supports STALL mode but no PRI). The issue is, CMDQ_OP_RESUME doesn't
> have any ssid or SSV params and works on sid and stag only.

I don't understand the problem, arm_smmu_page_response() doesn't set SSID
or SSV when sending a CMDQ_OP_RESUME. Could you detail the flow of a stall
event and RESUME command in your prototype?  Are you getting issues with
the host driver or the guest driver?

We do need to forward the SSV flag all the way to the guest driver, so the
guest can find the faulting address space using the SSID. Once the guest
handled the fault, then we don't send the SSID back to the host as part of
the RESUME command.

Thanks,
Jean

> Hence, it is difficult for
> Qemu SMMUv3 to populate this fields while preparing a page response. I can see
> that this flag is being checked in iopf_handle_single() (patch 04/24) as well. For POC,
> I used a temp fix[1] to work around this. Please let me know your thoughts.
> 
> Thanks,
> Shameer
> 
> 1. https://github.com/hisilicon/kernel-dev/commit/99ff96146e924055f38d97a5897e4becfa378d15
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
