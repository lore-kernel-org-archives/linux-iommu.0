Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4D4C62A
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470211; cv=none; b=Jz2X90kEQtifZbrn6IU+6Zh+rYd3P7md7CArRHXSkEz0ny6jfVROkDvpuXWg8nAMDYt25P7bdon2ZJsQK0c+yJdab7WfumHe6K7n3BPMNZMA3HqmZEQMQhQvR31ZQUdjwDEmeY4ilHeCG4Qmgd9Ycx2XlerxHZEECFgcNh5FV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470211; c=relaxed/simple;
	bh=oBbcCYoBRuNiy52ll2E39XeIWc04WoFIPXNgEzySS3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5+UPIAkR62TKR+gwlN53cE6b4RcHOEmaoZPY6DDEhTQWu1hIBCmpKrmHC/UsLolPG7UTkmGnezz5NA16eEfpCFr4IyvH42sjMFl8S15FvSkhJoZoyAu066TyAS05GDHzNhYxN0Wc4MhZRHaKbjhVoxG23v3oaOkx8mwHYziZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R/Y8Z2sE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R/Y8Z2sE"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c3400367so2525704f8f.2
        for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726470208; x=1727075008; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oBbcCYoBRuNiy52ll2E39XeIWc04WoFIPXNgEzySS3Y=;
        b=R/Y8Z2sE6hhukT3cPLe2sVQtC7q9/OfV6cu3JHpHkBHcBOcBhfFbRZSEc6wdIN+3FW
         4iR9Ca8R0Qws8eixgdIGZB1cSByqNTSjPt39qrIbPXNpCja3Br+85qgSIHP9mheb875K
         Uw8Moch2MNlZXcTBbdvtx7Eq3wfDaVx18RD3tbgQYgXMz1nlpeo8dS4o/SlHSJqnXGyl
         ghI+GZotaiC+JQvG9I1BEFYK0MLAcX6n3z49d6Xw/gaRNaa5QaPEGszUrvPl9iw28g4u
         dgrrq+E4BAgc1S5ux1nv6kw7yCveSe957zrW5Pn4oyE0+DPLeC2+1n1aC3eo8mrLUE+W
         RVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726470208; x=1727075008;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBbcCYoBRuNiy52ll2E39XeIWc04WoFIPXNgEzySS3Y=;
        b=ciKPsfg6/JtU7TQ1AAiq0lhcAYUnEpGvhFNAfs6YKCa/qtjfz1hXrcYLNxhSizfKPG
         8Nalt/CcKzcNGgyI8EONGVUJ1F96fwB1rlkhwR1xyx3cOHYmz/ws6TKV6uf/ziwAK9Uf
         9r3UNPyiTTpJv6F22elfqr6W6Up2yDO0U80MRK+p7Ww2CfS6PZRQ+n17lx6Srs37/Kcb
         y6wtmPe3OzUc8BqjB03kGJjSgPOH0E24ed1XIzDIOn6Pt0Rf97QF1BeMOKDAtTUMr65R
         WP7prlPC4MjNj+amM9yjGdD6KxuAV8gKfjnRPmWUualAXyRFem0Z9/1UObxqBdbCfydT
         Bd0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnmfEiaS7+KVTS1dmewgwFo5eUinDqXSr1CGeYOS3tLaVxHBFKyUO4KP6y9/HxybkLYtaZdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcrKUCjQhEHdV9FRBLOa6YQVcv5f94mYYFrPtc7tnNHTm01Apz
	4oWkHx/7rww4jRJQ9qx5H9866HzIlQkb5dCa6xKa8YVt+zzm2SSJ4PvhXzwRSI0=
X-Google-Smtp-Source: AGHT+IEYFX92VNOjaDyTPtVzoKjgTignMDmATbzLU58gE3Rp3juOGPJp3aMNII1N8lMWT1L0ct/c9w==
X-Received: by 2002:a05:6000:1862:b0:374:cc4b:596e with SMTP id ffacd0b85a97d-378d6235e10mr10332104f8f.37.1726470206941;
        Mon, 16 Sep 2024 00:03:26 -0700 (PDT)
