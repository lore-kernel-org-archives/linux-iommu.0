Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83585C433F5
	for <iommu@archiver.kernel.org>; Fri, 21 Jan 2022 21:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 087B841716;
	Fri, 21 Jan 2022 21:40:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CPyjwQTk--uE; Fri, 21 Jan 2022 21:40:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6E09D416B9;
	Fri, 21 Jan 2022 21:40:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FDC4C0039;
	Fri, 21 Jan 2022 21:40:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3175DC002F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 21:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A5DF60EF3
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 21:40:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=paul-moore-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ln3WawF_X_E5 for <iommu@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 21:40:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F64F60AC9
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 21:40:04 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id r10so13915733edt.1
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 13:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2XzEYKOvGUCpJX1XC7Y0iE2kDUqIGFs9tTF2AQ87lvo=;
 b=1FHUwnsgGA6Odi7wwfQc5WTlGMrmy+53Pg9yOCxP/YPWosvijOtSsQksoXSMP80AN6
 zx7Sw2lu5mFVfkt9M4kv+9JfLb6cW1w8/qmu7AhBlpwYbQJR9WHKAodsaqYSUeCe2Hwn
 g7M3fvX0NEzhtiSsbTOeeU+Xr0frSH1XRWjYsrx/W18xY0sfmY3JC6o91EGUkqUwGRPh
 mqmEeJT4iUviFmC0wGbwh5lGxeZhFvb8InCG8tmpcxOqSrvQrcMuQORxFV+XztoLiyBe
 odv5PPEvge6mxsVn8eDdZRbCARMKAzxxKCu2DoWhaR56lHqLUwgqfQnPxbsnfUDxq7Z9
 mSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2XzEYKOvGUCpJX1XC7Y0iE2kDUqIGFs9tTF2AQ87lvo=;
 b=a2+3rEbYvlRNb0ab/7JQN9xb+4YTKjgPgZN/v1XO5ysSvpkqFwaX+nEt1dDkoAeU9F
 tdFqcnyeHwvlWqvjfwQiSbJtRLZa2eyWqVG6TANRJ8nR420mKJWhtWkmXy1BnSdiKtkp
 oeb6E0uHF9LAyO5yicIwiYdMkzGaWk7uIl369dCtzMTVoDEwl71qjBF0Qo/XluPMAson
 3Tn+HuzSJVwLjs353Qp/W2s/53Vu4yRwi+KpFK8OyfUqbUHUqAGluSn8PNpJa7MyE/+5
 7AmBlq7ZGIns1Qe8NEbsNkxc1w72D93FlY5bTGHrMbkwuaj+0pETsS6bNsyK/GTgH8VN
 fxWw==
X-Gm-Message-State: AOAM5328a1YWt0V4GadOKsJo5NIJbQIrAlZuAe+vipCq4zlnEV0JBduZ
 0Tbe4UXIqrdxA+M1frVMiZsRCY9QFqAPKJ26wOKG
X-Google-Smtp-Source: ABdhPJyQLJtPj7Mu2Mv0ZwC2SSr2Iox19K/oxdj+523DvOIjsMyu/b4DP8NVvcO9V+LRwi9GrtbhSc7hL9jqXgNDk14=
X-Received: by 2002:aa7:d407:: with SMTP id z7mr5819912edq.331.1642801202509; 
 Fri, 21 Jan 2022 13:40:02 -0800 (PST)
MIME-Version: 1.0
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <CAHC9VhTJG24iG=U0geO-ZhC6OogxOu4icBrNY22+qRNpWd5PBQ@mail.gmail.com>
 <456caf8c-b79a-e8b0-581f-3504240466ff@apertussolutions.com>
 <CAHC9VhSZx7j2sEs1H3ON-eDoeWdtXPC7XNQcv5D1WbnP=4Lchg@mail.gmail.com>
