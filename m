Return-Path: <SRS0=EPxn=4E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01833C3B1BF
	for <iommu@archiver.kernel.org>; Sun, 16 Feb 2020 22:11:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B020B2067D
	for <iommu@archiver.kernel.org>; Sun, 16 Feb 2020 22:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZTPVn19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B020B2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C0218708F;
	Sun, 16 Feb 2020 22:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4AGrCPgij9eN; Sun, 16 Feb 2020 22:11:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 01B978704A;
	Sun, 16 Feb 2020 22:11:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0EFBC07FF;
	Sun, 16 Feb 2020 22:11:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8785C013E
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 22:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B19F48707A
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 22:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cSwT32TUeL5m for <iommu@lists.linux-foundation.org>;
 Sun, 16 Feb 2020 22:11:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CFA828704A
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 22:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581891085;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MgSgh6Awo6PzUOgfQ/mpTPuv1AmDiJ529hzRfa6zN8=;
 b=AZTPVn19qgbuZuodxTyb35tt+d5ZQ3h8fpXKaET8KLRXX2ZaEVYrweY4whHjdKj0vb9VFG
 HDshtV3vKylGtZnAOUeoqzVXv+7+9MwDirVOLxxzkKXeC9VK3qJFh6UsJk+tp5QdRWa9UN
 9KNwzqvAhYOOsyX8GvIbtrzXFPcr9FI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-69wbOBWcPGSkVVozv3_Jwg-1; Sun, 16 Feb 2020 17:11:13 -0500
Received: by mail-qk1-f198.google.com with SMTP id t186so10690347qkf.9
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 14:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=5MgSgh6Awo6PzUOgfQ/mpTPuv1AmDiJ529hzRfa6zN8=;
 b=mIoIaldFQL4JoliXXrigGuaeuclweY8iVVTi7qAK0EddJM5WDpS3CUjKVA1fT93kwu
 K3v7AsWzQhYIGQgEvr90mkygoKc8k+z6mrmIZRleQzhg7rfyiKxoWRcfCDxeEi7nAkCy
 LAiQ5wuZTv8OlSX/w7EQNcoby9X0jRsHpY7GIoKo3vdk9e8dRE/p0nxUMQqUiSa/lZtT
 xeiawJI0c3+LQ2Q5g7cZwVz/yQH6cUepjuOD9sq0m/8xOrDllMQDZM/hUWea3wWzFQd2
 cS88D2+qWcyszPVXlpYwDQ8dYsW75Y7kAWkF/K9Wox4RpAD8m1CoxgEAODpoxQONv3L2
 H/cQ==
X-Gm-Message-State: APjAAAUnAD3G1Q6qjmgebP65JhNUDA3vvVcrZ9K7mtZ6znTP9zmhOryb
 4L6s5X/7hZjZMoggwUC0rzCEoLupTpQPvgx9flAk8DQOWRBdPqVnD4rt6AQRPdsB5qrEQsioJO9
 m5hDUqzDCAQl6OOfp+S5V62oTOyK1Aw==
X-Received: by 2002:a37:73c7:: with SMTP id
 o190mr12262296qkc.490.1581891072827; 
 Sun, 16 Feb 2020 14:11:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqw3Cp95CyeFC0QHg/e9/XJOtQqQc/2522U/vK9rY7/LFJeFo/Mncp8jc2PoIYLHC+yPXKaPiw==
X-Received: by 2002:a37:73c7:: with SMTP id
 o190mr12262281qkc.490.1581891072459; 
 Sun, 16 Feb 2020 14:11:12 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id o25sm7970722qkk.7.2020.02.16.14.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 14:11:11 -0800 (PST)
Date: Sun, 16 Feb 2020 15:11:10 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: arm-smmu.1.auto: Unhandled context fault starting with 5.4-rc1
Message-ID: <20200216221110.zie3o5opbvarir3h@cantor>
References: <20200214201353.qlbqcvpztcx55qud@cantor>
 <7c9a234e-78b1-2385-84b8-50744b9c4066@arm.com>
