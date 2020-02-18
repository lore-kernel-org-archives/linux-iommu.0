Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346ADC34047
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:40:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00AF124655
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbapHghK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AF124655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C79878550D;
	Tue, 18 Feb 2020 18:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9sjzNnpUD55; Tue, 18 Feb 2020 18:40:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 03AB4853E6;
	Tue, 18 Feb 2020 18:40:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E41EDC1D84;
	Tue, 18 Feb 2020 18:40:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 211EBC013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0A810853E6
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 31RllzvWo2ko for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 18:40:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 57EF18202F
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:40:23 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E2D2B24655
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582051223;
 bh=e0prGkshvWw2XTwL3+iei7JE8F3vbsgEto2sLKzoNxY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ZbapHghKemvj/oI+zpPIruW3rQ0y+/IGCFK4hWmOUDx7Vi4fNxeSS/WMkU/tOfVw6
 5U9tzmE0siFMLLMGiimacSWFAD6i3onMYAlpQEevIhoPtM05rP/W3Mn7mRRqz8OUEZ
 FvJ+rEAk2hZeuYncgmnHdz8KREoKXg7XPBgExTnc=
Received: by mail-qk1-f173.google.com with SMTP id p7so20508320qkh.10
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 10:40:22 -0800 (PST)
X-Gm-Message-State: APjAAAVEYVhPx6WO78X2KRhBM87XNELMSQr/XNHg2YMuNi1wq/PEJJHC
 Lh4IX7klNpH3OciWdLFZ3ok6HY2f0LlmdbfD1A==
X-Google-Smtp-Source: APXvYqzzc5l2bT41Ulxw896RzAsZHa163jCmWCxKmNgy3aUdTfnzFWB1uBJXqNRZFmClh71pLAlutTDYlRFRVHXfwrQ=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr20551704qkg.152.1582051221993; 
 Tue, 18 Feb 2020 10:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20200218171321.30990-1-robh@kernel.org>
 <20200218181356.09ae0779@donnerap.cambridge.arm.com>
In-Reply-To: <20200218181356.09ae0779@donnerap.cambridge.arm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Feb 2020 12:40:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJpDLn5Zr2UHno1TeReqrwZ-HAAfd78AouigGi4sAQuOw@mail.gmail.com>
Message-ID: <CAL_JsqJpDLn5Zr2UHno1TeReqrwZ-HAAfd78AouigGi4sAQuOw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Removing Calxeda platform support
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Langsdorf <mlangsdo@redhat.com>, kvm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:LIBATA SUBSYSTEM \(Serial and Parallel ATA drivers\)"
 <linux-ide@vger.kernel.org>, Will Deacon <will@kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>, soc@kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org,
 Jon Loeliger <jdl@jdl.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Alexander Graf <graf@amazon.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 linux-edac <linux-edac@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Matthias Brugger <mbrugger@suse.com>, Stephen Boyd <sboyd@kernel.org>,
 netdev <netdev@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Robert Richter <rrichter@marvell.com>, James Morse <james.morse@arm.com>,
 Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Feb 18, 2020 at 12:14 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Tue, 18 Feb 2020 11:13:10 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> Hi,
>
> > Calxeda has been defunct for 6 years now. Use of Calxeda servers carried
> > on for some time afterwards primarily as distro builders for 32-bit ARM.
> > AFAIK, those systems have been retired in favor of 32-bit VMs on 64-bit
> > hosts.
> >
> > The other use of Calxeda Midway I'm aware of was testing 32-bit ARM KVM
> > support as there are few or no other systems with enough RAM and LPAE. Now
> > 32-bit KVM host support is getting removed[1].
> >
> > While it's not much maintenance to support, I don't care to convert the
> > Calxeda DT bindings to schema nor fix any resulting errors in the dts files
> > (which already don't exactly match what's shipping in firmware).
>
> While every kernel maintainer seems always happy to take patches with a negative diffstat, I wonder if this is really justification enough to remove a perfectly working platform. I don't really know about any active users, but experience tells that some platforms really are used for quite a long time, even if they are somewhat obscure. N900 or Netwinder, anyone?
>
> So to not give the impression that actually *everyone* (from that small subset of people actively reading the kernel list) is happy with that, I think that having support for at least Midway would be useful. On the one hand it's a decent LPAE platform (with memory actually exceeding 4GB), and on the other hand it's something with capable I/O (SATA) and networking, so one can actually stress test the system. Which is the reason I was using that for KVM testing, but even with that probably going away now there remain still some use cases, and be it for general ARM(32) testing.

Does LPAE with more than 4GB actually need to work if there's not
another platform out there?

> I don't particularly care about the more optional parts like EDAC, cpuidle, or cpufreq, but I wonder if keeping in at least the rather small SATA and XGMAC drivers and basic platform support is feasible.

cpuidle isn't actually stable from what I remember. I think without
cpufreq, we default to 1.1GHz instead of 1.4.

> If YAML DT bindings are used as an excuse, I am more than happy to convert those over.

Thanks!

>
> And if anyone has any particular gripes with some code, maybe there is a way to fix that instead of removing it? I was always wondering if we could get rid of the mach-highbank directory, for instance. I think most of it is Highbank (Cortex-A9) related.

All the reset/suspend/poweroff and coherency parts are shared. The SCU
and L2 parts could be removed, but not really worth the surgery IMO.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
