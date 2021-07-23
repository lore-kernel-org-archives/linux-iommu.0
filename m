Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E16BC4338F
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 14:24:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC9360EBC
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 14:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BC9360EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDAFC4063D;
	Fri, 23 Jul 2021 14:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NoaJ1C8oH3De; Fri, 23 Jul 2021 14:24:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DFE1040633;
	Fri, 23 Jul 2021 14:24:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DAD5C001A;
	Fri, 23 Jul 2021 14:24:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D69DC000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 14:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D64CD401FC
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 14:24:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ThRqSL08Y-1c for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 14:24:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00EBF401DB
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 14:24:18 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 x15-20020a05683000cfb02904d1f8b9db81so2142957oto.12
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TFOUkgVe/De3oymeenLBuNPer+TUmPN7lpMy3blENNw=;
 b=kMYc3VLcZ8HQkeGDP4GCj08ozIhO820sv8drLzH/p0tt+jnIl+jqN4ig75T2p0lKw/
 GbMiV85J/nc0wqsoDrAy0FBoq8f4oWdxggAf3+1YZZPlqb/CIQw5PVwLqx2g1fKTU/xJ
 2zCvCUTIqjmHIwMlzDo3Cq42Eirw6Z6bccTo6dTdRcjCoYtQKxDXrejsuVsuSV7LCRQR
 tuD974zCr28piclys4fQ7Y+lvwA+YYLmvDQ7giWULxqVOoa7Wshd7pAgkk+NcwkU53VM
 XgANK5fQb4M+ZZKMo9j6bpevRaDl4Dkyn+6PvhDQZiXVmnZmgWeY7qgorQkOPqWuAEcY
 HFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TFOUkgVe/De3oymeenLBuNPer+TUmPN7lpMy3blENNw=;
 b=aSnj7In8zTwCxSAG9rYsH+smag5d567N/PwAaDMumskiRz/IAaCz6iyndN/rUJ95Ux
 Qa7Imyk9C/02y2Wro7FFfL45L7kx7y3rrnR7VToSmsuBFSGRvyrS9nR4knaaP9n4Fkhn
 2MuNTp51YkgktTjBIlqLBajg/6g5Qid+Evq6O4W4NBI2RCxRzL/iiakQTcnp8ztiyxyc
 QLSmAgUAt8azva/ty5BODQVTqnmaSdppX12Rd9DNJjfMAokG7zO4HPblTD8uTNSuX9Oq
 ltDhhmzchWYyCWjP6buWI6pyc9a7Fnl6317o+g98EEg8WcAA1kRGf+279Sa+DzW3nduY
 Jf9g==
X-Gm-Message-State: AOAM532tg/MB+1LeSE/N6XRAHpg+kwFaROXKrGxU2d4SFJK14+a0liwv
 IuHfxIwYv81lq95Fot6uFY6mBg==
X-Google-Smtp-Source: ABdhPJz+8ZHqxxjGU86tyolNaSdy9VlLyxBEJo+yDX15pPrPdOO0ZWJWGxlkjLP/OhHNkko5BhKtfA==
X-Received: by 2002:a9d:2c61:: with SMTP id f88mr3251914otb.62.1627050257958; 
 Fri, 23 Jul 2021 07:24:17 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id s7sm3420836ool.14.2021.07.23.07.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 07:24:17 -0700 (PDT)
Date: Fri, 23 Jul 2021 09:24:14 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
Message-ID: <YPrRDrmlmF4ws4DQ@yoga>
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPgK50dmV7Z69WsL@kroah.com>
 <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
 <CAGETcx91URbHCYMoGt_cCgvMXNkVyJb4Ek-ng8jwR+eQhvZN1A@mail.gmail.com>
 <YPiCSOys6zEH6Kfg@yoga>
 <CAGETcx8Yw2QDYBYNpqVt_kPHnokFR+qinr5GAJ1byVWMuc3PLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx8Yw2QDYBYNpqVt_kPHnokFR+qinr5GAJ1byVWMuc3PLQ@mail.gmail.com>
Cc: Maulik Shah <mkshah@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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

On Wed 21 Jul 16:07 CDT 2021, Saravana Kannan wrote:

> On Wed, Jul 21, 2021 at 1:23 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Wed 21 Jul 13:00 CDT 2021, Saravana Kannan wrote:
> >
> > > On Wed, Jul 21, 2021 at 10:24 AM John Stultz <john.stultz@linaro.org> wrote:
> > > >
> > > > On Wed, Jul 21, 2021 at 4:54 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> > > > > > Allow the qcom_scm driver to be loadable as a permenent module.
> > > > >
> > > > > This feels like a regression, it should be allowed to be a module.
> > > >
> > > > I'm sorry, I'm not sure I'm following you, Greg.  This patch is trying
> > > > to enable the driver to be able to be loaded as a module.
> > >
> > > I think the mix up might be that Greg mentally read "permanent module"
> > > as "builtin"?
> > >
> > > "permanent module" is just something that can't be unloaded once it's
> > > loaded. It's not "builtin".
> > >
> >
> > Afaict there's nothing in this patch that makes it more or less
> > permanent.
> 
> The lack of a module_exit() makes it a permanent module. If you do
> lsmod, it'll mark this as "[permanent]".
> 

Cool, I didn't know that.

Thanks,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
