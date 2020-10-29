Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC2C2D0A3
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 17:20:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBA020759
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 17:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCwHtNb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBA020759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C036E86C23;
	Thu, 29 Oct 2020 17:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4KtaGljgdfkw; Thu, 29 Oct 2020 17:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 90E2186C15;
	Thu, 29 Oct 2020 17:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81339C088B;
	Thu, 29 Oct 2020 17:20:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29688C0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 17:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 226A387532
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 17:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EG205g6kjKMn for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 17:20:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EF27A874FE
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 17:20:51 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id x20so2615100qkn.1
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bgET2vKXyCysvHtuVXHC8x2bsoHr9I9pVPGZuJ2I2ok=;
 b=kCwHtNb0aDqVERdhKoxZMhicLRZ2QR3PolGpflI38e1AZzBFPmngVCvkULn12HaIpd
 xNZsE0KTf8SFsTeciNeDfLB2b8eo7aWwi+oWAp/jGZANfyHEmSTDAiXW3x245FjthbK+
 cNyymvnYwa4RgDaOm832TsIoNGN5VteNRutW9xIM3LOXzwfrz3rFIbB2qhaahGSK3KWZ
 rcjSGv+Lrv3xXtp7IhxItj2ThU4R1TxkB1brB4zm0qayhFjR52RmdpupiWUa8/437Az6
 Z5hmy1fEbRMjrq5fMw2J1qv+hvc2qIZX/q2dYGHrv1hoTM8Kgy/UG1ajYtjFlzWenf9F
 /BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=bgET2vKXyCysvHtuVXHC8x2bsoHr9I9pVPGZuJ2I2ok=;
 b=Hug8SbGhvVDI3CWLrFba7G3VdopbHtQ4SIq16Cgcy4OBQZtZqYelEKhs+AOTIQfcy2
 DEPQAns4X2Ikfi9AKc7ZmvM7srfzenIri0QyTIZZosmkMeZLPc1AGG+psVIefaOBNMGC
 sPtApDc1c6hSMPXainv+JtQQwSDah5kh4rn4DnnEgbKRJKTkbgm+4yU015DqIKVcJ06Q
 fgaLxksryW4ijnRIOMJyDcuL61/2WzcpeK7b2fFp/ISHvJM4TIp2oAMbSWX9fzl5S/IG
 RCEYW4EcrDIYbutNpB2tHGWvLoCTkVBxezSNTjgmODjDRjnIaDvFxvHWApE+DF0/JtAZ
 HnMw==
X-Gm-Message-State: AOAM532OvvozVxuvOxyayMsmQqcjlQjESxlEN5jv+ON1t9YJN3Yqe/22
 ICUZ+uTV9+NFJz7+HC8377s=
X-Google-Smtp-Source: ABdhPJxpj2lHqddfkMCdJsg7kjoxJdmwW/wIVKjCyqCU3W25AK0ciYoXUlV7HQMe/OgzwbBLEfxGlQ==
X-Received: by 2002:a05:620a:130a:: with SMTP id
 o10mr4612780qkj.63.1603992050890; 
 Thu, 29 Oct 2020 10:20:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
 by smtp.gmail.com with ESMTPSA id m33sm1432097qtb.65.2020.10.29.10.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 10:20:50 -0700 (PDT)
From: Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date: Thu, 29 Oct 2020 13:20:48 -0400
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] [v2] x86: apic: avoid -Wshadow warning in header
Message-ID: <20201029172048.GA2571425@rani.riverdale.lan>
References: <20201028212417.3715575-1-arnd@kernel.org>
 <38b11ed3fec64ebd82d6a92834a4bebe@AcuMS.aculab.com>
 <20201029165611.GA2557691@rani.riverdale.lan>
 <93180c2d-268c-3c33-7c54-4221dfe0d7ad@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <93180c2d-268c-3c33-7c54-4221dfe0d7ad@redhat.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Wanpeng Li <wanpengli@tencent.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 Arvind Sankar <nivedita@alum.mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Arnd Bergmann <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Jim Mattson <jmattson@google.com>, 'Arnd Bergmann' <arnd@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Laight <David.Laight@ACULAB.COM>, Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Thu, Oct 29, 2020 at 05:59:54PM +0100, Paolo Bonzini wrote:
> On 29/10/20 17:56, Arvind Sankar wrote:
> >> For those two just add:
> >> 	struct apic *apic = x86_system_apic;
> >> before all the assignments.
> >> Less churn and much better code.
> >>
> > Why would it be better code?
> > 
> 
> I think he means the compiler produces better code, because it won't
> read the global variable repeatedly.  Not sure if that's true,(*) but I
> think I do prefer that version if Arnd wants to do that tweak.
> 
> Paolo
> 
> (*) if it is, it might also be due to Linux using -fno-strict-aliasing
> 

Nope, it doesn't read it multiple times. I guess it still assumes that
apic isn't in the middle of what it points to: it would reload the
address if the first element of *apic was modified, but doesn't for
other elements. Interesting.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
