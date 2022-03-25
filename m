Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F670C433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 18:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C205E844C2;
	Fri, 25 Mar 2022 18:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XuxcLdAEU7ED; Fri, 25 Mar 2022 18:46:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2CC784476;
	Fri, 25 Mar 2022 18:46:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C96EC002C;
	Fri, 25 Mar 2022 18:46:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70ED7C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60201844A7
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Del1AhcFAZ7W for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 18:46:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8C8884476
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:46:31 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id h11so11448396ljb.2
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EgGZKxsD9TLt3F67gvL7glAxKY5LH/ALHfbJS10Unqo=;
 b=Ifi0U+jMvGYK0BTqlDqJD7wDJnEG/YfUGRvZzfRr8j43WKraDG3cCjf0FFuimZ9VSg
 Z0g9+NcUuKem/himXNWFu4jQmCzk/SXJEhcY5eS/wYwMyvOJB4gmBU/F0T+ou6Dqjoci
 oWVtYazkM++O6R/PwREQdtdeDirieoe3APP1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EgGZKxsD9TLt3F67gvL7glAxKY5LH/ALHfbJS10Unqo=;
 b=ZPK65SDU2caAJYUmHTEIilNCNFotnvRbAHYPm6iY4sQTiT0XnkFyMaxhg0TRVksYGS
 wZzUCmaUgLvbvyBD3dfiffOhLSAjmnVUsw8JSAmgCsyDxWOzh5n3cc5+ydMBarr80GrM
 mbZE/2psI/pw4EKON0OY4TODatpQydVFMZtqsoZEu/u7O7IB86I7dI4yLuOXVOxGF4D4
 sBYB2aGIH8lyXFwv3crVajMkS6TrSLwiDtRgTrYH+1wtsgYT8LJbGo6+YqNCI6G9hjkA
 jhWxwlXkY7FAvszhTUMIa7ezpYwgzxI60zxpoQyBaEs4P4l6F0QHJHI5om8BoHRyzVJX
 txZw==
X-Gm-Message-State: AOAM533Vf+rULT2r8cOyezQY4sQU/EwUU91EBqG43XaXRW81M8Dxz3W2
 Q+bgBu1h8XbSzJUo+AAbtMeTgatyFcQEbhcUpY58sA==
X-Google-Smtp-Source: ABdhPJydtdBIGow3SRurcBdxyOwAkP/VYkJ6YJXhUjRRrzFLvQZQCNjJVSkWlSekOHlP3rBpIaplXg==
X-Received: by 2002:a05:651c:1988:b0:249:9e53:e38b with SMTP id
 bx8-20020a05651c198800b002499e53e38bmr8835896ljb.284.1648233989182; 
 Fri, 25 Mar 2022 11:46:29 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182]) by smtp.gmail.com with ESMTPSA id
 x1-20020a056512130100b004484c116de3sm789161lfu.246.2022.03.25.11.46.26
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Mar 2022 11:46:27 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 17so11436068ljw.8
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 11:46:26 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr9323690ljc.506.1648233985657; Fri, 25
 Mar 2022 11:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
 <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324190216.0efa067f.pasic@linux.ibm.com>
 <20220325163204.GB16426@lst.de> <87y20x7vaz.fsf@toke.dk>
 <e077b229-c92b-c9a6-3581-61329c4b4a4b@arm.com>
In-Reply-To: <e077b229-c92b-c9a6-3581-61329c4b4a4b@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Mar 2022 11:46:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKF5GfLXyVGDQDifh0MpMccDdmBvJBG3dt2+idCa5DzQ@mail.gmail.com>
Message-ID: <CAHk-=wgKF5GfLXyVGDQDifh0MpMccDdmBvJBG3dt2+idCa5DzQ@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: Robin Murphy <robin.murphy@arm.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Fri, Mar 25, 2022 at 11:42 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Note that the current code is already a violation of the DMA
> API (because the device keeps writing even when it doesn't have
> ownership), so there's not a very strong argument in that regard.

See my other email. I actually think that the ath9k code is 100%
correct, adn it's the dma-mapping code that is in violation of the
rules.

And a big part of the problem - I think - is that the rules are so
badly documented and not explicitly listed.

I think my list of three different sync cases (not just two! It's not
just about whether to sync for the CPU or the device, it's also about
what direction the data itself is taking) is correct.

But maybe I'm wrong.

I really want people to think about this, because right now my gut
feel is that commit aa6f8dcbab47 was just absolutely incorrect.

              Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
