Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D66C432BE
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 07:45:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D555E60F14
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 07:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D555E60F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A893D80D80;
	Fri, 13 Aug 2021 07:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1jZT0LLJnA_D; Fri, 13 Aug 2021 07:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 905CB80D1C;
	Fri, 13 Aug 2021 07:45:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 740BAC001A;
	Fri, 13 Aug 2021 07:45:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 354DEC000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24B966070A
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:45:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7V7JK12Qmrhw for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 07:45:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A23760642
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628840706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Teq8UbagtozxN4Eo3VM2ctv7Q0KnaAQlxa4UWyV9YQ=;
 b=eOr8qvN6Md6PRFI46NnF40nrxzfpZnPoTOjC3rm14fLmYyedjg3UFwXJJDBGX4ni6xj1kf
 kinzRj2D6JEYfI/4tbrlw//ylRAzW4TzeeQ+iI1PduXlJD3uP0qH8qP3t6aX/jnSFUjC1Q
 JKXI2/DAF7IowMgle8bV6ETwSEfO3eI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-3HzMV9ZkP7mH8iKJ8aMeXQ-1; Fri, 13 Aug 2021 03:45:05 -0400
X-MC-Unique: 3HzMV9ZkP7mH8iKJ8aMeXQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 w1-20020adf8bc10000b0290154bed98988so2659831wra.1
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 00:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7Teq8UbagtozxN4Eo3VM2ctv7Q0KnaAQlxa4UWyV9YQ=;
 b=gObhW9giF0tjtZXd3ehpxbtcR+nYnq1d2ysPKGUBeaMNffXuW3Tt2OlWrm13bn49ue
 bqgoCyFzVxKzBCt2YhulIHKu/WhIfgnZxof2d+FkKPoNNgtItCJmRn/suv36A2vZDPBB
 A6SyaFUqoEmDRXR6irKelgi4juLPVmKtQ0DBWdD8y2iusmc+63134wNJL8f/vaMmDYoD
 wr5hI0x7R2QhOQ7LEOKulbZhVhVQSTclm1ej17lWmg+oGV9HtwPJhCbKJELempw9/XBu
 0+WGpXVJ9m6OHiWFMVuiOyvD1wvRTksGhh/22Za9toI0c3CP+fPjKPUszzuO0Fr5F0P+
 VgPQ==
X-Gm-Message-State: AOAM532N3wMpkVuVyBhEXHdzJGNqGCUEfqaoKP778wT/f7WCAulX55gK
 RU+ptkcrYKPQX9slKX0D02p1/qk49fXZ46WEnAFNYZxRbAd9MAC5LCu5kfPT/l3IzADi8umlSIi
 7bbhQc+Bv9khwZIk+xhpL/27y6JkznA==
X-Received: by 2002:a05:600c:1c28:: with SMTP id
 j40mr1344994wms.104.1628840704142; 
 Fri, 13 Aug 2021 00:45:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSjOWohJfjAJ+7FUzSyKi8N1Le4n6LYsBXwpgNlp369MQ4VMbQeGmfTi+w5r4HJ/tWLnckVA==
X-Received: by 2002:a05:600c:1c28:: with SMTP id
 j40mr1344978wms.104.1628840703928; 
 Fri, 13 Aug 2021 00:45:03 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66ea.dip0.t-ipconnect.de. [91.12.102.234])
 by smtp.gmail.com with ESMTPSA id h16sm742166wre.52.2021.08.13.00.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Aug 2021 00:45:03 -0700 (PDT)
Subject: Re: An cma optimization patch is used for cma_[alloc|free].
To: Jichao Zou <zoujc@motorola.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "minchan@kernel.org" <minchan@kernel.org>,
 "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
 "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 JianQi Yang <yangj@motorola.com>, Yanjune Tian <tianyje@motorola.com>
References: <HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f5cd9fe6-3b62-eab8-1ff1-d3943d4bb85b@redhat.com>
Date: Fri, 13 Aug 2021 09:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

T24gMTMuMDguMjEgMDk6MDAsIEppY2hhbyBab3Ugd3JvdGU6Cj4gUHJlLWFsbG9jYXRlwqBDTUHC
oG1lbW9yecKgdGhhdMKgY29uZmlndXJlZMKgaW7CoGRldmljZQo+IHRyZWUswqB0aGlzwqBncmVh
dGx5wqBpbXByb3Zlc8KgdGhlwqBDTUHCoG1lbW9yeQo+IGFsbG9jYXRpb27CoGVmZmljaWVuY3ks
wqBjbWFfW2FsbG9jfGZyZWVdwqBpc8KgbGVzcwo+IHRoYW7CoDFtcyzCoG9sZMKgd2F5wqBpc8Kg
dG9va8KgYcKgZmV3wqBtc8KgdG/CoHRlbnPCoG9yCj4gaHVuZHJlZHPCoG1zLgo+IAoKUGxlYXNl
IHNlbmQgcGF0Y2hlcyBhcyBwcm9wZXIgZW1haWxzIChtYW4gZ2l0LWZvcm1hdC1wYXRjaDsgbWFu
IApnaXQtc2VuZC1lbWFpbCkuCgpXaGF0IHlvdSBwcm9wb3NlIGlzIHR1cm5pbmcgY21hIHJlc2Vy
dmF0aW9ucyBpbnRvIHNvbWV0aGluZyBjb21wYXJhYmxlIAp0byBwZXJtYW5lbnQgYm9vdHRpbWUg
YWxsb2NhdGlvbnMuIEZyb20gdGhlIFBPViBvZiB0aGUgYnVkZHksIHRoZSBwYWdlcyAKYXJlIGFs
d2F5cyBhbGxvY2F0ZWQgYW5kIGNhbm5vdCBiZSByZXB1cnBvc2VkIGZvciBlLmcuLCBtb3ZhYmxl
IAphbGxvY2F0aW9ucyB1bnRpbCAqYWN0dWFsbHkqIGFsbG9jYXRlZCB2aWEgQ01BLgoKSSBkb24n
dCB0aGluayB3ZSB3YW50IHRoaXMgYmVoYXZpb3IgdXBzdHJlYW0uCgotLSAKVGhhbmtzLAoKRGF2
aWQgLyBkaGlsZGVuYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
