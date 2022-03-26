Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF068C433F5
	for <iommu@archiver.kernel.org>; Sat, 26 Mar 2022 18:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 825E98188A;
	Sat, 26 Mar 2022 18:44:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfRwuLmjNqCz; Sat, 26 Mar 2022 18:44:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5575281762;
	Sat, 26 Mar 2022 18:44:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35348C001D;
	Sat, 26 Mar 2022 18:44:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7CC9C0012
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 18:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A034260761
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 18:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4g5VFW1sRXWo for <iommu@lists.linux-foundation.org>;
 Sat, 26 Mar 2022 18:44:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0D01606F9
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 18:44:29 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id q14so14147714ljc.12
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2m51oiAn/Cj+SF/F+aV22/Ai48y8dhVaDitWIYFgHko=;
 b=Xzpb8EwMd16IfpevZXCSnZ1w7igDgljvhc1UKwPCGJbTR1UuTbbMqaENrY8MItnW6A
 /mhYRG9m1OqxvKFji2pu2e6epPatTwTurg1n0sv6438+lqS7kq56HR/JgRktiNPSjzbW
 jslyVNaXHhOqnGPtddZTS6jVTkH+ZYGjaxVaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2m51oiAn/Cj+SF/F+aV22/Ai48y8dhVaDitWIYFgHko=;
 b=3eC4b4Xxk588I5JEABz6unbleagQfRaOfNbru5UaYR4O0gXR7xDdHuuHZ4kJJaeqfz
 N3Rrvx14fxwAlLn3TCebhiJt76+EKwiguehKj2aFH1WVTNrQij9rhFTpSvDzYbbyk/Mj
 v+V/o+BbeWn0wlO97MeensxCoI30YF07pmVriXJhyvsbE1ahhDF1vGbcAhGPKy3rAu4q
 5BqEOSkitmg22B1QZG0l5Mwh9TJ+GDOpNQHYsm6LCK2qWSbrV4JM4OY+91kUQMwW1hVK
 2x1J4nUwaCzsSWv3ATnZSykF9kp6acSrc20y2tV8Ah0cGojx7FPDdbssI2EV/GTfJlhb
 GMYw==
X-Gm-Message-State: AOAM531sGDxbUO0GX63cLkXSTZVELn6aojaxlUP7gYmSVjYZlHmPXT6x
 Xxwz/1EozA/i4j2l5F5PVAk4G92VOpI/WbGCy8mzVA==
X-Google-Smtp-Source: ABdhPJwXR5CeVBBjdGoWu5cwuhB6pwfqtbASbU7XXjPTJE5J91cCX/nfE0US1O87dsVhk9X9XgL7XA==
X-Received: by 2002:a2e:a7ca:0:b0:249:862b:525 with SMTP id
 x10-20020a2ea7ca000000b00249862b0525mr13104369ljp.491.1648320267310; 
 Sat, 26 Mar 2022 11:44:27 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180]) by smtp.gmail.com with ESMTPSA id
 d22-20020a194f16000000b0044a72c26c97sm660698lfb.150.2022.03.26.11.44.26
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Mar 2022 11:44:26 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id c15so14162324ljr.9
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 11:44:26 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr13222025ljc.506.1648319955630; Sat, 26
 Mar 2022 11:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <cce202fb-5185-aa3e-9e9b-11626192cb49@arm.com>
 <20220326003853.44c3285c.pasic@linux.ibm.com>
 <8735j47l7y.fsf@toke.dk>
