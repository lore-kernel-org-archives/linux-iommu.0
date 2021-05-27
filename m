Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A374C4708D
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 05:40:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA46613D4
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 05:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA46613D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9185A40251;
	Thu, 27 May 2021 05:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UZsU_YFR6GCb; Thu, 27 May 2021 05:40:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8728240260;
	Thu, 27 May 2021 05:40:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 188E3C0025;
	Thu, 27 May 2021 05:40:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1713C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 05:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEADE4027C
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 05:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id frW_l_y8t4vK for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:40:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D45B740277
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 05:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622094043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AU/RuY2ymovNRYn9DIYtROZdNQLFTgpR1rexfb2OF3c=;
 b=N1/ocHRmo7AWpG6/7nLrdOYRAd5Uru10vZ6ei9T4zNgzfrbNjdD/3CTsBheXanRxPW2CSU
 Fsa2dqfqhI8XeCvsCa6NVLat7P/lAfXr+ce986tyzHq+dJ3cPuqjIGQUfzda39lsGfD5bz
 h788r12lhHM1nZAtw0hHM4mu8yjmvng=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-QjbpiTYeP5qipmRqjZNYgA-1; Thu, 27 May 2021 01:40:41 -0400
X-MC-Unique: QjbpiTYeP5qipmRqjZNYgA-1
Received: by mail-pl1-f198.google.com with SMTP id
 o19-20020a170902e293b02900ef869214f9so1760884plc.18
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 22:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AU/RuY2ymovNRYn9DIYtROZdNQLFTgpR1rexfb2OF3c=;
 b=qS8aM1bsaBRPeJ8Mf2EcfCnb7Ce/e3LGL/eEgPbjsRspQf9XeuUd8v50Au1DsIB/Fb
 /ZoxWz+M0VuzTLr/Yq9mD83tRHGFKLx7jfx8BcHkm9z7Fs3Xd4B3zJ491DkkuSKxpZvl
 IvG0Ec71VQHuv3K8vrWNykWGRVhYLwBoC3/aL7SSHqQITMMrDzz+l6Czj5b35hFDJ2bt
 RxQlHm2qSqLQgBPYhdwXi3Eonysqc1i6saIfKg/x8Vmj5eIyvFIjv4ES8nW1e5qR/G/B
 hsIDgOpcnqN4TYVIix3gZ0k+JM+gpjjt726nPMF93Wd7+Qo+lqjjZ8LhfLr0lwhVXe1j
 dHag==
X-Gm-Message-State: AOAM533oavI+hjsjZSWmajJet+l+n+l7uV3wAgdtU+mo6Nuk27e2czKx
 XpuLj+pgOZIXw7aki98LbuOG4ia08QSKJsm8Qat9Cy5KSCcivScNeek0wpxkJhqwOTlrNZglPx8
 +PxyUhkjh6wXJrI3ESirS1LRoo2WzvA==
X-Received: by 2002:a17:90a:71c7:: with SMTP id m7mr7691843pjs.9.1622094040615; 
 Wed, 26 May 2021 22:40:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdvc47LfRqVL36pEPdXD9AUGFkROiA0ecx8aq5qhRtKjUnV9VTluCW50o4cKagpZC5qThkZA==
X-Received: by 2002:a17:90a:71c7:: with SMTP id m7mr7691807pjs.9.1622094040375; 
 Wed, 26 May 2021 22:40:40 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z19sm851114pjq.11.2021.05.26.22.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 22:40:39 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
 <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
Date: Thu, 27 May 2021 13:40:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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

