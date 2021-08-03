Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5E3C43216
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 00:35:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0825F60F93
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 00:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0825F60F93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2DC4401C9;
	Tue,  3 Aug 2021 00:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YBEhelOBNhDG; Tue,  3 Aug 2021 00:35:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 575B2400A9;
	Tue,  3 Aug 2021 00:35:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 390F4C001A;
	Tue,  3 Aug 2021 00:35:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A6ADC000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 00:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74C1182B53
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 00:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BTOpnnBu11FN for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 00:35:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4812882B49
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 00:35:13 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id nh14so15751288pjb.2
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 17:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5xi7k8IuxcGb5LOBYAbguxfQfTtnnwxeja/w2hdMqvk=;
 b=BPBmBK6Oa9Fz1/ejFbBvP9PntE5M4Y/6SY4aMOApSL2NBqNeYpiuuKQDXikcP2is+8
 KwthFSUh59S+lqmZMHGQL/iqOYk5FHP9SnNinoO4RO1xwhcM5rgxlMILuWQmOKxcAIPn
 zJeKBCiGKcqtCYJZisFLf8biie1/ZYgMr5jveWfaC7x1qCTFlIIrCJZk1gP3QbL2B3La
 Ki8/oXSrAOROvW1S45zSi238dvzbRFlHJnddY1BZDizVXmVMNUBr92JGVnZXe7iI0YEZ
 CtoFFJcaY3q9gKDkWDB+mb3Sj0a3DGfi6gqy+vFZujkPJ+AkR329+XyiHF4N0jYmEkuh
 IbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5xi7k8IuxcGb5LOBYAbguxfQfTtnnwxeja/w2hdMqvk=;
 b=B7JQAokbCKQ3KooNMvxVjqMC1a7fBp+9qltBKBB1gfl/10O/l0r3mpw5+QDjmkqci1
 MGL3vTWI6rIB4KI+L2ZbfAYLOEjXDwvdyy5gqBnZd8s88csfr68U6+b+C2SKBq0GD1/B
 32MTDz1U3NxXvMx+SvUYvePvkqrwp8ly3xnWREmTD5k4hqvLFiQlRUFwgv9EysyAgO+r
 PQBdfZWH1KuQRPQtyiNogfTRxuuKdg1aXr30atz5JMJVY5yMCKhgBVzoC2NTsJ2Optzb
 GG3PMtbEUuEzPZcrIRmx+zCPGhjx3lpA0NV0WcbMjpnhq0/4sqpWUN2h8nXIH73WqeXg
 Jo7g==
X-Gm-Message-State: AOAM530Qmm1sHJOQazF0PLXTxf4Yxw3WktI6j0ofw3OiH70hoWv6rXjx
 UN7WoloQrdBK/1tmkze/y2Tgx8CtHRwjjM4hO3WtZg==
X-Google-Smtp-Source: ABdhPJyD/SoLzWfUHi1/eto0p7V/jbYQ+j7Zgt/Ff2rWqOX90CU7XVmBN71cEqRz0BEe3ypUcORU14MWzQ39UTDFVTA=
X-Received: by 2002:a17:90b:1a92:: with SMTP id
 ng18mr20057710pjb.86.1627950912360; 
 Mon, 02 Aug 2021 17:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org>
 <CAD=FV=U_mKPaGfWyN1SVi9S2hPBpG=rE_p89+Jvjr95d0TvgsA@mail.gmail.com>
 <e3555c49-2978-355f-93bb-dbfa7d09cab8@arm.com>
 <CAD=FV=XaTqNDn=vLEXfJ2dV+EH2UoxPfzWeiS+_sZ9hrQ274bw@mail.gmail.com>
 <CACK8Z6FV+QYR01=aP4AT8rNUQMkX-WwesHzf5XY8465KuUZ=_Q@mail.gmail.com>
In-Reply-To: <CACK8Z6FV+QYR01=aP4AT8rNUQMkX-WwesHzf5XY8465KuUZ=_Q@mail.gmail.com>
Date: Mon, 2 Aug 2021 17:34:36 -0700
Message-ID: <CACK8Z6Hzy+t05kY0VGwEnzcHZXgg9BAuS+DmRf3==J+G62qXgQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To: Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Joel Fernandes <joel@joelfernandes.org>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Saravana Kannan <saravanak@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Sonny Rao <sonnyrao@chromium.org>,
 Vlastimil Babka <vbabka@suse.cz>, Randy Dunlap <rdunlap@infradead.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Rob,

On Mon, Aug 2, 2021 at 5:09 PM Rajat Jain <rajatja@google.com> wrote:
>
> Hi Robin, Doug,
>
> On Wed, Jul 14, 2021 at 8:14 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jul 13, 2021 at 11:07 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 2021-07-08 15:36, Doug Anderson wrote:
> > > [...]
> > > >> Or document for the users that want performance how to
> > > >> change the setting, so that they can decide.
> > > >
> > > > Pushing this to the users can make sense for a Linux distribution but
> > > > probably less sense for an embedded platform. So I'm happy to make
> > > > some way for a user to override this (like via kernel command line),
> > > > but I also strongly believe there should be a default that users don't
> > > > have to futz with that we think is correct.
> > >
> > > FYI I did make progress on the "punt it to userspace" approach. I'm not
> > > posting it even as an RFC yet because I still need to set up a machine
> > > to try actually testing any of it (it's almost certainly broken
> > > somewhere), but in the end it comes out looking surprisingly not too bad
> > > overall. If you're curious to take a look in the meantime I put it here:
> > >
> > > https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/fq

BTW, is there another mirror to this? I (and another colleague) are
getting the following error when trying to clone it:

rajatja@rajat2:~/rob_iommu$ git clone
https://git.gitlab.arm.com/linux-arm/linux-rm.git
Cloning into 'linux-rm'...
remote: Enumerating objects: 125712, done.
remote: Counting objects: 100% (125712/125712), done.
remote: Compressing objects: 100% (41203/41203), done.
error: RPC failed; curl 18 transfer closed with outstanding read data remaining
error: 804 bytes of body are still expected
fetch-pack: unexpected disconnect while reading sideband packet fatal:
early EOF
fatal: fetch-pack: invalid index-pack output rajatja@rajat2:~/rob_iommu$

We've tried both git and https methods.

>
> I was wondering if you got any closer to testing / sending it out? I
> looked at the patches and am trying to understand, would they also
> make it possible to convert at runtime, an existing "non-strict"
> domain (for a particular device) into a "strict" domain leaving the
> other devices/domains as-is? Please let me know when you think your
> patches are good to be tested, and I'd also be interested in trying
> them out.
>
> >
> > Being able to change this at runtime through sysfs sounds great and it
> > fills all the needs I'm aware of, thanks! In Chrome OS we can just use
> > this with some udev rules and get everything we need.
>
> I still have another (inverse) use case where this does not work:
> We have an Intel chromebook with the default domain type being
> non-strict. There is an LTE modem (an internal PCI device which cannot
> be marked external), which we'd like to be treated as a "Strict" DMA
> domain.
>
> Do I understand it right that using Rob's patches, I could potentially
> switch the domain to "strict" *after* booting (since we don't use
> initramfs), but by that time, the driver might have already attached
> to the modem device (using "non-strict" domain), and thus the damage
> may have already been done? So perhaps we still need a device property
> that the firmware could use to indicate "strictness" for certain
> devices at boot?
>
> Thanks,
> Rajat
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
