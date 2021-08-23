Return-Path: <SRS0=Bvs7=NO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701AFC432BE
	for <iommu@archiver.kernel.org>; Mon, 23 Aug 2021 06:57:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165AB6135A
	for <iommu@archiver.kernel.org>; Mon, 23 Aug 2021 06:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 165AB6135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D429680D6A;
	Mon, 23 Aug 2021 06:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BJ6UV5mK9A7X; Mon, 23 Aug 2021 06:56:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B018E80CFA;
	Mon, 23 Aug 2021 06:56:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96C1FC001A;
	Mon, 23 Aug 2021 06:56:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AA90C000E
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 06:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2625D60683
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 06:56:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yPUCGeWVX1Jp for <iommu@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 06:56:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78E0960617
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629701810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6CVC1MYmQ2Yd0dGkq2W7I4r7P5G0FEqZECeGZvY4DU=;
 b=bGgS84DUOO9HZuvU4UuFplQU6CWUj6ZBx6nt8N8uyhMFtalN3AjQ7rc16CS59CxReRnJ2/
 qMTmSyKekUPcHdNFNp1JYcT9mMsCod++uTmko4h/TiqF1I2R2BEGr1UYYsLVJOiUXMaxne
 8wfxja4xDlmy/oWBXE+F0RIKJBoszlo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-ceH-4n_5McOlbyo8O-y11A-1; Mon, 23 Aug 2021 02:56:48 -0400
X-MC-Unique: ceH-4n_5McOlbyo8O-y11A-1
Received: by mail-pj1-f69.google.com with SMTP id
 nn5-20020a17090b38c500b00179d350674aso6465692pjb.5
 for <iommu@lists.linux-foundation.org>; Sun, 22 Aug 2021 23:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=O6CVC1MYmQ2Yd0dGkq2W7I4r7P5G0FEqZECeGZvY4DU=;
 b=k/tbKOFTu5IUvyPtXVv/oDauyYK0bvO9bibqwI8pgeG4euemkLd68BdHbvsoY0DAa4
 wDD7NuNEc0bjBcXtIADlW8QA6MBx7/g0eYzPtD5xO9NQizSJazvclJ9pzUF9A3MJeFOY
 pfuRtxin4MLH3Fls/5u7vD3pIdfsCwSN9e+aQx9XLawIEvxU5yPJKhBElQFGYSjYV/ot
 uKKLqJkPWCO5jh1F50ktnnJ4HC+9di0Q6PISSveuqFV9RQ4DcDhar6+shAqx+bd4C4nS
 yjjjs/PYFv6KFw8QLwd8xEP+ARNya1rAQ9socclNg1RCw0aeFWm4gzqLwevFYT/9o1L3
 EGBw==
X-Gm-Message-State: AOAM530lkyWUY7SN3hN8xsoS88eqxFgXQ1E2BpH6KN6x/n3CgDKJGkim
 ua9dEnsegfZ3WefF7p8+NWier06M6NBHaVPYiaUxLhWSiQ9zSHcSAz679YzWd1Ontv4ajaYK4EF
 sBjCmHRz/Ny0SANMqLV27KKbSc2da/g==
X-Received: by 2002:aa7:9ddc:0:b0:3e1:5fc1:1d20 with SMTP id
 g28-20020aa79ddc000000b003e15fc11d20mr32664047pfq.48.1629701807259; 
 Sun, 22 Aug 2021 23:56:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeDlxuu1bqct4xksqs7isW8FxpMxOH+GNhpdYUwjloBQhDlJbitQ/vFhNd4D+BhyIvDS4Fgg==
X-Received: by 2002:aa7:9ddc:0:b0:3e1:5fc1:1d20 with SMTP id
 g28-20020aa79ddc000000b003e15fc11d20mr32664016pfq.48.1629701807013; 
 Sun, 22 Aug 2021 23:56:47 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n30sm14807096pfv.87.2021.08.22.23.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Aug 2021 23:56:46 -0700 (PDT)
Subject: Re: [PATCH v11 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-12-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cfc11f6b-764b-7a52-2c4a-6fa22e6c1585@redhat.com>
Date: Mon, 23 Aug 2021 14:56:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-12-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOC8xOCDPws7nODowNiwgWGllIFlvbmdqaSDQtLXAOgo+IFRoaXMgVkRVU0UgZHJp
dmVyIGVuYWJsZXMgaW1wbGVtZW50aW5nIHNvZnR3YXJlLWVtdWxhdGVkIHZEUEEKPiBkZXZpY2Vz
IGluIHVzZXJzcGFjZS4gVGhlIHZEUEEgZGV2aWNlIGlzIGNyZWF0ZWQgYnkKPiBpb2N0bChWRFVT
RV9DUkVBVEVfREVWKSBvbiAvZGV2L3ZkdXNlL2NvbnRyb2wuIFRoZW4gYSBjaGFyIGRldmljZQo+
IGludGVyZmFjZSAoL2Rldi92ZHVzZS8kTkFNRSkgaXMgZXhwb3J0ZWQgdG8gdXNlcnNwYWNlIGZv
ciBkZXZpY2UKPiBlbXVsYXRpb24uCj4KPiBJbiBvcmRlciB0byBtYWtlIHRoZSBkZXZpY2UgZW11
bGF0aW9uIG1vcmUgc2VjdXJlLCB0aGUgZGV2aWNlJ3MKPiBjb250cm9sIHBhdGggaXMgaGFuZGxl
ZCBpbiBrZXJuZWwuIEEgbWVzc2FnZSBtZWNobmlzbSBpcyBpbnRyb2R1Y2VkCj4gdG8gZm9yd2Fy
ZCBzb21lIGRhdGFwbGFuZSByZWxhdGVkIGNvbnRyb2wgbWVzc2FnZXMgdG8gdXNlcnNwYWNlLgo+
Cj4gQW5kIGluIHRoZSBkYXRhIHBhdGgsIHRoZSBETUEgYnVmZmVyIHdpbGwgYmUgbWFwcGVkIGlu
dG8gdXNlcnNwYWNlCj4gYWRkcmVzcyBzcGFjZSB0aHJvdWdoIGRpZmZlcmVudCB3YXlzIGRlcGVu
ZGluZyBvbiB0aGUgdkRQQSBidXMgdG8KPiB3aGljaCB0aGUgdkRQQSBkZXZpY2UgaXMgYXR0YWNo
ZWQuIEluIHZpcnRpby12ZHBhIGNhc2UsIHRoZSBNTVUtYmFzZWQKPiBzb2Z0d2FyZSBJT1RMQiBp
cyB1c2VkIHRvIGFjaGlldmUgdGhhdC4gQW5kIGluIHZob3N0LXZkcGEgY2FzZSwgdGhlCj4gRE1B
IGJ1ZmZlciBpcyByZXNpZGUgaW4gYSB1c2Vyc3BhY2UgbWVtb3J5IHJlZ2lvbiB3aGljaCBjYW4g
YmUgc2hhcmVkCj4gdG8gdGhlIFZEVVNFIHVzZXJzcGFjZSBwcm9jZXNzcyB2aWEgdHJhbnNmZXJy
aW5nIHRoZSBzaG1mZC4KPgo+IEZvciBtb3JlIGRldGFpbHMgb24gVkRVU0UgZGVzaWduIGFuZCB1
c2FnZSwgcGxlYXNlIHNlZSB0aGUgZm9sbG93LW9uCj4gRG9jdW1lbnRhdGlvbiBjb21taXQuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KCgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
