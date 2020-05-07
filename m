Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D249C54E49
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 16:25:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1057D2083B
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 16:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1057D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD67487070;
	Thu,  7 May 2020 16:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ljRpPJTg0Zi9; Thu,  7 May 2020 16:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 61AD6870BD;
	Thu,  7 May 2020 16:25:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 530DDC0865;
	Thu,  7 May 2020 16:25:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E4DDC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 46C08870D1
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SqiWKJieLC1W for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 16:25:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AA13787097
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:25:45 +0000 (UTC)
IronPort-SDR: HLePSp05BktYDV9cwLjdmKtOWzJh1P5e6ILgZlE+RfcMdxQzk91cSF6bP0f10Vt0POmUf3D+jS
 v5pkZkarob8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 09:25:44 -0700
IronPort-SDR: UI2DdPDFZfRj74OALBpuW41w58LXZwgsjf3LGqDj+vALiCsEHXQU/Sa9YbL1TRdZwaxVQulhgj
 S1oqukCmHM3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; d="scan'208";a="278651044"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002.jf.intel.com with ESMTP; 07 May 2020 09:25:43 -0700
Date: Thu, 7 May 2020 09:31:50 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v6 17/25] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20200507093150.6da9d6fb@jacob-builder>
In-Reply-To: <20200505091531.GA203922@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-18-jean-philippe@linaro.org>
 <20200430141617.6ad4be4c@jacob-builder>
 <20200504164351.GJ170104@myrica>
 <20200504134723.54e2ebcd@jacob-builder>
 <20200505091531.GA203922@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 5 May 2020 11:15:31 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Mon, May 04, 2020 at 01:47:23PM -0700, Jacob Pan wrote:
> > > > > +	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid,
> > > > > &invalid_cd); +
> > > > > +	arm_smmu_tlb_inv_asid(smmu_domain->smmu,
> > > > > smmu_mn->cd->asid);
> > > > > +	/* TODO: invalidate ATS */
> > > > > +    
> > > > If mm release is called after tlb invalidate range, is it still
> > > > necessary to invalidate again?    
> > > 
> > > No, provided all mappings from the address space are unmapped and
> > > invalidated. I'll double check, but in my tests invalidate range
> > > didn't seem to be called for all mappings on mm exit, so I
> > > believe we do need this.
> > >   
> > I think it is safe to invalidate again. There was a concern that mm
> > release may delete IOMMU driver from the notification list and miss
> > tlb invalidate range. I had a hard time to confirm that with ftrace
> > while killing a process, many lost events.
> >   
> 
> If it helps, I have a test that generates small DMA transactions on a
> SMMU model. This is the trace for a job on a 8kB mmap'd buffer:
> 
>   smmu_bind_alloc: dev=0000:00:03.0 pasid=1
>   dev_fault: IOMMU:0000:00:03.0 type=2 reason=0
> addr=0x0000ffff860e6000 pasid=1 group=74 flags=3 prot=2
> dev_page_response: IOMMU:0000:00:03.0 code=0 pasid=1 group=74
> dev_fault: IOMMU:0000:00:03.0 type=2 reason=0 addr=0x0000ffff860e7000
> pasid=1 group=143 flags=3 prot=2 dev_page_response:
> IOMMU:0000:00:03.0 code=0 pasid=1 group=143 smmu_mm_invalidate:
> pasid=1 start=0xffff860e6000 end=0xffff860e8000 smmu_mm_invalidate:
> pasid=1 start=0xffff860e6000 end=0xffff860e8000 smmu_mm_invalidate:
> pasid=1 start=0xffff860e8000 end=0xffff860ea000 smmu_mm_invalidate:
> pasid=1 start=0xffff860e8000 end=0xffff860ea000 smmu_unbind_free:
> dev=0000:00:03.0 pasid=1
> 
> And this is the same job, but the process immediately kills itself
> after launching it.
> 
>   smmu_bind_alloc: dev=0000:00:03.0 pasid=1
>   dev_fault: IOMMU:0000:00:03.0 type=2 reason=0
> addr=0x0000ffffb9d15000 pasid=1 group=259 flags=3 prot=2
> smmu_mm_release: pasid=1 dev_page_response: IOMMU:0000:00:03.0 code=0
> pasid=1 group=259 dev_fault: IOMMU:0000:00:03.0 type=2 reason=0
> addr=0x0000ffffb9d15000 pasid=1 group=383 flags=3 prot=2
> dev_page_response: IOMMU:0000:00:03.0 code=1 pasid=1 group=383
> smmu_unbind_free: dev=0000:00:03.0 pasid=1
> 
> We don't get any invalidate_range notification in this case.
> 
Thanks for the confirmation. We do need to invalidate here.

> Thanks,
> Jean

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