Received: from ?IPV6:2003:e5:8741:4a00:60e5:7bee:fc48:e85c? (p200300e587414a0060e57beefc48e85c.dip0.t-ipconnect.de. [2003:e5:8741:4a00:60e5:7bee:fc48:e85c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612dfa54sm271177366b.161.2024.09.16.00.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 00:03:26 -0700 (PDT)
Message-ID: <8ef4ee94-5220-44a3-8095-30c3818ab46e@suse.com>
Date: Mon, 16 Sep 2024 09:03:26 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] xen/swiotlb: add alignment check for dma buffers
To: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-2-jgross@suse.com>
 <d23c9af4-4a79-4300-891a-fba3ea9cbb1c@suse.com>
 <c2dd89b4-46c7-4a0a-a47b-70862294176b@suse.com>
 <8866f8a6-e42c-47d2-af6f-c4bdda5a358f@suse.com>
 <c3a52494-7ced-42ec-8839-11bd18a7c3d9@suse.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <c3a52494-7ced-42ec-8839-11bd18a7c3d9@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Wi5Vfa8TT2UldISqlXfI80Rl"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Wi5Vfa8TT2UldISqlXfI80Rl
Content-Type: multipart/mixed; boundary="------------DRgD6x32XKw4TS4zHCqPY0Zo";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Message-ID: <8ef4ee94-5220-44a3-8095-30c3818ab46e@suse.com>
Subject: Re: [PATCH v2 1/2] xen/swiotlb: add alignment check for dma buffers
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-2-jgross@suse.com>
 <d23c9af4-4a79-4300-891a-fba3ea9cbb1c@suse.com>
 <c2dd89b4-46c7-4a0a-a47b-70862294176b@suse.com>
 <8866f8a6-e42c-47d2-af6f-c4bdda5a358f@suse.com>
 <c3a52494-7ced-42ec-8839-11bd18a7c3d9@suse.com>
In-Reply-To: <c3a52494-7ced-42ec-8839-11bd18a7c3d9@suse.com>
Autocrypt-Gossip: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJ3BBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AAIQkQoDSui/t3IH4WIQQ+pJkfkcoLMCa4X6CgNK6L+3cgfgn7AJ9DmMd0SMJE
 ePbc7/m22D2v04iu7ACffXTdZQhNl557tJuDXZSBxDmW/tLOwU0EWTecRBAIAIK5OMKMU5R2
 Lk2bbjgX7vyQuCFFyKf9rC/4itNwhYWFSlKzVj3WJBDsoi2KvPm7AI+XB6NIkNAkshL5C0kd
 pcNd5Xo0jRR5/WE/bT7LyrJ0OJWS/qUit5eNNvsO+SxGAk28KRa1ieVLeZi9D03NL0+HIAtZ
 tecfqwgl3Y72UpLUyt+r7LQhcI/XR5IUUaD4C/chB4Vq2QkDKO7Q8+2HJOrFIjiVli4lU+Sf
 OBp64m//Y1xys++Z4ODoKh7tkh5DxiO3QBHG7bHK0CSQsJ6XUvPVYubAuy1XfSDzSeSBl//C
 v78Fclb+gi9GWidSTG/4hsEzd1fY5XwCZG/XJJY9M/sAAwUH/09Ar9W2U1Qm+DwZeP2ii3Ou
 14Z9VlVVPhcEmR/AFykL9dw/OV2O/7cdi52+l00reUu6Nd4Dl8s4f5n8b1YFzmkVVIyhwjvU
 jxtPyUgDOt6DRa+RaDlXZZmxQyWcMv2anAgYWGVszeB8Myzsw8y7xhBEVV1S+1KloCzw4V8Z
 DSJrcsZlyMDoiTb7FyqxwQnM0f6qHxWbmOOnbzJmBqpNpFuDcz/4xNsymJylm6oXiucHQBAP
 Xb/cE1YNHpuaH4SRhIxwQilCYEznWowQphNAbJtEKOmcocY7EbSt8VjXTzmYENkIfkrHRyXQ
 dUm5AoL51XZljkCqNwrADGkTvkwsWSvCSQQYEQIACQUCWTecRAIbDAAKCRCgNK6L+3cgfuef
 AJ9wlZQNQUp0KwEf8Tl37RmcxCL4bQCcC5alCSMzUBJ5DBIcR4BY+CyQFAs=

--------------DRgD6x32XKw4TS4zHCqPY0Zo
Content-Type: multipart/mixed; boundary="------------BbymtZKzbkZPxp57F9RCO3oZ"

--------------BbymtZKzbkZPxp57F9RCO3oZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDkuMjQgMDk6MDEsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxNi4wOS4yMDI0
IDA4OjU5LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gT24gMTYuMDkuMjQgMDg6NTYsIEp1
ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4gT24gMTYuMDkuMjQgMDg6NTAsIEphbiBCZXVsaWNo
IHdyb3RlOg0KPj4+PiBPbiAxNi4wOS4yMDI0IDA4OjQ3LCBKdWVyZ2VuIEdyb3NzIHdyb3Rl
Og0KPj4+Pj4gLS0tIGEvZHJpdmVycy94ZW4vc3dpb3RsYi14ZW4uYw0KPj4+Pj4gKysrIGIv
ZHJpdmVycy94ZW4vc3dpb3RsYi14ZW4uYw0KPj4+Pj4gQEAgLTc4LDkgKzc4LDE1IEBAIHN0
YXRpYyBpbmxpbmUgaW50DQo+Pj4+PiByYW5nZV9zdHJhZGRsZXNfcGFnZV9ib3VuZGFyeShw
aHlzX2FkZHJfdCBwLCBzaXplX3Qgc2l6ZSkNCj4+Pj4+ICDCoCB7DQo+Pj4+PiAgwqDCoMKg
wqDCoCB1bnNpZ25lZCBsb25nIG5leHRfYmZuLCB4ZW5fcGZuID0gWEVOX1BGTl9ET1dOKHAp
Ow0KPj4+Pj4gIMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGksIG5yX3BhZ2VzID0gWEVOX1BG
Tl9VUCh4ZW5fb2Zmc2V0X2luX3BhZ2UocCkgKyBzaXplKTsNCj4+Pj4+ICvCoMKgwqAgcGh5
c19hZGRyX3QgYWxnbiA9IDFVTEwgPDwgKGdldF9vcmRlcihzaXplKSArIFBBR0VfU0hJRlQp
Ow0KPj4+Pj4gIMKgwqDCoMKgwqAgbmV4dF9iZm4gPSBwZm5fdG9fYmZuKHhlbl9wZm4pOw0K
Pj4+Pj4gK8KgwqDCoCAvKiBJZiBidWZmZXIgaXMgcGh5c2ljYWxseSBhbGlnbmVkLCBlbnN1
cmUgRE1BIGFsaWdubWVudC4gKi8NCj4+Pj4+ICvCoMKgwqAgaWYgKElTX0FMSUdORUQocCwg
YWxnbikgJiYNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAhSVNfQUxJR05FRChuZXh0X2JmbiA8
PCBYRU5fUEFHRV9TSElGVCwgYWxnbikpDQo+Pj4+DQo+Pj4+IEFuZCB0aGlzIHNoaWZ0IGlz
IG5vdCBhdCByaXNrIG9mIGxvc2luZyBiaXRzIG9uIEFybSBMUEFFPw0KPj4+DQo+Pj4gRm9y
IGFsaWdubWVudCBjaGVjayB0aGlzIGp1c3QgZG9lc24ndCBtYXR0ZXIgKGFzc3VtaW5nIFhF
Tl9QQUdFX1NJWkUgaXMNCj4+PiBzbWFsbGVyIHRoYW4gNEcpLg0KPj4NCj4+IFdhaXQsIHRo
YXQgd2FzIG5vbnNlbnNlLg0KPiANCj4gSSB0aGluayBpdCB3YXMgcXVpdGUgcmVhc29uYWJs
ZSwgYXMgbG9uZyBhcyBhbHNvIGFsZ24gKGFuZCBoZW5jZSBzaXplKQ0KPiBpc24ndCBhYnN1
cmRseSBsYXJnZS4NCg0KQmV0dGVyIHNhZmUgdGhhbiBzb3JyeS4NCg0KDQpKdWVyZ2VuDQoN
Cg==
--------------BbymtZKzbkZPxp57F9RCO3oZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------BbymtZKzbkZPxp57F9RCO3oZ--

--------------DRgD6x32XKw4TS4zHCqPY0Zo--

--------------Wi5Vfa8TT2UldISqlXfI80Rl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmbn2D4FAwAAAAAACgkQsN6d1ii/Ey9m
YAf+MNV3mm/QuYfn9wb9KKkCcNwEeRtXpRftH6QGHp3/rQ7DhzdLV+fNJ9myd0HbeC/Hzb3OGDTS
+/wOqYqtEoCDdyqV+lNT+uWePFns7kfq6TgEZW/1zytVgjbsgAXiGjU+ro6KmVe/vWGJfTDRBuvi
Z95M8PMnyhdf6XjtPPVmU3jHpZB+fdVAW4HmyJjaKY/jrTWXWEQqz1JvJa52akCWEYL7N8USDQaU
Cna9DWizU1tnL6In/PpPpOeogD3E2vf/c4QqLj7c+J880Sr+uyzrITkkh0LnJun7zRcHPVJn/Xov
J2+0nLlmSCz/juWenlPdPmAqo2OOyI380pqcdJ/reA==
=MdBe
-----END PGP SIGNATURE-----

--------------Wi5Vfa8TT2UldISqlXfI80Rl--
