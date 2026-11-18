Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004903;
	b=c2QuHG4gPtqjvcXPvPv3n4vumaD0PAWzKpv/tVb+5xaY9qsU9OVKLp8c7tT/+P168mh3
	 Xn8zDO8F2ZZNlqdWmmCNc1EHwtzwdCIm3MCA2foJ89iIRHspXPPAhHeVg6hOL2HtE0T8F
	 cw7oV/PjzCwQ6No7EfBdl3uwWO8p5IIzkEd3G7a6BdS08PKj9sw6rwN7RDom4yQR/hatc
	 F8XC4o3clD0SN1gOB1hyi3Eg8NAMrjZX6YTQrGx7ZhcqzxmjZgTWPutQzfz+TArzXBlvj
	 IxaFaBCwIcMa990I6UB2PYzEpOZchIf4lZ/8RvV7poihzrLABleNPmWdr3jd3Z7Nh+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qZqAnvrKTsVRZ3k+qpJ8SHuObdEj1UWG4cr1fECpUNs=;
	b=0tm9fGNdM8mKFkY1BaCG93sV8aKUF/saRgqKm/OsK7FR2X8Az0hc8rIA8Ajs1cr8k/r5
	 PWoHlUcHZhuxMNdxHe8psERear5jy8sZd0VCcIMss75o6lkilVEbFSIKZJ2AevlebPwow
	 8NsJt2A3BGvdwpY2UFjR4uIYt6VpVpMUUeesb/vCxMSIbRCZ1oUWMejx3m/H6prsLtEg7
	 C/HCP1TztNCwyQsd8jswr9BG93izK+WpDmV2rAn0RQkLwQ3TyQNiHeIQFHRdH9v6NaaEh
	 S0+X+UhozJbvdyB+EcohmtVc5hQNvpAam/qzPJ7pRnwZE5AXCfZ3htYd+jU8FB0tRQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PgUz900M;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F8606A331
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 12:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 402F8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PgUz900M
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so9362175e9.1
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 04:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795004902; x=1795609702; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qZqAnvrKTsVRZ3k+qpJ8SHuObdEj1UWG4cr1fECpUNs=;
        b=PgUz900MpEDd1jSkMKiMxDDLFYrtq4iqhcb0UWshPCM7pH9l00JxAZJMvDDB4rhxlO
         5nKhsLnUGBPu+NQzDq00T5crLmF6nhT4DUfI3Lsdo7QbiEhkfvEO9NwiigGApgaCABKQ
         IgFy4s3WHtBEgw6kqApQAS6ZHpYUBa686TNIzImqKM7sy3h69XmECtYIMgAzUsnFUKkB
         IZOrr4UsNj4ALRy8egrGxYTVDviGUMdkP8eUs8tKuI10xqd+PGWIbQfjPv8dhlwGaeq1
         UGpFVyhBVKpYIcDUrfDaYl/57nigbiB8X76gkFME1yBKLZXFkvLLLOQGCm8DqxOn4Vai
         7vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795004902; x=1795609702;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZqAnvrKTsVRZ3k+qpJ8SHuObdEj1UWG4cr1fECpUNs=;
        b=KfdsdX0JWMqfNicg5VDz5wSeoRJh1sCiPwlaifi21JYvDnCZfn3694MwQMYPgQCmba
         eKL3mh/Z9h6om7JmOCDCb58TtQkcAfs6I8pEW+XxL42Js0ZKqRaWqSZrO9uQwJqeHiTT
         R9zaJX5H12/HsGfxgHD0ZgJktNXq25SDmMB2M2wH8pLop1+Vk5IIMD2tITBwtdJV8oGF
         3hPG2dj1uXNI4M90lAafBUE5VndiJwciV3n2juFYmc29w9XWQgQAIg/cw4lZEyNYT63H
         3Swe4a1DopDA9VD709tFpFTo6+YEKGJeo8UQ2es9ru3BBdJceO64w2v8Tg8UluSIgEGh
         MgBA==
