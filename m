Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2774C2D0CE
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 17:29:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A8F206A2
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 17:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaOY33YD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A8F206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 830BD85087;
	Tue, 21 Jan 2020 17:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iMeCu1a92LzG; Tue, 21 Jan 2020 17:29:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49CE084508;
	Tue, 21 Jan 2020 17:29:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ACDAC1D88;
	Tue, 21 Jan 2020 17:29:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5437C0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 17:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B3D6987877
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 17:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PHUiT5lQKPUv for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 17:29:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2B4F6877B3
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 17:29:24 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id p8so3634682oth.10
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yzVs5yU5e7GypYXTX5nkOgXJ+y1KuzZBRltNX7nsZX4=;
 b=jaOY33YDlWKCRJgGf+lLzK9u/rCvJjunPfvZAe96diwPbnrnlqJPsjMGhMj/ptM0vS
 g7InLquIbotFt9nrsxHpBzAhtbd172jgTuzlW/YIzDIjWx1gyFaoaL4+xxuxpvG+GpI9
 5X4LXQgurepHyWBogU1XuZrv5QLRcDgFTf2CcsBJII4h4I0k0GqL15dxSmb3Yowviwgo
 Gpfzc9XhdhHolXwOEzJE/H2jZiPa4ox9o3B8DAbz0Uitl/J+k4TpvOfscD2ULNwaB6O6
 E+3V7ODhyB92SdGmKwFo20u3P3ijHJMszYSl6M/6uJecf1v/Pp5CLEJ3SZEG6T5eD7kY
 YZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yzVs5yU5e7GypYXTX5nkOgXJ+y1KuzZBRltNX7nsZX4=;
 b=o/Wjy6v3cDY3Ir43IzBSOIQUHUM9TGp3GYBvgemmRP1vY3vPwKRG9xhy2c8KS/Ti+T
 WwbHiQhmCoPxl4nL43zimXen89qEnUiKX4aBoMeRVC0ND3EIQ/xi+MPC2NkY60QMT6vU
 PAPrLJvJLqjSw65Nk/0L6ciJdg6njjKaesv2WpAvynt4F8e9NMIVQQbk3OflYa3cKuXm
 9ocnlxHDgQIp6Q+3U3GRpN1VUvikv5Ag564uKodPPyGhr4KZN+y5tv6AJupEcfoIrMHs
 EqU+0T65/taJi6knQZG6EjR52gLhJeUDclgP56nnyZ0IsUTSro+tZAv/nWAkA/+Xfqa6
 nbMQ==
X-Gm-Message-State: APjAAAW0vaqXaKCJ+UkIFSZIGwCZilhW7UnelQXXcKmeUBmdbSMSt93C
 NKtQ0Ikp8/bjOGcXEBcxtp9bXSYyJrmVelkvuK8=
X-Google-Smtp-Source: APXvYqzum8le0i06iNjiio7kmCZiIdhNCeqRocdGXC1d4lnLBJVL3iDPKLaEYytIyeF3gpdyTrMzzURDsyIyG4B/hkM=
X-Received: by 2002:a9d:da2:: with SMTP id 31mr4190300ots.319.1579627763287;
 Tue, 21 Jan 2020 09:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-3-xiyou.wangcong@gmail.com>
 <8ce2f5b6-74e1-9a74-fd80-9ad688beb9b2@arm.com>
In-Reply-To: <8ce2f5b6-74e1-9a74-fd80-9ad688beb9b2@arm.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 21 Jan 2020 09:29:12 -0800
Message-ID: <CAM_iQpXbjf8MuL17kZhxawXYBJm6t5-ho77F_VWR30L-9FS4Kg@mail.gmail.com>
Subject: Re: [Patch v3 2/3] iommu: optimize iova_magazine_free_pfns()
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jan 21, 2020 at 1:52 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 18/12/2019 4:39 am, Cong Wang wrote:
> > If the magazine is empty, iova_magazine_free_pfns() should
> > be a nop, however it misses the case of mag->size==0. So we
> > should just call iova_magazine_empty().
> >
> > This should reduce the contention on iovad->iova_rbtree_lock
> > a little bit, not much at all.
>
> Have you measured that in any way? AFAICS the only time this can get
> called with a non-full magazine is in the CPU hotplug callback, where
> the impact of taking the rbtree lock and immediately releasing it seems
> unlikely to be significant on top of everything else involved in that
> operation.

This patchset is only tested as a whole, it is not easy to deploy
each to production and test it separately.

Is there anything wrong to optimize a CPU hotplug path? :) And,
it is called in alloc_iova_fast() too when, for example, over-cached.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
