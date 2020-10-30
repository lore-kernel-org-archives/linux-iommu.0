Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CACBC4741F
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 18:17:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4A220A8B
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 18:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoLd4bj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4A220A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 281B0867FA;
	Fri, 30 Oct 2020 18:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YDzPOmHeBo1Y; Fri, 30 Oct 2020 18:17:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 437E9867E8;
	Fri, 30 Oct 2020 18:17:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BEA8C088B;
	Fri, 30 Oct 2020 18:17:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DB2AC0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 18:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7CD022044A
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 18:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JWWBCVOA0ZFS for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 18:16:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 805B020418
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604081817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQ9JbkxvNa0VjLQd06HFpKY/mjumkrtDAKSURNuwMaY=;
 b=WoLd4bj5ki0phUEDp88YWNjxuxXM7VLVIMIuuOJClL04e+P/+DgapMPZGeS7Gwk+B0KxlZ
 O8lYsej2JcTDoAe7XRoeVXR4enTLbDjvatYxFPcvUeDEXYHu0Pn0QmY64pp5alU5hosBDV
 hzoUoH9N+PyTjQr4vBLhKNaQ+d2FADc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-rGDG4MRINXWQxEEbHGEnSA-1; Fri, 30 Oct 2020 14:16:54 -0400
X-MC-Unique: rGDG4MRINXWQxEEbHGEnSA-1
Received: by mail-ej1-f71.google.com with SMTP id c10so2760822ejm.15
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 11:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hQ9JbkxvNa0VjLQd06HFpKY/mjumkrtDAKSURNuwMaY=;
 b=J40M2ByIZbBcXtv79t/WXQZT3CNL9SsCBcZmcWLOVLEcKqgEnhUsjU7Y3HXPTudj1G
 SBFim49Lyr+XnPyCDusbq7t45qiR7TVzL8kVnmmhgd80mP+SMzo8PE4UIXTpU6mkvf77
 M/AOCer33yG52SpqslNUk+I2mSIv6Cuwq0aH/B3KtJ4FhXaQRqJo1WOVXlWkZwFhQss7
 bKcmXVc8cW8UXGApSjGIXms4GYbKMlbR1tkL3Q3SP4PlG2/rSUW/dli9XTqO+SxpulrI
 4RurJ0HnC5UI3OvFMQDuYtek/D+JdBfOwEEvrmKAApyQHy0gXUL/Ol+ZooT0FV8W3XS+
 k6Yg==
X-Gm-Message-State: AOAM53092hl5McFSDSroNAR8yubfoMtHu8NqL+ROkQ36OgbIKZsadSQ3
 wFBu+uNDvVL3dv+X7pa0wkU6+wjICCaeo1KMnGHv8wmxL0NSD3bhQBn2nz7oKxbWvvZrNaotEsL
 UHuRLIWrnWMjzvQaTJOZU3iBmp/BmCw==
X-Received: by 2002:a17:906:c20f:: with SMTP id
 d15mr3678308ejz.341.1604081812911; 
 Fri, 30 Oct 2020 11:16:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxORp9yhzCHXkXQ+SV0R3eIJai4qo4teWFQf7D18bUb6YmyTx02WLXvoVEuul2E5KtdAUsMg==
X-Received: by 2002:a17:906:c20f:: with SMTP id
 d15mr3678275ejz.341.1604081812714; 
 Fri, 30 Oct 2020 11:16:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id r24sm3338060eds.67.2020.10.30.11.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 11:16:51 -0700 (PDT)
Subject: Re: [PATCH] [v2] x86: apic: avoid -Wshadow warning in header
To: David Laight <David.Laight@ACULAB.COM>,
 'Arvind Sankar' <nivedita@alum.mit.edu>, Thomas Gleixner <tglx@linutronix.de>
References: <20201028212417.3715575-1-arnd@kernel.org>
 <38b11ed3fec64ebd82d6a92834a4bebe@AcuMS.aculab.com>
 <20201029165611.GA2557691@rani.riverdale.lan>
 <93180c2d-268c-3c33-7c54-4221dfe0d7ad@redhat.com>
 <87v9esojdi.fsf@nanos.tec.linutronix.de>
 <20201029213512.GA34524@rani.riverdale.lan>
 <ad73f56e79d249b1b3614bccc85e2ca5@AcuMS.aculab.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <070f590f-b702-35f0-0b6c-c6455f08e9d5@redhat.com>
Date: Fri, 30 Oct 2020 19:16:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <ad73f56e79d249b1b3614bccc85e2ca5@AcuMS.aculab.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: 'Arnd Bergmann' <arnd@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Haiyang Zhang <haiyangz@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Wanpeng Li <wanpengli@tencent.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 29/10/20 23:12, David Laight wrote:
>> https://godbolt.org/z/4dzPbM
>>
>> With -fno-strict-aliasing, the compiler reloads the pointer if you write
>> to the start of what it points to, but not if you write to later
>> elements.
> I guess it assumes that global data doesn't overlap.

Yeah, setting

	p = (struct s *) ((char *)&p) - 8;

invokes undefined behavior _for a different reason than strict aliasing_
(it's a pointer that is based on "p" but points before its start or
after one byte past its end).  So the compiler assumes that only the
first few bytes of a global can overlap it.

If you change the size of the fields from long to char in the compiler
explorer link above, every field forces a reload of the global.

Paolo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
