Return-Path: <SRS0=5Ucf=P3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A81C433F5
	for <iommu@archiver.kernel.org>; Mon,  8 Nov 2021 17:18:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E8D611C4
	for <iommu@archiver.kernel.org>; Mon,  8 Nov 2021 17:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5E8D611C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AB996062F;
	Mon,  8 Nov 2021 17:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVRR5hI7G244; Mon,  8 Nov 2021 17:18:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68A74605E1;
	Mon,  8 Nov 2021 17:18:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52102C0012;
	Mon,  8 Nov 2021 17:18:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C47A9C000E
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 17:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1EC740157
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 17:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aVqq2OY2kIDB for <iommu@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 17:18:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63DFA400BF
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 17:18:23 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id u18so28147049wrg.5
 for <iommu@lists.linux-foundation.org>; Mon, 08 Nov 2021 09:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=k+xBEZ60gaFRX6TewmJXrlZ7gEV8kWXNlWQ1p+Qwerc=;
 b=tylg3WMyJzjHKD/AuBFYwm4sTJrCCB7p8z9qmReROGEUmKTiR2I/NZWbGzcvxFJ6Qx
 x1XXVAY/8WwROJcsuikAGPlh7nFdJBCVnCx61geyTP+gwS85Wl8WKrzbPHEW612w9ri6
 +xFyxs4jS7qkbKsHqzPT+vvq0MKH/lk7cbVX1gtE43W4uzaC4hL5x0ipSW3s30HvsT4P
 2dqTOyM/+yucbrMe03Y+U05gDlUl5up6eItt3RFmT04f8ego26SA924etCuazTv6/DOx
 xmWlH2BnDG5+MbIe5dJgmiCeVTJBkqoc/b0vLXNQJZzvfubWeP1eJll5cVOKutR1eC30
 PjAA==
X-Gm-Message-State: AOAM533gW8r0lVvnEpeCLUHei9eQNatq3y/NKu0p1a/2j3S4bfqEPiFE
 IY/8bbSGPp6Qn/NAWUu62L8=
X-Google-Smtp-Source: ABdhPJyhia6d85wm25bZ2YttwtRNLe8TYhS/6mtXkEsdSSvLaOR+qPwM+MSHCuDa9WsPVoLocUfggQ==
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr912657wrs.164.1636391901696; 
 Mon, 08 Nov 2021 09:18:21 -0800 (PST)
Received: from rocinante ([95.155.85.46])
 by smtp.gmail.com with ESMTPSA id f18sm17208547wre.7.2021.11.08.09.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 09:18:21 -0800 (PST)
Date: Mon, 8 Nov 2021 18:18:19 +0100
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)
Message-ID: <YYlb2w1UVaiVYigW@rocinante>
References: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>
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

Hi Paul,

> On a PowerEdge T440/021KCD, BIOS 2.11.2 04/22/2021, Linux 5.10.70 takes
> almost five seconds to initialize PCI. According to the timestamps, 1.5 s
> are from assigning the PCI devices to the 142 IOMMU groups.
[...]
> Is there anything that could be done to reduce the time?

I am curious - why is this a problem?  Are you power-cycling your servers
so often to the point where the cumulative time spent in enumerating PCI
devices and adding them later to IOMMU groups is a problem? 

I am simply wondering why you decided to signal out the PCI enumeration as
slow in particular, especially given that a large server hardware tends to
have (most of the time, as per my experience) rather long initialisation
time either from being powered off or after being power cycled.  I can take
a while before the actual operating system itself will start.

We talked about this briefly with Bjorn, and there might be an option to
perhaps add some caching, as we suspect that the culprit here is doing PCI
configuration space read for each device, which can be slow on some
platforms.

However, we would need to profile this to get some quantitative data to see
whether doing anything would even be worthwhile.  It would definitely help
us understand better where the bottlenecks really are and of what magnitude.

I personally don't have access to such a large hardware like the one you
have access to, thus I was wondering whether you would have some time, and
be willing, to profile this for us on the hardware you have.

Let me know what do you think?

	Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
