Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBF4C0044D
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 16:48:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CB620734
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 16:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gTYXTGLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CB620734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4482E21509;
	Wed, 11 Mar 2020 16:48:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01iaS3cLvImI; Wed, 11 Mar 2020 16:48:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 00B4A2011A;
	Wed, 11 Mar 2020 16:48:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBEA3C18D3;
	Wed, 11 Mar 2020 16:48:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC989C0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 16:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AB0302026D
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 16:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11OTY4US2zGN for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 16:48:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by silver.osuosl.org (Postfix) with ESMTPS id C1BA72011A
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 16:48:45 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id n13so519010lfh.5
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nvdaEzJa7BlyOVahyajCu5RaMgVluQfvfvpupgNvYPI=;
 b=gTYXTGLbY5loy6LLU50Ij4wvtWSkC1KAWrZXcHsoO1uCYD/i8UHh+Fp6H4Lfe4kdbN
 +iCHTAZrtgnoEbw/v9CPYJjmPJSY9iJAV9hHJtzdILJGtgEkVlpC0w+CR2pyEVwiAyC5
 UbZvFt+oRjc8PidJ6oJOx+Xw/Ygl8qTl+1lDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nvdaEzJa7BlyOVahyajCu5RaMgVluQfvfvpupgNvYPI=;
 b=l+iKrZvQv7Jv+e7HkOx15mZ9F0E4RYOsTamqWT4TOExa3o1x5cAghkz7UdfRB2eXAz
 Uxv0ZtHwOn6WXPygHV84HKszG6DwFY6++G9h8j0g6/2RRb20ZbdrriKHl16WC0pC7NhB
 IHuMzsCRlw8tixUzf5//Y8Cx0cNzRTiG8ZOky7qdPXILj8mMVL4Bps1P118XMLzODZUl
 jlaaQVgfs4TbFQ2N2tQuEBw3fT6AYorfMdmrlwsbsruOuekWHVoOLwjpTtrV3YagTO9y
 JlRnmGqpfX6fuMNI3kTZydpcyhyo7hE1kGdpdKIm1OCE1wrkjRGCmM4RZRQU6decF5BA
 XnYg==
X-Gm-Message-State: ANhLgQ0OF8ya/QYxClz0/oR6xddjc0mudpifgZmmFsd/m/j54SoXNAMO
 KHTgCTdmYB4NbRMtjzSdrJAjORkol1UEGA==
X-Google-Smtp-Source: ADFU+vuwK7lg8+4gMJdFzudajvClRZXAfR7TK8/MT30hJ618yH832FPmAGQs/Z4i+oQWdTp6KBAxVw==
X-Received: by 2002:ac2:41d3:: with SMTP id d19mr2751578lfi.57.1583945323035; 
 Wed, 11 Mar 2020 09:48:43 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182])
 by smtp.gmail.com with ESMTPSA id 133sm6961866ljj.91.2020.03.11.09.48.41
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 09:48:42 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id f13so3148665ljp.0
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 09:48:41 -0700 (PDT)
X-Received: by 2002:a2e:89c7:: with SMTP id c7mr2718156ljk.265.1583945321533; 
 Wed, 11 Mar 2020 09:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <bug-206175-5873@https.bugzilla.kernel.org/>
 <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de>
 <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com> <20200311154328.GA24044@lst.de>
 <20200311154718.GB24044@lst.de> <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
 <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com>
 <CAHk-=whFu_p-eiyJfiEevV=a+irzW=9LMWjMaaFSaaasXout9w@mail.gmail.com>
In-Reply-To: <CAHk-=whFu_p-eiyJfiEevV=a+irzW=9LMWjMaaFSaaasXout9w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Mar 2020 09:48:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkKCxj-U9343Tk4Bbkc7oatqq26XGdAM6JJ+X==R_iNQ@mail.gmail.com>
Message-ID: <CAHk-=whkKCxj-U9343Tk4Bbkc7oatqq26XGdAM6JJ+X==R_iNQ@mail.gmail.com>
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu <iommu@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
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

On Wed, Mar 11, 2020 at 9:24 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So it will have a different commit ID, updated message, and be a mix
> of my patch and Christoph's.

I ended up pushing it out before starting on the pull requests, so
it's out there now.

Artem, it would be good to have confirmation that my (modified) tip of
tree now works for you. I don't actually doubt it does, but a final
confirmation would be appreciated.

            Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
