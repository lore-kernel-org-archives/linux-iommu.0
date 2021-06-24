Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B458C49EA5
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 17:30:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093EB613C3
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 17:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093EB613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C165D41636;
	Thu, 24 Jun 2021 17:30:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O6yO9QnKzVWX; Thu, 24 Jun 2021 17:30:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86873415FD;
	Thu, 24 Jun 2021 17:30:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50A72C000E;
	Thu, 24 Jun 2021 17:30:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06843C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 17:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD57E83E2E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 17:30:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zjIUAWNwagxE for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 17:30:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFBA083E32
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 17:30:31 +0000 (UTC)
Received: by mail-ua1-x92f.google.com with SMTP id c47so1796071uad.1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+rsHIuusfgMY4pqsH67Cui+AEpTgqc5yU+NQJneTe3I=;
 b=nBGujxlend0FDFpaE8uA1VUl+5W3aXuZOEudrIKeZDfQ/+pPr4z/II/WEyNd+uPN26
 soAHBGP+8BikRpyXJAG3b8cFuHlgqAS3iEFezd2Ak3P1sLNeJUFtACX4Ma/t0C5DxnCj
 gDadjhrj4RKoBq1/dEScJTk1qx68aEBMsAMaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+rsHIuusfgMY4pqsH67Cui+AEpTgqc5yU+NQJneTe3I=;
 b=T2b6jMJZWXb4bAVG8bidgZHT5b55dp8PYD15/7Gxb3YhHGfKAudYlqAOOYvsJGeJOl
 IaAB56vHdUZ5IH/fs3Q7Ja/EDyPhxM4ozoMahVPo2275VPN5QoOU6YgfvmNXLw2SqhcX
 ktaMe1t2PkPkT/bKBK1WQZFjUMcnds+uybtBlnaOFh4XTnga5uXazAV/pGaTVXsG4bQo
 5tvFPnE5gdaqPORl4Qnyv4OhVO31l8+MnDqkXlVwE0jnTM+Xi3MCfq53CRvZE1TDRz7Y
 eaq/nikuZGFvMEe6xna6QGb5SH3wgkOO12mwVRgMMYQJvjmGTpF6mAurgvmdJ4lgD4ot
 wPzA==
X-Gm-Message-State: AOAM531vYUNxQ/BQ8jtXzZj3Oy1GDi4UfUtnScoJhP/eM4jc9CWiQ5j6
 KDPmtJKRXz7PaSX7VYhzma997D8OeXSj0A==
X-Google-Smtp-Source: ABdhPJzCc0lypyHE3DJYmM4hKM6ssrBm+/Us+xyylFIAPlfxba7kgMlbXmC2u35PkuOjiTAogMIPkA==
X-Received: by 2002:ab0:7791:: with SMTP id x17mr7111418uar.67.1624555830665; 
 Thu, 24 Jun 2021 10:30:30 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com.
 [209.85.222.44])
 by smtp.gmail.com with ESMTPSA id k8sm721342vsj.4.2021.06.24.10.30.30
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 10:30:30 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id r4so2501419uap.8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 10:30:30 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr6470962ybk.405.1624555397076; 
 Thu, 24 Jun 2021 10:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com>
 <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
 <498f3184-99fe-c21b-0eb0-a199f2615ceb@arm.com>
 <CAD=FV=UQBRY4hobBWVWtC8y07NLRLhpejdvUAD+7UWw-jqP2UA@mail.gmail.com>
In-Reply-To: <CAD=FV=UQBRY4hobBWVWtC8y07NLRLhpejdvUAD+7UWw-jqP2UA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 24 Jun 2021 10:23:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4ZrUZagtE8qtRXwFEdw9FqGt-tpX-yCO3Hvi9Aw22UA@mail.gmail.com>
Message-ID: <CAD=FV=V4ZrUZagtE8qtRXwFEdw9FqGt-tpX-yCO3Hvi9Aw22UA@mail.gmail.com>
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, quic_c_gdjako@quicinc.com,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Gross <agross@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Sonny Rao <sonnyrao@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
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

On Wed, Jun 23, 2021 at 10:29 AM Doug Anderson <dianders@chromium.org> wrote:
>
> * Instead of putting the details in per-device nodes, maybe it makes
> sense to accept that we should be specifying these things at the IOMMU
> level? If specifying things at the device tree level then the
> device-tree node of the IOMMU itself would just have a list of things
> that should be strict/non-strict. ...this could potentially be merged
> with a hardcoded list of things in the IOMMU driver based on the IOMMU
> compatible string.
>
> Do those sound right?
>
> I still haven't totally grokked the ideal way to identify devices. I
> guess on Qualcomm systems each device is in its own group and so could
> have its own strictness levels? ...or would it be better to list by
> "stream ID" or something like that?
>
> If we do something like this then maybe that's a solution that could
> land short-ish term? We would know right at init time whether a given
> domain should be strict or non-strict and there'd be no requirements
> to transition it.

OK, so I have attempted to implement this in the Qualcomm IOMMU driver
in v2 of this series:

https://lore.kernel.org/r/20210624171759.4125094-1-dianders@chromium.org/

Hopefully that doesn't fragment the discussion too much, but it seemed
like it might help move us forward to see what this would look like in
code.

I'll also note that I removed a few people from the CC list on v2 of
the series because I'm no longer touching any code outside of the
IOMMU subsystem and I thought folks would appreciate less noise in
their inboxes. I've CCed a boatload of mailing lists though so it
should be easy to find. If I dropped you from the CC list of v2 and
you really want back on then I'm more than happy to re-add you.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
