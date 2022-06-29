Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B663EC43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 00:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2864B60A72;
	Wed, 29 Jun 2022 00:14:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2864B60A72
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=dzzx4WtX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DH4pDiTUQH1n; Wed, 29 Jun 2022 00:14:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CA64A60B36;
	Wed, 29 Jun 2022 00:14:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA64A60B36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94429C0039;
	Wed, 29 Jun 2022 00:14:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1CEAC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 00:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7290860B36
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 00:14:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7290860B36
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XG7SqLad7jQG for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 00:14:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8B3B60A72
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8B3B60A72
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 00:14:52 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id cv13so14049878pjb.4
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 17:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=05ASLe35KlS/635AYkr9ttdQBevoBXGVkR7t9AbxzS8=;
 b=dzzx4WtXS/WkHpvykE0Ug4pI7IQoDYpxYcwT22eGTgXydtRyVau06KToMULz4WZ85p
 grc9sV1BmBI096bjPV6AYIg+FD5hBe5gj3092gLAqIoDR6Usno3qkCUxW0him8f4Kt+7
 5Uf02V1S6CU9QXgRzjHroyahVKDiR/lHNsV044fz9JWOwGa1zg1AbzobwrAmZjbW8zFF
 NJWZj5bNSbN92/C5/1fpmT4IbOePFpLv8AN2psJq3YvTqAwnlZ6jrlyHQy1YHFlzFM4V
 6GGIoWoQqCmV+YlWQVYdo/a8/uHvejllTjqLg43Sy9OxgGuiI2LvtGtvLWOWEwxpHjVI
 SvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=05ASLe35KlS/635AYkr9ttdQBevoBXGVkR7t9AbxzS8=;
 b=VJZQPzTcPoeRcaPG7wnB2qTnXp2bLB0O32RsuN0m8nXBjYqE/dkVdKggvFyHyBWHx3
 0+B0hC48yyQ2nBt/H/rH30NVDPc2b2s8Bw48eA7sGZ7gnhN+guNCUW6z8+SOudnS980Q
 Da26uy70LZ9B+NNJih/VfZyxsKqAR4BkiLedZxVa2cXtY9QfSrQ35M3bVfvjvxcNOEux
 VxEOwNWOCUvtJDbFvl1Q0QvaU1jMme5funne/og1ZjNyyKUKimiePUydEKRqwN7G2hd4
 VDt4pqYBw6TKX3tBtUiFJlk57ynDzgjJI8Xaa3JVwd8q4OrYhzkrxZGdaA+4oBl3X8Ea
 pzQw==
X-Gm-Message-State: AJIora8kKrJykX5rpcKQ0MZtdrVjjUZzSyM7LAdymbPJmS+3O+966PbW
 Bxjgqqj7Au0Yl14DYfAJn4E=
X-Google-Smtp-Source: AGRyM1s6BvhKknOd3DGT0QQr5uB83fgcSZ645ndGItCzAFy4UPsuv2Gt9Oy4n8CrGTj/IyliMMkT6Q==
X-Received: by 2002:a17:903:240e:b0:168:ea13:f9e0 with SMTP id
 e14-20020a170903240e00b00168ea13f9e0mr7684101plo.6.1656461692074; 
 Tue, 28 Jun 2022 17:14:52 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033?
 ([2001:df0:0:200c:75aa:d6ca:4354:6033])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a170902c1cd00b0016a276aada7sm9950167plc.20.2022.06.28.17.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jun 2022 17:14:51 -0700 (PDT)
Message-ID: <2402062b-aae6-a247-06a8-3775c2909bdb@gmail.com>
Date: Wed, 29 Jun 2022 12:14:42 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
From: Michael Schmitz <schmitzmic@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>, Arnd Bergmann <arnd@kernel.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
 <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
 <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
 <fc47e8da-81d3-e563-0a17-4eb23db015cc@acm.org>
 <859c2adc-d3cb-64e8-faba-06e1ac5eddaf@gmail.com>
In-Reply-To: <859c2adc-d3cb-64e8-faba-06e1ac5eddaf@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@infradead.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Denis Efremov <efremov@linux.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Khalid Aziz <khalid@gonehiking.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Matt Wang <wwentao@vmware.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Salyzyn <salyzyn@android.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 alpha <linux-alpha@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgQmFydCwKCk9uIDI5LzA2LzIyIDEyOjAxLCBNaWNoYWVsIFNjaG1pdHogd3JvdGU6Cj4KPj4g
QW4gZXhhbXBsZSBvZiBhIHVzZXIgc3BhY2UgYXBwbGljYXRpb24gdGhhdCBwYXNzZXMgYW4gU0cg
SS9PIGRhdGEgCj4+IGJ1ZmZlciB0byB0aGUga2VybmVsIHRoYXQgaXMgYWxpZ25lZCB0byBhIGZv
dXIgYnl0ZSBib3VuZGFyeSBidXQgbm90IAo+PiB0byBhbiBlaWdodCBieXRlIGJvdW5kYXJ5IGlm
IHRoZSAtcyAoc2NhdHRlcmVkKSBjb21tYW5kIGxpbmUgb3B0aW9uIAo+PiBpcyB1c2VkOiAKPj4g
aHR0cHM6Ly9naXRodWIuY29tL29zYW5kb3YvYmxrdGVzdHMvYmxvYi9tYXN0ZXIvc3JjL2Rpc2Nv
bnRpZ3VvdXMtaW8uY3BwCj4KPiBUaGFua3MgLSBmb3VyIGJ5dGUgYWxpZ25tZW50IGFjdHVhbGx5
IHdvdWxkbid0IGJlIGFuIGlzc3VlIGZvciBtZS4gCj4gSXQncyB0d28gYnl0ZSBvciBzbWFsbGVy
IHRoYXQgd291bGQgdHJpcCB1cCB0aGUgU0NTSSBETUEuCj4KPiBXaGlsZSBJJ20gc3VyZSBzdWNo
IGFuIGV2ZW4gbW9yZSBwYXRob2xvZ2ljYWwgdGVzdCBjYXNlIGNvdWxkIGJlIAo+IHdyaXR0ZW4s
IEkgd2FzIHJhdGhlciB3b3JyaWVkIGFib3V0IHN0LmMgYW5kIHNyLmMgaW5wdXQgLi4uCk5ldmVy
bWluZCAtIEkganVzdCBzZWUgbTY4ayBkZWZpbmVzIEFSQ0hfRE1BX01JTkFMSUdOIHRvIGJlIGZv
dXIgYnl0ZXMuIApTaG91bGQgYmUgc2FmZSBmb3IgYWxsIHRoYXQgbWF0dGVycywgdGhlbi4KCkNo
ZWVycywKCiDCoMKgwqAgTWljaGFlbAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
