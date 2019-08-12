Return-Path: <SRS0=NGNk=WI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674CC433FF
	for <iommu@archiver.kernel.org>; Mon, 12 Aug 2019 09:50:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354602087B
	for <iommu@archiver.kernel.org>; Mon, 12 Aug 2019 09:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354602087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0E526C7D;
	Mon, 12 Aug 2019 09:50:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E3626C7C
	for <iommu@lists.linux-foundation.org>;
	Mon, 12 Aug 2019 09:50:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7297987D
	for <iommu@lists.linux-foundation.org>;
	Mon, 12 Aug 2019 09:50:32 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 9F9FEAECA;
	Mon, 12 Aug 2019 09:50:30 +0000 (UTC)
Date: Mon, 12 Aug 2019 11:50:29 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Crash kernel with 256 MB reserved memory runs into OOM condition
Message-ID: <20190812095029.GE5117@dhcp22.suse.cz>
References: <d65e4a42-1962-78c6-1b5a-65cb70529d62@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d65e4a42-1962-78c6-1b5a-65cb70529d62@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-pci@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>,
	kexec@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, Donald Buczek <buczek@molgen.mpg.de>
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

On Mon 12-08-19 11:42:33, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Dell PowerEdge R7425 with two AMD EPYC 7601 (total 128 threads) and
> 1 TB RAM, the crash kernel with 256 MB of space reserved crashes.
> 
> Please find the messages of the normal and the crash kernel attached.

You will need more memory to reserve for the crash kernel because ...

> [    4.548703] Node 0 DMA free:484kB min:4kB low:4kB high:4kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:568kB managed:484kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    4.573612] lowmem_reserve[]: 0 125 125 125
> [    4.577799] Node 0 DMA32 free:1404kB min:1428kB low:1784kB high:2140kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:15720kB writepending:0kB present:261560kB managed:133752kB mlocked:0kB kernel_stack:2496kB pagetables:0kB bounce:0kB free_pcp:212kB local_pcp:212kB free_cma:0kB

... the memory is really depleted and nothing to be reclaimed (no anon.
file pages) Look how tht free memory is below min watermark (node zone DMA has
lowmem protection for GFP_KERNEL allocation).

[...]
> [    4.923156] Out of memory and no killable processes...

and there is no task existing to be killed so we go and panic.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
