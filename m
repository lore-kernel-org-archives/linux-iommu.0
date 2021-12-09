Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD09C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 00:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47F7F4027F;
	Thu,  9 Dec 2021 00:04:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGvFUv7nhhNf; Thu,  9 Dec 2021 00:04:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 58A8C40143;
	Thu,  9 Dec 2021 00:04:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E019C002F;
	Thu,  9 Dec 2021 00:04:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF9DFC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 00:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCF4B606C0
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 00:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XLEclttgHkRS for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:04:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F156F6068F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 00:04:45 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id q17so2624868plr.11
 for <iommu@lists.linux-foundation.org>; Wed, 08 Dec 2021 16:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MjUeHzzA4V17niQyufwkdrBEp0f65mLMF1fq0crIpW0=;
 b=b+3DMK2d5mC+XSKmwavtEEUhdxeN1Sx6VF8/i5xEOkF77+HhxFlS7HOatJxHNY6/nb
 PJfVeM/FZc53xg2Gm0RZKK3pjNka3g8c/tYglsPigPaiobRgBBAPlGbUvxoHlsHCHiUc
 YehYKmEOkc5137JM/L8YYXEfZTttkn66sk9+26uVrXO6Efykk+1T5nWhC7z4ZoGxT5zY
 qfP3qKjUB45LJk3MFpQvmhN2An5vk5coeZt786iJr9cey0YWSe2SZw3NC+Tjk7qc+S/P
 nBgfKZ2T3uD1CJW9x1r5EhNEYNtGIDrpOIuLhWfyb8yBYCpN0gd+nvxAsJloYZ9tf3QQ
 ZGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MjUeHzzA4V17niQyufwkdrBEp0f65mLMF1fq0crIpW0=;
 b=VC3G2Kj2I/Zq8C6LjzXqWO9fSO2A3UcTJNUtcCxmAu5j4ZZSe9gveFGjkPeWoMB+bW
 iZo9XkgPxaeADOp78Dwk77i87DvSmZuGzQwbeS/1eBLjuT0PgVHlI4KgyEqDXpQ2ZNlQ
 2xxf+iCQfzIODXfEZ3LBlVRDX10nUvMr/1N7F/kPdkdKX5xscFu83SZ+D2Se7pmK0FXu
 hFh6bs8Mn6shnhGnTO2MgjpXDNuZwzFXsZ2NRtd6xVkxSwYCPAY5Sx3oaee3BB68cLwW
 gB+1cksw1F07LIbOxkY9Bnl241RTibHIGsUgtInq0T+m2W6IutB65arsQLr/wNC+J4HD
 8IGQ==
X-Gm-Message-State: AOAM530ohyYHHpz5IK+W6WDjsszlrPBDg6KHTLzgE6JLH+DqW53IQ8Re
 MXgpbxMqK0fJMdr86bT2/fsW9w==
X-Google-Smtp-Source: ABdhPJyiv63F9ZJKJny3hjVwxro5UZyYEhLuM/dB7Sc4H0wX9hjkGjpGw/qXP8w5pVdLRhJLyjjXmQ==
X-Received: by 2002:a17:90b:1b0a:: with SMTP id
 nu10mr11290342pjb.35.1639008285121; 
 Wed, 08 Dec 2021 16:04:45 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id z4sm4946183pfh.15.2021.12.08.16.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 16:04:44 -0800 (PST)
Date: Thu, 9 Dec 2021 00:04:41 +0000
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
Message-ID: <YbFIGSeukbquyoQ5@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
 <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
 <6f0dc26c78c151814317d95d4918ffddabdd2df1.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6f0dc26c78c151814317d95d4918ffddabdd2df1.camel@redhat.com>
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
> Host crash while running 32 bit VM and another 32 bit VM nested in it:
> 
> [  751.182290] BUG: kernel NULL pointer dereference, address: 0000000000000025
> [  751.198234] #PF: supervisor read access in kernel mode
> [  751.209982] #PF: error_code(0x0000) - not-present page
> [  751.221733] PGD 3720f9067 P4D 3720f9067 PUD 3720f8067 PMD 0 
> [  751.234682] Oops: 0000 [#1] SMP
> [  751.241857] CPU: 8 PID: 54050 Comm: CPU 8/KVM Tainted: G           O      5.16.0-rc4.unstable #6
> [  751.261960] Hardware name: LENOVO 20UF001CUS/20UF001CUS, BIOS R1CET65W(1.34 ) 06/17/2021
> [  751.280475] RIP: 0010:is_page_fault_stale.isra.0+0x2a/0xa0 [kvm]

...

> Oh well, not related to the patch series but just that I don't forget.
> I need to do some throughfull testing on all the VMs I use.

This is my goof, I'll post a fix shortly.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
