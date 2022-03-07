Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4369C4332F
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 14:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EED6681D18;
	Mon,  7 Mar 2022 14:22:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0GH7xowMe96Z; Mon,  7 Mar 2022 14:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9FE8481B71;
	Mon,  7 Mar 2022 14:22:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D4AEC0089;
	Mon,  7 Mar 2022 14:21:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DFBAC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F32F81985
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c114GbCaU2iM for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 12:24:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 109FF813DC
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:24:19 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-2dbc48104beso161600497b3.5
 for <iommu@lists.linux-foundation.org>; Mon, 07 Mar 2022 04:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=benyossef-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Tj6WbMsdxlADcgXiMOHHwve+HOHgnfHXu+gQYVdroXE=;
 b=pHA+arVpLeTc3erxecGoIXrFCvy4PoDrWBlqN8JIF7mY2IGoJbMBczR89LA2bS8aMC
 yguRLI+tmcPDIgqqdDUxTOs/kjZFjF5CeNzYIGsqsIQg314nMvzyZOBF02WbUroTpWtV
 GDarJgyW7mr2EOnsWgcBsoa7X44OG1aPm3YigITnEba1sXuXKJfiaVAAkO/G+fs8hWLZ
 gbImZMGZnvXL73zDUG4UevZDohbEcoBL59i64nUpIoPESpteWCFwyi49hKcXFjzlVzcJ
 Bk1TMLuG4GI7/6Zz0I/Y+8IGDZLfq58POLxPMxi5crda+VOekW9RP4bhWlUAyN2YzXng
 kyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Tj6WbMsdxlADcgXiMOHHwve+HOHgnfHXu+gQYVdroXE=;
 b=AJ3FZRgf4rOtkx/M4nGa6iiAPugzJXtkqvLFUSXV6Xjufey3d36G9VpoG4PEP4VWIl
 s0FuckwzmJkgtbGeSfo4hBQBCL534kAhmkEAzh3qNHK+CizdaaVVMEBI+II+I72QaNUv
 IVah4hra77cknhhZJKNHrZtRsp+7qgOkBclRwQY9udRdZCBY/gf3n74LJ5ivL+GgVCZc
 ke1qLaJOG4DuQrIR/ENOhOBq4+mJzwwkfF2j0DtlnhmzbHRnPoscbWWqCOMT61+wPS7G
 QuPvCUKVbM7sdeHZG9Ig+Jjl06XjCj6pfrcgsgNWE15UqAJLOHDOAr5ROTYBGNpq9dad
 q6ig==
X-Gm-Message-State: AOAM531xwxJrP3mKKkEfpefc5ib2C/Zm/YLKkFKDZnSp9mELJzOJusZd
 hDQsog0pVMWnxXrMhzWx2PPSbH3+IMCpAUykcUJ7zQ==
X-Google-Smtp-Source: ABdhPJwIUBOImWd12VmEHZQOywK+J1aNy/4vn/CBPX5NYh0qWlcSv8SAgVPPCFqajq3puTrLz/Yhh6dWwpatPuuumFM=
X-Received: by 2002:a0d:d8d6:0:b0:2dc:1054:13a0 with SMTP id
 a205-20020a0dd8d6000000b002dc105413a0mr8131121ywe.54.1646655858855; Mon, 07
 Mar 2022 04:24:18 -0800 (PST)
MIME-Version: 1.0
References: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red>
 <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red>
In-Reply-To: <YiXjCcXXk0f18FDL@Red>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Mon, 7 Mar 2022 14:24:08 +0200
Message-ID: <CAOtvUMd_mtDjP1WRQ9imjh99bEf3gtJSb3OCr7Q6-Aky2_5-dQ@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To: Corentin Labbe <clabbe.montjoie@gmail.com>
X-Mailman-Approved-At: Mon, 07 Mar 2022 14:21:57 +0000
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

