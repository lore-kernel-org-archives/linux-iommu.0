Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CBDC433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:12:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7847523BAE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7847523BAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3044787ACA;
	Wed,  9 Dec 2020 19:12:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rcT5gx-I3KtU; Wed,  9 Dec 2020 19:12:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B3EE87ABE;
	Wed,  9 Dec 2020 19:12:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EFFEC0893;
	Wed,  9 Dec 2020 19:12:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F85BC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3B3DA87AC1
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:12:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GXFpaQSFv2Cz for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 19:12:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0BD6187ABE
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607541156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qu+X+CU3l3H2nboXtsm0ks4Jayrw6j8ysSQm3Vmo8QQ=;
 b=FI12E+VIHhmj1ykSGSUnFpVxy7TTl2Qyat1o5nnBnwnj0fGW2GYwUWojjA3WzkKEZBkQlV
 +JoFIz4kVOzDsGMdaDtyq05tMRor+GjJSQmh8X6FQf9t3/ZAAqg87RSIvynRNYHCCNrYa3
 HVEimdH7iW34YBT8qDhf6jH3PU7gs0o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-V0o2FuFQOfm3Q8B1gQmA-w-1; Wed, 09 Dec 2020 14:12:33 -0500
X-MC-Unique: V0o2FuFQOfm3Q8B1gQmA-w-1
Received: by mail-qv1-f71.google.com with SMTP id t17so1908379qvv.17
 for <iommu@lists.linux-foundation.org>; Wed, 09 Dec 2020 11:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=qu+X+CU3l3H2nboXtsm0ks4Jayrw6j8ysSQm3Vmo8QQ=;
 b=L6DKna6Qcjd6H6+xlBbcELRy9jjgh4ak2PDhes/qGh/m8eJlYTJ+CL/mN8i8+tIKLp
 lA68/yTqof/7nWsUtPD4VB7rc3nWew9OZTWE/vxU+KrRZuw1WIvFpBIzp1W8hwrcMaId
 23gWJW2A4tjQUFEi5J/CKb0uaLrVJRrVtb1NPfUldmqS2wLGQyqk5h+WZbvNYuCjR8M+
 MklK90Gxt75glgxScgLe5xlWv9E26o5MsKvV7xLBD5LSq7s83qVNTLHe1cS4uD+3EO3w
 pAx0oAjmLLDYpRGSF3ZFqUOvqCyxhZpaSnTTiMEkWLeFP0xY5QT4FI0j3xPvd38HbaGt
 NBPA==
X-Gm-Message-State: AOAM533ANCuXGfXGqRBH5wz+UdgEMwhFeEiw0WuE59GRdQbSY4jE/sVw
 OGeUVO8rh27KG0Szr9xEbsgslFYnWA/+6rGzbb3E5LojYuiT/i6mctEzVW4TvrF6xe8BXPNdyx0
 291cNyZXBTfsxt32fOsznINgcFl4rKQ==
X-Received: by 2002:aed:3865:: with SMTP id j92mr4525991qte.318.1607541153514; 
 Wed, 09 Dec 2020 11:12:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyD5VkRlGtdmY9MNkqm989yDI1f88xyqMGWR0Ad7zHxikNoNxEdgjy2+C5NrghMgOUe2XDj0Q==
X-Received: by 2002:aed:3865:: with SMTP id j92mr4525974qte.318.1607541153320; 
 Wed, 09 Dec 2020 11:12:33 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id y6sm1703316qki.115.2020.12.09.11.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 11:12:32 -0800 (PST)
References: <20201209141237.GA8092@willie-the-truck>
 <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
 <20201209185020.GC8778@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.1
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
In-reply-to: <20201209185020.GC8778@willie-the-truck>
Date: Wed, 09 Dec 2020 12:12:31 -0700
Message-ID: <87tusulrog.fsf@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org
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


Will Deacon @ 2020-12-09 11:50 MST:

> On Wed, Dec 09, 2020 at 10:07:46AM -0800, Linus Torvalds wrote:
>> On Wed, Dec 9, 2020 at 6:12 AM Will Deacon <will@kernel.org> wrote:
>> >
>> > Please pull this one-liner AMD IOMMU fix for 5.10. It's actually a fix
>> > for a fix, where the size of the interrupt remapping table was increased
>> > but a related constant for the size of the interrupt table was forgotten.
>> 
>> Pulled.
>
> Thanks.
>
>> However, why didn't this then add some sanity checking for the two
>> different #defines to be in sync?
>> 
>> IOW, something like
>> 
>>    #define AMD_IOMMU_IRQ_TABLE_SHIFT 9
>> 
>>    #define MAX_IRQS_PER_TABLE (1 << AMD_IOMMU_IRQ_TABLE_SHIFT)
>>    #define DTE_IRQ_TABLE_LEN ((u64)AMD_IOMMU_IRQ_TABLE_SHIFT << 1)

Since the field in the device table entry format expects it to be n
where there are 2^n entries in the table I guess it should be:

#define DTE_IRQ_TABLE_LEN 9
#define MAX_IRQS_PER_TABLE (1 << DTE_IRQ_TABLE_LEN)

>> 
>> or whatever. Hmm?
>
> This looks like a worthwhile change to me, but I don't have any hardware
> so I've been very reluctant to make even "obvious" driver changes here.
>
> Suravee -- please can you post a patch implementing the above?
>
>> That way this won't happen again, but perhaps equally importantly the
>> linkage will be more clear, and there won't be those random constants.
>> 
>> Naming above is probably garbage - I assume there's some actual
>> architectural name for that irq table length field in the DTE?
>
> The one in the spec is even better: "IntTabLen".
>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
