Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C84C47095
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 13:31:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FB661108
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 13:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FB661108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B9706075D;
	Mon,  7 Jun 2021 13:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BhETGF5O-VmW; Mon,  7 Jun 2021 13:31:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAAC7605E8;
	Mon,  7 Jun 2021 13:31:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B09E1C000E;
	Mon,  7 Jun 2021 13:31:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCE1CC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 13:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A41B382FE7
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 13:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mXsaoOqOS5Mx for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 13:31:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA00583004
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 13:30:58 +0000 (UTC)
Received: from [192.168.1.155] ([77.9.164.246]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDhth-1lg6BL1jZ1-00AmyS; Mon, 07 Jun 2021 15:30:24 +0200
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>, Jason Wang <jasowang@redhat.com>
References: <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
 <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
 <20210602172154.GC1002214@nvidia.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <51e060a3-fc59-0a13-5955-71692b14eed8@metux.net>
Date: Mon, 7 Jun 2021 15:30:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210602172154.GC1002214@nvidia.com>
Content-Language: tl
X-Provags-ID: V03:K1:0cHgvfvkcENeZcwWOdSnMY5OBsLQc+AHnAcYsiTQDwQzV8yGses
 BzhxD4cYyw748yK6N/P0nmJV8sW+l4B3uSreGFp/ZH44u5wZ7MaIBt0puYo9H6CTlkkSCpD
 r4aJTDd5BK/w2FdPrZ18SR5dS3R3LHVHU6xk7rIJbyOMOb5GKVOegP5pyC9SfzDF6IHFOit
 UCQz3Yv97nhVDnbAb1IQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0b78p2Fmx6c=:HhyzpkVQ7uJoDa9fEVb7F6
 xFsLe61+6cSl2oyH7zj5A4CrjvXvb7KOqKLmktH3ZbUW1fICP/UosO75+xU7E8hc5+pzc92VW
 LR/LjD80hvYUrCXbe017LZX/bfUnX4iZh/cSkhdx9zvaD9B4wT5uCKFiRN+/Wav2yCLrJvjsL
 cjOZ2hVolWapI/aaKjqSAv9n/VM644SA5c1DfW4pfDVDo9++KvqChAyaSubd+mkw1E7zGgk40
 bfww55mSUZo3QJLPzISQt8UMxjUVnI0+ag/zrptFmAUE1VzXaU21p2vQ1INWR7/mBGuTCmXRI
 zqtvzllXx6M57EsJbqrHzgQywOI2yoFgXEr8y7NLkFdoqVl3Hfq2u0DP3nzTLoHMufwoCj4jc
 vOzRhqKSiix+6zsxGDwISIp38M8erlQsz4YzoFJcWSS2FBSTbyJGUSU1C0Xi0yjMjCV2aBQH4
 e9JA8vdQoGpUfNiaEYe89HFY9isMuEvE4jzZzwHxxJcM8TOdD6nJ4VTt11FTqxA6vE11NAxW+
 FyX744HLunXQ18m0eR0ZMw=
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

T24gMDIuMDYuMjEgMTk6MjEsIEphc29uIEd1bnRob3JwZSB3cm90ZToKCkhpLAoKPiBOb3QgcmVh
bGx5LCBvbmNlIG9uZSB0aGluZyBpbiBhbiBhcHBsaWNhdGUgdXNlcyBhIGxhcmdlIG51bWJlciBG
RHMgdGhlCj4gZW50aXJlIGFwcGxpY2F0aW9uIGlzIGVmZmVjdGVkLiBJZiBhbnkgb3BlbigpIGNh
biByZXR1cm4gJ3ZlcnkgYmlnCj4gbnVtYmVyJyB0aGVuIG5vdGhpbmcgaW4gdGhlIHByb2Nlc3Mg
aXMgYWxsb3dlZCB0byBldmVyIHVzZSBzZWxlY3QuCgppc24ndCB0aGF0IGEgYnVnIGluIHNlbGVj
dCgpID8KCi0tbXR4CgotLSAKLS0tCkhpbndlaXM6IHVudmVyc2NobMO8c3NlbHRlIEUtTWFpbHMg
a8O2bm5lbiBsZWljaHQgYWJnZWjDtnJ0IHVuZCBtYW5pcHVsaWVydAp3ZXJkZW4gISBGw7xyIGVp
bmUgdmVydHJhdWxpY2hlIEtvbW11bmlrYXRpb24gc2VuZGVuIFNpZSBiaXR0ZSBpaHJlbgpHUEcv
UEdQLVNjaGzDvHNzZWwgenUuCi0tLQpFbnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3VsdApG
cmVlIHNvZnR3YXJlIGFuZCBMaW51eCBlbWJlZGRlZCBlbmdpbmVlcmluZwppbmZvQG1ldHV4Lm5l
dCAtLSArNDktMTUxLTI3NTY1Mjg3Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
