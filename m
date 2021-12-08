Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A713C433FE
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 15:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8306C607F9;
	Wed,  8 Dec 2021 15:43:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sOP4qCGkr6IY; Wed,  8 Dec 2021 15:43:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 76E1460669;
	Wed,  8 Dec 2021 15:43:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 526B9C002F;
	Wed,  8 Dec 2021 15:43:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD901C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC56D607F9
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FKMQHEvpdZXK for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 15:43:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9329360669
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:43:21 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id 71so2395325pgb.4
 for <iommu@lists.linux-foundation.org>; Wed, 08 Dec 2021 07:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nEv3fu5jwrCboKynxcy7NVAeh4fPLUw9uHqsDZgd59A=;
 b=CtdqoIxfk9xdbrOMMQTD4+kUl5f0wJm/9Q7ajYAIKpoFqgboCwNALpHdDi6dcih/XF
 pIOizVnHfeGbkZN995/Vnw3y6v66pk+7VvbifUlyU2gEqpzcljAb7UW3/cWLDs6/ZA2f
 2vFnWVw9HG7av5Pjky7WAx7SsaGP0aU0V36FHhYQdYvRqf3DeNvWvemXiCgHF/LL160U
 zoyWfckZ+zt2092yUQIPiZ9NxQoRIKKYEXVtYpxLoU115JZBwo2M9hVmhyAZHqRW07vT
 UgXFVaaMx7XoDTy6IC6UotxC8N3O9ChO9l6hU7eyMMhCnva3OGeJ5B1QLPzspbKj3lII
 +z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nEv3fu5jwrCboKynxcy7NVAeh4fPLUw9uHqsDZgd59A=;
 b=hWDWMtCKKi1GEzdTOmkV28/PGcWcNqwf36cZbgftM6VYq9dxDXOim4CF4/HemH8qcZ
 ne866uP8D4GD7Dk1xJ9E9LqNlthHqLtOt34YCHNp1QrAzIAMJ/BNNaqUYap2fC3QuRy7
 1btnOkd5/sG9n+cgPOV0RGue0rni99r2J0n9ScBLeaThHwU+gJSCAlxf42JOpD3Hhxlf
 93mvverfV0yd8wPeyDn47CRxe/FOuOsLN/G/B0AzNtBxyIC4Ms7MYXl3eHIFhPwgVSJv
 esS+Hf4B22dfn80zpYNcbXWJRXDfJ1QVQEBDXmG0Yc4v24ipKPNJ51x3gxgCmqSofgiP
 mw2g==
X-Gm-Message-State: AOAM532YnmvzRYESt/xwHaul3HZSxTxrhhFUFVf/1qescy0MzC7w10Z1
 y2lFVasV6j8KVNQIsbxstVt62A==
X-Google-Smtp-Source: ABdhPJw9zpx1/5+E0bsz8TnTYB1U2ApcuigLTOlRjZUB9rdeC2fT6xcf6EVUIMLNcGB+XIl8GoETLw==
X-Received: by 2002:aa7:9249:0:b0:4a2:d1c5:c94b with SMTP id
 9-20020aa79249000000b004a2d1c5c94bmr6426491pfp.45.1638978200789; 
 Wed, 08 Dec 2021 07:43:20 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id h26sm2940774pgm.68.2021.12.08.07.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 07:43:20 -0800 (PST)
Date: Wed, 8 Dec 2021 15:43:16 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 21/26] KVM: SVM: Drop AVIC's intermediate
 avic_set_running() helper
Message-ID: <YbDSlNsY8b2O8PtM@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <20211208015236.1616697-22-seanjc@google.com>
 <e1c4ec6a-7c1e-b96c-63e6-d07b35820def@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1c4ec6a-7c1e-b96c-63e6-d07b35820def@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
 iommu@lists.linux-foundation.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
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

On Wed, Dec 08, 2021, Paolo Bonzini wrote:
> On 12/8/21 02:52, Sean Christopherson wrote:
> > +	/*
> > +	 * Unload the AVIC when the vCPU is about to block,_before_  the vCPU
> > +	 * actually blocks.  The vCPU needs to be marked IsRunning=0 before the
> > +	 * final pass over the vIRR via kvm_vcpu_check_block().  Any IRQs that
> > +	 * arrive before IsRunning=0 will not signal the doorbell, i.e. it's
> > +	 * KVM's responsibility to ensure there are no pending IRQs in the vIRR
> > +	 * after IsRunning is cleared, prior to scheduling out the vCPU.
> 
> I prefer to phrase this around paired memory barriers and the usual
> store/smp_mb/load lockless idiom:

I've no objection to that, my goal is/was purely to emphasize the need to manually
process the vIRR after clearing IsRunning.
 
> 	/*
> 	 * Unload the AVIC when the vCPU is about to block, _before_
> 	 * the vCPU actually blocks.
> 	 *
> 	 * Any IRQs that arrive before IsRunning=0 will not cause an
> 	 * incomplete IPI vmexit on the source,

It's not just IPIs, the GA log will also suffer the same fate.  That's why I
didn't mention incomplete VM-Exits.  I'm certainly not opposed to that clarification,
but I don't want readers to walk away thinking this is only a problem for IPIs.

> therefore vIRR will also

"s/vIRR will/the vIRR must" to make it abundantly clear that checking the vIRR
is effectively a hard requirement.

> 	 * be checked by kvm_vcpu_check_block() before blocking.  The
> 	 * memory barrier implicit in set_current_state orders writing

set_current_state()

> 	 * IsRunning=0 before reading the vIRR.  The processor needs a
> 	 * matching memory barrier on interrupt delivery between writing
> 	 * IRR and reading IsRunning; the lack of this barrier might be

Missing the opening paranthesis.

> 	 * the cause of errata #1235).
> 	 */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
