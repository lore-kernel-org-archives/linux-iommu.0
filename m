Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E749C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 09:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89E2783E63;
	Wed,  8 Dec 2021 09:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09i8dAPazJ_B; Wed,  8 Dec 2021 09:04:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7814683E80;
	Wed,  8 Dec 2021 09:04:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DF82C001E;
	Wed,  8 Dec 2021 09:04:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A1EDC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 09:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3028740A09
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 09:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XCvv88tVBHjt for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 09:04:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BF7F409F1
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 09:04:09 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id x15so6126024edv.1
 for <iommu@lists.linux-foundation.org>; Wed, 08 Dec 2021 01:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Qn1VpNU5jS3SEjxYjRvbAZU0c7iKvv67I84Jy0NPUuA=;
 b=g3DSJJvsXNADP3nDn+EuLQH3pEarOmveuZdH3oex6+0UzQZQR6Mm3qmzn0DVc7f6wB
 Xwd+8ow8jHc1OqWWGckFcLnlWpzxKwQMsCxAMdcPyYYFc8/qFBVS8o/iaB6u2kC+MShm
 O5KwYIe4CBhnXbNSNjjGnpnbeBHMa4ForcW2Ufnh0u12IIuSR41rca0kjSTjNcmsSSGS
 IQj6hgawKJL2IVDPLfPIjUlvAd2f7Ai6lL/Hh5FcbJm81KjKlvQt/Fe5T3qrDS6nIKVo
 jqyglm0wqFa+phEBOVY+THGQuZdUCBW0Uee63BirJxL0FkvgVtt2h4rLpNpZBSioZ0k+
 Bd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Qn1VpNU5jS3SEjxYjRvbAZU0c7iKvv67I84Jy0NPUuA=;
 b=oTFQdMmAjpLgJ41W3QvOMqH0pwqmbj7ZciU41OdcMAscL9Whz4VBCW/Rt7xAzwoLO0
 UuopGk0YfGf6HJfIDgmFYWga63ky2qnD1FgVxT36tK7824G4Tu+QQUi67UC3B8Zbb0VJ
 3gsL71FKfmerOnLtlM9mYoBa9ipEeHt1KMJvQfCrCFlNYyAaqDPoNiCHNPpBO4H9MGhY
 xA2PlCMTpu7Wm5KEr6//HHKs/Z+CdDvQEGiSSxgldkoow/vsLs9/85Dnh6UYwb+Wtvn5
 51sOFb4qlreJF6iCg3gE8w8JeEhiRxSkUG9d3nBoPrUZJc9bmBTBWrHQ9hneYYO/Gltp
 TqXg==
X-Gm-Message-State: AOAM532wdfClmG3KBXbN22st+xVNzq4bqVC5ONeMBJ/dYdfAfX0LzxTj
 VP5tH03HJEnySomBQ+3UYyg=
X-Google-Smtp-Source: ABdhPJzHGTbq2Uakezo3is2FI3Tb++4C+nyUcrsCN1578HqBvtNqFSYsulWqoqyqhmDqZPLIYSEXnw==
X-Received: by 2002:a17:906:9750:: with SMTP id
 o16mr5919463ejy.263.1638954247442; 
 Wed, 08 Dec 2021 01:04:07 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id nd36sm1191641ejc.17.2021.12.08.01.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Dec 2021 01:04:07 -0800 (PST)
Message-ID: <0552f34f-3a56-f7c8-24ba-738ed7418157@redhat.com>
Date: Wed, 8 Dec 2021 10:04:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>
References: <20211208015236.1616697-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
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
> Overhaul and cleanup APIC virtualization (Posted Interrupts on Intel VMX,
> AVIC on AMD SVM) to streamline things as much as possible, remove a bunch
> of cruft, and document the lurking gotchas along the way.
> 
> Patch 01 is a fix from Paolo that's already been merged but hasn't made
> its way to kvm/queue.  It's included here to avoid a number of conflicts.
> 
> Based on kvm/queue, commit 1cf84614b04a ("KVM: x86: Exit to ...")

Thanks, I've now finally pushed to kvm/next.  Debug kernels look like 
they have a few issues that caused my tests to fail, and I wanted to 
make sure they weren't related to the sizable amount of patches already 
in the queue.

Paolo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
