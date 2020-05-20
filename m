Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A6BC433E3
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 12:59:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA39B207D4
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 12:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQv/vo1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA39B207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B3A6F23B44;
	Wed, 20 May 2020 12:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SwbqvzQ+8Gnl; Wed, 20 May 2020 12:59:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 921F5204C8;
	Wed, 20 May 2020 12:59:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83ABDC088A;
	Wed, 20 May 2020 12:59:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 869E7C0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7CF5C8569B
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:59:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DiqkQX4A1a8A for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 12:59:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D5E348543A
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:59:21 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 428642070A;
 Wed, 20 May 2020 12:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589979561;
 bh=UY6bhyA1qIT24OzeirfJ2m2V4bIa7vSuhBxipVcxHSg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PQv/vo1vuOh5BN49oSfeBhlvcbtDT/i2W10QY5VDIAdRGhoXfpN3/Z/QUeozn5SD+
 rzEi1mftpME8HSrsWYMdBHtO+ywFV0pA1oQallMrYtkq4UKSLTdC9feue1eJt4ywVs
 qENI/Bjv+xJ6dqkzZxsfk4v9OQqOwLRmWnay1Niw=
Date: Wed, 20 May 2020 13:59:17 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] iomm/arm-smmu: Add stall implementation hook
Message-ID: <20200520125916.GE25815@willie-the-truck>
References: <b491e02ad790a437115fdeab6b21bc48@codeaurora.org>
 <1ced023b-157c-21a0-ac75-1adef7f029f0@arm.com>
 <20200507125357.GA31783@willie-the-truck>
 <CAF6AEGuLU+_qP8HNO1s9PTPHqJnCMHzehmcT8NiJhiAwrfSH6w@mail.gmail.com>
 <CAF6AEGvuHKObTR97XdSXjmjKB+qjQ8N1_wxM=ZU8bEkF=cXp-A@mail.gmail.com>
 <20200511173008.GA24282@jcrouse1-lnx.qualcomm.com>
 <20200518154522.GN32394@willie-the-truck>
 <5a0ad639e272026c8be57393937cda22@codeaurora.org>
 <CAF6AEGuzBtj+srindmOvhaom5BdS2adLaOF=v_MtguMja14V2w@mail.gmail.com>
 <a801e79a0a75092c28a6646ae7fa5e36@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a801e79a0a75092c28a6646ae7fa5e36@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, "list@263.net:IOMMU DRIVERS ,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Wed, May 20, 2020 at 03:02:45PM +0530, Sai Prakash Ranjan wrote:
> On 2020-05-19 20:41, Rob Clark wrote:
> > On Tue, May 19, 2020 at 2:26 AM Sai Prakash Ranjan
> > <saiprakash.ranjan@codeaurora.org> wrote:
> > > On 2020-05-18 21:15, Will Deacon wrote:
> > > > So this sounds like an erratum to me, and I'm happy to set HUPCF if we
> > > > detect the broken implementation. However, it will need an entry in
> > > > Documentation/arm64/silicon-errata.rst and a decent comment in the
> > > > driver
> > > > to explain what we're doing and why.
> > > >
> > > 
> > > AFAIK there is no erratum documented internally for this behaviour and
> > > this
> > > exists from MSM8996 SoC time and errata usually don't survive this
> > > long
> > > across generation of SoCs and there is no point for us in disguising
> > > it.
> > 
> > possibly longer, qcom_iommu sets CFCFG..
> > 
> 
> Oh right, I was still in college when those SoCs were released ;)
> 
> > > Is it OK if we clearly mention it as the "design limitation" or some
> > > other
> > > term which we can agree upon along with the description which Rob and
> > > Jordan
> > > provided for setting HUPCF in the driver when we add the set_hupcf
> > > callback?
> > 
> > I'm not too picky on what we call it, but afaict it has been this way
> > since the beginning of time, rather than specific to a certain SoC or
> > generation of SoCs.  So it doesn't seem like the hw designers consider
> > it a bug.
> > 
> > (I'm not sure what the expected behavior is.. nor if any other SMMU
> > implementation encounters this sort of situation..)
> 
> Yes, that was my point as well that its probably not counted as a bug
> by the hw designers. So I'm going to post setting HUPCF on QCOM
> implementation with clear comments based on yours and Jordan's description
> of this problem, but I wanted to have a way to set this only for GPU context
> bank and not GMU as Jordan mentioned earlier that GMU doesnt need HUPCF set.
> I was checking as to how do we map cb to device, if it was possible then we
> can have
> a compatibility thing like we did for identity mapping. Any ideas Robin?

Right, see my reply over at:

https://lore.kernel.org/r/20200520125700.GD25815@willie-the-truck

Hopefully something like that can be made to work.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
