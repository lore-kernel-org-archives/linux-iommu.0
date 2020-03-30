Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC06C43331
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 18:50:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B2C2078B
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 18:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mlJLtlVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B2C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A82E18789B;
	Mon, 30 Mar 2020 18:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c6LNyJMxBEt0; Mon, 30 Mar 2020 18:50:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CE984878A1;
	Mon, 30 Mar 2020 18:50:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B919FC1D7E;
	Mon, 30 Mar 2020 18:50:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A844C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 18:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E8240869AB
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 18:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vu2uMv2lfUkW for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 18:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 767A8861A1
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 18:49:58 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id k15so3903445pfh.6
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NBiWhVp0IqfyFDNmwRRGA/s+Dtxuu8Q2mjZHUKcx0uk=;
 b=mlJLtlVPXBg1gWOsSAxsoafEcJT38NiNpF0UOqjmzXlo8GohAqgw297ZK1Swt56Bly
 V3nGgPyqvQPMeDtng5baT7oly6ktnoBEa56u9lCaFRUnAvGmc515iPKUrcWy2Hs+fCMI
 IFS1C4dlShgMqMwCUu2tNPruIHdi1VqoM0tac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NBiWhVp0IqfyFDNmwRRGA/s+Dtxuu8Q2mjZHUKcx0uk=;
 b=tBJhIOTxyk6JwnjG7CLrPSYEl/84K9AePhGunaQ03fyJnRr4r3g7QY4ZhiaeYZiG/r
 JYEX8g1p7ekiHmPJmyV3CLhpNpRrqU9DiVBFVs2lyata/Nu3JILIbOvErTqKwZdD62cP
 4SpxHYW33bCabf48iBQDMG0dMORD6ygE4XKKWp++kzM7LuYCe/5iwWGGDTrHrF4gieyP
 cNlSFl2UDlOdTFSPYZsonmL+n73z9WKtHDPmYDv/S0OzB4ZbXhqAW+fJscgDZ0cfB/FV
 h8X6L1j+mcs9CvwJLLTPBC+46vaS6+Rq5Afti0WhfY6qbtc2pfDIXlKJJaNAfgeSwvzd
 muJQ==
X-Gm-Message-State: ANhLgQ3EpzG21ke7kfLaul9TVgZitjAclGzdXKk4jge5qcwSNCFMIt8s
 e/ptiuLC9WTw3cAXIlFm5xe06pRPA2I=
X-Google-Smtp-Source: APiQypJQ7lTWDAV2N+IMIRZE46eM2iGJ2kJcLtVLbIwZ++HEvk6qAuFH5WfwTAk91OKGmq85WZHRYw==
X-Received: by 2002:a67:24c1:: with SMTP id k184mr9270431vsk.177.1585592683628; 
 Mon, 30 Mar 2020 11:24:43 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com.
 [209.85.221.169])
 by smtp.gmail.com with ESMTPSA id j21sm3490242vkj.56.2020.03.30.11.24.42
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 11:24:42 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id s194so4960870vkb.11
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 11:24:42 -0700 (PDT)
X-Received: by 2002:a1f:a9d2:: with SMTP id s201mr8815125vke.92.1585592681966; 
 Mon, 30 Mar 2020 11:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com>
 <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
 <5858bdac-b7f9-ac26-0c0d-c9653cef841d@arm.com>
 <d60196b548e1241b8334fadd0e8c2fb5@codeaurora.org>
In-Reply-To: <d60196b548e1241b8334fadd0e8c2fb5@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 30 Mar 2020 11:24:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXTN6xxqtL6d6MHxG8Epuo6FSQERRPfnoSCskhjh1KeQ@mail.gmail.com>
Message-ID: <CAD=FV=WXTN6xxqtL6d6MHxG8Epuo6FSQERRPfnoSCskhjh1KeQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Will Deacon <will@kernel.org>
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

Hi,

On Sat, Mar 28, 2020 at 12:35 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> > Of course the fact that in practice we'll *always* see the warning
> > because there's no way to tear down the default DMA domains, and even
> > if all devices *have* been nicely quiesced there's no way to tell, is
> > certainly less than ideal. Like I say, it's not entirely clear-cut
> > either way...
> >
>
> Thanks for these examples, good to know these scenarios in case we come
> across these.
> However, if we see these error/warning messages appear everytime then
> what will be
> the credibility of these messages? We will just ignore these messages
> when
> these issues you mention actually appears because we see them everytime
> on
> reboot or shutdown.

I would agree that if these messages are expected to be seen every
time, there's no way to fix them, and they're not indicative of any
problem then something should be done.  Seeing something printed at
"dev_error" level with an exclamation point (!) at the end makes me
feel like this is something that needs immediate action on my part.

If we really can't do better but feel that the messages need to be
there, at least make them dev_info and less scary like:

  arm-smmu 15000000.iommu: turning off; DMA should be quiesced before now

...that would still give you a hint in the logs that if you saw a DMA
transaction after the message that it was a bug but also wouldn't
sound scary to someone who wasn't seeing any other problems.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