X-Forwarded-Encrypted: i=1; AL+hErFwkBISauCDP78Z90RhrsYIE0zKbolq9eUCNN9FPhv2WsNQflMYprO1H3JTZnVutG2UXxwuew==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Q3cx+/E0E2zXZjCPpbtcBT6Ubpx3wYullrucLWdCQEb3RaRDL
	PlMs340cvD5f1U+BWOx8DwnEfdWPpNtkVjpHX6jAD4TidLEIRrdgTTegLgGSX52KhtU=
X-Gm-Gg: AYBFou2KEmpbfGhVbS1ZVawC1XQSlTap015AqmguBKEbbiHPG3KA9AIvJhpOo9Ys0IN
	UBNboNezNEdcKX2xFe6+nq+z7nxel01BUyX7yBZYLa4zFOwnBj1/OWLX2HKqhL0maw8kkn7uGll
	jEDb3YHHxgnC6v5o0pUashTd0LditgiHuhenVfsimCnlMQFmWI4opyT/dr6dEPgag9s2CI2bMjW
	8DKjjfqek3fRW8ZQjyAe+EAehNdUmXzsRLilAiBBa68yfsXcPj9LFFTg4R84jZFDMvB6UuG8e6a
	/fnHJZV279FHyOv2085mUE5Sv0sPiMkpSHzuGk58HCxASlw8stFrgDhOFNL6Pvuq7CsBValRPla
	Owvu++7MASEdLbhyVQguDSK7dDP8djzP3yjzfXLPCQnaLyMTDjF7Z2m6Dbv7a/8FB0THAsD/G4g
	mTFhoO8h4cyWzoASfe6XuoByAWGVPjE8btY3npUNyPPixLVHFAFzE5xM+zZxbJMxFoV/TASukp/
	BVu1aKGDB2ORW9tRJumXQ2gjARAkBOo+1thjn8S9quj65pV7yP4HNlwGgSD3JndNAGzAOkgoh49
	Qe9w92Os0NmIQYyvaFr7Q/IHD9AVJNhEa4ZFcddViulQFa+hp2u7Iqr/hUDrDPaFQiTLIo2Sx2Y
	trg==
X-Received: by 2002:a05:600c:34d2:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb7d6d1f21mr46698525e9.1.1795004901817;
        Wed, 18 Nov 2026 04:28:21 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2abfc4sm64858355e9.7.2026.11.18.04.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 04:28:21 -0800 (PST)
Message-ID: <49a9337f-6808-4f30-b826-9a280849a51c@baylibre.com>
Date: Wed, 18 Nov 2026 12:28:19 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Drake <ddrake@baylibre.com>
Subject: Re: [PATCH v17 11/12] arm64: dts: rockchip: add NPU (RKNN) nodes to
 rk3576
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <f9f4f43cd1c4c8c6cee0371b4b92badf37e68832.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <f9f4f43cd1c4c8c6cee0371b4b92badf37e68832.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14/11/2026 03:05, Jiaxing Hu wrote:
> Each core is on its own power domain only: core 0 on PD_NPU0, core 1 on
> PD_NPU1. Measured with both cores running, the results are correct, and
> the nputop and npu domains above them are powered through the domain
> hierarchy.

No need to include lab notes; we assume you tested this work and found
it to be working before submission.

> Label PD_NPU so a board can connect the NPU supply. The IOMMUs use four
> clocks.
> 
> Also set CLK_RKNN_DSU0 to 594 MHz. Mainline sets neither its rate nor the
> NPU voltage. On the ROCK 4D the DSU runs at 786 MHz by default and the
> rail boots at 750 mV; with both cores running, each pass of the 5400-row
> test has 11 to 25 wrong words. At 594 MHz the test is all correct. In the
> vendor OPP table, the 500 MHz and 600 MHz steps both need 725 mV.

I found this wording a bit confusing. I think you're saying, the system
boots into Linux with 786MHz & 750mV, and that configuration gives bad
results.

I'm not clear why you picked 594 Hz then. What does the vendor kernel
do, are you matching that behaviour?

