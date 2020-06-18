Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9781CC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 07:12:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AD521532
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 07:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bdT4Jipg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AD521532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E5B9688543;
	Thu, 18 Jun 2020 07:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ik3352fVVKka; Thu, 18 Jun 2020 07:12:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4CAA0884E1;
	Thu, 18 Jun 2020 07:12:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B552C0863;
	Thu, 18 Jun 2020 07:12:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF4E6C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 07:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C6B968536C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 07:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZseM0hhGko91 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 07:12:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 905758392B
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 07:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=fOQMFX0QqLMTbV6VegdwBRvYgy6RQf+xn1lfJSvvlA8=; b=bdT4JipgnI08pFeV28vEL5pwh3
 aeUMEBhHWrawbflbmfy53u1UsZZp/tQz3aCqNUdBdqJhyKXdXHx98w4s3PnETcR6ExGhJFakiGhFP
 P2Lw9ScRH9Fo+fIgPjKjS1IqE3P7F7WRRKDmEKHloIs56H2A3DrhHndw9u2JmYSIitqzCDxe+vfJa
 HQFNxoqz2X1bfWSuTTmyqqtRMLIV8fE0LFBLXunJupzuBaTFsblnfVzW4OpVkxelkjVX6/KSIg7FZ
 ME37a1Be3X8DZuWlFzvKVrY8WQgJecfbq5KKG4ey53hcKpjNDyXBE5jkXxeeXm9xPzFp5DRl9FpwP
 5wqIuoSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jloiU-0002mN-Nu; Thu, 18 Jun 2020 07:12:06 +0000
Date: Thu, 18 Jun 2020 00:12:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v3 01/13] iommu: Change type of pasid to unsigned int
Message-ID: <20200618071206.GA7294@infradead.org>
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
 <1592418233-17762-2-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592418233-17762-2-git-send-email-fenghua.yu@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Tony Luck <tony.luck@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Christoph Hellwig <hch@infradeed.org>, Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Jun 17, 2020 at 11:23:41AM -0700, Fenghua Yu wrote:
> PASID is defined as a few different types in iommu including "int",
> "u32", and "unsigned int". To be consistent and to match with ioasid's
> type, define PASID and its variations (e.g. max PASID) as "unsigned int".

Wouldn't u32 be a little more explicit (besides being shorter and
matching the uapi definitions)?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
