Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B704AC47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 05:29:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5422A6136E
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 05:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5422A6136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C0868318B;
	Tue,  1 Jun 2021 05:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GjLcS_Z-oDPB; Tue,  1 Jun 2021 05:29:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E92CB83187;
	Tue,  1 Jun 2021 05:29:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8B92C000E;
	Tue,  1 Jun 2021 05:29:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05FC2C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 05:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E88A8605F2
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 05:29:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JE6MaJ_CS4JF for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:29:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F513605BB
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 05:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622525393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siJz2CTmBAQXJpnvED6F5Lh0Z4do04zZE0SUG5Fvo2s=;
 b=ZZ2Gs+WAwGUw4hJSrtGoi8pFBeenRUCZil/IUzcdrozKK0LSvAz/CqeIN+kKwLkFYc5qDY
 0x8/5YfX9+mWPuaWy59Ksgq7ANoc4AQYyo4dS426j21J6l5x/1EVuQq5hMf/rsS8io6Cla
 d2C8xtBN0BN5tzdqL95wQpbc89LhBKM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-4Jb_D2LOMTOTL738Ua8Ygw-1; Tue, 01 Jun 2021 01:29:49 -0400
X-MC-Unique: 4Jb_D2LOMTOTL738Ua8Ygw-1
Received: by mail-pl1-f197.google.com with SMTP id
 u1-20020a1709027141b02901040cac08fdso1955166plm.12
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 22:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=siJz2CTmBAQXJpnvED6F5Lh0Z4do04zZE0SUG5Fvo2s=;
 b=Q4rKWO3ixeP0r0cbJI7sw4PN3yg6c6t9CdcwZwrL30rnj3S7IDd3qBojD3YRcYktDY
 9Gr+b5VGGAB0NuoIKxzPCpJ5L+qWwLf3FRjaCgjcWzi4Yxxz2l0vapHOluSsTvvf7Rk1
 kHPatl9itcwsSroEbIN5PizmE6nORq+oRKrzIgqORMLecwfePOG2XqOl7WAcgTV6+Sxi
 cwZzfM6HkDnC9cy0zcDUGCtcPoujUIGhi5NjXMrDfVumw7LEYoWFoymALpwW1gk2LT5C
 4ARCDdDErz/J+FS2dUfd9QKLgbDGW3PGtWQnvsh2EQfAlDXT+5uSJyFpDYgsBovtZx6v
 M/IA==
X-Gm-Message-State: AOAM531Qupgit5V8f7Mx8oAONK0utgZepgd/bnQHqHwRdNr8fwzNZRxm
 LDgIX99RRMQEgaxwzdg2xP7KcyGIaYoqWbWBMaDqXXG9JBS1+Tiy+jcSOHiXUtZVERXbS+JqQIT
 H5LgC0rc9DB4L1g4+Wsl7EpAWucaWKw==
X-Received: by 2002:a17:90a:4d0a:: with SMTP id
 c10mr2950613pjg.206.1622525388810; 
 Mon, 31 May 2021 22:29:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ7rHezJVl5toCxwphy2EqgUV3yr26yAhv4PAH3egfoOPVMm51yn71ZSBxAm52zcWBKyM7sw==
X-Received: by 2002:a17:90a:4d0a:: with SMTP id
 c10mr2950597pjg.206.1622525388516; 
 Mon, 31 May 2021 22:29:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y20sm12198235pfn.164.2021.05.31.22.29.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 22:29:48 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Lu Baolu <baolu.lu@linux.intel.com>, Liu Yi L <yi.l.liu@linux.intel.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
Date: Tue, 1 Jun 2021 13:29:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>
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

