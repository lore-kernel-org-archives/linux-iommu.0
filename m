Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334CDC31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 07:25:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C8B2073F
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 07:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C8B2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EE5A6F40;
	Fri, 14 Jun 2019 07:25:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 26587F3B
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 07:25:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E302EE5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 07:25:28 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 0A64268B02; Fri, 14 Jun 2019 09:25:00 +0200 (CEST)
Date: Fri, 14 Jun 2019 09:24:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v6 5/5] mmc: queue: Use bigger segments if IOMMU
	can merge the segments
Message-ID: <20190614072459.GD8420@lst.de>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: axboe@kernel.dk, linux-renesas-soc@vger.kernel.org, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, hch@lst.de
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

On Thu, Jun 13, 2019 at 07:20:15PM +0900, Yoshihiro Shimoda wrote:
> +static unsigned int mmc_get_max_segments(struct mmc_host *host)
> +{
> +	return host->can_merge ? BLK_MAX_SEGMENTS : host->max_segs;
> +}

Note that BLK_MAX_SEGMENTS is really a little misnamed, it just
is a BLK_DEFAULT_SEGMENTS.  I think you are better of picking your
own value here (even if 128 ends up ok) than reusing this somewhat
confusing constant.

> +	/*
> +	 * Since blk_mq_alloc_tag_set() calls .init_request() of mmc_mq_ops,
> +	 * the host->can_merge should be set before to get max_segs from
> +	 * mmc_get_max_segments().
> +	 */
> +	if (host->max_segs < BLK_MAX_SEGMENTS &&
> +	    device_iommu_mapped(mmc_dev(host)))
> +		host->can_merge = 1;
> +	else
> +		host->can_merge = 0;
> +

can_merge seems a little too generic a name to me.  Maybe can_iommu_merge?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
