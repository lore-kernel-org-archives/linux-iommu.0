Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B035C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 17:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A012560B65;
	Mon, 28 Mar 2022 17:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y86-0sZUYPTv; Mon, 28 Mar 2022 17:17:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5FC9A6061B;
	Mon, 28 Mar 2022 17:17:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33745C001D;
	Mon, 28 Mar 2022 17:17:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A33F0C0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F88B8144D
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xelNcPzD-Drs for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 17:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46C75813E2
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 17:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648487849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFq5xIrtlE0LH/UrNTPMMjVa4bF/UcCC/THRar2iFcc=;
 b=Cr+zpr/JkkxW4zolas/2bQ1xopYnADnguv8JugjmbP8brbk5wvp7S5bqnWNVyW4Lb++ram
 yW0pNVFqejehuaOS/3Cv+7B8h2HP4i3T3gwbqJz1e72nNR92763dtQgxyMX9DJLq66one6
 s4qQC+FHL0LiDPnWNEK+gO6C7Hp+4QE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-lbCcIggcMUmXWi9QrJGdTg-1; Mon, 28 Mar 2022 13:17:26 -0400
X-MC-Unique: lbCcIggcMUmXWi9QrJGdTg-1
Received: by mail-il1-f198.google.com with SMTP id
 o17-20020a92c691000000b002c2c04aebe7so8168675ilg.8
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 10:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=kFq5xIrtlE0LH/UrNTPMMjVa4bF/UcCC/THRar2iFcc=;
 b=3jtYKjE6oIR4B/QSqxODXtB7hvqcpQOb/iRVxEbR6uFYZhdRVjD0Vl3kINayxA0BKJ
 lQPmm1SxRCJTPndgd1UkVfD4AvYvYs8Ku3O1QlIcv9WGvJ33gqQAG1yduOPUakxYEcpo
 4lCYWzjC+pMb8cFikzrGEblHbLGEPyr69f9uVR/rhOWkiKq4C0wA7q8VOBWDX3wslqum
 IaRjABMpPHLOiFYwl2X4L2GFXsOjTX8Zl1rf8EEuZOOyXiDg6l6lCJe2omkwc6MyNHWz
 wJTpTFTq0VFCzH3tWkiyUbCF9H06DQlBdfC/dtAjvua93HWEU/3Zeo4xBRssYOogJsev
 hZzA==
X-Gm-Message-State: AOAM53009qsrJDa7Tsra9h3OD8QlsPMY5CanzTxSun0AdUD9QxMoT+9E
 tKdzHk7/EcrhxgPvfEO6hePjdAOxvRCKgx6CdXI6dVbrthPAGFKJY/vF2k/AyAJswXuiXurY+Xc
 Fog+Wmv6fpVynCthLNp4JzVwE3oq0CA==
X-Received: by 2002:a05:6602:2494:b0:64c:86a7:9fe9 with SMTP id
 g20-20020a056602249400b0064c86a79fe9mr1305008ioe.171.1648487845630; 
 Mon, 28 Mar 2022 10:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRWO2iQoEBPA6dqLLt3lHbvXF79rpJ35GLftd2YlzpdVdpYHvZvRm2FU0alz72N0akwN5Zzg==
X-Received: by 2002:a05:6602:2494:b0:64c:86a7:9fe9 with SMTP id
 g20-20020a056602249400b0064c86a79fe9mr1304982ioe.171.1648487845379; 
 Mon, 28 Mar 2022 10:17:25 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 c6-20020a056e020bc600b002c6731e7cb8sm7563658ilu.31.2022.03.28.10.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 10:17:25 -0700 (PDT)
Date: Mon, 28 Mar 2022 11:17:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Message-ID: <20220328111723.24fa5118.alex.williamson@redhat.com>
In-Reply-To: <20220324134622.GB1184709@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323131038.3b5cb95b.alex.williamson@redhat.com>
 <20220323193439.GS11336@nvidia.com>
 <20220323140446.097fd8cc.alex.williamson@redhat.com>
 <20220323203418.GT11336@nvidia.com>
 <20220323225438.GA1228113@nvidia.com>
 <BN9PR11MB5276EB80AFCC3003955A46248C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220324134622.GB1184709@nvidia.com>
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

On Thu, 24 Mar 2022 10:46:22 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Mar 24, 2022 at 07:25:03AM +0000, Tian, Kevin wrote:
> 
> > Based on that here is a quick tweak of the force-snoop part (not compiled).  
> 
> I liked your previous idea better, that IOMMU_CAP_CACHE_COHERENCY
> started out OK but got weird. So lets fix it back to the way it was.
> 
> How about this:
> 
> https://github.com/jgunthorpe/linux/commits/intel_no_snoop
> 
> b11c19a4b34c2a iommu: Move the Intel no-snoop control off of IOMMU_CACHE
> 5263947f9d5f36 vfio: Require that device support DMA cache coherence

I have some issues with the argument here:

  This will block device/platform/iommu combinations that do not
  support cache coherent DMA - but these never worked anyhow as VFIO
  did not expose any interface to perform the required cache
  maintenance operations.

VFIO never intended to provide such operations, it only tried to make
the coherence of the device visible to userspace such that it can
perform operations via other means, for example via KVM.  The "never
worked" statement here seems false.

Commit b11c19a4b34c2a also appears to be a behavioral change.  AIUI
vfio_domain.enforce_cache_coherency would only be set on Intel VT-d
where snoop-control is supported, this translates to KVM emulating
coherency instructions everywhere except VT-d w/ snoop-control.

My understanding of AMD-Vi is that no-snoop TLPs are always coherent, so
this would trigger unnecessary wbinvd emulation on those platforms.  I
don't know if other archs need similar, but it seems we're changing
polarity wrt no-snoop TLPs from "everyone is coherent except this case
on Intel" to "everyone is non-coherent except this opposite case on
Intel".  Thanks,

Alex

> eab4b381c64a30 iommu: Restore IOMMU_CAP_CACHE_COHERENCY to its original meaning
> 2752e12bed48f6 iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY with dev_is_dma_coherent()
> 
> If you like it could you take it from here?
> 
> Thanks,
> Jason
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
