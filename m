Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4884DC433E2
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 15:51:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8FA206B8
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 15:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="Hnu0TMoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8FA206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 24E5987353;
	Sat,  5 Sep 2020 15:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OgNsZ03aq5NN; Sat,  5 Sep 2020 15:51:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 37F8A87152;
	Sat,  5 Sep 2020 15:51:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BD1AC088B;
	Sat,  5 Sep 2020 15:51:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0F39C0052
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 15:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A6CB986A46
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 15:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0F5S4DmnKY85 for <iommu@lists.linux-foundation.org>;
 Sat,  5 Sep 2020 15:51:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1A3E186A3C
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 15:51:27 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id t76so9534393oif.7
 for <iommu@lists.linux-foundation.org>; Sat, 05 Sep 2020 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0zomv6SLpBCgRUcNigIvJpvA8Tydvp1pLbt33s7KfSg=;
 b=Hnu0TMoiEodwJYjQuYaWa1t2E+EpttYP4C490ikFzotrHDz6qAJBxTSBFrzBM9ZWFV
 rlJOySqH7G7hN7IYcBZDSQ4IoOZTMhy0m+8VIsKIQ4QSWRRgbMZIsztMcCzfk9DmFbHy
 8Dg6Yc+q3/o3SRY7/RIUOoW5mKjeMe35qCXWfrslnb1fCi13pdd3EM37UFUuQfHGAltL
 keQHRRBWLicT0pLW5vtR+CKe7sn2VXWnPG++EEi0qVq2QmkQoEcwLwSUFOaBBUPQ4Uc3
 qmRxoht8EFp8lgseX12iqurjQfGvOi3uikHIwDwOe8MOCLrXdhZo/XYFicKrYcN01vbM
 XPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0zomv6SLpBCgRUcNigIvJpvA8Tydvp1pLbt33s7KfSg=;
 b=PLbCYC81YPnxVzT9OymTij4OKI6/THVFhNUkNaGHh6jZ9nDFdYvS/BqDlvLp9aeNQd
 R7+pG/VQCwBxN+lmxxgFkF85CVfT/c8J8sfQlfs2THQSTMNnjrSV8hFNnmvSQa7/Ky6H
 OLmxMDUj9o9jP9pPP+OaNFnuD8/j6vyweNGEYLkeHcToOB6KzQ/6806+jwivAsyWgQm4
 dI5VYilvTNWBFC/Kg5ix07xuRtAFOt8uCrOcdceUtyJIhN9kZmdKneIG8/Hpgq4pZD3l
 TlDI5m1VWsMgbUWHiY4l3Be1ttDSrF1KgKUDeAAxSz3GeyGwzAyBrz006ecmsV2U2bcj
 F7Rg==
X-Gm-Message-State: AOAM531D1JeTXkChRZ4EaHTgkRlmNGfVUalLNvUc3CKTWRxJcIilV8WL
 0XrakVPQy7aJ84houIUcu2YPGhW11GL4XJpE
X-Google-Smtp-Source: ABdhPJy2DO7Qwem10G6tlX9grnI3fcQoduoCr4ZB3PxiacIYR680sRJ0i6xLUCnOjlQ7wVZiNvvTjg==
X-Received: by 2002:a17:90a:f117:: with SMTP id
 cc23mr12744737pjb.155.1599320729072; 
 Sat, 05 Sep 2020 08:45:29 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au.
 [124.171.83.152])
 by smtp.gmail.com with ESMTPSA id c22sm1900861pgb.52.2020.09.05.08.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 08:45:27 -0700 (PDT)
Subject: Re: [PATCH 5/5] powerpc: use the generic dma_ops_bypass mode
To: Christoph Hellwig <hch@lst.de>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <20200708152449.316476-1-hch@lst.de>
 <20200708152449.316476-6-hch@lst.de>
 <505bcc1d-01a7-9655-88e1-ebddd0b94d56@kaod.org>
 <20200831064038.GB27617@lst.de>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <48e38110-2a8f-1701-2e30-06fb07bbfffe@ozlabs.ru>
