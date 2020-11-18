Return-Path: <SRS0=FiUI=EY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD7C5519F
	for <iommu@archiver.kernel.org>; Wed, 18 Nov 2020 13:28:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34342463B
	for <iommu@archiver.kernel.org>; Wed, 18 Nov 2020 13:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xTg6/kl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34342463B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 605B585AE9;
	Wed, 18 Nov 2020 13:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zCjcTb6-uot0; Wed, 18 Nov 2020 13:28:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0A8D6859D9;
	Wed, 18 Nov 2020 13:28:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0362C0891;
	Wed, 18 Nov 2020 13:28:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5417AC07FF
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 13:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 417EA86DCA
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 13:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WYJO2g72xrxz for <iommu@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 13:28:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2D73F86D73
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 13:28:56 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5BA0D2168B;
 Wed, 18 Nov 2020 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605706135;
 bh=GXB+cRJ8S+Trf+du81PieNJ/TBxT7l3tdYWwgb2rQhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xTg6/kl1kBQzTpCAQlHPbXFP963UAv5vU9c3sWuwOg1Q3oOt7LIi8zLZ5wqCh2xzx
 fJw+EPx6TOuIsdIszc1YozVWGx2fKeLuxGiD/uufdJoiWaqths4pvkKeyz/V7DgVMQ
 646pu+Law3l7M2mne3g3XllKxsM4mwgV0lutbCe0=
Date: Wed, 18 Nov 2020 13:28:50 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init
 fail in tboot system
Message-ID: <20201118132849.GB2029@willie-the-truck>
References: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
 <34e8f6c6-e9f7-634b-8f68-3645261fd882@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34e8f6c6-e9f7-634b-8f68-3645261fd882@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tboot-devel@lists.sourceforge.net, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 ning.sun@intel.com, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 mingo@redhat.com, bp@alien8.de, tglx@linutronix.de, dwmw2@infradead.org
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

On Wed, Nov 18, 2020 at 07:32:25AM +0800, Lu Baolu wrote:
> Please consider this patch for v5.10.

Cheers, I'll stick this onto a fixes branch momentarily.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
