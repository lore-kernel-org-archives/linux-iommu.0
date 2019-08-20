Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E71C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 10:31:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B87922CF9
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 10:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIoIm7Db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B87922CF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C21A5D3D;
	Tue, 20 Aug 2019 10:31:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3920BD36
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 10:31:20 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EE41E89B
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 10:31:19 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id ADDD422CF4;
	Tue, 20 Aug 2019 10:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566297079;
	bh=4BGIRfpdxn+C4hWqH87mAKMqnUtkkvEwwMwmi3ha0Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIoIm7Dblia20ly5df5KEgLyPX9cMYqKbtR+dcf8m13dvUFZd+rD2XNAI9PF0uISf
	tNgmIHr/tUheptTGLanF0PONmSDlW3lN/bUkaHdR1wcQf5f5ib2LE1OPAFGAITycQM
	EonGx+kruT5WbB6IbRA+dD+UXF+t2syBwXuuuhhs=
Date: Tue, 20 Aug 2019 11:31:16 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] iommu/io-pgtable-arm: Rationalise TCR handling
Message-ID: <20190820103115.o7neehdethf7sbqi@willie-the-truck>
References: <cover.1566238530.git.robin.murphy@arm.com>
	<78df4f8e2510e88f3ded59eb385f79b4442ed4f2.1566238530.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <78df4f8e2510e88f3ded59eb385f79b4442ed4f2.1566238530.git.robin.murphy@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Aug 19, 2019 at 07:19:30PM +0100, Robin Murphy wrote:
> Although it's conceptually nice for the io_pgtable_cfg to provide a
> standard VMSA TCR value, the reality is that no VMSA-compliant IOMMU
> looks exactly like an Arm CPU, and they all have various other TCR
> controls which io-pgtable can't be expected to understand. Thus since
> there is an expectation that drivers will have to add to the given TCR
> value anyway, let's strip it down to just the essentials that are
> directly relevant to io-pgatble's inner workings - namely the address
> sizes, walk attributes, and where appropriate, format selection.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c        | 7 +------
>  drivers/iommu/arm-smmu.c           | 1 +
>  drivers/iommu/arm-smmu.h           | 2 ++
>  drivers/iommu/io-pgtable-arm-v7s.c | 6 ++----
>  drivers/iommu/io-pgtable-arm.c     | 4 ----
>  drivers/iommu/qcom_iommu.c         | 2 +-
>  6 files changed, 7 insertions(+), 15 deletions(-)

Hmm, so I'm a bit nervous about this one since I think we really should
be providing a TCR with EPD1 set if we're only giving you TTBR0. Relying
on the driver to do this worries me. See my comments on the next patch.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