T24gTW9uLCBNYXIgNywgMjAyMiBhdCAxMjo0OCBQTSBDb3JlbnRpbiBMYWJiZQo8Y2xhYmJlLm1v
bnRqb2llQGdtYWlsLmNvbT4gd3JvdGU6Cgo+Cj4gSGVsbG8KPgo+IEkgc3RpbGwgZ2V0IHRoZSB3
YXJuaW5nOgo+IFsgIDQzMy40MDYyMzBdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0t
LS0tLQo+IFsgIDQzMy40MDYzMjZdIERNQS1BUEk6IGNjcmVlIGU2NjAxMDAwLmNyeXB0bzogY2Fj
aGVsaW5lIHRyYWNraW5nIEVFWElTVCwgb3ZlcmxhcHBpbmcgbWFwcGluZ3MgYXJlbid0IHN1cHBv
cnRlZAo+IFsgIDQzMy40MDYzODZdIFdBUk5JTkc6IENQVTogNyBQSUQ6IDMxMDc0IGF0IC9ob21l
L2NsYWJiZS9saW51eC1uZXh0L2tlcm5lbC9kbWEvZGVidWcuYzo1NzEgYWRkX2RtYV9lbnRyeSsw
eDFkMC8weDI4OAo+IFsgIDQzMy40MDY0MzRdIE1vZHVsZXMgbGlua2VkIGluOgo+IFsgIDQzMy40
MDY0NThdIENQVTogNyBQSUQ6IDMxMDc0IENvbW06IGtjYXBpIE5vdCB0YWludGVkIDUuMTcuMC1y
YzYtbmV4dC0yMDIyMDMwMy0wMDEzMC1nMzAwNDJlNDdlZTQ3LWRpcnR5ICM1NAo+IFsgIDQzMy40
MDY0NzNdIEhhcmR3YXJlIG5hbWU6IFJlbmVzYXMgU2FsdmF0b3ItWCBib2FyZCBiYXNlZCBvbiBy
OGE3Nzk1MCAoRFQpCj4gWyAgNDMzLjQwNjQ4NF0gcHN0YXRlOiA0MDAwMDAwNSAoblpjdiBkYWlm
IC1QQU4gLVVBTyAtVENPIC1ESVQgLVNTQlMgQlRZUEU9LS0pCj4gWyAgNDMzLjQwNjQ5OF0gcGMg
OiBhZGRfZG1hX2VudHJ5KzB4MWQwLzB4Mjg4Cj4gWyAgNDMzLjQwNjUxMF0gbHIgOiBhZGRfZG1h
X2VudHJ5KzB4MWQwLzB4Mjg4Cj4gWyAgNDMzLjQwNjUyMl0gc3AgOiBmZmZmODAwMDE1ZGEzNjkw
Cj4gWyAgNDMzLjQwNjUzMV0geDI5OiBmZmZmODAwMDE1ZGEzNjkwIHgyODogMDAwMDAwMDAwMDAw
MDAwMCB4Mjc6IDAwMDAwMDAwMDAwMDAwMDAKPiBbICA0MzMuNDA2NTYyXSB4MjY6IDAwMDAwMDAw
MDAwMDAwMDAgeDI1OiBmZmZmODAwMDBiNGM3YmMwIHgyNDogZmZmZjgwMDAwYjRjNzAwMAo+IFsg
IDQzMy40MDY1OTNdIHgyMzogMDAwMDAwMDAwMDAwMDAwMCB4MjI6IDAwMDAwMDAwZmZmZmZmZWYg
eDIxOiBmZmZmODAwMDBhOWI2MDAwCj4gWyAgNDMzLjQwNjYyM10geDIwOiBmZmZmMDAwNGMwYWY1
YzAwIHgxOTogZmZmZjgwMDAwYjQyMDAwMCB4MTg6IGZmZmZmZmZmZmZmZmZmZmYKPiBbICA0MzMu
NDA2NjUzXSB4MTc6IDZjNzI2NTc2NmYyMDJjNTQgeDE2OiA1MzQ5NTg0NTQ1MjA2NzZlIHgxNTog
MDAwMDAwMDAwMDAwMDIyZQo+IFsgIDQzMy40MDY2ODNdIHgxNDogZmZmZjgwMDAxNWRhMzM4MCB4
MTM6IDAwMDAwMDAwZmZmZmZmZWEgeDEyOiBmZmZmODAwMDBiNGJlMDEwCj4gWyAgNDMzLjQwNjcx
M10geDExOiAwMDAwMDAwMDAwMDAwMDAxIHgxMDogMDAwMDAwMDAwMDAwMDAwMSB4OSA6IGZmZmY4
MDAwMGI0YTYwMjgKPiBbICA0MzMuNDA2NzQzXSB4OCA6IGMwMDAwMDAwZmZmZmVmZmYgeDcgOiAw
MDAwMDAwMDAwMDE3ZmU4IHg2IDogZmZmZjgwMDAwYjRhNWZkMAo+IFsgIDQzMy40MDY3NzNdIHg1
IDogZmZmZjAwMDZmZjc5NWM0OCB4NCA6IDAwMDAwMDAwMDAwMDAwMDAgeDMgOiAwMDAwMDAwMDAw
MDAwMDI3Cj4gWyAgNDMzLjQwNjgwMl0geDIgOiAwMDAwMDAwMDAwMDAwMDIzIHgxIDogOGNhNGU0
ZmJmNGI4NzkwMCB4MCA6IDAwMDAwMDAwMDAwMDAwMDAKPiBbICA0MzMuNDA2ODMzXSBDYWxsIHRy
YWNlOgo+IFsgIDQzMy40MDY4NDFdICBhZGRfZG1hX2VudHJ5KzB4MWQwLzB4Mjg4Cj4gWyAgNDMz
LjQwNjg1NF0gIGRlYnVnX2RtYV9tYXBfc2crMHgxNTAvMHgzOTgKPiBbICA0MzMuNDA2ODY5XSAg
X19kbWFfbWFwX3NnX2F0dHJzKzB4OWMvMHgxMDgKPiBbICA0MzMuNDA2ODg5XSAgZG1hX21hcF9z
Z19hdHRycysweDEwLzB4MjgKPiBbICA0MzMuNDA2OTA0XSAgY2NfbWFwX3NnKzB4ODAvMHgxMDAK
PiBbICA0MzMuNDA2OTI0XSAgY2NfbWFwX2NpcGhlcl9yZXF1ZXN0KzB4MTc4LzB4M2M4Cj4gWyAg
NDMzLjQwNjkzOV0gIGNjX2NpcGhlcl9wcm9jZXNzKzB4MjEwLzB4YjU4Cj4gWyAgNDMzLjQwNjk1
M10gIGNjX2NpcGhlcl9lbmNyeXB0KzB4MmMvMHgzOAo+IFsgIDQzMy40MDY5NjddICBjcnlwdG9f
c2tjaXBoZXJfZW5jcnlwdCsweDQ0LzB4NzgKPiBbICA0MzMuNDA2OTg2XSAgc2tjaXBoZXJfcmVj
dm1zZysweDM2Yy8weDQyMAo+IFsgIDQzMy40MDcwMDNdICBfX19fc3lzX3JlY3Ztc2crMHg5MC8w
eDI4MAo+IFsgIDQzMy40MDcwMjRdICBfX19zeXNfcmVjdm1zZysweDg4LzB4ZDAKPiBbICA0MzMu
NDA3MDM4XSAgX19zeXNfcmVjdm1zZysweDZjLzB4ZDAKPiBbICA0MzMuNDA3MDQ5XSAgX19hcm02
NF9zeXNfcmVjdm1zZysweDI0LzB4MzAKPiBbICA0MzMuNDA3MDYxXSAgaW52b2tlX3N5c2NhbGwr
MHg0NC8weDEwMAo+IFsgIDQzMy40MDcwODJdICBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMysw
eDkwLzB4MTIwCj4gWyAgNDMzLjQwNzA5Nl0gIGRvX2VsMF9zdmMrMHgyNC8weDg4Cj4gWyAgNDMz
LjQwNzExMF0gIGVsMF9zdmMrMHg0Yy8weDEwMAo+IFsgIDQzMy40MDcxMzFdICBlbDB0XzY0X3N5
bmNfaGFuZGxlcisweDkwLzB4YjgKPiBbICA0MzMuNDA3MTQ1XSAgZWwwdF82NF9zeW5jKzB4MTcw
LzB4MTc0Cj4gWyAgNDMzLjQwNzE2MF0gaXJxIGV2ZW50IHN0YW1wOiA1NjI0Cj4gWyAgNDMzLjQw
NzE2OF0gaGFyZGlycXMgbGFzdCAgZW5hYmxlZCBhdCAoNTYyMyk6IFs8ZmZmZjgwMDAwODEyZjZh
OD5dIF9fdXBfY29uc29sZV9zZW0rMHg2MC8weDk4Cj4gWyAgNDMzLjQwNzE5MV0gaGFyZGlycXMg
bGFzdCBkaXNhYmxlZCBhdCAoNTYyNCk6IFs8ZmZmZjgwMDAwOWM5YTA2MD5dIGVsMV9kYmcrMHgy
OC8weDkwCj4gWyAgNDMzLjQwNzIwOF0gc29mdGlycXMgbGFzdCAgZW5hYmxlZCBhdCAoNTU3MCk6
IFs8ZmZmZjgwMDAwOTdlNjJmOD5dIGxvY2tfc29ja19uZXN0ZWQrMHg4MC8weGEwCj4gWyAgNDMz
LjQwNzIyNl0gc29mdGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoNTU2OCk6IFs8ZmZmZjgwMDAwOTdl
NjJkOD5dIGxvY2tfc29ja19uZXN0ZWQrMHg2MC8weGEwCj4gWyAgNDMzLjQwNzI0MV0gLS0tWyBl
bmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tCj4gWyAgNDMzLjQwNzM4MV0gRE1BLUFQSTog
TWFwcGVkIGF0Ogo+IFsgIDQzMy40MDczOTZdICBkZWJ1Z19kbWFfbWFwX3NnKzB4MTZjLzB4Mzk4
Cj4gWyAgNDMzLjQwNzQxNl0gIF9fZG1hX21hcF9zZ19hdHRycysweDljLzB4MTA4Cj4gWyAgNDMz
LjQwNzQzNl0gIGRtYV9tYXBfc2dfYXR0cnMrMHgxMC8weDI4Cj4gWyAgNDMzLjQwNzQ1NV0gIGNj
X21hcF9zZysweDgwLzB4MTAwCj4gWyAgNDMzLjQwNzQ3NV0gIGNjX21hcF9jaXBoZXJfcmVxdWVz
dCsweDE3OC8weDNjOAoKQnkgdGhlIHdheSwgdGhpcyBjb21lcyBmcm9tIGEgdG90YWxseSBkaWZm
ZXJlbnQgY2FsbCBzaXRlIHRoYW4gdGhlCnByZXZpb3VzIGRyYmcuCgpKdWRnaW5nIGZyb20gdGhl
IGZhY3QgdGhhdCB3ZSd2ZSBuZXZlciBzZWVuIHRoaXMgZXJyb3IgYmVmb3JlIGFuZCB0aGF0Cnlv
dSBzdGFydCBzZWVpbmcgaXQgc3VkZGVubHkgZnJvbSBkaWZmZXJlbnQgZHJpdmVycyBvbiBkaWZm
ZXJlbnQKcGxhdGZvcm1zIGZyb20gZGlmZmVyZW50IGNhbGwgc2l0ZXMgLi4uCgpJIHN1c3BlY3Qg
dGhpcyBpcyBjYXVzZWQgYnkgc29tZSByZWNlbnQgYWRkaXRpb24gb3IgY2hhbmdlLgoKV2hpY2gg
dHJlZSBhcmUgeW91IGJ1aWxkaW5nIHRoaXMgZnJvbSBhbmQgZG9lcyBpdCBoYXZlIGRtYSByZWxh
dGVkCmNvbW1pdHM/IG1heSB0cnkgdG9pIGJpc2VjdCB0aGlzPwoKR2lsYWQKCgotLSAKR2lsYWQg
QmVuLVlvc3NlZgpDaGllZiBDb2ZmZWUgRHJpbmtlcgoKdmFsdWVzIG9mIM6yIHdpbGwgZ2l2ZSBy
aXNlIHRvIGRvbSEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
