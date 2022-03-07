Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BEFC433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 14:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4064F410D8;
	Mon,  7 Mar 2022 14:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oUKzDJ8lvxh4; Mon,  7 Mar 2022 14:22:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C8A6D410CA;
	Mon,  7 Mar 2022 14:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8195AC0094;
	Mon,  7 Mar 2022 14:22:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 216CFC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A21E400F3
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=benyossef-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8T6Mldf1HZUR for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 13:43:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BEABE40004
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:43:19 +0000 (UTC)
Received: by mail-yb1-xb34.google.com with SMTP id g1so31006570ybe.4
 for <iommu@lists.linux-foundation.org>; Mon, 07 Mar 2022 05:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=benyossef-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JCKv7BiBf9KG6Lbs2x2WUR/OIGhabVnbX0TExKcjkAM=;
 b=gRhar2tLLWw3vujECxYDIPLVv4cP5OMth9dsY81IrziJVDaknPrMFo+BiUFhiXJ7DS
 nWaS4XgP8LTp2gx/tyJR+2S3YX0eVmdK7AozFzzDdgjWt8kCC/DHARuASPKl8yWqdqj0
 EVvhKHnxTyfHPGhZ8l5klawlyZUoD5ZehNQ0EsJRCuLFeYrIa4bMqF2N+7zGpEu6FjmY
 polRoaLpZLFE5t9vTCI3w7sMTd/dZO7L6D9fFMkorMIMUTXhl4gvM3IhuAlnnphN7hyf
 nbAXNJE9C7rhsL58LAKTnwd2rbH9I29vLJrJr+MeibQ7XwmgGRYn+iDc4SEKsIQG37eT
 5JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JCKv7BiBf9KG6Lbs2x2WUR/OIGhabVnbX0TExKcjkAM=;
 b=ZHUgVyt0l6L6HgRI51NL1cwrWw+dtc7Cgcc1RQkZ4WRDacWYEd4kBq8VSbXDVTIEwu
 jOeClNXzNUuOZvuhEOhyAJeyHnG6utVizyJMxRSXjOvs2XO2RthdezB5qbIuJVK72GDM
 gHJcBJ7PsRFCwqQs02qG2OuUwHsco1CHNkSuUxcgkUC9x8XbUCmj2kGsVpvEZNa3lRu7
 JGGB6brcFpVjY57y5zc1E4ltbSVkWh6NxWAgi2PvdP10QH+pIDrrNn3OW2lL80wzFjL6
 l490+daPasjp+z8gxTTpXkF7pOr9EoY1eKLDM7jDogVWkkBFQm4H4n8/x/JvlIWJN8uq
 0MjQ==
X-Gm-Message-State: AOAM533zYM9GpryEHr0UEj8zF4mpxUXE2Rn1HuUFAR8cHPBgnpLSdqip
 ZZsyDmlrgixdj15XcyXAe3v21pwzUpmzyrdRCDSvaQ==
