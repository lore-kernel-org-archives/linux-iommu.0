Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E91C433F5
	for <iommu@archiver.kernel.org>; Thu, 27 Jan 2022 10:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C33F4036A;
	Thu, 27 Jan 2022 10:50:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fdC9eqGdlTIL; Thu, 27 Jan 2022 10:50:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1CB44400D7;
	Thu, 27 Jan 2022 10:50:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2FC5C0011;
	Thu, 27 Jan 2022 10:50:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7842BC000B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 10:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5053840292
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 10:50:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KaESH9eHRk06 for <iommu@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 10:50:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49FE1400D7
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 10:50:30 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id z1so971059qto.3
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 02:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/F95RwYdMvK9HG/AU2XwA1QRoH8XyM9R4nwtANcJ5fk=;
 b=sPsDr1HwEupFrnPd7Svv7MqI5xNpx6ivirsj2+MIHfSf7r8EJ1QTIm3S0B52YFQzpm
 k6k7lX7aCuQtDxlKw8RVGdJAD5PeSO3jx36LqcD7hW2n86kkS9nd+6nnfMBD4oJ1x3wh
 u7F7ZpT7F6Omnjke06e5F4I312WXgYQX59Tn6jZYdxes7XHunXiP14xJD/HfhD/BUe91
 DYUDDLJPHd2v2fX5kkjY8IblJm5Qpqi1g56N8vU83e8gKViPb0GZKaAwXPKncyU/FV39
 xpD82pjVt1neEwyR+3k9nGH/w5r8mjn3ybJ8F1ZeQPWqWpGcw5eeTiVJ7i7PSLsgQGal
 O5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/F95RwYdMvK9HG/AU2XwA1QRoH8XyM9R4nwtANcJ5fk=;
 b=UjFaYo00LiYJMxePuNWNjcK0yxd4U2NYlQSPzd4+rSlW38kpCxhJA4z+VCJozdJxqb
 7BFlrGa0OYffF5k5O2bLs+IazjD8SWfhoKQmKd6CN5OwAzsOl7IAQ9BMhk4dFJviYauw
 aSDv3WVzyOE3PgNoJIZpdVhfGaPHDSR8PPSGEC6GrUzI5R4gUi7weY6f+hQ8+a9SintB
 nxFc5Fuy7q8udy1FOLh8zvpLZsjvIHJO9dFE3FYkIdiP7LsXBMy4W56BvV6TikWThTOW
 DD/mdmwGrQjJVfLLIJRD8+o27wICanKW7YNbUWfq1K47fb94liduMGBZvfg2L3Gfr92G
 7LTA==
X-Gm-Message-State: AOAM530NgalHBCATZfb6KkSFqMrtKM3symol2lwjVZu30njYMAuBNAti
 U+u+qMqoG/M3HhO0AvIj9PXHYP+F112gawqPB6/asw==
X-Google-Smtp-Source: ABdhPJy8xAU/Buo5U/A2RnAMl8repadRILhqBYLRMHVZsi0GK3WvvWhyxabZUBoN6ZrfrIACKHySCn+sPEUKG77AoUM=
X-Received: by 2002:ac8:5fcf:: with SMTP id k15mr2143983qta.73.1643280628944; 
 Thu, 27 Jan 2022 02:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20211123161038.48009-1-mlevitsk@redhat.com>
 <20220125150832.1570-1-mike@fireburn.co.uk>
 <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
 <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
 <7809c3253a997330102b9d779206312d6b3bcaf1.camel@redhat.com>
 <CAHbf0-F8Uemcu8FVcZvY0CPOf4kFXOcaCzWF1ZCwkpa3tyut3A@mail.gmail.com>
 <6cf58a4cd925726ef10481d38f9f4e8090f5023d.camel@redhat.com>
 <CAHbf0-EY9_27Tw3v-pfwXDaTuwpsuuFqrJDKZ8C_cW+-PwXwww@mail.gmail.com>
 <495878a237748e3652619e692706b9352969f435.camel@redhat.com>
In-Reply-To: <495878a237748e3652619e692706b9352969f435.camel@redhat.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 27 Jan 2022 10:50:18 +0000
Message-ID: <CAHbf0-Ew=LPpYx6MT_Gb8oM-4egTvXuz0H7cYKZxFjFeBz=9Tw@mail.gmail.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 tglx@linutronix.de, will@kernel.org, dwmw@amazon.co.uk
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

On Thu, 27 Jan 2022 at 10:22, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Thu, 2022-01-27 at 00:39 +0000, Mike Lothian wrote:
> > On Wed, 26 Jan 2022 at 10:12, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > > Great, your system does seem to support GA log
> > > (but a patch to check if, other that assume blindly that it is supported is
> > > something that should be done).
> > >
> > > So could you bump the LOOP_TIMEOUT like by 10x or so and see if the problem goes away?
> > >
> > > (that code should be rewritten to time based wait and not just blindly loop like that,
> > > I also can prepare a patch for that as well).
> > >
> > > Best regards,
> > >         Maxim Levitsky
> > >
> >
> > Hi
> >
> > I've done quite a few restarts with the LOOP_TIMEOUT increased and
> > I've not seen the issue since
>
> Great, so the problem is solved I guess.
> Thanks for the help!
>
>
> I'll send a patch for this in few days to replace this and other similiar timeouts
> with a proper udelay() wait.
>

Thanks for your help
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
