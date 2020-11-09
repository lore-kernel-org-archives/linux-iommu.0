Return-Path: <SRS0=JucZ=EP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4A2C2D0A3
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 09:12:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08232083B
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 09:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfs1nbvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08232083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F70786099;
	Mon,  9 Nov 2020 09:12:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nF3OKlaFjG6X; Mon,  9 Nov 2020 09:12:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9ED8586049;
	Mon,  9 Nov 2020 09:12:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CB8FC088B;
	Mon,  9 Nov 2020 09:12:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABDD5C016F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 09:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A724420510
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 09:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PWaXYX1tBZD4 for <iommu@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 09:12:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by silver.osuosl.org (Postfix) with ESMTPS id AA119204D2
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 09:12:21 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id q19so7612572ljc.10
 for <iommu@lists.linux-foundation.org>; Mon, 09 Nov 2020 01:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ipacAfJrcUtFbk4kHEgOAkZMChrOufJTZqnjVylo3V4=;
 b=cfs1nbvSNaF0RgE6Xx5r9EKZ2Lpfy3eyp9kFQWTdkWi1XH1N5o0cjNLHHnXeF1HNL6
 B8CYQoZMucWCx5Rn7WQs8tcIecSHKUjRK+ZtqaCZHmpOnpCrr92wFIMAQdf4w+ovB3px
 dS0edwMrhuxRTG9uTnthhmr/AUdE5xMF4uk5uve0JxaBt7QpQvQ2TZEcVXa7wr5et9Pv
 uLIq0+6sNwp/qjE1TskxJLuOHtuGmrlftKifZi3wU0X3CjKrHRXOSlo017jQZe179qJ7
 6TQO/23kXEorFpfzmpr0PLNiJWfaaapQbDer0kvmsCsrUm+b4ik89oAGwEB3pr632R7C
 zZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ipacAfJrcUtFbk4kHEgOAkZMChrOufJTZqnjVylo3V4=;
 b=Q7dDBW3lOQ39bAEhsxwniqPH9KGdrMvY2p0wRjlbUUEN9cvz3JwWMjCocRcqq7AU3t
 +5386x2QcignuTyJ/uF28HLp5f8LaFQwNBpZ+lKXi+7Ushe+qEpgIiaH7P1UeB3jJyi4
 V2M9U/IakITopGrEQ3KZrBAJhcyxIr6BvfUDtH1ZsjRfBjLhRJtgmKuDf+LrtIqEyjCE
 yuW5p302S4ohk/vkd9nKal96Yu+d6uJ0FMhCzmaSQceIn1i/WhsHqVDWtOAlj/2uXPzE
 G6nM3CNaF0FrIPCwIwDsGQ+7mLtOrfKXpaCbH/3+cN1BOpZ6V824bE3q5S8yvSYFLqtR
 n/JQ==
X-Gm-Message-State: AOAM533qPYD6jD9+7lEHA0J/zcvFz2I76kyYoNNCDgv4rqboO+dNkDli
 jUYLJ1kk/ASxmKUBEdleUNw0Z0gjuJAwTJytkbU=
X-Google-Smtp-Source: ABdhPJx3gb+Zqkqz8YKx0Q7b6qqEZP6KKzTy7i5HcpFtnMCHQGp8PS4EXys/cD1YCAPEF/BDQqI7PKbjHnczt/FAfnc=
X-Received: by 2002:a2e:95cf:: with SMTP id y15mr5247385ljh.209.1604913139942; 
 Mon, 09 Nov 2020 01:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20201104081438.2075-1-zhenzhong.duan@gmail.com>
 <CAFH1YnMoNJZUJr-duEvzOMzeX0sXgE41T_A6HA+2oAU8WC=ktg@mail.gmail.com>
 <9e5e5f48-e91d-adce-cbf5-b98fee3b56a6@linux.intel.com>
In-Reply-To: <9e5e5f48-e91d-adce-cbf5-b98fee3b56a6@linux.intel.com>
From: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date: Mon, 9 Nov 2020 17:12:00 +0800
Message-ID: <CAFH1YnOW4ZMVC=AioJ=anLiDia1xx_NtSqgKFtfJ10icNccefg@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: avoid unnecessory panic if iommu init fail in
 tboot
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: jroedel@suse.de, x86@kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 ning.sun@intel.com, tboot-devel@lists.sourceforge.net,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
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

Hi Baolu,

On Mon, Nov 9, 2020 at 11:15 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi Zhenzhong,
>
> On 11/9/20 10:27 AM, Zhenzhong Duan wrote:
> > +intel iommu maintainers,
> >
> > Can anyone help review this patch? Thanks
> >
> > Zhenzhong
> >
> > On Wed, Nov 4, 2020 at 4:15 PM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
> >>
> >> "intel_iommu=off" command line is used to disable iommu and iommu is force
> >> enabled in a tboot system. Meanwhile "intel_iommu=tboot_noforce,off"
> >> could be used to force disable iommu in tboot for better performance.
> >>
> >> By default kernel should panic if iommu init fail in tboot for security
> >> reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
> >>
> >> Fix it by return 0 in tboot_force_iommu() so that force_on is not set.
> >>
> >> Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> >> ---
> >>   arch/x86/kernel/tboot.c | 5 +----
> >>   1 file changed, 1 insertion(+), 4 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> >> index 992fb1415c0f..9fd4d162b331 100644
> >> --- a/arch/x86/kernel/tboot.c
> >> +++ b/arch/x86/kernel/tboot.c
> >> @@ -511,12 +511,9 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
> >>
> >>   int tboot_force_iommu(void)
> >>   {
> >> -       if (!tboot_enabled())
> >> +       if (!tboot_enabled() || intel_iommu_tboot_noforce)
> >>                  return 0;
> >>
> >> -       if (intel_iommu_tboot_noforce)
> >> -               return 1;
>
> This was obviously wrong. It should return false, right?

I guess you missed above change: "if (!tboot_enabled() ||
intel_iommu_tboot_noforce)".
It does return false.

>
> It looks odd that intel_iommu_tboot_noforce is defined in Intel iommu
> implementation, but is used here. How about moving it back to the iommu
> driver?

That's better, will do. Thanks for your suggestion.

Zhenzhong
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
