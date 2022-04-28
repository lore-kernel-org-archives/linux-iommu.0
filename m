Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D63C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8341760A81;
	Thu, 28 Apr 2022 14:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DuTUrN4ff97r; Thu, 28 Apr 2022 14:51:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 833506079E;
	Thu, 28 Apr 2022 14:51:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CD37C0032;
	Thu, 28 Apr 2022 14:51:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E429C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BA8281441
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:51:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eV2hZtbZOWNh for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:51:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D55FF8129E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:51:52 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id o69so3170536pjo.3
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u9jjxzFqyEv8LBWVsrZtYT4OxlKeAvkfQsoOT8XO85M=;
 b=Eo9pYlKYZkJpqf31dxcbCDkgVISHZnUiOPR5gJATEANdzGnDNxlo7Yahv5R1ctQee5
 bhsphKUBm5UdIl3TBHZtHHw8KW8AwPkGlZn1OfaZhzn/qjhFAd47hmnNY4VRyJ1kd3km
 UCuuoJEpezzIv4/nWOUTOvsiHjuUq16RoBvyw5pGTRCV2ncKp0ExCyStDmL+GBS5SWFz
 Bz7YgTdAdWJFoOUriJJvEHLbu+XJ9lDNE7fxqKvInyUi5DHD5btdg9Im39MbF9U6EzOR
 o2UIXa2E8oOO9eNFlULEYoj5w6ijpqiTJdTHzG1DUeZmGcAuENmSCNnPkDqW8UG99YXH
 L66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u9jjxzFqyEv8LBWVsrZtYT4OxlKeAvkfQsoOT8XO85M=;
 b=CP+FTGi4HWcu5QMzSc6OJaxaLVk0zaDGW0CQqizzcu5tyE+h09x+wDydHQ+KUt8+pM
 pw0ktfyO36uOY69AVvVvxHiw0oGsxP1BjngtTQG1jlkfQ/V5XRF6zAe3UqvzPrrWdT+x
 7vlU7DOn937ntZP8Cio+zifnDEuy30/FDPIVhZvvsb7ZpwNeFAmwnQWkC7thraCrD34v
 erf9T6pvpRg8anH9BiUUCn3Kn8B3Kr2qGeEnBGwGjq3PiTkth6XfQ0t1TYjFmpy4PGoc
 AZHBEmjYHQEWnyj/yrNv0ssTAmtM8jKKzBS1TDqfCxWuYlRoxONYotKz5zuK+kHYrRar
 p+2Q==
X-Gm-Message-State: AOAM531qsTmDWi35EAXBAkEwCGEw6wewuzqItaMrTwZHeHkwcOLHFZET
 T/lOjiHWd+K7EHPrLYw9flXMhHBsUevntK6BBLg=
X-Google-Smtp-Source: ABdhPJxIL1GSLaYMCrNZgOMOzrkbrH8EbxUnGtoLQMMClEdi0B+tr5FBUwfsx9F5E/E5vZQrHQaEKf8q8QovbJXGBJM=
X-Received: by 2002:a17:90a:ec0e:b0:1d9:7f4d:23be with SMTP id
 l14-20020a17090aec0e00b001d97f4d23bemr22629798pjy.181.1651157512300; Thu, 28
 Apr 2022 07:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_6A5CCC9FB9221C4A1414E1534A3DFFC62008@qq.com>
In-Reply-To: <tencent_6A5CCC9FB9221C4A1414E1534A3DFFC62008@qq.com>
From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date: Thu, 28 Apr 2022 08:51:30 -0600
Message-ID: <CAOCk7Np+tVPtSXGzdwHJZqfgVseVKKZ4znThPx_9ApxMOqRZyA@mail.gmail.com>
Subject: Re: [PATCH] iommu/msm: add a check for the return of kzalloc()
To: xkernel.wang@foxmail.com
Cc: MSM <linux-arm-msm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Will Deacon <will@kernel.org>
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

On Fri, Mar 25, 2022 at 2:13 PM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/iommu/msm_iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 3a38352..697ad63 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -597,6 +597,10 @@ static void insert_iommu_master(struct device *dev,
>
>         if (list_empty(&(*iommu)->ctx_list)) {
>                 master = kzalloc(sizeof(*master), GFP_ATOMIC);
> +               if (!master) {
> +                       dev_err(dev, "Failed to allocate iommu_master\n");

How do you reconcile this with chapter 14 of the coding style document?

"These generic allocation functions all emit a stack dump on failure when used
without __GFP_NOWARN so there is no use in emitting an additional failure
message when NULL is returned."

> +                       return;
> +               }
>                 master->of_node = dev->of_node;
>                 list_add(&master->list, &(*iommu)->ctx_list);
>                 dev_iommu_priv_set(dev, master);
> --
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
