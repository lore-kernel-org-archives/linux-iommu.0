Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E368C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 15:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0A2C4025F;
	Mon, 21 Feb 2022 15:15:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pv--xRkyRDcQ; Mon, 21 Feb 2022 15:15:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CE86540270;
	Mon, 21 Feb 2022 15:15:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B24ECC001A;
	Mon, 21 Feb 2022 15:15:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81C5BC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7030D8131C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:15:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5J0TS-gdRHya for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:15:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0222808A1
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:15:07 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id g1so9152863pfv.1
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 07:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=rQjzrJUBJUG4lrXY3qHLoN254Z+Hvh/Va/Cpr5SArPA=;
 b=YB37ZflfT9ggqvpHpDLeP8hKKD9vSOva3ZaRBtd3tgoeYOYCGS/+oOCm9dvs5+8Wr3
 9m9VOC1yL/2ha0cc8D9+MLPdWVL5Y0UtghNB+2KfdcOAl7UfAZ8JSEDIDQBuBUpsSd05
 YfAu3GG7/z4rqLLCa7Ur4F0fYf79Ri2KUmBE/N+KsRRrqtnuzULfCX1i78dghi1zf+0V
 qqA4m2PtIrmFeaTmVPH+e1otxTv9qMz0z/PuOXXfneytP+fflzqJ+CmI32BrqCWU5OSE
 gO9FLaK9LU2vQkti/b7TlzQvzfLpeNUkv9G8DzVCo2XbOtXOO6yJyP7LVqqCye+nyFjk
 aOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=rQjzrJUBJUG4lrXY3qHLoN254Z+Hvh/Va/Cpr5SArPA=;
 b=7PWFWFvN4mL1EfMPGRGSeDEtAH9FuYUS7masResMbXIs6SqsscOTVritrLn//hZTkA
 Xe/KLveiw+1lA4XQifzjiaffKGGScbs4rH7JCxj4AX9lSRsxsc78B320QEhuiHDbs6yQ
 x1qZY0DuWLE7XaiAa1bXB2M10czBB2OY6NjsUcwpV9bmMjAvkk30hDRnHK629NCzz3Ni
 ZzEUZJONlvw2hbrll70eMowQ9UJQi0ykwj8BfMoJwY3ao+w0d2icDKRZq2RvFElUykai
 4JqXilhdgGcrcUgPMkoDg9m6scGsmuX5f/DNQLpERPLTCxqwfYLGu75Y5hweuzZubhM5
 xlDw==
X-Gm-Message-State: AOAM532G50D+pF0UZCuCBQAZPopbMfb0TvS/gg5SuYyszyKX8A4NOzjD
 2ctZQuLWQ2sDOY8ix1Q9Sh8=
X-Google-Smtp-Source: ABdhPJylmsV+h5d8jn8qiDmtwnHSxu0TXVS9IMCo+KFkNe8tAnqXy4KJ+vAfQkmA12bMTt5jor+fkw==
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id
 bj2-20020a056a02018200b003745a57cbf9mr2835424pgb.616.1645456506920; 
 Mon, 21 Feb 2022 07:15:06 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:1a:efea::754])
 by smtp.gmail.com with ESMTPSA id
 s2sm13819900pfk.3.2022.02.21.07.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 07:15:06 -0800 (PST)
Message-ID: <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
Date: Mon, 21 Feb 2022 23:14:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
From: Tianyu Lan <ltykernel@gmail.com>
To: Christoph Hellwig <hch@lst.de>
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
 <20220214135834.GA30150@lst.de>
 <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
In-Reply-To: <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 hch@infradead.org, wei.liu@kernel.org, sthemmin@microsoft.com, x86@kernel.org,
 decui@microsoft.com, michael.h.kelley@microsoft.com, mingo@redhat.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com
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

