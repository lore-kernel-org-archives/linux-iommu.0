Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD6AC43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 13:02:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6612082D
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 13:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6612082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBD6087694;
	Fri, 27 Mar 2020 13:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CVBI_BjQd5td; Fri, 27 Mar 2020 13:02:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3985587569;
	Fri, 27 Mar 2020 13:02:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B2D1C18DA;
	Fri, 27 Mar 2020 13:02:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEEDDC0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 13:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C5770887A7
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 13:02:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sRBKa-ZtS7s4 for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 13:02:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AD22A8878F
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 13:02:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id 1294B297E16
Message-ID: <9e863f96cd9a188db84ae8bc5a0d49287b4b4922.camel@collabora.com>
Subject: Re: [PATCH] iommu: Lower severity of add/remove device messages
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Fri, 27 Mar 2020 10:02:11 -0300
In-Reply-To: <20200327095029.GB11538@8bytes.org>
References: <20200323214956.30165-1-ezequiel@collabora.com>
 <20200327095029.GB11538@8bytes.org>
Organization: Collabora
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org
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

Hello Joerg,

Thanks for reviewing.

I understand this change bears some controversy
for IOMMU, as developers are probably used to see these
messages.

On Fri, 2020-03-27 at 10:50 +0100, Joerg Roedel wrote:
> On Mon, Mar 23, 2020 at 06:49:56PM -0300, Ezequiel Garcia wrote:
> > These user messages are not really informational,
> > but mostly of debug nature. Lower their severity.
> 
> Like most other messages in the kernel log, that is not a reason to
> lower the severity.
>
> These messages are the first thing to look at when
> looking into IOMMU related issues.
> 

Sure, but the messages are still here, you can
always enable them when you are looking at IOMMU issues :-)

The idea is to reduce the amount of verbosity in the kernel.

If all subsystems would print messages that are useful
when looking at issues, things would be quite nasty verbose.

Thanks!
Ezequiel

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
