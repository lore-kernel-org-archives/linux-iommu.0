Return-Path: <SRS0=bsOk=CS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46568C43461
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 01:49:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD412177B
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 01:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD412177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6E18E20370;
	Wed,  9 Sep 2020 01:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aV9Kmk7wP2at; Wed,  9 Sep 2020 01:49:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E55472034F;
	Wed,  9 Sep 2020 01:49:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2D5BC0859;
	Wed,  9 Sep 2020 01:49:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FAE5C0051
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 01:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1D86D87459
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 01:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gW-0tjkxo-yy for <iommu@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 01:49:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8DF6786F5E
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 01:49:00 +0000 (UTC)
IronPort-SDR: ZfN0TZbaydtq4ifRh0dRWOokjt+niVZXBqKUG1S4qtBknh7Dys69nEG/D/G0lPradWxhKjeXxg
 G03EBt1HiuAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="145976104"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="145976104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 18:48:59 -0700
IronPort-SDR: iu1TM291fKLzW13YkpPo+t+WTXhU6OwMMLl9NaOEaJe/bkV8fk4PoCH/IQPpFihFj7CFCpN+QZ
 QO3ApYZpMMQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="407316380"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2020 18:48:55 -0700
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
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a10026ea-6de5-b7b1-80af-8000dfd4601b@linux.intel.com>
Date: Wed, 9 Sep 2020 09:43:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908062326.GB20774@infradead.org>
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

Hi Christoph,

On 9/8/20 2:23 PM, Christoph Hellwig wrote:
> On Tue, Sep 08, 2020 at 02:04:53PM +0800, Lu Baolu wrote:
>> Do you mind telling where can I find Marek's series?
> 
> [PATCH v10 00/30] DRM: fix struct sg_table nents vs. orig_nents misuse
> 
> on various lists including the iommu one.
> 

It seems that more work is needed in i915 driver. I will added below
quirk as you suggested.

--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -851,6 +851,31 @@ static int __finalise_sg(struct device *dev, struct 
scatterlist *sg, int nents,
         unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
         int i, count = 0;

+       /*
+        * The Intel graphic device driver is used to assume that the 
returned
+        * sg list is not combound. This blocks the efforts of 
converting the
+        * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
+        * device driver work and should be removed once it's fixed in i915
+        * driver.
+        */
+       if (dev_is_pci(dev) &&
+           to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
+           (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
+               for_each_sg(sg, s, nents, i) {
+                       unsigned int s_iova_off = sg_dma_address(s);
+                       unsigned int s_length = sg_dma_len(s);
+                       unsigned int s_iova_len = s->length;
+
+                       s->offset += s_iova_off;
+                       s->length = s_length;
+                       sg_dma_address(s) = dma_addr + s_iova_off;
+                       sg_dma_len(s) = s_length;
+                       dma_addr += s_iova_len;
+               }
+
+               return nents;
+       }
+

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
