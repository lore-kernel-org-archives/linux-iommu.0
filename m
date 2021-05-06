Return-Path: <SRS0=J567=KB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9888EC433B4
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 07:24:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08ADF61176
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 07:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08ADF61176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8CB4840658;
	Thu,  6 May 2021 07:24:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02PkSFzlUzch; Thu,  6 May 2021 07:24:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6984A40657;
	Thu,  6 May 2021 07:24:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D09ABC000E;
	Thu,  6 May 2021 07:24:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E055C0001
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 07:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4359A4030D
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 07:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jd9aniVMrRkU for <iommu@lists.linux-foundation.org>;
 Thu,  6 May 2021 07:24:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 416E14030B
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 07:24:09 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id n2so6751582ejy.7
 for <iommu@lists.linux-foundation.org>; Thu, 06 May 2021 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=eRP4wTn1wFZOpPD7g2y7lVg+V5xezb4JX6rjQ3r6xH4=;
 b=hUJi1Ju1LlScfHhDyP72PNYvaUr6tj3fzBj+bZ8lHKvWeTBj3NT+hIdlrf/7xRWASa
 6Pzl54QcOoN1FrgBAKNgI7p/u+Z67s85MNyGYoOGpLpm+B7uGbsGiRpdBDjBmYzy+mn1
 T4+0QHVMlUST9R6hoUf/e2yagDGq567NRATcCfxLdrrWXMQAlV9egyi1+gUty6dpbudK
 sG8R5sRiXurKziDANc3OM7wQg/58LnoDibOv9BsTRUF+iR4Ijjh1a2YVVOz/Sx6vpa/J
 3lZ2bKsEQKGQxdMwD9vshCsR0OAelyfZBQ01L7pmUJ1RGEcUaLvkbSVy2Yjc9Coaiplc
 6HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eRP4wTn1wFZOpPD7g2y7lVg+V5xezb4JX6rjQ3r6xH4=;
 b=G+Qg/h8FEYF6LeC23d8rzCgZHv/ivFgJbIjB2NglNTGPKU65y2C+/QPzfDFUYU2k9T
 WDUbVnxgpnO9Tzglhx0JBfK0q/0pIgpy7BEIxm4JtAXn+yeLnDZPa8g+aJq4OHod3lt9
 7p22fBcIZEOmk40pVwwWUT/LSDuveNse+TSRFA9yh2VPi0AJHsCx/U2SYXp+7b7E8HFT
 Crin/W/S9a2UiQ6vvB+6yCtVU7byIdhoqEvqQxY92A8xKAegF5CJHL8TvH8+LIis+ii8
 UYWSwZS67WJUdiMah5NZmoPxDhgI3yn63sYwmVKmiTVny63KkVhq+3mprlc6bkQJ5g9n
 YIqg==
X-Gm-Message-State: AOAM531/ZVtHJr65LP5GbWKygAqNn0eCWcghrM/77GrwJZnbEWWSmzzi
 PRBmUcE0OdiNiJZLHbthCHZg1A==
X-Google-Smtp-Source: ABdhPJzixQ3BaFD3OTh1vRysF4zM97RPtVrKDRVk2N/ghEPf5TXJ8hDsWRBVGG0/0QhCyqEk1Prz2g==
X-Received: by 2002:a17:906:170a:: with SMTP id
 c10mr2796408eje.493.1620285847402; 
 Thu, 06 May 2021 00:24:07 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r16sm935986edq.87.2021.05.06.00.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 May 2021 00:24:06 -0700 (PDT)
Date: Thu, 6 May 2021 09:23:48 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YJOZhPGheTSlHtQc@myrica>
References: <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210505130446.3ee2fccd@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Wed, May 05, 2021 at 01:04:46PM -0700, Jacob Pan wrote:
> > > For ARM, since the guest owns the per device PASID table. There is no
> > > need to allocate PASIDs from the host nor the hypervisor. Without SWQ,
> > > there is no need for global PASID/SSID either. So PASID being global
> > > for ARM is for simplicity in case of host PASID/SSID.  
> > 
> > It isn't clear how ARM can support PASID and mdev but that is an
> > unrelated issue..
> > 
> AFAIK, the current SMMU device assignment is per RID, since only one stage2
> page tables per RID, not per PASID. This is equivalent to the older VT-d
> spec. prior to scalable mode.

Yes that's right. Since SMMUv3 has a single level-2 page table per RID, it
doesn't support assigning level-1 page tables to guests for mdevs (sub-VF
devices). So no PASIDs for mdevs, which also means each guest has its own
PASID space and the host doesn't track guest PASIDs.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
