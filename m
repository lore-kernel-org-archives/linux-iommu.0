Return-Path: <SRS0=b5RZ=T4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B82C04AB6
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 13:39:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA2A2054F
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 13:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA2A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 247011CED;
	Tue, 28 May 2019 13:39:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5025C1CD9
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 13:37:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D4FEF13A
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 13:37:45 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 285ADACD4;
	Tue, 28 May 2019 13:37:44 +0000 (UTC)
Date: Tue, 28 May 2019 15:37:42 +0200
From: "jroedel@suse.de" <jroedel@suse.de>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
Message-ID: <20190528133742.GA8151@suse.de>
References: <20190506041106.29167-1-cai@lca.pw>
	<ea379dc8-dd6b-f204-0abc-7b6fe87a851b@amd.com>
	<1557845746.6132.27.camel@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1557845746.6132.27.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Gary R Hook <ghook@amd.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, May 14, 2019 at 10:55:46AM -0400, Qian Cai wrote:
> Jroedel, I am wondering what the plan for 41e59a41fc5d1 (iommu tree) or this
> patch to be pushed to the linux-next or mainline...

Looks like I applied that patch directly to the master branch, which is
not what goes upstream. I cherry-picked it to x86/amd, so it will go
upstream for v5.3.


Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
