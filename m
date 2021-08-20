Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D46C43214
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 15:38:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF53B6103D
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 15:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF53B6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7870A8184F;
	Fri, 20 Aug 2021 15:38:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QaLnzmDOZLnh; Fri, 20 Aug 2021 15:38:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 403DC81751;
	Fri, 20 Aug 2021 15:38:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21C8DC001A;
	Fri, 20 Aug 2021 15:38:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EDF3C000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 15:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F16C0401EF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 15:38:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UQGX_GLNDt3h for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 15:38:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3100940105
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 15:38:12 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id q2so9525477pgt.6
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dVOZ4z0XPa7OayGE8ECMnwdJyIdPwvP3nXcnH8MPASM=;
 b=A/zNrhCd3U9O9ero/5NghZBre9EOOjJ3OGobszwgvGoiOz7/5WsjufLewqFNiAvU0v
 UdflMS96g40+NfLrBAqJeCjCdymuciBQ80Yx/AQ8ITRU/L7SATQ2tHnIIaF5k29JMsjP
 WAvdDEXHkH/FVzOYK69bzTjmosbJipBqxfsdB/cAPu2yYaYLLNyru8HIfNH/zhlEl+mU
 b5+PJ4XRQM2BJW9oXzisu/vOdi7dHLX+vQAJHyTA5vk0DQ7OMESbpxAVqABg7O8/+78J
 3nht4WbwZ0TDJVCxNgnUkxAG6lFfKLPK4ZeS+qG0noIJNBwIfI2dl2YXRq8khGR4QbyN
 AtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dVOZ4z0XPa7OayGE8ECMnwdJyIdPwvP3nXcnH8MPASM=;
 b=oeqSeoA0fbi+ciQjnlga4cyJjjpshPa0Xp44ukWePO6Zt5Gyh3lCNYRRxTuDhveCtx
 QLnNYdXlDHqTmArrZbbm3D9hh9NO5bRvoCx4ScQspCeXHEyoYfu6Mkrby7oI1bn0Kjtq
 1lQeYXLU2qq74zyjVwzN82Y+E3MkfPmAhNltylpt7nWkK9uB3vpvuzxH2J+DXb2TfDhG
 eSCbCzfH1kYv8+qNZJFBqhbtgY+wPAslARVaU/p2shStv+B3mZm5lLVMfyN45E0bWaao
 ZpYwl488lzQOW13zbKzD5Ss0N9H5jUqrHuQ5cxdfnKKBQD5Sv7EJzpep4UItdnUB8/A2
 INYw==
X-Gm-Message-State: AOAM531tWpJYoTWi1+ZzA9QKEtCcvz5hGumeNHalMIY4db/aRpm/ynIR
 rNPhqXDxJUVSxIEkKrfufwg=
X-Google-Smtp-Source: ABdhPJyVl6KA/n8a2L0ZyHmpD0HkIjOfmbblHOo22Ydnq/pt3+qZWO40wgWo8CzM7IJsFIvGGIvzGQ==
X-Received: by 2002:a63:1962:: with SMTP id 34mr19583687pgz.14.1629473891609; 
 Fri, 20 Aug 2021 08:38:11 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 i26sm7738720pfu.6.2021.08.20.08.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Aug 2021 08:38:11 -0700 (PDT)
Subject: Re: [PATCH V3 13/13] HV/Storvsc: Add Isolation VM support for storvsc
 driver
From: Tianyu Lan <ltykernel@gmail.com>
To: Michael Kelley <mikelley@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "ardb@kernel.org" <ardb@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "rientjes@google.com" <rientjes@google.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "tj@kernel.org" <tj@kernel.org>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-14-ltykernel@gmail.com>
 <MWHPR21MB1593EEF30FFD5C60ED744985D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
 <a96626db-4ac9-3ce4-64e9-92568e4f827a@gmail.com>
Message-ID: <9ae704a9-838c-0a54-9c16-f0f10eaaaefe@gmail.com>
Date: Fri, 20 Aug 2021 23:37:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a96626db-4ac9-3ce4-64e9-92568e4f827a@gmail.com>
Content-Language: en-US
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>
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

