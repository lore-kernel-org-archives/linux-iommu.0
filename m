Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D0FCA9EC5
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 09:43:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950EE20874
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 09:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950EE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3B9E0DBB;
	Wed, 30 Oct 2019 09:43:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 41081491;
	Wed, 30 Oct 2019 09:43:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BAE9F8A;
	Wed, 30 Oct 2019 09:43:19 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 3EE1334A; Wed, 30 Oct 2019 10:43:17 +0100 (CET)
Date: Wed, 30 Oct 2019 10:43:15 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Cristiane Naves <cristianenavescardoso09@gmail.com>
Subject: Re: [PATCH] iommu/virtio: Remove unused variable
Message-ID: <20191030094315.GC7254@8bytes.org>
References: <20191025161340.GA31368@cristiane-Inspiron-5420>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191025161340.GA31368@cristiane-Inspiron-5420>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Julia Lawall <julia.lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>,
	virtualization@lists.linux-foundation.org,
	outreachy-kernel@googlegroups.com, iommu@lists.linux-foundation.org
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

On Fri, Oct 25, 2019 at 01:13:40PM -0300, Cristiane Naves wrote:
> Remove the variable of return. Issue found by
> coccicheck(scripts/coccinelle/misc/returnvar.cocci)
> 
> Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
> ---
>  drivers/iommu/virtio-iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied for v5.5, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
