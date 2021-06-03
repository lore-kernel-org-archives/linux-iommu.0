Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3166C4708F
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 03:02:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43108613F2
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 03:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43108613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16138404E8;
	Thu,  3 Jun 2021 03:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QDVuXo6Q1VS7; Thu,  3 Jun 2021 03:02:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F510400B8;
	Thu,  3 Jun 2021 03:02:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AD1BC000E;
	Thu,  3 Jun 2021 03:02:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 232A7C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 03:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 203A7404D7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 03:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B0uThhHHMwO8 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:02:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 717D0400B8
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 03:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622689353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5v7V01P50/MU+rNJexPycRVWZFkh/NJWCZ7iWh6s3/0=;
 b=Mf16mczZQFQT8oKi95pL6KnJ9eKGU6MVl5dPLF9A/lvYUUpXPYRdn6p9j9Hy8Nu3YdOp5n
 8+tMTC1Me+R1fQsi5j21DwVvC9aRBT8gJ8OZIOnnP9+qpgyH6BYaIuqVdKmqdAEbJVxlOI
 kd5FcicadQgY4Ntq/Fj0/vLw3vCT0EU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-J8qqXKEeNUyo-YFSY2bFIg-1; Wed, 02 Jun 2021 23:02:31 -0400
X-MC-Unique: J8qqXKEeNUyo-YFSY2bFIg-1
Received: by mail-pj1-f71.google.com with SMTP id
 fu20-20020a17090ad194b0290163ff5d5867so4535514pjb.2
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 20:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5v7V01P50/MU+rNJexPycRVWZFkh/NJWCZ7iWh6s3/0=;
 b=hqiQnWHPTWZmD7pTKi1hSvgdmlJ/Pc10G+w9MgGS+JRSmvG2jnykFil5BSAoY89G1M
 37/E8gARK2uBCSE+QAFS4iXvg6VNRr/P8vBRlIHc4kx1FOzRgrFi9hd/VkmMfCQeEaqc
 S39Rh6iyl7Rva49fWCFOIZpmBsMSkuOiq5cflNpRi3JcleKYtsli2EP2OASiYiAxzEoe
 AGfT2OqfX30Q3kvvA5cT1Z+UBGutpvW9r6JrLfC6U0kv3+JM5L1xtrHNmwE4sOakmKg0
 fYbuZX9Qfgp3ksOL75xR4Scq7pNiDknhoL9XGBbAEfwDrEQjFQLk1EFCdGY4KQJm3KKv
 UR4A==
X-Gm-Message-State: AOAM530NjY/qT4nB2APIGWeY1YyDNcYD7JPIxRX3FN8raUI6o+/t2TkG
 iKwR0fuZbAlexv4/H7VYbJaaIDGx/BA8IqdYbSpMlqM3HKc02D876QY8AFOLdxyU7UBesKXvOih
 ldXJGaou+8DYz2d8IcGr39uXV5d/CsA==
X-Received: by 2002:a17:90a:e54e:: with SMTP id
 ei14mr4156599pjb.53.1622689350894; 
 Wed, 02 Jun 2021 20:02:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwhDfm3DFenSc3jf0+IF7vZ3fiL+QyQZqc2ItshCLLfoqd1jKoY3Jfm/f4//A4m6OHVAGWYQ==
X-Received: by 2002:a17:90a:e54e:: with SMTP id
 ei14mr4156577pjb.53.1622689350622; 
 Wed, 02 Jun 2021 20:02:30 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q191sm791649pfq.108.2021.06.02.20.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 20:02:30 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
 <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
 <1c08bc42-7448-351e-78bf-fcf68d2b2561@redhat.com>
 <5a2d0d70-fa6b-f08d-f222-5c00cf5f9d44@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9b10bb24-eb27-510e-cf0d-7818ab9166ef@redhat.com>
Date: Thu, 3 Jun 2021 11:02:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <5a2d0d70-fa6b-f08d-f222-5c00cf5f9d44@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jpoimboe@redhat.com, robin.murphy@arm.com, hch@lst.de
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

CuWcqCAyMDIxLzYvMyDkuIrljYgxMDo1NiwgQW5kaSBLbGVlbiDlhpnpgZM6Cj4KPj4KPj4gSSBh
Z3JlZSwgYnV0IEkgd2FudCB0byBrbm93IHdoeSBpbmRpcmVjdCBkZXNjcmlwdG9yIG5lZWRzIHRv
IGJlIAo+PiBkaXNhYmxlZC4gVGhlIHRhYmxlIGNhbid0IGJlIHdyb3RlIGJ5IHRoZSBkZXZpY2Ug
c2luY2UgaXQncyBub3QgCj4+IGNvaGVyZW50IHN3aW90bGIgbWFwcGluZy4KPgo+IEkgaGFkIGFs
bCBraW5kcyBvZiBwcm9ibGVtcyB3aXRoIHVuaW5pdGlhbGl6ZWQgZW50cmllcyBpbiB0aGUgaW5k
aXJlY3QgCj4gdGFibGUuIFNvIEkgZ2F2ZSB1cCBvbiBpdCBhbmQgY29uY2x1ZGVkIGl0IHdvdWxk
IGJlIHRvbyBkaWZmaWN1bHQgdG8gCj4gc2VjdXJlLgo+Cj4KPiAtQW5kaQo+Cj4KCk9rLCBidXQg
d2hhdCBJIG1lYW50IGlzIHRoaXMsIGlmIHdlIGRvbid0IHJlYWQgZnJvbSB0aGUgZGVzY3JpcHRv
ciByaW5nLCAKYW5kIHZhbGlkYXRlIGFsbCB0aGUgb3RoZXIgbWV0YWRhdGEgc3VwcGxpZWQgYnkg
dGhlIGRldmljZSAodXNlZCBpZCBhbmQgCmxlbikuIFRoZW4gdGhlcmUgc2hvdWxkIGJlIG5vIHdh
eSBmb3IgdGhlIGRldmljZSB0byBzdXBwcmVzcyB0aGUgZG1hIApmbGFncyB0byB3cml0ZSB0byB0
aGUgaW5kaXJlY3QgZGVzY3JpcHRvciB0YWJsZS4KCk9yIGRvIHlvdSBoYXZlIGFuIGV4YW1wbGUg
aG93IGl0IGNhbiBkbyB0aGF0PwoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
