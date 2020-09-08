Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB0EC2BBD0
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 06:10:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B383D206B8
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 06:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B383D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 432782291C;
	Tue,  8 Sep 2020 06:10:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJzw14vaWHwO; Tue,  8 Sep 2020 06:10:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 22722228E2;
	Tue,  8 Sep 2020 06:10:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0148DC0052;
	Tue,  8 Sep 2020 06:10:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3743C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 06:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7E3752291C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 06:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJChBOsFF3vg for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 06:10:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id A73E2228E2
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 06:10:41 +0000 (UTC)
IronPort-SDR: nD/reGhEOJC0rywvyhGNTnk47h6OyIQy9X0HMzr5bVTsdvoGDhuo2o1SJ99vthWcnvpu5Lr7EA
 NC2uN1HdxytA==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="145801284"
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; d="scan'208";a="145801284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2020 23:10:40 -0700
IronPort-SDR: WV1iGX4PezN4uM+SBYmsobq8wQfeNgX5mSccINOILxX+uqqhJ1fSilEU4XPtxc6P1gSWzvsQfz
 ZmYSq5PMiL1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; d="scan'208";a="407028868"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2020 23:10:38 -0700
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
To: Christoph Hellwig <hch@infradead.org>, Tom Murphy <murphyt7@tcd.ie>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
 <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
 <20200908053619.GA15418@infradead.org> <20200908055510.GA19078@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9655fdc9-6ea0-e4c1-e104-a9a8981ecb1e@linux.intel.com>
Date: Tue, 8 Sep 2020 14:04:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908055510.GA19078@infradead.org>
Content-Language: en-US
Cc: intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, iommu@lists.linux-foundation.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On 9/8/20 1:55 PM, Christoph Hellwig wrote:
> On Tue, Sep 08, 2020 at 06:36:19AM +0100, Christoph Hellwig wrote:
>> On Mon, Sep 07, 2020 at 09:18:50PM +0100, Tom Murphy wrote:
>>> Yeah we talked about passing an attr to map_sg to disable merging at
>>> the following microconfernce:
>>> https://linuxplumbersconf.org/event/7/contributions/846/
>>> As far as I can remember everyone seemed happy with that solution. I
>>> won't be working on this though as I don't have any more time to
>>> dedicate to this. It seems Lu Baolu will take over this.
>>
>> I'm absolutely again passing a flag.  Tha just invites further
>> abuse.  We need a PCI ID based quirk or something else that can't
>> be as easily abused.
> 
> Also, I looked at i915 and there are just three dma_map_sg callers.
> The two dmabuf related ones are fixed by Marek in his series, leaving

Do you mind telling where can I find Marek's series?

Best regards,
baolu

> just the one in i915_gem_gtt_prepare_pages, which does indeed look
> very fishy.  But if that one is so hard to fix it can just be replaced
> by an open coded for_each_sg loop that contains manual dma_map_page
> calls.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
