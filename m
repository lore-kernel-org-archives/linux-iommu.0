Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117CDC433DB
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 20:38:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8BE64FAE
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 20:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8BE64FAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 130D4843B3;
	Wed, 10 Mar 2021 20:38:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GV-vqxo2xUqP; Wed, 10 Mar 2021 20:38:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id F300A83D80;
	Wed, 10 Mar 2021 20:38:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8DA8C000A;
	Wed, 10 Mar 2021 20:38:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A90BC0001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 20:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11D9D46260
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 20:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0IHthvztyibQ for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 20:38:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 999B145BE9
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 20:38:50 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id p15so27335232ljc.13
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EpCYjEARt3GihkppJF00n/fHDaWEnMpZu2zSs93LYdM=;
 b=nwAFR6XeM496vQm0sCt75xBjUOLlwUOt/i3Xde+t3Ki5YXd4OyEKMQqPvqBuW2sw+t
 ewZyRmKQ1m3qdGfzDivjdJrmiFaoqc1qHA1AiTVkr6r8THPGKeMxiSzzjizg8NXLpBqU
 cPOA2Wa1VrfauXsrVTZfDX0sZTqoJjQGOchPfrAtEtU406/fp0g6PEqS+8uUoQu3jNx3
 JNwSf4JYum4uYpS9q+FfiUWvr9ST43EA92tDIhs5tQctdbPZTxulLpfAMsFFGzFhpQG4
 mxoObcgCT9W+jzC0zVobk18fXiTRyGOD7dmYLWJMMXFD3vgnDHjlz5/3H91syoBIfaIh
 Wl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EpCYjEARt3GihkppJF00n/fHDaWEnMpZu2zSs93LYdM=;
 b=ecY+hooFUP4znLKmj3+EX/lIOw5gki+gLMrnQJSKqvXVRFqg/xzrkUhE7tL8cctpwj
 wWM9YeJWn4VIRS1sKdCmDWF3CqH2RBOP/6XCLU3Ne8u+SBJU98Ow2K4XohIUJMeEPNn2
 HXLcfzZabgctG+v52+7X6BuE4kqORQwJFZxk6+oa+47B8NwiJlZf05KTGJcR/FSQaKLY
 VYZFfGXGGnK0L/F1fXqRjXbcgO2pWNP7L5+znS8SAYMMP50/tSkCCSnfvgL3lLtyG/oA
 OGGCjOdAfw+ppDrILzC5XstZ3Un7+BDGeX0Rv9a6ley4SIw1x+3zbZy7CYlaEQT9dSd4
 tfRw==
X-Gm-Message-State: AOAM530l1d0kawXnuXqdbmdgjf7YjW1rLa7arirlKfzv1URi0X4MkFW/
 aa6RmT6cusuBv5UzqKfieEc=
X-Google-Smtp-Source: ABdhPJy0ZdpO+I0NMxp3L4J/Y0G4vaPRvjMDY2wWTo9ibfWpApN4a/l8R3EKLG71SP+a0L5qWAZu3w==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr2810226ljj.148.1615408728426; 
 Wed, 10 Mar 2021 12:38:48 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id y10sm113357lfl.240.2021.03.10.12.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Mar 2021 12:38:47 -0800 (PST)
Subject: Re: [PATCH v2] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
 thierry.reding@gmail.com, will@kernel.org
References: <20210310033614.16772-1-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cc5dca8f-e9b0-a845-1af4-e762782d5441@gmail.com>
Date: Wed, 10 Mar 2021 23:38:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210310033614.16772-1-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

