Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB97C8300F
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 08:55:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DB124654
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 08:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbwSXtuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DB124654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CEB6786D1C;
	Thu, 19 Nov 2020 08:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vfLtSL+F4OXz; Thu, 19 Nov 2020 08:55:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4B77F86CE2;
	Thu, 19 Nov 2020 08:55:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C0E9C1825;
	Thu, 19 Nov 2020 08:55:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3401EC0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 08:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 302C886CE7
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 08:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ClT9QekiJsnO for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 08:55:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AEB2186CE2
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 08:55:35 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D1D8E24655;
 Thu, 19 Nov 2020 08:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605776135;
 bh=37UHjWd1EyNrZdnPdz2fj2YTPg1mgy6U5NFaw+wtvfk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lbwSXtuSAfpQPjPEEzR57puxGHtmKJWiGf975TrtuJROHsC1AGWzBaidaZbWtIfEU
 ELALfje4CTiSV39yyCzf/KYbRoNtxkNPjpTX0MGxvQqbRubgqLRoVgiAAN5yk6Ftke
 quPOyUYjHRIAZ5DKl6KLftwlXDmh2B5liaAR+lxc=
Date: Thu, 19 Nov 2020 08:55:30 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [Patch V8 3/3] iommu: Document usage of
 "/sys/kernel/iommu_groups/<grp_id>/type" file
Message-ID: <20201119085529.GB3599@willie-the-truck>
References: <20200925190620.18732-1-ashok.raj@intel.com>
 <20200925190620.18732-4-ashok.raj@intel.com>
 <20201118135137.GA2177@willie-the-truck>
 <7eeae289-070f-c5c9-aff5-edbb8437ef69@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7eeae289-070f-c5c9-aff5-edbb8437ef69@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Ashok Raj <ashok.raj@intel.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Lu,

On Thu, Nov 19, 2020 at 10:32:43AM +0800, Lu Baolu wrote:
> On 11/18/20 9:51 PM, Will Deacon wrote:
> > On Fri, Sep 25, 2020 at 12:06:20PM -0700, Ashok Raj wrote:
> > I can't figure out from this description what string is returned to
> > userspace in the case that the group is configured as  blocked or unmanaged.
> 
> This series only enables switching a default domain in use between DMA
> and IDENTITY. Other cases will result in write failures.

I understood that from the text, but what I couldn't figure out is what
happens if you *read* the file when the default domain is not identity
or DMA. I think that should be documented.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
