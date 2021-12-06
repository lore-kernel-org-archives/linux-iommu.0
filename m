Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C53C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 20:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1408B40E46;
	Mon,  6 Dec 2021 20:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ijgjgI_tN5fZ; Mon,  6 Dec 2021 20:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9701E40947;
	Mon,  6 Dec 2021 20:56:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FACEC001E;
	Mon,  6 Dec 2021 20:56:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99BDDC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 20:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81E1060DA0
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 20:56:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=paul-moore-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ajbl6YG9kYTT for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 20:56:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EFDCA60D9D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 20:56:45 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id w1so48221458edc.6
 for <iommu@lists.linux-foundation.org>; Mon, 06 Dec 2021 12:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SPIEvU27nJzVjEldPndh6AIS3bn8rbbKEjqvujfESAs=;
 b=sqwrKYiuzMi5dmssg4GlXv9w5rXRuhpdynng6r31rrdUObFVM64iPlAGLY+IA6nJ/m
 1gWVgyo7h8UJSqiNk8kHnQBl3DslIrDGeQY/YI4e8xSZwdJRLRPILwtK2RvxOIlaDPjC
 OBpGK2HLI8rTM8NspupF8U0OMeFFkOlxbGDEdtu/HKjDnBfhz0fkSnyY621D4Xsbi4/b
 3ST5UtyYqeWW1cHbeOb480Uy4eW1eKVVgbiLR6jyCICedfyJJmGjtpyRESSiCOiDt3JU
 DhRelVF98isI2imEImS6IZhbw31inMErIQFNgiZw9xj2I71NmXJtHWWx+Lg6R3ctNEeU
 pQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SPIEvU27nJzVjEldPndh6AIS3bn8rbbKEjqvujfESAs=;
 b=dRiCZ2NK79RGPArGcR6bNO+SAO676iUToDNLcBth0kGQNMXc8E6z/2a1w9OL9AFnu+
 WvEeDGMiUSPaHzVPwdwFM0WO9ONylwqz9Hubhw2fJNBOnHtyl+Q0LXMxywsJIi1dMifC
 AB0vNfp1yyQNIczJj4OO2+iv4iAgQTVLZrGGeE1Xmz3Ogn75M9bhtphFKhrs6Wr0Kcrj
 Yru8OZTQzyFcotG4uKB+wkkP6IlvbltunctZK2/EvPcgB+ZMSNHwyVg2IDGeoqzOBJS0
 fpxGwkNySt+kjwoE8frY+DP9iBL0yqgnrB9eOrxsQSPaWExx04dwukNf1Ug7GW1H1Ccf
 CWpA==
X-Gm-Message-State: AOAM531qXOBi61AtPldCcTpRaW7DooKZ0P7AQKY/utInUffZ+Axv0gfq
 A2nSMOaHaZQaGFT82IRMBqcUli74G7JUI8x1zglq
X-Google-Smtp-Source: ABdhPJyGSChgdU/2qHILkiKTMa1sAUYPNsA9phsLkYfr2JydqmXGaS1LTwjvs5zpRZPdPLscuqOdPR5Q9zocilnkoek=
X-Received: by 2002:a17:907:9196:: with SMTP id
 bp22mr46000620ejb.69.1638824203940; 
 Mon, 06 Dec 2021 12:56:43 -0800 (PST)
MIME-Version: 1.0
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <CAHC9VhTJG24iG=U0geO-ZhC6OogxOu4icBrNY22+qRNpWd5PBQ@mail.gmail.com>
 <456caf8c-b79a-e8b0-581f-3504240466ff@apertussolutions.com>
In-Reply-To: <456caf8c-b79a-e8b0-581f-3504240466ff@apertussolutions.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Dec 2021 15:56:33 -0500
Message-ID: <CAHC9VhSZx7j2sEs1H3ON-eDoeWdtXPC7XNQcv5D1WbnP=4Lchg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: linux-doc@vger.kernel.org, Ross Philipson <ross.philipson@oracle.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, kanth.ghatraju@oracle.com, linux-integrity@vger.kernel.org,
 trenchboot-devel@googlegroups.com, tglx@linutronix.de
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

On Thu, Dec 2, 2021 at 11:11 AM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
> Hi Paul!

/me waves

> On 11/30/21 8:06 PM, Paul Moore wrote:
> > On Fri, Aug 27, 2021 at 9:20 AM Ross Philipson
> > <ross.philipson@oracle.com> wrote:
> >>
> >> The larger focus of the Trechboot project (https://github.com/TrenchBoot) is to
> >> enhance the boot security and integrity in a unified manner. The first area of
> >> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> >> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> >> Trust for Measurement).
> >
> > My apologies for such a late reply, but I'm just getting around to
> > looking at this and I have a few questions on the basic design/flow
> > (below) ...
>
> No worries, thank you so much for taking the time to review.
>
> >> The basic flow is:
> >>
> >>  - Entry from the dynamic launch jumps to the SL stub
> >
> > So I'm clear, at this point the combined stub+kernel+initramfs+cmdline
> > image has already been loaded into memory and the SL stub is
> > executing, yes?
>
> That is correct.
>
> > As TrenchBoot seems to be focused on boot measurement and not
> > enforcing policy, I'm guessing this is considered out-of-scope (not to
> > mention that the combined stub+kernel image makes this less
> > interesting), but has any thought been given to leveraging the TXT
> > launch control policy, or is it simply an empty run-everything policy?
>
> The TrenchBoot model is a bit different and takes a more flexible
> approach to allow users to build tailored solutions. For instance Secure
> Launch is able to be used in a configuration that is similar to tboot.
> Consider the functions of tboot, it has a portion that is the
> post-launch kernel that handles the handover from the ACM and a portion
> that provides the Verified Launch policy engine, which is only capable
> of enforcing policy on what is contained in the Multiboot chain. The
> TrenchBoot approach is to introduce the Secure Launch capability into a
> kernel, in this case Linux, to handle the handover from the ACM, and
> then transition to a running user space that can contain a distribution
> specific policy enforcement. As an example, the TrenchBoot project
> contributed to the uroot project a Secure Launch policy engine which
> enables the creation of an initramfs image which can then be embedded
> into a minimal configuration Secure Launch Linux kernel ...

Thank you for the answers, that was helpful.

I think I initially misunderstood TrenchBoot, thinking that a Secure
Launch'd kernel/userspace would be the "normal" OS that would
transition to multi-user mode and be available for users and
applications.  However, on reading your response it appears that the
Secure Launch'd kernel/initramfs exists only to verify a secondary
kernel/initramfs/userspace and then kexec() into that once verified.

> Finally if your schedule allows it and it is not too much to ask, it
> would be greatly appreciated if some code review could be provided.
> Otherwise thank you for taking the time that you have to review the
> approach.

I have to admit that I'm not sure I'm the most appropriate person to
review all of the Intel TXT related assembly, but I could give it a
shot as time allows.  I would think Intel would be willing to help out
here if one were to ask nicely :)

Beyond that, and with my new understanding of how TrenchBoot is
supposed to work, I guess my only other concern is how one might
verify the integrity of the Secure Launch environment on the local
system during boot.  My apologies if I missed some details about that
in your docs, responses, etc. but is this something that TrenchBoot is
planning on addressing (or has already addressed)?

-- 
paul moore
www.paul-moore.com
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
