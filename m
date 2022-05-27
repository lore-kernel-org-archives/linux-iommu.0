Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2741C433F5
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 12:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F5BF417E8;
	Fri, 27 May 2022 12:21:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Fodu3mjz2p1; Fri, 27 May 2022 12:21:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B77B41548;
	Fri, 27 May 2022 12:21:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 184D9C0032;
	Fri, 27 May 2022 12:21:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3880C002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 12:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C18584B2B
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 12:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bwvl8R3p7xup for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 12:21:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0CDE184B29
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 12:20:59 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id b5so3986105plx.10
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 05:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:reply-to:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=iJRtC6FZ8/ulUwIgZS39WaHh+o9Ilrp1wW7JFepItc0=;
 b=qSLrw/xH/l+UVkirRAZz/8FZ0ZZjL5uSuxHX7LIvFmTyb2UbiCPcMLJ7FPei3UtAUG
 /ngnpOH2XTctk2kEZnq1GlxnsaUo07pYEaINTbsCgqrOHFJQt24gZQ+ILHVpJtEzyjME
 4UrYxkBjVTiElekXp+gzuW+XAGU6/RtkFdOXe+8dCI4p/cXb8vCquU8DfILasd9urWSo
 KHl1WoMhA+RFZrgD0SzbVWJBhfTAXtdoOWgI9FuBo/sPpuLmHrpwM/ULSW9MXKoel/hj
 SOkK23tv+gEHbYe80ZKZG6/zw7Y4B7GfXZTNIaeke82Up93gcA/IDSi6cSpXHo/eaf+S
 8+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
 :subject:content-language:to:cc:references:from:organization
 :in-reply-to:content-transfer-encoding;
 bh=iJRtC6FZ8/ulUwIgZS39WaHh+o9Ilrp1wW7JFepItc0=;
 b=K+uxwMeTnr3CJ+9MfaVNQGAj0cmnS7JgpPyVyXG2Ms+gJrh/IJiYHF1C8PgJv8keTO
 MJrj4UHKjMBOnCNbx3J7XUijdhT2EUFWCkRxhGRspVXWPx3bgDnkeHtknRriakQm1DJK
 q+p7MnJutT4UK+Hq2Q954inbVSp1GsXvhuHKAjc3Roq+fn4cTGcWS+ztUelSW55yH8zb
 hhIIaqtIDawDZa0AjOT3NAqjooTgqZGD5kRB6zh1eHtlaZ7hXBmzpzJePYAq6LzKjM79
 2Ls5zrHyJ2q9HEFc0PikFvORG8iCQFQsJWwA+QVvCHBTUiBXQ9du5nLTvAK5tMCeKFZ/
 zYBg==
X-Gm-Message-State: AOAM532Tzh/8+EcXDlMK21ytVueDkhhoGjisaq6ooiZ+GJmG6U1Uq9KS
 HVWlaVlr2heq+vhi0U86A2s=
X-Google-Smtp-Source: ABdhPJyhM4+yaDnivdy5jmDUaKkUnBpSnlKSW9KCRZAyRvH55Ju8bIw6KCyC4TQtzI1iKBxbIA25WA==
X-Received: by 2002:a17:903:2305:b0:163:64c7:f9ff with SMTP id
 d5-20020a170903230500b0016364c7f9ffmr11636415plh.46.1653654059447; 
 Fri, 27 May 2022 05:20:59 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::597? ([2404:f801:9000:18:efec::597])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a170902d48b00b0015ea8b4b8f3sm3463974plg.263.2022.05.27.05.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 May 2022 05:20:58 -0700 (PDT)
Message-ID: <56243d2b-d7f6-9e45-d5fd-3af7767d52e3@gmail.com>
Date: Fri, 27 May 2022 20:20:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH V3 2/2] net: netvsc: Allocate per-device swiotlb
 bounce buffer for netvsc
Content-Language: en-US
To: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "hch@infradead.org" <hch@infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "Michael Kelley (LINUX)" <mikelley@microsoft.com>
References: <20220526120113.971512-1-ltykernel@gmail.com>
 <20220526120113.971512-3-ltykernel@gmail.com>
 <BYAPR21MB12706372826A3ABAEF42E716BFD99@BYAPR21MB1270.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Organization: Microsft
In-Reply-To: <BYAPR21MB12706372826A3ABAEF42E716BFD99@BYAPR21MB1270.namprd21.prod.outlook.com>
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kirill.shutemov" <kirill.shutemov@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "andi.kleen@intel.com" <andi.kleen@intel.com>, vkuznets <vkuznets@redhat.com>,
 "hch@lst.de" <hch@lst.de>
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
Reply-To: tiala@microsoft.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiA1LzI3LzIwMjIgMjo0MyBBTSwgRGV4dWFuIEN1aSB3cm90ZToKPj4gRnJvbTogVGlhbnl1
IExhbiA8bHR5a2VybmVsQGdtYWlsLmNvbT4KPj4gU2VudDogVGh1cnNkYXksIE1heSAyNiwgMjAy
MiA1OjAxIEFNCj4+IC4uLgo+PiBAQCAtMTE5LDYgKzEyNCwxMCBAQCBzdGF0aWMgdm9pZCBuZXR2
c2Nfc3ViY2hhbl93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdAo+PiAqdykKPj4gICAJCQludmRldi0+
bWF4X2NobiA9IDE7Cj4+ICAgCQkJbnZkZXYtPm51bV9jaG4gPSAxOwo+PiAgIAkJfQo+PiArCj4+
ICsJCS8qIEFsbG9jYXRlIGJvdWNuZSBidWZmZXIuKi8KPj4gKwkJc3dpb3RsYl9kZXZpY2VfYWxs
b2NhdGUoJmhkZXYtPmRldmljZSwgbnZkZXYtPm51bV9jaG4sCj4+ICsJCQkJMTAgKiBJT19UTEJf
QkxPQ0tfVU5JVCk7Cj4+ICAgCX0KPiAKPiBMb29rcyBsaWtlIHN3aW90bGJfZGV2aWNlX2FsbG9j
YXRlKCkgaXMgbm90IGNhbGxlZCBpZiB0aGUgbmV0dnNjIGRldmljZQo+IGhhcyBvbmx5IDEgcHJp
bWFyeSBjaGFubmVsIGFuZCBubyBzdWItc2NoYW5uZWwsIGUuZy4gaW4gdGhlIGNhc2Ugb2YKPiBz
aW5nbGUtdkNQVSBWTT8KCldoZW4gdGhlcmUgaXMgb25seSBzaW5sZ2XvvIx0aGVyZSBzZWVtcyBu
b3QgdG8gYmUgbXVjaCBwZXJmb3JtYW5jZQpwZW5hbHR5LiBCdXQgeW91IGFyZSByaWdodCwgd2Ug
c2hvdWxkIGtlZXAgdGhlIHNhbWUgYmVoYXZpb3Igd2hlbiBzaW5nbGUgCkNQVSBhbmQgbXVsdGkg
Q1BVLiBXaWxsIHVwZGF0ZSBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKVGhhbmtzLgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
