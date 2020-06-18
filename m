Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A1CC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 09:14:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD83B21924
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 09:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUiFmMiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD83B21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A747286FB2;
	Thu, 18 Jun 2020 09:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B2Zyq2oVW19F; Thu, 18 Jun 2020 09:14:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3CA586D47;
	Thu, 18 Jun 2020 09:14:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85ED3C088C;
	Thu, 18 Jun 2020 09:14:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D928C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 09:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1271720418
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 09:14:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MDh6gklYvati for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 09:14:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 626B62002F
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 09:14:54 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id d6so2387051pjs.3
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z8nLtniSUTwDDfd3xamrlaMHNc2J6LLLxRRAmrLugfc=;
 b=WUiFmMizj/e43QF9f4A66+T2uWZtKintH+n9ALWbkqK9xh+j7F8ZiQgw9pxlheUeGH
 t3Oi01AlXPbcpdZ0puHr4Khua7Rh8QX/l/Da8aBvz2upfYTo+WDUJYpUx6nvti10A9RY
 pPFrour+Wkan5hwTVsHSegYeG3TD1ki5Qcqy46mKt9GV25ybvb7aDLlMDYc59xXSfSph
 nje/NsQPFrHQp/aKc4YOKpgdQ2kn5OolMEBD3obDZvJeCKYMLfyVSeS0DUTaLDRh9l2J
 dvTzSlFKPYnuDUGIqjOTZlVjJXNth4e7FCH2uT2N7yUUzoYRlaY858tGJ2yCw8HNco+Q
 nuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z8nLtniSUTwDDfd3xamrlaMHNc2J6LLLxRRAmrLugfc=;
 b=l7g9kohNYI5UmJU4sz4Rhvh/LSuGnOnNZ6qNcAqcttUZnBBUEdf72wh4bBw0IqsJnv
 Osm3puK3/4hZT+3BW6Y7NMZx3dKQFkWsxrWwgZe6Xf/xLylcy/kqbIT4Dy5yjArtyj0k
 iP8Wv6oQCYmbKbQt/5CiyflGF+3Q1NuKG1sTm9eJyJdpkMTtwMK4BeBjcZ0UBkTcvuQv
 pPhqF+0HbI2E1U2d/sEGno8UQTn4+JnFHK0+nb6AoYJVOXvZGBlc0pxbf6vP2hpQwPj/
 4Tqs3jNR40M0BNfV7A7r4JCEmqIf/9Y+LsEnlOOw+1rVviHCfEPzmdvotjWdu0yY3jbg
 rrDg==
X-Gm-Message-State: AOAM533qhQvFHzb2EJLLxo0sgzdfmXFCNt0EN99tSsPIT1ink2qdLZi/
 CR1ZR70FAskpNirHA68sliqozxbIfUSAgmINb+Y=
X-Google-Smtp-Source: ABdhPJy19VeWbUl1qm2WmtP0kQGdDEXszOr6FW5/f3pi9L1oha0kncME731SjRkGY9uycpokgvt/SCosojgEDUDVq64=
X-Received: by 2002:a17:90a:220f:: with SMTP id
 c15mr3418248pje.129.1592471693834; 
 Thu, 18 Jun 2020 02:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
 <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
 <20200618083646.GA1066967@kroah.com>
In-Reply-To: <20200618083646.GA1066967@kroah.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Jun 2020 12:14:41 +0300
Message-ID: <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Diego Rivas <diegorivas@google.com>, Rajat Jain <rajatja@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Oliver O'Halloran <oohall@gmail.com>,
 Benson Leung <bleung@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Alex Levin <levinale@google.com>
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

On Thu, Jun 18, 2020 at 11:36 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > ...
> >
> > > (and likely call it "external" instead of "untrusted".
> >
> > Which is not okay. 'External' to what? 'untrusted' has been carefully
> > chosen by the meaning of it.
> > What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> > tables, but I can replace it.
>
> Then your ACPI tables should show this, there is an attribute for it,
> right?

There is a _PLD() method, but it's for the USB devices (or optional
for others, I don't remember by heart). So, most of the ACPI tables,
alas, don't show this.

> > This is only one example. Or if firmware of some device is altered,
> > and it's internal (whatever it means) is it trusted or not?
>
> That is what people are using policy for today, if you object to this,
> please bring it up to those developers :)

> > So, please leave it as is (I mean name).
>
> firmware today exports this attribute, why do you not want userspace to
> also know it?
>
> Trust is different, yes, don't get the two mixed up please.  That should
> be a different sysfs attribute for obvious reasons.

Yes, as a bottom line that's what I meant as well.

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
