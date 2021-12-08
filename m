Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76C2C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 14:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64229402B5;
	Wed,  8 Dec 2021 14:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VIcYeIIlBYpm; Wed,  8 Dec 2021 14:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A12E0403B7;
	Wed,  8 Dec 2021 14:43:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 666F3C001E;
	Wed,  8 Dec 2021 14:43:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26F2FC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 14:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07B2D40249
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 14:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P6gLknjMJFH4 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 14:43:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14DBF40187
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 14:43:25 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id r25so9076510edq.7
 for <iommu@lists.linux-foundation.org>; Wed, 08 Dec 2021 06:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rorkq0kqbS106yCnMdxNh4H+tZeEZk4vhvZMtOx+RQ4=;
 b=T3mfDWm/XqaADQeVNwzK/X8+hI+FconPHoWo6op2K9PxyThxL1T38t2a3dx5Xh4PfW
 iLoTV9rja69gpLtgr66N21boCJeEsaM/jY3TU/FvTOIbVY+ARWnGgqXtahW/xOQceEz0
 eLoe43vh5rZ2SolOLIajqKHiLqQSH4YNiztYIm6KfhElEtSZ9hQJFJryyfWhiq3Qawy4
 YQm5eBbfTdRocGGCU8z81P7fSgxvnU5sCufQzM/jYiUoAptS/wsu62k+zo7LWQ8AmcwW
 17TOvUH9bJlBQJ1a7vm6ilUEt3K3Hbu1hYLMntw72EMbIuKovpldwpE56i+vdBMQunCy
 EWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rorkq0kqbS106yCnMdxNh4H+tZeEZk4vhvZMtOx+RQ4=;
 b=aj7yq/Fymlr4EP4JXAW23PWRcg5+5t4l2dJVrnmq4xp+1tozfj0RdVspN97LX5zbiH
 JUf0MiZvxW2iUsMfoLBP/8w89/5K/AP0YBYlYGfGAS00Q+HBo1PtpZ5cbdK5uKskCwqr
 qbyJRQ2M5lB3I77jhhWzmSTmlGsluPPeXMGfBrbNBqeFRhWIm0vRBJeYUut1k0jG2tVd
 Rk7SRb6J9Z1aOPBMophuk4glSe8l9kbfUPoKsa04cRriBWdAU09lYAKkJ2l8phhBAyHy
 QF1ZxWQ4d6uIRmtYd7EewU99CsSAht8wDBBOS9dUHRo5070GKXHHNsS6cexWBxj6RS0E
 sAyA==
X-Gm-Message-State: AOAM530E/JqjADXsRyGO3+oEF1UZnAfNF5l2QvF0TwnU6/lgFtArZpln
 Pdh82peLXI0ylNxg3aFUDjs=
X-Google-Smtp-Source: ABdhPJwfAih1UJbuG8DluPuj4Xflbizg9LMcjZmEsGKRCYoy5N5def2qOGTnZAHflDSy0OchG6cTIQ==
X-Received: by 2002:a17:906:5f94:: with SMTP id
 a20mr8047146eju.256.1638974601767; 
 Wed, 08 Dec 2021 06:43:21 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id oz11sm1691246ejc.81.2021.12.08.06.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Dec 2021 06:43:21 -0800 (PST)
Message-ID: <e1c4ec6a-7c1e-b96c-63e6-d07b35820def@redhat.com>
Date: Wed, 8 Dec 2021 15:43:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 21/26] KVM: SVM: Drop AVIC's intermediate
 avic_set_running() helper
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>
References: <20211208015236.1616697-1-seanjc@google.com>
 <20211208015236.1616697-22-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211208015236.1616697-22-seanjc@google.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 12/8/21 02:52, Sean Christopherson wrote:
> +	/*
> +	 * Unload the AVIC when the vCPU is about to block,_before_  the vCPU
> +	 * actually blocks.  The vCPU needs to be marked IsRunning=0 before the
> +	 * final pass over the vIRR via kvm_vcpu_check_block().  Any IRQs that
> +	 * arrive before IsRunning=0 will not signal the doorbell, i.e. it's
> +	 * KVM's responsibility to ensure there are no pending IRQs in the vIRR
> +	 * after IsRunning is cleared, prior to scheduling out the vCPU.

I prefer to phrase this around paired memory barriers and the usual 
store/smp_mb/load lockless idiom:

	/*
	 * Unload the AVIC when the vCPU is about to block, _before_
	 * the vCPU actually blocks.
	 *
	 * Any IRQs that arrive before IsRunning=0 will not cause an
	 * incomplete IPI vmexit on the source, therefore vIRR will also
	 * be checked by kvm_vcpu_check_block() before blocking.  The
	 * memory barrier implicit in set_current_state orders writing
	 * IsRunning=0 before reading the vIRR.  The processor needs a
	 * matching memory barrier on interrupt delivery between writing
	 * IRR and reading IsRunning; the lack of this barrier might be
	 * the cause of errata #1235).
	 */

Is there any nuance that I am missing?

Paolo

> +	 */
> +	avic_vcpu_put(vcpu);
> +

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