T24gMi8xNS8yMDIyIDExOjMyIFBNLCBUaWFueXUgTGFuIHdyb3RlOgo+IE9uIDIvMTQvMjAyMiA5
OjU4IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4gT24gTW9uLCBGZWIgMTQsIDIwMjIg
YXQgMDc6Mjg6NDBQTSArMDgwMCwgVGlhbnl1IExhbiB3cm90ZToKPj4+IE9uIDIvMTQvMjAyMiA0
OjE5IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+PiBBZGRpbmcgYSBmdW5jdGlvbiB0
byBzZXQgdGhlIGZsYWcgZG9lc24ndCByZWFsbHkgY2hhbmdlIG11Y2guwqAgQXMgUm9iaW4KPj4+
PiBwb2ludGVkIG91dCBsYXN0IHRpbWUgeW91IHNob3VsZCBmaW5lIGEgd2F5IHRvIGp1c3QgY2Fs
bAo+Pj4+IHN3aW90bGJfaW5pdF93aXRoX3RibCBkaXJlY3RseSB3aXRoIHRoZSBtZW1vcnkgYWxs
b2NhdGVkIHRoZSB3YXkgeW91Cj4+Pj4gbGlrZSBpdC7CoCBPciBnaXZlbiB0aGF0IHdlIGhhdmUg
cXVpdGUgYSBmZXcgb2YgdGhlc2UgdHJ1c3RlZCBoeXBlcnZpc29yCj4+Pj4gc2NoZW1lcyBtYXli
ZSBhZGQgYW4gYXJndW1lbnQgdG8gc3dpb3RsYl9pbml0IHRoYXQgc3BlY2lmaWVzIGhvdyB0bwo+
Pj4+IGFsbG9jYXRlIHRoZSBtZW1vcnkuCj4+Pgo+Pj4gVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rp
b24uIEkgd2lsbCB0cnkgdGhlIGZpcnN0IGFwcHJvYWNoIGZpcnN0IAo+Pj4gYXBwcm9hY2guCj4+
Cj4+IFRha2UgYSBsb29rIGF0IHRoZSBTV0lPVExCX0FOWSBmbGFnIGluIHRoaXMgV0lQIGJyYW5j
aDoKPj4KPj4gICAgIAo+PiBodHRwOi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL21pc2Mu
Z2l0L3Nob3J0bG9nL3JlZnMvaGVhZHMvc3dpb3RsYi1pbml0LWNsZWFudXAgCj4+Cj4+Cj4+IFRo
YXQgYmVpbmcgc2FpZCBJJ20gbm90IHN1cmUgdGhhdCBlaXRoZXIgdGhpcyBmbGFnIG9yIHRoZSBl
eGlzdGluZyAKPj4gcG93ZXJwYwo+PiBjb2RlIGnRlSBhY3R1YWxseSB0aGUgcmlnaHQgdGhpbmcg
dG8gZG8uwqAgV2Ugc3RpbGwgbmVlZCB0aGUgNEcgbGltaXRlZAo+PiBidWZmZXIgdG8gc3VwcG9y
dCBkZXZpY2VzIHdpdGggYWRkcmVzc2luZyBsaW1pdGF0aW9ucy7CoCBTbyBJIHRoaW5rIHdlIAo+
PiBuZWVkCj4+IGFuIGFkZGl0aW9uYWwgaW9fdGxiX21lbSBpbnN0YW5jZSBmb3IgdGhlIGRldmlj
ZXMgd2l0aG91dCBhZGRyZXNzaW5nCj4+IGxpbWl0YXRpb25zIGluc3RlYWQuCj4+Cj4gCj4gSGkg
Q2hyaXN0b3BoOgo+ICDCoMKgwqDCoCBUaGFua3MgZm9yIHlvdXIgcGF0Y2hlcy4gSSB0ZXN0ZWQg
dGhlc2UgcGF0Y2hlcyBpbiBIeXBlci1WIHRydXN0ZWQgCj4gVk0gYW5kIHN5c3RlbSBjYW4ndCBi
b290IHVwLiBJIGFtIGRlYnVnZ2luZyBhbmQgd2lsbCByZXBvcnQgYmFjay4KClNvcnJ5LiBUaGUg
Ym9vdCBmYWlsdXJlIGlzIG5vdCByZWxhdGVkIHdpdGggdGhlc2UgcGF0Y2hlcyBhbmQgdGhlIGlz
c3VlCmhhcyBiZWVuIGZpeGVkIGluIHRoZSBsYXRlc3QgdXBzdHJlYW0gY29kZS4KClRoZXJlIGlz
IGEgcGVyZm9ybWFuY2UgYm90dGxlbmVjayBkdWUgdG8gaW8gdGxiIG1lbSdzIHNwaW4gbG9jayBk
dXJpbmcKcGVyZm9ybWFuY2UgdGVzdC4gQWxsIGRldmljZXMnaW8gcXVldWVzIHVzZXMgc2FtZSBp
byB0bGIgbWVtIGVudHJ5CmFuZCB0aGUgc3BpbiBsb2NrIG9mIGlvIHRsYiBtZW0gaW50cm9kdWNl
IG92ZXJoZWFkcy4gVGhlcmUgaXMgYSBmaXggCnBhdGNoIGZyb20gQW5kaSBLbGVlbiBpbiB0aGUg
Z2l0aHViLiBDb3VsZCB5b3UgaGF2ZSBhIGxvb2s/CgpodHRwczovL2dpdGh1Yi5jb20vaW50ZWwv
dGR4L2NvbW1pdC80NTI5YjU3ODRjMTQxNzgyYzcyZWM5YmQ5YTkyZGYyYjY4Y2I3ZDQ1CgpUaGFu
a3MuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
