Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A6C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 09:17:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C11E613D6
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 09:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C11E613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 54C51402EA;
	Thu,  3 Jun 2021 09:17:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jd2IU0cBnThU; Thu,  3 Jun 2021 09:17:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4190D400DB;
	Thu,  3 Jun 2021 09:17:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBB5FC000E;
	Thu,  3 Jun 2021 09:17:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4E91C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 09:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86EE8402EA
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 09:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UIz99N_FZjkp for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 09:17:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10829400DB
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 09:17:10 +0000 (UTC)
IronPort-SDR: ooP3ufuVibgWlMlGtETQAL1i0PUCawiJI1RXFdK+GW89S/DbQqUNdL5e5aaqEDQHcx86OMRgTR
 6p8fUgmmP1yQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="200990701"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="200990701"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 02:17:08 -0700
IronPort-SDR: GiFlEA2d98S0y3fZX2hwn2y9S0cggQtERcJvUzDDX14kZt+3xkig3EyHLndhd45VWF76KFBNLM
 XY2WVcRmIijA==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="483398225"
Received: from aburk3x-mobl2.ger.corp.intel.com (HELO [10.213.243.139])
 ([10.213.243.139])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 02:17:06 -0700
Subject: Re: [Intel-gfx] i915 and swiotlb_max_segment
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20210510152525.GA30093@lst.de> <YKZ8eqnSnaso3aoe@0xbeefdead.lan>
 <162270961054.11739.9148402963893484386@jlahtine-mobl.ger.corp.intel.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <d7bd2bde-2b95-44fa-18b0-fd883c78e3b6@linux.intel.com>
Date: Thu, 3 Jun 2021 10:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <162270961054.11739.9148402963893484386@jlahtine-mobl.ger.corp.intel.com>
Content-Language: en-US
Cc: intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org
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

On 03/06/2021 09:40, Joonas Lahtinen wrote:
> + Tvrtko to take a look
> 
> Quoting Konrad Rzeszutek Wilk (2021-05-20 18:12:58)
>> On Mon, May 10, 2021 at 05:25:25PM +0200, Christoph Hellwig wrote:
>>> Hi all,
>>>
>>> swiotlb_max_segment is a rather strange "API" export by swiotlb.c,
>>> and i915 is the only (remaining) user.
>>>
>>> swiotlb_max_segment returns 0 if swiotlb is not in use, 1 if
>>> SWIOTLB_FORCE is set or swiotlb-zen is set, and the swiotlb segment
>>> size when swiotlb is otherwise enabled.
>>>
>>> i915 then uses it to:
>>>
>>>   a) decided on the max order in i915_gem_object_get_pages_internal
>>>   b) decide on a max segment size in i915_sg_segment_size
>>>
>>> for a) it really seems i915 should switch to dma_alloc_noncoherent
>>> or dma_alloc_noncontigous ASAP instead of using alloc_page and
>>> streaming DMA mappings.  Any chance I could trick one of the i915
>>> maintaines into doing just that given that the callchain is not
>>> exactly trivial?
>>>
>>> For b) I'm not sure swiotlb and i915 really agree on the meaning
>>> of the value.  swiotlb_set_max_segment basically returns the entire
>>> size of the swiotlb buffer, while i915 seems to use it to limit
>>> the size each scatterlist entry.  It seems like dma_max_mapping_size
>>> might be the best value to use here.
>>
>> Yes. The background behind that was SWIOTLB would fail because well, the
>> size of the sg was too large. And some way to limit it to max size
>> was needed - the dma_max_mapping_size "should" be just fine.

Can't say I am 100% at home here but what I remember is that the limiting factor was maximum size of a sg segment and not total size of the mapping.

Looking at the code today, if we would replace usage swiotlb_max_segment() with dma_max_mapping_size(), I don't see that would work when we call dma_map_sg_attrs().

Because AFAICT code can end up in dma_direct_max_mapping_size() (not sure when the ops->map_sg path is active and where to trace that) where we have:

size_t dma_direct_max_mapping_size(struct device *dev)
{
	/* If SWIOTLB is active, use its maximum mapping size */
	if (is_swiotlb_active() &&
	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
		return swiotlb_max_mapping_size(dev);
	return SIZE_MAX;
}

So for all swiotlb cases, including force, we get:

size_t swiotlb_max_mapping_size(struct device *dev)
{
	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
}

Which is fixed and doesn't align with swiotlb_max_segment(). But you guys are the experts here so please feel to correct me.

Regards,

Tvrtko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
