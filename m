Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABEBECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 12:40:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0FA205F4
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 12:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0FA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 13571B8A;
	Tue, 15 Oct 2019 12:40:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5EF7AB49
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 12:40:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A295F6D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 12:40:13 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id DB4B72DF; Tue, 15 Oct 2019 14:40:11 +0200 (CEST)
Date: Tue, 15 Oct 2019 14:40:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: AngeloGioacchino Del Regno <kholk11@gmail.com>
Subject: Re: [PATCH v4 1/7] firmware: qcom: scm: Add function to set IOMMU
	pagetable addressing
Message-ID: <20191015124008.GB17570@8bytes.org>
References: <20191001220205.6423-1-kholk11@gmail.com>
	<20191001220205.6423-2-kholk11@gmail.com>
	<20191015111454.GG14518@8bytes.org>
	<CAK7fi1YZXW=mqC5HWtfBWsioAq-duejAk6RgtD8npKZR=af38w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK7fi1YZXW=mqC5HWtfBWsioAq-duejAk6RgtD8npKZR=af38w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: MSM <linux-arm-msm@vger.kernel.org>, iommu@lists.linux-foundation.org,
	Andy Gross <agross@kernel.org>, marijns95@gmail.com
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

On Tue, Oct 15, 2019 at 02:33:47PM +0200, AngeloGioacchino Del Regno wrote:
> Il giorno mar 15 ott 2019 alle ore 13:14 Joerg Roedel
> <joro@8bytes.org> ha scritto:
> >
> > On Wed, Oct 02, 2019 at 12:01:59AM +0200, kholk11@gmail.com wrote:
> > > From: "Angelo G. Del Regno" <kholk11@gmail.com>
> > >
> > > Add a function to change the IOMMU pagetable addressing to
> > > AArch32 LPAE or AArch64. If doing that, then this must be
> > > done for each IOMMU context (not necessarily at the same time).
> >
> > This patch lacks a Signed-off-by.
> >
> 
> I'm sorry for that. Should I resend or is it enough for me to write it here?
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>

Please resend, but you are free to wait for the reviews/acks from Rob
Clark, which I'd like to see on the series.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
