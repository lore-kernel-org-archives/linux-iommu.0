Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B124C4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 15:46:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADB860FBF
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 15:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DADB860FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8FA6240025;
	Fri, 13 Aug 2021 15:46:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TF0eVzE5vbOn; Fri, 13 Aug 2021 15:46:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4791E40225;
	Fri, 13 Aug 2021 15:46:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A44AC0010;
	Fri, 13 Aug 2021 15:46:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ABFBC000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 15:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0978C605E2
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 15:46:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M_Gqzfo7b-3g for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 15:46:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3136E605BE
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 15:46:37 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id n12so11819220plf.4
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wKFFzJ6O/UU/EGmVRS4t6oCyritoPh4g9td5WczAyTo=;
 b=gpOB0Y8XQiqz1aLvaU6jIg9RPMX5OaDCdWoo9W0/Q2q+kzIydjrOBlFyjP7UzB3kKu
 pKC5fQKwcstAd0YQI+OOMc+Hph81qJBcgd6a6j/eZV4DZzaRXi8P0eE9TkqFFEfuP6Fs
 nqc3F+blWCYXnhrDhS5Xax0X9UD9UA1rqQ97e73U530OMewKqtQ32RmFCPlsK9QLyJDd
 JzDYB4UO2udw85z6h2dZ4RGC4/E80VSb0OqYVuR0Ko6CkL954JcBoU8gKe0yErZye0/l
 hpIPQs5WrePOhscpt5NogL/l9EEbPoUJkMopea8nPd8pJVwp5GuAwu7eXpiJmMd23C80
 v3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wKFFzJ6O/UU/EGmVRS4t6oCyritoPh4g9td5WczAyTo=;
 b=UuQkojvj5kYzd0UhSAwv1eMon26MfY/uV/wXLiILByBePaNJlmZL3UZ6ngTXHyWyZA
 JouXAZrW+oV5XPoRb26PSFIsnmrkJmnMw8GORXiDmoN9Uf+UHYJ9G4/mtCicpbO+pkDU
 tnri0ZRdbf6mcLe1OgI/DXzlj1IIP4wH5fYGUGd4/NBNkeuuqb2W+JDHs9xooVvm/qZ8
 K8gOU8jhBkoWPxlx0NChAvzS8sEFi99TvLjrRJsAE++e0V6VtHQXgQhWfclh0OnOelIx
 vLtw/UUmdCdxhTv5nu5bRn5cSEnkTbJwAOQnlQxTSGZB27APQa0cvcnXe8BxGFbi5C+D
 JdIA==
X-Gm-Message-State: AOAM533mLyP8Aksd4IZA2m53RwUbiC/OH56LyaqUEXoRk3x6Mdt/5nQB
 ZeuDbTguC6RpchOsz+BgG3s=
X-Google-Smtp-Source: ABdhPJzk13A/+fCbnakCVSOwZJNHKGdKPt2T4sFIbI1aKCvZDK2x7JFoHkEcCMPEgs+3McCqxtRHYw==
X-Received: by 2002:a65:6894:: with SMTP id e20mr2777702pgt.419.1628869596537; 
 Fri, 13 Aug 2021 08:46:36 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 g26sm3345160pgb.45.2021.08.13.08.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Aug 2021 08:46:36 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V3 01/13] x86/HV: Initialize GHCB page in Isolation VM
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
 <20210809175620.720923-2-ltykernel@gmail.com>
 <MWHPR21MB1593BDFA4A71CE6882E25400D7F99@MWHPR21MB1593.namprd21.prod.outlook.com>
Message-ID: <ec1b8b47-46b7-910e-df87-584bce585999@gmail.com>
Date: Fri, 13 Aug 2021 23:46:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593BDFA4A71CE6882E25400D7F99@MWHPR21MB1593.namprd21.prod.outlook.com>
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

