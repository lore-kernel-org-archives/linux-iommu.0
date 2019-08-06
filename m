Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A8C433FF
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 15:25:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081B120C01
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 15:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081B120C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DAB63E6D;
	Tue,  6 Aug 2019 15:25:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8F6C2E62
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 15:25:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 30E0689D
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 15:25:32 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id A10883D5; Tue,  6 Aug 2019 17:25:30 +0200 (CEST)
Date: Tue, 6 Aug 2019 17:25:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Handle SG length overflow better
Message-ID: <20190806152529.GB1198@8bytes.org>
References: <fbdbb8c0e550ae559ea3eedc1fea084c0111f202.1564418681.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fbdbb8c0e550ae559ea3eedc1fea084c0111f202.1564418681.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Robin,

On Mon, Jul 29, 2019 at 05:46:00PM +0100, Robin Murphy wrote:
> Since scatterlist dimensions are all unsigned ints, in the relatively
> rare cases where a device's max_segment_size is set to UINT_MAX, then
> the "cur_len + s_length <= max_len" check in __finalise_sg() will always
> return true. As a result, the corner case of such a device mapping an
> excessively large scatterlist which is mergeable to or beyond a total
> length of 4GB can lead to overflow and a bogus truncated dma_length in
> the resulting segment.
> 
> As we already assume that any single segment must be no longer than
> max_len to begin with, this can easily be addressed by reshuffling the
> comparison.

Has this been triggered in the wild of can this patch wait for the next
merge window?

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
