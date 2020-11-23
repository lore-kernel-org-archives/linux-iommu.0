Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA8DC63697
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 14:56:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA6520773
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 14:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLvhjSzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA6520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D06E585608;
	Mon, 23 Nov 2020 14:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A9xMGD4eubb1; Mon, 23 Nov 2020 14:56:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 81F5C84C63;
	Mon, 23 Nov 2020 14:56:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D7E9C163C;
	Mon, 23 Nov 2020 14:56:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C99A6C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 14:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B4A3020009
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 14:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id axe-jcEYtcdX for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 14:56:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 51403204BE
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 14:56:11 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7620420658;
 Mon, 23 Nov 2020 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606143370;
 bh=XUm8OV+H1ot7qmV/No9ou5eqPJW8U55vgkCpuzquesU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XLvhjSzxb01JFT7bTsyemJ7VwGR2FQh0Nx3EVYr/RQNdLEZjSTfutOLl8yWkJJgCt
 UToUSkVFwohasfZMWNu27JglVMGGXy7IZMRv5AE5wbWHTia9HHBzGvPSErzFRQsnqF
 wuOwImNxJG+mc9eUYs8IbGnTbO+hjgsAOQRhDKb8=
Date: Mon, 23 Nov 2020 14:56:06 +0000
From: Will Deacon <will@kernel.org>
To: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Enforce 4k mapping for certain IOMMU data
 structures
Message-ID: <20201123145605.GA11033@willie-the-truck>
References: <20201105145832.3065-1-suravee.suthikulpanit@amd.com>
 <c189684a-27e5-c0c2-1629-063b9fb16957@amd.com>
 <35c6f7d8-f889-8c3c-2e01-1a9226babf0a@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <35c6f7d8-f889-8c3c-2e01-1a9226babf0a@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jon.Grimm@amd.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bp@suse.de
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

On Thu, Nov 19, 2020 at 10:19:01PM -0600, Brijesh Singh wrote:
> On 11/19/20 8:30 PM, Suravee Suthikulpanit wrote:
> > On 11/18/20 5:57 AM, Will Deacon wrote:
> > > I think I'm missing something here. set_memory_4k() will break the
> > kernel
> > > linear mapping up into page granular mappings, but the IOMMU isn't
> > using
> > > that mapping, right?
> >
> > That's correct. This does not affect the IOMMU, but it affects the PSP
> > FW.
> >
> > > It's just using the physical address returned by
> > iommu_virt_to_phys(), so why does it matter?
> > >
> > > Just be nice to capture some of this rationale in the log,
> > especially as
> > > I'm not familiar with this device.
> >
> > According to the AMD SEV-SNP white paper
> > (https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf),
> > the Reverse Map Table (RMP) contains one entry for every 4K page of
> > DRAM that may be used by the VM. In this case, the pages allocated by
> > the IOMMU driver are added as 4K entries in the RMP table by the
> > SEV-SNP FW.
> >
> > During the page table walk, the RMP checks if the page is owned by the
> > hypervisor. Without calling set_memory_4k() to break the mapping up
> > into 4K pages, pages could end up being part of large mapping (e.g. 2M
> > page), in which the page access would be denied and result in #PF.
> 
> 
> Since the page is added as a 4K page in the RMP table by the SEV-SNP FW,
> so we need to split the physmap to ensure that this page will be access
> with a 4K mapping from the x86. If the page is part of large page then
> write access will cause a RMP violation (i.e #PF), this is because SNP
> hardware enforce that the CPU page level walk must match with page-level
> programmed in the RMP table.

Got it; thanks.

> > >> Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion
> > wait write-back semaphore")
> > >
> > > I couldn't figure out how that commit could cause this problem.
> > Please can
> > > you explain that to me?
> >
> > Hope this helps clarify. If so, I'll update the commit log and send
> > out V3.

Cheers. No need for a v2, as I've queued this up with a Link: tag.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
