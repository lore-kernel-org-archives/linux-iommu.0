Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D7C2BA19
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 08:15:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5508206E9
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 08:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cNfCC3/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5508206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 99572838B8;
	Tue, 14 Apr 2020 08:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JgApb1cRdq4e; Tue, 14 Apr 2020 08:15:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D3C05863A6;
	Tue, 14 Apr 2020 08:15:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA417C089E;
	Tue, 14 Apr 2020 08:15:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDF22C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 08:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B67E620450
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 08:15:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TBvW6+DVr25G for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 08:15:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by silver.osuosl.org (Postfix) with ESMTPS id 096082041D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 08:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=uMnsJWGnn/nFfa6VeGd0dp8M4eB4NXe4aAT+p9Z7jQU=; b=cNfCC3/8l7kAjcB3Ine/8IO+qO
 euv1IG6OasKoYWOIraty2tztaAvY6nVmWlcOSyz4ppLdfFxd5ccybT9I2r9w73Yl1O7D6aDpUVN07
 yM7bAPX4cI6ydO3Ot1sDzTtU/FQQ5Q0wawnW91NATGzw4NkbLO/+DvsT2nHt7lAeWuKGJz3KzT+0Z
 NDHdv+5PB7jTv647zBtWOkWMkZRlvTNWdhY6O94pMi55/zXyi5D5MrTG9e5mxfXA41nugMmBGF+qS
 lrvKD6tAq8XPJ/pH02ibFXfE3v7EJ8p5r326XssUFtynYxOvBj6qlKkHWhgLn7cJvJ0pGtSpzrkdp
 f4XZsQkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jOGii-0005li-3U; Tue, 14 Apr 2020 08:15:00 +0000
Date: Tue, 14 Apr 2020 01:15:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200414081500.GB7315@infradead.org>
References: <20200327074702.GA27959@infradead.org>
 <20200327165335.397f24a3@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
 <20200330090746.23c5599c@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
 <20200331085444.44bee0bb@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803AFF@SHSMSX104.ccr.corp.intel.com>
 <20200402113604.6eea1e6f@jacob-builder>
 <20200413134157.395981a6@jacob-builder>
 <20200413162129.313b3b5a@w520.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200413162129.313b3b5a@w520.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Mon, Apr 13, 2020 at 04:21:29PM -0600, Alex Williamson wrote:
> Is the objection to a global version or to any version fields?  I don't
> really understand the global version, I'd think a mechanism to check
> extensions plus a per structure flags/version would be preferred.  The
> former should resolve how userspace can test support for features
> requiring multiple interfaces.  A global version also implies that
> we're only ever adding features and never removing.  For example,
> feature Foo is added in version 4, but it's replaced by feature Bar in
> version 5, now userspace can't simply test version >= 4 must include
> feature Foo.

The objection is to versions vs the much more sensible struct size +
capability flags.  Making it global just increases the problems with
a version for all of the above reasons.

> It seems to me that version and flags can also be complimentary, for
> example a field might be defined by a version but a flag could indicate
> if it's implemented.  With only the flag, we'd infer the field from the
> flag, with only the version we'd need to assume the field is always
> implemented.  So I have a hard time making a blanket statement that all
> versions fields should be avoided.

s/version/struct size/, but otherwise agreed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