In-Reply-To: <8735j47l7y.fsf@toke.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Mar 2022 11:38:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjorwZTQuQB8QBgNpdBZNz7uyprgaTT+1Q6_1FaT3sAmQ@mail.gmail.com>
Message-ID: <CAHk-=wjorwZTQuQB8QBgNpdBZNz7uyprgaTT+1Q6_1FaT3sAmQ@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gU2F0LCBNYXIgMjYsIDIwMjIgYXQgOTowNiBBTSBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4g
PHRva2VAdG9rZS5kaz4gd3JvdGU6Cj4KPiBJIHdhcyBhbHNvIHRveWluZyB3aXRoIHRoZSBpZGVh
IG9mIGhhdmluZyBhIGNvcHktYmFzZWQgcGVlayBoZWxwZXIgbGlrZToKPgo+IHUzMiBkYXRhID0g
ZG1hX3BlZWtfd29yZChidWYsIG9mZnNldCkKCkkgcmVhbGx5IGRvbid0IHRoaW5rIHlvdSBjYW4g
b3Igd2FudCB0byBoYXZlIGEgd29yZC1iYXNlZCBvbmUuCgpUaGF0IHNhaWQsIEkgbGlrZSB0aGUg
Km5hbWUqIG9mIHRoYXQgdGhpbmcuCgpJIHRoaW5rIGEgbG90IG9mIGNvbmZ1c2lvbiBjb21lcyBm
cm9tIHRoZSB2ZXJ5IHN1YnRsZSBuYW1pbmcgb2YKZnVuZGFtZW50YWxseSBoYXZpbmcgYSBsb3Qg
b2Ygb2RkIGNvbmRpdGlvbnMgd2l0aAoKIC0gdHdvIGRpZmZlcmVudCAiZGlyZWN0aW9ucyBvZiB0
aGUgc3luYyIgLSBpZSB3aG8gaXQgaXMgdGhhdCBjYXJlczoKCiAgICAgICBkbWFfc3luY19zaW5n
bGVfZm9yX3tjcHUsZGV2aWNlfQoKIC0gdGhyZWUgZGlmZmVyZW50ICJkaXJlY3Rpb24gb2YgdGhl
IGRhdGEiIC0gaWUgd2hvIGl0IGlzIHRoYXQgd3JpdGVzIHRoZSBkYXRhOgoKICAgICAgICBETUFf
RlJPTV9ERVZJQ0UgLyBETUFfVE9fREVWSUNFIC8gRE1BX0JJRElSRUNUSU9OQUwKCnNvIHlvdSBo
YXZlIHNpeCBwb3NzaWJsZSBjb21iaW5hdGlvbnMsIHRocmVlIG9mIHdoaWNoIHNlZW0gaW5zYW5l
IGFuZApub3QgdXNlZnVsLCBhbmQgb2YgdGhlIHRocmVlIHRoYXQgYXJlIGFjdHVhbGx5IHBvc3Np
YmxlLCBzb21lIGFyZSB2ZXJ5CnVudXN1YWwgKGl0IGV4YWN0bHkgdGhhdCAiZGV2aWNlIGlzIHRo
ZSBvbmUgd3JpdGluZywgYnV0IHdlIHdhbnQgdG8Kc3luYyB0aGUgZG1hIGFyZWEgZm9yIHRoZSBk
ZXZpY2UiKS4KCkkgZG8gbm90IHRoaW5rIGl0IGhlbHBzIHRoYXQgbm90IG9ubHkgZG8gd2UgaGF2
ZSB0aGlzIGNvbWJpbmF0b3JpYWwKbmFtaW5nLCB3ZSBhbHNvIHVzZSBfZGlmZmVyZW50XyBuYW1l
cy4gV2Ugc2F5ICJmb3IgZGV2aWNlIiBhbmQgImZvcgpjcHUiLCBidXQgdGhlbiB3aGVuIHdlIHNw
ZWNpZnkgd2hvIGRvZXMgdGhlIHdyaXRpbmcsIHdlIGRvbid0IHNheSAiY3B1CnZzIGRldmljZSIs
IHdlIGp1c3Qgc3BlY2lmeSB0aGUgZGlyZWN0aW9uIGluc3RlYWQgKEZST01fREVWSUNFIG1lYW5z
CnRoZSBkZXZpY2UgZGlkIHRoZSB3cml0aW5nLCBUT19ERVZJQ0UgbWVhbnMgdGhhdCB0aGUgQ1BV
IGRpZCB0aGUKd3JpdGluZykuCgpBbnl3YXksIEkgc3BlbnQgYSBsb3Qgb2YgdGltZSBsb29raW5n
IGF0IHRoaXMsIGFuZCBJIGFtIG5vdyBwZXJzb25hbGx5CmNvbnZpbmNlZCB0aGF0IGNvbW1pdCBh
YTZmOGRjYmFiNDcgKHN3aW90bGI6IHJld29yayAiZml4IGluZm8gbGVhawp3aXRoIERNQV9GUk9N
X0RFVklDRSIpIHdhcyBqdXN0IGNvbXBsZXRlbHkgYnVnZ3ksIGFuZCB3YXMgYnVnZ3kKZXhhY3Rs
eSBiZWNhc3VlIGl0IHdhcyBmdW5kYW1lbnRhbGx5IGNvbmZ1c2VkIGV2ZW4gYWJvdXQgd2hpY2gK
ZGlyZWN0aW9uIHRoZSBib3VuY2Ugd2FzIGhhcHBlbmluZy4KCkkgaGF2ZSByZXZlcnRlZCBpdCBp
biBteSB0cmVlLCBhbmQgSSB0cmllZCB0byB3cml0ZSBhIGNvbXByZWhlbnNpdmUKc3VtbWFyeSBh
Ym91dCB3aHkgaXQgd2FzIHdyb25nLgoKV2hhdCBJICpkaWRuJ3QqIGRvIGluIHRoYXQgY29tbWl0
IHdhcyB0byBhcmd1ZSBhZ2FpbnN0IHRoZSBuYW1pbmcsIGFuZAp0cnkgdG8gZW51bWVyYXRlIGFs
bCB0aGUgZGlmZmVyZW50IHZhbGlkIGNhc2VzLgoKQmVjYXVzZSBJIHRoaW5rIG5hbWluZyBtYXR0
ZXJzLCBhbmQgSSB0aGluayB0aGUgY3VycmVudCBkbWFfc3luYygpCmludGVyZmFjZXMgYXJlIGhv
cnJpYmx5IGNvbmZ1c2luZyBleGFjdGx5IGR1ZSB0byB0aG9zZSBuYW1pbmcKY29tYmluYXRvcmlh
bHMuCgpCdXQgSSB0aGluayAicGVlayIgaXMgYSBnb29kIG5hbWUsIG5vdCBiZWNhdXNlIEkgdGhp
bmsgcmVhZGluZyBvbmUKd29yayBpcyBhIHZhbGlkIHRoaW5nICh5b3Ugd2FudCB0byBvZnRlbiBw
ZWVrIG1vcmUgdGhhbiB0aGF0KSwgYnV0CmJlY2F1c2UgaXQgc2VlbXMgbXVjaCBtb3JlIGludHVp
dGl2ZSB0aGFuCiJkbWFfc3luY19mb3JfY3B1KERNQV9GUk9NX0RFVklDRSkiLgoKU2ltaWxhcmx5
LCBJIHdvdWxkIHRoaW5rIHRoYXQgImZsdXNoIiBpcyBhIG11Y2ggYmV0dGVyIHdvcmQgZm9yCiJk
bWFfc3luY19mb3JfZGV2aWNlKERNQV9GUk9NX0NQVSkiLgoKSSBkb24ndCBrbm93IHdoYXQgYSBn
b29kIHdvcmQgZm9yCiJkbWFfc3luY19mb3JfZGV2aWNlKERNQV9GUk9NX0RFVklDRSkiIGlzLCBi
dXQgbWF5YmUgImZvcmdldCIgd291bGQKY29tZSBjbG9zZXN0IC0gd2Ugd2FudCB0aGUgQ1BVIHRv
ICJmb3JnZXQiIHdoYXQgaXQgcGVla2VkLgoKQW55d2F5LCBJIGhhdmUgcmV2ZXJ0ZWQgdGhhdCBj
b21taXQsIGFuZCBJIHRoaW5rIGl0IHdhcyB3cm9uZyBib3RoIGluCnNwaXJpdCBhbmQgaW4gaW1w
bGVtZW50YXRpb24sIGFuZCBJJ2xsIGFzayBHcmVnIHRvIHJlbW92ZSBpdCBmcm9tCnN0YWJsZS4K
CkFuZCBJIHRoaW5rIHRoZSBzZWN1cml0eSBhcmd1bWVudCB3YXMgZW50aXJlbHkgYm9ndXMsIGJl
Y2F1c2UgdGhlCndob2xlIHNlY3VyaXR5IGFyZ3VtZW50IHdhcyBiYXNlZCBvbiBhbiBpbmNvcnJl
Y3QgdW5kZXJzdGFuZGluZyBvZiB0aGUKZGlyZWN0aW9uIG9mIHRoZSBkYXRhLgoKQnV0IGhleSwg
SSBtYXkgY3VycmVudGx5IGJlIGNvbnZpbmNlZCB0aGF0IHJldmVydCBpcyB0aGUgcmlnaHQgdGhp
bmcKdG8gZG8sIEJVVCBJJ3ZlIGJlZW4gd3JvbmcgYmVmb3JlLCBhbmQgSSdsbCBoYXBwaWx5IGNo
YW5nZSBteSBtaW5kIGlmCnNvbWVib2R5IG1ha2VzIGEgcmVhbGx5IGNvZ2VudCBhcmd1bWVudAoK
ICAgICAgICAgICAgICAgTGludXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