T24gOC8yMC8yMDIxIDExOjIwIFBNLCBUaWFueXUgTGFuIHdyb3RlOgo+PiBUaGUgd2hvbGUgYXBw
cm9hY2ggaGVyZSBpcyB0byBkbyBkbWEgcmVtYXBwaW5nIG9uIGVhY2ggaW5kaXZpZHVhbCBwYWdl
Cj4+IG9mIHRoZSBJL08gYnVmZmVyLsKgIEJ1dCB3b3VsZG4ndCBpdCBiZSBwb3NzaWJsZSB0byB1
c2UgZG1hX21hcF9zZygpIHRvIAo+PiBtYXAKPj4gZWFjaCBzY2F0dGVybGlzdCBlbnRyeSBhcyBh
IHVuaXQ/wqAgRWFjaCBzY2F0dGVybGlzdCBlbnRyeSBkZXNjcmliZXMgYSAKPj4gcmFuZ2Ugb2YK
Pj4gcGh5c2ljYWxseSBjb250aWd1b3VzIG1lbW9yeS7CoCBBZnRlciBkbWFfbWFwX3NnKCksIHRo
ZSByZXN1bHRpbmcgZG1hCj4+IGFkZHJlc3MgbXVzdCBhbHNvIHJlZmVyIHRvIGEgcGh5c2ljYWxs
eSBjb250aWd1b3VzIHJhbmdlIGluIHRoZSBzd2lvdGxiCj4+IGJvdW5jZSBidWZmZXIgbWVtb3J5
LsKgwqAgU28gYXQgdGhlIHRvcCBvZiB0aGUgImZvciIgbG9vcCBvdmVyIHRoZSAKPj4gc2NhdHRl
cmxpc3QKPj4gZW50cmllcywgZG8gZG1hX21hcF9zZygpIGlmIHdlJ3JlIGluIGFuIGlzb2xhdGVk
IFZNLsKgIFRoZW4gY29tcHV0ZSB0aGUKPj4gaHZwZm4gdmFsdWUgYmFzZWQgb24gdGhlIGRtYSBh
ZGRyZXNzIGluc3RlYWQgb2Ygc2dfcGFnZSgpLsKgIEJ1dCAKPj4gZXZlcnl0aGluZwo+PiBlbHNl
IGlzIHRoZSBzYW1lLCBhbmQgdGhlIGlubmVyIGxvb3AgZm9yIHBvcHVsYXRpbmcgdGhlIHBmbl9h
cnJ5IGlzIAo+PiB1bm1vZGlmaWVkLgo+PiBGdXJ0aGVybW9yZSwgdGhlIGRtYV9yYW5nZSBhcnJh
eSB0aGF0IHlvdSd2ZSBhZGRlZCBpcyBub3QgbmVlZGVkLCBzaW5jZQo+PiBzY2F0dGVybGlzdCBl
bnRyaWVzIGFscmVhZHkgaGF2ZSBhIGRtYV9hZGRyZXNzIGZpZWxkIGZvciBzYXZpbmcgdGhlIAo+
PiBtYXBwZWQKPj4gYWRkcmVzcywgYW5kIGRtYV91bm1hcF9zZygpIHVzZXMgdGhhdCBmaWVsZC4K
PiAKPiBJIGRvbid0IHVzZSBkbWFfbWFwX3NnKCkgaGVyZSBpbiBvcmRlciB0byBhdm9pZCBpbnRy
b2R1Y2luZyBvbmUgbW9yZSAKPiBsb29wKGUsZyBkbWFfbWFwX3NnKCkpLiBXZSBhbHJlYWR5IGhh
dmUgYSBsb29wIHRvIHBvcHVsYXRlIAo+IGNtZF9yZXF1ZXN0LT5kbWFfcmFuZ2VbXSBhbmQgc28g
ZG8gdGhlIGRtYSBtYXAgaW4gdGhlIHNhbWUgbG9vcC4KClNvcnJ5IGZvciBhIHR5cG8uIHMvY21k
X3JlcXVlc3QtPmRtYV9yYW5nZVtdL3BheWxvYWQtPnJhbmdlLnBmbl9hcnJheVtdLwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