CuWcqCAyMDIxLzYvMSDkuIvljYgxOjIzLCBMdSBCYW9sdSDlhpnpgZM6Cj4gSGkgSmFzb24gVywK
Pgo+IE9uIDYvMS8yMSAxOjA4IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IDIpIElmIHllcywg
d2hhdCdzIHRoZSByZWFzb24gZm9yIG5vdCBzaW1wbHkgdXNlIHRoZSBmZCBvcGVuZWQgZnJvbQo+
Pj4+IC9kZXYvaW9hcy4gKFRoaXMgaXMgdGhlIHF1ZXN0aW9uIHRoYXQgaXMgbm90IGFuc3dlcmVk
KSBhbmQgd2hhdCAKPj4+PiBoYXBwZW5zCj4+Pj4gaWYgd2UgY2FsbCBHRVRfSU5GTyBmb3IgdGhl
IGlvYXNpZF9mZD8KPj4+PiAzKSBJZiBub3QsIGhvdyBHRVRfSU5GTyB3b3JrPwo+Pj4gb2gsIG1p
c3NlZCB0aGlzIHF1ZXN0aW9uIGluIHByaW9yIHJlcGx5LiBQZXJzb25hbGx5LCBubyBzcGVjaWFs
IHJlYXNvbgo+Pj4geWV0LiBCdXQgdXNpbmcgSUQgbWF5IGdpdmUgdXMgb3Bwb3J0dW5pdHkgdG8g
Y3VzdG9taXplIHRoZSBtYW5hZ2VtZW50Cj4+PiBvZiB0aGUgaGFuZGxlLiBGb3Igb25lLCBiZXR0
ZXIgbG9va3VwIGVmZmljaWVuY3kgYnkgdXNpbmcgeGFycmF5IHRvCj4+PiBzdG9yZSB0aGUgYWxs
b2NhdGVkIElEcy4gRm9yIHR3bywgY291bGQgY2F0ZWdvcml6ZSB0aGUgYWxsb2NhdGVkIElEcwo+
Pj4gKHBhcmVudCBvciBuZXN0ZWQpLiBHRVRfSU5GTyBqdXN0IHdvcmtzIHdpdGggYW4gaW5wdXQg
RkQgYW5kIGFuIElELgo+Pgo+Pgo+PiBJJ20gbm90IHN1cmUgSSBnZXQgdGhpcywgZm9yIG5lc3Rp
bmcgY2FzZXMgeW91IGNhbiBzdGlsbCBtYWtlIHRoZSAKPj4gY2hpbGQgYW4gZmQuCj4+Cj4+IEFu
ZCBhIHF1ZXN0aW9uIHN0aWxsLCB1bmRlciB3aGF0IGNhc2Ugd2UgbmVlZCB0byBjcmVhdGUgbXVs
dGlwbGUgCj4+IGlvYXNpZHMgb24gYSBzaW5nbGUgaW9hc2lkIGZkPwo+Cj4gT25lIHBvc3NpYmxl
IHNpdHVhdGlvbiB3aGVyZSBtdWx0aXBsZSBJT0FTSURzIHBlciBGRCBjb3VsZCBiZSB1c2VkIGlz
Cj4gdGhhdCBkZXZpY2VzIHdpdGggZGlmZmVyZW50IHVuZGVybHlpbmcgSU9NTVUgY2FwYWJpbGl0
aWVzIGFyZSBzaGFyaW5nIGEKPiBzaW5nbGUgRkQuIEluIHRoaXMgY2FzZSwgb25seSBkZXZpY2Vz
IHdpdGggY29uc2lzdGVudCB1bmRlcmx5aW5nIElPTU1VCj4gY2FwYWJpbGl0aWVzIGNvdWxkIGJl
IHB1dCBpbiBhbiBJT0FTSUQgYW5kIG11bHRpcGxlIElPQVNJRHMgcGVyIEZEIGNvdWxkCj4gYmUg
YXBwbGllZC4KPgo+IFRob3VnaCwgSSBzdGlsbCBub3Qgc3VyZSBhYm91dCAibXVsdGlwbGUgSU9B
U0lEIHBlci1GRCIgdnMgIm11bHRpcGxlCj4gSU9BU0lEIEZEcyIgZm9yIHN1Y2ggY2FzZS4KCgpS
aWdodCwgdGhhdCdzIGV4YWN0bHkgbXkgcXVlc3Rpb24uIFRoZSBsYXR0ZXIgc2VlbXMgbXVjaCBt
b3JlIGVhc2llciB0byAKYmUgdW5kZXJzdG9vZCBhbmQgaW1wbGVtZW50ZWQuCgpUaGFua3MKCgo+
Cj4gQmVzdCByZWdhcmRzLAo+IGJhb2x1Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
