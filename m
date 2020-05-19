Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E6C433DF
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 01:50:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0BC20674
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 01:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0BC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E03198831F;
	Tue, 19 May 2020 01:50:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RN93oQbmN9CA; Tue, 19 May 2020 01:50:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4169C8831B;
	Tue, 19 May 2020 01:50:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26799C0888;
	Tue, 19 May 2020 01:50:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DCC9C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 01:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 33FB786DAF
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 01:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hYZzSTQg7N7t for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 01:50:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 84FA18632F
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 01:50:07 +0000 (UTC)
IronPort-SDR: KKeMMnYlE2Nn+jkuIL7+x/T9eRbCHAt/uGbuUk+k7VCizUSLMPPeoxIT6+tYgA29xhk9BbN4vt
 IkiQnga1Uslw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2020 18:50:07 -0700
IronPort-SDR: EOGTS74a05MTvCoTDcKp6/q9yc/0wC7ttZEFMvT3gszZFI5Y5cYKuYzl7+6H07Ij3myT/jDUaY
 PfoWZuL1ngtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; d="scan'208";a="282170239"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by orsmga002.jf.intel.com with ESMTP; 18 May 2020 18:50:05 -0700
Subject: Re: [PATCH 00/18] [PULL REQUEST] iommu/vt-d: patches for v5.8
To: Joerg Roedel <joro@8bytes.org>
References: <20200516062101.29541-1-baolu.lu@linux.intel.com>
 <20200518185038.GF18353@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2808d6fc-d006-f052-dff8-d2d55c8c21b0@linux.intel.com>
Date: Tue, 19 May 2020 09:46:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518185038.GF18353@8bytes.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>
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

Hi Joerg,

On 5/19/20 2:50 AM, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Sat, May 16, 2020 at 02:20:43PM +0800, Lu Baolu wrote:
>> Jacob Pan (9):
>>    iommu/vt-d: Move domain helper to header
>>    iommu/vt-d: Use a helper function to skip agaw for SL
>>    iommu/vt-d: Add nested translation helper function
>>    iommu/vt-d: Add bind guest PASID support
>>    iommu/vt-d: Support flushing more translation cache types
>>    iommu/vt-d: Add svm/sva invalidate function
>>    iommu/vt-d: Add custom allocator for IOASID
>>    iommu/vt-d: Report SVA feature with generic flag
>>    iommu/vt-d: Replace intel SVM APIs with generic SVA APIs
>>
>> Lu Baolu (8):
>>    iommu/vt-d: Enlightened PASID allocation
>>    iommu/vt-d: Add get_domain_info() helper
>>    iommu/vt-d: Multiple descriptors per qi_submit_sync()
>>    iommu/vt-d: debugfs: Add support to show inv queue internals
>>    iommu/vt-d: Disable non-recoverable fault processing before unbind
>>    iommu/vt-d: Add page request draining support
>>    iommu/vt-d: Remove redundant IOTLB flush
>>    iommu/vt-d: Remove duplicated check in intel_svm_bind_mm()
>>
>> Tom Murphy (1):
>>    iommu/vt-d: Remove IOVA handling code from the non-dma_ops path
> 
> I get these new compile warnings on x86-32 after pulling in these
> patches:
> 
>      drivers/iommu/intel-pasid.c:818:6: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      drivers/iommu/intel-pasid.c:821:9: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      drivers/iommu/intel-pasid.c:824:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      drivers/iommu/intel-svm.c:343:45: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> 
> Can you please take a look and send me a fix for these?

Thanks a lot for catching this. I've post a fix. Please check it.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
