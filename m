Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729B6C1B08C
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 05:01:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266936128B
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 05:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266936128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A733183D3C;
	Thu, 15 Jul 2021 05:01:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kZ8wTHUGa00; Thu, 15 Jul 2021 05:01:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 924A383D30;
	Thu, 15 Jul 2021 05:01:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C9A3C0022;
	Thu, 15 Jul 2021 05:01:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7202C001A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 05:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94A9660B15
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 05:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JB9nqU6asVM8 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 05:01:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED7476076B
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 05:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626325277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtjoUKLcgmL3bnw/gxqCJv6EYfcYaY0E3bn8JDpe3PI=;
 b=NRHwQ0mfc+N910GwrP2+5WyQPvU2t5lzubt6aOZSL5Ifo9QIYZw+Y70g8fS7B/odNKMhL+
 YgHnyPxgSnJiLx3r6rtfTgNcxoK+HHU5xfmijkaGRsIynHXh546pJVcCTptqOACMHpORfz
 +q58YkukocLMtw/XtdJdEwWOSq4ksI8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-MnDLLlVlNyWbUSPR1JXTyg-1; Thu, 15 Jul 2021 01:01:14 -0400
X-MC-Unique: MnDLLlVlNyWbUSPR1JXTyg-1
Received: by mail-pj1-f72.google.com with SMTP id
 jx12-20020a17090b46ccb029017365ced08eso5093587pjb.3
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 22:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WtjoUKLcgmL3bnw/gxqCJv6EYfcYaY0E3bn8JDpe3PI=;
 b=g13VwVZuMrSRLU1nj2JvML1jxo0jnqSEkFQd8XROR/1VUJaYqizr/T3Cz1L2OjA/Yr
 Ff0imyqLPhD5V+cHIhqoA12ZHBnpQf/GVyIo0x6Y2HX6rFT39m8ekoLNW38pYPRKuLt4
 inMpcWC/i5+ZZw6jaCpa7AZwmYCorWCuR5EDMnja2vFM4rpm+hRWHS+9yr6UzQpabw+l
 SMq1fdt52UPFJVtJv3m3rMj4NrnDiMlFG99p/I8ECno+gAPMV29rKmELdSu2Cz+/dtdD
 3R8nDcB7THxa1XfeHZ8j+fAsLC7dESDoZNDdRGjdFLdD2UMekSRKyRHvWqDDzLRfzAQR
 VM1g==
X-Gm-Message-State: AOAM533EkP2oSoBowgGDAvbyBvIhCaqq3Qj8jM8ktd7wwuGp9g+OTRtS
 xHkN1+WPyA9MPMbhX9Q99eNuq+ZDkRcXXLh06K3soX/JMa7U58RjykFTkqZ3lgXmFrnQo4458A9
 2Bie/pZyB7Z1sHrHmRfrTtklZdYHNPg==
X-Received: by 2002:a63:1e5c:: with SMTP id p28mr2391182pgm.3.1626325272857;
 Wed, 14 Jul 2021 22:01:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkpF4TSDI5DZm/B2bv9bWVuNXDKhmhRtseurS2rxggrCDnmBokVeS6bdawuICnE0MaFRu/xw==
X-Received: by 2002:a63:1e5c:: with SMTP id p28mr2391148pgm.3.1626325272634;
 Wed, 14 Jul 2021 22:01:12 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o20sm5070990pgv.80.2021.07.14.22.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jul 2021 22:01:12 -0700 (PDT)
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
 <CACycT3uh+wUeDM1H7JiCJTMeCVCBngURGKeXD-h+meekNNwiQw@mail.gmail.com>
 <ec3e2729-3490-851f-ed4b-6dee9c04831c@redhat.com>
 <CACycT3vTyR=+6xOJyXCu_bGAKcz4Fx3bA25WfdBjhxJ6MOvLzw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5d756360-b540-2faf-6e52-e7e6e863ca0b@redhat.com>
Date: Thu, 15 Jul 2021 13:00:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vTyR=+6xOJyXCu_bGAKcz4Fx3bA25WfdBjhxJ6MOvLzw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, He Zhe <zhe.he@windriver.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzcvMTUg5LiL5Y2IMTI6MDMsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+PiBXaGljaCBp
b2N0bCBjYW4gYmUgdXNlZCBmb3IgdGhpcz8KPj4KPiBJIG1lYW4gd2UgY2FuIGludHJvZHVjZSBh
IG5ldyBpb2N0bCBmb3IgdGhhdCBpbiB0aGUgZnV0dXJlLgoKCk9rLCBJIHNlZS4KCgo+Cj4+Pj4g
SSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8gZG8gc29tZXRoaW5nIHNpbWlsYXIgdG8gY2N3Ogo+
Pj4+Cj4+Pj4gMSkgcmVxdWlyZXMgdGhlIHVzZXJzcGFjZSB0byB1cGRhdGUgdGhlIHN0YXR1cyBi
aXQgaW4gdGhlIHJlc3BvbnNlCj4+Pj4gMikgdXBkYXRlIHRoZSBkZXYtPnN0YXR1cyB0byB0aGUg
c3RhdHVzIGluIHRoZSByZXNwb25zZSBpZiBubyB0aW1lb3V0Cj4+Pj4KPj4+PiBUaGVuIHVzZXJz
cGFjZSBjb3VsZCB0aGVuIHNldCBORUVEU19SRVNFVCBpZiBuZWNlc3NhcnkuCj4+Pj4KPj4+IEJ1
dCBORUVEU19SRVNFVCBkb2VzIG5vdCBvbmx5IGhhcHBlbiBpbiB0aGlzIGNhc2UuCj4+IFllcywg
c28geW91IG5lZWQgYW4gaW9jdGwgZm9yIHVzZXJzcGFjZSB0byB1cGRhdGUgdGhlIGRldmljZSBz
dGF0dXMKPj4gKE5FRURTX1JFU0VUKSBwcm9iYWJseS4KPj4KPiBZZXMsIGJ1dCBJJ2QgbGlrZSB0
byBkbyB0aGF0IGFmdGVyIHRoZSBpbml0aWFsIHZlcnNpb24gaXMgbWVyZ2VkIHNpbmNlCj4gTkVF
RFNfUkVTRVQgaXMgbm90IHN1cHBvcnRlZCBub3cuCgoKUmlnaHQuCgpUaGFua3MKCgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
