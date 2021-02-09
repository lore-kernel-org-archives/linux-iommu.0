Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766F6C433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:27:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BA364EB9
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BA364EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A5DA88723B;
	Tue,  9 Feb 2021 06:27:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gMK8yKz9ha0w; Tue,  9 Feb 2021 06:27:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 31D4986F93;
	Tue,  9 Feb 2021 06:27:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26AA1C0174;
	Tue,  9 Feb 2021 06:27:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 853FBC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 577D286F92
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:27:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O38Gt-Hsl9wM for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:27:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com
 [209.85.166.170])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8935686F7D
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:27:31 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id d6so15128958ilo.6
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 22:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1yfWtyKyTZvhHLdRd0Os+HgXY0IXloCRl6/1X6y49yY=;
 b=I8sAs6STSD3viziWc9zjdGpRV2Ij0huuBcH4DTqpEpqza+Sa89+jcmi0lEr6QyU3Yc
 L7rP/rH0/RfRBI83gH4R47SJOVgSrDffjCf/VWsaIa4tSZ3K01/puYHwXeA+73O+NMbj
 Mayn3mIGAEUCdMMblgZt8JrLoIUQfDCTzzdMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1yfWtyKyTZvhHLdRd0Os+HgXY0IXloCRl6/1X6y49yY=;
 b=LNxkvG7jo2O3ErQH8W+p3coELK3QPGElqAf/jYS3BtzJ34SAYU5kXftC4n/rBh19zq
 T9FIn8NKVZ5x+ZtCFmCE7/8RH5AvDhtpN4gNhjDyIa1BdY5NAymxPErHGJHsfFNJJJzu
 ryluM0ar7fvqLO3LB6mU3BPolyU3yiAh4bGoEB6S4QW5pumt7Qu1b+VKoBPBdD0dENis
 6iEKrB4CFQU4p+K8cYPJd1HpPCTjFE1NHMIdnTC0cpdVqtHSBiavy3/yOKqHWuRYTzuU
 1iqdhn4NmllRj3yhHQvAAImfvDqqdsUYMN6gJxbuH1U6Gt1FopkImN2PL3opJk5ksPl/
 /w3g==
X-Gm-Message-State: AOAM532HomN0rmXep1naadPuDoz3PxyBWItBihlhfzVzsMdjCIC0i+Dq
 yMrvQzbOTxVpyZXLDbmC3TDaRm6ldneY0g==
X-Google-Smtp-Source: ABdhPJxjPDOHEcyjNDxFSZ2GxwRjFoE7+vAnakiTM8WDOE79stV7A272AJbWZ+tQZGHvH662YC8Cog==
X-Received: by 2002:a92:d44b:: with SMTP id r11mr18855845ilm.159.1612852050657; 
 Mon, 08 Feb 2021 22:27:30 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com.
 [209.85.166.53])
 by smtp.gmail.com with ESMTPSA id e15sm10007143iog.24.2021.02.08.22.27.29
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 22:27:29 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id m17so7121085ioy.4
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 22:27:29 -0800 (PST)
X-Received: by 2002:a6b:144c:: with SMTP id 73mr18274991iou.69.1612852048986; 
 Mon, 08 Feb 2021 22:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <d7043239-12cf-3636-4726-2e3b90917dc6@gmail.com>
 <CALiNf28sU1VtGB7LeTXExkMwQiCeg8N5arqyEjw0CPZP72R4dg@mail.gmail.com>
 <78871151-947d-b085-db03-0d0bd0b55632@gmail.com>
 <CALiNf29_PmLJTVLksSHp3NFAaL52idqehSMOtatJ=jaM2Muq1g@mail.gmail.com>
 <23a09b9a-70fc-a7a8-f3ea-b0bfa60507f0@gmail.com>
 <CAAFQd5DX=AdaYSYQbxgnrYYojkM5q7EE_Qs-BYPOiNjcQWbN1A@mail.gmail.com>
 <c7f7941d-b8bd-f0f3-4e40-b899a77188bf@gmail.com>
 <CAAFQd5AGm4U8hD4jHmw10S7MRS1-ZUSq7eGgoUifMMyfZgP2NA@mail.gmail.com>
 <7fe99ad2-79a7-9c8b-65ce-ce8353e9d9bf@gmail.com>
In-Reply-To: <7fe99ad2-79a7-9c8b-65ce-ce8353e9d9bf@gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 9 Feb 2021 14:27:18 +0800
X-Gmail-Original-Message-ID: <CALiNf2_rRufFoxNN=i0_LkVvw31tXetKasm3SrzYy7O8o-sfgg@mail.gmail.com>
Message-ID: <CALiNf2_rRufFoxNN=i0_LkVvw31tXetKasm3SrzYy7O8o-sfgg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] Restricted DMA
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>
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

v4 here: https://lore.kernel.org/patchwork/cover/1378113/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
