Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0A6C282E1
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 15:55:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72ED8218B0
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 15:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72ED8218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 334DAE59;
	Wed, 24 Apr 2019 15:55:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 133FEE51
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 15:55:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8232D786
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 15:55:08 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 4A77C78F; Wed, 24 Apr 2019 17:55:06 +0200 (CEST)
Date: Wed, 24 Apr 2019 17:55:06 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
Message-ID: <20190424155505.GA6731@8bytes.org>
References: <20190424141900.8883-1-tmurphy@arista.com>
	<20190424143246.GA24079@infradead.org>
	<CAPL0++7w0wR+hid=0XkGtH2wR0qvL1oNheEMQOM=8CtyhNLmag@mail.gmail.com>
	<20190424145819.GA16141@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424145819.GA16141@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424155506.sGHjpr7aLtjNqciPrdOzwnFc0_pXaWMvWWTV2IA-S7A@z>

On Wed, Apr 24, 2019 at 07:58:19AM -0700, Christoph Hellwig wrote:
> I'd be tempted to do that.  But lets just ask Joerg if he has
> any opinion..

The reason was that it is an unlikely path, as hardware implementations
are not allowed to set this bit. It is purely for emulated AMD IOMMUs.
I have not measured whether this annotation has any performance
benefit, but I find it more readable at least.

Regards,

	Joerg

PS: Why did you drop me from the Cc list of the previous replies?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
