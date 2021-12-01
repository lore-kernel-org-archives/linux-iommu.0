Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF6BC433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 02:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34BD940921;
	Wed,  1 Dec 2021 02:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55S7GdZ6j7xL; Wed,  1 Dec 2021 02:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C85C640919;
	Wed,  1 Dec 2021 02:41:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A335AC0012;
	Wed,  1 Dec 2021 02:41:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16479C000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 01:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E67B040919
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 01:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wd6Zzyla1cvu for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 01:07:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0DA7240913
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 01:07:01 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id e3so94463712edu.4
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 17:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dDTZQO1s0l0nQ4okwAIdEoHQ0YiyLaeFzWFpDGXURhI=;
 b=aKNAM/hTD2iyToIfqhdvNElGlNz9s4c/KoEOloKnsDnBEqXyqyhwYtC2k4V2Z29Ggn
 +lCXAtuOpk0iQ5eDzn4kskDCc8OBWFvZ9JqVFA5JLxu1TSSG/YxssrYsCO8FWCfa6qcM
 +z4U//Z4fsc3N5DwKeNMvUZdr2y6nHv+6d8iEYXb8tGncg6XmtgLZVXqK39wY3N63duR
 HCle84xmK41sYwEp0AQj2ovjVB2X/++iufFILpVt1GA9iC5em/e6g1rjyY9bf2VgSG5T
 vWocu4b0nzqES5H+XLSYywAOR/GNZYkfeYyv13c2VG30g6TdJDNddeC+wgPeuRcm45/o
 PBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dDTZQO1s0l0nQ4okwAIdEoHQ0YiyLaeFzWFpDGXURhI=;
 b=HLkUWEETQ2+MtNckc9fEYW0BShCkmAK7d4ZGXQLhbfzCX/7rorSey0ouDYC3MAjzos
 GkeXQP8H+xaPGIx9Cm8hoX4p1Nusu/qEHJL/YaH7/5Xjr5HR54Bstm+Q1piPl3LqLtr2
 7HFe7x7QWAo5V3cyzXIfbtFmfGWDceTjOMwqGYyd0SpjJbmUIFyjSMA3wqm5o2lno6Jk
 L6C9iKAZk724Ug9r1J8CNFwMi5dc+J3+6Pvm8iNb/r5UoripK2LZ7/Jl3nUKPR2J1tn2
 8Nute0DB+OA1WpcDIgRmd7T2sW8gB+tHuDiWbT47f3dtSdr8jtDw4KqTonwP5uBawZne
 6LiA==
X-Gm-Message-State: AOAM5320eoYeQvoi3Lut/+OB3E6X4MNbWlIeMhOJfv6nHZZzCpdE25Yc
 g8+4eV0IzufBwDejGYbt5LpRX3thzYxrd0K1pagQ
X-Google-Smtp-Source: ABdhPJxty9SzAkb0v8cwbtS2kkFtq94PrIqZjihhoj6I/Aj1LVnCBLmzhnBqErP0r0YUKFdEbazwCMhiZXkezaGEjsU=
X-Received: by 2002:a17:906:d96e:: with SMTP id
 rp14mr3105756ejb.104.1638320819895; 
 Tue, 30 Nov 2021 17:06:59 -0800 (PST)
MIME-Version: 1.0
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Nov 2021 20:06:49 -0500
Message-ID: <CAHC9VhTJG24iG=U0geO-ZhC6OogxOu4icBrNY22+qRNpWd5PBQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Ross Philipson <ross.philipson@oracle.com>,
 trenchboot-devel@googlegroups.com
X-Mailman-Approved-At: Wed, 01 Dec 2021 02:41:17 +0000
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, kanth.ghatraju@oracle.com, linux-integrity@vger.kernel.org,
 tglx@linutronix.de
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

On Fri, Aug 27, 2021 at 9:20 AM Ross Philipson
<ross.philipson@oracle.com> wrote:
>
> The larger focus of the Trechboot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity in a unified manner. The first area of
> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> Trust for Measurement).

My apologies for such a late reply, but I'm just getting around to
looking at this and I have a few questions on the basic design/flow
(below) ...

> The basic flow is:
>
>  - Entry from the dynamic launch jumps to the SL stub

So I'm clear, at this point the combined stub+kernel+initramfs+cmdline
image has already been loaded into memory and the SL stub is
executing, yes?

As TrenchBoot seems to be focused on boot measurement and not
enforcing policy, I'm guessing this is considered out-of-scope (not to
mention that the combined stub+kernel image makes this less
interesting), but has any thought been given to leveraging the TXT
launch control policy, or is it simply an empty run-everything policy?

>  - SL stub fixes up the world on the BSP
>  - For TXT, SL stub wakes the APs, fixes up their worlds
>  - For TXT, APs are left halted waiting for an NMI to wake them
>  - SL stub jumps to startup_32
>  - SL main locates the TPM event log and writes the measurements of
>    configuration and module information into it.

Since the stub+kernel image are combined it looks like the kernel
measurement comes from the ACM via the MLE measurement into PCR 18,
while the stub generated measurements are extended into PCR 19 or 20
depending on the configuration, yes?

I realize that moving the TXT code into the kernel makes this
difficult (not possible?), but one of the things that was nice about
the tboot based approach (dynamic, early launch) was that it could be
extended to do different types of measurements, e.g. a signing
authority measurement similar to UEFI Secure Boot and PCR 7.  If that
is possible, I think it is something worth including in the design,
even if it isn't initially implemented.  The only thing that
immediately comes to mind would be a section/region based approach
similar to systemd-boot/gummiboot where the (signed) kernel is kept in
a well known region and verified/measured by the stub prior to jumping
into its start point.

>  - Kernel boot proceeds normally from this point.
>  - During early setup, slaunch_setup() runs to finish some validation
>    and setup tasks.
>  - The SMP bringup code is modified to wake the waiting APs. APs vector
>    to rmpiggy and start up normally from that point.
>  - SL platform module is registered as a late initcall module. It reads
>    the TPM event log and extends the measurements taken into the TPM PCRs.

I'm sure there is some issue with passing data across boundaries, but
is there any reason why the TPM event log needs to be updated
out-of-sync with the TPM PCRs?  Is is possible to pass the
measurements to the SL platform module which would both extend the
PCRs and update the TPM event log at the same time?

>  - SL platform module initializes the securityfs interface to allow
>    asccess to the TPM event log and TXT public registers.
>  - Kernel boot finishes booting normally
>  - SEXIT support to leave SMX mode is present on the kexec path and
>    the various reboot paths (poweroff, reset, halt).

It doesn't look like it's currently implemented, but it looks like
eventually you plan to support doing a new DRTM measurement on kexec,
is that correct?  I'm sure that is something a *lot* of people
(including myself) would like to see happen.

-- 
paul moore
www.paul-moore.com
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
