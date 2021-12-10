Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E85BC433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 14:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9194411D0;
	Fri, 10 Dec 2021 14:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CSf8w6Gz44xD; Fri, 10 Dec 2021 14:01:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47443401F5;
	Fri, 10 Dec 2021 14:01:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27C5BC001E;
	Fri, 10 Dec 2021 14:01:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94643C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 14:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B5A7411D0
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 14:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YHQUvs0iZpv7 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 14:01:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1BB5401F5
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 14:01:29 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id p18so6314100plf.13
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 06:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=qGyMg3tvfT9nUCepnAppoZ9Lv+yUxkzqt89//s+CHr8=;
 b=E5gvOzOd9Jcgbo7L0/Gr2lPgDb+GzCE1t9Hj5oLewunkZJ69lNCjzxAU+rrM7IZX8M
 m3l9lRj2J8s1wNDOSmylB7KXS78MBT5AoUfgGA9Lt5H9CgvPI3rtE+36X8jmCXZD/FQh
 vN05DUXd4DejDyXPhkRZD+YfK5YG6cv397KJs01OrVXKhlLKE0Awcy1NbP8ZR9zum4Tx
 0ERuW0U61lzP2W3au6RMK4oP4M2lfyyNEhkRSZbW81m729P0vMx/YjDbGowwayZRjSDb
 MwIhPqLO1Vk1KSKHZP9u/MTjJi8Fb3+F/5X7rj5h2Q4nFoGUHhKLQYJfktOvskXkeuok
 ML3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=qGyMg3tvfT9nUCepnAppoZ9Lv+yUxkzqt89//s+CHr8=;
 b=QBO2eKkbZ9d3kF+o/KpYJ68WKoTbIqa+1BuCoLaWYEusTQg6dd/n1PS0gh3fv9eg3V
 6KMD8b21SckX8E/9Wa+163MZngsLZamPwIkve/bOR0HD3jmzjT04j543JLwIPa0rujVM
 OIrIJoQByb4tFp9LgkcDp57spBkHEgvLs/Wu1I4DuFHmNqPCJtc3pbvbUgwffdRO5qGe
 cIv6TNmvLVzjU+NJERsjji5w6GNBuIAmrGRCYzN5YgsNO9KmzRkVZ/c3zC7y053GChZS
 0qglDlILjb1/yWyv44F/wg6cuHt4leA3agnc/oKioZjzoQ6c48qRo9zytuBHnYflx4h+
 MUPQ==
X-Gm-Message-State: AOAM530D1omiK546t5sFJpiJKzb9sS4hf6TMUAeJFSGAxnIr7fsEpgC0
 Er7QJ6rk3FR1fZyw0m2SrtY=
X-Google-Smtp-Source: ABdhPJyN70DofvK36my/JEa51Le1W77gGRolxr53HVM8X29rx2LLiZygscgs0COaIR0G2PUhK4LxUA==
X-Received: by 2002:a17:90b:384a:: with SMTP id
 nl10mr24345699pjb.234.1639144888831; 
 Fri, 10 Dec 2021 06:01:28 -0800 (PST)
Received: from [10.10.156.113] ([167.220.233.113])
 by smtp.gmail.com with ESMTPSA id n71sm3733339pfd.50.2021.12.10.06.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Dec 2021 06:01:28 -0800 (PST)
Message-ID: <6baeb3c4-a493-80d1-439d-fa7dbe1a703a@gmail.com>
Date: Fri, 10 Dec 2021 22:01:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V6 3/5] hyper-v: Enable swiotlb bounce buffer for
 Isolation VM
Content-Language: en-US
From: Tianyu Lan <ltykernel@gmail.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "hch@infradead.org" <hch@infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
References: <20211207075602.2452-1-ltykernel@gmail.com>
 <20211207075602.2452-4-ltykernel@gmail.com>
 <MWHPR21MB159359667085776793988EACD7709@MWHPR21MB1593.namprd21.prod.outlook.com>
 <4d60fcd1-97df-f4a1-1b79-643e65f66b3e@gmail.com>
In-Reply-To: <4d60fcd1-97df-f4a1-1b79-643e65f66b3e@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>, "hch@lst.de" <hch@lst.de>
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

