Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061A6C56201
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 21:43:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745CC2083E
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 21:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2o5Kf7D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745CC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EEE3F228A0;
	Tue, 24 Nov 2020 21:43:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id beNdCU1gIb45; Tue, 24 Nov 2020 21:43:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B2B21227AA;
	Tue, 24 Nov 2020 21:43:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FD8DC163C;
	Tue, 24 Nov 2020 21:43:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACD5BC0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A05C987342
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J06daDXpt9GC for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:43:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 42C6787002
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:43:39 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 59B54206E5;
 Tue, 24 Nov 2020 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606254218;
 bh=i6hbvXSQGJaCxcemC8oeN03qQ1XDrz8RB9bbPy6ICHk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2o5Kf7D1A5gTiV8Nhz1O+8BEQi/wWC34FzTS5PI3TQQZffxbXmWetS43a7L52YofA
 KWSYuuapjz1kmlStNLltWbt79U8cNM/VUtLsX7fa9Zj5pHGuEU8z8L2GSmtyFijpKM
 mFULM7VSP0LZjXlRQml8/M2XHFMwVBmMHN4lmqng=
Date: Tue, 24 Nov 2020 21:43:33 +0000
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCHv8 0/8] System Cache support for GPU and required SMMU
 support
Message-ID: <20201124214332.GC14252@willie-the-truck>
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <20201123152146.GE11033@willie-the-truck>
 <50b68f2bdf9413b896fbe816ba4ddbc9@codeaurora.org>
 <CAF6AEGse=WBAC1WbTi6aD5_m1_NBg91f=veYm-7V=Uds7NA0Lw@mail.gmail.com>
 <1c665e33d1d27263fb5056c16d30b827@codeaurora.org>
 <20201124111027.GA13151@willie-the-truck>
 <CAF6AEGuZ2YbY=ATFBX1KJw=LwhcpH8n+zzxckTHPwwopi6mOqw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGuZ2YbY=ATFBX1KJw=LwhcpH8n+zzxckTHPwwopi6mOqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Robin Murphy <robin.murphy@arm.com>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS , Joerg Roedel <joro@8bytes.org>,
 " <iommu@lists.linux-foundation.org>,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Dave Airlie <airlied@gmail.com>,
 freedreno <freedreno@lists.freedesktop.org>,
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

On Tue, Nov 24, 2020 at 11:05:39AM -0800, Rob Clark wrote:
> On Tue, Nov 24, 2020 at 3:10 AM Will Deacon <will@kernel.org> wrote:
> > On Tue, Nov 24, 2020 at 09:32:54AM +0530, Sai Prakash Ranjan wrote:
> > > On 2020-11-24 00:52, Rob Clark wrote:
> > > > On Mon, Nov 23, 2020 at 9:01 AM Sai Prakash Ranjan
> > > > <saiprakash.ranjan@codeaurora.org> wrote:
> > > > > On 2020-11-23 20:51, Will Deacon wrote:
> > > > > > Modulo some minor comments I've made, this looks good to me. What is
> > > > > > the
> > > > > > plan for merging it? I can take the IOMMU parts, but patches 4-6 touch
> > > > > > the
> > > > > > MSM GPU driver and I'd like to avoid conflicts with that.
> > > > > >
> > > > >
> > > > > SMMU bits are pretty much independent and GPU relies on the domain
> > > > > attribute
> > > > > and the quirk exposed, so as long as SMMU changes go in first it
> > > > > should
> > > > > be good.
> > > > > Rob?
> > > >
> > > > I suppose one option would be to split out the patch that adds the
> > > > attribute into it's own patch, and merge that both thru drm and iommu?
> > > >
> > >
> > > Ok I can split out domain attr and quirk into its own patch if Will is
> > > fine with that approach.
> >
> > Why don't I just queue the first two patches on their own branch and we
> > both pull that?
> 
> Ok, that works for me.  I normally base msm-next on -rc1 but I guess
> as long as we base the branch on the older or our two -next branches,
> that should work out nicely

Turns out we're getting a v10 of Sai's stuff, so I've asked him to split
patch two up anyway. Then I'll make a branch based on -rc1 that we can
both pull.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
