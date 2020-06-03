Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7B3C433E2
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 07:39:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE45F2077D
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 07:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaA7HqoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE45F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8DCDA879A7;
	Wed,  3 Jun 2020 07:39:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wE8ut5oRJRmu; Wed,  3 Jun 2020 07:39:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA03E87874;
	Wed,  3 Jun 2020 07:39:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA2F6C0888;
	Wed,  3 Jun 2020 07:39:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 743E0C016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 07:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6B9B020489
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 07:39:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjwzi2ufmb+5 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 07:39:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 73AD7203FE
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 07:39:03 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id j198so3888445wmj.0
 for <iommu@lists.linux-foundation.org>; Wed, 03 Jun 2020 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hLQ9Ov0eKr85gKa7olFwe6f0SlVLYGl5nrVG5b+LzPg=;
 b=BaA7HqoJAJJh2tIRtyNtCnJJ+ARabjO7t5qWHkwfey6v8O/bYqibUoJb7g2lNYfNoZ
 ifRC05Pi1fFsLS0xec3/ZwWH5HsiqKmSLEV1fLmRpATey18HMYDmWin9n3Lkz4IawUOQ
 xlEYpZp5UmMhs18ikzeusxNZVkL8Zx3ToEbKvsz7PW6G3ARdQwBq0YY+pC+k6oMkgPG9
 WS33Jb4rH9VdYT1yaXMb7+k5Kf1kqlPXl8+BOa8wlHnCW3navM5sN6dA2DpyHeZobAy9
 jaGeJhzWEgaTqAFNlLtfzmz/6tmkY5sIGP7K7i1KqYqmIFqvLzdVzqj+ASM+V0Ps5U09
 v7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hLQ9Ov0eKr85gKa7olFwe6f0SlVLYGl5nrVG5b+LzPg=;
 b=fOranFZnC73KHvr339J2uK3JcBtm40SzKZXi2f0zUzgTKt116T16UL2pr+Fyx+gWCs
 +yPMxk80udHygfzlDnFs7t9J54nbbOfyP1D6Ehy9GUg8gwFCFWbQxh0y2uWfRMt0l5oi
 pzuuUWZBh/ANVMx3tU/yLJxz4rJZgxkRwopQLBteucwvYVjxyU80fEX4klFiO15H+fHC
 Q5XM7hBUMDepnklxr/c/NMa8tMd5fnG2m++cB8MABAM+3OR7vrIzlXwKkCen29Ru9eYz
 PkpNvJwvQ1UHH8WmRaqvXDCEUf76IFjBQ9FfGNIOKxhaLQXHIku3QLFEe3KEIyeZ5xjf
 gGIw==
X-Gm-Message-State: AOAM530tLfIhUkvl0HeFO7FW4lk2EuWbOKpq5LK9v3nxjOliEO/8gUfP
 seRoDb0GUbbbMjvhK8FPrsUDnA==
X-Google-Smtp-Source: ABdhPJx2CVWTxoCwkjfPm8H6OgQs2Q+1IKumvn68jhcLFzJkSHw/NXJvs00yy3+6Xok2VEhmklRBbQ==
X-Received: by 2002:a1c:5a0b:: with SMTP id o11mr7245089wmb.74.1591169941832; 
 Wed, 03 Jun 2020 00:39:01 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id t129sm1796108wmf.41.2020.06.03.00.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 00:39:01 -0700 (PDT)
Date: Wed, 3 Jun 2020 09:38:51 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v7 21/24] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20200603073851.GA3198@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-22-jean-philippe@linaro.org>
 <4741b6c45d1a43b69041ecb5ce0be0d5@huawei.com>
 <20200602093836.GA1029680@myrica>
 <1517c4d97b5849e6b6d32e7d7ed35289@huawei.com>
 <20200602114611.GB1029680@myrica>
 <c165fe41230f49baba991f1a416a4739@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c165fe41230f49baba991f1a416a4739@huawei.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "will@kernel.org" <will@kernel.org>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "felix.kuehling@amd.com" <felix.kuehling@amd.com>,
 "hch@infradead.org" <hch@infradead.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
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

On Tue, Jun 02, 2020 at 12:12:30PM +0000, Shameerali Kolothum Thodi wrote:
> > > > > > +		if (ssid_valid)
> > > > > > +			flt->prm.flags |=
> > > > IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > > > >
> > > > > Do we need to set this for STALL mode only support? I had an issue
> > > > > with this being set on a vSVA POC based on our D06 zip
> > > > > device(which is a "fake " pci dev that supports STALL mode but no
> > > > > PRI). The issue is, CMDQ_OP_RESUME doesn't have any ssid or SSV
> > > > > params and works on sid
> > > > and stag only.
> > > >
> > > > I don't understand the problem, arm_smmu_page_response() doesn't set
> > > > SSID or SSV when sending a CMDQ_OP_RESUME. Could you detail the flow
> > > > of a stall event and RESUME command in your prototype?  Are you
> > > > getting issues with the host driver or the guest driver?
> > >
> > > The issue is on the host side iommu_page_response(). The flow is
> > > something like below.
> > >
> > > Stall: Host:-
> > >
> > > arm_smmu_handle_evt()
> > >   iommu_report_device_fault()
> > >     vfio_pci_iommu_dev_fault_handler()
> > >
> > > Stall: Qemu:-
> > >
> > > vfio_dma_fault_notifier_handler()
> > >   inject_faults()
> > >     smmuv3_inject_faults()
> > >
> > > Stall: Guest:-
> > >
> > > arm_smmu_handle_evt()
> > >   iommu_report_device_fault()
> > >     iommu_queue_iopf
> > >   ...
> > >   iopf_handle_group()
> > >     iopf_handle_single()
> > >       handle_mm_fault()
> > >         iopf_complete()
> > >            iommu_page_response()
> > >              arm_smmu_page_response()
> > >                arm_smmu_cmdq_issue_cmd(CMDQ_OP_RESUME)
> > >
> > > Resume: Qemu:-
> > >
> > > smmuv3_cmdq_consume(SMMU_CMD_RESUME)
> > >   smmuv3_notify_page_resp()
> > >     vfio:ioctl(page_response)  --> struct iommu_page_response is filled
> > >                              with only version, grpid and code.
> > >
> > > Resume: Host:-
> > >   ioctl(page_response)
> > >     iommu_page_response()  --> fails as the pending req has PASID_VALID
> > flag
> > >                              set and it checks for a match.
> > 
> > I believe the fix needs to be here. It's also wrong for PRI since not all PCIe
> > endpoint require a PASID in the page response. Could you try the attached
> > patch?
> 
> Going through the patch, yes, that will definitely fix the issue. But isn't it better if
> the request itself indicate whether it expects a response msg with a valid pasid or
> not? The response msg can come from userspace as well(vSVA) and if for some reason
> doesn't set it for a req that expects pasid then it should be an error, right? In the temp
> fix I had, I introduced another flag to indicate the endpoint has PRI support or not and
> used that to verify the pasid requirement. But for the PRI case you mentioned 
> above, not sure it is easy to get that information or not. May be I am complicating things
> here :)

No you're right, we shouldn't send back malformed responses to the SMMU. I
suppose we can store a flag "PASID required" in the fault and check that
against the response. If we have to discard the guest's response, then we
can either fake a response (abort the stall) right away, or wait for the
response timeout to kick, which will do the same.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
