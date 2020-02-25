Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DBC35DF9
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 08:37:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDFF20CC7
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 08:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCYfGreF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDFF20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4CB96864D4;
	Tue, 25 Feb 2020 08:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jtMo4bv7-GlC; Tue, 25 Feb 2020 08:37:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0FD2B84BE7;
	Tue, 25 Feb 2020 08:37:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D155EC089F;
	Tue, 25 Feb 2020 08:37:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9844C0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 08:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C25CF8643F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 08:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1KYt1ikvpW13 for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 08:37:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 511FF84BE7
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 08:37:20 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id k29so6775216pfp.13
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=lesurzoUvSvfZ2EeEsmnXSXZFaFQRXcHJcV4OzRZYOs=;
 b=DCYfGreFPdhhVUKXFmeqvJ7SEwhie4HjOFGZRNvYH5SHGiV2hNKnZM5LLgrSEwuNK7
 ETetaQ1oMfVmaw3i9vzZIH/dJHU/aNeO2l1wNQw3Jk0AI7ENyeR5T7UPFpZ78lCsi/mv
 kgwfnufCzk/jHU/WRhl1aJXX8MoSfanEuNzEWfq6le+2X32btUn47Uln8Dc0XD0ZbgEJ
 RBVbcCdYViUIjt0SAfo8x3VSPfsgeOQzZ3YlESmTJ0yAIE2HbOtkc5SEViXCsGYjH40X
 Zniy5FQ2dnfIFvKYiV9vPy5iyjHXhmpX6OMC/q3DWm0AjGtMNhDEpxP9Nu4SWi6NCbn2
 1IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lesurzoUvSvfZ2EeEsmnXSXZFaFQRXcHJcV4OzRZYOs=;
 b=BPQiVrZcCHVx47OAa+FXVS7+dJpuj3lSq75aN0HKN8EKNH0ksnA+DrpyAixOFUYJ3p
 /lrbn2AqbQypKFRtsHUKVmsIPCfZVDFZQUZx1TmZvCmHbkmE9LsLn/5TFm0ftHK46h2V
 LzIT3lZ9J4XY9wjnZCXIr9V9UZXLImUUdIkjbivBzRX0swCL308slljlq1CT+Dk5nonr
 5b8E456f7PruZcC86kistHyK568FzNs1qLJVbPVZFtiyguMr21xED41juwcZzAO8qIsS
 k2vlZaglJVYilhmRJRTS44GktqCmfd0MBa/2XlklQBbdQ5BiBmrlBu0GVkGBdxC/RrX1
 Fw8g==
X-Gm-Message-State: APjAAAWCgbd+6bV43mW8UoqzDh9gIrxwVBBc6COAhWOBAeeH488O0hDO
 AB0IHUZ3ta5g/kyWRGieYtK5Hg==
X-Google-Smtp-Source: APXvYqxEIXMkJNt5ttW3aixCV0507Pt6cLR5KGoDAfoWs6jkQMH5M+MdAxhMB11LIwT8PXIuxrhNDA==
X-Received: by 2002:a63:f70e:: with SMTP id x14mr55230760pgh.71.1582619839849; 
 Tue, 25 Feb 2020 00:37:19 -0800 (PST)
Received: from ?IPv6:240e:362:421:7f00:524:e1bd:8061:a346?
 ([240e:362:421:7f00:524:e1bd:8061:a346])
 by smtp.gmail.com with ESMTPSA id c26sm16217660pfj.8.2020.02.25.00.36.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 00:37:19 -0800 (PST)
Subject: Re: [PATCH v12 2/4] uacce: add uacce driver
To: "Raj, Ashok" <ashok.raj@linux.intel.com>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
 <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
 <20200224182201.GA22668@araj-mobl1.jf.intel.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <81c5a532-468c-3316-83d2-b4fa027dbe0e@linaro.org>
Date: Tue, 25 Feb 2020 16:36:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200224182201.GA22668@araj-mobl1.jf.intel.com>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 Ashok Raj <ashok.raj@intel.com>, Kenneth Lee <liguozhu@hisilicon.com>,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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

SGksIFJhagoKT24gMjAyMC8yLzI1IOS4iuWNiDI6MjIsIFJhaiwgQXNob2sgd3JvdGU6Cj4gSGkg
S2VubmV0aCwKPgo+IHNvcnJ5IGZvciB3YWtpbmcgdXAgbGF0ZSBvbiB0aGlzIHBhdGNoc2V0Lgo+
Cj4gKwo+ICtzdGF0aWMgaW50IHVhY2NlX2ZvcHNfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBz
dHJ1Y3QgZmlsZSAqZmlsZXApCj4gK3sKPiArCXN0cnVjdCB1YWNjZV9tbSAqdWFjY2VfbW0gPSBO
VUxMOwo+ICsJc3RydWN0IHVhY2NlX2RldmljZSAqdWFjY2U7Cj4gKwlzdHJ1Y3QgdWFjY2VfcXVl
dWUgKnE7Cj4gKwlpbnQgcmV0ID0gMDsKPiArCj4gKwl1YWNjZSA9IHhhX2xvYWQoJnVhY2NlX3hh
LCBpbWlub3IoaW5vZGUpKTsKPiArCWlmICghdWFjY2UpCj4gKwkJcmV0dXJuIC1FTk9ERVY7Cj4g
Kwo+ICsJcSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCB1YWNjZV9xdWV1ZSksIEdGUF9LRVJORUwp
Owo+ICsJaWYgKCFxKQo+ICsJCXJldHVybiAtRU5PTUVNOwo+ICsKPiArCW11dGV4X2xvY2soJnVh
Y2NlLT5tbV9sb2NrKTsKPiArCXVhY2NlX21tID0gdWFjY2VfbW1fZ2V0KHVhY2NlLCBxLCBjdXJy
ZW50LT5tbSk7Cj4gSSB0aGluayBoYXZpbmcgdGhpcyBhdCBvcGVuIHRpbWUgaXMgYSBiaXQgdW5u
YXR1cmFsLiBTaW5jZSB3aGVuIGEgcHJvY2Vzcwo+IGRvZXMgZm9yaywgd2UgZG8gbm90IGluaGVy
aXQgdGhlIFBBU0lELiBBbHRob3VnaCBpdCBpbmhlcml0cyB0aGUgZmQKPiBidXQgY2Fubm90IHVz
ZSB0aGUgbW1hcGVkIGFkZHJlc3MgaW4gdGhlIGNoaWxkLgo+Cj4gSWYgeW91IG1vdmUgdGhpcyB0
byB0aGUgbW1hcCB0aW1lLCBpdHMgbW9yZSBuYXR1cmFsLiBUaGUgY2hpbGQgY291bGQKPiBkbyBh
IG1tYXAoKSBnZXQgYSBuZXcgUEFTSUQgKyBtbWlvIHNwYWNlIHRvIHdvcmsgd2l0aCB0aGUgaGFy
ZHdhcmUuCj4KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4KV2Ugd2lsbCBjb25zaWRlciBmb3Jr
IGluIHRoZSBuZXh0IHN0ZXAsIG1heSBuZWVkIHNvbWUgdGltZS4KClRoYW5rcwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
