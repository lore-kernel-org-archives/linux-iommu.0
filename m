Return-Path: <SRS0=24gJ=V4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825AEC433FF
	for <iommu@archiver.kernel.org>; Wed, 31 Jul 2019 17:20:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558EA206A2
	for <iommu@archiver.kernel.org>; Wed, 31 Jul 2019 17:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xq8v5cdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558EA206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A3FB0405E;
	Wed, 31 Jul 2019 17:20:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7AE913B6C
	for <iommu@lists.linux-foundation.org>;
	Wed, 31 Jul 2019 17:05:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 36499A8
	for <iommu@lists.linux-foundation.org>;
	Wed, 31 Jul 2019 17:05:47 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
	[83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 92E7621852;
	Wed, 31 Jul 2019 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564592747;
	bh=L3gzyj0Bf5T2JOyiCBjjVvtUSwX1i/8yfo6bEx9KXps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xq8v5cdYUmxOkz410SjHmnJAFRmmUKwibQkMhbgas7+CxkzBDNOLrg3rGm2WmLGvv
	ZWZCvt/S84P9Y9xNylItyFFdww4Le8Lhctjqu0nPNBV/CZh+Z1iUtljDQHUrQHLPYl
	mm++EQmH+soLKYA2+JfPhaiyK10Ehpd3cZTEVogo=
Date: Wed, 31 Jul 2019 19:05:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH-4.19-stable 0/2] iommu/vt-d: queue_iova() boot crash
	backport
Message-ID: <20190731170542.GB22660@kroah.com>
References: <20190731162220.24364-1-dima@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190731162220.24364-1-dima@arista.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Joerg Roedel <jroedel@suse.de>, 0x7f454c46@gmail.com,
	stable@vger.kernel.org, iommu@lists.linux-foundation.org,
	David Woodhouse <dwmw2@infradead.org>
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

On Wed, Jul 31, 2019 at 05:22:18PM +0100, Dmitry Safonov wrote:
> Backport commits from master that fix boot failure on some intel
> machines.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the backports, 4.19.y and 4.14.y patches now queued up.

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