MTAuMDMuMjAyMSAwNjozNiwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gVGhpcyBwYXRjaCBk
dW1wcyBhbGwgYWN0aXZlIG1hcHBpbmcgZW50cmllcyBmcm9tIHBhZ2V0YWJsZQo+IHRvIGEgZGVi
dWdmcyBkaXJlY3RvcnkgbmFtZWQgIm1hcHBpbmdzIi4KPiAKPiBBdGFjaGluZyBhbiBleGFtcGxl
Ogo+IAo+IFNXR1JPVVA6IGhjCj4gQVNJRDogMAo+IHJlZzogMHgyNTAKPiBQVEJfQVNJRDogMHhl
MDA4MDAwNAo+IGFzLT5wZF9kbWE6IDB4ODAwMDQwMDAKPiB7Cj4gICAgICAgICBbMTAyM10gMHhm
MDA4MDAxMyAoMSkKPiAgICAgICAgIHsKPiAgICAgICAgICAgICAgICAgUFRFIFJBTkdFICAgICAg
IFBIWVMgICAgICAgICAgIElPVkEgICAgICAgIFNJWkUgICAgICAgIEFUVFIKPiAgICAgICAgICAg
ICAgICAgIzEwMjMgLSAjMTAyMyAgIDB4MTIyZTVlMDAwICAgIDB4ZmZmZmYwMDAgIDB4MTAwMCAg
ICAgIDB4NQo+ICAgICAgICAgfQo+IH0KPiBUb3RhbCBQREUgY291bnQ6IDEKPiBUb3RhbCBQVEUg
Y291bnQ6IDEKCkFkZHJlc3NlcyBhcmUgMzJiaXQgb24gQVJNMzIsIHBsZWFzZSBmaXggdGhlIGZv
cm1hdHRpbmcuIFRoZSBwaHlzX2FkZHJfdAphbmQgZG1hX2FkZHJfdCBoYXZlIHNwZWNpYWwgcHJp
bnRrIHNwZWNpZmllcnMgWzFdLgoKWzFdCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwv
bGF0ZXN0L2NvcmUtYXBpL3ByaW50ay1mb3JtYXRzLmh0bWw/aGlnaGxpZ2h0PXByaW50ayNwaHlz
aWNhbC1hZGRyZXNzLXR5cGVzLXBoeXMtYWRkci10Cgphcy0+cGRfZG1hOiAweGMwMjZlODFiMDAw
MDAyNmMKewogICAgICAgIFswXSAweGYwMDgyODQ4ICgxMDI0KQogICAgICAgIHsKICAgICAgICAg
ICAgICAgIFBURSBSQU5HRSAgICAgICBQSFlTICAgICAgICAgICBJT1ZBICAgICAgICBTSVpFCkFU
VFIKICAgICAgICAgICAgICAgICMwICAgIC0gIzE1ICAgICAweGMwZjlmYzQwYmZkZTAwMDAgMHgw
ICAgICAgICAgMHgxMDAwMAogICAweDcKICAgICAgICAgICAgICAgICMxNiAgIC0gIzQ3ICAgICAw
eGMwZjlmYzQwYmZkYzAwMDAgMHgxMDAwMCAgICAgMHgyMDAwMAogICAweDcKICAgICAgICAgICAg
ICAgICM0OCAgIC0gIzExMSAgICAweGMwZjlmYzQwYmZkODAwMDAgMHgzMDAwMCAgICAgMHg0MDAw
MAogICAweDcKICAgICAgICAgICAgICAgICMxMTIgIC0gIzIzOSAgICAweGMwZjlmYzQwYmZkMDAw
MDAgMHg3MDAwMCAgICAgMHg4MDAwMAogICAweDcKICAgICAgICAgICAgICAgICMyNDAgIC0gIzQ5
NSAgICAweGMwZjlmYzQwYmZjMDAwMDAgMHhmMDAwMCAgICAgMHgxMDAwMDAKICAgMHg3CiAgICAg
ICAgICAgICAgICAjNDk2ICAtICM5OTkgICAgMHhjMGY5ZmM0MGJmNDAwMDAwIDB4MWYwMDAwICAg
IDB4MWY4MDAwCiAgIDB4NwogICAgICAgICAgICAgICAgIzEwMDAgLSAjMTAwMCAgIDB4YzBmOWZj
NDBhY2M0MDAwMCAweDNlODAwMCAgICAweDEwMDAKICAgMHg3CiAgICAgICAgICAgICAgICAjMTAw
MSAtICMxMDAxICAgMHhjMGY5ZmM0MGJiYjk1MDAwIDB4M2U5MDAwICAgIDB4MTAwMAogICAweDcK
ICAgICAgICAgICAgICAgICMxMDAyIC0gIzEwMDIgICAweGMwZjlmYzQwYmJiOTcwMDAgMHgzZWEw
MDAgICAgMHgxMDAwCiAgIDB4NwogICAgICAgICAgICAgICAgIzEwMDMgLSAjMTAwMyAgIDB4YzBm
OWZjNDBiYmI5MTAwMCAweDNlYjAwMCAgICAweDEwMDAKICAgMHg3CiAgICAgICAgICAgICAgICAj
MTAwNCAtICMxMDA1ICAgMHhjMGY5ZmM0MGJiNDU1MDAwIDB4M2VjMDAwICAgIDB4MjAwMAogICAw
eDcKICAgICAgICAgICAgICAgICMxMDA2IC0gIzEwMDYgICAweGMwZjlmYzQwYmVlOWMwMDAgMHgz
ZWUwMDAgICAgMHgxMDAwCiAgIDB4NwogICAgICAgICAgICAgICAgIzEwMDcgLSAjMTAwNyAgIDB4
YzBmOWZjNDBiZWQyMDAwMCAweDNlZjAwMCAgICAweDEwMDAKICAgMHg3CiAgICAgICAgICAgICAg
ICAjMTAwOCAtICMxMDA4ICAgMHhjMGY5ZmM0MGJiZGUwMDAwIDB4M2YwMDAwICAgIDB4MTAwMAog
ICAweDcKICAgICAgICAgICAgICAgICMxMDA5IC0gIzEwMDkgICAweGMwZjlmYzQwYmU0NjUwMDAg
MHgzZjEwMDAgICAgMHgxMDAwCiAgIDB4NwogICAgICAgICAgICAgICAgIzEwMTAgLSAjMTAxMCAg
IDB4YzBmOWZjNDBiYjUwNTAwMCAweDNmMjAwMCAgICAweDEwMDAKICAgMHg3CiAgICAgICAgICAg
ICAgICAjMTAxMSAtICMxMDExICAgMHhjMGY5ZmM0MGJkY2I5MDAwIDB4M2YzMDAwICAgIDB4MTAw
MAogICAweDcKICAgICAgICAgICAgICAgICMxMDEyIC0gIzEwMTIgICAweGMwZjlmYzQwYmNkZjkw
MDAgMHgzZjQwMDAgICAgMHgxMDAwCiAgIDB4NwogICAgICAgICAgICAgICAgIzEwMTMgLSAjMTAx
MyAgIDB4YzBmOWZjNDBiYjZjZTAwMCAweDNmNTAwMCAgICAweDEwMDAKICAgMHg3CiAgICAgICAg
ICAgICAgICAjMTAxNCAtICMxMDE0ICAgMHhjMGY5ZmM0MGJjZDc0MDAwIDB4M2Y2MDAwICAgIDB4
MTAwMAogICAweDcKICAgICAgICAgICAgICAgICMxMDE1IC0gIzEwMTUgICAweGMwZjlmYzQwYmQw
ZDAwMDAgMHgzZjcwMDAgICAgMHgxMDAwCiAgIDB4NwogICAgICAgICAgICAgICAgIzEwMTYgLSAj
MTAxNiAgIDB4YzBmOWZjNDBiYjZjNTAwMCAweDNmODAwMCAgICAweDEwMDAKICAgMHg3CiAgICAg
ICAgICAgICAgICAjMTAxNyAtICMxMDE3ICAgMHhjMGY5ZmM0MGJkMTIxMDAwIDB4M2Y5MDAwICAg
IDB4MTAwMAogICAweDcKICAgICAgICAgICAgICAgICMxMDE4IC0gIzEwMTggICAweGMwZjlmYzQw
YmI2ZGYwMDAgMHgzZmEwMDAgICAgMHgxMDAwCiAgIDB4NwogICAgICAgICAgICAgICAgIzEwMTkg
LSAjMTAyMCAgIDB4YzBmOWZjNDBiYjZlOTAwMCAweDNmYjAwMCAgICAweDIwMDAKICAgMHg3CiAg
ICAgICAgICAgICAgICAjMTAyMSAtICMxMDIxICAgMHhjMGY5ZmM0MGJiNzEzMDAwIDB4M2ZkMDAw
ICAgIDB4MTAwMAogICAweDcKICAgICAgICAgICAgICAgICMxMDIyIC0gIzEwMjIgICAweGMwZjlm
YzQwYmI3MzgwMDAgMHgzZmUwMDAgICAgMHgxMDAwCiAgIDB4NwogICAgICAgICAgICAgICAgIzEw
MjMgLSAjMTAyMyAgIDB4YzBmOWZjNDBiZTQ0NDAwMCAweDNmZjAwMCAgICAweDEwMDAKICAgMHg3
CiAgICAgICAgfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
