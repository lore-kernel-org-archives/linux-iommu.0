Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CC9C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 08:41:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DFB64F68
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 08:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DFB64F68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 87D0184F76;
	Wed,  3 Feb 2021 08:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mzaEjZvSPoHl; Wed,  3 Feb 2021 08:41:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9226A81D5F;
	Wed,  3 Feb 2021 08:41:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72678C0174;
	Wed,  3 Feb 2021 08:41:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FB64C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EA98F2046A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t-NQe2ffOsHO for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 08:41:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id F3B332043C
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=m0J+u/j+uny4CEWAa03yCknMg8b0lzJj8IlB90UmRbQ=; b=Q7u/dXHa1/DQ0U/Lkpo1Tq6SSK
 QCaA+INY0ZIy4LWpqUddCz2I+dyNYlUYb4QtgdkjPwomlDcyVoTuWW+LZy1WBRYSIGOZdEm67pmKO
 KOw7uXDf5NkoHyI+f5MG2kmdAcWtgx5Dqi6wO5mV6d9ViomB+JDdDhATqlY0KLMz5fj+qXkpCuY5z
 LqWwERsqBvXPhvJIg1bWf0WNdwjTgV6jZ8bhCCPiaPg4MLZ1DjtVgXk2A3+y7uNyURN1dgW1oacik
 /j3XIqezFFCdZoUjAyPhyVwqueIDuuegeoASE32zG94oqyV81ips9qTDJbDRoeUGLYWo8yu0CGbQj
 V1W/fmvQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1l7Dj6-00GSI9-6E; Wed, 03 Feb 2021 08:41:28 +0000
Date: Wed, 3 Feb 2021 08:41:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/3] iommu/vt-d: Add support for ACPI/SATC table
Message-ID: <20210203084128.GA3916610@infradead.org>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202044057.615277-1-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Ashok Raj <ashok.raj@intel.com>
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

On Tue, Feb 02, 2021 at 12:40:54PM +0800, Lu Baolu wrote:
> Intel platform VT-d (v3.2) comes with a new type of DMAR subtable
> SATC. The SATC table includes a list of SoC integrated devices
> that require SATC. OS software can use this table to enable ATS
> only for the devices in the list.

This all sounds like gibberish. Please expand and if necessary explain
acronyms when first used in each commit log / cover letter.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
