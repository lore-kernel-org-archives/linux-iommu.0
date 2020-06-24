Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04698C433E0
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 23:22:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87D02078D
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 23:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7YPQvc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87D02078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 936B687678;
	Wed, 24 Jun 2020 23:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OfWCAlVkd57f; Wed, 24 Jun 2020 23:22:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 139BD87669;
	Wed, 24 Jun 2020 23:22:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BC29C088E;
	Wed, 24 Jun 2020 23:22:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59C6DC016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 23:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 46EF7883C0
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 23:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Shlq0tDW83qh for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 23:22:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 843CA883C8
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 23:22:24 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id 18so3589850otv.6
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ixR4kIucjZXiRtwMzxKSRPAHfL+FLubXnd+GvW1h77s=;
 b=Z7YPQvc6norraPne8OACkSUlKBVmLzg0FP9LZ7gduh3U4fiXJckSxRV8Rw/M6ozRWJ
 CjO2/AkaXd9R+o9hVzdrRw1hQuKb2mCZ1GENwhRmQMvXPb4YogDL9Anl/z4vNHibhS7O
 NK3IrFNQK8cYxuy21niT7Scw64KVhXT99fgZQNoQLHaS4zd3qSpDwRBNF69Va9CI3Su1
 XOZeXBH0cz4qgxb4LruxmpvoG9P53uUpxNMeGz+7XTSEjo/48iNu+ULMKQcpWyfIRnzG
 WGAjrfnyEm3aD+QzMcQW7ICI5L5cy+GzJeuU+I+SuwLYvFoAuMEzV69tL1xuT3vPCjHY
 qcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ixR4kIucjZXiRtwMzxKSRPAHfL+FLubXnd+GvW1h77s=;
 b=aaG3hfgLgoC8JIjvP4LzVYnseY2Rm9eCrJIui2AgL2eemKKmuyiTvKzQsVR9JsfbVd
 yfB4mwaLB+CVA1HwrjGfqbnRp52AFvcCb7E9SjYlyhhxmpbqMntaDcUisL+WuMNzZYNg
 eLAcTM+LpQMEX7lqre3DRxw2ycEDTXgjfYdq3C/mLFj8KBj5uMuyXHQF+iuig/Rln178
 u/XzlqW9eV3gDiOp/9eaoJJSIKFduWEkvq1yaG8i99F1qJPJ9tWzhKFig0xJ+B/+F+Bq
 ixLJsvg5UhSpeoAzVT7PuWo42VyB9VvkYfSfVpMmH8e9k67f+wQW6GwjjuQm4panalwX
 qvxg==
X-Gm-Message-State: AOAM532XRfvCmxlJcN399h4slJThQBcUNLEfYwcKUvyMs9wsZGo9lrC0
 nsnVycdxx/usHunTa80GcSFEdVf6mDcImd22jyErEA==
X-Google-Smtp-Source: ABdhPJyDeT0KDPGBY+XrtAn4IpWyHShWZgknfbRvrpyv5ICBQ0JbfIvQE3n6cpvnMFZ4tsBYi4nHf3OPeZeTeb/2RbY=
X-Received: by 2002:a05:6830:1e13:: with SMTP id
 s19mr9494408otr.102.1593040943632; 
 Wed, 24 Jun 2020 16:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200616061338.109499-1-john.stultz@linaro.org>
 <20200616061338.109499-5-john.stultz@linaro.org>
 <20200621060055.GA2421@builder.lan>
In-Reply-To: <20200621060055.GA2421@builder.lan>
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 24 Jun 2020 16:22:12 -0700
Message-ID: <CALAqxLUhi4qQpz5b+6hc8T5mA2E6ugg6UD44WA+Dc2+=Hjm=DQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/5] pinctrl: qcom: Allow pinctrl-msm code to be
 loadable as a module
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Saravana Kannan <saravanak@google.com>,
 Marc Zyngier <maz@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Todd Kjos <tkjos@google.com>
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

On Sat, Jun 20, 2020 at 11:03 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 15 Jun 23:13 PDT 2020, John Stultz wrote:
>
> > Tweaks to allow pinctrl-msm code to be loadable as a module.
> > This is needed in order to support having the qcom-scm driver,
> > which pinctrl-msm calls into, configured as a module.
> >
>
> This means that we need a "depends on QCOM_SCM || QCOM_SCM=n" on all
> entries in the Kconfig that selects PINCTRL_MSM, or switch PINCTRL_MSM
> to be user selectable and make all the others depend on it.

Oh, good point! I already had to fix that in a different tree, but
forgot to move the fix over to my upstreaming tree.


> >
> > +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. pinctrl-msm driver");
>
> It's the "Qualcomm Technologies, Inc. TLMM driver"
>
> > +MODULE_LICENSE("GPL v2");
> > +
>
> Please don't retain my empty line at the end of this file :)

Done and done. Thanks so much for the review!
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
