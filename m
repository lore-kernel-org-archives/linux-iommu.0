Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFA2C31E4C
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 06:52:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3E020851
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 06:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3E020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BD3CAEF4;
	Fri, 14 Jun 2019 06:52:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4C7F6CE5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 06:52:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D3E26174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 06:52:31 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 14D0B68B05; Fri, 14 Jun 2019 08:52:03 +0200 (CEST)
Date: Fri, 14 Jun 2019 08:52:02 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Tan, Ley Foon" <ley.foon.tan@intel.com>
Subject: Re: switch nios2 and microblaze to use the generic uncached
	segement support
Message-ID: <20190614065202.GA8084@lst.de>
References: <20190603065324.9724-1-hch@lst.de>
	<1560476434.21652.1.camel@intel.com> <20190614054418.GA6722@lst.de>
	<1560492659.21652.3.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1560492659.21652.3.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "monstr@monstr.eu" <monstr@monstr.eu>,
	"lftan.linux@gmail.com" <lftan.linux@gmail.com>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"hch@lst.de" <hch@lst.de>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Jun 14, 2019 at 06:11:00AM +0000, Tan, Ley Foon wrote:
> On Fri, 2019-06-14 at 07:44 +0200, Christoph Hellwig wrote:
> > On Fri, Jun 14, 2019 at 09:40:34AM +0800, Ley Foon Tan wrote:
> > > =

> > > Hi=A0Christoph
> > > =

> > > Can this patch in=A0http://git.infradead.org/users/hch/dma-mapping.gi
> > > t/sh
> > > ortlog/refs/heads/for-next
> > > =

> > > [PATCH 1/2] nios2: use the generic uncached segment support in dma-
> > > direct
> > Hi Ley Foon,
> > =

> > I don't understand the above sentence.=A0=A0Does it imply a Reviewed-by?
> Sorry, typo in my previous email.=A0
> Can't find this patch in the git link you provided (for-next branch).
> Did you push the patch?

No, I did not push the microblaze and nios2 patches there.  The for-next
patch just has the baseline, you'll need to apply the nios2 on top of
that branch to test it.  If it tests good and you are fine with it I'd
like to apply it to that branch.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
