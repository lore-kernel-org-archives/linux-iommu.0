Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F6C433E1
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 17:41:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6C120734
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 17:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBS/XvI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6C120734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2FFD287DF3;
	Mon,  1 Jun 2020 17:41:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ftr5B8OQhAEo; Mon,  1 Jun 2020 17:41:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ADCEF87D8B;
	Mon,  1 Jun 2020 17:41:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F019C088C;
	Mon,  1 Jun 2020 17:41:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66E04C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 17:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 50C8B86439
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 17:41:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9RHyn+jmOaXE for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 17:41:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D9DE686429
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 17:41:06 +0000 (UTC)
Received: from localhost (mobile-166-175-190-200.mycingular.net
 [166.175.190.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 48FEF206A4;
 Mon,  1 Jun 2020 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591033266;
 bh=egFH6RgQ4a+4kLCfGrEDkjv5v4bJblqDQOjodPikqEM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=PBS/XvI5mPBJhMQPW3QR/267YghZh8VBNHFVIA3y76nvmv7wSAOnIG8ZofBmrwL3W
 hjX/e/kbh6hI/0SHMT/KsCJ3IYwK/78zwY6ZY8W6ZDDtNYI4kfbVVgq5NF84Mj/Dz5
 u9OiYWmcq6uvLgae6Udy20G6q8HsslAkBraLQcZo=
Date: Mon, 1 Jun 2020 12:41:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200601174104.GA734973@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200528073344.GO5221@8bytes.org>
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

On Thu, May 28, 2020 at 09:33:44AM +0200, Joerg Roedel wrote:
> On Wed, May 27, 2020 at 01:18:42PM -0500, Bjorn Helgaas wrote:
> > Is this slowdown significant?  We already iterate over every device
> > when applying PCI_FIXUP_FINAL quirks, so if we used the existing
> > PCI_FIXUP_FINAL, we wouldn't be adding a new loop.  We would only be
> > adding two more iterations to the loop in pci_do_fixups() that tries
> > to match quirks against the current device.  I doubt that would be a
> > measurable slowdown.
> 
> I don't know how significant it is, but I remember people complaining
> about adding new PCI quirks because it takes too long for them to run
> them all. That was in the discussion about the quirk disabling ATS on
> AMD Stoney systems.
> 
> So it probably depends on how many PCI devices are in the system whether
> it causes any measureable slowdown.

I found this [1] from Paul Menzel, which was a slowdown caused by
quirk_usb_early_handoff().  I think the real problem is individual
quirks that take a long time.

The PCI_FIXUP_IOMMU things we're talking about should be fast, and of
course, they're only run for matching devices anyway.  So I'd rather
keep them as PCI_FIXUP_FINAL than add a whole new phase.

Bjorn

[1] https://lore.kernel.org/linux-pci/b1533fd5-1fae-7256-9597-36d3d5de9d2a@molgen.mpg.de/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
