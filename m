Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB00C433DB
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 14:15:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0311E64F69
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 14:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0311E64F69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75E584EDCC;
	Wed, 17 Mar 2021 14:15:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AUW19ieZU_uQ; Wed, 17 Mar 2021 14:15:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A5AC4ED58;
	Wed, 17 Mar 2021 14:15:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02202C000B;
	Wed, 17 Mar 2021 14:15:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6986C0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 14:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B831542FDF
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 14:15:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SskukrmfpCuB for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 14:15:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA8DB40184
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Message-ID:From:CC:To:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
 Date:Sender:Reply-To:Content-ID:Content-Description;
 bh=CMMz5R1TICGoardcIZbuQbx/IbDn7R6aDFEFgKeLLJw=; b=SgzSOzls4iI1qxq/PGJWPYRBFb
 rFE1EcVrfc1TpoiIoUGVJ204bhFGtx3WBPohUhVUEX/eHBcWyi1U9NZ5PyuZPqJyKJdeemTaCbIgX
 sLrB7QPQgpGFD8jrUDTf6MZLOmuL3W6CcGgOS2l3P5DZ28JBNSl126SXOVxMNQg2KqWl7crfFKOq7
 GNCBy1CGrI8zlYJ7YiIEKduV42jmovU4yYCRaV+YIDfVN1sD3kSROw5Mtt3x68MKLmep4V7k6uqpV
 8GE5wDZdNvKLCYvLbHgbT+o7KsYnkK4hxlvVx7Kq6Z8ZTOyeAra+yeim4JhwslpeXEdIir8gkNZPy
 EdNrJt6A==;
Received: from [2001:8b0:10b:1:6dbf:8591:24f9:c1c2]
 by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lMWxR-003EYd-9t; Wed, 17 Mar 2021 14:15:33 +0000
Date: Wed, 17 Mar 2021 13:37:16 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <YFIE8xnr/HWqxm4p@8bytes.org>
References: <20210317091037.31374-1-joro@8bytes.org>
 <20210317091037.31374-3-joro@8bytes.org>
 <449d4a2d192d23eb504e43b13c35c326f2d0309a.camel@infradead.org>
 <YFIE8xnr/HWqxm4p@8bytes.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] iommu/amd: Don't call early_amd_iommu_init() when AMD
 IOMMU is disabled
To: Joerg Roedel <joro@8bytes.org>
From: David Woodhouse <dwmw2@infradead.org>
Message-ID: <3014DA56-84D8-474B-94FE-6FDBB6241F9F@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Cc: Joerg Roedel <jroedel@suse.de>, Xiaojian Du <xiaojian.du@amd.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
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



On 17 March 2021 13:32:35 GMT, Joerg Roedel <joro@8bytes.org> wrote:
>On Wed, Mar 17, 2021 at 11:47:11AM +0000, David Woodhouse wrote:
>> If you've already moved the Stoney Ridge check out of the way,
>there's
>> no real reason why you can't just set
>init_state=IOMMU_CMDLINE_DISABLED
>> directly from parse_amd_iommu_options(), is there? Then you don't
>need
>> the condition here at all?
>
>True, there is even more room for optimization. The amd_iommu_disabled
>variable can go away entirely, including its checks in
>early_amd_iommu_init(). I will do a patch-set on-top of this for v5.13
>which does more cleanups.

If we can get to the point where we don't even need to check amd_iommu_irq_remap in the ...select() function because the IRQ domain is never even registered in the case where the flag ends up false, all the better :)

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