In-Reply-To: <CAHC9VhSZx7j2sEs1H3ON-eDoeWdtXPC7XNQcv5D1WbnP=4Lchg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jan 2022 16:39:51 -0500
Message-ID: <CAHC9VhThAbwuy+wXZfeMorc0QZ19FOfh0rk7uqaOj7uHvruM0Q@mail.gmail.com>
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

On Mon, Dec 6, 2021 at 3:56 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Dec 2, 2021 at 11:11 AM Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
> > Hi Paul!
>
> /me waves
>
> > On 11/30/21 8:06 PM, Paul Moore wrote:
> > > On Fri, Aug 27, 2021 at 9:20 AM Ross Philipson
> > > <ross.philipson@oracle.com> wrote:
> > >>
> > >> The larger focus of the Trechboot project (https://github.com/TrenchBoot) is to
> > >> enhance the boot security and integrity in a unified manner. The first area of
> > >> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> > >> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> > >> Trust for Measurement).
> > >
> > > My apologies for such a late reply, but I'm just getting around to
> > > looking at this and I have a few questions on the basic design/flow
> > > (below) ...
> >
> > No worries, thank you so much for taking the time to review.
> >
> > >> The basic flow is:
> > >>
> > >>  - Entry from the dynamic launch jumps to the SL stub
> > >
> > > So I'm clear, at this point the combined stub+kernel+initramfs+cmdline
> > > image has already been loaded into memory and the SL stub is
> > > executing, yes?
> >
> > That is correct.
> >
> > > As TrenchBoot seems to be focused on boot measurement and not
> > > enforcing policy, I'm guessing this is considered out-of-scope (not to
> > > mention that the combined stub+kernel image makes this less
> > > interesting), but has any thought been given to leveraging the TXT
> > > launch control policy, or is it simply an empty run-everything policy?
> >
> > The TrenchBoot model is a bit different and takes a more flexible
> > approach to allow users to build tailored solutions. For instance Secure
> > Launch is able to be used in a configuration that is similar to tboot.
> > Consider the functions of tboot, it has a portion that is the
> > post-launch kernel that handles the handover from the ACM and a portion
> > that provides the Verified Launch policy engine, which is only capable
> > of enforcing policy on what is contained in the Multiboot chain. The
> > TrenchBoot approach is to introduce the Secure Launch capability into a
> > kernel, in this case Linux, to handle the handover from the ACM, and
> > then transition to a running user space that can contain a distribution
> > specific policy enforcement. As an example, the TrenchBoot project
> > contributed to the uroot project a Secure Launch policy engine which
> > enables the creation of an initramfs image which can then be embedded
> > into a minimal configuration Secure Launch Linux kernel ...
>
> Thank you for the answers, that was helpful.
>
> I think I initially misunderstood TrenchBoot, thinking that a Secure
> Launch'd kernel/userspace would be the "normal" OS that would
> transition to multi-user mode and be available for users and
> applications.  However, on reading your response it appears that the
> Secure Launch'd kernel/initramfs exists only to verify a secondary
> kernel/initramfs/userspace and then kexec() into that once verified.
>
> > Finally if your schedule allows it and it is not too much to ask, it
> > would be greatly appreciated if some code review could be provided.
> > Otherwise thank you for taking the time that you have to review the
> > approach.
>
> I have to admit that I'm not sure I'm the most appropriate person to
> review all of the Intel TXT related assembly, but I could give it a
> shot as time allows.  I would think Intel would be willing to help out
> here if one were to ask nicely :)
>
> Beyond that, and with my new understanding of how TrenchBoot is
> supposed to work, I guess my only other concern is how one might
> verify the integrity of the Secure Launch environment on the local
> system during boot.  My apologies if I missed some details about that
> in your docs, responses, etc. but is this something that TrenchBoot is
> planning on addressing (or has already addressed)?

I wanted to follow-up on this thread just in case this last question
was lost ...

-- 
paul moore
paul-moore.com
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
