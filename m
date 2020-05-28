Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BBEC433E2
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 07:33:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A712088E
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 07:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A712088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 940DD87E6A;
	Thu, 28 May 2020 07:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9LhVU1R-4Q6; Thu, 28 May 2020 07:33:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E6B9D86657;
	Thu, 28 May 2020 07:33:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5D55C07FF;
	Thu, 28 May 2020 07:33:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08B44C016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E3AA987E34
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 84dl4iqNdm2W for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 07:33:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B4FF186657
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:33:47 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B776F327; Thu, 28 May 2020 09:33:45 +0200 (CEST)
Date: Thu, 28 May 2020 09:33:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200528073344.GO5221@8bytes.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
 <20200527181842.GA256680@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200527181842.GA256680@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kenneth-lee-2012@foxmail.com, linux-acpi@vger.kernel.org,
 linux-crypto@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
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

On Wed, May 27, 2020 at 01:18:42PM -0500, Bjorn Helgaas wrote:
> Is this slowdown significant?  We already iterate over every device
> when applying PCI_FIXUP_FINAL quirks, so if we used the existing
> PCI_FIXUP_FINAL, we wouldn't be adding a new loop.  We would only be
> adding two more iterations to the loop in pci_do_fixups() that tries
> to match quirks against the current device.  I doubt that would be a
> measurable slowdown.

I don't know how significant it is, but I remember people complaining
about adding new PCI quirks because it takes too long for them to run
them all. That was in the discussion about the quirk disabling ATS on
AMD Stoney systems.

So it probably depends on how many PCI devices are in the system whether
it causes any measureable slowdown.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
