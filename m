Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734AFC433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 21:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 136604099A;
	Mon, 28 Mar 2022 21:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mCzhwu02I9lQ; Mon, 28 Mar 2022 21:27:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CCE87415EF;
	Mon, 28 Mar 2022 21:26:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F942C001D;
	Mon, 28 Mar 2022 21:26:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02C16C0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 21:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF2B340242
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 21:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RWjUiAalbZ8F for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 21:26:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1142B4016C
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 21:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648502815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhA4dUFlPR118hhpX2PsAoIqQjvFZQbvAcfxVPt1G38=;
 b=V71GLXt3O34AyseUUE/ErIpH6xVrIYm0PCiEU2U154FTfGjHLf5EcAB8Om2f9+4AcaHX9a
 2isHVwTIQsT7Kzh4MkGqBoMPS2e/GPeFTENwdwKJOszZpT3i/+yaCctpVY6rsRl3pK+CIi
 D8l9tsSM/pa6PCo9C6kx4BjI510xsE8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-SIyvclMXPiiK8fElXcV5Qg-1; Mon, 28 Mar 2022 17:26:54 -0400
X-MC-Unique: SIyvclMXPiiK8fElXcV5Qg-1
Received: by mail-il1-f198.google.com with SMTP id
 s4-20020a92c5c4000000b002c7884b8608so8497126ilt.21
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 14:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=AhA4dUFlPR118hhpX2PsAoIqQjvFZQbvAcfxVPt1G38=;
 b=T0LWMe1CZz71EBYOAwpgjgtF5/Ul3XK8syhVp/iay2B7E8dlh90oZyz70110Cs3FG8
 LQxXp2VfWkq+31/wWIySpJfLfPbNXHNDkew4hJ18Rix1DJK6AgH3x33iUCJBPN63AV9/
 njT3okiO/V5z97vc3MQ3lSovvzQmdlI6XMo8ZzAhlFCjedDI/UU1y5mKsdoH12R6p0/m
 842eGk7ZPOxhiuVUOAwX02aUS18XucqLbGqo9mx+4PyY1Hz676pPU3gwPklck1X98Dni
 o3tHJwHIFWeLZ2d3/v5YB3MXuvHcqnHBsdhDoGNxCaRllDkPJCbeU8WlX6koMZ6sargc
 B8Bg==
X-Gm-Message-State: AOAM5323A4ubw3EsjTTB7WW3+ETu6oeHkmHto8i22OBLsSaSXYSVUQG4
 XANJDpsyQZTsD3SFvn9AAb244BvYvOuzqqKOga1f62PmFELNXEbdmbMaVAkUnT6KXll3xl2yAEB
 PJuN+QOr1Mq8KhE3i5znM8luKDTKqDA==
X-Received: by 2002:a05:6638:1490:b0:323:6863:fd0f with SMTP id
 j16-20020a056638149000b003236863fd0fmr3955833jak.20.1648502813606; 
 Mon, 28 Mar 2022 14:26:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypxL5wkwODjtfYMS8ID4x491eGOOpE6QbjSXOKlH5MMMTvT9ty6p3YM6m6FKhe9EFHLEL44w==
X-Received: by 2002:a05:6638:1490:b0:323:6863:fd0f with SMTP id
 j16-20020a056638149000b003236863fd0fmr3955814jak.20.1648502813325; 
 Mon, 28 Mar 2022 14:26:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 f8-20020a056e02168800b002c654e0f592sm7880621ila.58.2022.03.28.14.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 14:26:52 -0700 (PDT)
Date: Mon, 28 Mar 2022 15:26:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Message-ID: <20220328152651.4882d8e9.alex.williamson@redhat.com>
In-Reply-To: <20220328194749.GA1746678@nvidia.com>
References: <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323131038.3b5cb95b.alex.williamson@redhat.com>
 <20220323193439.GS11336@nvidia.com>
 <20220323140446.097fd8cc.alex.williamson@redhat.com>
 <20220323203418.GT11336@nvidia.com>
 <20220323225438.GA1228113@nvidia.com>
 <BN9PR11MB5276EB80AFCC3003955A46248C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220324134622.GB1184709@nvidia.com>
 <20220328111723.24fa5118.alex.williamson@redhat.com>
 <20220328185753.GA1716663@nvidia.com>
 <20220328194749.GA1746678@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Mon, 28 Mar 2022 16:47:49 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 28, 2022 at 03:57:53PM -0300, Jason Gunthorpe wrote:
> 
> > So, currently AMD and Intel have exactly the same HW feature with a
> > different kAPI..  
> 
> I fixed it like below and made the ordering changes Kevin pointed
> to. Will send next week after the merge window:
> 
> 527e438a974a06 iommu: Delete IOMMU_CAP_CACHE_COHERENCY
> 5cbc8603ffdf20 vfio: Move the Intel no-snoop control off of IOMMU_CACHE
> ebc961f93d1af3 iommu: Introduce the domain op enforce_cache_coherency()
> 79c52a2bb1e60b vfio: Require that devices support DMA cache coherence
> 02168f961b6a75 iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY with dev_is_dma_coherent()
> 
> '79c can be avoided, we'd just drive IOMMU_CACHE off of
> dev_is_dma_coherent() - but if we do that I'd like to properly
> document the arch/iommu/platform/kvm combination that is using this..

We can try to enforce dev_is_dma_coherent(), as you note it's not going
to affect any x86 users.  arm64 is the only obviously relevant arch that
defines ARCH_HAS_SYNC_DMA_FOR_{DEVICE,CPU} but the device.dma_coherent
setting comes from ACPI/OF firmware, so someone from ARM land will need
to shout if this is an issue.  I think we'd need to back off and go
with documentation if a broken use case shows up.  Thanks,

Alex

 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 3c0ac3c34a7f9a..f144eb9fea8e31 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2269,6 +2269,12 @@ static int amd_iommu_def_domain_type(struct device *dev)
>  	return 0;
>  }
>  
> +static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
> +{
> +	/* IOMMU_PTE_FC is always set */
> +	return true;
> +}
> +
>  const struct iommu_ops amd_iommu_ops = {
>  	.capable = amd_iommu_capable,
>  	.domain_alloc = amd_iommu_domain_alloc,
> @@ -2291,6 +2297,7 @@ const struct iommu_ops amd_iommu_ops = {
>  		.flush_iotlb_all = amd_iommu_flush_iotlb_all,
>  		.iotlb_sync	= amd_iommu_iotlb_sync,
>  		.free		= amd_iommu_domain_free,
> +		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
>  	}
>  };
> 
> Thanks,
> Jason
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
