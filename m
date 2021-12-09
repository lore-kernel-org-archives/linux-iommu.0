Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0197AC433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 14:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DD1842297;
	Thu,  9 Dec 2021 14:29:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IseIzCPVqKgP; Thu,  9 Dec 2021 14:29:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 551B742295;
	Thu,  9 Dec 2021 14:29:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E099C002F;
	Thu,  9 Dec 2021 14:29:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE5AC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E73FF6119D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MB-g12tcRtrx for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 14:29:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40F686119B
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:29:53 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id r11so19850554edd.9
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 06:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9cj0mtHbG/1EogjrV8DWvYZ3qqdf7FqjqdU9JmwNaoE=;
 b=UcjRt/F48WQ+88oivvHq5btKWLWP98eLCuaAlcCMhQmJOHkA8iVK9jz5B2qRE5NwCZ
 xJbBkugOnK4i0lsdQ0PYZCFRHxkvrDWGXBMOEKBuo1tUPiooxvmBZQQt7b/AidPodQnl
 KMJd7dPa4iT1mLB4w+foCa46H75L1T7IAFP4rA8yrywQe16swFcr48j7yvWRc3H5iBJe
 R4GcyW+tFfQQ6EPh8J33hjtZadnQMVEyaVpcPV6XrjH8XPALaMuxDvWvvpn8VggY64re
 WbkqgFM15dMZwubrJ+OjksRtaOIT7boFyJs7JZ7aHNAfKefBO2XvLVjUXbxzK9vLiIaY
 5G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9cj0mtHbG/1EogjrV8DWvYZ3qqdf7FqjqdU9JmwNaoE=;
 b=Pv69cGt7Jm+HXhkOD4FMw1tx0vhGAtCCD70P1vJlkG1++ZerTlWB+QufwuUHrH4kmR
 og0yzqUhhP1YHJYiV5sQmYBI0kZom6hQm7k5ZvZe94SqP4dZ0pkLR2LtXsnytAbnDl+4
 rASNscCioT+RIxXWVzmekxQAijMphAef6uFLtFbglLUW3HKhiybMQVesUDy8gQZA+miH
 +5H2hSxpD2TPT1P3yAvBDtJUG1ewIvUxqZWYWFtKwaIlA9QeiInFsvKIF0E8h1yYpC+c
 4Fkn2pD+rPmV5H/VvHXx2avpSTCqkz3Aw4B2WM2K/h+GpaZqL4XJZimDtHjW3A2I9LOj
 rrJw==
X-Gm-Message-State: AOAM532dpo8Pn/orlbS/s2XJ5uILjzUu5eggk4AkpBKFLvZr3ktbIVul
 c2VifS//zQGfZDpQUm/Q2ec=
X-Google-Smtp-Source: ABdhPJyzoHgfT0wNRHcffHzxW74cOpNqsmfXP7tjIl0bScfQZlJAg3gtAty+IICEdLo/TNpIUpAPwQ==
X-Received: by 2002:aa7:cd5c:: with SMTP id v28mr29282160edw.6.1639060147619; 
 Thu, 09 Dec 2021 06:29:07 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id j17sm1979edj.0.2021.12.09.06.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 06:29:06 -0800 (PST)
Message-ID: <3bf8d500-0c1e-92dd-20c8-c3c231d2cbed@redhat.com>
Date: Thu, 9 Dec 2021 15:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
 <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
 <YbFHsYJ5ua3J286o@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YbFHsYJ5ua3J286o@google.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 12/9/21 01:02, Sean Christopherson wrote:
> RDX, a.k.a. ir_data is NULL.  This check in svm_ir_list_add()
> 
> 	if (pi->ir_data && (pi->prev_ga_tag != 0)) {
> 
> implies pi->ir_data can be NULL, but neither avic_update_iommu_vcpu_affinity()
> nor amd_iommu_update_ga() check ir->data for NULL.
> 
> amd_ir_set_vcpu_affinity() returns "success" without clearing pi.is_guest_mode
> 
> 	/* Note:
> 	 * This device has never been set up for guest mode.
> 	 * we should not modify the IRTE
> 	 */
> 	if (!dev_data || !dev_data->use_vapic)
> 		return 0;
> 
> so it's plausible svm_ir_list_add() could add to the list with a NULL pi->ir_data.
> 
> But none of the relevant code has seen any meaningful changes since 5.15, so odds
> are good I broke something :-/
> 

Ok, I'll take this.

Paolo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
