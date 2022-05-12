Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E844BC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 07:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80F9360BFC;
	Thu, 12 May 2022 07:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sm_kvJXE7OEw; Thu, 12 May 2022 07:01:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6326A605AE;
	Thu, 12 May 2022 07:01:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 343D1C0039;
	Thu, 12 May 2022 07:01:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D72FEC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 07:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0CDC4198A
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 07:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RRxcPnZSrDOD for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 07:01:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9D45402BE
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 07:01:28 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 s18-20020a056830149200b006063fef3e17so2067923otq.12
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=efsh0uFhOmfXuxYUIJCJiPXg0Qyy8hA9I7vTZKgvJew=;
 b=EnqUiSp3NRowBkDyrnH+e0w+NAXs45+xS/LbhwDZ3jHVK0hFAtydeud0D9yIZn5vHW
 h8HWixSpXklXLa+vK0fx3AbDZVfRsCuQ3uWTqZM5UIxf9StJFijoGeJ7Y9NtGuxszsXu
 kpIsxH5bfEK7ZaVLJvMeAWAa17bcyo8M/DirkCc2ghz86spx04iga5Sx0rcogQiDYQQK
 EOfOw72OCdN2Dw7gxALr9tRfBFCVfE8WB3Y9udtLVW8WmkPb7+c5AtLreavAU14sR3SC
 TZ3bR7XjoP4DP+D+JPhHYQsGcJN53ZIv1t4dk2aqF7ASmkfTgz5ABsz8Jo02qvjVqbb+
 lCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=efsh0uFhOmfXuxYUIJCJiPXg0Qyy8hA9I7vTZKgvJew=;
 b=1/vAR16KY7GvIJnHPNUhDBCJ1MM6lE9nJZvQTeNQ1n2c5+3GgF9TmyK/nPP3BiceLX
 Ko72Lp0AunrBPX5I+3tSdqo5X7z1rPaKpdf+rT72fowYB5oVy6VPs72ImWS9vOSXqssM
 blGVrMdEYKkwB42SqoeZFgbI/8ViHEZO/I1WLyanJy9MQq6AS+AQn2DdXPWtlBap9xaF
 SAQSbGO18MHu3+NLLhZLVBvuWyzO0y3CswQBJqWcbqJsLuWy6qgff7N2LTyq6PgQZhVN
 YwrI9eNPBEhZ45KTrSg+0VoD0ZUuhnz/pXxv7XTZzZhQG38O9/ATU7G0IU3DskzbdPPb
 hfiw==
X-Gm-Message-State: AOAM531MjgY81VBeh+rI0F4/Dctg+6zDwnE9DxFwxayVIuZwLsmTANXe
 ZtNiykswUoCmV21sTfc67MrSuA==
X-Google-Smtp-Source: ABdhPJwALcVzEMLfNXiKQ1qqw3+WNq3w140FzQj5Vmo+drcuLq4wMlXBD8pHJTOXCPPEJ5+K2h3aKA==
X-Received: by 2002:a9d:7618:0:b0:605:a132:7d57 with SMTP id
 k24-20020a9d7618000000b00605a1327d57mr11353454otl.262.1652338887629; 
 Thu, 12 May 2022 00:01:27 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 102-20020a9d016f000000b0060603221272sm1633368otu.66.2022.05.12.00.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 00:01:26 -0700 (PDT)
Date: Thu, 12 May 2022 08:00:59 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <Ynywqxo4P+aEeS6c@myrica>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
 <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
 <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yntrv+nq2t/IeVo2@myrica> <20220511120240.GY49344@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220511120240.GY49344@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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

On Wed, May 11, 2022 at 09:02:40AM -0300, Jason Gunthorpe wrote:
> On Wed, May 11, 2022 at 08:54:39AM +0100, Jean-Philippe Brucker wrote:
> > > > > Then 'detach pasid' is:
> > > > >
> > > > > iommu_ops->blocking_domain->ops->attach_dev_pasid(domain, dev,
> > > > pasid);
> > > > >
> > > > > And we move away from the notion of 'detach' and in the direction that
> > > > > everything continuously has a domain set. PASID would logically
> > > > > default to blocking_domain, though we wouldn't track this anywhere.
> > > > 
> > > > I am not sure whether we still need to keep the blocking domain concept
> > > > when we are entering the new PASID world. Please allow me to wait and
> > > > listen to more opinions.
> > > > 
> > > 
> > > I'm with Jason on this direction. In concept after a PASID is detached it's
> > > essentially blocked. Implementation-wise it doesn't prevent the iommu
> > > driver from marking the PASID entry as non-present as doing in this
> > > series instead of actually pointing to the empty page table of the block
> > > domain. But api-wise it does make the entire semantics more consistent.
> > 
> > This is all internal to IOMMU so I don't think we should be concerned
> > about API consistency. I prefer a straighforward detach() operation
> > because that way IOMMU drivers don't have to keep track of which domain is
> > attached to which PASID. That code can be factored into the IOMMU core.
> 
> Why would a driver need to keep additional tracking?
> 
> > In addition to clearing contexts, detach() also needs to invalidate TLBs,
> > and for that the SMMU driver needs to know the old ASID (!= PASID) that
> > was used by the context descriptor. We can certainly work around a missing
> > detach() to implement this, but it will be convoluted.
> 
> It is not "missing" it is just renamed to blocking_domain->ops->set_dev_pasid()
> 
> The implementation of that function would be identical to
> detach_dev_pasid.

  attach(dev, pasid, sva_domain)
  detach(dev, pasid, sva_domain)

versus

  set_dev_pasid(dev, pasid, sva_domain)
  set_dev_pasid(dev, pasid, blocking)

we loose the information of the domain previously attached, and the SMMU
driver has to retrieve it to find the ASID corresponding to the mm. 

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