CuWcqCAyMDIxLzUvMjcg5LiL5Y2IMTowOCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gVGh1LCBN
YXkgMjcsIDIwMjEgYXQgMTowMCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxMjo1NywgWW9uZ2ppIFhpZSDlhpnpgZM6
Cj4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCAxMjoxMyBQTSBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKPj4+PiDlnKggMjAyMS81LzE3IOS4i+WNiDU6NTUsIFhpZSBZ
b25namkg5YaZ6YGTOgo+Pj4+PiArCj4+Pj4+ICtzdGF0aWMgaW50IHZkdXNlX2Rldl9tc2dfc3lu
YyhzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgdmR1c2VfZGV2X21zZyAqbXNnKQo+Pj4+PiArewo+Pj4+PiArICAgICBpbml0X3dh
aXRxdWV1ZV9oZWFkKCZtc2ctPndhaXRxKTsKPj4+Pj4gKyAgICAgc3Bpbl9sb2NrKCZkZXYtPm1z
Z19sb2NrKTsKPj4+Pj4gKyAgICAgdmR1c2VfZW5xdWV1ZV9tc2coJmRldi0+c2VuZF9saXN0LCBt
c2cpOwo+Pj4+PiArICAgICB3YWtlX3VwKCZkZXYtPndhaXRxKTsKPj4+Pj4gKyAgICAgc3Bpbl91
bmxvY2soJmRldi0+bXNnX2xvY2spOwo+Pj4+PiArICAgICB3YWl0X2V2ZW50X2tpbGxhYmxlKG1z
Zy0+d2FpdHEsIG1zZy0+Y29tcGxldGVkKTsKPj4+PiBXaGF0IGhhcHBlbnMgaWYgdGhlIHVzZXJz
cGFjZShtYWxpY291cykgZG9lc24ndCBnaXZlIGEgcmVzcG9uc2UgZm9yZXZlcj8KPj4+Pgo+Pj4+
IEl0IGxvb2tzIGxpa2UgYSBET1MuIElmIHllcywgd2UgbmVlZCB0byBjb25zaWRlciBhIHdheSB0
byBmaXggdGhhdC4KPj4+Pgo+Pj4gSG93IGFib3V0IHVzaW5nIHdhaXRfZXZlbnRfa2lsbGFibGVf
dGltZW91dCgpIGluc3RlYWQ/Cj4+Cj4+IFByb2JhYmx5LCBhbmQgdGhlbiB3ZSBuZWVkIGNob29z
ZSBhIHN1aXRhYmxlIHRpbWVvdXQgYW5kIG1vcmUgaW1wb3J0YW50LAo+PiBuZWVkIHRvIHJlcG9y
dCB0aGUgZmFpbHVyZSB0byB2aXJ0aW8uCj4+Cj4gTWFrZXMgc2Vuc2UgdG8gbWUuIEJ1dCBpdCBs
b29rcyBsaWtlIHNvbWUKPiB2ZHBhX2NvbmZpZ19vcHMvdmlydGlvX2NvbmZpZ19vcHMgc3VjaCBh
cyBzZXRfc3RhdHVzKCkgZGlkbid0IGhhdmUgYQo+IHJldHVybiB2YWx1ZS4gIE5vdyBJIGFkZCBh
IFdBUk5fT04oKSBmb3IgdGhlIGZhaWx1cmUuIERvIHlvdSBtZWFuIHdlCj4gbmVlZCB0byBhZGQg
c29tZSBjaGFuZ2UgZm9yIHZpcnRpbyBjb3JlIHRvIGhhbmRsZSB0aGUgZmFpbHVyZT8KCgpNYXli
ZSwgYnV0IEknbSBub3Qgc3VyZSBob3cgaGFyZCB3ZSBjYW4gZG8gdGhhdC4KCldlIGhhZCBORUVE
U19SRVNFVCBidXQgaXQgbG9va3Mgd2UgZG9uJ3QgaW1wbGVtZW50IGl0LgoKT3IgYSByb3VnaCBp
ZGVhIGlzIHRoYXQgbWF5YmUgbmVlZCBzb21lIHJlbGF4aW5nIHRvIGJlIGNvdXBsZWQgbG9vc2Vs
eSAKd2l0aCB1c2Vyc3BhY2UuIEUuZyB0aGUgZGV2aWNlIChjb250cm9sIHBhdGgpIGlzIGltcGxl
bWVudGVkIGluIHRoZSAKa2VybmVsIGJ1dCB0aGUgZGF0YXBhdGggaXMgaW1wbGVtZW50ZWQgaW4g
dGhlIHVzZXJzcGFjZSBsaWtlIFRVTi9UQVAuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gWW9uZ2pp
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