MIME-Version: 1.0
In-Reply-To: <7c9a234e-78b1-2385-84b8-50744b9c4066@arm.com>
X-MC-Unique: 69wbOBWcPGSkVVozv3_Jwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gRnJpIEZlYiAxNCAyMCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+SGkgSmVycnksCj4KPk9uIDIw
MjAtMDItMTQgODoxMyBwbSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj5IaSBXaWxsLAo+Pgo+
Pk9uIGEgZ2lnYWJ5dGUgc3lzdGVtIHdpdGggQ2F2aXVtIENOOHh4LCB3aGVuIGRvaW5nIGEgZmlv
IHRlc3QgYWdhaW5zdAo+PmFuIG52bWUgZHJpdmUgd2UgYXJlIHNlZWluZyB0aGUgZm9sbG93aW5n
Ogo+Pgo+PlvCoCA2MzcuMTYxMTk0XSBhcm0tc21tdSBhcm0tc21tdS4xLmF1dG86IFVuaGFuZGxl
ZCBjb250ZXh0IGZhdWx0OiAKPj5mc3I9MHg4MDAwMDQwMiwgaW92YT0weDgwMTAwMDNmNjAwMCwg
ZnN5bnI9MHg3MDA5MSwgCj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+PlvCoCA2MzcuMTc0MzI5
XSBhcm0tc21tdSBhcm0tc21tdS4xLmF1dG86IFVuaGFuZGxlZCBjb250ZXh0IGZhdWx0OiAKPj5m
c3I9MHg4MDAwMDQwMiwgaW92YT0weDgwMTAwMDAzNjAwMCwgZnN5bnI9MHg3MDA5MSwgCj4+Y2Jm
cnN5bnJhPTB4OTAwMCwgY2I9Nwo+PlvCoCA2MzcuMTg2ODg3XSBhcm0tc21tdSBhcm0tc21tdS4x
LmF1dG86IFVuaGFuZGxlZCBjb250ZXh0IGZhdWx0OiAKPj5mc3I9MHg4MDAwMDQwMiwgaW92YT0w
eDgwMTAwMDJlZTAwMCwgZnN5bnI9MHg3MDA5MSwgCj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+
PlvCoCA2MzcuMTk5Mjc1XSBhcm0tc21tdSBhcm0tc21tdS4xLmF1dG86IFVuaGFuZGxlZCBjb250
ZXh0IGZhdWx0OiAKPj5mc3I9MHg4MDAwMDQwMiwgaW92YT0weDgwMTAwMDNjNzAwMCwgZnN5bnI9
MHg3MDA5MSwgCj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+PlvCoCA2MzcuMjExODg1XSBhcm0t
c21tdSBhcm0tc21tdS4xLmF1dG86IFVuaGFuZGxlZCBjb250ZXh0IGZhdWx0OiAKPj5mc3I9MHg4
MDAwMDQwMiwgaW92YT0weDgwMTAwMDM5MjAwMCwgZnN5bnI9MHg3MDA5MSwgCj4+Y2JmcnN5bnJh
PTB4OTAwMCwgY2I9Nwo+PlvCoCA2MzcuMjI0NTgwXSBhcm0tc21tdSBhcm0tc21tdS4xLmF1dG86
IFVuaGFuZGxlZCBjb250ZXh0IGZhdWx0OiAKPj5mc3I9MHg4MDAwMDQwMiwgaW92YT0weDgwMTAw
MDAxODAwMCwgZnN5bnI9MHg3MDA5MSwgCj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+PlvCoCA2
MzcuMjM3MjQxXSBhcm0tc21tdSBhcm0tc21tdS4xLmF1dG86IFVuaGFuZGxlZCBjb250ZXh0IGZh
dWx0OiAKPj5mc3I9MHg4MDAwMDQwMiwgaW92YT0weDgwMTAwMDM2MDAwMCwgZnN5bnI9MHg3MDA5
MSwgCj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+PlvCoCA2MzcuMjQ5NjU3XSBhcm0tc21tdSBh
cm0tc21tdS4xLmF1dG86IFVuaGFuZGxlZCBjb250ZXh0IGZhdWx0OiAKPj5mc3I9MHg4MDAwMDQw
MiwgaW92YT0weDgwMTAwMDBiYTAwMCwgZnN5bnI9MHg3MDA5MSwgCj4+Y2JmcnN5bnJhPTB4OTAw
MCwgY2I9Nwo+PlvCoCA2MzcuMjYyMTIwXSBhcm0tc21tdSBhcm0tc21tdS4xLmF1dG86IFVuaGFu
ZGxlZCBjb250ZXh0IGZhdWx0OiAKPj5mc3I9MHg4MDAwMDQwMiwgaW92YT0weDgwMTAwMDAzZTAw
MCwgZnN5bnI9MHg3MDA5MSwgCj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+PlvCoCA2MzcuMjc0
NDY4XSBhcm0tc21tdSBhcm0tc21tdS4xLmF1dG86IFVuaGFuZGxlZCBjb250ZXh0IGZhdWx0OiAK
Pj5mc3I9MHg4MDAwMDQwMiwgaW92YT0weDgwMTAwMDMwNDAwMCwgZnN5bnI9MHg3MDA5MSwgCj4+
Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+Cj5UaG9zZSAiSU9WQXMiIGRvbid0IGxvb2sgbXVjaCBs
aWtlIElPVkFzIGZyb20gdGhlIERNQSBhbGxvY2F0b3IgLSBpZiAKPnRoZXkgd2VyZSBwaHlzaWNh
bCBhZGRyZXNzZXMsIHdvdWxkIHRoZXkgY29ycmVzcG9uZCB0byBhbiBleHBlY3RlZCAKPnJlZ2lv
biBvZiB0aGUgcGh5c2ljYWwgbWVtb3J5IG1hcD8KPgo+SSB3b3VsZCBzdXNwZWN0IHRoYXQgdGhp
cyBpcyBtb3N0IGxpa2VseSBtaXNiZWhhdmlvdXIgaW4gdGhlIE5WTWUgCj5kcml2ZXIgKGlzc3Vp
bmcgYSB3cml0ZSB0byBhIG5vbi1ETUEtbWFwcGVkIGFkZHJlc3MpLCBhbmQgdGhlIFNNTVUgaXMg
Cj5qdXN0IGRvaW5nIGl0cyBqb2IgaW4gYmxvY2tpbmcgYW5kIHJlcG9ydGluZyBpdC4KPgo+Pkkg
YWxzbyByZXByb2R1Y2VkIHdpdGggNS41LXJjNywgYW5kIHdpbGwgY2hlY2sgNS42LXJjMSBsYXRl
ciB0b2RheS4gCj4+SSBjb3VsZG4ndCBuYXJyb3cgaXQgZG93biBmdXJ0aGVyIGludG8gNS40LXJj
MS4KPj5JIGRvbid0IGtub3cgc21tdSBvciB0aGUgY29kZSB3ZWxsLCBhbnkgdGhvdWdodHMgb24g
d2hlcmUgdG8gc3RhcnQgCj4+ZGlnZ2luZyBpbnRvIHRoaXM/Cj4+Cj4+ZmlvIHRlc3QgdGhhdCBp
cyBiZWluZyBydW4gaXM6Cj4+Cj4+I2ZpbyAtZmlsZW5hbWU9L2Rldi9udm1lMG4xIC1pb2RlcHRo
PTY0IC10aHJlYWQgLXJ3PXJhbmR3cml0ZSAKPj4taW9lbmdpbmU9bGliYWlvIC1icz00ayAtcnVu
dGltZT00MzIwMCAtc2l6ZT0tZ3JvdXBfcmVwb3J0aW5nIAo+Pi1uYW1lPW15dGVzdCAtbnVtam9i
cz0zMgo+Cj5KdXN0IHRvIGNsYXJpZnksIGRvIG90aGVyIHRlc3RzIHdvcmsgT0sgb24gdGhlIHNh
bWUgZGV2aWNlPwo+Cj5UaGFua3MsCj5Sb2Jpbi4KPgoKSSB3YXMgYWJsZSB0byBnZXQgYmFjayBv
biB0aGUgc3lzdGVtIHRvZGF5LiBJIHRoaW5rIEkga25vdyB3aGF0IHRoZSBwcm9ibGVtIGlzOgoK
WyAgICAwLjAzNjE4OV0gaW9tbXU6IEdpZ2FieXRlIFIxMjAtVDM0LTAwIGRldGVjdGVkLCBmb3Jj
ZSBpb21tdSBwYXNzdGhyb3VnaCBtb2RlClsgICAgNi4zMjQyODJdIGlvbW11OiBEZWZhdWx0IGRv
bWFpbiB0eXBlOiBUcmFuc2xhdGVkCgpTbyB0aGUgbmV3IGRlZmF1bHQgZG9tYWluIGNvZGUgaW4g
NS40IG92ZXJyaWRlcyB0aGUgaW9tbXUgcXVpcmsgY29kZSBzZXR0aW5nIGRlZmF1bHQKcGFzc3Ro
cm91Z2guIFRlc3RpbmcgYSBxdWljayBwYXRjaCB0aGF0IHRyYWNrcyB3aGV0aGVyIHRoZSBkZWZh
dWx0IGRvbWFpbiB3YXMgc2V0CmluIHRoZSBxdWlyayBjb2RlLCBhbmQgbGVhdmVzIGl0IGFsb25l
IGlmIGl0IHdhcy4gU28gZmFyIGl0IHNlZW1zIHRvIGJlIHdvcmtpbmcuCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