Date: Sun, 6 Sep 2020 01:45:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831064038.GB27617@lst.de>
Content-Language: en-US
Cc: linuxppc-dev@lists.ozlabs.org, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <brouer@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Oliver O'Halloran <oohall@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, aacraid@microsemi.com,
 Robin Murphy <robin.murphy@arm.com>
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

CgpPbiAzMS8wOC8yMDIwIDE2OjQwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBTdW4s
IEF1ZyAzMCwgMjAyMCBhdCAxMTowNDoyMUFNICswMjAwLCBDw6lkcmljIExlIEdvYXRlciB3cm90
ZToKPj4gSGVsbG8sCj4+Cj4+IE9uIDcvOC8yMCA1OjI0IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3
cm90ZToKPj4+IFVzZSB0aGUgRE1BIEFQSSBieXBhc3MgbWVjaGFuaXNtIGZvciBkaXJlY3Qgd2lu
ZG93IG1hcHBpbmdzLiAgVGhpcyB1c2VzCj4+PiBjb21tb24gY29kZSBhbmQgc3BlZWQgdXAgdGhl
IGRpcmVjdCBtYXBwaW5nIGNhc2UgYnkgYXZvaWRpbmcgaW5kaXJlY3QKPj4+IGNhbGxzIGp1c3Qg
d2hlbiBub3QgdXNpbmcgZG1hIG9wcyBhdCBhbGwuICBJdCBhbHNvIGZpeGVzIGEgcHJvYmxlbSB3
aGVyZQo+Pj4gdGhlIHN5bmNfKiBtZXRob2RzIHdlcmUgdXNpbmcgdGhlIGJ5cGFzcyBjaGVjayBm
b3IgRE1BIGFsbG9jYXRpb25zLCBidXQKPj4+IHRob3NlIGFyZSBwYXJ0IG9mIHRoZSBzdHJlYW1p
bmcgb3BzLgo+Pj4KPj4+IE5vdGUgdGhhdCB0aGlzIHBhdGNoIGxvc2VzIHRoZSBETUFfQVRUUl9X
RUFLX09SREVSSU5HIG92ZXJyaWRlLCB3aGljaAo+Pj4gaGFzIG5ldmVyIGJlZW4gd2VsbCBkZWZp
bmVkLCBhcyBpcyBvbmx5IHVzZWQgYnkgYSBmZXcgZHJpdmVycywgd2hpY2gKPj4+IElJUkMgbmV2
ZXIgc2hvd2VkIHVwIGluIHRoZSB0eXBpY2FsIENlbGwgYmxhZGUgc2V0dXBzIHRoYXQgYXJlIGFm
ZmVjdGVkCj4+PiBieSB0aGUgb3JkZXJpbmcgd29ya2Fyb3VuZC4KPj4+Cj4+PiBGaXhlczogZWZk
MTc2YTA0YmVmICgicG93ZXJwYy9wc2VyaWVzL2RtYTogQWxsb3cgU1dJT1RMQiIpCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPj4+IC0tLQo+Pj4gICBh
cmNoL3Bvd2VycGMvS2NvbmZpZyAgICAgICAgICAgICAgfCAgMSArCj4+PiAgIGFyY2gvcG93ZXJw
Yy9pbmNsdWRlL2FzbS9kZXZpY2UuaCB8ICA1IC0tCj4+PiAgIGFyY2gvcG93ZXJwYy9rZXJuZWwv
ZG1hLWlvbW11LmMgICB8IDkwICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA4NiBkZWxldGlvbnMoLSkKPj4KPj4g
SSBhbSBzZWVpbmcgY29ycnVwdGlvbnMgb24gYSBjb3VwbGUgb2YgUE9XRVI5IHN5c3RlbXMgKGJv
c3Rvbikgd2hlbgo+PiBzdHJlc3NlZCB3aXRoIElPLiBzdHJlc3MtbmcgZ2l2ZXMgc29tZSByZXN1
bHRzIGJ1dCBJIGhhdmUgZmlyc3Qgc2Vlbgo+PiBpdCB3aGVuIGNvbXBpbGluZyB0aGUga2VybmVs
IGluIGEgZ3Vlc3QgYW5kIHRoaXMgaXMgc3RpbGwgdGhlIGJlc3Qgd2F5Cj4+IHRvIHJhaXNlIHRo
ZSBpc3N1ZS4KPj4KPj4gVGhlc2Ugc3lzdGVtcyBoYXZlIG9mIGEgU0FTIEFkYXB0ZWMgY29udHJv
bGxlciA6Cj4+Cj4+ICAgIDAwMDM6MDE6MDAuMCBTZXJpYWwgQXR0YWNoZWQgU0NTSSBjb250cm9s
bGVyOiBBZGFwdGVjIFNlcmllcyA4IDEyRyBTQVMvUENJZSAzIChyZXYgMDEpCj4+Cj4+IFdoZW4g
dGhlIGZhaWx1cmUgb2NjdXJzLCB0aGUgUE9XRVJQQyBFRUggaW50ZXJydXB0IGZpcmVzIGFuZCBk
dW1wcwo+PiBsb3dsZXZlbCBQSEI0IHJlZ2lzdGVycyBhbW9uZyB3aGljaCA6Cj4+IAkJCQkJCj4+
ICAgIFsgMjE3OS4yNTEwNjk0OTAsM10gUEhCIzAwMDNbMDozXTogICAgICAgICAgIHBoYkVycm9y
U3RhdHVzID0gMDAwMDAyODAwMDAwMDAwMAo+PiAgICBbIDIxNzkuMjUxMTE3NDc2LDNdIFBIQiMw
MDAzWzA6M106ICAgICAgcGhiRmlyc3RFcnJvclN0YXR1cyA9IDAwMDAwMjAwMDAwMDAwMDAKPj4K
Pj4gVGhlIGJpdHMgcmFpc2VkIGlkZW50aWZ5IGEgUFBDICdUQ0UnIGVycm9yLCB3aGljaCBtZWFu
cyBpdCBpcyByZWxhdGVkCj4+IHRvIERNQXMuIFNlZSBiZWxvdyBmb3IgbW9yZSBkZXRhaWxzLgo+
Pgo+Pgo+PiBSZXZlcnRpbmcgdGhpcyBwYXRjaCAiZml4ZXMiIHRoZSBpc3N1ZSBidXQgaXQgaXMg
cHJvYmFibHkgZWxzZSB3aGVyZSwKPj4gaW4gc29tZSBvdGhlciBsYXllcnMgb3IgaW4gdGhlIGFh
Y3JhaWQgZHJpdmVyLiBIb3cgc2hvdWxkIEkgcHJvY2VlZAo+PiB0byBnZXQgbW9yZSBpbmZvcm1h
dGlvbiA/Cj4gCj4gVGhlIGFhY3JhaWQgRE1BIG1hc2tzIGxvb2sgbGlrZSBhIG1lc3MuCgoKSXQg
a2luZHMgZG9lcyBhbmQgaXMuIFRoZSB0aGluZyBpcyB0aGF0IGFmdGVyIGYxNTY1YzI0YjU5NiB0
aGUgZHJpdmVyIApzZXRzIDMyIGJpdCBETUEgbWFzayB3aGljaCBpbiB0dXJuIGVuYWJsZXMgdGhl
IHNtYWxsIERNQSB3aW5kb3cgKG5vdCAKYnlwYXNzKSBhbmQgc2luY2UgdGhlIGFhY3JhaWQgZHJp
dmVyIGhhcyBhdCBsZWFzdCBvbmUgYnVnIHdpdGggZG91YmxlIAp1bm1hcCBvZiB0aGUgc2FtZSBE
TUEgaGFuZGxlLCB0aGlzIHNvbWVob3cgbGVhZHMgdG8gRUVIIChQQ0kgRE1BIGVycm9yKS4KCgpU
aGUgZHJpdmVyIHNldHMgMzJidXQgbWFzayBiZWNhdXNlIGl0IGNhbGxpcyBkbWFfZ2V0X3JlcXVp
cmVkX21hc2soKSAKX2JlZm9yZV8gc2V0dGluZyB0aGUgbWFzayBzbyBkbWFfZ2V0X3JlcXVpcmVk
X21hc2soKSBkb2VzIG5vdCBnbyB0aGUgCmRtYV9hbGxvY19kaXJlY3QoKSBwYXRoIGFuZCBjYWxs
cyB0aGUgcG93ZXJwYydzIApkbWFfaW9tbXVfZ2V0X3JlcXVpcmVkX21hc2soKSB3aGljaDoKCjEu
IGRvZXMgdGhlIG1hdGggbGlrZSB0aGlzIChzcG90IDIgYnVncyk6CgptYXNrID0gMVVMTCA8IChm
bHNfbG9uZyh0YmwtPml0X29mZnNldCArIHRibC0+aXRfc2l6ZSkgLSAxKQoKMi4gYnV0IGV2ZW4g
YWZ0ZXIgZml4aW5nIHRoYXQsIHRoZSBkcml2ZXIgY3Jhc2hlcyBhcyBmMTU2NWMyNGI1OTYgCnJl
bW92ZWQgdGhlIGNhbGwgdG8gZG1hX2lvbW11X2J5cGFzc19zdXBwb3J0ZWQoKSBzbyBpdCBlbmZv
cmNlcyBJT01NVS4KCgpUaGUgcGF0Y2ggYmVsb3cgKHRoZSBmaXJzdCBodW5rIHRvIGJlIHByZWNp
c2UpIGJyaW5ncyB0aGUgdGhpbmdzIGJhY2sgdG8gCndoZXJlIHRoZXkgd2VyZSAoNjRiaXQgbWFz
aykuIFRoZSBkb3VibGUgdW5tYXAgYnVnIGluIHRoZSBkcml2ZXIgaXMgCnN0aWxsIHRvIGJlIGlu
dmVzdGlnYXRlZC4KCgoKZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvZG1hLWlvbW11
LmMgCmIvYXJjaC9wb3dlcnBjL2tlcm5lbC9kbWEtaW9tbXUuYwppbmRleCA1NjlmZWNkN2I1YjIu
Ljc4NWFiY2NiOTBmYyAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9kbWEtaW9tbXUu
YworKysgYi9hcmNoL3Bvd2VycGMva2VybmVsL2RtYS1pb21tdS5jCkBAIC0xMTcsMTAgKzExNywx
OCBAQCB1NjQgZG1hX2lvbW11X2dldF9yZXF1aXJlZF9tYXNrKHN0cnVjdCBkZXZpY2UgKmRldikK
ICAgICAgICAgc3RydWN0IGlvbW11X3RhYmxlICp0YmwgPSBnZXRfaW9tbXVfdGFibGVfYmFzZShk
ZXYpOwogICAgICAgICB1NjQgbWFzazsKCisgICAgICAgaWYgKGRldl9pc19wY2koZGV2KSkgewor
ICAgICAgICAgICAgICAgdTY0IGJ5cGFzc19tYXNrID0gZG1hX2RpcmVjdF9nZXRfcmVxdWlyZWRf
bWFzayhkZXYpOworCisgICAgICAgICAgICAgICBpZiAoZG1hX2lvbW11X2J5cGFzc19zdXBwb3J0
ZWQoZGV2LCBieXBhc3NfbWFzaykpCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBieXBh
c3NfbWFzazsKKyAgICAgICB9CisKICAgICAgICAgaWYgKCF0YmwpCiAgICAgICAgICAgICAgICAg
cmV0dXJuIDA7CgotICAgICAgIG1hc2sgPSAxVUxMIDwgKGZsc19sb25nKHRibC0+aXRfb2Zmc2V0
ICsgdGJsLT5pdF9zaXplKSAtIDEpOworICAgICAgIG1hc2sgPSAxVUxMIDw8IChmbHNfbG9uZyh0
YmwtPml0X29mZnNldCArIHRibC0+aXRfc2l6ZSkgKworICAgICAgICAgICAgICAgICAgICAgICB0
YmwtPml0X3BhZ2Vfc2hpZnQgLSAxKTsKICAgICAgICAgbWFzayArPSBtYXNrIC0gMTsKCiAgICAg
ICAgIHJldHVybiBtYXNrOwoKCgotLSAKQWxleGV5Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
