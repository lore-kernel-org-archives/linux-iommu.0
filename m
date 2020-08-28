Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E7C433E2
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 10:29:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA16208FE
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 10:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zUNtDENk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA16208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F0A7386473;
	Fri, 28 Aug 2020 10:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9ZD6K4dhiad; Fri, 28 Aug 2020 10:29:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 673448639E;
	Fri, 28 Aug 2020 10:29:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42758C016F;
	Fri, 28 Aug 2020 10:29:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F56FC0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 10:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 95380883F0
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 10:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rfxLATNim8NB for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 10:29:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 85273883C0
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 10:29:32 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 11BCE2080C;
 Fri, 28 Aug 2020 10:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598610572;
 bh=OM0xDviExPMs25X2djcfNEdWDnV1PejufaV7fIDxStc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zUNtDENk4ICQ8nLWM16O2yclgqOzaKohnholRoFV5bpNLhnMucSqN7r68fxxZUXi0
 OJxHoK0mbSbxdpsVucJwPxRYKdUF/AaeMFVMkedUbEoFfz0Y8/5CgGchloDeiuGSrX
 Ryqe/7AuLbZdxTKaD+gXilydDho1fJi+m9JeTzaU=
Date: Fri, 28 Aug 2020 11:29:27 +0100
From: Will Deacon <will@kernel.org>
To: Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: add tracepoints for cmdq_issue_cmdlist
Message-ID: <20200828102927.GA30391@willie-the-truck>
References: <20200827093351.15244-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200827093351.15244-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
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

On Thu, Aug 27, 2020 at 09:33:51PM +1200, Barry Song wrote:
> cmdq_issue_cmdlist() is the hotspot that uses a lot of time. This patch
> adds tracepoints for it to help debug.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  * can furthermore develop an eBPF program to benchmark using this trace

Hmm, don't these things have a history of becoming ABI? If so, I don't
really want them in the driver at all, sorry. Do other drivers overcome
this somehow?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