SGkgTWljaGFlbDoKICAgICAgVGhhbmtzIGZvciB5b3VyIHJldmlldy4KCk9uIDgvMTMvMjAyMSAz
OjE0IEFNLCBNaWNoYWVsIEtlbGxleSB3cm90ZToKPiBGcm9tOiBUaWFueXUgTGFuIDxsdHlrZXJu
ZWxAZ21haWwuY29tPiBTZW50OiBNb25kYXksIEF1Z3VzdCA5LCAyMDIxIDEwOjU2IEFNCj4+IFN1
YmplY3Q6IFtQQVRDSCBWMyAwMS8xM10geDg2L0hWOiBJbml0aWFsaXplIEdIQ0IgcGFnZSBpbiBJ
c29sYXRpb24gVk0KPiAKPiBUaGUgc3ViamVjdCBsaW5lIHRhZyBvbiBwYXRjaGVzIHVuZGVyIGFy
Y2gveDg2L2h5cGVydiBpcyBnZW5lcmFsbHkgIng4Ni9oeXBlcnY6Ii4KPiBUaGVyZSdzIHNvbWUg
dmFyaWF0aW9uIGluIHRoZSBzcGVsbGluZyBvZiAiaHlwZXJ2IiwgYnV0IGxldCdzIGdvIHdpdGgg
dGhlIGFsbAo+IGxvd2VyY2FzZSAiaHlwZXJ2Ii4KCk9LLiBXaWxsIHVwZGF0ZS4KCj4gCj4+Cj4+
IEh5cGVyLVYgZXhwb3NlcyBHSENCIHBhZ2UgdmlhIFNFViBFUyBHSENCIE1TUiBmb3IgU05QIGd1
ZXN0Cj4+IHRvIGNvbW11bmljYXRlIHdpdGggaHlwZXJ2aXNvci4gTWFwIEdIQ0IgcGFnZSBmb3Ig
YWxsCj4+IGNwdXMgdG8gcmVhZC93cml0ZSBNU1IgcmVnaXN0ZXIgYW5kIHN1Ym1pdCBodmNhbGwg
cmVxdWVzdAo+PiB2aWEgR0hDQi4KPj4KPj4gU2lnbmVkLW9mZi1ieTogVGlhbnl1IExhbiA8VGlh
bnl1LkxhbkBtaWNyb3NvZnQuY29tPgo+PiAtLS0KPj4gICBhcmNoL3g4Ni9oeXBlcnYvaHZfaW5p
dC5jICAgICAgIHwgNjYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4+ICAgYXJj
aC94ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCB8ICAyICsKPj4gICBpbmNsdWRlL2FzbS1nZW5l
cmljL21zaHlwZXJ2LmggIHwgIDIgKwo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9o
dl9pbml0LmMgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jCj4+IGluZGV4IDcwOGEyNzEyYTUx
Ni4uMGJiNGQ5Y2E3YTU1IDEwMDY0NAo+PiAtLS0gYS9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5j
Cj4+ICsrKyBiL2FyY2gveDg2L2h5cGVydi9odl9pbml0LmMKPj4gQEAgLTIwLDYgKzIwLDcgQEAK
Pj4gICAjaW5jbHVkZSA8bGludXgva2V4ZWMuaD4KPj4gICAjaW5jbHVkZSA8bGludXgvdmVyc2lv
bi5oPgo+PiAgICNpbmNsdWRlIDxsaW51eC92bWFsbG9jLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgv
aW8uaD4KPj4gICAjaW5jbHVkZSA8bGludXgvbW0uaD4KPj4gICAjaW5jbHVkZSA8bGludXgvaHlw
ZXJ2Lmg+Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KPj4gQEAgLTQyLDYgKzQzLDMxIEBA
IHN0YXRpYyB2b2lkICpodl9oeXBlcmNhbGxfcGdfc2F2ZWQ7Cj4+ICAgc3RydWN0IGh2X3ZwX2Fz
c2lzdF9wYWdlICoqaHZfdnBfYXNzaXN0X3BhZ2U7Cj4+ICAgRVhQT1JUX1NZTUJPTF9HUEwoaHZf
dnBfYXNzaXN0X3BhZ2UpOwo+Pgo+PiArc3RhdGljIGludCBoeXBlcnZfaW5pdF9naGNiKHZvaWQp
Cj4+ICt7Cj4+ICsJdTY0IGdoY2JfZ3BhOwo+PiArCXZvaWQgKmdoY2JfdmE7Cj4+ICsJdm9pZCAq
KmdoY2JfYmFzZTsKPj4gKwo+PiArCWlmICghbXNfaHlwZXJ2LmdoY2JfYmFzZSkKPj4gKwkJcmV0
dXJuIC1FSU5WQUw7Cj4+ICsKPj4gKwkvKgo+PiArCSAqIEdIQ0IgcGFnZSBpcyBhbGxvY2F0ZWQg
YnkgcGFyYXZpc29yLiBUaGUgYWRkcmVzcwo+PiArCSAqIHJldHVybmVkIGJ5IE1TUl9BTUQ2NF9T
RVZfRVNfR0hDQiBpcyBhYm92ZSBzaGFyZWQKPj4gKwkgKiBnaGNiIGJvdW5kYXJ5IGFuZCBtYXAg
aXQgaGVyZS4KPj4gKwkgKi8KPj4gKwlyZG1zcmwoTVNSX0FNRDY0X1NFVl9FU19HSENCLCBnaGNi
X2dwYSk7Cj4+ICsJZ2hjYl92YSA9IG1lbXJlbWFwKGdoY2JfZ3BhLCBIVl9IWVBfUEFHRV9TSVpF
LCBNRU1SRU1BUF9XQik7Cj4+ICsJaWYgKCFnaGNiX3ZhKQo+PiArCQlyZXR1cm4gLUVOT01FTTsK
Pj4gKwo+PiArCWdoY2JfYmFzZSA9ICh2b2lkICoqKXRoaXNfY3B1X3B0cihtc19oeXBlcnYuZ2hj
Yl9iYXNlKTsKPj4gKwkqZ2hjYl9iYXNlID0gZ2hjYl92YTsKPj4gKwo+PiArCXJldHVybiAwOwo+
PiArfQo+PiArCj4+ICAgc3RhdGljIGludCBodl9jcHVfaW5pdCh1bnNpZ25lZCBpbnQgY3B1KQo+
PiAgIHsKPj4gICAJdW5pb24gaHZfdnBfYXNzaXN0X21zcl9jb250ZW50cyBtc3IgPSB7IDAgfTsK
Pj4gQEAgLTg1LDYgKzExMSw4IEBAIHN0YXRpYyBpbnQgaHZfY3B1X2luaXQodW5zaWduZWQgaW50
IGNwdSkKPj4gICAJCX0KPj4gICAJfQo+Pgo+PiArCWh5cGVydl9pbml0X2doY2IoKTsKPj4gKwo+
PiAgIAlyZXR1cm4gMDsKPj4gICB9Cj4+Cj4+IEBAIC0xNzcsNiArMjA1LDE0IEBAIHN0YXRpYyBp
bnQgaHZfY3B1X2RpZSh1bnNpZ25lZCBpbnQgY3B1KQo+PiAgIHsKPj4gICAJc3RydWN0IGh2X3Jl
ZW5saWdodGVubWVudF9jb250cm9sIHJlX2N0cmw7Cj4+ICAgCXVuc2lnbmVkIGludCBuZXdfY3B1
Owo+PiArCXZvaWQgKipnaGNiX3ZhID0gTlVMTDsKPiAKPiBJJ20gbm90IHNlZWluZyBhbnkgcmVh
c29uIHdoeSB0aGlzIG5lZWRzIHRvIGJlIGluaXRpYWxpemVkLgo+IAo+PiArCj4+ICsJaWYgKG1z
X2h5cGVydi5naGNiX2Jhc2UpIHsKPj4gKwkJZ2hjYl92YSA9ICh2b2lkICoqKXRoaXNfY3B1X3B0
cihtc19oeXBlcnYuZ2hjYl9iYXNlKTsKPj4gKwkJaWYgKCpnaGNiX3ZhKQo+PiArCQkJbWVtdW5t
YXAoKmdoY2JfdmEpOwo+PiArCQkqZ2hjYl92YSA9IE5VTEw7Cj4+ICsJfQo+Pgo+PiAgIAlodl9j
b21tb25fY3B1X2RpZShjcHUpOwo+Pgo+PiBAQCAtMzgzLDkgKzQxOSwxOSBAQCB2b2lkIF9faW5p
dCBoeXBlcnZfaW5pdCh2b2lkKQo+PiAgIAkJCVZNQUxMT0NfRU5ELCBHRlBfS0VSTkVMLCBQQUdF
X0tFUk5FTF9ST1gsCj4+ICAgCQkJVk1fRkxVU0hfUkVTRVRfUEVSTVMsIE5VTUFfTk9fTk9ERSwK
Pj4gICAJCQlfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MoMCkpOwo+PiAtCWlmIChodl9oeXBlcmNh
bGxfcGcgPT0gTlVMTCkgewo+PiAtCQl3cm1zcmwoSFZfWDY0X01TUl9HVUVTVF9PU19JRCwgMCk7
Cj4+IC0JCWdvdG8gcmVtb3ZlX2NwdWhwX3N0YXRlOwo+PiArCWlmIChodl9oeXBlcmNhbGxfcGcg
PT0gTlVMTCkKPj4gKwkJZ290byBjbGVhbl9ndWVzdF9vc19pZDsKPj4gKwo+PiArCWlmIChodl9p
c29sYXRpb25fdHlwZV9zbnAoKSkgewo+PiArCQltc19oeXBlcnYuZ2hjYl9iYXNlID0gYWxsb2Nf
cGVyY3B1KHZvaWQgKik7Cj4+ICsJCWlmICghbXNfaHlwZXJ2LmdoY2JfYmFzZSkKPj4gKwkJCWdv
dG8gY2xlYW5fZ3Vlc3Rfb3NfaWQ7Cj4+ICsKPj4gKwkJaWYgKGh5cGVydl9pbml0X2doY2IoKSkg
ewo+PiArCQkJZnJlZV9wZXJjcHUobXNfaHlwZXJ2LmdoY2JfYmFzZSk7Cj4+ICsJCQltc19oeXBl
cnYuZ2hjYl9iYXNlID0gTlVMTDsKPj4gKwkJCWdvdG8gY2xlYW5fZ3Vlc3Rfb3NfaWQ7Cj4+ICsJ
CX0KPiAKPiBIYXZpbmcgdGhlIEdIQ0Igc2V0dXAgY29kZSBoZXJlIHNwbGl0cyB0aGUgaHlwZXJj
YWxsIHBhZ2Ugc2V0dXAgaW50bwo+IHR3byBwYXJ0cywgd2hpY2ggaXMgdW5leHBlY3RlZC4gIEZp
cnN0IHRoZSBtZW1vcnkgaXMgYWxsb2NhdGVkCj4gZm9yIHRoZSBoeXBlcmNhbGwgcGFnZSwgdGhl
biB0aGUgR0hDQiBzdHVmZiBpcyBkb25lLCB0aGVuIHRoZSBoeXBlcmNhbGwKPiBNU1IgaXMgc2V0
dXAuICBJcyB0aGVyZSBhIG5lZWQgdG8gZG8gdGhpcyBzcGxpdD8gIEFsc28sIGlmIHRoZSBHSENC
IHN0dWZmCj4gZmFpbHMgYW5kIHlvdSBnb3RvIGNsZWFuX2d1ZXN0X29zX2lkLCB0aGUgbWVtb3J5
IGFsbG9jYXRlZCBmb3IgdGhlCj4gaHlwZXJjYWxsIHBhZ2UgaXMgbmV2ZXIgZnJlZWQuCgoKSnVz
dCBub3QgZW5hYmxlIGh5cGVyY2FsbCB3aGVuIGZhaWxzIHRvIHNldHVwIGdoY2IuIE90aGVyd2lz
ZSwgd2UgbmVlZCAKdG8gZGlzYWJsZSBoeXBlcmNhbGwgaW4gdGhlIGZhaWx1cmUgY29kZSBwYXRo
LgoKWWVz77yMaHlwZXJjYWxsIHBhZ2Ugc2hvdWxkIGJlIGZyZWVkIGluIHRoZSBjbGVhbl9ndWVz
dF9vc19pZCBwYXRoLgoKPiAKPiBJdCdzIGFsc28gdW5leHBlY3RlZCB0byBoYXZlIGh5cGVydl9p
bml0X2doY2IoKSBjYWxsZWQgaGVyZSBhbmQgY2FsbGVkCj4gaW4gaHZfY3B1X2luaXQoKS4gIFdv
dWxkbid0IGl0IGJlIHBvc3NpYmxlIHRvIHNldHVwIGdoY2JfYmFzZSAqYmVmb3JlKgo+IGNwdV9z
ZXR1cF9zdGF0ZSgpIGlzIGNhbGxlZCwgc28gdGhhdCBodl9jcHVfaW5pdCgpIHdvdWxkIHRha2Ug
Y2FyZSBvZgo+IGNhbGxpbmcgaHlwZXJ2X2luaXRfZ2hjYigpIGZvciB0aGUgYm9vdCBDUFU/ICBU
aGF0J3MgdGhlIHBhdHRlcm4gdXNlZAo+IGJ5IHRoZSBWUCBhc3Npc3QgcGFnZSwgdGhlIHBlcmNw
dSBpbnB1dCBwYWdlLCBldGMuCgpJIHdpbGwgaGF2ZSBhIHRyeSBhbmQgcmVwb3J0IGJhY2suIFRo
YW5rcyBmb3Igc3VnZ2VzdGlvbi4KCj4gCj4+ICAgCX0KPj4KPj4gICAJcmRtc3JsKEhWX1g2NF9N
U1JfSFlQRVJDQUxMLCBoeXBlcmNhbGxfbXNyLmFzX3VpbnQ2NCk7Cj4+IEBAIC00NTYsNyArNTAy
LDggQEAgdm9pZCBfX2luaXQgaHlwZXJ2X2luaXQodm9pZCkKPj4gICAJaHZfcXVlcnlfZXh0X2Nh
cCgwKTsKPj4gICAJcmV0dXJuOwo+Pgo+PiAtcmVtb3ZlX2NwdWhwX3N0YXRlOgo+PiArY2xlYW5f
Z3Vlc3Rfb3NfaWQ6Cj4+ICsJd3Jtc3JsKEhWX1g2NF9NU1JfR1VFU1RfT1NfSUQsIDApOwo+PiAg
IAljcHVocF9yZW1vdmVfc3RhdGUoY3B1aHApOwo+PiAgIGZyZWVfdnBfYXNzaXN0X3BhZ2U6Cj4+
ICAgCWtmcmVlKGh2X3ZwX2Fzc2lzdF9wYWdlKTsKPj4gQEAgLTQ4NCw2ICs1MzEsOSBAQCB2b2lk
IGh5cGVydl9jbGVhbnVwKHZvaWQpCj4+ICAgCSAqLwo+PiAgIAlodl9oeXBlcmNhbGxfcGcgPSBO
VUxMOwo+Pgo+PiArCWlmIChtc19oeXBlcnYuZ2hjYl9iYXNlKQo+PiArCQlmcmVlX3BlcmNwdSht
c19oeXBlcnYuZ2hjYl9iYXNlKTsKPj4gKwo+IAo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBjbGVhbnVw
IGlzIG5lY2Vzc2FyeS4gIFRoZSBwcmltYXJ5IHB1cnBvc2Ugb2YKPiBoeXBlcnZfY2xlYW51cCgp
IGlzIHRvIGVuc3VyZSB0aGF0IHRoaW5ncyBsaWtlIG92ZXJsYXkgcGFnZXMgYXJlCj4gcHJvcGVy
bHkgcmVzZXQgaW4gSHlwZXItViBiZWZvcmUgZG9pbmcgYSBrZXhlYygpLCBvciBiZWZvcmUKPiBw
YW5pYydpbmcgYW5kIHJ1bm5pbmcgdGhlIGtkdW1wIGtlcm5lbC4gIFRoZXJlJ3Mgbm8gbmVlZCB0
byBkbwo+IGdlbmVyYWwgbWVtb3J5IGZyZWUnaW5nIGluIExpbnV4LiAgRG9pbmcgc28ganVzdCBh
ZGRzIHRvIHRoZSByaXNrCj4gdGhhdCB0aGUgcGFuaWMgcGF0aCBjb3VsZCBpdHNlbGYgZmFpbC4K
Ck5pY2UgY2F0Y2guIEkgd2lsbCByZW1vdmUgdGhpcy4KCj4gCj4+ICAgCS8qIFJlc2V0IHRoZSBo
eXBlcmNhbGwgcGFnZSAqLwo+PiAgIAloeXBlcmNhbGxfbXNyLmFzX3VpbnQ2NCA9IDA7Cj4+ICAg
CXdybXNybChIVl9YNjRfTVNSX0hZUEVSQ0FMTCwgaHlwZXJjYWxsX21zci5hc191aW50NjQpOwo+
PiBAQCAtNTU5LDMgKzYwOSwxMSBAQCBib29sIGh2X2lzX2lzb2xhdGlvbl9zdXBwb3J0ZWQodm9p
ZCkKPj4gICB7Cj4+ICAgCXJldHVybiBodl9nZXRfaXNvbGF0aW9uX3R5cGUoKSAhPSBIVl9JU09M
QVRJT05fVFlQRV9OT05FOwo+PiAgIH0KPj4gKwo+PiArREVGSU5FX1NUQVRJQ19LRVlfRkFMU0Uo
aXNvbGF0aW9uX3R5cGVfc25wKTsKPj4gKwo+PiArYm9vbCBodl9pc29sYXRpb25fdHlwZV9zbnAo
dm9pZCkKPj4gK3sKPj4gKwlyZXR1cm4gc3RhdGljX2JyYW5jaF91bmxpa2VseSgmaXNvbGF0aW9u
X3R5cGVfc25wKTsKPj4gK30KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKGh2X2lzb2xhdGlvbl90eXBl
X3NucCk7Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaAo+PiBpbmRleCBhZGNjYmMyMDkxNjkuLjY2
MjdjZmQyYmZiYSAxMDA2NDQKPj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYu
aAo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oCj4+IEBAIC0xMSw2ICsx
MSw4IEBACj4+ICAgI2luY2x1ZGUgPGFzbS9wYXJhdmlydC5oPgo+PiAgICNpbmNsdWRlIDxhc20v
bXNoeXBlcnYuaD4KPj4KPj4gK0RFQ0xBUkVfU1RBVElDX0tFWV9GQUxTRShpc29sYXRpb25fdHlw
ZV9zbnApOwo+PiArCj4+ICAgdHlwZWRlZiBpbnQgKCpoeXBlcnZfZmlsbF9mbHVzaF9saXN0X2Z1
bmMpKAo+PiAgIAkJc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2hfbGlzdCAqZmx1c2gsCj4+
ICAgCQl2b2lkICpkYXRhKTsKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvbXNo
eXBlcnYuaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvbXNoeXBlcnYuaAo+PiBpbmRleCBjMWFiNmE2
ZTcyYjUuLjQyNjlmMzE3NGU1OCAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9t
c2h5cGVydi5oCj4+ICsrKyBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvbXNoeXBlcnYuaAo+PiBAQCAt
MzYsNiArMzYsNyBAQCBzdHJ1Y3QgbXNfaHlwZXJ2X2luZm8gewo+PiAgIAl1MzIgbWF4X2xwX2lu
ZGV4Owo+PiAgIAl1MzIgaXNvbGF0aW9uX2NvbmZpZ19hOwo+PiAgIAl1MzIgaXNvbGF0aW9uX2Nv
bmZpZ19iOwo+PiArCXZvaWQgIF9fcGVyY3B1ICoqZ2hjYl9iYXNlOwo+IAo+IFRoaXMgZG9lc24n
dCBmZWVsIGxpa2UgdGhlIHJpZ2h0IHBsYWNlIHRvIHB1dCB0aGlzIHBvaW50ZXIuICBUaGUgb3Ro
ZXIKPiBmaWVsZHMgaW4gdGhlIG1zX2h5cGVydl9pbmZvIHN0cnVjdHVyZSBhcmUganVzdCBmaXhl
ZCB2YWx1ZXMgb2J0YWluZWQKPiBmcm9tIHRoZSBDUFVJRCBpbnN0cnVjdGlvbi4gICBUaGUgZXhp
c3RpbmcgcGF0dGVybnMgc2ltaWxhciB0byBnaGNiX2Jhc2UKPiBhcmUgdGhlIFZQIGFzc2lzdCBw
YWdlIGFuZCB0aGUgcGVyY3B1IGlucHV0IGFuZCBvdXRwdXQgYXJncy4gIFRoZXkgYXJlCj4gYWxs
IGJhc2VkIG9uIHN0YW5kYWxvbmUgZ2xvYmFsIHZhcmlhYmxlcy4gIEl0IHdvdWxkIGJlIG1vcmUg
Y29uc2lzdGVudAo+IHRvIGRvIHRoZSBzYW1lIHdpdGggdGhlIGdoY2JfYmFzZS4KCk9LLiBJIHdp
bGwgdXBkYXRlIGluIHRoZSBuZXh0IHZlcnNpb24uCgo+IAo+PiAgIH07Cj4+ICAgZXh0ZXJuIHN0
cnVjdCBtc19oeXBlcnZfaW5mbyBtc19oeXBlcnY7Cj4+Cj4+IEBAIC0yMzcsNiArMjM4LDcgQEAg
Ym9vbCBodl9pc19oeXBlcnZfaW5pdGlhbGl6ZWQodm9pZCk7Cj4+ICAgYm9vbCBodl9pc19oaWJl
cm5hdGlvbl9zdXBwb3J0ZWQodm9pZCk7Cj4+ICAgZW51bSBodl9pc29sYXRpb25fdHlwZSBodl9n
ZXRfaXNvbGF0aW9uX3R5cGUodm9pZCk7Cj4+ICAgYm9vbCBodl9pc19pc29sYXRpb25fc3VwcG9y
dGVkKHZvaWQpOwo+PiArYm9vbCBodl9pc29sYXRpb25fdHlwZV9zbnAodm9pZCk7Cj4+ICAgdm9p
ZCBoeXBlcnZfY2xlYW51cCh2b2lkKTsKPj4gICBib29sIGh2X3F1ZXJ5X2V4dF9jYXAodTY0IGNh
cF9xdWVyeSk7Cj4+ICAgI2Vsc2UgLyogQ09ORklHX0hZUEVSViAqLwo+PiAtLQo+PiAyLjI1LjEK
PiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
