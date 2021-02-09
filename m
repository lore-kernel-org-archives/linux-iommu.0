Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1423C433E6
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 10:57:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EB964E30
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 10:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EB964E30
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bfs.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F830861A1;
	Tue,  9 Feb 2021 10:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KTswBgdi-ptn; Tue,  9 Feb 2021 10:57:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E68218618F;
	Tue,  9 Feb 2021 10:57:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D892CC0174;
	Tue,  9 Feb 2021 10:57:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26EB4C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 10:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2232B86191
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 10:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id noRw5ad0Jza3 for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 10:57:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01-sz.bfs.de (mx01-sz.bfs.de [194.94.69.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C62538618F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 10:57:36 +0000 (UTC)
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
 by mx01-sz.bfs.de (Postfix) with ESMTPS id DABFE2076E;
 Tue,  9 Feb 2021 11:57:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901; 
 t=1612868252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1DfsCqs88iiQXx9DWuj57ZejBv/iB8OwGlMzxeON1g=;
 b=L+XB+9cKSQKPGfxZSR9SZuyPfdtlbofqolBjxsYSYkQtzW0FtR5MScz8D3qZ3c2xRn/0sV
 +Ej7sWzVqYbx+Qc/bHWjYvIKEozDvX6Sm9kIQ1u43f/Noc2sATXR09ggbiSnDsZ8EADFm+
 Tcn5Rsec2RYzMpPYc1gduwH6C5LyRb9PowHLp26kqTTv49t2ACE3UoyB/PdljEC6QevGff
 FxT5qN+DSAtEwUfgWW+IKU7eiE/GWXik59pkL0zsEazLhb+2dyWpkKlxlTPKHusnOu/1CZ
 3MZQFWfi+SWgvmG6Mv75oKtr4QHuocgfg+6B8zCkbTZf6ENFBVHyP1AKVZhLyg==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.2; Tue, 9 Feb 2021
 11:57:32 +0100
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%13]) with mapi id
 15.01.2176.002; Tue, 9 Feb 2021 11:57:32 +0100
From: Walter Harms <wharms@bfs.de>
To: Dan Carpenter <dan.carpenter@oracle.com>, Will Deacon <will@kernel.org>
Subject: AW: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison with
 less than zero
Thread-Topic: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison with
 less than zero
Thread-Index: AQHW+jVw6vQF7iLM7kGMzk6JKLJ0oqpHqk8AgAfZ0YCAACsEgg==
Date: Tue, 9 Feb 2021 10:57:32 +0000
Message-ID: <c6b3b6beeb1e439f881bc3ff4d39f27a@bfs.de>
References: <20210203135936.23016-1-colin.king@canonical.com>
 <20210204092558.GA20244@willie-the-truck>,<20210209091923.GO2696@kadam>
In-Reply-To: <20210209091923.GO2696@kadam>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
x-tm-as-product-ver: SMEX-14.0.0.3080-8.6.1012-25962.007
x-tm-as-result: No-10--7.431600-5.000000
x-tmase-matchedrid: qqoVTVjx6YDRubRCcrbc5grcxrzwsv5u3dCmvEa6IiHgYNP0+4v1nizy
 bVqWyY2NjrJzIoPQuMw+otRoIV3vSHVgBjkrax/H52zh+cq/0JuQBbTqDF++CmOMyb1Ixq8VUDG
 dbyXu/ma30GP8pin5GSKkzMT7+4ooN9rojbjxBkzXA3LnlKuVLMqFE6gRdROb+nlefiwGml8hlG
 9iTcYtaqNIXC+Evb2D1qIE4CfpJ4zBm5Pnp+5TT/SG/+sPtZVkJih/yo+OvlXk6Qbi+9i6D0MmJ
 6dGmSIy2JDeaNwtlNBVVkf0bJfBjyxppiUy9o4cGjzBgnFZvQ4vV5f7P0HVDETqq9Xa45y5XJvT
 MgAKYypb2hQcAFTn3WnsfYyMrTTf6Ne/nacGH0HM0ihsfYPMYdFTR6mnbN4LvGAx/1ATZ5sJetz
 2R9zIsefqkkwronku/Sj/WnCM/LO/WXZS/HqJ2gtuKBGekqUpbGVEmIfjf3vt19sHZWTQhkfEDy
 E6wbBxQsEUiq7rfWGPfhLI9kH4wx7PLpUeWnT+
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--7.431600-5.000000
x-tmase-version: SMEX-14.0.0.3080-8.6.1012-25962.007
x-tm-snts-smtp: 8C502E7B3B6532B6AC707D8C4AE56DFF89CE4B2F07035BEC56FE6C2324B7857A2000:9
MIME-Version: 1.0
X-Spamd-Result: default: False [0.82 / 7.00]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; HAS_XOIP(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[bfs.de:s=dkim201901];
 BAYES_HAM(-0.68)[83.00%]; RCPT_COUNT_TWELVE(0.00)[14];
 NEURAL_HAM(-0.00)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[canonical.com,8bytes.org,gmail.com,mediatek.com,chromium.org,lists.linux-foundation.org,lists.infradead.org,vger.kernel.org];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: mx01-sz.bfs.de;
	none
Cc: Anan sun <anan.sun@mediatek.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Chao Hao <chao.hao@mediatek.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Colin King <colin.king@canonical.com>
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

I second that ...

Having i unsigned violates the rule of "least surprise".
If you need it unsigned make it clearly visible, also adding
a simple comment may help.

jm2c,
 wh
________________________________________
Von: Dan Carpenter <dan.carpenter@oracle.com>
Gesendet: Dienstag, 9. Februar 2021 10:19:23
An: Will Deacon
Cc: Colin King; Joerg Roedel; Matthias Brugger; Anan sun; Yong Wu; Chao Hao; Tomasz Figa; iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org; linux-mediatek@lists.infradead.org; kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
Betreff: Re: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison with less than zero

On Thu, Feb 04, 2021 at 09:25:58AM +0000, Will Deacon wrote:
> On Wed, Feb 03, 2021 at 01:59:36PM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently the check for domid < 0 is always false because domid
> > is unsigned.  Fix this by making it signed.
> >
> > Addresses-CoverityL ("Unsigned comparison against 0")
>
> Typo here ('L' instead of ':')
>
> > Fixes: ab1d5281a62b ("iommu/mediatek: Add iova reserved function")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 0ad14a7604b1..823d719945b2 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -640,7 +640,7 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
> >                                    struct list_head *head)
> >  {
> >     struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
> > -   unsigned int domid = mtk_iommu_get_domain_id(dev, data->plat_data), i;
> > +   int domid = mtk_iommu_get_domain_id(dev, data->plat_data), i;
>
> Not sure if it's intentional, but this also makes 'i' signed. It probably
> should remain 'unsigned' to match 'iova_region_nr' in
> 'struct mtk_iommu_plat_data'.


iova_region_nr is either 1 or 5 so unsigned doesn't matter.

I once almost introduced a bug where the iterator was supposed to be
size_t.  I fixed a bug by making it signed but I ended up introducing a
new bug.  But generally that's pretty rare.  The more common case is
that making iterators unsigned introduces bugs.

It's better to default to "int i;" and if more complicated types are
required that should stand out.  "size_t pg_idx;" or whatever.

regards,
dan carpenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