X-Google-Smtp-Source: ABdhPJzFyMKnNGi+vCbsh8ASrlugLFK23AGLqc1/O9wGTI5xnE6q4Cl9t28M03oKxU1zc0ZjlqYNyJSxdT4uOPVVyho=
X-Received: by 2002:a25:7804:0:b0:628:ec4c:989b with SMTP id
 t4-20020a257804000000b00628ec4c989bmr7562231ybc.428.1646660598309; Mon, 07
 Mar 2022 05:43:18 -0800 (PST)
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
Date: Mon, 7 Mar 2022 15:43:07 +0200
Message-ID: <CAOtvUMffp3K1q2uXwS4X4dJbFE2_J-nRj8nxBvLewBAVWc8TvQ@mail.gmail.com>
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
dCsweDE3OC8weDNjOAo+Cj4KPiBCVVQgSSBzdGFydCB0byB0aGluZyB0aGlzIGlzIGEgYnVnIGlu
IERNQS1BUEkgZGVidWcuCj4KPgo+IE15IHN1bjhpLXNzIGRyaXZlciBoaXQgdGhlIHNhbWUgd2Fy
bmluZzoKPiBbICAxNDIuNDU4MzUxXSBXQVJOSU5HOiBDUFU6IDEgUElEOiA5MCBhdCBrZXJuZWwv
ZG1hL2RlYnVnLmM6NTk3IGFkZF9kbWFfZW50cnkrMHgyZWMvMHg0Y2MKPiBbICAxNDIuNDU4NDI5
XSBETUEtQVBJOiBzdW44aS1zcyAxYzE1MDAwLmNyeXB0bzogY2FjaGVsaW5lIHRyYWNraW5nIEVF
WElTVCwgb3ZlcmxhcHBpbmcgbWFwcGluZ3MgYXJlbid0IHN1cHBvcnRlZAo+IFsgIDE0Mi40NTg0
NTVdIE1vZHVsZXMgbGlua2VkIGluOiBjY20gYWxnaWZfYWVhZCB4dHMgY21hYwo+IFsgIDE0Mi40
NTg1NjNdIENQVTogMSBQSUQ6IDkwIENvbW06IDFjMTUwMDAuY3J5cHRvLSBOb3QgdGFpbnRlZCA1
LjE3LjAtcmM2LW5leHQtMjAyMjAzMDctMDAxMzItZzM5ZGFkNTY4ZDIwYS1kaXJ0eSAjMjIzCj4g
WyAgMTQyLjQ1ODU4MV0gSGFyZHdhcmUgbmFtZTogQWxsd2lubmVyIEE4M3QgYm9hcmQKPiBbICAx
NDIuNDU4NTk2XSAgdW53aW5kX2JhY2t0cmFjZSBmcm9tIHNob3dfc3RhY2srMHgxMC8weDE0Cj4g
WyAgMTQyLjQ1ODYyN10gIHNob3dfc3RhY2sgZnJvbSAweGYwYWJkZDFjCj4gWyAgMTQyLjQ1ODY0
Nl0gaXJxIGV2ZW50IHN0YW1wOiAzMTc0Nwo+IFsgIDE0Mi40NTg2NjBdIGhhcmRpcnFzIGxhc3Qg
IGVuYWJsZWQgYXQgKDMxNzUzKTogWzxjMDE5MzE2Yz5dIF9fdXBfY29uc29sZV9zZW0rMHg1MC8w
eDYwCj4gWyAgMTQyLjQ1ODY4OF0gaGFyZGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoMzE3NTgpOiBb
PGMwMTkzMTU4Pl0gX191cF9jb25zb2xlX3NlbSsweDNjLzB4NjAKPiBbICAxNDIuNDU4NzEwXSBz
b2Z0aXJxcyBsYXN0ICBlbmFibGVkIGF0ICgzMTYwMCk6IFs8YzA2OTkwYzg+XSBzdW44aV9zc19o
YW5kbGVfY2lwaGVyX3JlcXVlc3QrMHgzMDAvMHg4YjgKPiBbICAxNDIuNDU4NzM4XSBzb2Z0aXJx
cyBsYXN0IGRpc2FibGVkIGF0ICgzMTU4MCk6IFs8YzA2OTkwYzg+XSBzdW44aV9zc19oYW5kbGVf
Y2lwaGVyX3JlcXVlc3QrMHgzMDAvMHg4YjgKPiBbICAxNDIuNDU4NzU4XSAtLS1bIGVuZCB0cmFj
ZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0KPiBbICAxNDIuNDU4NzcxXSBETUEtQVBJOiBNYXBwZWQg
YXQ6CgpUaGUgbW9yZSBJIHRoaW5rIGFib3V0IGl0LCB0aGUgbW9yZSBJIHN1c3BlY3QgdGhhdCB0
aGlzIGlzIGEgcHJvYmxlbQpvZiB0aGUgaW5wdXQgc2dsaXN0cyB0byBjcnlwdG8gQVBJIGNhbGxz
IG92ZXJsYXBwaW5nIGluIHNvbWUgZmFzaGlvbiwKZWl0aGVyIGJldHdlZW4gc3JjIGFuZCBkc3Qg
b3IgbWF5YmUgZXZlbiBhY3Jvc3MgZGlmZmVyZW50IGNyeXB0bwpvcGVyYXRpb25zIGFuZCBIVyBj
cnlwdG8gZHJpdmVycyBqdXN0IG1hcHBpbmcgdGhvc2Ugc2dsaXN0cywgb2JsaXZpb3VzCnRvIGl0
LgoKV2hhdCBhcmUgY3J5cHRvIEhXIGRyaXZlcnMgdG8gZG8/IHNjYW4gZWFjaCBpbnB1dCBzY2F0
dGVybGlzdCBmb3IKb3ZlcmxhcCwgbm90IGp1c3QgYmV0d2VlbiBzcmMgYW5kIGRzdCBvZiB0aGUg
c2FtZSBvcGVyYXRpb24gYnV0IGFsc28KYWNyb3NzIGRpZmZlcmVudCBjcnlwdG8gb3BlcmF0aW9u
cz8gVGhhdCBpcyBpbnNhbmUuLi4KCiBJIGFtIG5vdCBzdXJlIHdoZXJlIHRvIGdvIGZyb20gaGVy
ZS4KCkdpbGFkCgoKLS0gCkdpbGFkIEJlbi1Zb3NzZWYKQ2hpZWYgQ29mZmVlIERyaW5rZXIKCnZh
bHVlcyBvZiDOsiB3aWxsIGdpdmUgcmlzZSB0byBkb20hCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
