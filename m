Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE87C43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 15:28:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7BC22453
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 15:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7BC22453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C16F88733A;
	Tue,  8 Sep 2020 15:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YpTFtsohG45R; Tue,  8 Sep 2020 15:28:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E47178732A;
	Tue,  8 Sep 2020 15:28:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D372DC0859;
	Tue,  8 Sep 2020 15:28:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65204C0051;
 Tue,  8 Sep 2020 15:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5F63E85A46;
 Tue,  8 Sep 2020 15:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ek6bb5Hy+Dxv; Tue,  8 Sep 2020 15:28:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6E6B286B0A;
 Tue,  8 Sep 2020 15:28:50 +0000 (UTC)
IronPort-SDR: QJvSP55dbM2/Eb9xDgaXPYmae4BPy6xrBNjX5bZO0bfQt4aykXUliv9pC0ynxKGtEnMmmQWvwh
 9BOUg+rg7hmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="138199263"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; d="scan'208";a="138199263"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 08:28:50 -0700
IronPort-SDR: OqiPE0Cn/mbaoFglvyhAf2rWnLm6JquwW+AKzi6KXAQYqzMCNSFdbI9D+UGi2vd+sJzRv/8Kvj
 Oe6qN0U8cxmQ==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; d="scan'208";a="480068519"
Received: from sderix-mobl1.ger.corp.intel.com (HELO [10.214.213.131])
 ([10.214.213.131])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 08:28:38 -0700
Subject: Re: [Intel-gfx] [PATCH 0/8] Convert the intel iommu driver to the
 dma-iommu api
To: Logan Gunthorpe <logang@deltatee.com>, Tom Murphy <murphyt7@tcd.ie>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
 <20200529124523.GA11817@infradead.org>
 <CGME20200529190523eucas1p2c086133e707257c0cdc002f502d4f51d@eucas1p2.samsung.com>
 <33137cfb-603c-86e8-1091-f36117ecfaf3@deltatee.com>
 <ef2150d5-7b6a-df25-c10d-e43316fe7812@samsung.com>
 <b9140772-0370-a858-578c-af503a06d8e9@deltatee.com>
 <CALQxJuutRaeX89k2o4ffTKYRMizmMu0XbRnzpFuSSrkQR02jKg@mail.gmail.com>
 <766525c3-4da9-6db7-cd90-fb4b82cd8083@deltatee.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <60a82319-cbee-4cd1-0d5e-3c407cc51330@linux.intel.com>
Date: Tue, 8 Sep 2020 16:28:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <766525c3-4da9-6db7-cd90-fb4b82cd8083@deltatee.com>
Content-Language: en-US
Cc: kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Julien Grall <julien.grall@arm.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, linux-rockchip@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


Hi,

On 27/08/2020 22:36, Logan Gunthorpe wrote:
> On 2020-08-23 6:04 p.m., Tom Murphy wrote:
>> I have added a check for the sg_dma_len == 0 :
>> """
>>   } __sgt_iter(struct scatterlist *sgl, bool dma) {
>>          struct sgt_iter s = { .sgp = sgl };
>>
>> +       if (sgl && sg_dma_len(sgl) == 0)
>> +           s.sgp = NULL;
>>
>>          if (s.sgp) {
>>              .....
>> """
>> at location [1].
>> but it doens't fix the problem.
> 
> Based on my read of the code, it looks like we also need to change usage
> of sgl->length... Something like the rough patch below, maybe?

This thread was brought to my attention and I initially missed this 
reply. Essentially I came to the same conclusion about the need to use 
sg_dma_len. One small correction below:

> Also, Tom, do you have an updated version of the patchset to convert the
> Intel IOMMU to dma-iommu available? The last one I've found doesn't
> apply cleanly (I'm assuming parts of it have been merged in slightly
> modified forms).
> 
> Thanks,
> 
> Logan
> 
> --
> 
> diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h
> b/drivers/gpu/drm/i915/i915
> index b7b59328cb76..9367ac801f0c 100644
> --- a/drivers/gpu/drm/i915/i915_scatterlist.h
> +++ b/drivers/gpu/drm/i915/i915_scatterlist.h
> @@ -27,13 +27,19 @@ static __always_inline struct sgt_iter {
>   } __sgt_iter(struct scatterlist *sgl, bool dma) {
>          struct sgt_iter s = { .sgp = sgl };
> 
> +       if (sgl && !sg_dma_len(s.sgp))

I'd extend the condition to be, just to be safe:

	if (dma && sgl && !sg_dma_len(s.sgp))

> +               s.sgp = NULL;
> +
>          if (s.sgp) {
>                  s.max = s.curr = s.sgp->offset;
> -               s.max += s.sgp->length;
> -               if (dma)
> +
> +               if (dma) {
> +                       s.max += sg_dma_len(s.sgp);
>                          s.dma = sg_dma_address(s.sgp);
> -               else
> +               } else {
> +                       s.max += s.sgp->length;
>                          s.pfn = page_to_pfn(sg_page(s.sgp));
> +               }

Otherwise has this been tested or alternatively how to test it? (How to 
repro the issue.)

Regards,

Tvrtko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
