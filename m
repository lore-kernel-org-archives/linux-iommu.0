Return-Path: <SRS0=7x6w=CV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936F4C433E2
	for <iommu@archiver.kernel.org>; Sat, 12 Sep 2020 03:14:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E360F221E7
	for <iommu@archiver.kernel.org>; Sat, 12 Sep 2020 03:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E360F221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9544F8748B;
	Sat, 12 Sep 2020 03:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jkHDXwBjZWIT; Sat, 12 Sep 2020 03:14:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DDE6487479;
	Sat, 12 Sep 2020 03:14:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE406C0859;
	Sat, 12 Sep 2020 03:14:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E37DC0051
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 03:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 697372E22C
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 03:14:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cTaoBaVXB+lJ for <iommu@lists.linux-foundation.org>;
 Sat, 12 Sep 2020 03:14:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id 16C5E20788
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 03:14:02 +0000 (UTC)
IronPort-SDR: jK65wtnPf2wDgDSYmcme62CaeZFoHB0qeb1G6sTvfNUvF1H5U+5vn8zqG8BxcrSLa8yYl6QV5m
 jHCfGYxbqT6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="158171176"
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; d="scan'208";a="158171176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2020 20:13:53 -0700
IronPort-SDR: loX3EgoYAZYme1znZJfeaI/r7pIPYNsgYHy4/zzxkRoOl4GgCMscW7J0njqdIzhqNsEmDKhHWJ
 0XHzTAidexJw==
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; d="scan'208";a="481555306"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.203])
 ([10.254.212.203])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2020 20:13:49 -0700
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
To: Christoph Hellwig <hch@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
 <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
 <20200908053619.GA15418@infradead.org> <20200908055510.GA19078@infradead.org>
 <9655fdc9-6ea0-e4c1-e104-a9a8981ecb1e@linux.intel.com>
 <20200908062326.GB20774@infradead.org>
 <a10026ea-6de5-b7b1-80af-8000dfd4601b@linux.intel.com>
 <20200909070620.GB28245@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8c8f3df1-7fab-d019-7e4a-4ce5f5b2b273@linux.intel.com>
Date: Sat, 12 Sep 2020 11:13:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909070620.GB28245@infradead.org>
Content-Language: en-US
Cc: intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, iommu@lists.linux-foundation.org,
 Tom Murphy <murphyt7@tcd.ie>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
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

On 2020/9/9 15:06, Christoph Hellwig wrote:
> On Wed, Sep 09, 2020 at 09:43:09AM +0800, Lu Baolu wrote:
>> +       /*
>> +        * The Intel graphic device driver is used to assume that the
>> returned
>> +        * sg list is not combound. This blocks the efforts of converting
>> the
> 
> This adds pointless overly long lines.
> 
>> +        * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
>> +        * device driver work and should be removed once it's fixed in i915
>> +        * driver.
>> +        */
>> +       if (dev_is_pci(dev) &&
>> +           to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
>> +           (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
>> +               for_each_sg(sg, s, nents, i) {
>> +                       unsigned int s_iova_off = sg_dma_address(s);
>> +                       unsigned int s_length = sg_dma_len(s);
>> +                       unsigned int s_iova_len = s->length;
>> +
>> +                       s->offset += s_iova_off;
>> +                       s->length = s_length;
>> +                       sg_dma_address(s) = dma_addr + s_iova_off;
>> +                       sg_dma_len(s) = s_length;
>> +                       dma_addr += s_iova_len;
>> +               }
>> +
>> +               return nents;
>> +       }
> 
> This wants an IS_ENABLED() check.  And probably a pr_once reminding
> of the workaround.
> 

Will fix in the next version.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