CgpPbiAxMi8xMC8yMDIxIDk6MjUgUE0sIFRpYW55dSBMYW4gd3JvdGU6Cj4+PiBAQCAtMzE5LDgg
KzMyMCwxNiBAQCBzdGF0aWMgdm9pZCBfX2luaXQgbXNfaHlwZXJ2X2luaXRfcGxhdGZvcm0odm9p
ZCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9pbmZvKCJIeXBlci1WOiBJc29sYXRpb24gQ29u
ZmlnOiBHcm91cCBBIDB4JXgsIEdyb3VwIEIgCj4+PiAweCV4XG4iLAo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbXNfaHlwZXJ2Lmlzb2xhdGlvbl9jb25maWdfYSwgCj4+PiBtc19oeXBl
cnYuaXNvbGF0aW9uX2NvbmZpZ19iKTsKPj4+Cj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGh2X2dl
dF9pc29sYXRpb25fdHlwZSgpID09IEhWX0lTT0xBVElPTl9UWVBFX1NOUCkKPj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAoaHZfZ2V0X2lzb2xhdGlvbl90eXBlKCkgPT0gSFZfSVNPTEFUSU9OX1RZUEVf
U05QKSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGF0aWNfYnJhbmNoX2VuYWJs
ZSgmaXNvbGF0aW9uX3R5cGVfc25wKTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN3aW90
bGJfdW5lbmNyeXB0ZWRfYmFzZSA9IG1zX2h5cGVydi5zaGFyZWRfZ3BhX2JvdW5kYXJ5Owo+Pj4g
K8KgwqDCoMKgwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoCAvKgo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqAgKiBFbmFibGUgc3dpb3RsYiBmb3JjZSBtb2RlIGluIElzb2xhdGlvbiBWTSB0
bwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB1c2Ugc3dpb3RsYiBib3VuY2UgYnVmZmVyIGZvciBk
bWEgdHJhbnNhY3Rpb24uCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4gK8KgwqDCoMKgwqDC
oMKgIHN3aW90bGJfZm9yY2UgPSBTV0lPVExCX0ZPUkNFOwo+PiBJJ20gZ29vZCB3aXRoIHRoaXMg
YXBwcm9hY2ggdGhhdCBkaXJlY3RseSB1cGRhdGVzIHRoZSBzd2lvdGxiIHNldHRpbmdzIAo+PiBo
ZXJlCj4+Cj4+IHJhdGhlciB0aGFuIGluIElPTU1VIGluaXRpYWxpemF0aW9uIGNvZGUuwqAgSXQn
cyBhIGxvdCBtb3JlIAo+PiBzdHJhaWdodGZvcndhcmQuCj4+Cj4+IEhvd2V2ZXIsIHRoZXJlJ3Mg
YW4gaXNzdWUgaWYgYnVpbGRpbmcgZm9yIFg4Nl8zMiB3aXRob3V0IFBBRSwgaW4gdGhhdCB0aGUK
Pj4gc3dpb3RsYiBtb2R1bGUgbWF5IG5vdCBiZSBidWlsdCwgcmVzdWx0aW5nIGluIGNvbXBpbGUg
YW5kIGxpbmsgCj4+IGVycm9ycy7CoCBUaGUKPj4gc3dpb3RsYi5oIGZpbGUgbmVlZHMgdG8gYmUg
dXBkYXRlZCB0byBwcm92aWRlIGEgc3R1YiBmdW5jdGlvbiBmb3IKPj4gc3dpb3RsYl91cGRhdGVf
bWVtX2F0dHJpYnV0ZXMoKS7CoMKgIHN3aW90bGJfdW5lbmNyeXB0ZWRfYmFzZSBwcm9iYWJseQo+
PiBuZWVkcyB3cmFwcGVyIGZ1bmN0aW9ucyB0byBnZXQvc2V0IGl0LCB3aGljaCBjYW4gYmUgc3R1
YnMgd2hlbgo+PiBDT05GSUdfU1dJT1RMQiBpcyBub3Qgc2V0LsKgIHN3aW90bGJfZm9yY2UgaXMg
YSBiaXQgb2YgYSBtZXNzIGluIHRoYXQgCj4+IGl0IGFscmVhZHkKPj4gaGFzIGEgc3R1YiBkZWZp
bml0aW9uIHRoYXQgYXNzdW1lcyBpdCB3aWxsIG9ubHkgYmUgcmVhZCwgYW5kIG5vdCBzZXQuICAK
Pj4gQSBiaXQgb2YKPj4gdGhpbmtpbmcgd2lsbCBiZSBuZWVkZWQgdG8gc29ydCB0aGF0IG91dC4K
PiAKPiBJdCdzIG9rIHRvIGZpeCB0aGUgaXNzdWUgdmlhIHNlbGVjdGluZyBzd2lvdGxiIHdoZW4g
Q09ORklHX0hZUEVSViBpcwo+IHNldD8KPiAKU29ycnkuIGlnbm9yZSB0aGUgcHJldmlvdXMgc3Rh
dGVtZW50LiBUaGVzZSBjb2RlcyBkb2Vzbid0IGRlcGVuZCBvbiAKQ09ORklHX0hZUEVSVi4KCkhv
dyBhYm91dCBtYWtpbmcgdGhlc2UgY29kZSB1bmRlciAjaWZkZWYgQ09ORklHX1g4Nl82NCBvciBD
T05GSUdfU1dJT1RMQj8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
