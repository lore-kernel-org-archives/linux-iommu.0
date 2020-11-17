Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB34EC2D0E4
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 22:41:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2777720738
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 22:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS3dCUKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2777720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8912D203EE;
	Tue, 17 Nov 2020 22:41:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RSlfMMRzyOCb; Tue, 17 Nov 2020 22:41:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 69F9C203AB;
	Tue, 17 Nov 2020 22:41:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44DD0C0891;
	Tue, 17 Nov 2020 22:41:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4AE1C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B79F4856F6
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:41:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r0K+PwHG31IE for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 22:41:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7F9948568D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:41:07 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0787720709;
 Tue, 17 Nov 2020 22:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605652866;
 bh=aesflSSYIio9RUvTzHtgIgEoBgRRVoXJ8Ijz+a/sfyI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uS3dCUKL6WFxURM7zFODhozxOOvUIRtS5/nhXQgMIIRf00VUQ+S2X+GvIrcTVSiNf
 tsRxeURBO1Q2jzx7d7dPMBxKja0S1W9Am/ZpO07cm3BAMZlZBvCfQ9S1TRLVRBgHum
 53Aa+N9+/selE+q+CxLJsVann3TpX5J16I2ODveI=
Date: Tue, 17 Nov 2020 22:41:02 +0000
From: Will Deacon <will@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH] iommu: fix return error code in iommu_probe_device()
Message-ID: <20201117224102.GD524@willie-the-truck>
References: <20201117025238.3425422-1-yangyingliang@huawei.com>
 <835ab066-b6b8-a211-4941-c01781031de8@linux.intel.com>
 <454f5e3e-c380-e8a5-9283-3f7578eb601e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <454f5e3e-c380-e8a5-9283-3f7578eb601e@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Nov 17, 2020 at 07:11:28PM +0800, Yang Yingliang wrote:
> On 2020/11/17 17:40, Lu Baolu wrote:
> > On 2020/11/17 10:52, Yang Yingliang wrote:
> > > If iommu_group_get() failed, it need return error code
> > > in iommu_probe_device().
> > > =

> > > Fixes: cf193888bfbd ("iommu: Move new probe_device path...")
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > > =A0 drivers/iommu/iommu.c | 4 +++-
> > > =A0 1 file changed, 3 insertions(+), 1 deletion(-)
> > > =

> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index b53446bb8c6b..6f4a32df90f6 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -253,8 +253,10 @@ int iommu_probe_device(struct device *dev)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto err_out;
> > > =A0 =A0=A0=A0=A0=A0 group =3D iommu_group_get(dev);
> > > -=A0=A0=A0 if (!group)
> > > +=A0=A0=A0 if (!group) {
> > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENODEV;
> > =

> > Can you please explain why you use -ENODEV here?
> =

> Before 79659190ee97 ("iommu: Don't take group reference in
> iommu_alloc_default_domain()"), in
> =

> iommu_alloc_default_domain(), if group is NULL, it will return -ENODEV.

Hmm. While I think the patch is ok, I'm not sure it qualifies as a fix.
Has iommu_probe_device() ever propagated this error? The commit you
identify in the 'Fixes:' tag doesn't seem to change this afaict.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
