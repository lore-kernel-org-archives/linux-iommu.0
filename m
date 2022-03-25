Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EBAC433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 19:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C08C5408F0;
	Fri, 25 Mar 2022 19:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id svgTBgA8eQBL; Fri, 25 Mar 2022 19:28:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 57625405C7;
	Fri, 25 Mar 2022 19:28:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A7D9C001D;
	Fri, 25 Mar 2022 19:28:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53412C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4156960B6F
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9uTCsttijMrX for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 19:28:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED11760F56
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:28:49 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id 5so15015753lfp.1
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 12:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4MqmH9CCCrUKFAq5y+I/qeK/sNikgDEGLg2VH+hZ/B8=;
 b=EEYCtzdxDwF4pZQoFLQy5R1bkbtIioQJ+didZOsq+7BOWsBdCAqNeXRuHlQHbxjkxI
 6ZpgNOxAuZZNbggkh7Po3d0QcOFG1glqGOPQvM9m9QhMt25NNyLu1evDrcAPEgux5s6f
 doW8iQM9agqh0IgmvQNxMRNQkwdp7w1AkhPq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4MqmH9CCCrUKFAq5y+I/qeK/sNikgDEGLg2VH+hZ/B8=;
 b=gI29poLqxtuc/g33UcMqygQVoXasCBoAjFq8nDsrRkKTSaZgjhM0PR7+bd6U2ulc1W
 xg/0WshiLpSbpP5bOaMnpjdB/HNp8nJe2gMNik7TC1m0iLwKNS9nQLt9TvnrFv1sgTMx
 0svpMRrtrc1g6AKmaLl3qmtsgDLC7OloWaY5Zv5fjmipwbK5waKQ6H7p09o/PPxl9ZbV
 U/cJD5Q+I6S1+ZgCXl0K9CTM5Y/mfWaU+XwtiD7UDOLI8xsnFDvR9YZQaRpCumoe9bIa
 522uSyjwXh/tRJk5zHNl6zoi4r6NGIy5ihyS8bwGkoo6Z6dUbczJ+S64qM/IPEx8CRye
 ud4w==
X-Gm-Message-State: AOAM531Utn5uPL7vrNwSEVil65j3ZmtyYF+b92o36897yLPcgdNB0rFF
 5ebDW06K0P8ys9MrKCO/erTnB2rbtsmhvZzuGYCMxw==
X-Google-Smtp-Source: ABdhPJzj531nN4RfRGtfIXwE3wHAZt+wytNaLthENkoDaSUdh4CwxI9rjuFLD4vfvVmFG117U6i/zA==
X-Received: by 2002:a05:6512:308b:b0:44a:6735:a3 with SMTP id
 z11-20020a056512308b00b0044a673500a3mr6752429lfd.250.1648236527541; 
 Fri, 25 Mar 2022 12:28:47 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181]) by smtp.gmail.com with ESMTPSA id
 m9-20020ac24249000000b004471fa09a95sm795524lfl.265.2022.03.25.12.28.46
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Mar 2022 12:28:47 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id c15so11556470ljr.9
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 12:28:46 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr8851909lfh.687.1648236109737; Fri, 25
 Mar 2022 12:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
 <a1829f4a-d916-c486-ac49-2c6dff77521a@arm.com>
In-Reply-To: <a1829f4a-d916-c486-ac49-2c6dff77521a@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Mar 2022 12:21:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpKDePfUoKmvJhSNbWcHFY5e7Uq5qEypD=R14+66DNvQ@mail.gmail.com>
Message-ID: <CAHk-=whpKDePfUoKmvJhSNbWcHFY5e7Uq5qEypD=R14+66DNvQ@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: Robin Murphy <robin.murphy@arm.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Mar 25, 2022 at 12:14 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Note "between the DMA transfers", and not "during the DMA transfers".
> The fundamental assumption of the streaming API is that only one thing
> is ever accessing the mapping at any given time, which is what the whole
> notion of ownership is about.

Well, but that ignores reality.

Any documentation that ignores the "CPU will want to see the
intermediate state" is by definition garbage, because that is clearly
a simple fact.

We don't write documentation for fantasy.

            Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
