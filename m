Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434A2C2BA2B
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 12:04:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28A320753
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 12:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28A320753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=panix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AD05786B34;
	Thu,  9 Apr 2020 12:04:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KO1GKOSchtk1; Thu,  9 Apr 2020 12:04:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE6E986B47;
	Thu,  9 Apr 2020 12:04:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD5C4C089F;
	Thu,  9 Apr 2020 12:04:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7916BC0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 12:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 64C7A87B40
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 12:01:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XVvmQpdJQpLG for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 12:01:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2C6BE877E7
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 12:01:04 +0000 (UTC)
Received: from xps-7390 (ip68-111-223-64.sd.sd.cox.net [68.111.223.64])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 48yfqf5PPHz1Bs0;
 Thu,  9 Apr 2020 08:01:02 -0400 (EDT)
Date: Thu, 9 Apr 2020 05:01:01 -0700 (PDT)
From: "Kenneth R. Crudup" <kenny@panix.com>
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, 
 iommu@lists.linux-foundation.org
Subject: Re: "DMAR hardware is malfunctioning" error when powering off
In-Reply-To: <alpine.DEB.2.21.2004090407250.2968@xps-7390>
Message-ID: <alpine.DEB.2.21.2004090455530.2949@xps-7390>
References: <alpine.DEB.2.21.2004090407250.2968@xps-7390>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 09 Apr 2020 12:04:25 +0000
Cc: "Kenneth R. Crudup" <kenny@panix.com>
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
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


BTW, I normally don't run with "intel_iommu=on" (but I do have "CONFIG_IRQ_REMAP
turned on), as I figure that if I'm a single-user laptop and my only VM is
VMWare (running Win10 guests), and I only use my Thunderbolt ports for my own
docks, that I really don't need an IOMMU anyway- but is there a benefit to
having the IOMMU turned on (were it to work, that is) in my situation?

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
