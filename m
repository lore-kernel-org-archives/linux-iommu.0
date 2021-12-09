Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFFDC433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 01:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEE856069D;
	Thu,  9 Dec 2021 01:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2bEA5vCCOOHe; Thu,  9 Dec 2021 01:37:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F37860657;
	Thu,  9 Dec 2021 01:37:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67081C002F;
	Thu,  9 Dec 2021 01:37:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 318CFC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 01:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F3F98283D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 01:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LWXUWFkehfSx for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:37:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2D13827CE
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 01:37:08 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id np3so3250341pjb.4
 for <iommu@lists.linux-foundation.org>; Wed, 08 Dec 2021 17:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Uub+IbSwvrL8++vPLHy04nVi4lIQuX6pueB0R7vJJ2U=;
 b=iHwPfvXwbAm6nakAlsdpYwrT0RIU8jrGpjgoLneEfTM5vIUaoB0f6Pb1UpM6tETwX2
 aCJikC5Vfr+/Qk4u+4KXRa/2H9AdK2V2ip1H1doX0T7+cU2W9lUcvbGCJ6viyybWGYV5
 wIQhcWIUPsGn3E4dbsyVRMtahM/9GjICVYpwSz/R3j9evKuev0PZYmC6M4G958QNbWEX
 OECU3Wj9J3umEN2suXvmzUMdROlZUYvb4GVrHW+LIcJmBv2alcrtOMCuR+Xh+gSC57IT
 apbqVK1Gfq04kvNfWwShKfXCgqVO0kmDM51NYNa8a/m4OnsPBGbqQ+vyiH8I6B/E31Gf
 vwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Uub+IbSwvrL8++vPLHy04nVi4lIQuX6pueB0R7vJJ2U=;
 b=G3D3TM9NiVTB+NC0P/0ZR4WBIo7jU2Vuky1/rVQa2s5WcJNYvvJMRHtjFDsvVpEocg
 julshM7fKsTSyWBBIviih373nBZIppd9bhjRp/p5cbWEazJFy1w2nRF5DR5ktMnTxk7k
 bjZ8/a5QzCLU4MsPG1LfeaVfwOT4UYyPUC/PlYNUJIgQ6AByDTfPTAaqcfmO1y97Hz7X
 XWRH59XtrulHiRF4reeg5uueuccWmtDqe2QF8cjEAfepfTeSYIvH17XCUv+J/UWSrSdZ
 +J3FJvnExs02TvLOoduaxn+9SVY+RqCCZ4LXrtrI6eUp/67/t5CoVxRnoV1sEAwgcHOd
 u5sw==
X-Gm-Message-State: AOAM532viNItoHO4x/DyaSfETySGkpAJdKxV5/4kWPs4yKIe0JUansRW
 nJRNE7TEILVh5mEzk1NjKAQX6Q==
X-Google-Smtp-Source: ABdhPJwIMJr5dFbwijfg8NpzqGkN3MdYDUBGuiollfpqkvGJuDCIdMQ7nXvJJkacj26B4AVhBVPxuw==
X-Received: by 2002:a17:902:a60b:b0:142:7621:be0b with SMTP id
 u11-20020a170902a60b00b001427621be0bmr62849052plq.58.1639013827911; 
 Wed, 08 Dec 2021 17:37:07 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id x14sm4023275pjl.27.2021.12.08.17.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 17:37:07 -0800 (PST)
Date: Thu, 9 Dec 2021 01:37:04 +0000
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
Message-ID: <YbFdwO3RZf6dg0M5@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
 <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Jim Mattson <jmattson@google.com>
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
From: Sean Christopherson via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> On Thu, 2021-12-09 at 01:00 +0200, Maxim Levitsky wrote:
> > Probably just luck (can't reproduce this anymore) but
> > while running some kvm unit tests with this patch series (and few my patches
> > for AVIC co-existance which shouldn't affect this) I got this
> > 
> > (warning about is_running already set)

...
 
> Also got this while trying a VM with passed through device:

A tangentially related question: have you seen any mysterious crashes on your AMD
system?  I've been bisecting (well, attempting to bisect) bizarre crashes that
AFAICT showed up between v5.15 and v5.16-rc2.  Things like runqueues being NULL
deep in the scheduler when a CPU is coming out of idle.  I _think_ the issues have
been fixed as of v5.16-rc4, but I don't have a good reproducer so bisecting in
either direction has been a complete mess.  I've reproduced on multiple AMD hosts,
but never on an Intel system.  I have a sinking feeling that the issue is
relatively unique to our systems :-/

And a request: any testing and bug fixes you can throw at the AVIC changes would be
greatly appreciated.  I've been partially blocked on testing the AVIC stuff for the
better part of the week.  If the crashes I'm seeing have been resolved, then I should
be able to help hunt down the issues, but if not...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
